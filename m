Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751959AbeCICGn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 21:06:43 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:45764 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751679AbeCICGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 21:06:23 -0500
Subject: Re: [PATCH V4 3/5] nvme-pci: avoid nvme_dev_disable to be invoked in
 nvme_timeout
To: keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <1520489971-31174-1-git-send-email-jianchao.w.wang@oracle.com>
 <1520489971-31174-4-git-send-email-jianchao.w.wang@oracle.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <5e60e6bc-d0cc-9ea9-1a35-ed5031904da6@oracle.com>
Date: Fri, 9 Mar 2018 10:01:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520489971-31174-4-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8826 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803090024
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith

Can I have the honor of getting your comment on this patch?

Thanks in advance
Jianchao

On 03/08/2018 02:19 PM, Jianchao Wang wrote:
> nvme_dev_disable will issue command on adminq to clear HMB and
> delete io cq/sqs, maybe more in the future. When adminq no response,
> it has to depends on timeout path. However, nvme_timeout has to
> invoke nvme_dev_disable before return, so that the DMA mappings
> could be released safely. This will introduce dangerous circular
> dependence. Moreover, the whole nvme_dev_disable is under
> shutdown_lock even waiting for the command, this makes things
> worse.
> 
> To avoid this, this patch refactors the nvme_timeout. The basic
> principle is:
>  - When need to schedule reset_work, hand over expired requests
>    to nvme_dev_disable. They will be completed after the controller
>    is disabled/shtudown.
>  - When requests from nvme_dev_disable and nvme_reset_work expires,
>    disable the controller directly then the request could be completed
>    to wakeup the waiter. nvme_pci_disable_ctrl_directly is introduced
>    for this, it doesn't send commands on adminq and the shutdown_lock
>    is not needed here, because the nvme_abort_requests_sync in
>    nvme_dev_disable could synchronize with nvme_timeout.
> 
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
>  drivers/nvme/host/pci.c | 199 ++++++++++++++++++++++++++++++++----------------
>  1 file changed, 134 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index e186158..ce09057 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -70,6 +70,7 @@ struct nvme_queue;
>  
>  static void nvme_process_cq(struct nvme_queue *nvmeq);
>  static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
> +static void nvme_pci_disable_ctrl_directly(struct nvme_dev *dev);
>  
>  /*
>   * Represents an NVM Express device.  Each nvme_dev is a PCI function.
> @@ -98,6 +99,7 @@ struct nvme_dev {
>  	u32 cmbloc;
>  	struct nvme_ctrl ctrl;
>  	struct completion ioq_wait;
> +	bool inflight_flushed;
>  
>  	/* shadow doorbell buffer support: */
>  	u32 *dbbuf_dbs;
> @@ -1180,73 +1182,13 @@ static void nvme_warn_reset(struct nvme_dev *dev, u32 csts)
>  			 csts, result);
>  }
>  
> -static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
> +static enum blk_eh_timer_return nvme_pci_abort_io_req(struct request *req)
>  {
>  	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>  	struct nvme_queue *nvmeq = iod->nvmeq;
>  	struct nvme_dev *dev = nvmeq->dev;
> -	struct request *abort_req;
>  	struct nvme_command cmd;
> -	u32 csts = readl(dev->bar + NVME_REG_CSTS);
> -
> -	/*
> -	 * Reset immediately if the controller is failed
> -	 */
> -	if (nvme_should_reset(dev, csts)) {
> -		nvme_warn_reset(dev, csts);
> -		nvme_dev_disable(dev, false);
> -		nvme_reset_ctrl(&dev->ctrl);
> -		return BLK_EH_HANDLED;
> -	}
> -
> -	/*
> -	 * Did we miss an interrupt?
> -	 */
> -	if (__nvme_poll(nvmeq, req->tag)) {
> -		dev_warn(dev->ctrl.device,
> -			 "I/O %d QID %d timeout, completion polled\n",
> -			 req->tag, nvmeq->qid);
> -		return BLK_EH_HANDLED;
> -	}
> -
> -	/*
> -	 * Shutdown immediately if controller times out while starting. The
> -	 * reset work will see the pci device disabled when it gets the forced
> -	 * cancellation error. All outstanding requests are completed on
> -	 * shutdown, so we return BLK_EH_HANDLED.
> -	 */
> -	switch (dev->ctrl.state) {
> -	case NVME_CTRL_CONNECTING:
> -	case NVME_CTRL_RESETTING:
> -		dev_warn(dev->ctrl.device,
> -			 "I/O %d QID %d timeout, disable controller\n",
> -			 req->tag, nvmeq->qid);
> -		nvme_dev_disable(dev, false);
> -		set_bit(NVME_REQ_CANCELLED, &nvme_req(req)->flags);
> -		return BLK_EH_HANDLED;
> -	default:
> -		break;
> -	}
> -
> -	/*
> - 	 * Shutdown the controller immediately and schedule a reset if the
> - 	 * command was already aborted once before and still hasn't been
> - 	 * returned to the driver, or if this is the admin queue.
> -	 */
> -	if (!nvmeq->qid || iod->aborted) {
> -		dev_warn(dev->ctrl.device,
> -			 "I/O %d QID %d timeout, reset controller\n",
> -			 req->tag, nvmeq->qid);
> -		nvme_dev_disable(dev, false);
> -		nvme_reset_ctrl(&dev->ctrl);
> -
> -		/*
> -		 * Mark the request as handled, since the inline shutdown
> -		 * forces all outstanding requests to complete.
> -		 */
> -		set_bit(NVME_REQ_CANCELLED, &nvme_req(req)->flags);
> -		return BLK_EH_HANDLED;
> -	}
> +	struct request *abort_req;
>  
>  	if (atomic_dec_return(&dev->ctrl.abort_limit) < 0) {
>  		atomic_inc(&dev->ctrl.abort_limit);
> @@ -1282,6 +1224,105 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>  	return BLK_EH_RESET_TIMER;
>  }
>  
> +static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
> +{
> +	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> +	struct nvme_queue *nvmeq = iod->nvmeq;
> +	struct nvme_dev *dev = nvmeq->dev;
> +	u32 csts = readl(dev->bar + NVME_REG_CSTS);
> +	enum {ABORT, RESET, DISABLE} action;
> +	enum blk_eh_timer_return ret;
> +	/*
> +	 * This is for nvme_abort_req. This request will be completed
> +	 * by nvme_flush_aborted_requests after the controller is
> +	 * disabled/shutdown
> +	 */
> +	if (test_bit(NVME_REQ_ABORTED, &nvme_req(req)->flags))
> +		return BLK_EH_NOT_HANDLED;
> +
> +	/*
> +	 * Reset immediately if the controller is failed.
> +	 * Defer the completion to nvme_flush_aborted_requests.
> +	 */
> +	if (nvme_should_reset(dev, csts)) {
> +		nvme_warn_reset(dev, csts);
> +		nvme_reset_ctrl(&dev->ctrl);
> +		return BLK_EH_RESET_TIMER;
> +	}
> +
> +	/*
> +	 * Did we miss an interrupt?
> +	 */
> +	if (__nvme_poll(nvmeq, req->tag)) {
> +		dev_warn(dev->ctrl.device,
> +			 "I/O %d QID %d timeout, completion polled\n",
> +			 req->tag, nvmeq->qid);
> +		return BLK_EH_HANDLED;
> +	}
> +
> +	if (nvmeq->qid) {
> +		if (dev->ctrl.state == NVME_CTRL_RESETTING ||
> +				iod->aborted)
> +			action = RESET;
> +		else
> +			action = ABORT;
> +	} else {
> +		/*
> +		 * Disable immediately if controller times out while disabling/
> +		 * shuting down/starting. The nvme_dev_disable/nvme_reset_work
> +		 * will see the error.
> +		 * Note: inflight_flushed is set in nvme_dev_disable when it
> +		 * abort all the inflight requests. Introducing this flag is due
> +		 * to there is no state to represent the shutdown procedure.
> +		 */
> +		if (dev->ctrl.state == NVME_CTRL_CONNECTING ||
> +			dev->inflight_flushed)
> +			action = DISABLE;
> +		else
> +			action = RESET;
> +	}
> +
> +	switch (action) {
> +	case ABORT:
> +		ret = nvme_pci_abort_io_req(req);
> +		break;
> +	case RESET:
> +		dev_warn(dev->ctrl.device,
> +			 "I/O %d QID %d timeout, reset controller\n",
> +			 req->tag, nvmeq->qid);
> +		set_bit(NVME_REQ_CANCELLED, &nvme_req(req)->flags);
> +		nvme_reset_ctrl(&dev->ctrl);
> +		/*
> +		 * The reset work will take over this request. nvme_abort_req
> +		 * employs blk_abort_request to force the request to be timed
> +		 * out. So we need to return BLK_EH_RESET_TIMER then the
> +		 * RQF_MQ_TIMEOUT_EXPIRED could be cleared.
> +		 */
> +		ret = BLK_EH_RESET_TIMER;
> +		break;
> +	case DISABLE:
> +		/*
> +		 * We disable the controller directly here so that we could
> +		 * complete the request safely to wake up the nvme_dev_disable/
> +		 * nvme_reset_work who is waiting on adminq. We cannot return
> +		 * BLK_EH_RESET_TIMER to depend on error recovery procedure
> +		 * because it is waiting for timeout path.
> +		 */
> +		dev_warn(dev->ctrl.device,
> +			 "I/O %d QID %d timeout, disable controller\n",
> +			 req->tag, nvmeq->qid);
> +		nvme_pci_disable_ctrl_directly(dev);
> +		set_bit(NVME_REQ_CANCELLED, &nvme_req(req)->flags);
> +		ret = BLK_EH_HANDLED;
> +		break;
> +	default:
> +		WARN_ON(1);
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
>  static void nvme_free_queue(struct nvme_queue *nvmeq)
>  {
>  	dma_free_coherent(nvmeq->q_dmadev, CQ_SIZE(nvmeq->q_depth),
> @@ -2169,6 +2210,33 @@ static void nvme_pci_disable(struct nvme_dev *dev)
>  	}
>  }
>  
> +/*
> + * This is only invoked by nvme_timeout. shutdown_lock is not needed
> + * here because nvme_abort_requests_sync in nvme_dev_disable will
> + * synchronize with the timeout path.
> + */
> +static void nvme_pci_disable_ctrl_directly(struct nvme_dev *dev)
> +{
> +	int i;
> +	struct pci_dev *pdev = to_pci_dev(dev->dev);
> +	bool dead = true;
> +
> +	if (pci_is_enabled(pdev)) {
> +		u32 csts = readl(dev->bar + NVME_REG_CSTS);
> +
> +		dead = !!((csts & NVME_CSTS_CFS) || !(csts & NVME_CSTS_RDY) ||
> +			pdev->error_state  != pci_channel_io_normal);
> +
> +		if (!dead)
> +			nvme_disable_ctrl(&dev->ctrl, dev->ctrl.cap);
> +	}
> +
> +	for (i = dev->ctrl.queue_count - 1; i >= 0; i--)
> +		nvme_suspend_queue(&dev->queues[i]);
> +
> +	nvme_pci_disable(dev);
> +}
> +
>  static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>  {
>  	int i;
> @@ -2205,6 +2273,8 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>  
>  	}
>  	nvme_stop_queues(&dev->ctrl);
> +	nvme_abort_requests_sync(&dev->ctrl);
> +	dev->inflight_flushed = true;
>  
>  	if (!dead) {
>  		nvme_disable_io_queues(dev);
> @@ -2215,9 +2285,8 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>  
>  	nvme_pci_disable(dev);
>  
> -	blk_mq_tagset_busy_iter(&dev->tagset, nvme_cancel_request, &dev->ctrl);
> -	blk_mq_tagset_busy_iter(&dev->admin_tagset, nvme_cancel_request, &dev->ctrl);
> -
> +	nvme_flush_aborted_requests(&dev->ctrl);
> +	dev->inflight_flushed = false;
>  	/*
>  	 * The driver will not be starting up queues again if shutting down so
>  	 * must flush all entered requests to their failed completion to avoid
> 

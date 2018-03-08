Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754545AbeCHSVy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 13:21:54 -0500
Received: from mail-io0-f176.google.com ([209.85.223.176]:40660 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752155AbeCHSVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 13:21:50 -0500
X-Google-Smtp-Source: AG47ELtav8idfjQm2w0iNkTLNXK3PP/R4BYMHpz0PRf6yk9Q7D9Np7jrQpZLIQdpZDebPaXhEFN0KQ==
Subject: Re: [PATCH V4 2/5] nvme: add helper interface to flush in-flight
 requests
To: Jianchao Wang <jianchao.w.wang@oracle.com>, keith.busch@intel.com,
        axboe@fb.com, hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1520489971-31174-1-git-send-email-jianchao.w.wang@oracle.com>
 <1520489971-31174-3-git-send-email-jianchao.w.wang@oracle.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <931a03f8-9c8b-fec4-0f89-04321a906710@grimberg.me>
Date: Thu, 8 Mar 2018 20:21:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520489971-31174-3-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/08/2018 08:19 AM, Jianchao Wang wrote:
> Currently, we use nvme_cancel_request to complete the request
> forcedly. This has following defects:
>   - It is not safe to race with the normal completion path.
>     blk_mq_complete_request is ok to race with timeout path,
>     but not with itself.
>   - Cannot ensure all the requests have been handled. The timeout
>     path may grab some expired requests, blk_mq_complete_request
>     cannot touch them.
> 
> add two helper interface to flush in-flight requests more safely.
> - nvme_abort_requests_sync
> use nvme_abort_req to timeout all the in-flight requests and wait
> until timeout work and irq completion path completes. More details
> please refer to the comment of this interface.
> - nvme_flush_aborted_requests
> complete the requests 'aborted' by nvme_abort_requests_sync. It will
> be invoked after the controller is disabled/shutdown.
> 
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
>   drivers/nvme/host/core.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/nvme/host/nvme.h |  4 +-
>   2 files changed, 99 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 7b8df47..e26759b 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3567,6 +3567,102 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
>   }
>   EXPORT_SYMBOL_GPL(nvme_start_queues);
>   
> +static void nvme_abort_req(struct request *req, void *data, bool reserved)
> +{
> +	if (!blk_mq_request_started(req))
> +		return;
> +
> +	dev_dbg_ratelimited(((struct nvme_ctrl *) data)->device,
> +				"Abort I/O %d", req->tag);
> +
> +	/* The timeout path need identify this flag and return
> +	 * BLK_EH_NOT_HANDLED, then the request will not be completed.
> +	 * we will defer the completion after the controller is disabled or
> +	 * shutdown.
> +	 */
> +	set_bit(NVME_REQ_ABORTED, &nvme_req(req)->flags);
> +	blk_abort_request(req);
> +}
> +
> +/*
> + * This function will ensure all the in-flight requests on the
> + * controller to be handled by timeout path or irq completion path.
> + * It has to pair with nvme_flush_aborted_requests which will be
> + * invoked after the controller has been disabled/shutdown and
> + * complete the requests 'aborted' by nvme_abort_req.
> + *
> + * Note, the driver layer will not be quiescent before disable
> + * controller, because the requests aborted by blk_abort_request
> + * are still active and the irq will fire at any time, but it can
> + * not enter into completion path, because the request has been
> + * timed out.
> + */
> +void nvme_abort_requests_sync(struct nvme_ctrl *ctrl)
> +{
> +	struct nvme_ns *ns;
> +
> +	blk_mq_tagset_busy_iter(ctrl->tagset, nvme_abort_req, ctrl);
> +	blk_mq_tagset_busy_iter(ctrl->admin_tagset, nvme_abort_req, ctrl);
> +	/*
> +	 * ensure the timeout_work is queued, thus needn't to sync
> +	 * the timer
> +	 */
> +	kblockd_schedule_work(&ctrl->admin_q->timeout_work);
> +
> +	down_read(&ctrl->namespaces_rwsem);
> +
> +	list_for_each_entry(ns, &ctrl->namespaces, list)
> +		kblockd_schedule_work(&ns->queue->timeout_work);
> +
> +	list_for_each_entry(ns, &ctrl->namespaces, list)
> +		flush_work(&ns->queue->timeout_work);
> +
> +	up_read(&ctrl->namespaces_rwsem);
> +	/* This will ensure all the nvme irq completion path have exited */
> +	synchronize_sched();
> +}
> +EXPORT_SYMBOL_GPL(nvme_abort_requests_sync);
> +
> +static void nvme_comp_req(struct request *req, void *data, bool reserved)

Not a very good name...

> +{
> +	struct nvme_ctrl *ctrl = (struct nvme_ctrl *)data;
> +
> +	if (!test_bit(NVME_REQ_ABORTED, &nvme_req(req)->flags))
> +		return;
> +
> +	WARN_ON(!blk_mq_request_started(req));
> +
> +	if (ctrl->tagset && ctrl->tagset->ops->complete) {

What happens when this called on the admin tagset when the controller
does not have an io tagset?

> +		clear_bit(NVME_REQ_ABORTED, &nvme_req(req)->flags);
> +		/*
> +		 * We set the status to NVME_SC_ABORT_REQ, then ioq request
> +		 * will be requeued and adminq one will be failed.
> +		 */
> +		nvme_req(req)->status = NVME_SC_ABORT_REQ;
> +		/*
> +		 * For ioq request, blk_mq_requeue_request should be better
> +		 * here. But the nvme code will still setup the cmd even if
> +		 * the RQF_DONTPREP is set. We have to use .complete to free
> +		 * the cmd and then requeue it.

IMO, its better to fix nvme to not setup the command if RQF_DONTPREP is 
on (other than the things it must setup).

> +		 *
> +		 * For adminq request, invoking .complete directly will miss
> +		 * blk_mq_sched_completed_request, but this is ok because we
> +		 * won't have io scheduler for adminq.
> +		 */
> +		ctrl->tagset->ops->complete(req);

I don't think that directly calling .complete is a good idea...

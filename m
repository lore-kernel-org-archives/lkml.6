Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3F9C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41F7D20652
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F7D20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbeIFCli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:41:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56246 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727657AbeIFCli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:41:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3957F804B4B9;
        Wed,  5 Sep 2018 22:09:25 +0000 (UTC)
Received: from ming.t460p (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D6A082166BA1;
        Wed,  5 Sep 2018 22:09:16 +0000 (UTC)
Date:   Thu, 6 Sep 2018 06:09:11 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     axboe@kernel.dk, bart.vanassche@wdc.com, sagi@grimberg.me,
        keith.busch@intel.com, jthumshirn@suse.de, jsmart2021@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/3] nvme-pci: use queue close instead of queue freeze
Message-ID: <20180905220910.GC21352@ming.t460p>
References: <1536120586-3378-1-git-send-email-jianchao.w.wang@oracle.com>
 <1536120586-3378-4-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536120586-3378-4-git-send-email-jianchao.w.wang@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 05 Sep 2018 22:09:25 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 05 Sep 2018 22:09:25 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ming.lei@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 12:09:46PM +0800, Jianchao Wang wrote:
> nvme_dev_disable freezes queues to prevent new IO. nvme_reset_work
> will unfreeze and wait to drain the queues. However, if IO timeout
> at the moment, no body could do recovery as nvme_reset_work is
> waiting. We will encounter IO hang.
> 
> To avoid this scenario, use queue close to prevent new IO which
> doesn't need to drain the queues. And just use queue freeze to
> try to wait for in-flight IO for shutdown case.
> 
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
>  drivers/nvme/host/core.c | 22 ++++++++++++++++++++++
>  drivers/nvme/host/nvme.h |  3 +++
>  drivers/nvme/host/pci.c  | 27 ++++++++++++++-------------
>  3 files changed, 39 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index dd8ec1d..ce5b35b 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3602,6 +3602,28 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
>  }
>  EXPORT_SYMBOL_GPL(nvme_kill_queues);
>  
> +void nvme_close_queues(struct nvme_ctrl *ctrl)
> +{
> +	struct nvme_ns *ns;
> +
> +	down_read(&ctrl->namespaces_rwsem);
> +	list_for_each_entry(ns, &ctrl->namespaces, list)
> +		blk_set_queue_closed(ns->queue);
> +	up_read(&ctrl->namespaces_rwsem);
> +}
> +EXPORT_SYMBOL_GPL(nvme_close_queues);
> +
> +void nvme_open_queues(struct nvme_ctrl *ctrl)
> +{
> +	struct nvme_ns *ns;
> +
> +	down_read(&ctrl->namespaces_rwsem);
> +	list_for_each_entry(ns, &ctrl->namespaces, list)
> +		blk_clear_queue_closed(ns->queue);
> +	up_read(&ctrl->namespaces_rwsem);
> +}
> +EXPORT_SYMBOL_GPL(nvme_open_queues);
> +
>  void nvme_unfreeze(struct nvme_ctrl *ctrl)
>  {
>  	struct nvme_ns *ns;
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index bb4a200..fcd44cb 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -437,6 +437,9 @@ void nvme_wait_freeze(struct nvme_ctrl *ctrl);
>  void nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout);
>  void nvme_start_freeze(struct nvme_ctrl *ctrl);
>  
> +void nvme_close_queues(struct nvme_ctrl *ctrl);
> +void nvme_open_queues(struct nvme_ctrl *ctrl);
> +
>  #define NVME_QID_ANY -1
>  struct request *nvme_alloc_request(struct request_queue *q,
>  		struct nvme_command *cmd, blk_mq_req_flags_t flags, int qid);
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index d668682..c0ccd04 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2145,23 +2145,25 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>  	struct pci_dev *pdev = to_pci_dev(dev->dev);
>  
>  	mutex_lock(&dev->shutdown_lock);
> +	nvme_close_queues(&dev->ctrl);
>  	if (pci_is_enabled(pdev)) {
>  		u32 csts = readl(dev->bar + NVME_REG_CSTS);
>  
> -		if (dev->ctrl.state == NVME_CTRL_LIVE ||
> -		    dev->ctrl.state == NVME_CTRL_RESETTING)
> -			nvme_start_freeze(&dev->ctrl);
>  		dead = !!((csts & NVME_CSTS_CFS) || !(csts & NVME_CSTS_RDY) ||
>  			pdev->error_state  != pci_channel_io_normal);
> -	}
>  
> -	/*
> -	 * Give the controller a chance to complete all entered requests if
> -	 * doing a safe shutdown.
> -	 */
> -	if (!dead) {
> -		if (shutdown)
> -			nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
> +		if (dev->ctrl.state == NVME_CTRL_LIVE ||
> +		    dev->ctrl.state == NVME_CTRL_RESETTING) {
> +			/*
> +			 * Give the controller a chance to complete all entered
> +			 * requests if doing a safe shutdown.
> +			 */
> +			if (!dead && shutdown) {
> +				nvme_start_freeze(&dev->ctrl);
> +				nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
> +				nvme_unfreeze(&dev->ctrl);
> +			}
> +		}
>  	}
>  
>  	nvme_stop_queues(&dev->ctrl);
> @@ -2328,11 +2330,9 @@ static void nvme_reset_work(struct work_struct *work)
>  		new_state = NVME_CTRL_ADMIN_ONLY;
>  	} else {
>  		nvme_start_queues(&dev->ctrl);
> -		nvme_wait_freeze(&dev->ctrl);
>  		/* hit this only when allocate tagset fails */
>  		if (nvme_dev_add(dev))
>  			new_state = NVME_CTRL_ADMIN_ONLY;
> -		nvme_unfreeze(&dev->ctrl);

nvme_dev_add() still may call freeze & unfreeze queue, so your patch
can't avoid draining queue completely here.

Thanks,
Ming

Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F9BC00449
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 02:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 545B7213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 02:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 545B7213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbeJIKEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 06:04:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60770 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbeJIKEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 06:04:31 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 09FE785550;
        Tue,  9 Oct 2018 02:49:50 +0000 (UTC)
Received: from ming.t460p (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ADAC11054FBA;
        Tue,  9 Oct 2018 02:49:43 +0000 (UTC)
Date:   Tue, 9 Oct 2018 10:49:38 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     axboe@kernel.dk, keith.busch@linux.intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] blk-mq: adjust debugfs and sysfs register when
 updating nr_hw_queues
Message-ID: <20181009024937.GA18673@ming.t460p>
References: <1538044984-2147-1-git-send-email-jianchao.w.wang@oracle.com>
 <1538044984-2147-2-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538044984-2147-2-git-send-email-jianchao.w.wang@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 09 Oct 2018 02:49:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 06:43:03PM +0800, Jianchao Wang wrote:
> blk-mq debugfs and sysfs entries need to be removed before updating
> queue map, otherwise, we get get wrong result there. This patch fixes
> it and remove the redundant debugfs and sysfs register/unregister
> operations during __blk_mq_update_nr_hw_queues.
> 
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
>  block/blk-mq.c | 39 ++++++++++++---------------------------
>  1 file changed, 12 insertions(+), 27 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 85a1c1a..6356455 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2137,8 +2137,6 @@ static void blk_mq_exit_hctx(struct request_queue *q,
>  		struct blk_mq_tag_set *set,
>  		struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
>  {
> -	blk_mq_debugfs_unregister_hctx(hctx);
> -
>  	if (blk_mq_hw_queue_mapped(hctx))
>  		blk_mq_tag_idle(hctx);
>  
> @@ -2165,6 +2163,7 @@ static void blk_mq_exit_hw_queues(struct request_queue *q,
>  	queue_for_each_hw_ctx(q, hctx, i) {
>  		if (i == nr_queue)
>  			break;
> +		blk_mq_debugfs_unregister_hctx(hctx);
>  		blk_mq_exit_hctx(q, set, hctx, i);
>  	}
>  }
> @@ -2222,8 +2221,6 @@ static int blk_mq_init_hctx(struct request_queue *q,
>  	if (hctx->flags & BLK_MQ_F_BLOCKING)
>  		init_srcu_struct(hctx->srcu);
>  
> -	blk_mq_debugfs_register_hctx(q, hctx);
> -
>  	return 0;
>  
>   free_fq:
> @@ -2512,8 +2509,6 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
>  	int i, j;
>  	struct blk_mq_hw_ctx **hctxs = q->queue_hw_ctx;
>  
> -	blk_mq_sysfs_unregister(q);
> -
>  	/* protect against switching io scheduler  */
>  	mutex_lock(&q->sysfs_lock);
>  	for (i = 0; i < set->nr_hw_queues; i++) {
> @@ -2561,7 +2556,6 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
>  	}
>  	q->nr_hw_queues = i;
>  	mutex_unlock(&q->sysfs_lock);
> -	blk_mq_sysfs_register(q);
>  }
>  
>  struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
> @@ -2659,25 +2653,6 @@ void blk_mq_free_queue(struct request_queue *q)
>  	blk_mq_exit_hw_queues(q, set, set->nr_hw_queues);
>  }
>  
> -/* Basically redo blk_mq_init_queue with queue frozen */
> -static void blk_mq_queue_reinit(struct request_queue *q)
> -{
> -	WARN_ON_ONCE(!atomic_read(&q->mq_freeze_depth));
> -
> -	blk_mq_debugfs_unregister_hctxs(q);
> -	blk_mq_sysfs_unregister(q);
> -
> -	/*
> -	 * redo blk_mq_init_cpu_queues and blk_mq_init_hw_queues. FIXME: maybe
> -	 * we should change hctx numa_node according to the new topology (this
> -	 * involves freeing and re-allocating memory, worth doing?)
> -	 */
> -	blk_mq_map_swqueue(q);
> -
> -	blk_mq_sysfs_register(q);
> -	blk_mq_debugfs_register_hctxs(q);
> -}
> -
>  static int __blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
>  {
>  	int i;
> @@ -2987,11 +2962,21 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>  		if (!blk_mq_elv_switch_none(&head, q))
>  			goto switch_back;
>  
> +	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> +		blk_mq_debugfs_unregister_hctxs(q);
> +		blk_mq_sysfs_unregister(q);
> +	}
> +
>  	set->nr_hw_queues = nr_hw_queues;
>  	blk_mq_update_queue_map(set);
>  	list_for_each_entry(q, &set->tag_list, tag_set_list) {
>  		blk_mq_realloc_hw_ctxs(set, q);
> -		blk_mq_queue_reinit(q);
> +		blk_mq_map_swqueue(q);
> +	}
> +
> +	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> +		blk_mq_sysfs_register(q);
> +		blk_mq_debugfs_register_hctxs(q);
>  	}
>  
>  switch_back:
> -- 
> 2.7.4
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

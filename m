Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D43FC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 02:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27CF0206B8
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 02:49:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27CF0206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbeI2JPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 05:15:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57168 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbeI2JPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 05:15:52 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 49EA9317C416;
        Sat, 29 Sep 2018 02:49:14 +0000 (UTC)
Received: from ming.t460p (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C2BE1600C1;
        Sat, 29 Sep 2018 02:49:08 +0000 (UTC)
Date:   Sat, 29 Sep 2018 10:49:03 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     axboe@kernel.dk, keith.busch@linux.intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] blk-mq: adjust debugfs and sysfs register when
 updating nr_hw_queues
Message-ID: <20180929024902.GA27170@ming.t460p>
References: <1538044984-2147-1-git-send-email-jianchao.w.wang@oracle.com>
 <1538044984-2147-2-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538044984-2147-2-git-send-email-jianchao.w.wang@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Sat, 29 Sep 2018 02:49:14 +0000 (UTC)
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

Looks both blk_mq_sysfs_register() and blk_mq_debugfs_register_hctx()
are removed from the path of blk_mq_init_allocated_queue(), so where are
the two registered for a freshly new queue?

Thanks,
Ming

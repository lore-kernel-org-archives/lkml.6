Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA5EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6BB62073D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbfBOC1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:27:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50304 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbfBOC1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:27:18 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 05E3DA53C7;
        Fri, 15 Feb 2019 02:27:18 +0000 (UTC)
Received: from ming.t460p (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 23D7E5DD6C;
        Fri, 15 Feb 2019 02:27:03 +0000 (UTC)
Date:   Fri, 15 Feb 2019 10:26:59 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        tj@kernel.org, longman@redhat.com, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v7 21/23] block: Avoid that flushing triggers a lockdep
 complaint
Message-ID: <20190215022658.GB21045@ming.t460p>
References: <20190214230058.196511-1-bvanassche@acm.org>
 <20190214230058.196511-22-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214230058.196511-22-bvanassche@acm.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 15 Feb 2019 02:27:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 03:00:56PM -0800, Bart Van Assche wrote:
> Avoid that running test nvme/012 from the blktests suite triggers the
> following false positive lockdep complaint:
> 
> ============================================
> WARNING: possible recursive locking detected
> 5.0.0-rc3-xfstests-00015-g1236f7d60242 #841 Not tainted
> --------------------------------------------
> ksoftirqd/1/16 is trying to acquire lock:
> 000000000282032e (&(&fq->mq_flush_lock)->rlock){..-.}, at: flush_end_io+0x4e/0x1d0
> 
> but task is already holding lock:
> 00000000cbadcbc2 (&(&fq->mq_flush_lock)->rlock){..-.}, at: flush_end_io+0x4e/0x1d0
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(&(&fq->mq_flush_lock)->rlock);
>   lock(&(&fq->mq_flush_lock)->rlock);
> 
>  *** DEADLOCK ***
> 
>  May be due to missing lock nesting notation
> 
> 1 lock held by ksoftirqd/1/16:
>  #0: 00000000cbadcbc2 (&(&fq->mq_flush_lock)->rlock){..-.}, at: flush_end_io+0x4e/0x1d0
> 
> stack backtrace:
> CPU: 1 PID: 16 Comm: ksoftirqd/1 Not tainted 5.0.0-rc3-xfstests-00015-g1236f7d60242 #841
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  dump_stack+0x67/0x90
>  __lock_acquire.cold.45+0x2b4/0x313
>  lock_acquire+0x98/0x160
>  _raw_spin_lock_irqsave+0x3b/0x80
>  flush_end_io+0x4e/0x1d0
>  blk_mq_complete_request+0x76/0x110
>  nvmet_req_complete+0x15/0x110 [nvmet]
>  nvmet_bio_done+0x27/0x50 [nvmet]
>  blk_update_request+0xd7/0x2d0
>  blk_mq_end_request+0x1a/0x100
>  blk_flush_complete_seq+0xe5/0x350
>  flush_end_io+0x12f/0x1d0
>  blk_done_softirq+0x9f/0xd0
>  __do_softirq+0xca/0x440
>  run_ksoftirqd+0x24/0x50
>  smpboot_thread_fn+0x113/0x1e0
>  kthread+0x121/0x140
>  ret_from_fork+0x3a/0x50
> 
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-flush.c | 5 ++++-
>  block/blk.h       | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index 6e0f2d97fc6d..86c86c76c087 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -70,6 +70,7 @@
>  #include <linux/blkdev.h>
>  #include <linux/gfp.h>
>  #include <linux/blk-mq.h>
> +#include <linux/lockdep.h>
>  
>  #include "blk.h"
>  #include "blk-mq.h"
> @@ -472,7 +473,8 @@ struct blk_flush_queue *blk_alloc_flush_queue(struct request_queue *q,
>  	if (!fq)
>  		goto fail;
>  
> -	spin_lock_init(&fq->mq_flush_lock);
> +	lockdep_register_key(&fq->key);
> +	spin_lock_init_key(&fq->mq_flush_lock, &fq->key);
>  
>  	rq_sz = round_up(rq_sz + cmd_size, cache_line_size());
>  	fq->flush_rq = kzalloc_node(rq_sz, flags, node);
> @@ -497,6 +499,7 @@ void blk_free_flush_queue(struct blk_flush_queue *fq)
>  	if (!fq)
>  		return;
>  
> +	lockdep_unregister_key(&fq->key);
>  	kfree(fq->flush_rq);
>  	kfree(fq);
>  }
> diff --git a/block/blk.h b/block/blk.h
> index 848278c52030..10f5e19aa4a1 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -28,6 +28,7 @@ struct blk_flush_queue {
>  	 * at the same time
>  	 */
>  	struct request		*orig_rq;
> +	struct lock_class_key	key;
>  	spinlock_t		mq_flush_lock;
>  };
>  

Hi Bart,

Did you look at the following comment?

https://marc.info/?l=linux-block&m=155014828206209&w=2

There might be lots of blk_flush_queue instance which is allocated
for each hctx, then lots of class key slot may be wasted.

So I suggest to use one nvmet_loop_flush_lock_key for this particular issue,
something like the following patch:

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 4aac1b4a8112..ec4248c12ed9 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -524,7 +524,9 @@ static const struct nvme_ctrl_ops nvme_loop_ctrl_ops = {
 
 static int nvme_loop_create_io_queues(struct nvme_loop_ctrl *ctrl)
 {
-	int ret;
+	static struct lock_class_key  nvme_loop_flush_lock_key;
+	int ret, i;
+	struct blk_mq_hw_ctx *hctx;
 
 	ret = nvme_loop_init_io_queues(ctrl);
 	if (ret)
@@ -553,6 +555,10 @@ static int nvme_loop_create_io_queues(struct nvme_loop_ctrl *ctrl)
 		goto out_free_tagset;
 	}
 
+	queue_for_each_hw_ctx(ctrl->ctrl.connect_q, hctx, i)
+		lockdep_set_class(&hctx->fq->mq_flush_lock,
+				&nvme_loop_flush_lock_key);
+
 	ret = nvme_loop_connect_io_queues(ctrl);
 	if (ret)
 		goto out_cleanup_connect_q;

--
Ming

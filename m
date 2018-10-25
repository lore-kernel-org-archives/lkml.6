Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA472C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC602083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AC602083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbeJZE0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 00:26:24 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:47922 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbeJZE0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 00:26:24 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1gFlfv-0000uE-St; Thu, 25 Oct 2018 21:52:12 +0200
Message-ID: <11db45f85e2f763c23ae32834dcd016adfce8ad6.camel@sipsolutions.net>
Subject: Re: [PATCH 3/3] kernel/workqueue: Suppress a false positive lockdep
 complaint
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Bart Van Assche <bvanassche@acm.org>, Tejun Heo <tj@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "tytso@mit.edu" <tytso@mit.edu>
Date:   Thu, 25 Oct 2018 21:51:50 +0200
In-Reply-To: <1540487511.66186.31.camel@acm.org> (sfid-20181025_191156_926182_FF0802A9)
References: <20181025150540.259281-1-bvanassche@acm.org>
         <20181025150540.259281-4-bvanassche@acm.org>
         <2cebeb88640433ce473bc40f9a5c7e06d0661e4d.camel@sipsolutions.net>
         <1540487511.66186.31.camel@acm.org> (sfid-20181025_191156_926182_FF0802A9)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-25 at 10:11 -0700, Bart Van Assche wrote:
> On Thu, 2018-10-25 at 19:02 +0200, Johannes Berg wrote:
> > On Thu, 2018-10-25 at 15:05 +0000, Bart Van Assche wrote:
> > > It can happen that the direct I/O queue creates and destroys an empty
> > > workqueue from inside a work function.
> > 
> > So, thinking about this more, can you guarantee (somehow) that the
> > workqueue is empty at this point?
> 
> In general, no. But for the direct I/O case this can be guaranteed. Please
> have a look at the code in sb_init_dio_done_wq() if you would not yet have
> done this.

Indeed, obviously.

> > Do you know how to reproduce this?
> 
> The lockdep complaint in the patch description is easy to reproduce. The
> way I reproduce it is as follows:
> 
> git clone https://github.com/osandov/blktests
> (cd blktests && ./check -q nvmeof-mp)

I'm a bit scared by this, looks like that needs a lot of prerequisites?
I'll try it in a VM when it's done compiling with nvme.


Looking at the splat in more detail, I think we have the following:

__generic_file_fsync() takes i_mutex_key#14

__generic_file_fsync() this is called from dio_aio_complete_work()

dio_aio_complete_work() generally runs on the dio/%s workqueue



Lockdep also sees:

ext4_file_write_iter() takes i_mutex_key#14

depending on circumstances, it can then call do_blockdev_direct_IO(),
which needs to ensure the WQ exists for this SB, so it calls
sb_init_dio_done_wq() to allocate the dio/%s workqueue.



Since lockdep neither knows that the instance of the workqueue that was
executing dio_aio_complete_work() must be different from the instance
that's freed, it complains because this creates a circle of
dependencies.

Still, basically what I tried to say before - rather than track whether
a workqueue was ever used, which is error-prone since in other cases in
the kernel the usage might depend on whatever conditions, I think we
should either teach lockdep that this is guaranteed to be a different
workqueue, or perhaps we should just have a "free empty workqueue"
function. I tend to prefer the former as it's more general, so I'd
propose this (combined) patch:

diff --git a/fs/direct-io.c b/fs/direct-io.c
index 093fb54cd316..9ef33d6cba56 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -629,9 +629,16 @@ int sb_init_dio_done_wq(struct super_block *sb)
 	 * This has to be atomic as more DIOs can race to create the workqueue
 	 */
 	old = cmpxchg(&sb->s_dio_done_wq, NULL, wq);
-	/* Someone created workqueue before us? Free ours... */
+	/*
+	 * Someone created workqueue before us? Free ours...
+	 * Note the _nested(), that pushes down to the (in this case actually
+	 * pointless) flush_workqueue() happening inside, since this function
+	 * might be called in contexts that hold the same locks that an fs may
+	 * take while being called from dio_aio_complete_work() from another
+	 * instance of the workqueue we allocate here.
+	 */
 	if (old)
-		destroy_workqueue(wq);
+		destroy_workqueue_nested(wq, SINGLE_DEPTH_NESTING);
 	return 0;
 }
 
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 60d673e15632..0b36a7df61d4 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -453,7 +453,12 @@ __alloc_workqueue_key(const char *fmt, unsigned int flags, int max_active,
 #define create_singlethread_workqueue(name)				\
 	alloc_ordered_workqueue("%s", __WQ_LEGACY | WQ_MEM_RECLAIM, name)
 
-extern void destroy_workqueue(struct workqueue_struct *wq);
+extern void destroy_workqueue_nested(struct workqueue_struct *wq, int subclass);
+
+static inline void destroy_workqueue(struct workqueue_struct *wq)
+{
+	destroy_workqueue_nested(wq, 0);
+}
 
 struct workqueue_attrs *alloc_workqueue_attrs(gfp_t gfp_mask);
 void free_workqueue_attrs(struct workqueue_attrs *attrs);
@@ -469,8 +474,18 @@ extern bool mod_delayed_work_on(int cpu, struct workqueue_struct *wq,
 			struct delayed_work *dwork, unsigned long delay);
 extern bool queue_rcu_work(struct workqueue_struct *wq, struct rcu_work *rwork);
 
-extern void flush_workqueue(struct workqueue_struct *wq);
-extern void drain_workqueue(struct workqueue_struct *wq);
+extern void flush_workqueue_nested(struct workqueue_struct *wq, int subclass);
+extern void drain_workqueue_nested(struct workqueue_struct *wq, int subclass);
+
+static inline void flush_workqueue(struct workqueue_struct *wq)
+{
+	flush_workqueue_nested(wq, 0);
+}
+
+static inline void drain_workqueue(struct workqueue_struct *wq)
+{
+	drain_workqueue_nested(wq, 0);
+}
 
 extern int schedule_on_each_cpu(work_func_t func);
 
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 0280deac392e..6b00e062af96 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2634,13 +2634,14 @@ static bool flush_workqueue_prep_pwqs(struct workqueue_struct *wq,
 }
 
 /**
- * flush_workqueue - ensure that any scheduled work has run to completion.
+ * flush_workqueue_nested - ensure that any scheduled work has run to completion.
  * @wq: workqueue to flush
+ * @subclass: subclass for lockdep
  *
  * This function sleeps until all work items which were queued on entry
  * have finished execution, but it is not livelocked by new incoming ones.
  */
-void flush_workqueue(struct workqueue_struct *wq)
+void flush_workqueue_nested(struct workqueue_struct *wq, int subclass)
 {
 	struct wq_flusher this_flusher = {
 		.list = LIST_HEAD_INIT(this_flusher.list),
@@ -2652,7 +2653,7 @@ void flush_workqueue(struct workqueue_struct *wq)
 	if (WARN_ON(!wq_online))
 		return;
 
-	lock_map_acquire(&wq->lockdep_map);
+	lock_acquire_exclusive(&wq->lockdep_map, subclass, 0, NULL, _THIS_IP_);
 	lock_map_release(&wq->lockdep_map);
 
 	mutex_lock(&wq->mutex);
@@ -2789,11 +2790,12 @@ void flush_workqueue(struct workqueue_struct *wq)
 out_unlock:
 	mutex_unlock(&wq->mutex);
 }
-EXPORT_SYMBOL(flush_workqueue);
+EXPORT_SYMBOL(flush_workqueue_nested);
 
 /**
- * drain_workqueue - drain a workqueue
+ * drain_workqueue_nested - drain a workqueue
  * @wq: workqueue to drain
+ * @subclass: lockdep subclass
  *
  * Wait until the workqueue becomes empty.  While draining is in progress,
  * only chain queueing is allowed.  IOW, only currently pending or running
@@ -2802,7 +2804,7 @@ EXPORT_SYMBOL(flush_workqueue);
  * by the depth of chaining and should be relatively short.  Whine if it
  * takes too long.
  */
-void drain_workqueue(struct workqueue_struct *wq)
+void drain_workqueue_nested(struct workqueue_struct *wq, int subclass)
 {
 	unsigned int flush_cnt = 0;
 	struct pool_workqueue *pwq;
@@ -2817,7 +2819,7 @@ void drain_workqueue(struct workqueue_struct *wq)
 		wq->flags |= __WQ_DRAINING;
 	mutex_unlock(&wq->mutex);
 reflush:
-	flush_workqueue(wq);
+	flush_workqueue_nested(wq, subclass);
 
 	mutex_lock(&wq->mutex);
 
@@ -2844,7 +2846,7 @@ void drain_workqueue(struct workqueue_struct *wq)
 		wq->flags &= ~__WQ_DRAINING;
 	mutex_unlock(&wq->mutex);
 }
-EXPORT_SYMBOL_GPL(drain_workqueue);
+EXPORT_SYMBOL_GPL(drain_workqueue_nested);
 
 static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr,
 			     bool from_cancel)
@@ -4141,18 +4143,19 @@ struct workqueue_struct *__alloc_workqueue_key(const char *fmt,
 EXPORT_SYMBOL_GPL(__alloc_workqueue_key);
 
 /**
- * destroy_workqueue - safely terminate a workqueue
+ * destroy_workqueue_nested - safely terminate a workqueue
  * @wq: target workqueue
+ * @subclass: lockdep subclass
  *
  * Safely destroy a workqueue. All work currently pending will be done first.
  */
-void destroy_workqueue(struct workqueue_struct *wq)
+void destroy_workqueue_nested(struct workqueue_struct *wq, int subclass)
 {
 	struct pool_workqueue *pwq;
 	int node;
 
 	/* drain it before proceeding with destruction */
-	drain_workqueue(wq);
+	drain_workqueue_nested(wq, subclass);
 
 	/* sanity checks */
 	mutex_lock(&wq->mutex);
@@ -4217,7 +4220,7 @@ void destroy_workqueue(struct workqueue_struct *wq)
 		put_pwq_unlocked(pwq);
 	}
 }
-EXPORT_SYMBOL_GPL(destroy_workqueue);
+EXPORT_SYMBOL_GPL(destroy_workqueue_nested);
 
 /**
  * workqueue_set_max_active - adjust max_active of a workqueue


We could avoid the useless subclass argument in the non-lockdep case
with some macro trickery, but for now I haven't done that.

johannes


Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D74C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C836B2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AC5tmYVD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C836B2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbeLLJE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 04:04:28 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55902 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbeLLJE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 04:04:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+XPP4ag0ralWnBPCa/1Nb0L+FOiI4y1WI38xxv0QM0Y=; b=AC5tmYVD31KikE8uaMCt9X/gV
        ivLN0oVwz+yi0v+7z+sdcYs7I9FTe4CdDvYSwDEhTE0q5eaSnL2r05h3qdHkrm7eTwbHLC565tNYr
        QpsDNIGT56JKjlA6ppdtBk1MhCtujr9wysX09lPXmawcXfkMyLvCoCQs1IR7xh5iw8T+MNd/eg41S
        XLAMAQPGIwGv9HbEAbp7/WuYJbiMV7uREHowlMRv9O2KEte3aYz7PSmc6NZ2nBdENdUmZ45UeSEtI
        2gHH68tzwzDHhMFMlSqKACOUE+duUP/kZ18K0esosxDkTfSt19G2cxjSwlEU/ykwYx8cjEhrix1kB
        OVOpo208Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gX0RJ-0006S8-Qm; Wed, 12 Dec 2018 09:04:22 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 902982075BF39; Wed, 12 Dec 2018 10:04:18 +0100 (CET)
Date:   Wed, 12 Dec 2018 10:04:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stefan Liebler <stli@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Darren Hart <dvhart@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [patch] futex: Cure exit race
Message-ID: <20181212090418.GT5289@hirez.programming.kicks-ass.net>
References: <20181210152311.986181245@linutronix.de>
 <20181210160205.GQ5289@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1812101824070.1667@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1812101824070.1667@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 06:43:51PM +0100, Thomas Gleixner wrote:
> On Mon, 10 Dec 2018, Peter Zijlstra wrote:
> > On Mon, Dec 10, 2018 at 04:23:06PM +0100, Thomas Gleixner wrote:
> > There is another callers of futex_lock_pi_atomic(),
> > futex_proxy_trylock_atomic(), which is part of futex_requeue(), that too
> > does a retry loop on -EAGAIN.
> > 
> > And there is another caller of attach_to_pi_owner(): lookup_pi_state(),
> > and that too is in futex_requeue() and handles the retry case properly.
> > 
> > Yes, this all looks good.
> > 
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Bah. The little devil in the unconcious part of my brain insisted on
> thinking further about that EAGAIN loop even despite my attempt to page
> that futex horrors out again immediately after sending that patch.
> 
> There is another related issue which is even worse than just mildly
> confusing user space:
> 
>    task1(SCHED_OTHER)
>    sys_exit()
>      do_exit()
>       exit_mm()
>        task1->flags |= PF_EXITING;
> 
>    ---> preemption
> 
>    task2(SCHED_FIFO)
>      sys_futex(LOCK_PI)
>        ....
>        attach_to_pi_owner() {
>          ...
>          if (!task1->flags & PF_EXITING) {
>            attach();
>          } else {
>               if (!(tsk->flags & PF_EXITPIDONE))
> 	         return -EAGAIN;
> 
> Now assume UP or both tasks pinned on the same CPU. That results in a
> livelock because task2 is going to loop forever.
> 
> No immediate idea how to cure that one w/o creating a mess.

One possible; but fairly gruesome hack; would be something like the
below.

Now, this obviously introduces a priority inversion, but that's
arguablly better than a live-lock, also I'm not sure there's really
anything 'sane' you can do in the case where your lock holder is dying
instead of doing a proper unlock anyway.

But no, I'm not liking this much either...

diff --git a/kernel/exit.c b/kernel/exit.c
index 0e21e6d21f35..bc6a01112d9d 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -806,6 +806,8 @@ void __noreturn do_exit(long code)
 		 * task into the wait for ever nirwana as well.
 		 */
 		tsk->flags |= PF_EXITPIDONE;
+		smp_mb();
+		wake_up_bit(&tsk->flags, 3 /* PF_EXITPIDONE */);
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule();
 	}
diff --git a/kernel/futex.c b/kernel/futex.c
index f423f9b6577e..a743d657e783 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1148,8 +1148,8 @@ static int attach_to_pi_state(u32 __user *uaddr, u32 uval,
  * Lookup the task for the TID provided from user space and attach to
  * it after doing proper sanity checks.
  */
-static int attach_to_pi_owner(u32 uval, union futex_key *key,
-			      struct futex_pi_state **ps)
+static int attach_to_pi_owner(u32 __user *uaddr, u32 uval, union futex_key *key,
+			      struct futex_pi_state **ps, struct task_struct **pe)
 {
 	pid_t pid = uval & FUTEX_TID_MASK;
 	struct futex_pi_state *pi_state;
@@ -1187,10 +1236,15 @@ static int attach_to_pi_owner(u32 uval, union futex_key *key,
 		 * set, we know that the task has finished the
 		 * cleanup:
 		 */
 		int ret = handle_exit_race(uaddr, uval, p);
 
 		raw_spin_unlock_irq(&p->pi_lock);
-		put_task_struct(p);
+
+		if (ret == -EAGAIN)
+			*pe = p;
+		else
+			put_task_struct(p);
+
 		return ret;
 	}
 
@@ -1244,7 +1298,7 @@ static int lookup_pi_state(u32 __user *uaddr, u32 uval,
 	 * We are the first waiter - try to look up the owner based on
 	 * @uval and attach to it.
 	 */
-	return attach_to_pi_owner(uval, key, ps);
+	return attach_to_pi_owner(uaddr, uval, key, ps);
 }
 
 static int lock_pi_update_atomic(u32 __user *uaddr, u32 uval, u32 newval)
@@ -1282,7 +1336,8 @@ static int lock_pi_update_atomic(u32 __user *uaddr, u32 uval, u32 newval)
 static int futex_lock_pi_atomic(u32 __user *uaddr, struct futex_hash_bucket *hb,
 				union futex_key *key,
 				struct futex_pi_state **ps,
-				struct task_struct *task, int set_waiters)
+				struct task_struct *task, int set_waiters,
+				struct task_struct **exiting)
 {
 	u32 uval, newval, vpid = task_pid_vnr(task);
 	struct futex_q *top_waiter;
@@ -1352,7 +1407,7 @@ static int futex_lock_pi_atomic(u32 __user *uaddr, struct futex_hash_bucket *hb,
 	 * attach to the owner. If that fails, no harm done, we only
 	 * set the FUTEX_WAITERS bit in the user space variable.
 	 */
-	return attach_to_pi_owner(uval, key, ps);
+	return attach_to_pi_owner(uaddr, uval, key, ps, exiting);
 }
 
 /**
@@ -2716,6 +2771,7 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 	struct rt_mutex_waiter rt_waiter;
 	struct futex_hash_bucket *hb;
 	struct futex_q q = futex_q_init;
+	struct task_struct *exiting;
 	int res, ret;
 
 	if (!IS_ENABLED(CONFIG_FUTEX_PI))
@@ -2733,6 +2789,7 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 	}
 
 retry:
+	exiting = NULL;
 	ret = get_futex_key(uaddr, flags & FLAGS_SHARED, &q.key, VERIFY_WRITE);
 	if (unlikely(ret != 0))
 		goto out;
@@ -2740,7 +2797,7 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 retry_private:
 	hb = queue_lock(&q);
 
-	ret = futex_lock_pi_atomic(uaddr, hb, &q.key, &q.pi_state, current, 0);
+	ret = futex_lock_pi_atomic(uaddr, hb, &q.key, &q.pi_state, current, 0, &exiting);
 	if (unlikely(ret)) {
 		/*
 		 * Atomic work succeeded and we got the lock,
@@ -2762,6 +2819,12 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 			 */
 			queue_unlock(hb);
 			put_futex_key(&q.key);
+
+			if (exiting) {
+				wait_bit(&exiting->flags, 3 /* PF_EXITPIDONE */, TASK_UNINTERRUPTIBLE);
+				put_task_struct(exiting);
+			}
+
 			cond_resched();
 			goto retry;
 		default:

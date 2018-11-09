Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91741C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F08120840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=austad-us.20150623.gappssmtp.com header.i=@austad-us.20150623.gappssmtp.com header.b="qm7Zk+4O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F08120840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=austad.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbeKITr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:47:56 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:32942 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbeKITrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:47:55 -0500
Received: by mail-lf1-f68.google.com with SMTP id i26so925223lfc.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 02:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=austad-us.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4Y32pnofdGwY40blovyeS3tP03mZN23o/Nx3ToDc44c=;
        b=qm7Zk+4ONa/btjkO7l+0r8cJo/9x8+KRuoJYikoeE/YiaIVPYNrAvEIvxNNMuXv+Xx
         kflY6jOBmEVO3tcMy5vXBi7YN53LyYh2HNqFNQOvhyHP3CvDNA0W0772oHprlxXoB+8O
         cwk2cyV8cuZdCyPAlXb6ybfEkjMlE155P4QLPmohMFBVByJ12As9DahwCq3YE+rbVeVS
         Z6BRDCZu34bY2d1c9OA+CEzBUQbHet+pvKGMJbsqOpW3Mh4A17hlFNNBn5I5fQ+spaCD
         ZgWwR5ZdSIxIIlADlN5vjNl0s5w4xIgx+Wk5+r82RfRtz+nyq16rOW9+0iyAsX3ipa05
         xQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4Y32pnofdGwY40blovyeS3tP03mZN23o/Nx3ToDc44c=;
        b=AIdn1eMWtUFHGeRrZPKFVoJoICUtHVPG07luPqUH2Wa7Q4sc++wumln1dMrvoei1dL
         Ed1NNPwIq/KnfXrfIbMl3Q8Pi/Xem8onByLwxKUNohVj1e4ECoRTHqe8tMuY8kjlsXSV
         PVnxYF7YDNeeJ5Kt3RNNxm/larQByMsdgRH9bO+RKrFJfWSxIbIuxJDbKUqzdi2sAWkS
         znBy1pYFrC8nqHxgTJQvkWrIOHLgQ8uygheVZRFjz65FIIZUyVgFTUen/zTNJip6f7fK
         X6/6DNV5jz4sMbhve5Ku5lsyPDoo3pk2btOtjJpFvSAONjYnIv9nF3PWiPuOoVbA4XP2
         osAQ==
X-Gm-Message-State: AGRZ1gI3i37a8tf274gEK5EoxSN2JP/pjPzgVMPLvAdNfepso2jjc3st
        eoGQ0CGNaZRje8qWALkLYDdzBBjTTh0QAeRu
X-Google-Smtp-Source: AJdET5fZ0j7sog/GOehbQ+ePqyvLsHUiA7hMEdDZOjJJYdvjG+nx1kmRWcSfcV2RPGvPX33f5EM6KA==
X-Received: by 2002:a19:5059:: with SMTP id z25mr4862170lfj.120.1541758078960;
        Fri, 09 Nov 2018 02:07:58 -0800 (PST)
Received: from sisyphus.home.austad.us (11.92-220-88.customer.lyse.net. [92.220.88.11])
        by smtp.gmail.com with ESMTPSA id u65sm1265576lff.54.2018.11.09.02.07.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 02:07:57 -0800 (PST)
From:   Henrik Austad <henrik@austad.us>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Henrik Austad <haustad@cisco.com>,
        Peter Zijlstra <peterz@infradead.org>, juri.lelli@arm.com,
        bigeasy@linutronix.de, xlpang@redhat.com, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jdesfossez@efficios.com,
        dvhart@infradead.org, bristot@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 05/17] futex,rt_mutex: Provide futex specific rt_mutex API
Date:   Fri,  9 Nov 2018 11:07:33 +0100
Message-Id: <1541758065-10952-6-git-send-email-henrik@austad.us>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541758065-10952-1-git-send-email-henrik@austad.us>
References: <1541758065-10952-1-git-send-email-henrik@austad.us>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

commit 5293c2efda37775346885c7e924d4ef7018ea60b upstream.

Part of what makes futex_unlock_pi() intricate is that
rt_mutex_futex_unlock() -> rt_mutex_slowunlock() can drop
rt_mutex::wait_lock.

This means it cannot rely on the atomicy of wait_lock, which would be
preferred in order to not rely on hb->lock so much.

The reason rt_mutex_slowunlock() needs to drop wait_lock is because it can
race with the rt_mutex fastpath, however futexes have their own fast path.

Since futexes already have a bunch of separate rt_mutex accessors, complete
that set and implement a rt_mutex variant without fastpath for them.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: juri.lelli@arm.com
Cc: bigeasy@linutronix.de
Cc: xlpang@redhat.com
Cc: rostedt@goodmis.org
Cc: mathieu.desnoyers@efficios.com
Cc: jdesfossez@efficios.com
Cc: dvhart@infradead.org
Cc: bristot@redhat.com
Link: http://lkml.kernel.org/r/20170322104151.702962446@infradead.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by:Henrik Austad <haustad@cisco.com>
---
 kernel/futex.c                  | 30 +++++++++++-----------
 kernel/locking/rtmutex.c        | 55 ++++++++++++++++++++++++++++++-----------
 kernel/locking/rtmutex_common.h |  9 +++++--
 3 files changed, 62 insertions(+), 32 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 0f44952..e1200b9 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -910,7 +910,7 @@ void exit_pi_state_list(struct task_struct *curr)
 		pi_state->owner = NULL;
 		raw_spin_unlock_irq(&curr->pi_lock);
 
-		rt_mutex_unlock(&pi_state->pi_mutex);
+		rt_mutex_futex_unlock(&pi_state->pi_mutex);
 
 		spin_unlock(&hb->lock);
 
@@ -1358,20 +1358,18 @@ static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_q *top_waiter
 	pi_state->owner = new_owner;
 	raw_spin_unlock(&new_owner->pi_lock);
 
-	raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
-
-	deboost = rt_mutex_futex_unlock(&pi_state->pi_mutex, &wake_q);
-
 	/*
-	 * First unlock HB so the waiter does not spin on it once he got woken
-	 * up. Second wake up the waiter before the priority is adjusted. If we
-	 * deboost first (and lose our higher priority), then the task might get
-	 * scheduled away before the wake up can take place.
+	 * We've updated the uservalue, this unlock cannot fail.
 	 */
+	deboost = __rt_mutex_futex_unlock(&pi_state->pi_mutex, &wake_q);
+
+	raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
 	spin_unlock(&hb->lock);
-	wake_up_q(&wake_q);
-	if (deboost)
+
+	if (deboost) {
+		wake_up_q(&wake_q);
 		rt_mutex_adjust_prio(current);
+	}
 
 	return 0;
 }
@@ -2259,7 +2257,7 @@ static int fixup_owner(u32 __user *uaddr, struct futex_q *q, int locked)
 		 * task acquired the rt_mutex after we removed ourself from the
 		 * rt_mutex waiters list.
 		 */
-		if (rt_mutex_trylock(&q->pi_state->pi_mutex)) {
+		if (rt_mutex_futex_trylock(&q->pi_state->pi_mutex)) {
 			locked = 1;
 			goto out;
 		}
@@ -2574,7 +2572,7 @@ retry_private:
 	if (!trylock) {
 		ret = rt_mutex_timed_futex_lock(&q.pi_state->pi_mutex, to);
 	} else {
-		ret = rt_mutex_trylock(&q.pi_state->pi_mutex);
+		ret = rt_mutex_futex_trylock(&q.pi_state->pi_mutex);
 		/* Fixup the trylock return value: */
 		ret = ret ? 0 : -EWOULDBLOCK;
 	}
@@ -2597,7 +2595,7 @@ retry_private:
 	 * it and return the fault to userspace.
 	 */
 	if (ret && (rt_mutex_owner(&q.pi_state->pi_mutex) == current))
-		rt_mutex_unlock(&q.pi_state->pi_mutex);
+		rt_mutex_futex_unlock(&q.pi_state->pi_mutex);
 
 	/* Unqueue and drop the lock */
 	unqueue_me_pi(&q);
@@ -2904,7 +2902,7 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 			spin_lock(q.lock_ptr);
 			ret = fixup_pi_state_owner(uaddr2, &q, current);
 			if (ret && rt_mutex_owner(&q.pi_state->pi_mutex) == current)
-				rt_mutex_unlock(&q.pi_state->pi_mutex);
+				rt_mutex_futex_unlock(&q.pi_state->pi_mutex);
 			/*
 			 * Drop the reference to the pi state which
 			 * the requeue_pi() code acquired for us.
@@ -2944,7 +2942,7 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 		 * userspace.
 		 */
 		if (ret && rt_mutex_owner(pi_mutex) == current)
-			rt_mutex_unlock(pi_mutex);
+			rt_mutex_futex_unlock(pi_mutex);
 
 		/* Unqueue and drop the lock. */
 		unqueue_me_pi(&q);
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index b8d08c7..28c1d40 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1486,15 +1486,23 @@ EXPORT_SYMBOL_GPL(rt_mutex_lock_interruptible);
 
 /*
  * Futex variant with full deadlock detection.
+ * Futex variants must not use the fast-path, see __rt_mutex_futex_unlock().
  */
-int rt_mutex_timed_futex_lock(struct rt_mutex *lock,
+int __sched rt_mutex_timed_futex_lock(struct rt_mutex *lock,
 			      struct hrtimer_sleeper *timeout)
 {
 	might_sleep();
 
-	return rt_mutex_timed_fastlock(lock, TASK_INTERRUPTIBLE, timeout,
-				       RT_MUTEX_FULL_CHAINWALK,
-				       rt_mutex_slowlock);
+	return rt_mutex_slowlock(lock, TASK_INTERRUPTIBLE,
+				 timeout, RT_MUTEX_FULL_CHAINWALK);
+}
+
+/*
+ * Futex variant, must not use fastpath.
+ */
+int __sched rt_mutex_futex_trylock(struct rt_mutex *lock)
+{
+	return rt_mutex_slowtrylock(lock);
 }
 
 /**
@@ -1553,19 +1561,38 @@ void __sched rt_mutex_unlock(struct rt_mutex *lock)
 EXPORT_SYMBOL_GPL(rt_mutex_unlock);
 
 /**
- * rt_mutex_futex_unlock - Futex variant of rt_mutex_unlock
- * @lock: the rt_mutex to be unlocked
- *
- * Returns: true/false indicating whether priority adjustment is
- * required or not.
+ * Futex variant, that since futex variants do not use the fast-path, can be
+ * simple and will not need to retry.
  */
-bool __sched rt_mutex_futex_unlock(struct rt_mutex *lock,
-				   struct wake_q_head *wqh)
+bool __sched __rt_mutex_futex_unlock(struct rt_mutex *lock,
+				    struct wake_q_head *wake_q)
 {
-	if (likely(rt_mutex_cmpxchg_release(lock, current, NULL)))
-		return false;
+	lockdep_assert_held(&lock->wait_lock);
+
+	debug_rt_mutex_unlock(lock);
+
+	if (!rt_mutex_has_waiters(lock)) {
+		lock->owner = NULL;
+		return false; /* done */
+	}
+
+	mark_wakeup_next_waiter(wake_q, lock);
+	return true; /* deboost and wakeups */
+}
 
-	return rt_mutex_slowunlock(lock, wqh);
+void __sched rt_mutex_futex_unlock(struct rt_mutex *lock)
+{
+	WAKE_Q(wake_q);
+	bool deboost;
+
+	raw_spin_lock_irq(&lock->wait_lock);
+	deboost = __rt_mutex_futex_unlock(lock, &wake_q);
+	raw_spin_unlock_irq(&lock->wait_lock);
+
+	if (deboost) {
+		wake_up_q(&wake_q);
+		rt_mutex_adjust_prio(current);
+	}
 }
 
 /**
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index e317e1c..2441c2d 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -109,9 +109,14 @@ extern int rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 extern int rt_mutex_finish_proxy_lock(struct rt_mutex *lock,
 				      struct hrtimer_sleeper *to,
 				      struct rt_mutex_waiter *waiter);
+
 extern int rt_mutex_timed_futex_lock(struct rt_mutex *l, struct hrtimer_sleeper *to);
-extern bool rt_mutex_futex_unlock(struct rt_mutex *lock,
-				  struct wake_q_head *wqh);
+extern int rt_mutex_futex_trylock(struct rt_mutex *l);
+
+extern void rt_mutex_futex_unlock(struct rt_mutex *lock);
+extern bool __rt_mutex_futex_unlock(struct rt_mutex *lock,
+				 struct wake_q_head *wqh);
+
 extern void rt_mutex_adjust_prio(struct task_struct *task);
 
 #ifdef CONFIG_DEBUG_RT_MUTEXES
-- 
2.7.4


Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuQqBtfPT+qkHUrcRupf1dvsblQCcKPLAMWtzoXo2JRa+NQCuqfbqM12DVQpPIMf+wla+Mz
ARC-Seal: i=1; a=rsa-sha256; t=1521483791; cv=none;
        d=google.com; s=arc-20160816;
        b=VakovnZyFgv+gh9Yer5DHsTFmb51f1lLzIecGt4Y/MvbEmySSiihOfcIfxDX4CMW7b
         T1HzjHLF9hR0kJJsQqcvfOmGNnfOR/bMOKbbWciLUuHshyD6pCDUn7FWfMuMsgdPlh4c
         y+YD2ZJcCIijwdDu4o34p9e9m4XHM4xsQ958jJq0t3sTplsTNfJhvtS6D4l+0i7Y+NJd
         Um1EBsCQvQMqlpgWk5Bzmjm9s5ujXvl3NVRGD3+DHiIRjnL/8oeUKtPal1ttU4uhnA97
         4LQvj1l7PSLTUqy73zA+OPWjgb020egWtKSJfiLaaVB0XiGZX3j0nCYsShs5yT4m5rDs
         y9hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qfNfFyvuxIQIs1VCcGQOJyb0UYnqPzmJjBYtQLgd4rc=;
        b=ocL0QjqXTJegqwulkOmS/XH7JKd839FAVkCyZ9W3TrRuSG5Tal43Mei0g2DJv+J+Th
         YBZrsMiaahNzDzzh403hJrQt73CKnsJKO6KlyPB3/P5kRKrRWkBVcILbZFpzxjguDbJ9
         TfGowUmxUSz4ooAhuVQtA+cjSRKEDTEQ03FUznMnW1y+L8m2volYytbVZjA8Wv7VHzMx
         gZ59xkux0WEkIDxh3CQ3ZluJuwrbRLceVNxVYSndxSUkY0f4bk1i0+vqp5tLOQW53wsB
         5LZo2okuNBjfRetTtWbcoJZOfYsYA8mfFftJp+aI0IB++H+lMSA9TXRwi0Furi6byAJB
         64WQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	juri.lelli@arm.com,
	bigeasy@linutronix.de,
	xlpang@redhat.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jdesfossez@efficios.com,
	bristot@redhat.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 101/241] rtmutex: Fix PI chain order integrity
Date: Mon, 19 Mar 2018 19:06:06 +0100
Message-Id: <20180319180755.385200641@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391388097553297?=
X-GMAIL-MSGID: =?utf-8?q?1595391388097553297?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>


[ Upstream commit e0aad5b44ff5d28ac1d6ae70cdf84ca228e889dc ]

rt_mutex_waiter::prio is a copy of task_struct::prio which is updated
during the PI chain walk, such that the PI chain order isn't messed up
by (asynchronous) task state updates.

Currently rt_mutex_waiter_less() uses task state for deadline tasks;
this is broken, since the task state can, as said above, change
asynchronously, causing the RB tree order to change without actual
tree update -> FAIL.

Fix this by also copying the deadline into the rt_mutex_waiter state
and updating it along with its prio field.

Ideally we would also force PI chain updates whenever DL tasks update
their deadline parameter, but for first approximation this is less
broken than it was.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: juri.lelli@arm.com
Cc: bigeasy@linutronix.de
Cc: xlpang@redhat.com
Cc: rostedt@goodmis.org
Cc: mathieu.desnoyers@efficios.com
Cc: jdesfossez@efficios.com
Cc: bristot@redhat.com
Link: http://lkml.kernel.org/r/20170323150216.403992539@infradead.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/locking/rtmutex.c        |   29 +++++++++++++++++++++++++++--
 kernel/locking/rtmutex_common.h |    1 +
 2 files changed, 28 insertions(+), 2 deletions(-)

--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -236,8 +236,7 @@ rt_mutex_waiter_less(struct rt_mutex_wai
 	 * then right waiter has a dl_prio() too.
 	 */
 	if (dl_prio(left->prio))
-		return dl_time_before(left->task->dl.deadline,
-				      right->task->dl.deadline);
+		return dl_time_before(left->deadline, right->deadline);
 
 	return 0;
 }
@@ -704,7 +703,26 @@ static int rt_mutex_adjust_prio_chain(st
 
 	/* [7] Requeue the waiter in the lock waiter tree. */
 	rt_mutex_dequeue(lock, waiter);
+
+	/*
+	 * Update the waiter prio fields now that we're dequeued.
+	 *
+	 * These values can have changed through either:
+	 *
+	 *   sys_sched_set_scheduler() / sys_sched_setattr()
+	 *
+	 * or
+	 *
+	 *   DL CBS enforcement advancing the effective deadline.
+	 *
+	 * Even though pi_waiters also uses these fields, and that tree is only
+	 * updated in [11], we can do this here, since we hold [L], which
+	 * serializes all pi_waiters access and rb_erase() does not care about
+	 * the values of the node being removed.
+	 */
 	waiter->prio = task->prio;
+	waiter->deadline = task->dl.deadline;
+
 	rt_mutex_enqueue(lock, waiter);
 
 	/* [8] Release the task */
@@ -831,6 +849,8 @@ static int rt_mutex_adjust_prio_chain(st
 static int try_to_take_rt_mutex(struct rt_mutex *lock, struct task_struct *task,
 				struct rt_mutex_waiter *waiter)
 {
+	lockdep_assert_held(&lock->wait_lock);
+
 	/*
 	 * Before testing whether we can acquire @lock, we set the
 	 * RT_MUTEX_HAS_WAITERS bit in @lock->owner. This forces all
@@ -958,6 +978,8 @@ static int task_blocks_on_rt_mutex(struc
 	struct rt_mutex *next_lock;
 	int chain_walk = 0, res;
 
+	lockdep_assert_held(&lock->wait_lock);
+
 	/*
 	 * Early deadlock detection. We really don't want the task to
 	 * enqueue on itself just to untangle the mess later. It's not
@@ -975,6 +997,7 @@ static int task_blocks_on_rt_mutex(struc
 	waiter->task = task;
 	waiter->lock = lock;
 	waiter->prio = task->prio;
+	waiter->deadline = task->dl.deadline;
 
 	/* Get the top priority waiter on the lock */
 	if (rt_mutex_has_waiters(lock))
@@ -1080,6 +1103,8 @@ static void remove_waiter(struct rt_mute
 	struct task_struct *owner = rt_mutex_owner(lock);
 	struct rt_mutex *next_lock;
 
+	lockdep_assert_held(&lock->wait_lock);
+
 	raw_spin_lock(&current->pi_lock);
 	rt_mutex_dequeue(lock, waiter);
 	current->pi_blocked_on = NULL;
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -33,6 +33,7 @@ struct rt_mutex_waiter {
 	struct rt_mutex		*deadlock_lock;
 #endif
 	int prio;
+	u64 deadline;
 };
 
 /*

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965589AbeEYJrR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:47:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45731 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965562AbeEYJrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:47:14 -0400
Date: Fri, 25 May 2018 02:46:45 -0700
From: tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-b1f5b378e126133521df668379249fb8265121f1@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        peterz@infradead.org, mingo@kernel.org, mroos@linux.ee, lkp@01.org,
        lkp@intel.com, torvalds@linux-foundation.org
Reply-To: peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com,
        torvalds@linux-foundation.org, lkp@intel.com, mroos@linux.ee,
        lkp@01.org
In-Reply-To: <20180504091142.GI12235@hirez.programming.kicks-ass.net>
References: <20180504091142.GI12235@hirez.programming.kicks-ass.net>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] kthread: Allow kthread_park() on a parked kthread
Git-Commit-ID: b1f5b378e126133521df668379249fb8265121f1
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  b1f5b378e126133521df668379249fb8265121f1
Gitweb:     https://git.kernel.org/tip/b1f5b378e126133521df668379249fb8265121f1
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Fri, 4 May 2018 11:11:42 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 25 May 2018 08:03:51 +0200

kthread: Allow kthread_park() on a parked kthread

The following commit:

  85f1abe0019f ("kthread, sched/wait: Fix kthread_parkme() completion issue")

added a WARN() in the case where we call kthread_park() on an already
parked thread, because the old code wasn't doing the right thing there
and it wasn't at all clear that would happen.

It turns out, this does in fact happen, so we have to deal with it.

Instead of potentially returning early, also wait for the completion.
This does however mean we have to use complete_all() and re-initialize
the completion on re-use.

Reported-by: LKP <lkp@01.org>
Tested-by: Meelis Roos <mroos@linux.ee>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: kernel test robot <lkp@intel.com>
Cc: wfg@linux.intel.com
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 85f1abe0019f ("kthread, sched/wait: Fix kthread_parkme() completion issue")
Link: http://lkml.kernel.org/r/20180504091142.GI12235@hirez.programming.kicks-ass.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/kthread.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 2017a39ab490..481951bf091d 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -193,7 +193,7 @@ EXPORT_SYMBOL_GPL(kthread_parkme);
 
 void kthread_park_complete(struct task_struct *k)
 {
-	complete(&to_kthread(k)->parked);
+	complete_all(&to_kthread(k)->parked);
 }
 
 static int kthread(void *_create)
@@ -459,6 +459,7 @@ void kthread_unpark(struct task_struct *k)
 	if (test_bit(KTHREAD_IS_PER_CPU, &kthread->flags))
 		__kthread_bind(k, kthread->cpu, TASK_PARKED);
 
+	reinit_completion(&kthread->parked);
 	clear_bit(KTHREAD_SHOULD_PARK, &kthread->flags);
 	wake_up_state(k, TASK_PARKED);
 }
@@ -483,9 +484,6 @@ int kthread_park(struct task_struct *k)
 	if (WARN_ON(k->flags & PF_EXITING))
 		return -ENOSYS;
 
-	if (WARN_ON_ONCE(test_bit(KTHREAD_SHOULD_PARK, &kthread->flags)))
-		return -EBUSY;
-
 	set_bit(KTHREAD_SHOULD_PARK, &kthread->flags);
 	if (k != current) {
 		wake_up_process(k);

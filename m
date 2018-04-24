Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751555AbeDXSFV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 14:05:21 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46520 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751095AbeDXSFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 14:05:18 -0400
Date: Tue, 24 Apr 2018 20:05:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Kohli, Gaurav" <gkohli@codeaurora.org>
Cc: tglx@linutronix.de, mpe@ellerman.id.au, dzickus@redhat.com,
        mingo@kernel.org, bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>
Subject: Re: [PATCH] kthread/smpboot: Serialize kthread parking against wakeup
Message-ID: <20180424180504.GV4043@hirez.programming.kicks-ass.net>
References: <1524562105-31026-1-git-send-email-gkohli@codeaurora.org>
 <3e823654-9701-9b01-43fc-1a29feb7a298@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e823654-9701-9b01-43fc-1a29feb7a298@codeaurora.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 08:12:49PM +0530, Kohli, Gaurav wrote:
> @@ -157,6 +156,7 @@ static int smpboot_thread_fn(void *data)
> 
>                 if (!ht->thread_should_run(td->cpu)) {
> 
>                         preempt_enable_no_resched();
> 
> +                       set_current_state(TASK_INTERRUPTIBLE);
> 
>                         schedule();
> 
>                 } else {
> 
>                         __set_current_state(TASK_RUNNING);
> 
> Please suggest if this approach is better.

Bah, my brain isn't working... see below for the 'correct' version of
your second patch.

But this violates the normal pattern; see the comment near
set_current_state(). That pattern ensures the thread either sees the
wakeup condition or the actual wakeup.

I'm thinking that with this patch there is a scenario where we'll miss
both the kthread_should_park() and the actual wakeup and end up not
doing anything.

I do the like the end result, but I suspect it's buggy.


---
 kernel/smpboot.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/smpboot.c b/kernel/smpboot.c
index 5043e7433f4b..5bdf57f2ce68 100644
--- a/kernel/smpboot.c
+++ b/kernel/smpboot.c
@@ -109,10 +109,8 @@ static int smpboot_thread_fn(void *data)
 	struct smp_hotplug_thread *ht = td->ht;
 
 	while (1) {
-		set_current_state(TASK_INTERRUPTIBLE);
 		preempt_disable();
 		if (kthread_should_stop()) {
-			__set_current_state(TASK_RUNNING);
 			preempt_enable();
 			/* cleanup must mirror setup */
 			if (ht->cleanup && td->status != HP_THREAD_NONE)
@@ -122,7 +120,6 @@ static int smpboot_thread_fn(void *data)
 		}
 
 		if (kthread_should_park()) {
-			__set_current_state(TASK_RUNNING);
 			preempt_enable();
 			if (ht->park && td->status == HP_THREAD_ACTIVE) {
 				BUG_ON(td->cpu != smp_processor_id());
@@ -139,7 +136,6 @@ static int smpboot_thread_fn(void *data)
 		/* Check for state change setup */
 		switch (td->status) {
 		case HP_THREAD_NONE:
-			__set_current_state(TASK_RUNNING);
 			preempt_enable();
 			if (ht->setup)
 				ht->setup(td->cpu);
@@ -147,7 +143,6 @@ static int smpboot_thread_fn(void *data)
 			continue;
 
 		case HP_THREAD_PARKED:
-			__set_current_state(TASK_RUNNING);
 			preempt_enable();
 			if (ht->unpark)
 				ht->unpark(td->cpu);
@@ -156,10 +151,10 @@ static int smpboot_thread_fn(void *data)
 		}
 
 		if (!ht->thread_should_run(td->cpu)) {
+			set_current_state(TASK_IDLE);
 			preempt_enable_no_resched();
 			schedule();
 		} else {
-			__set_current_state(TASK_RUNNING);
 			preempt_enable();
 			ht->thread_fn(td->cpu);
 		}

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754434AbeD3O0g (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 10:26:36 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34766 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754219AbeD3O0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 10:26:32 -0400
Message-Id: <20180430142235.842920126@infradead.org>
User-Agent: quilt/0.63-1
Date: Mon, 30 Apr 2018 16:17:52 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, oleg@redhat.com, will.deacon@arm.com,
        mpe@ellerman.id.au, bigeasy@linutronix.de, gkohli@codeaurora.org,
        neeraju@codeaurora.org, peterz@infradead.org
Subject: [PATCH 1/2] kthread: Fix kthread_parkme() wait-loop
References: <20180430141751.377491406@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-sched-smpboot-1.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gaurav reported a problem with __kthread_parkme() where a concurrent
try_to_wake_up() could result in competing stores to ->state which,
when the TASK_PARKED store got lost bad things would happen.

The comment near set_current_state() actually mentions this competing
store, but only mentions the case against TASK_RUNNING. This same
store, with different timing, can happen against a subsequent !RUNNING
store.

This normally is not a problem, because as per that same comment, the
!RUNNING state store is inside a condition based wait-loop:

  for (;;) {
    set_current_state(TASK_UNINTERRUPTIBLE);
    if (!need_sleep)
      break;
    schedule();
  }
  __set_current_state(TASK_RUNNING);

If we loose the (first) TASK_UNINTERRUPTIBLE store to a previous
(concurrent) wakeup, the schedule() will NO-OP and we'll go around the
loop once more.

The problem here is that the TASK_PARKED store is not inside the
KTHREAD_SHOULD_PARK condition wait-loop.

There is a genuine issue with sleeps that do not have a condition;
this is addressed in a subsequent patch.

Reported-by: Gaurav Kohli <gkohli@codeaurora.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/kthread.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -177,12 +177,13 @@ void *kthread_probe_data(struct task_str
 
 static void __kthread_parkme(struct kthread *self)
 {
-	__set_current_state(TASK_PARKED);
-	while (test_bit(KTHREAD_SHOULD_PARK, &self->flags)) {
+	for (;;) {
+		set_current_state(TASK_PARKED);
+		if (!test_bit(KTHREAD_SHOULD_PARK, &self->flags))
+			break;
 		if (!test_and_set_bit(KTHREAD_IS_PARKED, &self->flags))
 			complete(&self->parked);
 		schedule();
-		__set_current_state(TASK_PARKED);
 	}
 	clear_bit(KTHREAD_IS_PARKED, &self->flags);
 	__set_current_state(TASK_RUNNING);

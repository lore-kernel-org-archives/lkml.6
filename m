Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751255AbeDYIdj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 04:33:39 -0400
Received: from alexa-out-tai-01.qualcomm.com ([103.229.16.226]:37206 "EHLO
        alexa-out-tai-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750882AbeDYIdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 04:33:36 -0400
X-IronPort-AV: E=Sophos;i="5.49,325,1520870400";
   d="scan'208";a="387776"
X-IronPort-AV: E=McAfee;i="5900,7806,8873"; a="6704111"
From: Gaurav Kohli <gkohli@codeaurora.org>
To: peterz@infradead.org, tglx@linutronix.de, mpe@ellerman.id.au,
        mingo@kernel.org, bigeasy@linutronix.de
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Gaurav Kohli <gkohli@codeaurora.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>
Subject: [PATCH v1] kthread/smpboot: Serialize kthread parking against wakeup
Date: Wed, 25 Apr 2018 14:03:19 +0530
Message-Id: <1524645199-5596-1-git-send-email-gkohli@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The control cpu thread which initiates hotplug calls kthread_park()
for hotplug thread and sets KTHREAD_SHOULD_PARK. After this control
thread wakes up the hotplug thread. There is a chance that wakeup
code sees the hotplug thread (running on AP core) in INTERRUPTIBLE
state, but sets its state to RUNNING after hotplug thread has entered
kthread_parkme() and changed its state to TASK_PARKED. This can result
in panic later on in kthread_unpark(), as it sees KTHREAD_IS_PARKED
flag set but fails to rebind the kthread, due to it being not in
TASK_PARKED state. Fix this, by serializing wakeup state change,
against state change before parking the kthread.

Below is the possible race:

Control thread				      Hotplug Thread

kthread_park()
set KTHREAD_SHOULD_PARK
					      smpboot_thread_fn
					      set_current_state(TASK_INTERRUPTIBLE);
					      kthread_parkme

wake_up_process()

raw_spin_lock_irqsave(&p->pi_lock, flags);
if (!(p->state & state)) -> this will fail
            goto out;

					      __kthread_parkme
					       __set_current_state(TASK_PARKED);

if (p->on_rq && ttwu_remote(p, wake_flags))
    ttwu_remote()
        p->state = TASK_RUNNING;
						schedule();

So to avoid this race, take pi_lock to serial state changes.

Suggested-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
Co-developed-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Gaurav Kohli <gkohli@codeaurora.org>
---

Changes since V1:
- Add comment to explain need of pi_lock.

diff --git a/kernel/smpboot.c b/kernel/smpboot.c
index 5043e74..c5c5184 100644
--- a/kernel/smpboot.c
+++ b/kernel/smpboot.c
@@ -122,7 +122,45 @@ static int smpboot_thread_fn(void *data)
 		}
 
 		if (kthread_should_park()) {
+			/*
+			 * Serialize against wakeup. If we take the lock first,
+			 * wakeup is skipped. If we run later, we observe,
+			 * TASK_RUNNING update from wakeup path, before moving
+			 * forward. This helps avoid the race, where wakeup
+			 * observes TASK_INTERRUPTIBLE, and also observes
+			 * the TASK_PARKED in kthread_parkme() before updating
+			 * task state to TASK_RUNNING. In this case, kthread
+			 * gets parked in TASK_RUNNING state. This results
+			 * in panic later on in kthread_unpark(), as it sees
+			 * KTHREAD_IS_PARKED flag set but fails to rebind the
+			 * kthread, due to it being not in TASK_PARKED state.
+			 *
+			 * Control thread                      Hotplug Thread
+			 *
+			 * kthread_park()
+			 *   set KTHREAD_SHOULD_PARK
+			 *                                smpboot_thread_fn()
+			 *                                set_current_state(
+			 *                                TASK_INTERRUPTIBLE);
+			 *                                kthread_parkme()
+			 *
+			 *   wake_up_process()
+			 *
+			 * raw_spin_lock_irqsave(&p->pi_lock, flags);
+			 * if (!(p->state & state))       __set_current_state(
+			 *            goto out;           TASK_RUNNING);
+			 *
+			 *                                __set_current_state(
+			 *                                TASK_PARKED);
+			 *
+			 * if (p->on_rq && ttwu_remote(p, wake_flags))
+			 *   ttwu_remote()
+			 *     p->state = TASK_RUNNING;
+			 *                                   schedule();
+			 */
+			raw_spin_lock(&current->pi_lock);
 			__set_current_state(TASK_RUNNING);
+			raw_spin_unlock(&current->pi_lock);
 			preempt_enable();
 			if (ht->park && td->status == HP_THREAD_ACTIVE) {
 				BUG_ON(td->cpu != smp_processor_id());
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

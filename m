Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967214AbeEYPy6 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 11:54:58 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:56755 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966293AbeEYPy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 11:54:56 -0400
Date: Fri, 25 May 2018 17:54:41 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4 v2] PM / suspend: Prevent might sleep splats
Message-ID: <20180525155440.jwqrpu3shocwcwjy@linutronix.de>
References: <20180525094648.15464-1-bigeasy@linutronix.de>
 <20180525094648.15464-2-bigeasy@linutronix.de>
 <CAJZ5v0j8zf36HdxH-YR_jTS02tF-BF3w7f9tLjf6UJoqCPG+mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAJZ5v0j8zf36HdxH-YR_jTS02tF-BF3w7f9tLjf6UJoqCPG+mQ@mail.gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

timekeeping suspend/resume calls read_persistent_clock() which takes
rtc_lock. That results in might sleep warnings because at that point
we run with interrupts disabled.

We cannot convert rtc_lock to a raw spinlock as that would trigger
other might sleep warnings.

As a workaround we disable the might sleep warnings by setting
system_state to SYSTEM_SUSPEND before calling sysdev_suspend() and
restoring it to SYSTEM_RUNNING afer sysdev_resume(). There is no lock
contention because hibernate / suspend to RAM is single-CPU at this
point.

In s2idle's case the system_state is set to SYSTEM_SUSPEND before
timekeeping_suspend() which is invoked by the last CPU. In the resume
case it set back to SYSTEM_RUNNING after timekeeping_resume() which is
invoked by the first CPU in the resume case. The other CPUs will block
on tick_freeze_lock.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[bigeasy: cover s2idle in tick_freeze() / tick_unfreeze()]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1…v2: Moved the s2idle case into tick_freeze()/unfreeze() as suggested
       by Rafael (tglx was okay with this).

 include/linux/kernel.h    | 1 +
 kernel/power/hibernate.c  | 7 +++++++
 kernel/power/suspend.c    | 4 ++++
 kernel/time/tick-common.c | 2 ++
 4 files changed, 14 insertions(+)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 6a1eb0b0aad9..7aed92624531 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -542,6 +542,7 @@ extern enum system_states {
 	SYSTEM_HALT,
 	SYSTEM_POWER_OFF,
 	SYSTEM_RESTART,
+	SYSTEM_SUSPEND,
 } system_state;
 
 /* This cannot be an enum because some may be used in assembly source. */
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 5454cc639a8d..9c85c7822383 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -287,6 +287,8 @@ static int create_image(int platform_mode)
 
 	local_irq_disable();
 
+	system_state = SYSTEM_SUSPEND;
+
 	error = syscore_suspend();
 	if (error) {
 		pr_err("Some system devices failed to power down, aborting hibernation\n");
@@ -317,6 +319,7 @@ static int create_image(int platform_mode)
 	syscore_resume();
 
  Enable_irqs:
+	system_state = SYSTEM_RUNNING;
 	local_irq_enable();
 
  Enable_cpus:
@@ -445,6 +448,7 @@ static int resume_target_kernel(bool platform_mode)
 		goto Enable_cpus;
 
 	local_irq_disable();
+	system_state = SYSTEM_SUSPEND;
 
 	error = syscore_suspend();
 	if (error)
@@ -478,6 +482,7 @@ static int resume_target_kernel(bool platform_mode)
 	syscore_resume();
 
  Enable_irqs:
+	system_state = SYSTEM_RUNNING;
 	local_irq_enable();
 
  Enable_cpus:
@@ -563,6 +568,7 @@ int hibernation_platform_enter(void)
 		goto Enable_cpus;
 
 	local_irq_disable();
+	system_state = SYSTEM_SUSPEND;
 	syscore_suspend();
 	if (pm_wakeup_pending()) {
 		error = -EAGAIN;
@@ -575,6 +581,7 @@ int hibernation_platform_enter(void)
 
  Power_up:
 	syscore_resume();
+	system_state = SYSTEM_RUNNING;
 	local_irq_enable();
 
  Enable_cpus:
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 4c10be0f4843..5149c77506b3 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -428,6 +428,8 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
 	arch_suspend_disable_irqs();
 	BUG_ON(!irqs_disabled());
 
+	system_state = SYSTEM_SUSPEND;
+
 	error = syscore_suspend();
 	if (!error) {
 		*wakeup = pm_wakeup_pending();
@@ -443,6 +445,8 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
 		syscore_resume();
 	}
 
+	system_state = SYSTEM_RUNNING;
+
 	arch_suspend_enable_irqs();
 	BUG_ON(irqs_disabled());
 
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 49edc1c4f3e6..14de3727b18e 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -490,6 +490,7 @@ void tick_freeze(void)
 	if (tick_freeze_depth == num_online_cpus()) {
 		trace_suspend_resume(TPS("timekeeping_freeze"),
 				     smp_processor_id(), true);
+		system_state = SYSTEM_SUSPEND;
 		timekeeping_suspend();
 	} else {
 		tick_suspend_local();
@@ -513,6 +514,7 @@ void tick_unfreeze(void)
 
 	if (tick_freeze_depth == num_online_cpus()) {
 		timekeeping_resume();
+		system_state = SYSTEM_RUNNING;
 		trace_suspend_resume(TPS("timekeeping_freeze"),
 				     smp_processor_id(), false);
 	} else {
-- 
2.17.0

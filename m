Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752219AbeCNPnU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:43:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47929 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751452AbeCNPnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:43:18 -0400
Date: Wed, 14 Mar 2018 08:42:49 -0700
From: tip-bot for Lai Jiangshan <tipbot@zytor.com>
Message-ID: <tip-17a2f1ced0280068897990b0dd25ce70555b8ac7@git.kernel.org>
Cc: boris.ostrovsky@oracle.com, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, hpa@zytor.com, tglx@linutronix.de,
        peterz@infradead.org, paulmck@linux.vnet.ibm.com, mingo@kernel.org,
        jiangshanlai@gmail.com
Reply-To: paulmck@linux.vnet.ibm.com, peterz@infradead.org, mingo@kernel.org,
        jiangshanlai@gmail.com, hpa@zytor.com, boris.ostrovsky@oracle.com,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
In-Reply-To: <20171201135008.21633-1-jiangshanlai@gmail.com>
References: <20171201135008.21633-1-jiangshanlai@gmail.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:smp/hotplug] cpu/hotplug: Merge cpuhp_bp_states and
 cpuhp_ap_states
Git-Commit-ID: 17a2f1ced0280068897990b0dd25ce70555b8ac7
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

Commit-ID:  17a2f1ced0280068897990b0dd25ce70555b8ac7
Gitweb:     https://git.kernel.org/tip/17a2f1ced0280068897990b0dd25ce70555b8ac7
Author:     Lai Jiangshan <jiangshanlai@gmail.com>
AuthorDate: Fri, 1 Dec 2017 21:50:05 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 14 Mar 2018 16:38:43 +0100

cpu/hotplug: Merge cpuhp_bp_states and cpuhp_ap_states

cpuhp_bp_states and cpuhp_ap_states have different set of steps without any
conflicting steps, so that they can be merged.

The original `[CPUHP_BRINGUP_CPU] = { },` is removed, because the new
cpuhp_hp_states has CPUHP_ONLINE index which is larger than
CPUHP_BRINGUP_CPU.

Signed-off-by: Lai Jiangshan <jiangshanlai@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Link: https://lkml.kernel.org/r/20171201135008.21633-1-jiangshanlai@gmail.com

---
 kernel/cpu.c | 42 +++++++++++++++---------------------------
 1 file changed, 15 insertions(+), 27 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 53f7dc65f9a3..a1860d42aacf 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -124,8 +124,7 @@ struct cpuhp_step {
 };
 
 static DEFINE_MUTEX(cpuhp_state_mutex);
-static struct cpuhp_step cpuhp_bp_states[];
-static struct cpuhp_step cpuhp_ap_states[];
+static struct cpuhp_step cpuhp_hp_states[];
 
 static bool cpuhp_is_ap_state(enum cpuhp_state state)
 {
@@ -138,10 +137,7 @@ static bool cpuhp_is_ap_state(enum cpuhp_state state)
 
 static struct cpuhp_step *cpuhp_get_step(enum cpuhp_state state)
 {
-	struct cpuhp_step *sp;
-
-	sp = cpuhp_is_ap_state(state) ? cpuhp_ap_states : cpuhp_bp_states;
-	return sp + state;
+	return cpuhp_hp_states + state;
 }
 
 /**
@@ -1224,7 +1220,7 @@ int __boot_cpu_id;
 #endif /* CONFIG_SMP */
 
 /* Boot processor state steps */
-static struct cpuhp_step cpuhp_bp_states[] = {
+static struct cpuhp_step cpuhp_hp_states[] = {
 	[CPUHP_OFFLINE] = {
 		.name			= "offline",
 		.startup.single		= NULL,
@@ -1289,24 +1285,6 @@ static struct cpuhp_step cpuhp_bp_states[] = {
 		.teardown.single	= NULL,
 		.cant_stop		= true,
 	},
-	/*
-	 * Handled on controll processor until the plugged processor manages
-	 * this itself.
-	 */
-	[CPUHP_TEARDOWN_CPU] = {
-		.name			= "cpu:teardown",
-		.startup.single		= NULL,
-		.teardown.single	= takedown_cpu,
-		.cant_stop		= true,
-	},
-#else
-	[CPUHP_BRINGUP_CPU] = { },
-#endif
-};
-
-/* Application processor state steps */
-static struct cpuhp_step cpuhp_ap_states[] = {
-#ifdef CONFIG_SMP
 	/* Final state before CPU kills itself */
 	[CPUHP_AP_IDLE_DEAD] = {
 		.name			= "idle:dead",
@@ -1340,6 +1318,16 @@ static struct cpuhp_step cpuhp_ap_states[] = {
 	[CPUHP_AP_ONLINE] = {
 		.name			= "ap:online",
 	},
+	/*
+	 * Handled on controll processor until the plugged processor manages
+	 * this itself.
+	 */
+	[CPUHP_TEARDOWN_CPU] = {
+		.name			= "cpu:teardown",
+		.startup.single		= NULL,
+		.teardown.single	= takedown_cpu,
+		.cant_stop		= true,
+	},
 	/* Handle smpboot threads park/unpark */
 	[CPUHP_AP_SMPBOOT_THREADS] = {
 		.name			= "smpboot/threads:online",
@@ -1408,11 +1396,11 @@ static int cpuhp_reserve_state(enum cpuhp_state state)
 
 	switch (state) {
 	case CPUHP_AP_ONLINE_DYN:
-		step = cpuhp_ap_states + CPUHP_AP_ONLINE_DYN;
+		step = cpuhp_hp_states + CPUHP_AP_ONLINE_DYN;
 		end = CPUHP_AP_ONLINE_DYN_END;
 		break;
 	case CPUHP_BP_PREPARE_DYN:
-		step = cpuhp_bp_states + CPUHP_BP_PREPARE_DYN;
+		step = cpuhp_hp_states + CPUHP_BP_PREPARE_DYN;
 		end = CPUHP_BP_PREPARE_DYN_END;
 		break;
 	default:

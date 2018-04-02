Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754130AbeDBJDj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 05:03:39 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38057 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752011AbeDBJDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 05:03:38 -0400
X-Google-Smtp-Source: AIpwx4+hQoN16c0VrBXsLkxNHTNtcYOCh1fPvJCwN0j/+la2GCokesYdVDj1PXPmlCwcXdl8LUocyg==
Date: Mon, 2 Apr 2018 11:03:34 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] SMP hotplug changes for v4.17
Message-ID: <20180402090334.45ekwthhshuz3mf6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest smp-hotplug-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-hotplug-for-linus

   # HEAD: fcb3029a8d89487470f2e175645a9a993949233c cpu/hotplug: Fix unused function warning

Simplify the CPU hot-plug state machine.

 Thanks,

	Ingo

------------------>
Arnd Bergmann (1):
      cpu/hotplug: Fix unused function warning

Lai Jiangshan (1):
      cpu/hotplug: Merge cpuhp_bp_states and cpuhp_ap_states


 kernel/cpu.c | 60 ++++++++++++++++++++++++------------------------------------
 1 file changed, 24 insertions(+), 36 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 53f7dc65f9a3..0db8938fbb23 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -124,24 +124,11 @@ struct cpuhp_step {
 };
 
 static DEFINE_MUTEX(cpuhp_state_mutex);
-static struct cpuhp_step cpuhp_bp_states[];
-static struct cpuhp_step cpuhp_ap_states[];
-
-static bool cpuhp_is_ap_state(enum cpuhp_state state)
-{
-	/*
-	 * The extra check for CPUHP_TEARDOWN_CPU is only for documentation
-	 * purposes as that state is handled explicitly in cpu_down.
-	 */
-	return state > CPUHP_BRINGUP_CPU && state != CPUHP_TEARDOWN_CPU;
-}
+static struct cpuhp_step cpuhp_hp_states[];
 
 static struct cpuhp_step *cpuhp_get_step(enum cpuhp_state state)
 {
-	struct cpuhp_step *sp;
-
-	sp = cpuhp_is_ap_state(state) ? cpuhp_ap_states : cpuhp_bp_states;
-	return sp + state;
+	return cpuhp_hp_states + state;
 }
 
 /**
@@ -239,6 +226,15 @@ static int cpuhp_invoke_callback(unsigned int cpu, enum cpuhp_state state,
 }
 
 #ifdef CONFIG_SMP
+static bool cpuhp_is_ap_state(enum cpuhp_state state)
+{
+	/*
+	 * The extra check for CPUHP_TEARDOWN_CPU is only for documentation
+	 * purposes as that state is handled explicitly in cpu_down.
+	 */
+	return state > CPUHP_BRINGUP_CPU && state != CPUHP_TEARDOWN_CPU;
+}
+
 static inline void wait_for_ap_thread(struct cpuhp_cpu_state *st, bool bringup)
 {
 	struct completion *done = bringup ? &st->done_up : &st->done_down;
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

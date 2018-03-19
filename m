Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754951AbeCSEPa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 00:15:30 -0400
Received: from mga18.intel.com ([134.134.136.126]:41503 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751084AbeCSEP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 00:15:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,328,1517904000";
   d="scan'208";a="36111795"
From: Yu Chen <yu.c.chen@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Rui Zhang <rui.zhang@intel.com>, Lukas Wunner <lukas@wunner.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH][v4] PM / sleep: Do not delay the synchronization of MTRR during resume
Date: Mon, 19 Mar 2018 12:18:43 +0800
Message-Id: <20180319041843.28218-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Yu <yu.c.chen@intel.com>

Sometimes it is too late for the APs to adjust their MTRRs
to the valid ones saved before suspend - currently this
action is performed by set_mtrr_state() after all the APs
have been brought up. In some cases the BIOS might scribble
the MTRR across suspend, as a result we might get invalid
MTRR after resumed back, thus every instruction runs on
this AP would be extremely slow if it happended to be a
'uncached' MTRR. It is necessary to synchronize the MTRR
as early as possible to get it fixed during each AP's
online - this is what this patch does.

Moreover, since we have put the synchronization earlier, there is
a side effect that, during each AP's online, the previous APs already
been brought up will be forced to run mtrr_rendezvous_handler() and
reprogram the MTRR again and again. This symptom can be mitigated
by checking if this cpu has already run the synchronization
during the enable_nonboot_cpus() stage, if it is, we can safely
bypass the reprogramming action. (We can not bypass the
mtrr_rendezvous_handler(), because the other online cpus must be
stopped running the VMX transaction while one cpu is updating
its MTRR, which is described here:
Commit d0af9eed5aa9 ("x86, pat/mtrr: Rendezvous all the cpus for
MTRR/PAT init")

This patch does not impact the normal boot up nor cpu hotplug.

On a platform with invalid MTRR after resumed,
1. before this patch:
   [  619.810899] Enabling non-boot CPUs ...
   [  619.825537] smpboot: Booting Node 0 Processor 1 APIC 0x2
   [  621.723809] CPU1 is up
   [  621.840228] smpboot: Booting Node 0 Processor 3 APIC 0x3
   [  626.690900] CPU3 is up

It took cpu1 621.723809 - 619.825537 = 1898.272 ms, and
cpu3 626.690900 - 621.840228 = 4850.672 ms.

2. after this patch:
   [  106.931790] smpboot: Booting Node 0 Processor 1 APIC 0x2
   [  106.948360] CPU1 is up
   [  106.986534] smpboot: Booting Node 0 Processor 3 APIC 0x3
   [  106.990702] CPU3 is up

It took cpu1 106.948360 - 106.931790 = 16.57 ms, and
cpu3 106.990702 - 106.986534 = 4.16 ms.

For comparison, suspend on a 88 cpus Xeon Broadwell
platform is also tested, and the result shows that
with this patch applied, the overall APs online time has
decreased a little bit, this is because since the synchronizing
of MTRR has been performed earlier, the MTRRs get updated
to the correct value earlier.

Tested 5 times, data illustrated below:

1. before this patch:

[   64.549430] Enabling non-boot CPUs ...
[   66.253304] End enabling non-boot CPUs
overall cpu online: 1.703874 second

[   62.159063] Enabling non-boot CPUs ...
[   64.483443] End enabling non-boot CPUs
overall cpu online: 2.32438 second

[   58.351449] Enabling non-boot CPUs ...
[   60.796951] End enabling non-boot CPUs
overall cpu online: 2.445502 second

[   64.491317] Enabling non-boot CPUs ...
[   66.996208] End enabling non-boot CPUs
overall cpu online: 2.504891 second

[   60.593235] Enabling non-boot CPUs ...
[   63.397886] End enabling non-boot CPUs
overall cpu online: 2.804651 second

Average: 2.3566596 second

2. after this patch:

[   66.077368] Enabling non-boot CPUs ...
[   68.343374] End enabling non-boot CPUs
overall cpu online: 2.266006 second

[   64.594605] Enabling non-boot CPUs ...
[   66.092688] End enabling non-boot CPUs
overall cpu online: 1.498083 second

[   64.778546] Enabling non-boot CPUs ...
[   66.277577] End enabling non-boot CPUs
overall cpu online: 1.499031 second

[   63.773091] Enabling non-boot CPUs ...
[   65.601637] End enabling non-boot CPUs
overall cpu online: 1.828546 second

[   64.638855] Enabling non-boot CPUs ...
[   66.327098] End enabling non-boot CPUs
overall cpu online: 1.688243 second

Average: 1.7559818 second

With the patch applied, the cpu online time during resume
has decreased by about 6 seconds on a bogus MTRR platform,
and decreased by about 600ms on a 88 cpus Xeon platform after
resumed.

Quote from Lukas:
"Just for the record, this series cuts down resume time from system sleep
by 4-5 seconds on my MacBookPro9,1.  Great work, looking forward to this
being respun and merged."

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Rui Zhang <rui.zhang@intel.com>
Tested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 arch/x86/include/asm/mtrr.h     |  2 ++
 arch/x86/kernel/cpu/mtrr/main.c | 29 ++++++++++++++++++++++++++---
 arch/x86/kernel/smpboot.c       |  4 ++--
 3 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index dbff1456d215..182cc96f79cb 100644
--- a/arch/x86/include/asm/mtrr.h
+++ b/arch/x86/include/asm/mtrr.h
@@ -49,6 +49,7 @@ extern void mtrr_aps_init(void);
 extern void mtrr_bp_restore(void);
 extern int mtrr_trim_uncached_memory(unsigned long end_pfn);
 extern int amd_special_default_mtrr(void);
+extern void set_mtrr_aps_check(bool enable);
 #  else
 static inline u8 mtrr_type_lookup(u64 addr, u64 end, u8 *uniform)
 {
@@ -93,6 +94,7 @@ static inline void mtrr_bp_init(void)
 #define set_mtrr_aps_delayed_init() do {} while (0)
 #define mtrr_aps_init() do {} while (0)
 #define mtrr_bp_restore() do {} while (0)
+#define set_mtrr_aps_check(enable) do {} while (0)
 #  endif
 
 #ifdef CONFIG_COMPAT
diff --git a/arch/x86/kernel/cpu/mtrr/main.c b/arch/x86/kernel/cpu/mtrr/main.c
index 7468de429087..e3e92f41d2b6 100644
--- a/arch/x86/kernel/cpu/mtrr/main.c
+++ b/arch/x86/kernel/cpu/mtrr/main.c
@@ -59,6 +59,7 @@
 #define MTRR_TO_PHYS_WC_OFFSET 1000
 
 u32 num_var_ranges;
+static bool mtrr_aps_check;
 static bool __mtrr_enabled;
 
 static bool mtrr_enabled(void)
@@ -66,6 +67,11 @@ static bool mtrr_enabled(void)
 	return __mtrr_enabled;
 }
 
+void set_mtrr_aps_check(bool enable)
+{
+	mtrr_aps_check = enable;
+}
+
 unsigned int mtrr_usage_table[MTRR_MAX_VAR_RANGES];
 static DEFINE_MUTEX(mtrr_mutex);
 
@@ -148,6 +154,7 @@ struct set_mtrr_data {
 	unsigned long	smp_size;
 	unsigned int	smp_reg;
 	mtrr_type	smp_type;
+	int		smp_cpu;
 };
 
 /**
@@ -178,6 +185,19 @@ static int mtrr_rendezvous_handler(void *info)
 		mtrr_if->set(data->smp_reg, data->smp_base,
 			     data->smp_size, data->smp_type);
 	} else if (mtrr_aps_delayed_init || !cpu_online(smp_processor_id())) {
+		/*
+		 * Reduce redundancy by only syncing the cpu
+		 * who has issued the sync request during resumed:
+		 * start_secondary() ->
+		 *  smp_callin() ->
+		 *   smp_store_cpu_info() ->
+		 *    identify_secondary_cpu() ->
+		 *     mtrr_ap_init() ->
+		 *      set_mtrr_from_inactive_cpu(smp_processor_id())
+		 */
+		if (mtrr_aps_check &&
+		    data->smp_cpu != smp_processor_id())
+			return 0;
 		mtrr_if->set_all();
 	}
 	return 0;
@@ -231,7 +251,8 @@ set_mtrr(unsigned int reg, unsigned long base, unsigned long size, mtrr_type typ
 	struct set_mtrr_data data = { .smp_reg = reg,
 				      .smp_base = base,
 				      .smp_size = size,
-				      .smp_type = type
+				      .smp_type = type,
+				      .smp_cpu = smp_processor_id()
 				    };
 
 	stop_machine(mtrr_rendezvous_handler, &data, cpu_online_mask);
@@ -243,7 +264,8 @@ static void set_mtrr_cpuslocked(unsigned int reg, unsigned long base,
 	struct set_mtrr_data data = { .smp_reg = reg,
 				      .smp_base = base,
 				      .smp_size = size,
-				      .smp_type = type
+				      .smp_type = type,
+				      .smp_cpu = smp_processor_id()
 				    };
 
 	stop_machine_cpuslocked(mtrr_rendezvous_handler, &data, cpu_online_mask);
@@ -255,7 +277,8 @@ static void set_mtrr_from_inactive_cpu(unsigned int reg, unsigned long base,
 	struct set_mtrr_data data = { .smp_reg = reg,
 				      .smp_base = base,
 				      .smp_size = size,
-				      .smp_type = type
+				      .smp_type = type,
+				      .smp_cpu = smp_processor_id()
 				    };
 
 	stop_machine_from_inactive_cpu(mtrr_rendezvous_handler, &data,
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index ff99e2b6fc54..aff560e7cd86 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1261,12 +1261,12 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 
 void arch_enable_nonboot_cpus_begin(void)
 {
-	set_mtrr_aps_delayed_init();
+	set_mtrr_aps_check(true);
 }
 
 void arch_enable_nonboot_cpus_end(void)
 {
-	mtrr_aps_init();
+	set_mtrr_aps_check(false);
 }
 
 /*
-- 
2.13.6

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753081AbeBSPSk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 10:18:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35126 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753041AbeBSPSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 10:18:36 -0500
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com, mpe@ellerman.id.au, stewart@linux.vnet.ibm.com,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [PATCH] cpuidle/powernv : Restore different PSSCR for idle and hotplug
Date: Mon, 19 Feb 2018 20:48:20 +0530
X-Mailer: git-send-email 2.5.5
X-TM-AS-GCONF: 00
x-cbid: 18021915-0040-0000-0000-0000043543F8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021915-0041-0000-0000-000020D7501B
Message-Id: <1519053500-31860-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-19_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802190189
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 1e1601b38e6e ("powerpc/powernv/idle: Restore SPRs for deep idle
states via stop API.") uses stop-api provided by the firmware to restore
PSSCR. PSSCR restore is required for handling special wakeup. When special
wakeup is completed, the core enters stop state based on restored PSSCR.

Currently PSSCR is restored to deepest available stop state, causing
a idle cpu to enter deeper stop state on a special wakeup, which causes
the cpu to hang on wakeup.

A "sensors" command which reads temperature (through DTS sensors) on idle
cpu can trigger special wakeup.

Failed Scenario :
Request restore of PSSCR with RL = 11
cpu enters idle state (stop5)
  user triggers "sensors" command
   Assert special wakeup on cpu
     Restores PSSCR with RL = 11  <---- Done by firmware
      Read DTS sensor
   Deassert special wakeup
  cpu enters idle state (stop11) <-- Instead of stop5

Cpu hang is caused because cpu ended up in a deeper state than it requested

This patch fixes instability caused by special wakeup when stop11 is
enabled. Requests restore of PSSCR to deepest stop state used by cpuidle.
Only when offlining cpu, request restore of PSSCR to deepest stop state.
On onlining cpu, request restore of PSSCR to deepest stop state used by
cpuidle.

Fixes : 1e1601b38e6e ("powerpc/powernv/idle: Restore SPRs for deep idle
states via stop API.")
Reported-by: Pridhiviraj Paidipeddi <ppaidipe@linux.vnet.ibm.com>
Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/cpuidle.h    |  2 ++
 arch/powerpc/platforms/powernv/idle.c | 46 ++++++++++++++++++++++++++++++++---
 drivers/cpuidle/cpuidle-powernv.c     |  1 -
 3 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
index e210a83..f52e9f1 100644
--- a/arch/powerpc/include/asm/cpuidle.h
+++ b/arch/powerpc/include/asm/cpuidle.h
@@ -67,6 +67,8 @@
 #define ERR_EC_ESL_MISMATCH		-1
 #define ERR_DEEP_STATE_ESL_MISMATCH	-2
 
+#define POWERNV_THRESHOLD_LATENCY_NS 200000
+
 #ifndef __ASSEMBLY__
 /* Additional SPRs that need to be saved/restored during stop */
 struct stop_sprs {
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 443d5ca..4b0c7d24 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -56,8 +56,11 @@ u64 pnv_first_deep_stop_state = MAX_STOP_STATE;
  */
 static u64 pnv_deepest_stop_psscr_val;
 static u64 pnv_deepest_stop_psscr_mask;
+static u64 pnv_deepest_cpuidle_psscr_val;
+static u64 pnv_deepest_cpuidle_psscr_mask;
 static u64 pnv_deepest_stop_flag;
 static bool deepest_stop_found;
+static bool deepest_cpuidle_found;
 
 static int pnv_save_sprs_for_deep_states(void)
 {
@@ -76,7 +79,14 @@ static int pnv_save_sprs_for_deep_states(void)
 	uint64_t hid5_val = mfspr(SPRN_HID5);
 	uint64_t hmeer_val = mfspr(SPRN_HMEER);
 	uint64_t msr_val = MSR_IDLE;
-	uint64_t psscr_val = pnv_deepest_stop_psscr_val;
+
+	/*
+	 * Pick deepest cpuidle psscr as the value to be
+	 * restored through wakeup engine.
+	 * We will request a deeper state to be restored
+	 * in hotplug path
+	 */
+	uint64_t psscr_val = pnv_deepest_cpuidle_psscr_val;
 
 	for_each_possible_cpu(cpu) {
 		uint64_t pir = get_hard_smp_processor_id(cpu);
@@ -409,7 +419,7 @@ static void pnv_program_cpu_hotplug_lpcr(unsigned int cpu, u64 lpcr_val)
  */
 unsigned long pnv_cpu_offline(unsigned int cpu)
 {
-	unsigned long srr1;
+	u64 srr1;
 	u32 idle_states = pnv_get_supported_cpuidle_states();
 	u64 lpcr_val;
 
@@ -429,12 +439,18 @@ unsigned long pnv_cpu_offline(unsigned int cpu)
 	__ppc64_runlatch_off();
 
 	if (cpu_has_feature(CPU_FTR_ARCH_300) && deepest_stop_found) {
-		unsigned long psscr;
+		u64 psscr;
+		u64 pir = get_hard_smp_processor_id(cpu);
 
 		psscr = mfspr(SPRN_PSSCR);
 		psscr = (psscr & ~pnv_deepest_stop_psscr_mask) |
 						pnv_deepest_stop_psscr_val;
+		if (pnv_deepest_stop_psscr_val != pnv_deepest_cpuidle_psscr_val)
+			opal_slw_set_reg(pir, P9_STOP_SPR_PSSCR, psscr);
 		srr1 = power9_idle_stop(psscr);
+		psscr = (psscr & ~pnv_deepest_cpuidle_psscr_mask) |
+						pnv_deepest_cpuidle_psscr_val;
+		opal_slw_set_reg(pir, P9_STOP_SPR_PSSCR, psscr);
 
 	} else if ((idle_states & OPAL_PM_WINKLE_ENABLED) &&
 		   (idle_states & OPAL_PM_LOSE_FULL_CONTEXT)) {
@@ -555,6 +571,7 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
 	u64 *psscr_val = NULL;
 	u64 *psscr_mask = NULL;
 	u32 *residency_ns = NULL;
+	u32 *latency_ns = NULL;
 	u64 max_residency_ns = 0;
 	int rc = 0, i;
 
@@ -562,6 +579,8 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
 	psscr_mask = kcalloc(dt_idle_states, sizeof(*psscr_mask), GFP_KERNEL);
 	residency_ns = kcalloc(dt_idle_states, sizeof(*residency_ns),
 			       GFP_KERNEL);
+	latency_ns = kcalloc(dt_idle_states, sizeof(*latency_ns),
+			     GFP_KERNEL);
 
 	if (!psscr_val || !psscr_mask || !residency_ns) {
 		rc = -1;
@@ -591,6 +610,13 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
 		rc = -1;
 		goto out;
 	}
+	if (of_property_read_u32_array(np,
+				       "ibm,cpu-idle-state-latencies-ns",
+					latency_ns, dt_idle_states)) {
+		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-latency-ns in DT\n");
+		rc = -1;
+		goto out;
+	}
 
 	/*
 	 * Set pnv_first_deep_stop_state, pnv_deepest_stop_psscr_{val,mask},
@@ -621,6 +647,12 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
 			continue;
 		}
 
+		if (latency_ns[i] <= POWERNV_THRESHOLD_LATENCY_NS) {
+			pnv_deepest_cpuidle_psscr_val = psscr_val[i];
+			pnv_deepest_cpuidle_psscr_mask = psscr_mask[i];
+			deepest_cpuidle_found = true;
+		}
+
 		if (max_residency_ns < residency_ns[i]) {
 			max_residency_ns = residency_ns[i];
 			pnv_deepest_stop_psscr_val = psscr_val[i];
@@ -653,6 +685,14 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
 			pnv_deepest_stop_psscr_mask);
 	}
 
+	if (unlikely(!deepest_cpuidle_found)) {
+		pr_warn("cpuidle-powernv: No suitable deepest CPU-idle state found");
+	} else {
+		pr_info("cpuidle-powernv: Deepest cpuidle: psscr = 0x%016llx,mask=0x%016llx\n",
+			pnv_deepest_cpuidle_psscr_val,
+			pnv_deepest_cpuidle_psscr_mask);
+	}
+
 	pr_info("cpuidle-powernv: Requested Level (RL) value of first deep stop = 0x%llx\n",
 		pnv_first_deep_stop_state);
 out:
diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 1a8234e..620765d 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -26,7 +26,6 @@
  * Expose only those Hardware idle states via the cpuidle framework
  * that have latency value below POWERNV_THRESHOLD_LATENCY_NS.
  */
-#define POWERNV_THRESHOLD_LATENCY_NS 200000
 
 static struct cpuidle_driver powernv_idle_driver = {
 	.name             = "powernv_idle",
-- 
2.5.5

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932719AbeEaCxe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 22:53:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59190 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932620AbeEaCxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 22:53:32 -0400
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: stewart@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com,
        ego@linux.vnet.ibm.com, mpe@ellerman.id.au,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [PATCH] [SCHEME 2]powernv/cpuidle: Add support for new idle state device-tree format
Date: Thu, 31 May 2018 08:23:20 +0530
X-Mailer: git-send-email 2.5.5
X-TM-AS-GCONF: 00
x-cbid: 18053102-0008-0000-0000-000002423072
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18053102-0009-0000-0000-000021A7D97E
Message-Id: <1527735200-24653-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-30_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1805310029
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for new device-tree format for idle state
description.

Previously if a older kernel runs on a newer firmware, it may enable
all available states irrespective of its capability of handling it.
New device tree format adds a compatible flag, so that only kernel
which has the capability to handle the version of stop state will enable
it.

Older kernel will still see stop0 and stop0_lite in older format and we
will depricate it after some time.

Idea is to bump up the version in firmware if we find a bug or
regression in stop states. A fix will be provided in linux which would
now know about the bumped up version of stop states, where as kernel
without fixes would ignore the states.

New idle state device tree format :

    power-mgt {
        ibm,cpu-idle-state-names = "stop0_lite", "stop0";
        ibm,cpu-idle-state-residency-ns = <0x2710 0x4e20>;
        ibm,cpu-idle-state-latencies-ns = <0x3e8 0x7d0>;
        ibm,cpu-idle-state-psscr-mask = <0x0 0x3003ff 0x0 0x3003ff>;
        ibm,cpu-idle-state-psscr = <0x0 0x330 0x0 0x300330>;
        ibm,cpu-idle-state-flags = <0x100000 0x101000>;
        ibm,enabled-stop-levels = <0xec000000>;
        ibm,idle-states {
          ibm,cpu-idle-state-names = "stop1", "stop2", "stop4", "stop5";
          ibm,cpu-idle-state-residency-ns = <0xc350 0x186a0 0x989680
    0x1312d00>;
          ibm,cpu-idle-state-latencies-ns = <0x1388 0x2710 0x186a0
    0x30d40>;
          ibm,cpu-idle-state-psscr-mask = <0x0 0x3003ff 0x0 0x3003ff 0x0
    0x3003ff 0x0 0x3003ff>;
          ibm,cpu-idle-state-psscr = <0x0 0x300331 0x0 0x300332 0x0
    0x300374 0x0 0x300375>;
          ibm,cpu-idle-state-versions = "ibm,idle-state-v1
    ", "ibm,idle-state-v1", "ibm,idle-state-v1", "ibm,idle-state-v1";
          ibm,cpu-idle-state-flags = <0x101000 0x101000 0x207000
0x207000>;
       }
     }

Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/idle.c | 60 ++++++++++++++++++++++++++------
 drivers/cpuidle/cpuidle-powernv.c     | 65 +++++++++++++++++++++++++++++++++--
 2 files changed, 112 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 1f12ab1..ab52665 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -622,8 +622,8 @@ int validate_psscr_val_mask(u64 *psscr_val, u64 *psscr_mask, u32 flags)
  * @dt_idle_states: Number of idle state entries
  * Returns 0 on success
  */
-static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
-					int dt_idle_states)
+static int __init pnv_power9_idle_init(struct device_node *np, struct device_node *np_new,u32 *flags,
+					int dt_idle_states, int additional_states)
 {
 	u64 *psscr_val = NULL;
 	u64 *psscr_mask = NULL;
@@ -631,9 +631,10 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
 	u64 max_residency_ns = 0;
 	int rc = 0, i;
 
-	psscr_val = kcalloc(dt_idle_states, sizeof(*psscr_val), GFP_KERNEL);
-	psscr_mask = kcalloc(dt_idle_states, sizeof(*psscr_mask), GFP_KERNEL);
-	residency_ns = kcalloc(dt_idle_states, sizeof(*residency_ns),
+	/* TODO: remove ugliness of using additional_states count*/
+	psscr_val = kcalloc(dt_idle_states+additional_states, sizeof(*psscr_val), GFP_KERNEL);
+	psscr_mask = kcalloc(dt_idle_states+additional_states, sizeof(*psscr_mask), GFP_KERNEL);
+	residency_ns = kcalloc(dt_idle_states+additional_states, sizeof(*residency_ns),
 			       GFP_KERNEL);
 
 	if (!psscr_val || !psscr_mask || !residency_ns) {
@@ -648,6 +649,13 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
 		rc = -1;
 		goto out;
 	}
+	if (of_property_read_u64_array(np_new,
+		"ibm,cpu-idle-state-psscr",
+		psscr_val + dt_idle_states, additional_states)) {
+		pr_warn("cpuidle-powernv: missing addtional ibm,cpu-idle-state-psscr in DT\n");
+		rc = -1;
+		goto out;
+	}
 
 	if (of_property_read_u64_array(np,
 				       "ibm,cpu-idle-state-psscr-mask",
@@ -656,6 +664,13 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
 		rc = -1;
 		goto out;
 	}
+	if (of_property_read_u64_array(np_new,
+				       "ibm,cpu-idle-state-psscr-mask",
+				       psscr_mask + dt_idle_states, additional_states)) {
+		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-psscr-mask in DT\n");
+		rc = -1;
+		goto out;
+	}
 
 	if (of_property_read_u32_array(np,
 				       "ibm,cpu-idle-state-residency-ns",
@@ -664,7 +679,13 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
 		rc = -1;
 		goto out;
 	}
-
+	if (of_property_read_u32_array(np_new,
+				       "ibm,cpu-idle-state-residency-ns",
+					residency_ns + dt_idle_states,additional_states)) {
+		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-residency-ns in DT\n");
+		rc = -1;
+		goto out;
+	}
 	/*
 	 * Set pnv_first_deep_stop_state, pnv_deepest_stop_psscr_{val,mask},
 	 * and the pnv_default_stop_{val,mask}.
@@ -679,7 +700,7 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
 	 * the shallowest (OPAL_PM_STOP_INST_FAST) loss-less stop state.
 	 */
 	pnv_first_deep_stop_state = MAX_STOP_STATE;
-	for (i = 0; i < dt_idle_states; i++) {
+	for (i = 0; i < dt_idle_states+additional_states; i++) {
 		int err;
 		u64 psscr_rl = psscr_val[i] & PSSCR_RL_MASK;
 
@@ -740,10 +761,11 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
  */
 static void __init pnv_probe_idle_states(void)
 {
-	struct device_node *np;
+	struct device_node *np,*np_new;
 	int dt_idle_states;
 	u32 *flags = NULL;
 	int i;
+	int additional_states=0;
 
 	np = of_find_node_by_path("/ibm,opal/power-mgt");
 	if (!np) {
@@ -756,21 +778,37 @@ static void __init pnv_probe_idle_states(void)
 		pr_warn("cpuidle-powernv: no idle states found in the DT\n");
 		goto out;
 	}
+	/* Support new device tree */
+	np_new = of_find_node_by_path("/ibm,opal/power-mgt/ibm,idle-states");
+	if (!np_new) {
+		pr_info("opal: PowerMgmt/ibm,idle-states Node not found\n");
+	} else {
+		additional_states = of_property_count_u32_elems(np_new,
+			"ibm,cpu-idle-state-flags");
+		if (additional_states < 0) 
+			pr_info("cpuidle-powernv: no idle states found in the DT\n");
+	}
 
-	flags = kcalloc(dt_idle_states, sizeof(*flags),  GFP_KERNEL);
+	flags = kcalloc(dt_idle_states + additional_states, sizeof(*flags),  GFP_KERNEL);
 
 	if (of_property_read_u32_array(np,
 			"ibm,cpu-idle-state-flags", flags, dt_idle_states)) {
 		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-flags in DT\n");
 		goto out;
 	}
+	if (of_property_read_u32_array(np_new,
+			"ibm,cpu-idle-state-flags", flags + dt_idle_states, additional_states)) {
+		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-flags in DT\n");
+		goto out;
+	}
+
 
 	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
-		if (pnv_power9_idle_init(np, flags, dt_idle_states))
+		if (pnv_power9_idle_init(np, np_new, flags, dt_idle_states,additional_states))
 			goto out;
 	}
 
-	for (i = 0; i < dt_idle_states; i++)
+	for (i = 0; i < dt_idle_states+additional_states; i++)
 		supported_cpuidle_states |= flags[i];
 
 out:
diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 1a8234e..8060a96 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -241,9 +241,9 @@ static inline int validate_dt_prop_sizes(const char *prop1, int prop1_len,
 extern u32 pnv_get_supported_cpuidle_states(void);
 static int powernv_add_idle_states(void)
 {
-	struct device_node *power_mgt;
+	struct device_node *power_mgt,*np_new;
 	int nr_idle_states = 1; /* Snooze */
-	int dt_idle_states, count;
+	int dt_idle_states, count, additional_states;
 	u32 latency_ns[CPUIDLE_STATE_MAX];
 	u32 residency_ns[CPUIDLE_STATE_MAX];
 	u32 flags[CPUIDLE_STATE_MAX];
@@ -365,6 +365,62 @@ static int powernv_add_idle_states(void)
 						residency_ns, dt_idle_states);
 	}
 
+	/* Support new dt format for idle states */
+
+	np_new = of_find_node_by_path("/ibm,opal/power-mgt/ibm,idle-states");
+	if (!np_new) {
+		pr_info("opal: PowerMgmt/ibm,idle-states Node not found\n");
+	} else {
+		additional_states = of_property_count_u32_elems(np_new,
+			"ibm,cpu-idle-state-flags");
+		if (additional_states < 0) 
+			pr_info("cpuidle-powernv: no idle states found in the DT\n");
+		else {
+			if (of_property_read_u32_array(np_new,
+				"ibm,cpu-idle-state-flags", flags+dt_idle_states, additional_states)) {
+				pr_warn("cpuidle-powernv : missing ibm,cpu-idle-state-flags in DT\n");
+				goto out;
+			}
+
+			if (of_property_read_u32_array(np_new,
+				"ibm,cpu-idle-state-latencies-ns", latency_ns+dt_idle_states,
+				additional_states)) {
+				pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-latencies-ns in DT\n");
+				goto out;
+			}
+			if (of_property_read_u32_array(np_new,
+				"ibm,cpu-idle-state-residencies-ns", residency_ns+dt_idle_states,
+				additional_states)) {
+				pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-residencies-ns in DT\n");
+				goto out;
+			}
+			if (of_property_read_string_array(np_new,
+				"ibm,cpu-idle-state-names", names+dt_idle_states, additional_states) < 0) {
+				pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-names in DT\n");
+				goto out;
+			}
+			if (of_property_read_string_array(np_new,
+				"ibm,cpu-idle-state-versions", versions, additional_states) < 0) {
+				pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-names in DT\n");
+				goto out;
+			}
+			if (of_property_read_u64_array(np_new,
+			    "ibm,cpu-idle-state-psscr", psscr_val+ dt_idle_states, additional_states)) {
+				pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-psscr in DT\n");
+				goto out;
+			}
+
+			if (of_property_read_u64_array(power_mgt,
+					       "ibm,cpu-idle-state-psscr-mask",
+						psscr_mask + dt_idle_states,additional_states)) {
+				pr_warn("cpuidle-powernv:Missing ibm,cpu-idle-state-psscr-mask in DT\n");
+				goto out;
+			}
+		
+
+			dt_idle_states += additional_states;
+		}
+	}
 	for (i = 0; i < dt_idle_states; i++) {
 		unsigned int exit_latency, target_residency;
 		bool stops_timebase = false;
@@ -375,6 +431,11 @@ static int powernv_add_idle_states(void)
 		 */
 		if ((flags[i] & supported_flags) != flags[i])
 			continue;
+
+		/* Supported version */
+		if (!( strcmp(version[i] , "ibm,idle-state-v1"))
+				continue;
+				
 		/*
 		 * If an idle state has exit latency beyond
 		 * POWERNV_THRESHOLD_LATENCY_NS then don't use it
-- 
2.5.5

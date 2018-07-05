Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A073EC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4B124052
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:41:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D4B124052
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754220AbeGELlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 07:41:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47262 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754119AbeGELkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 07:40:53 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w65BcsoV071304
        for <linux-kernel@vger.kernel.org>; Thu, 5 Jul 2018 07:40:53 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k1jehgnj8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 07:40:53 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akshay.adiga@linux.vnet.ibm.com>;
        Thu, 5 Jul 2018 12:40:50 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 5 Jul 2018 12:40:47 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w65BekOF4128892
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Jul 2018 11:40:47 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99CE84C050;
        Thu,  5 Jul 2018 14:41:11 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5AD8C4C058;
        Thu,  5 Jul 2018 14:41:09 +0100 (BST)
Received: from aksadiga.ibm (unknown [9.195.33.98])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  5 Jul 2018 14:41:09 +0100 (BST)
From:   Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-pm@vger.kernel.org
Cc:     rjw@rjwysocki.net, stewart@linux.vnet.ibm.com,
        benh@kernel.crashing.org, svaidy@linux.vnet.ibm.com,
        ego@linux.vnet.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [PATCH v4 1/2] powernv/cpuidle: Parse dt idle properties into global structure
Date:   Thu,  5 Jul 2018 17:10:21 +0530
X-Mailer: git-send-email 2.18.0.rc2.85.g1fb9df7
In-Reply-To: <20180705114022.19285-1-akshay.adiga@linux.vnet.ibm.com>
References: <20180705114022.19285-1-akshay.adiga@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18070511-0020-0000-0000-000002A35C16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070511-0021-0000-0000-000020EF827F
Message-Id: <20180705114022.19285-2-akshay.adiga@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-05_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807050137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device-tree parsing happens twice, once while deciding idle state to be
used for hotplug and once during cpuidle init. Hence, parsing the device
tree and caching it will reduce code duplication. Parsing code has been
moved to pnv_parse_cpuidle_dt() from pnv_probe_idle_states(). In addition
to the properties in the device tree the number of available states is
also required.

Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/cpuidle.h    |  11 ++
 arch/powerpc/platforms/powernv/idle.c | 216 ++++++++++++++++----------
 2 files changed, 149 insertions(+), 78 deletions(-)

diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
index e210a83eb196..574b0ce1d671 100644
--- a/arch/powerpc/include/asm/cpuidle.h
+++ b/arch/powerpc/include/asm/cpuidle.h
@@ -79,6 +79,17 @@ struct stop_sprs {
 	u64 mmcra;
 };
 
+#define PNV_IDLE_NAME_LEN    16
+struct pnv_idle_states_t {
+	char name[PNV_IDLE_NAME_LEN];
+	u32 latency_ns;
+	u32 residency_ns;
+	u64 psscr_val;
+	u64 psscr_mask;
+	u32 flags;
+	bool valid;
+};
+
 extern u32 pnv_fastsleep_workaround_at_entry[];
 extern u32 pnv_fastsleep_workaround_at_exit[];
 
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 1c5d0675b43c..7cf71b3e03a1 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -36,6 +36,8 @@
 #define P9_STOP_SPR_PSSCR      855
 
 static u32 supported_cpuidle_states;
+struct pnv_idle_states_t *pnv_idle_states;
+int nr_pnv_idle_states;
 
 /*
  * The default stop state that will be used by ppc_md.power_save
@@ -622,48 +624,10 @@ int validate_psscr_val_mask(u64 *psscr_val, u64 *psscr_mask, u32 flags)
  * @dt_idle_states: Number of idle state entries
  * Returns 0 on success
  */
-static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
-					int dt_idle_states)
+static int __init pnv_power9_idle_init(void)
 {
-	u64 *psscr_val = NULL;
-	u64 *psscr_mask = NULL;
-	u32 *residency_ns = NULL;
 	u64 max_residency_ns = 0;
-	int rc = 0, i;
-
-	psscr_val = kcalloc(dt_idle_states, sizeof(*psscr_val), GFP_KERNEL);
-	psscr_mask = kcalloc(dt_idle_states, sizeof(*psscr_mask), GFP_KERNEL);
-	residency_ns = kcalloc(dt_idle_states, sizeof(*residency_ns),
-			       GFP_KERNEL);
-
-	if (!psscr_val || !psscr_mask || !residency_ns) {
-		rc = -1;
-		goto out;
-	}
-
-	if (of_property_read_u64_array(np,
-		"ibm,cpu-idle-state-psscr",
-		psscr_val, dt_idle_states)) {
-		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-psscr in DT\n");
-		rc = -1;
-		goto out;
-	}
-
-	if (of_property_read_u64_array(np,
-				       "ibm,cpu-idle-state-psscr-mask",
-				       psscr_mask, dt_idle_states)) {
-		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-psscr-mask in DT\n");
-		rc = -1;
-		goto out;
-	}
-
-	if (of_property_read_u32_array(np,
-				       "ibm,cpu-idle-state-residency-ns",
-					residency_ns, dt_idle_states)) {
-		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-residency-ns in DT\n");
-		rc = -1;
-		goto out;
-	}
+	int i;
 
 	/*
 	 * Set pnv_first_deep_stop_state, pnv_deepest_stop_psscr_{val,mask},
@@ -679,33 +643,36 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
 	 * the shallowest (OPAL_PM_STOP_INST_FAST) loss-less stop state.
 	 */
 	pnv_first_deep_stop_state = MAX_STOP_STATE;
-	for (i = 0; i < dt_idle_states; i++) {
+	for (i = 0; i < nr_pnv_idle_states; i++) {
 		int err;
-		u64 psscr_rl = psscr_val[i] & PSSCR_RL_MASK;
+		struct pnv_idle_states_t *state = &pnv_idle_states[i];
+		u64 psscr_rl = state->psscr_val & PSSCR_RL_MASK;
 
-		if ((flags[i] & OPAL_PM_LOSE_FULL_CONTEXT) &&
-		     (pnv_first_deep_stop_state > psscr_rl))
+		if ((state->flags & OPAL_PM_LOSE_FULL_CONTEXT) &&
+		    pnv_first_deep_stop_state > psscr_rl)
 			pnv_first_deep_stop_state = psscr_rl;
 
-		err = validate_psscr_val_mask(&psscr_val[i], &psscr_mask[i],
-					      flags[i]);
+		err = validate_psscr_val_mask(&state->psscr_val,
+					      &state->psscr_mask,
+					      state->flags);
 		if (err) {
-			report_invalid_psscr_val(psscr_val[i], err);
+			state->valid = false;
+			report_invalid_psscr_val(state->psscr_val, err);
 			continue;
 		}
 
-		if (max_residency_ns < residency_ns[i]) {
-			max_residency_ns = residency_ns[i];
-			pnv_deepest_stop_psscr_val = psscr_val[i];
-			pnv_deepest_stop_psscr_mask = psscr_mask[i];
-			pnv_deepest_stop_flag = flags[i];
+		if (max_residency_ns < state->residency_ns) {
+			max_residency_ns = state->residency_ns;
+			pnv_deepest_stop_psscr_val = state->psscr_val;
+			pnv_deepest_stop_psscr_mask = state->psscr_mask;
+			pnv_deepest_stop_flag = state->flags;
 			deepest_stop_found = true;
 		}
 
 		if (!default_stop_found &&
-		    (flags[i] & OPAL_PM_STOP_INST_FAST)) {
-			pnv_default_stop_val = psscr_val[i];
-			pnv_default_stop_mask = psscr_mask[i];
+		    (state->flags & OPAL_PM_STOP_INST_FAST)) {
+			pnv_default_stop_val = state->psscr_val;
+			pnv_default_stop_mask = state->psscr_mask;
 			default_stop_found = true;
 		}
 	}
@@ -728,11 +695,8 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
 
 	pr_info("cpuidle-powernv: Requested Level (RL) value of first deep stop = 0x%llx\n",
 		pnv_first_deep_stop_state);
-out:
-	kfree(psscr_val);
-	kfree(psscr_mask);
-	kfree(residency_ns);
-	return rc;
+
+	return 0;
 }
 
 /*
@@ -740,50 +704,146 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
  */
 static void __init pnv_probe_idle_states(void)
 {
-	struct device_node *np;
-	int dt_idle_states;
-	u32 *flags = NULL;
 	int i;
 
+	if (nr_pnv_idle_states < 0) {
+		pr_warn("cpuidle-powernv: no idle states found in the DT\n");
+		return;
+	}
+
+	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+		if (pnv_power9_idle_init())
+			return;
+	}
+
+	for (i = 0; i < nr_pnv_idle_states; i++)
+		supported_cpuidle_states |= pnv_idle_states[i].flags;
+}
+
+/*
+ * This function parses device-tree and populates all the information
+ * into pnv_idle_states structure. It also sets up nr_pnv_idle_states
+ * which is the number of cpuidle states discovered through device-tree.
+ */
+
+static int pnv_parse_cpuidle_dt(void)
+{
+	struct device_node *np;
+	int nr_idle_states, i;
+	int rc = 0;
+	u32 *temp_u32;
+	u64 *temp_u64;
+	const char **temp_string;
+
 	np = of_find_node_by_path("/ibm,opal/power-mgt");
 	if (!np) {
 		pr_warn("opal: PowerMgmt Node not found\n");
-		goto out;
+		return -ENODEV;
 	}
-	dt_idle_states = of_property_count_u32_elems(np,
-			"ibm,cpu-idle-state-flags");
-	if (dt_idle_states < 0) {
-		pr_warn("cpuidle-powernv: no idle states found in the DT\n");
+	nr_idle_states = of_property_count_u32_elems(np,
+						"ibm,cpu-idle-state-flags");
+
+	pnv_idle_states = kcalloc(nr_idle_states, sizeof(*pnv_idle_states),
+				  GFP_KERNEL);
+	temp_u32 = kcalloc(nr_idle_states, sizeof(u32),  GFP_KERNEL);
+	temp_u64 = kcalloc(nr_idle_states, sizeof(u64),  GFP_KERNEL);
+	temp_string = kcalloc(nr_idle_states, sizeof(char *),  GFP_KERNEL);
+
+	if (!(pnv_idle_states && temp_u32 && temp_u64 && temp_string)) {
+		pr_err("Could not allocate memory for dt parsing\n");
+		rc = -ENOMEM;
 		goto out;
 	}
 
-	flags = kcalloc(dt_idle_states, sizeof(*flags),  GFP_KERNEL);
-
-	if (of_property_read_u32_array(np,
-			"ibm,cpu-idle-state-flags", flags, dt_idle_states)) {
+	/* Read flags */
+	if (of_property_read_u32_array(np, "ibm,cpu-idle-state-flags",
+				       temp_u32, nr_idle_states)) {
 		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-flags in DT\n");
+		rc = -EINVAL;
 		goto out;
 	}
+	for (i = 0; i < nr_idle_states; i++)
+		pnv_idle_states[i].flags = temp_u32[i];
+
+	/* Read latencies */
+	if (of_property_read_u32_array(np, "ibm,cpu-idle-state-latencies-ns",
+				       temp_u32, nr_idle_states)) {
+		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-latencies-ns in DT\n");
+		rc = -EINVAL;
+		goto out;
+	}
+	for (i = 0; i < nr_idle_states; i++)
+		pnv_idle_states[i].latency_ns = temp_u32[i];
+
+	/* Read residencies */
+	if (of_property_read_u32_array(np, "ibm,cpu-idle-state-residency-ns",
+				       temp_u32, nr_idle_states)) {
+		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-latencies-ns in DT\n");
+		rc = -EINVAL;
+		goto out;
+	}
+	for (i = 0; i < nr_idle_states; i++)
+		pnv_idle_states[i].residency_ns = temp_u32[i];
 
+	/* For power9 */
 	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
-		if (pnv_power9_idle_init(np, flags, dt_idle_states))
+		/* Read pm_crtl_val */
+		if (of_property_read_u64_array(np, "ibm,cpu-idle-state-psscr",
+					       temp_u64, nr_idle_states)) {
+			pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-psscr in DT\n");
+			rc = -EINVAL;
+			goto out;
+		}
+		for (i = 0; i < nr_idle_states; i++)
+			pnv_idle_states[i].psscr_val = temp_u64[i];
+
+		/* Read pm_crtl_mask */
+		if (of_property_read_u64_array(np, "ibm,cpu-idle-state-psscr-mask",
+					       temp_u64, nr_idle_states)) {
+			pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-psscr-mask in DT\n");
+			rc = -EINVAL;
 			goto out;
+		}
+		for (i = 0; i < nr_idle_states; i++)
+			pnv_idle_states[i].psscr_mask = temp_u64[i];
 	}
 
-	for (i = 0; i < dt_idle_states; i++)
-		supported_cpuidle_states |= flags[i];
+	/*
+	 * power8 specific properties ibm,cpu-idle-state-pmicr-mask and
+	 * ibm,cpu-idle-state-pmicr-val were never used and there is no
+	 * plan to use it in near future. Hence, not parsing these properties
+	 */
 
+	if (of_property_read_string_array(np, "ibm,cpu-idle-state-names",
+					  temp_string, nr_idle_states) < 0) {
+		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-names in DT\n");
+		rc = -EINVAL;
+		goto out;
+	}
+	for (i = 0; i < nr_idle_states; i++)
+		strncpy(pnv_idle_states[i].name, temp_string[i],
+			PNV_IDLE_NAME_LEN);
+	nr_pnv_idle_states = nr_idle_states;
+	rc = 0;
 out:
-	kfree(flags);
+	kfree(temp_u32);
+	kfree(temp_u64);
+	kfree(temp_string);
+	return rc;
 }
+
 static int __init pnv_init_idle_states(void)
 {
-
+	int rc = 0;
 	supported_cpuidle_states = 0;
 
+	/* In case we error out nr_pnv_idle_states will be zero */
+	nr_pnv_idle_states = 0;
 	if (cpuidle_disable != IDLE_NO_OVERRIDE)
 		goto out;
-
+	rc = pnv_parse_cpuidle_dt();
+	if (rc)
+		return rc;
 	pnv_probe_idle_states();
 
 	if (!(supported_cpuidle_states & OPAL_PM_SLEEP_ENABLED_ER1)) {
-- 
2.18.0.rc2.85.g1fb9df7


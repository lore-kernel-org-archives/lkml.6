Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA06C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A247240BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A247240BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754164AbeGELlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 07:41:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37230 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754120AbeGELk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 07:40:57 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w65BcqJg026325
        for <linux-kernel@vger.kernel.org>; Thu, 5 Jul 2018 07:40:57 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k1jh1rdtq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 07:40:57 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akshay.adiga@linux.vnet.ibm.com>;
        Thu, 5 Jul 2018 12:40:55 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 5 Jul 2018 12:40:51 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w65BeoTN18612248
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Jul 2018 11:40:51 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 980954C04E;
        Thu,  5 Jul 2018 14:41:15 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0ECC24C046;
        Thu,  5 Jul 2018 14:41:13 +0100 (BST)
Received: from aksadiga.ibm (unknown [9.195.33.98])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  5 Jul 2018 14:41:12 +0100 (BST)
From:   Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-pm@vger.kernel.org
Cc:     rjw@rjwysocki.net, stewart@linux.vnet.ibm.com,
        benh@kernel.crashing.org, svaidy@linux.vnet.ibm.com,
        ego@linux.vnet.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [PATCH v4 2/2] powernv/cpuidle: Use parsed device tree values for cpuidle_init
Date:   Thu,  5 Jul 2018 17:10:22 +0530
X-Mailer: git-send-email 2.18.0.rc2.85.g1fb9df7
In-Reply-To: <20180705114022.19285-1-akshay.adiga@linux.vnet.ibm.com>
References: <20180705114022.19285-1-akshay.adiga@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18070511-0008-0000-0000-0000024FF137
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070511-0009-0000-0000-000021B60AD4
Message-Id: <20180705114022.19285-3-akshay.adiga@linux.vnet.ibm.com>
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

Export pnv_idle_states and nr_pnv_idle_states so that its accessible to
cpuidle driver. Use properties from pnv_idle_states structure for powernv
cpuidle_init.

Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/cpuidle.h |   2 +
 drivers/cpuidle/cpuidle-powernv.c  | 158 +++++------------------------
 2 files changed, 28 insertions(+), 132 deletions(-)

diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
index 574b0ce1d671..43e5f31fe64d 100644
--- a/arch/powerpc/include/asm/cpuidle.h
+++ b/arch/powerpc/include/asm/cpuidle.h
@@ -90,6 +90,8 @@ struct pnv_idle_states_t {
 	bool valid;
 };
 
+extern struct pnv_idle_states_t *pnv_idle_states;
+extern int nr_pnv_idle_states;
 extern u32 pnv_fastsleep_workaround_at_entry[];
 extern u32 pnv_fastsleep_workaround_at_exit[];
 
diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index d29e4f041efe..84b1ebe212b3 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -242,6 +242,7 @@ static inline void add_powernv_state(int index, const char *name,
 	powernv_states[index].target_residency = target_residency;
 	powernv_states[index].exit_latency = exit_latency;
 	powernv_states[index].enter = idle_fn;
+	/* For power8 and below psscr_* will be 0 */
 	stop_psscr_table[index].val = psscr_val;
 	stop_psscr_table[index].mask = psscr_mask;
 }
@@ -263,186 +264,80 @@ static inline int validate_dt_prop_sizes(const char *prop1, int prop1_len,
 extern u32 pnv_get_supported_cpuidle_states(void);
 static int powernv_add_idle_states(void)
 {
-	struct device_node *power_mgt;
 	int nr_idle_states = 1; /* Snooze */
-	int dt_idle_states, count;
-	u32 latency_ns[CPUIDLE_STATE_MAX];
-	u32 residency_ns[CPUIDLE_STATE_MAX];
-	u32 flags[CPUIDLE_STATE_MAX];
-	u64 psscr_val[CPUIDLE_STATE_MAX];
-	u64 psscr_mask[CPUIDLE_STATE_MAX];
-	const char *names[CPUIDLE_STATE_MAX];
+	int dt_idle_states;
 	u32 has_stop_states = 0;
-	int i, rc;
+	int i;
 	u32 supported_flags = pnv_get_supported_cpuidle_states();
 
 
 	/* Currently we have snooze statically defined */
-
-	power_mgt = of_find_node_by_path("/ibm,opal/power-mgt");
-	if (!power_mgt) {
-		pr_warn("opal: PowerMgmt Node not found\n");
-		goto out;
-	}
-
-	/* Read values of any property to determine the num of idle states */
-	dt_idle_states = of_property_count_u32_elems(power_mgt, "ibm,cpu-idle-state-flags");
-	if (dt_idle_states < 0) {
-		pr_warn("cpuidle-powernv: no idle states found in the DT\n");
+	if (nr_pnv_idle_states <= 0) {
+		pr_warn("cpuidle-powernv : Only Snooze is available\n");
 		goto out;
 	}
 
-	count = of_property_count_u32_elems(power_mgt,
-					    "ibm,cpu-idle-state-latencies-ns");
-
-	if (validate_dt_prop_sizes("ibm,cpu-idle-state-flags", dt_idle_states,
-				   "ibm,cpu-idle-state-latencies-ns",
-				   count) != 0)
-		goto out;
-
-	count = of_property_count_strings(power_mgt,
-					  "ibm,cpu-idle-state-names");
-	if (validate_dt_prop_sizes("ibm,cpu-idle-state-flags", dt_idle_states,
-				   "ibm,cpu-idle-state-names",
-				   count) != 0)
-		goto out;
+	/* TODO: Count only states which are eligible for cpuidle */
+	dt_idle_states = nr_pnv_idle_states;
 
 	/*
 	 * Since snooze is used as first idle state, max idle states allowed is
 	 * CPUIDLE_STATE_MAX -1
 	 */
-	if (dt_idle_states > CPUIDLE_STATE_MAX - 1) {
+	if (nr_pnv_idle_states > CPUIDLE_STATE_MAX - 1) {
 		pr_warn("cpuidle-powernv: discovered idle states more than allowed");
 		dt_idle_states = CPUIDLE_STATE_MAX - 1;
 	}
 
-	if (of_property_read_u32_array(power_mgt,
-			"ibm,cpu-idle-state-flags", flags, dt_idle_states)) {
-		pr_warn("cpuidle-powernv : missing ibm,cpu-idle-state-flags in DT\n");
-		goto out;
-	}
-
-	if (of_property_read_u32_array(power_mgt,
-		"ibm,cpu-idle-state-latencies-ns", latency_ns,
-		dt_idle_states)) {
-		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-latencies-ns in DT\n");
-		goto out;
-	}
-	if (of_property_read_string_array(power_mgt,
-		"ibm,cpu-idle-state-names", names, dt_idle_states) < 0) {
-		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-names in DT\n");
-		goto out;
-	}
-
 	/*
 	 * If the idle states use stop instruction, probe for psscr values
 	 * and psscr mask which are necessary to specify required stop level.
 	 */
-	has_stop_states = (flags[0] &
+	has_stop_states = (pnv_idle_states[0].flags &
 			   (OPAL_PM_STOP_INST_FAST | OPAL_PM_STOP_INST_DEEP));
-	if (has_stop_states) {
-		count = of_property_count_u64_elems(power_mgt,
-						    "ibm,cpu-idle-state-psscr");
-		if (validate_dt_prop_sizes("ibm,cpu-idle-state-flags",
-					   dt_idle_states,
-					   "ibm,cpu-idle-state-psscr",
-					   count) != 0)
-			goto out;
-
-		count = of_property_count_u64_elems(power_mgt,
-						    "ibm,cpu-idle-state-psscr-mask");
-		if (validate_dt_prop_sizes("ibm,cpu-idle-state-flags",
-					   dt_idle_states,
-					   "ibm,cpu-idle-state-psscr-mask",
-					   count) != 0)
-			goto out;
-
-		if (of_property_read_u64_array(power_mgt,
-		    "ibm,cpu-idle-state-psscr", psscr_val, dt_idle_states)) {
-			pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-psscr in DT\n");
-			goto out;
-		}
-
-		if (of_property_read_u64_array(power_mgt,
-					       "ibm,cpu-idle-state-psscr-mask",
-						psscr_mask, dt_idle_states)) {
-			pr_warn("cpuidle-powernv:Missing ibm,cpu-idle-state-psscr-mask in DT\n");
-			goto out;
-		}
-	}
-
-	count = of_property_count_u32_elems(power_mgt,
-					    "ibm,cpu-idle-state-residency-ns");
-
-	if (count < 0) {
-		rc = count;
-	} else if (validate_dt_prop_sizes("ibm,cpu-idle-state-flags",
-					  dt_idle_states,
-					  "ibm,cpu-idle-state-residency-ns",
-					  count) != 0) {
-		goto out;
-	} else {
-		rc = of_property_read_u32_array(power_mgt,
-						"ibm,cpu-idle-state-residency-ns",
-						residency_ns, dt_idle_states);
-	}
 
 	for (i = 0; i < dt_idle_states; i++) {
 		unsigned int exit_latency, target_residency;
 		bool stops_timebase = false;
+		struct pnv_idle_states_t *state = &pnv_idle_states[i];
 
 		/*
 		 * Skip the platform idle state whose flag isn't in
 		 * the supported_cpuidle_states flag mask.
 		 */
-		if ((flags[i] & supported_flags) != flags[i])
+		if ((state->flags & supported_flags) != state->flags)
 			continue;
 		/*
 		 * If an idle state has exit latency beyond
 		 * POWERNV_THRESHOLD_LATENCY_NS then don't use it
 		 * in cpu-idle.
 		 */
-		if (latency_ns[i] > POWERNV_THRESHOLD_LATENCY_NS)
+		if (state->latency_ns > POWERNV_THRESHOLD_LATENCY_NS)
 			continue;
 		/*
 		 * Firmware passes residency and latency values in ns.
 		 * cpuidle expects it in us.
 		 */
-		exit_latency = DIV_ROUND_UP(latency_ns[i], 1000);
-		if (!rc)
-			target_residency = DIV_ROUND_UP(residency_ns[i], 1000);
-		else
-			target_residency = 0;
-
-		if (has_stop_states) {
-			int err = validate_psscr_val_mask(&psscr_val[i],
-							  &psscr_mask[i],
-							  flags[i]);
-			if (err) {
-				report_invalid_psscr_val(psscr_val[i], err);
+		exit_latency = DIV_ROUND_UP(state->latency_ns, 1000);
+		target_residency = DIV_ROUND_UP(state->residency_ns, 1000);
+
+		if (has_stop_states && !(state->valid))
 				continue;
-			}
-		}
 
-		if (flags[i] & OPAL_PM_TIMEBASE_STOP)
+		if (state->flags & OPAL_PM_TIMEBASE_STOP)
 			stops_timebase = true;
 
-		/*
-		 * For nap and fastsleep, use default target_residency
-		 * values if f/w does not expose it.
-		 */
-		if (flags[i] & OPAL_PM_NAP_ENABLED) {
-			if (!rc)
-				target_residency = 100;
+		if (state->flags & OPAL_PM_NAP_ENABLED) {
 			/* Add NAP state */
 			add_powernv_state(nr_idle_states, "Nap",
 					  CPUIDLE_FLAG_NONE, nap_loop,
 					  target_residency, exit_latency, 0, 0);
 		} else if (has_stop_states && !stops_timebase) {
-			add_powernv_state(nr_idle_states, names[i],
+			add_powernv_state(nr_idle_states, state->name,
 					  CPUIDLE_FLAG_NONE, stop_loop,
 					  target_residency, exit_latency,
-					  psscr_val[i], psscr_mask[i]);
+					  state->psscr_val,
+					  state->psscr_mask);
 		}
 
 		/*
@@ -450,20 +345,19 @@ static int powernv_add_idle_states(void)
 		 * within this config dependency check.
 		 */
 #ifdef CONFIG_TICK_ONESHOT
-		else if (flags[i] & OPAL_PM_SLEEP_ENABLED ||
-			 flags[i] & OPAL_PM_SLEEP_ENABLED_ER1) {
-			if (!rc)
-				target_residency = 300000;
+		else if (state->flags & OPAL_PM_SLEEP_ENABLED ||
+			 state->flags & OPAL_PM_SLEEP_ENABLED_ER1) {
 			/* Add FASTSLEEP state */
 			add_powernv_state(nr_idle_states, "FastSleep",
 					  CPUIDLE_FLAG_TIMER_STOP,
 					  fastsleep_loop,
 					  target_residency, exit_latency, 0, 0);
 		} else if (has_stop_states && stops_timebase) {
-			add_powernv_state(nr_idle_states, names[i],
+			add_powernv_state(nr_idle_states, state->name,
 					  CPUIDLE_FLAG_TIMER_STOP, stop_loop,
 					  target_residency, exit_latency,
-					  psscr_val[i], psscr_mask[i]);
+					  state->psscr_val,
+					  state->psscr_mask);
 		}
 #endif
 		else
-- 
2.18.0.rc2.85.g1fb9df7


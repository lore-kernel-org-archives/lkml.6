Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EECC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58CC02083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:05:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58CC02083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755748AbeFSFFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 01:05:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48240 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755706AbeFSFE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 01:04:59 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5J546pO021274
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 01:04:59 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jpng93jde-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 01:04:59 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akshay.adiga@linux.vnet.ibm.com>;
        Tue, 19 Jun 2018 06:04:57 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 19 Jun 2018 06:04:54 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5J54r4N35324072
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Jun 2018 05:04:53 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0AFD74C044;
        Tue, 19 Jun 2018 05:55:55 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1B624C040;
        Tue, 19 Jun 2018 05:55:51 +0100 (BST)
Received: from aksadiga.ibm (unknown [9.195.32.219])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 19 Jun 2018 05:55:51 +0100 (BST)
From:   Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-pm@vger.kernel.org
Cc:     rjw@rjwysocki.net, svaidy@linux.vnet.ibm.com,
        ego@linux.vnet.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [PATCH 2/3] cpuidle/powernv: Change platform init to avoid reparsing dt
Date:   Tue, 19 Jun 2018 10:34:27 +0530
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1529384668-27548-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
References: <1529384668-27548-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18061905-0008-0000-0000-000002493DCA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061905-0009-0000-0000-000021AF8750
Message-Id: <1529384668-27548-3-git-send-email-akshay.adiga@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-19_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=679 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806190058
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The required data is accessible from cpuidle_states structure and
nr_cpu_idle_states. This patch makes changes to avoid reparsing and use
data from these structures.

Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/idle.c | 37 ++++++++---------------------------
 1 file changed, 8 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 07be984..0a62611 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -624,8 +624,7 @@ int validate_psscr_val_mask(u64 *psscr_val, u64 *psscr_mask, u32 flags)
  * @dt_idle_states: Number of idle state entries
  * Returns 0 on success
  */
-static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
-					int dt_idle_states)
+static int __init pnv_power9_idle_init(void)
 {
 	u64 max_residency_ns = 0;
 	int i;
@@ -644,7 +643,7 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
 	 * the shallowest (OPAL_PM_STOP_INST_FAST) loss-less stop state.
 	 */
 	pnv_first_deep_stop_state = MAX_STOP_STATE;
-	for (i = 0; i < dt_idle_states; i++) {
+	for (i = 0; i < nr_pnv_idle_states; i++) {
 		int err;
 		struct pnv_idle_states_t *state = &pnv_idle_states[i];
 		u64 psscr_rl = state->pm_ctrl_reg_val & PSSCR_RL_MASK;
@@ -704,41 +703,21 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
  */
 static void __init pnv_probe_idle_states(void)
 {
-	struct device_node *np;
-	int dt_idle_states;
-	u32 *flags = NULL;
 	int i;
 
-	np = of_find_node_by_path("/ibm,opal/power-mgt");
-	if (!np) {
-		pr_warn("opal: PowerMgmt Node not found\n");
-		goto out;
-	}
-	dt_idle_states = of_property_count_u32_elems(np,
-			"ibm,cpu-idle-state-flags");
-	if (dt_idle_states < 0) {
+	if (nr_pnv_idle_states < 0) {
 		pr_warn("cpuidle-powernv: no idle states found in the DT\n");
-		goto out;
-	}
-
-	flags = kcalloc(dt_idle_states, sizeof(*flags),  GFP_KERNEL);
-
-	if (of_property_read_u32_array(np,
-			"ibm,cpu-idle-state-flags", flags, dt_idle_states)) {
-		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-flags in DT\n");
-		goto out;
+		return;
 	}
 
 	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
-		if (pnv_power9_idle_init(np, flags, dt_idle_states))
-			goto out;
+		if (pnv_power9_idle_init())
+			return;
 	}
 
-	for (i = 0; i < dt_idle_states; i++)
-		supported_cpuidle_states |= flags[i];
+	for (i = 0; i < nr_pnv_idle_states; i++)
+		supported_cpuidle_states |= pnv_idle_states[i].flags;
 
-out:
-	kfree(flags);
 }
 
 /*
-- 
2.5.5


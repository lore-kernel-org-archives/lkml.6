Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C337C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F7120874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:14:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47F7120874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388283AbeGXHTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 03:19:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36432 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388161AbeGXHTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 03:19:15 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6O6Dwc5135268
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 02:14:25 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kdwa3ufgr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 02:14:25 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
        Tue, 24 Jul 2018 02:14:24 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 24 Jul 2018 02:14:22 -0400
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6O6ELiD10879264
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Jul 2018 06:14:21 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E97F6124053;
        Tue, 24 Jul 2018 03:15:44 -0400 (EDT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A74F5124052;
        Tue, 24 Jul 2018 03:15:44 -0400 (EDT)
Received: from sofia.ibm.com (unknown [9.124.35.39])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 24 Jul 2018 03:15:44 -0400 (EDT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 38CAD2E324E; Tue, 24 Jul 2018 11:44:18 +0530 (IST)
From:   "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Neuling <mikey@neuling.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH v4 2/2] powerpc: Enable CPU_FTR_ASYM_SMT for interleaved big-cores
Date:   Tue, 24 Jul 2018 11:44:08 +0530
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1532412848-9826-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1532412848-9826-1-git-send-email-ego@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18072406-0060-0000-0000-000002912ED1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009421; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01065309; UDB=6.00547221; IPR=6.00843167;
 MB=3.00022293; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-24 06:14:24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072406-0061-0000-0000-000045E83078
Message-Id: <1532412848-9826-3-git-send-email-ego@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-24_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807240066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

A pair of IBM POWER9 SMT4 cores can be fused together to form a big-core
with 8 SMT threads. This can be discovered via the "ibm,thread-groups"
CPU property in the device tree which will indicate which group of
threads that share the L1 cache, translation cache and instruction data
flow. If there are multiple such group of threads, then the core is a
big-core.

Furthermore, if the thread-ids of the threads of the big-core can be
obtained by interleaving the thread-ids of the thread-groups
(component small core), then such a big-core is called an interleaved
big-core.

Eg: Threads in the pair of component SMT4 cores of an interleaved
big-core are numbered {0,2,4,6} and {1,3,5,7} respectively.

The SMT4 cores forming a big-core are more or less independent
units. Thus when multiple tasks are scheduled to run on the fused
core, we get the best performance when the tasks are spread across the
pair of SMT4 cores.

This patch enables CPU_FTR_ASYM_SMT bit in the cpu-features on
detecting the presence of interleaved big-cores at boot up. This will
will bias the load-balancing of tasks on smaller numbered threads,
which will automatically result in spreading the tasks uniformly
across the associated pair of SMT4 cores.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/setup-common.c | 75 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 989edc1..22bc486 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -581,6 +581,69 @@ int get_cpu_thread_group_start(int cpu, struct thread_groups *tg)
 	return -1;
 }
 
+/*
+ * check_interleaved_big_core - Checks if the thread group tg
+ * corresponds to a big-core whose threads are interleavings of the
+ * threads of the component small cores.
+ *
+ * @tg: A thread-group struct for the core.
+ *
+ * Returns true if the core is a interleaved big-core.
+ * Returns false otherwise.
+ */
+static inline bool check_interleaved_big_core(struct thread_groups *tg)
+{
+	int nr_groups;
+	int threads_per_group;
+	int cur_cpu, next_cpu, i, j;
+
+	nr_groups = tg->nr_groups;
+	threads_per_group = tg->threads_per_group;
+
+	if (tg->property != 1)
+		return false;
+
+	if (nr_groups < 2 || threads_per_group < 2)
+		return false;
+
+	/*
+	 * In case of an interleaved big-core, the thread-ids of the
+	 * big-core can be obtained by interleaving the the thread-ids
+	 * of the component small
+	 *
+	 * Eg: On a 8-thread big-core with two SMT4 small cores, the
+	 * threads of the two component small cores will be
+	 * {0, 2, 4, 6} and {1, 3, 5, 7}.
+	 */
+	for (i = 0; i < nr_groups; i++) {
+		int group_start = i * threads_per_group;
+
+		for (j = 0; j < threads_per_group - 1; j++) {
+			int cur_idx = group_start + j;
+
+			cur_cpu = tg->thread_list[cur_idx];
+			next_cpu = tg->thread_list[cur_idx + 1];
+			if (next_cpu != cur_cpu + nr_groups)
+				return false;
+		}
+	}
+
+	return true;
+}
+
+#if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
+static inline void enable_asym_smt_feature(void)
+{
+	int key = __builtin_ctzl(CPU_FTR_ASYM_SMT);
+
+	cur_cpu_spec->cpu_features |= CPU_FTR_ASYM_SMT;
+	static_branch_enable(&cpu_feature_keys[key]);
+	pr_info("Enabling ASYM_SMT on interleaved big-cores\n");
+}
+#else
+#define enable_asym_smt_feature()
+#endif
+
 /**
  * setup_cpu_maps - initialize the following cpu maps:
  *                  cpu_possible_mask
@@ -604,6 +667,7 @@ void __init smp_setup_cpu_maps(void)
 	struct device_node *dn;
 	int cpu = 0;
 	int nthreads = 1;
+	bool has_interleaved_big_cores = true;
 
 	has_big_cores = true;
 	DBG("smp_setup_cpu_maps()\n");
@@ -657,6 +721,12 @@ void __init smp_setup_cpu_maps(void)
 
 		if (has_big_cores && !dt_has_big_core(dn, &tg)) {
 			has_big_cores = false;
+			has_interleaved_big_cores = false;
+		}
+
+		if (has_interleaved_big_cores) {
+			has_interleaved_big_cores =
+				check_interleaved_big_core(&tg);
 		}
 
 		if (cpu >= nr_cpu_ids) {
@@ -713,7 +783,10 @@ void __init smp_setup_cpu_maps(void)
 	vdso_data->processorCount = num_present_cpus();
 #endif /* CONFIG_PPC64 */
 
-        /* Initialize CPU <=> thread mapping/
+	if (has_interleaved_big_cores)
+		enable_asym_smt_feature();
+
+	/* Initialize CPU <=> thread mapping/
 	 *
 	 * WARNING: We assume that the number of threads is the same for
 	 * every CPU in the system. If that is not the case, then some code
-- 
1.9.4


Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED006C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B6E2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:04:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3B6E2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753155AbeGCLEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 07:04:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37638 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752620AbeGCLEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 07:04:32 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w63B4NsK058272
        for <linux-kernel@vger.kernel.org>; Tue, 3 Jul 2018 07:04:32 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k0734a6x0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 07:04:27 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
        Tue, 3 Jul 2018 07:04:03 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Jul 2018 07:03:59 -0400
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w63B3wb18061538
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Jul 2018 11:03:58 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFA5F2805A;
        Tue,  3 Jul 2018 07:03:31 -0400 (EDT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D2BC2805E;
        Tue,  3 Jul 2018 07:03:31 -0400 (EDT)
Received: from sofia.ibm.com (unknown [9.124.35.39])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  3 Jul 2018 07:03:31 -0400 (EDT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 2EDDE2E2F44; Tue,  3 Jul 2018 16:33:57 +0530 (IST)
From:   "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Neuling <mikey@neuling.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [v2 PATCH 2/2] powerpc: Enable CPU_FTR_ASYM_SMT for interleaved big-cores
Date:   Tue,  3 Jul 2018 16:33:51 +0530
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1530609795.git.ego@linux.vnet.ibm.com>
References: <cover.1530609795.git.ego@linux.vnet.ibm.com>
In-Reply-To: <cover.1530609795.git.ego@linux.vnet.ibm.com>
References: <cover.1530609795.git.ego@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18070311-0072-0000-0000-00000379202B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009300; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01055907; UDB=6.00541612; IPR=6.00833829;
 MB=3.00021975; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-03 11:04:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070311-0073-0000-0000-000048936640
Message-Id: <573a559dff87da1d68a55bf6ada97b7697102909.1530609795.git.ego@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-03_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807030128
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
 arch/powerpc/kernel/setup-common.c | 67 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index a78ec66..f63d797 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -537,6 +537,56 @@ int get_cpu_thread_group_start(int cpu, struct thread_groups *tg)
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
 /**
  * setup_cpu_maps - initialize the following cpu maps:
  *                  cpu_possible_mask
@@ -560,6 +610,7 @@ void __init smp_setup_cpu_maps(void)
 	struct device_node *dn;
 	int cpu = 0;
 	int nthreads = 1;
+	bool has_interleaved_big_core = true;
 
 	DBG("smp_setup_cpu_maps()\n");
 
@@ -613,6 +664,12 @@ void __init smp_setup_cpu_maps(void)
 		if (parse_thread_groups(dn, &tg) ||
 		    tg.nr_groups < 1 || tg.property != 1) {
 			has_big_cores = false;
+			has_interleaved_big_core = false;
+		}
+
+		if (has_interleaved_big_core) {
+			has_interleaved_big_core =
+				check_interleaved_big_core(&tg);
 		}
 
 		if (cpu >= nr_cpu_ids) {
@@ -669,7 +726,15 @@ void __init smp_setup_cpu_maps(void)
 	vdso_data->processorCount = num_present_cpus();
 #endif /* CONFIG_PPC64 */
 
-        /* Initialize CPU <=> thread mapping/
+	if (has_interleaved_big_core) {
+		int key = __builtin_ctzl(CPU_FTR_ASYM_SMT);
+
+		cur_cpu_spec->cpu_features |= CPU_FTR_ASYM_SMT;
+		static_branch_enable(&cpu_feature_keys[key]);
+		pr_info("Detected interleaved big-cores\n");
+	}
+
+	/* Initialize CPU <=> thread mapping/
 	 *
 	 * WARNING: We assume that the number of threads is the same for
 	 * every CPU in the system. If that is not the case, then some code
-- 
1.9.4


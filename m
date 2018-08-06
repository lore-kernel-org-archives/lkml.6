Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A7AC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11D421A5E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E11D421A5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733268AbeHFScy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:32:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38040 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732552AbeHFScy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:32:54 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w76GFBjW117651
        for <linux-kernel@vger.kernel.org>; Mon, 6 Aug 2018 12:23:03 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kpsma0eaa-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 12:23:03 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
        Mon, 6 Aug 2018 12:23:02 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 Aug 2018 12:22:59 -0400
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w76GMwRF14025192
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Aug 2018 16:22:58 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F995124058;
        Mon,  6 Aug 2018 13:24:05 -0400 (EDT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 431A7124053;
        Mon,  6 Aug 2018 13:24:05 -0400 (EDT)
Received: from sofia.ibm.com (unknown [9.84.220.3])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  6 Aug 2018 13:24:05 -0400 (EDT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id C62422E3334; Mon,  6 Aug 2018 21:52:55 +0530 (IST)
From:   "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Neuling <mikey@neuling.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        Anton Blanchard <anton@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH v5 2/2] powerpc: Use cpu_smallcore_sibling_mask at SMT level on bigcores
Date:   Mon,  6 Aug 2018 21:52:45 +0530
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1533572565-17357-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1533572565-17357-1-git-send-email-ego@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18080616-0064-0000-0000-0000033614C0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009495; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01070373; UDB=6.00550830; IPR=6.00849589;
 MB=3.00022540; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-06 16:23:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080616-0065-0000-0000-00003A355698
Message-Id: <1533572565-17357-3-git-send-email-ego@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-06_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808060169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

Each of the SMT4 cores forming a big-core are more or less independent
units. Thus when multiple tasks are scheduled to run on the fused
core, we get the best performance when the tasks are spread across the
pair of SMT4 cores.

This patch achieves this by setting the SMT level mask to correspond
to the smallcore sibling mask on big-core systems.

With this patch, the SMT sched-domain with SMT=8,4,2 on big-core
systems are as follows:

1) ppc64_cpu --smt=8

 CPU0 attaching sched-domain(s):
  domain-0: span=0,2,4,6 level=SMT
   groups: 0:{ span=0 cap=294 }, 2:{ span=2 cap=294 },
           4:{ span=4 cap=294 }, 6:{ span=6 cap=294 }
 CPU1 attaching sched-domain(s):
  domain-0: span=1,3,5,7 level=SMT
   groups: 1:{ span=1 cap=294 }, 3:{ span=3 cap=294 },
           5:{ span=5 cap=294 }, 7:{ span=7 cap=294 }

2) ppc64_cpu --smt=4

 CPU0 attaching sched-domain(s):
  domain-0: span=0,2 level=SMT
   groups: 0:{ span=0 cap=589 }, 2:{ span=2 cap=589 }
 CPU1 attaching sched-domain(s):
  domain-0: span=1,3 level=SMT
   groups: 1:{ span=1 cap=589 }, 3:{ span=3 cap=589 }

3) ppc64_cpu --smt=2
   SMT domain ceases to exist as each domain consists of just one
   group.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/smp.h |  6 +++++
 arch/powerpc/kernel/smp.c      | 55 +++++++++++++++++++++++++++++++++++++++---
 2 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 29ffaab..30798c7 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -99,6 +99,7 @@ static inline void set_hard_smp_processor_id(int cpu, int phys)
 #endif
 
 DECLARE_PER_CPU(cpumask_var_t, cpu_sibling_map);
+DECLARE_PER_CPU(cpumask_var_t, cpu_smallcore_sibling_map);
 DECLARE_PER_CPU(cpumask_var_t, cpu_l2_cache_map);
 DECLARE_PER_CPU(cpumask_var_t, cpu_core_map);
 
@@ -107,6 +108,11 @@ static inline struct cpumask *cpu_sibling_mask(int cpu)
 	return per_cpu(cpu_sibling_map, cpu);
 }
 
+static inline struct cpumask *cpu_smallcore_sibling_mask(int cpu)
+{
+	return per_cpu(cpu_smallcore_sibling_map, cpu);
+}
+
 static inline struct cpumask *cpu_core_mask(int cpu)
 {
 	return per_cpu(cpu_core_map, cpu);
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 4794d6b..ea3b306 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -76,10 +76,12 @@
 struct thread_info *secondary_ti;
 
 DEFINE_PER_CPU(cpumask_var_t, cpu_sibling_map);
+DEFINE_PER_CPU(cpumask_var_t, cpu_smallcore_sibling_map);
 DEFINE_PER_CPU(cpumask_var_t, cpu_l2_cache_map);
 DEFINE_PER_CPU(cpumask_var_t, cpu_core_map);
 
 EXPORT_PER_CPU_SYMBOL(cpu_sibling_map);
+EXPORT_PER_CPU_SYMBOL(cpu_smallcore_sibling_map);
 EXPORT_PER_CPU_SYMBOL(cpu_l2_cache_map);
 EXPORT_PER_CPU_SYMBOL(cpu_core_map);
 
@@ -689,6 +691,9 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	for_each_possible_cpu(cpu) {
 		zalloc_cpumask_var_node(&per_cpu(cpu_sibling_map, cpu),
 					GFP_KERNEL, cpu_to_node(cpu));
+		zalloc_cpumask_var_node(&per_cpu(cpu_smallcore_sibling_map,
+						 cpu),
+					GFP_KERNEL, cpu_to_node(cpu));
 		zalloc_cpumask_var_node(&per_cpu(cpu_l2_cache_map, cpu),
 					GFP_KERNEL, cpu_to_node(cpu));
 		zalloc_cpumask_var_node(&per_cpu(cpu_core_map, cpu),
@@ -707,6 +712,10 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	cpumask_set_cpu(boot_cpuid, cpu_sibling_mask(boot_cpuid));
 	cpumask_set_cpu(boot_cpuid, cpu_l2_cache_mask(boot_cpuid));
 	cpumask_set_cpu(boot_cpuid, cpu_core_mask(boot_cpuid));
+	if (has_big_cores) {
+		cpumask_set_cpu(boot_cpuid,
+				cpu_smallcore_sibling_mask(boot_cpuid));
+	}
 
 	if (smp_ops && smp_ops->probe)
 		smp_ops->probe();
@@ -991,6 +1000,10 @@ static void remove_cpu_from_masks(int cpu)
 		set_cpus_unrelated(cpu, i, cpu_core_mask);
 		set_cpus_unrelated(cpu, i, cpu_l2_cache_mask);
 		set_cpus_unrelated(cpu, i, cpu_sibling_mask);
+		if (has_big_cores) {
+			set_cpus_unrelated(cpu, i,
+					   cpu_smallcore_sibling_mask);
+		}
 	}
 }
 #endif
@@ -999,7 +1012,17 @@ static void add_cpu_to_masks(int cpu)
 {
 	int first_thread = cpu_first_thread_sibling(cpu);
 	int chipid = cpu_to_chip_id(cpu);
-	int i;
+
+	struct thread_groups tg;
+	int i, cpu_group_start = -1;
+
+	if (has_big_cores) {
+		struct device_node *dn = of_get_cpu_node(cpu, NULL);
+
+		parse_thread_groups(dn, &tg);
+		cpu_group_start = get_cpu_thread_group_start(cpu, &tg);
+		cpumask_set_cpu(cpu, cpu_smallcore_sibling_mask(cpu));
+	}
 
 	/*
 	 * This CPU will not be in the online mask yet so we need to manually
@@ -1007,9 +1030,21 @@ static void add_cpu_to_masks(int cpu)
 	 */
 	cpumask_set_cpu(cpu, cpu_sibling_mask(cpu));
 
-	for (i = first_thread; i < first_thread + threads_per_core; i++)
-		if (cpu_online(i))
-			set_cpus_related(i, cpu, cpu_sibling_mask);
+	for (i = first_thread; i < first_thread + threads_per_core; i++) {
+		int i_group_start;
+
+		if (!cpu_online(i))
+			continue;
+
+		set_cpus_related(i, cpu, cpu_sibling_mask);
+
+		if (!has_big_cores)
+			continue;
+
+		i_group_start = get_cpu_thread_group_start(i, &tg);
+		if (i_group_start == cpu_group_start)
+			set_cpus_related(i, cpu, cpu_smallcore_sibling_mask);
+	}
 
 	/*
 	 * Copy the thread sibling mask into the cache sibling mask
@@ -1136,6 +1171,11 @@ static const struct cpumask *shared_cache_mask(int cpu)
 	return cpu_l2_cache_mask(cpu);
 }
 
+static const struct cpumask *smallcore_smt_mask(int cpu)
+{
+	return cpu_smallcore_sibling_mask(cpu);
+}
+
 static struct sched_domain_topology_level power9_topology[] = {
 #ifdef CONFIG_SCHED_SMT
 	{ cpu_smt_mask, powerpc_smt_flags, SD_INIT_NAME(SMT) },
@@ -1158,6 +1198,13 @@ void __init smp_cpus_done(unsigned int max_cpus)
 
 	dump_numa_cpu_topology();
 
+#ifdef CONFIG_SCHED_SMT
+	if (has_big_cores) {
+		pr_info("Using small cores at SMT level\n");
+		power9_topology[0].mask = smallcore_smt_mask;
+		powerpc_topology[0].mask = smallcore_smt_mask;
+	}
+#endif
 	/*
 	 * If any CPU detects that it's sharing a cache with another CPU then
 	 * use the deeper topology that is aware of this sharing.
-- 
1.9.4


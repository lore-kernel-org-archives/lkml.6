Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0117AECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A668621531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:23:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A668621531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387773AbeITXH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:07:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53414 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726990AbeITXH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:07:28 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8KHEN3g115425
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 13:22:56 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mmdqw674r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 13:22:56 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
        Thu, 20 Sep 2018 11:22:54 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 20 Sep 2018 11:22:51 -0600
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8KHMouS49741974
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Sep 2018 10:22:50 -0700
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45E4F6E04E;
        Thu, 20 Sep 2018 11:22:50 -0600 (MDT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6393F6E052;
        Thu, 20 Sep 2018 11:22:49 -0600 (MDT)
Received: from sofia.ibm.com (unknown [9.124.212.176])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 20 Sep 2018 11:22:49 -0600 (MDT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 3DBE92E2CF3; Thu, 20 Sep 2018 22:52:45 +0530 (IST)
From:   "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
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
Subject: [PATCH v8 1/3] powerpc: Detect the presence of big-cores via "ibm,thread-groups"
Date:   Thu, 20 Sep 2018 22:52:37 +0530
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1537464159-25919-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1537464159-25919-1-git-send-email-ego@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18092017-8235-0000-0000-00000E03409C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009741; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01091142; UDB=6.00563758; IPR=6.00871165;
 MB=3.00023416; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-20 17:22:53
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092017-8236-0000-0000-000042B5FEA1
Message-Id: <1537464159-25919-2-git-send-email-ego@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-20_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=945 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809200167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

On IBM POWER9, the device tree exposes a property array identifed by
"ibm,thread-groups" which will indicate which groups of threads share a
particular set of resources.

As of today we only have one form of grouping identifying the group of
threads in the core that share the L1 cache, translation cache and
instruction data flow.

This patch

     1) Defines the helper function to parse the contents of
     "ibm,thread-groups".

     2) On boot, it parses the "ibm,thread-groups" property and caches
     the CPU-threads sharing the L1 cache in a per-cpu variable named
     cpu_l1_cache_map.

     3) Initializes a global variable named "has_big_cores" on
     big-core systems.

     4) Each time a CPU is onlined, it initializes the
     cpu_smallcore_mask which contains the online siblings of the
     CPU that share the L1 cache with this CPU.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/cputhreads.h |   2 +
 arch/powerpc/include/asm/smp.h        |   6 +
 arch/powerpc/kernel/smp.c             | 221 ++++++++++++++++++++++++++++++++++
 3 files changed, 229 insertions(+)

diff --git a/arch/powerpc/include/asm/cputhreads.h b/arch/powerpc/include/asm/cputhreads.h
index d71a909..deb99fd 100644
--- a/arch/powerpc/include/asm/cputhreads.h
+++ b/arch/powerpc/include/asm/cputhreads.h
@@ -23,11 +23,13 @@
 extern int threads_per_core;
 extern int threads_per_subcore;
 extern int threads_shift;
+extern bool has_big_cores;
 extern cpumask_t threads_core_mask;
 #else
 #define threads_per_core	1
 #define threads_per_subcore	1
 #define threads_shift		0
+#define has_big_cores		0
 #define threads_core_mask	(*get_cpu_mask(0))
 #endif
 
diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 95b66a0..4439893 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -100,6 +100,7 @@ static inline void set_hard_smp_processor_id(int cpu, int phys)
 DECLARE_PER_CPU(cpumask_var_t, cpu_sibling_map);
 DECLARE_PER_CPU(cpumask_var_t, cpu_l2_cache_map);
 DECLARE_PER_CPU(cpumask_var_t, cpu_core_map);
+DECLARE_PER_CPU(cpumask_var_t, cpu_smallcore_map);
 
 static inline struct cpumask *cpu_sibling_mask(int cpu)
 {
@@ -116,6 +117,11 @@ static inline struct cpumask *cpu_l2_cache_mask(int cpu)
 	return per_cpu(cpu_l2_cache_map, cpu);
 }
 
+static inline struct cpumask *cpu_smallcore_mask(int cpu)
+{
+	return per_cpu(cpu_smallcore_map, cpu);
+}
+
 extern int cpu_to_core_id(int cpu);
 
 /* Since OpenPIC has only 4 IPIs, we use slightly different message numbers.
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 61c1fad..15095110 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -74,14 +74,32 @@
 #endif
 
 struct thread_info *secondary_ti;
+bool has_big_cores;
 
 DEFINE_PER_CPU(cpumask_var_t, cpu_sibling_map);
+DEFINE_PER_CPU(cpumask_var_t, cpu_smallcore_map);
 DEFINE_PER_CPU(cpumask_var_t, cpu_l2_cache_map);
 DEFINE_PER_CPU(cpumask_var_t, cpu_core_map);
 
 EXPORT_PER_CPU_SYMBOL(cpu_sibling_map);
 EXPORT_PER_CPU_SYMBOL(cpu_l2_cache_map);
 EXPORT_PER_CPU_SYMBOL(cpu_core_map);
+EXPORT_SYMBOL_GPL(has_big_cores);
+
+#define MAX_THREAD_LIST_SIZE	8
+#define THREAD_GROUP_SHARE_L1   1
+struct thread_groups {
+	unsigned int property;
+	unsigned int nr_groups;
+	unsigned int threads_per_group;
+	unsigned int thread_list[MAX_THREAD_LIST_SIZE];
+};
+
+/*
+ * On big-cores system, cpu_l1_cache_map for each CPU corresponds to
+ * the set its siblings that share the L1-cache.
+ */
+DEFINE_PER_CPU(cpumask_var_t, cpu_l1_cache_map);
 
 /* SMP operations for this machine */
 struct smp_ops_t *smp_ops;
@@ -674,6 +692,184 @@ static void set_cpus_unrelated(int i, int j,
 }
 #endif
 
+/*
+ * parse_thread_groups: Parses the "ibm,thread-groups" device tree
+ *                      property for the CPU device node @dn and stores
+ *                      the parsed output in the thread_groups
+ *                      structure @tg if the ibm,thread-groups[0]
+ *                      matches @property.
+ *
+ * @dn: The device node of the CPU device.
+ * @tg: Pointer to a thread group structure into which the parsed
+ *      output of "ibm,thread-groups" is stored.
+ * @property: The property of the thread-group that the caller is
+ *            interested in.
+ *
+ * ibm,thread-groups[0..N-1] array defines which group of threads in
+ * the CPU-device node can be grouped together based on the property.
+ *
+ * ibm,thread-groups[0] tells us the property based on which the
+ * threads are being grouped together. If this value is 1, it implies
+ * that the threads in the same group share L1, translation cache.
+ *
+ * ibm,thread-groups[1] tells us how many such thread groups exist.
+ *
+ * ibm,thread-groups[2] tells us the number of threads in each such
+ * group.
+ *
+ * ibm,thread-groups[3..N-1] is the list of threads identified by
+ * "ibm,ppc-interrupt-server#s" arranged as per their membership in
+ * the grouping.
+ *
+ * Example: If ibm,thread-groups = [1,2,4,5,6,7,8,9,10,11,12] it
+ * implies that there are 2 groups of 4 threads each, where each group
+ * of threads share L1, translation cache.
+ *
+ * The "ibm,ppc-interrupt-server#s" of the first group is {5,6,7,8}
+ * and the "ibm,ppc-interrupt-server#s" of the second group is {9, 10,
+ * 11, 12} structure
+ *
+ * Returns 0 on success, -EINVAL if the property does not exist,
+ * -ENODATA if property does not have a value, and -EOVERFLOW if the
+ * property data isn't large enough.
+ */
+static int parse_thread_groups(struct device_node *dn,
+			       struct thread_groups *tg,
+			       unsigned int property)
+{
+	int i;
+	u32 thread_group_array[3 + MAX_THREAD_LIST_SIZE];
+	u32 *thread_list;
+	size_t total_threads;
+	int ret;
+
+	ret = of_property_read_u32_array(dn, "ibm,thread-groups",
+					 thread_group_array, 3);
+	if (ret)
+		return ret;
+
+	tg->property = thread_group_array[0];
+	tg->nr_groups = thread_group_array[1];
+	tg->threads_per_group = thread_group_array[2];
+	if (tg->property != property ||
+	    tg->nr_groups < 1 ||
+	    tg->threads_per_group < 1)
+		return -ENODATA;
+
+	total_threads = tg->nr_groups * tg->threads_per_group;
+
+	ret = of_property_read_u32_array(dn, "ibm,thread-groups",
+					 thread_group_array,
+					 3 + total_threads);
+	if (ret)
+		return ret;
+
+	thread_list = &thread_group_array[3];
+
+	for (i = 0 ; i < total_threads; i++)
+		tg->thread_list[i] = thread_list[i];
+
+	return 0;
+}
+
+/*
+ * get_cpu_thread_group_start : Searches the thread group in tg->thread_list
+ *                              that @cpu belongs to.
+ *
+ * @cpu : The logical CPU whose thread group is being searched.
+ * @tg : The thread-group structure of the CPU node which @cpu belongs
+ *       to.
+ *
+ * Returns the index to tg->thread_list that points to the the start
+ * of the thread_group that @cpu belongs to.
+ *
+ * Returns -1 if cpu doesn't belong to any of the groups pointed to by
+ * tg->thread_list.
+ */
+static int get_cpu_thread_group_start(int cpu, struct thread_groups *tg)
+{
+	int hw_cpu_id = get_hard_smp_processor_id(cpu);
+	int i, j;
+
+	for (i = 0; i < tg->nr_groups; i++) {
+		int group_start = i * tg->threads_per_group;
+
+		for (j = 0; j < tg->threads_per_group; j++) {
+			int idx = group_start + j;
+
+			if (tg->thread_list[idx] == hw_cpu_id)
+				return group_start;
+		}
+	}
+
+	return -1;
+}
+
+static int init_cpu_l1_cache_map(int cpu)
+
+{
+	struct device_node *dn = of_get_cpu_node(cpu, NULL);
+	struct thread_groups tg;
+
+	int first_thread = cpu_first_thread_sibling(cpu);
+	int i, cpu_group_start = -1, err = 0;
+
+	if (!dn)
+		return -ENODATA;
+
+	err = parse_thread_groups(dn, &tg, THREAD_GROUP_SHARE_L1);
+	if (err)
+		goto out;
+
+	zalloc_cpumask_var_node(&per_cpu(cpu_l1_cache_map, cpu),
+				GFP_KERNEL,
+				cpu_to_node(cpu));
+
+	cpu_group_start = get_cpu_thread_group_start(cpu, &tg);
+
+	if (unlikely(cpu_group_start == -1)) {
+		WARN_ON_ONCE(1);
+		err = -ENODATA;
+		goto out;
+	}
+
+	for (i = first_thread; i < first_thread + threads_per_core; i++) {
+		int i_group_start = get_cpu_thread_group_start(i, &tg);
+
+		if (unlikely(i_group_start == -1)) {
+			WARN_ON_ONCE(1);
+			err = -ENODATA;
+			goto out;
+		}
+
+		if (i_group_start == cpu_group_start)
+			cpumask_set_cpu(i, per_cpu(cpu_l1_cache_map, cpu));
+	}
+
+out:
+	of_node_put(dn);
+	return err;
+}
+
+static int init_big_cores(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		int err = init_cpu_l1_cache_map(cpu);
+
+		if (err)
+			return err;
+
+		zalloc_cpumask_var_node(&per_cpu(cpu_smallcore_map, cpu),
+					GFP_KERNEL,
+					cpu_to_node(cpu));
+	}
+
+	has_big_cores = true;
+	return 0;
+}
+
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 	unsigned int cpu;
@@ -712,6 +908,12 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	cpumask_set_cpu(boot_cpuid, cpu_l2_cache_mask(boot_cpuid));
 	cpumask_set_cpu(boot_cpuid, cpu_core_mask(boot_cpuid));
 
+	init_big_cores();
+	if (has_big_cores) {
+		cpumask_set_cpu(boot_cpuid,
+				cpu_smallcore_mask(boot_cpuid));
+	}
+
 	if (smp_ops && smp_ops->probe)
 		smp_ops->probe();
 }
@@ -995,10 +1197,28 @@ static void remove_cpu_from_masks(int cpu)
 		set_cpus_unrelated(cpu, i, cpu_core_mask);
 		set_cpus_unrelated(cpu, i, cpu_l2_cache_mask);
 		set_cpus_unrelated(cpu, i, cpu_sibling_mask);
+		if (has_big_cores)
+			set_cpus_unrelated(cpu, i, cpu_smallcore_mask);
 	}
 }
 #endif
 
+static inline void add_cpu_to_smallcore_masks(int cpu)
+{
+	struct cpumask *this_l1_cache_map = per_cpu(cpu_l1_cache_map, cpu);
+	int i, first_thread = cpu_first_thread_sibling(cpu);
+
+	if (!has_big_cores)
+		return;
+
+	cpumask_set_cpu(cpu, cpu_smallcore_mask(cpu));
+
+	for (i = first_thread; i < first_thread + threads_per_core; i++) {
+		if (cpu_online(i) && cpumask_test_cpu(i, this_l1_cache_map))
+			set_cpus_related(i, cpu, cpu_smallcore_mask);
+	}
+}
+
 static void add_cpu_to_masks(int cpu)
 {
 	int first_thread = cpu_first_thread_sibling(cpu);
@@ -1015,6 +1235,7 @@ static void add_cpu_to_masks(int cpu)
 		if (cpu_online(i))
 			set_cpus_related(i, cpu, cpu_sibling_mask);
 
+	add_cpu_to_smallcore_masks(cpu);
 	/*
 	 * Copy the thread sibling mask into the cache sibling mask
 	 * and mark any CPUs that share an L2 with this CPU.
-- 
1.9.4


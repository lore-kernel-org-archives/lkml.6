Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753359AbeEKLRs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 07:17:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54454 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753210AbeEKLRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 07:17:43 -0400
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Neuling <mikey@neuling.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH 1/2] powerpc: Detect the presence of big-core with interleaved threads
Date: Fri, 11 May 2018 16:47:23 +0530
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1526037444-22876-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1526037444-22876-1-git-send-email-ego@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18051111-0016-0000-0000-000008B3FB92
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009005; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000259; SDB=6.01030698; UDB=6.00526774; IPR=6.00809829;
 MB=3.00021044; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-11 11:17:41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051111-0017-0000-0000-00003EAAAEF1
Message-Id: <1526037444-22876-2-git-send-email-ego@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-11_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805110107
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

A pair of IBM POWER9 SMT4 cores can be fused together to form a
big-core with 8 SMT threads. This can be discovered via the
"ibm,thread-groups" CPU property in the device tree which will
indicate which group of threads that share the L1 cache, translation
cache and instruction data flow.  If there are multiple such group of
threads, then the core is a big-core. The thread-ids of the threads of
the big-core can be obtained by interleaving the thread-ids of the
thread-groups (component small core).

Eg: Threads in the pair of component SMT4 cores of an interleaved
big-core are numbered {0,2,4,6} and {1,3,5,7} respectively.

This patch introduces a function to check if a given device tree node
corresponding to a CPU node represents an interleaved big-core.

This function is invoked during the boot-up to detect the presence of
interleaved big-cores. The presence of such an interleaved big-core is
recorded in a global variable for later use.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/cputhreads.h |  8 +++--
 arch/powerpc/kernel/setup-common.c    | 63 +++++++++++++++++++++++++++++++++--
 2 files changed, 66 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/cputhreads.h b/arch/powerpc/include/asm/cputhreads.h
index d71a909..b706f0a 100644
--- a/arch/powerpc/include/asm/cputhreads.h
+++ b/arch/powerpc/include/asm/cputhreads.h
@@ -23,11 +23,13 @@
 extern int threads_per_core;
 extern int threads_per_subcore;
 extern int threads_shift;
+extern bool has_interleaved_big_core;
 extern cpumask_t threads_core_mask;
 #else
-#define threads_per_core	1
-#define threads_per_subcore	1
-#define threads_shift		0
+#define threads_per_core		1
+#define threads_per_subcore		1
+#define threads_shift			0
+#define has_interleaved_big_core	0
 #define threads_core_mask	(*get_cpu_mask(0))
 #endif
 
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 0af5c11..884dff2 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -408,10 +408,12 @@ void __init check_for_initrd(void)
 #ifdef CONFIG_SMP
 
 int threads_per_core, threads_per_subcore, threads_shift;
+bool has_interleaved_big_core;
 cpumask_t threads_core_mask;
 EXPORT_SYMBOL_GPL(threads_per_core);
 EXPORT_SYMBOL_GPL(threads_per_subcore);
 EXPORT_SYMBOL_GPL(threads_shift);
+EXPORT_SYMBOL_GPL(has_interleaved_big_core);
 EXPORT_SYMBOL_GPL(threads_core_mask);
 
 static void __init cpu_init_thread_core_maps(int tpc)
@@ -436,8 +438,56 @@ static void __init cpu_init_thread_core_maps(int tpc)
 	printk(KERN_DEBUG " (thread shift is %d)\n", threads_shift);
 }
 
-
 u32 *cpu_to_phys_id = NULL;
+/*
+ * check_for_interleaved_big_core - Checks if the core represented by
+ *	 dn is a big-core whose threads are interleavings of the
+ *	 threads of the component small cores.
+ *
+ * @dn: device node corresponding to the core.
+ *
+ * Returns true if the core is a interleaved big-core.
+ * Returns false otherwise.
+ */
+static inline bool check_for_interleaved_big_core(struct device_node *dn)
+{
+	int len, nr_groups, threads_per_group;
+	const __be32 *thread_groups;
+	__be32 *thread_list, *first_cpu_idx;
+	int cur_cpu, next_cpu, i, j;
+
+	thread_groups = of_get_property(dn, "ibm,thread-groups", &len);
+	if (!thread_groups)
+		return false;
+
+	nr_groups = be32_to_cpu(*(thread_groups + 1));
+	if (nr_groups <= 1)
+		return false;
+
+	threads_per_group = be32_to_cpu(*(thread_groups + 2));
+	thread_list = (__be32 *)thread_groups + 3;
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
+		first_cpu_idx = thread_list + i * threads_per_group;
+
+		for (j = 0; j < threads_per_group - 1; j++) {
+			cur_cpu = be32_to_cpu(*(first_cpu_idx + j));
+			next_cpu = be32_to_cpu(*(first_cpu_idx + j + 1));
+			if (next_cpu != cur_cpu + nr_groups)
+				return false;
+		}
+	}
+	return true;
+}
 
 /**
  * setup_cpu_maps - initialize the following cpu maps:
@@ -565,7 +615,16 @@ void __init smp_setup_cpu_maps(void)
 	vdso_data->processorCount = num_present_cpus();
 #endif /* CONFIG_PPC64 */
 
-        /* Initialize CPU <=> thread mapping/
+	dn = of_find_node_by_type(NULL, "cpu");
+	if (dn) {
+		if (check_for_interleaved_big_core(dn)) {
+			has_interleaved_big_core = true;
+			pr_info("Detected interleaved big-cores\n");
+		}
+		of_node_put(dn);
+	}
+
+	/* Initialize CPU <=> thread mapping/
 	 *
 	 * WARNING: We assume that the number of threads is the same for
 	 * every CPU in the system. If that is not the case, then some code
-- 
1.9.4

Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45220C46472
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E65CB21A72
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E65CB21A72
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733297AbeHFSc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:32:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55740 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733208AbeHFScz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:32:55 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w76GFZqm065048
        for <linux-kernel@vger.kernel.org>; Mon, 6 Aug 2018 12:23:04 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kpshprp7f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 12:23:04 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
        Mon, 6 Aug 2018 12:23:03 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 Aug 2018 12:22:59 -0400
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w76GMwVt14549452
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Aug 2018 16:22:58 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A68C6124053;
        Mon,  6 Aug 2018 13:24:05 -0400 (EDT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F6C0124052;
        Mon,  6 Aug 2018 13:24:05 -0400 (EDT)
Received: from sofia.ibm.com (unknown [9.84.220.3])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  6 Aug 2018 13:24:05 -0400 (EDT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id B927F2E3306; Mon,  6 Aug 2018 21:52:55 +0530 (IST)
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
Subject: [PATCH v5 1/2] powerpc: Detect the presence of big-cores via "ibm,thread-groups"
Date:   Mon,  6 Aug 2018 21:52:44 +0530
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1533572565-17357-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1533572565-17357-1-git-send-email-ego@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18080616-2213-0000-0000-000002D614AA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009495; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01070374; UDB=6.00550830; IPR=6.00849588;
 MB=3.00022540; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-06 16:23:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080616-2214-0000-0000-00005B1B57C7
Message-Id: <1533572565-17357-2-git-send-email-ego@linux.vnet.ibm.com>
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

On IBM POWER9, the device tree exposes a property array identifed by
"ibm,thread-groups" which will indicate which groups of threads share a
particular set of resources.

As of today we only have one form of grouping identifying the group of
threads in the core that share the L1 cache, translation cache and
instruction data flow.

This patch defines the helper function to parse the contents of
"ibm,thread-groups" and a new structure to contain the parsed output.

The patch also creates the sysfs file named "small_core_siblings" that
returns the physical ids of the threads in the core that share the L1
cache, translation cache and instruction data flow.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu |   8 ++
 arch/powerpc/include/asm/cputhreads.h              |  22 +++
 arch/powerpc/kernel/setup-common.c                 | 154 +++++++++++++++++++++
 arch/powerpc/kernel/sysfs.c                        |  35 +++++
 4 files changed, 219 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 9c5e7732..52c9b50 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -487,3 +487,11 @@ Description:	Information about CPU vulnerabilities
 		"Not affected"	  CPU is not affected by the vulnerability
 		"Vulnerable"	  CPU is affected and no mitigation in effect
 		"Mitigation: $M"  CPU is affected and mitigation $M is in effect
+
+What: 		/sys/devices/system/cpu/cpu[0-9]+/small_core_siblings
+Date:		06-Aug-2018
+KernelVersion:	v4.19.0
+Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+Description:	List of Physical ids of CPUs which share the L1 cache,
+		translation cache and instruction data-flow with this CPU.
+Values:		Comma separated list of decimal integers.
diff --git a/arch/powerpc/include/asm/cputhreads.h b/arch/powerpc/include/asm/cputhreads.h
index d71a909..33226d7 100644
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
 
@@ -69,12 +71,32 @@ static inline cpumask_t cpu_online_cores_map(void)
 	return cpu_thread_mask_to_cores(cpu_online_mask);
 }
 
+#define MAX_THREAD_LIST_SIZE	8
+struct thread_groups {
+	unsigned int property;
+	unsigned int nr_groups;
+	unsigned int threads_per_group;
+	unsigned int thread_list[MAX_THREAD_LIST_SIZE];
+};
+
 #ifdef CONFIG_SMP
 int cpu_core_index_of_thread(int cpu);
 int cpu_first_thread_of_core(int core);
+int parse_thread_groups(struct device_node *dn, struct thread_groups *tg);
+int get_cpu_thread_group_start(int cpu, struct thread_groups *tg);
 #else
 static inline int cpu_core_index_of_thread(int cpu) { return cpu; }
 static inline int cpu_first_thread_of_core(int core) { return core; }
+static inline int parse_thread_groups(struct device_node *dn,
+				      struct thread_groups *tg)
+{
+	return -ENODATA;
+}
+
+static inline int get_cpu_thread_group_start(int cpu, struct thread_groups *tg)
+{
+	return -1;
+}
 #endif
 
 static inline int cpu_thread_in_core(int cpu)
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 40b44bb..989edc1 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -402,10 +402,12 @@ void __init check_for_initrd(void)
 #ifdef CONFIG_SMP
 
 int threads_per_core, threads_per_subcore, threads_shift;
+bool has_big_cores;
 cpumask_t threads_core_mask;
 EXPORT_SYMBOL_GPL(threads_per_core);
 EXPORT_SYMBOL_GPL(threads_per_subcore);
 EXPORT_SYMBOL_GPL(threads_shift);
+EXPORT_SYMBOL_GPL(has_big_cores);
 EXPORT_SYMBOL_GPL(threads_core_mask);
 
 static void __init cpu_init_thread_core_maps(int tpc)
@@ -433,6 +435,152 @@ static void __init cpu_init_thread_core_maps(int tpc)
 
 u32 *cpu_to_phys_id = NULL;
 
+/*
+ * parse_thread_groups: Parses the "ibm,thread-groups" device tree
+ *                      property for the CPU device node @dn and stores
+ *                      the parsed output in the thread_groups
+ *                      structure @tg.
+ *
+ * @dn: The device node of the CPU device.
+ * @tg: Pointer to a thread group structure into which the parsed
+ *     output of "ibm,thread-groups" is stored.
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
+int parse_thread_groups(struct device_node *dn,
+			struct thread_groups *tg)
+{
+	unsigned int nr_groups, threads_per_group, property;
+	int i;
+	u32 thread_group_array[3 + MAX_THREAD_LIST_SIZE];
+	u32 *thread_list;
+	size_t total_threads;
+	int ret;
+
+	ret = of_property_read_u32_array(dn, "ibm,thread-groups",
+					 thread_group_array, 3);
+
+	if (ret)
+		goto out_err;
+
+	property = thread_group_array[0];
+	nr_groups = thread_group_array[1];
+	threads_per_group = thread_group_array[2];
+	total_threads = nr_groups * threads_per_group;
+
+	ret = of_property_read_u32_array(dn, "ibm,thread-groups",
+					 thread_group_array,
+					 3 + total_threads);
+	if (ret)
+		goto out_err;
+
+	thread_list = &thread_group_array[3];
+
+	for (i = 0 ; i < total_threads; i++)
+		tg->thread_list[i] = thread_list[i];
+
+	tg->property = property;
+	tg->nr_groups = nr_groups;
+	tg->threads_per_group = threads_per_group;
+
+	return 0;
+out_err:
+	tg->property = 0;
+	tg->nr_groups = 0;
+	tg->threads_per_group = 0;
+	return ret;
+}
+
+/*
+ * dt_has_big_core : Parses the device tree property
+ *		    "ibm,thread-groups" for device node pointed by @dn
+ *		    and stores the parsed output in the structure
+ *		    pointed to by @tg.  Then checks if the output in
+ *		    @tg corresponds to a big-core.
+ *
+ * @dn: Device node pointer of the CPU node being checked for a
+ *      big-core.
+ * @tg: Pointer to thread_groups struct in which parsed output of
+ *      "ibm,thread-groups" is recorded.
+ *
+ * Returns true if the @dn points to a big-core.
+ * Returns false if there is an error in parsing "ibm,thread-groups"
+ * or the parsed output doesn't correspond to a big-core.
+ */
+static inline bool dt_has_big_core(struct device_node *dn,
+				   struct thread_groups *tg)
+{
+	if (parse_thread_groups(dn, tg))
+		return false;
+
+	if (tg->property != 1)
+		return false;
+
+	if (tg->nr_groups < 1)
+		return false;
+
+	return true;
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
+int get_cpu_thread_group_start(int cpu, struct thread_groups *tg)
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
 /**
  * setup_cpu_maps - initialize the following cpu maps:
  *                  cpu_possible_mask
@@ -457,6 +605,7 @@ void __init smp_setup_cpu_maps(void)
 	int cpu = 0;
 	int nthreads = 1;
 
+	has_big_cores = true;
 	DBG("smp_setup_cpu_maps()\n");
 
 	cpu_to_phys_id = __va(memblock_alloc(nr_cpu_ids * sizeof(u32),
@@ -467,6 +616,7 @@ void __init smp_setup_cpu_maps(void)
 		const __be32 *intserv;
 		__be32 cpu_be;
 		int j, len;
+		struct thread_groups tg;
 
 		DBG("  * %pOF...\n", dn);
 
@@ -505,6 +655,10 @@ void __init smp_setup_cpu_maps(void)
 			cpu++;
 		}
 
+		if (has_big_cores && !dt_has_big_core(dn, &tg)) {
+			has_big_cores = false;
+		}
+
 		if (cpu >= nr_cpu_ids) {
 			of_node_put(dn);
 			break;
diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 755dc98..f5717de 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -18,6 +18,7 @@
 #include <asm/smp.h>
 #include <asm/pmc.h>
 #include <asm/firmware.h>
+#include <asm/cputhreads.h>
 
 #include "cacheinfo.h"
 #include "setup.h"
@@ -1025,6 +1026,33 @@ static ssize_t show_physical_id(struct device *dev,
 }
 static DEVICE_ATTR(physical_id, 0444, show_physical_id, NULL);
 
+static ssize_t show_small_core_siblings(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct cpu *cpu = container_of(dev, struct cpu, dev);
+	struct device_node *dn = of_get_cpu_node(cpu->dev.id, NULL);
+	struct thread_groups tg;
+	int i, j;
+	ssize_t ret = 0;
+
+	if (parse_thread_groups(dn, &tg))
+		return -ENODATA;
+
+	i = get_cpu_thread_group_start(cpu->dev.id, &tg);
+
+	if (i == -1)
+		return -ENODATA;
+
+	for (j = 0; j < tg.threads_per_group - 1; j++)
+		ret += sprintf(buf + ret, "%d,", tg.thread_list[i + j]);
+
+	ret += sprintf(buf + ret, "%d\n", tg.thread_list[i + j]);
+
+	return ret;
+}
+static DEVICE_ATTR(small_core_siblings, 0444, show_small_core_siblings, NULL);
+
 static int __init topology_init(void)
 {
 	int cpu, r;
@@ -1048,6 +1076,13 @@ static int __init topology_init(void)
 			register_cpu(c, cpu);
 
 			device_create_file(&c->dev, &dev_attr_physical_id);
+
+			if (has_big_cores) {
+				const struct device_attribute *attr =
+				       &dev_attr_small_core_siblings;
+
+			       device_create_file(&c->dev, attr);
+			}
 		}
 	}
 	r = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "powerpc/topology:online",
-- 
1.9.4


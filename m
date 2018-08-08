Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC26C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 07:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B6221708
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 07:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B6221708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeHHJ2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 05:28:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34502 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726721AbeHHJ2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 05:28:08 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7874MIR085164
        for <linux-kernel@vger.kernel.org>; Wed, 8 Aug 2018 03:09:48 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kqtq5aksj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 03:09:47 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Wed, 8 Aug 2018 08:09:45 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 8 Aug 2018 08:09:42 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7879fMw41549966
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Aug 2018 07:09:41 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25BE7AE051;
        Wed,  8 Aug 2018 10:09:35 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E088AE053;
        Wed,  8 Aug 2018 10:09:33 +0100 (BST)
Received: from srikart450.in.ibm.com (unknown [9.77.127.181])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  8 Aug 2018 10:09:32 +0100 (BST)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Andre Wild <wild@linux.vnet.ibm.com>
Subject: [PATCH] sched/topology: Use Identity node only if required
Date:   Wed,  8 Aug 2018 12:39:31 +0530
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18080807-0012-0000-0000-00000296CA63
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080807-0013-0000-0000-000020C9D399
Message-Id: <1533712172-11428-1-git-send-email-srikar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-08_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808080075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With Commit 051f3ca02e46 ("sched/topology: Introduce NUMA identity node
sched domain") scheduler introduces an extra numa level. However that
leads to

 - numa topology on 2 node systems no more marked as NUMA_DIRECT.  After
   this commit, it gets reported as NUMA_BACKPLANE. This is because
   sched_domains_numa_level now equals 2 on 2 node systems.

 - Extra numa sched domain that gets added and degenerated on most
   machines.  The Identity node is only needed on very few systems.
   Also all non-numa systems will end up populating
   sched_domains_numa_distance and sched_domains_numa_masks tables.

 - On shared lpars like powerpc, this extra sched domain creation can
   lead to repeated rcu stalls, sometimes even causing unresponsive
   systems on boot. On such stalls, it was noticed that
   init_sched_groups_capacity() (sg != sd->groups is always true).

INFO: rcu_sched self-detected stall on CPU
 1-....: (240039 ticks this GP) idle=c32/1/4611686018427387906 softirq=782/782 fqs=80012
  (t=240039 jiffies g=6272 c=6271 q=263040)
NMI backtrace for cpu 1
CPU: 1 PID: 1576 Comm: kworker/1:1 Kdump: loaded Tainted: G            E     4.18.0-rc7-master+ #42
Workqueue: events topology_work_fn
Call Trace:
[c00000832132f190] [c0000000009557ac] dump_stack+0xb0/0xf4 (unreliable)
[c00000832132f1d0] [c00000000095ed54] nmi_cpu_backtrace+0x1b4/0x230
[c00000832132f270] [c00000000095efac] nmi_trigger_cpumask_backtrace+0x1dc/0x220
[c00000832132f310] [c00000000005f77c] arch_trigger_cpumask_backtrace+0x2c/0x40
[c00000832132f330] [c0000000001a32d4] rcu_dump_cpu_stacks+0x100/0x15c
[c00000832132f380] [c0000000001a2024] rcu_check_callbacks+0x894/0xaa0
[c00000832132f4a0] [c0000000001ace9c] update_process_times+0x4c/0xa0
[c00000832132f4d0] [c0000000001c5400] tick_sched_handle.isra.13+0x50/0x80
[c00000832132f4f0] [c0000000001c549c] tick_sched_timer+0x6c/0xd0
[c00000832132f530] [c0000000001ae044] __hrtimer_run_queues+0x134/0x360
[c00000832132f5b0] [c0000000001aeea4] hrtimer_interrupt+0x124/0x300
[c00000832132f660] [c000000000024a04] timer_interrupt+0x114/0x2f0
[c00000832132f6c0] [c0000000000090f4] decrementer_common+0x114/0x120
--- interrupt: 901 at __bitmap_weight+0x70/0x100
    LR = __bitmap_weight+0x78/0x100
[c00000832132f9b0] [c0000000009bb738] __func__.61127+0x0/0x20 (unreliable)
[c00000832132fa00] [c00000000016c178] build_sched_domains+0xf98/0x13f0
[c00000832132fb30] [c00000000016d73c] partition_sched_domains+0x26c/0x440
[c00000832132fc20] [c0000000001ee284] rebuild_sched_domains_locked+0x64/0x80
[c00000832132fc50] [c0000000001f11ec] rebuild_sched_domains+0x3c/0x60
[c00000832132fc80] [c00000000007e1c4] topology_work_fn+0x24/0x40
[c00000832132fca0] [c000000000126704] process_one_work+0x1a4/0x470
[c00000832132fd30] [c000000000126a68] worker_thread+0x98/0x540
[c00000832132fdc0] [c00000000012f078] kthread+0x168/0x1b0
[c00000832132fe30] [c00000000000b65c]
ret_from_kernel_thread+0x5c/0x80

Similar problem was earlier also reported at
https://lwn.net/ml/linux-kernel/20180512100233.GB3738@osiris/

One easy alternative would be to use a hint from architectures that have
a liking for identity node.

Fixes: 051f3ca02e46 "Introduce NUMA identity node sched domain"
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 arch/x86/include/asm/topology.h |  2 ++
 arch/x86/kernel/smpboot.c       |  5 +++++
 kernel/sched/topology.c         | 34 ++++++++++++++++++++++++----------
 3 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index c1d2a9892352..524cb900e273 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -79,7 +79,9 @@ extern void setup_node_to_cpumask_map(void);
 
 extern int __node_distance(int, int);
 #define node_distance(a, b) __node_distance(a, b)
+#define arch_supports_identity_node arch_supports_identity_node
 
+extern int arch_supports_identity_node(void);
 #else /* !CONFIG_NUMA */
 
 static inline int numa_node_id(void)
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index db9656e13ea0..08de8ca06232 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1346,6 +1346,11 @@ void __init native_smp_cpus_done(unsigned int max_cpus)
 	mtrr_aps_init();
 }
 
+int arch_supports_identity_node(void)
+{
+	return x86_has_numa_in_package;
+}
+
 static int __initdata setup_possible_cpus = -1;
 static int __init _setup_possible_cpus(char *str)
 {
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 56a0fed30c0a..8f61df23948a 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1322,20 +1322,30 @@ static void init_numa_topology_type(void)
 	}
 }
 
+#ifndef arch_supports_identity_node
+static inline int arch_supports_identity_node(void)
+{
+	return 0;
+}
+#endif
+
 void sched_init_numa(void)
 {
 	int next_distance, curr_distance = node_distance(0, 0);
 	struct sched_domain_topology_level *tl;
-	int level = 0;
+	int numa_in_package, level = 0;
 	int i, j, k;
 
 	sched_domains_numa_distance = kzalloc(sizeof(int) * nr_node_ids, GFP_KERNEL);
 	if (!sched_domains_numa_distance)
 		return;
 
-	/* Includes NUMA identity node at level 0. */
-	sched_domains_numa_distance[level++] = curr_distance;
-	sched_domains_numa_levels = level;
+	numa_in_package = arch_supports_identity_node();
+	if (numa_in_package) {
+		/* Includes NUMA identity node at level 0. */
+		sched_domains_numa_distance[level++] = curr_distance;
+		sched_domains_numa_levels = level;
+	}
 
 	/*
 	 * O(nr_nodes^2) deduplicating selection sort -- in order to find the
@@ -1445,19 +1455,23 @@ void sched_init_numa(void)
 	for (i = 0; sched_domain_topology[i].mask; i++)
 		tl[i] = sched_domain_topology[i];
 
+	j  = 0;
 	/*
 	 * Add the NUMA identity distance, aka single NODE.
 	 */
-	tl[i++] = (struct sched_domain_topology_level){
-		.mask = sd_numa_mask,
-		.numa_level = 0,
-		SD_INIT_NAME(NODE)
-	};
+	if (numa_in_package) {
+		tl[i++] = (struct sched_domain_topology_level){
+			.mask = sd_numa_mask,
+			.numa_level = 0,
+			SD_INIT_NAME(NODE)
+		};
+		j++;
+	}
 
 	/*
 	 * .. and append 'j' levels of NUMA goodness.
 	 */
-	for (j = 1; j < level; i++, j++) {
+	for (; j < level; i++, j++) {
 		tl[i] = (struct sched_domain_topology_level){
 			.mask = sd_numa_mask,
 			.sd_flags = cpu_numa_flags,
-- 
2.12.3


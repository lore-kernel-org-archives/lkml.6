Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8B1C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B6F20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:53:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B6F20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731176AbeIMTDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:03:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33760 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbeIMTDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:03:31 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 405F1D19;
        Thu, 13 Sep 2018 13:53:55 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Manjunatha H R <manjuhr1@in.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 058/197] powerpc/topology: Get topology for shared processors at boot
Date:   Thu, 13 Sep 2018 15:30:07 +0200
Message-Id: <20180913131843.843770685@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

[ Upstream commit 2ea62630681027c455117aa471ea3ab8bb099ead ]

On a shared LPAR, Phyp will not update the CPU associativity at boot
time. Just after the boot system does recognize itself as a shared
LPAR and trigger a request for correct CPU associativity. But by then
the scheduler would have already created/destroyed its sched domains.

This causes
  - Broken load balance across Nodes causing islands of cores.
  - Performance degradation esp if the system is lightly loaded
  - dmesg to wrongly report all CPUs to be in Node 0.
  - Messages in dmesg saying borken topology.
  - With commit 051f3ca02e46 ("sched/topology: Introduce NUMA identity
    node sched domain"), can cause rcu stalls at boot up.

The sched_domains_numa_masks table which is used to generate cpumasks
is only created at boot time just before creating sched domains and
never updated. Hence, its better to get the topology correct before
the sched domains are created.

For example on 64 core Power 8 shared LPAR, dmesg reports

  Brought up 512 CPUs
  Node 0 CPUs: 0-511
  Node 1 CPUs:
  Node 2 CPUs:
  Node 3 CPUs:
  Node 4 CPUs:
  Node 5 CPUs:
  Node 6 CPUs:
  Node 7 CPUs:
  Node 8 CPUs:
  Node 9 CPUs:
  Node 10 CPUs:
  Node 11 CPUs:
  ...
  BUG: arch topology borken
       the DIE domain not a subset of the NUMA domain
  BUG: arch topology borken
       the DIE domain not a subset of the NUMA domain

numactl/lscpu output will still be correct with cores spreading across
all nodes:

  Socket(s):             64
  NUMA node(s):          12
  Model:                 2.0 (pvr 004d 0200)
  Model name:            POWER8 (architected), altivec supported
  Hypervisor vendor:     pHyp
  Virtualization type:   para
  L1d cache:             64K
  L1i cache:             32K
  NUMA node0 CPU(s): 0-7,32-39,64-71,96-103,176-183,272-279,368-375,464-471
  NUMA node1 CPU(s): 8-15,40-47,72-79,104-111,184-191,280-287,376-383,472-479
  NUMA node2 CPU(s): 16-23,48-55,80-87,112-119,192-199,288-295,384-391,480-487
  NUMA node3 CPU(s): 24-31,56-63,88-95,120-127,200-207,296-303,392-399,488-495
  NUMA node4 CPU(s):     208-215,304-311,400-407,496-503
  NUMA node5 CPU(s):     168-175,264-271,360-367,456-463
  NUMA node6 CPU(s):     128-135,224-231,320-327,416-423
  NUMA node7 CPU(s):     136-143,232-239,328-335,424-431
  NUMA node8 CPU(s):     216-223,312-319,408-415,504-511
  NUMA node9 CPU(s):     144-151,240-247,336-343,432-439
  NUMA node10 CPU(s):    152-159,248-255,344-351,440-447
  NUMA node11 CPU(s):    160-167,256-263,352-359,448-455

Currently on this LPAR, the scheduler detects 2 levels of Numa and
created numa sched domains for all CPUs, but it finds a single DIE
domain consisting of all CPUs. Hence it deletes all numa sched
domains.

To address this, detect the shared processor and update topology soon
after CPUs are setup so that correct topology is updated just before
scheduler creates sched domain.

With the fix, dmesg reports:

  numa: Node 0 CPUs: 0-7 32-39 64-71 96-103 176-183 272-279 368-375 464-471
  numa: Node 1 CPUs: 8-15 40-47 72-79 104-111 184-191 280-287 376-383 472-479
  numa: Node 2 CPUs: 16-23 48-55 80-87 112-119 192-199 288-295 384-391 480-487
  numa: Node 3 CPUs: 24-31 56-63 88-95 120-127 200-207 296-303 392-399 488-495
  numa: Node 4 CPUs: 208-215 304-311 400-407 496-503
  numa: Node 5 CPUs: 168-175 264-271 360-367 456-463
  numa: Node 6 CPUs: 128-135 224-231 320-327 416-423
  numa: Node 7 CPUs: 136-143 232-239 328-335 424-431
  numa: Node 8 CPUs: 216-223 312-319 408-415 504-511
  numa: Node 9 CPUs: 144-151 240-247 336-343 432-439
  numa: Node 10 CPUs: 152-159 248-255 344-351 440-447
  numa: Node 11 CPUs: 160-167 256-263 352-359 448-455

and lscpu also reports:

  Socket(s):             64
  NUMA node(s):          12
  Model:                 2.0 (pvr 004d 0200)
  Model name:            POWER8 (architected), altivec supported
  Hypervisor vendor:     pHyp
  Virtualization type:   para
  L1d cache:             64K
  L1i cache:             32K
  NUMA node0 CPU(s): 0-7,32-39,64-71,96-103,176-183,272-279,368-375,464-471
  NUMA node1 CPU(s): 8-15,40-47,72-79,104-111,184-191,280-287,376-383,472-479
  NUMA node2 CPU(s): 16-23,48-55,80-87,112-119,192-199,288-295,384-391,480-487
  NUMA node3 CPU(s): 24-31,56-63,88-95,120-127,200-207,296-303,392-399,488-495
  NUMA node4 CPU(s):     208-215,304-311,400-407,496-503
  NUMA node5 CPU(s):     168-175,264-271,360-367,456-463
  NUMA node6 CPU(s):     128-135,224-231,320-327,416-423
  NUMA node7 CPU(s):     136-143,232-239,328-335,424-431
  NUMA node8 CPU(s):     216-223,312-319,408-415,504-511
  NUMA node9 CPU(s):     144-151,240-247,336-343,432-439
  NUMA node10 CPU(s):    152-159,248-255,344-351,440-447
  NUMA node11 CPU(s):    160-167,256-263,352-359,448-455

Reported-by: Manjunatha H R <manjuhr1@in.ibm.com>
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
[mpe: Trim / format change log]
Tested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/include/asm/topology.h |    5 +++++
 arch/powerpc/kernel/smp.c           |    5 +++++
 arch/powerpc/mm/numa.c              |   20 ++++++++++----------
 3 files changed, 20 insertions(+), 10 deletions(-)

--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -92,6 +92,7 @@ extern int stop_topology_update(void);
 extern int prrn_is_enabled(void);
 extern int find_and_online_cpu_nid(int cpu);
 extern int timed_topology_update(int nsecs);
+extern void __init shared_proc_topology_init(void);
 #else
 static inline int start_topology_update(void)
 {
@@ -113,6 +114,10 @@ static inline int timed_topology_update(
 {
 	return 0;
 }
+
+#ifdef CONFIG_SMP
+static inline void shared_proc_topology_init(void) {}
+#endif
 #endif /* CONFIG_NUMA && CONFIG_PPC_SPLPAR */
 
 #include <asm-generic/topology.h>
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1156,6 +1156,11 @@ void __init smp_cpus_done(unsigned int m
 	if (smp_ops && smp_ops->bringup_done)
 		smp_ops->bringup_done();
 
+	/*
+	 * On a shared LPAR, associativity needs to be requested.
+	 * Hence, get numa topology before dumping cpu topology
+	 */
+	shared_proc_topology_init();
 	dump_numa_cpu_topology();
 
 	/*
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1078,7 +1078,6 @@ static int prrn_enabled;
 static void reset_topology_timer(void);
 static int topology_timer_secs = 1;
 static int topology_inited;
-static int topology_update_needed;
 
 /*
  * Change polling interval for associativity changes.
@@ -1306,11 +1305,8 @@ int numa_update_cpu_topology(bool cpus_l
 	struct device *dev;
 	int weight, new_nid, i = 0;
 
-	if (!prrn_enabled && !vphn_enabled) {
-		if (!topology_inited)
-			topology_update_needed = 1;
+	if (!prrn_enabled && !vphn_enabled && topology_inited)
 		return 0;
-	}
 
 	weight = cpumask_weight(&cpu_associativity_changes_mask);
 	if (!weight)
@@ -1423,7 +1419,6 @@ int numa_update_cpu_topology(bool cpus_l
 
 out:
 	kfree(updates);
-	topology_update_needed = 0;
 	return changed;
 }
 
@@ -1551,6 +1546,15 @@ int prrn_is_enabled(void)
 	return prrn_enabled;
 }
 
+void __init shared_proc_topology_init(void)
+{
+	if (lppaca_shared_proc(get_lppaca())) {
+		bitmap_fill(cpumask_bits(&cpu_associativity_changes_mask),
+			    nr_cpumask_bits);
+		numa_update_cpu_topology(false);
+	}
+}
+
 static int topology_read(struct seq_file *file, void *v)
 {
 	if (vphn_enabled || prrn_enabled)
@@ -1608,10 +1612,6 @@ static int topology_update_init(void)
 		return -ENOMEM;
 
 	topology_inited = 1;
-	if (topology_update_needed)
-		bitmap_fill(cpumask_bits(&cpu_associativity_changes_mask),
-					nr_cpumask_bits);
-
 	return 0;
 }
 device_initcall(topology_update_init);



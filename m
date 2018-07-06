Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEECC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6454023D29
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6454023D29
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933823AbeGFQz6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 12:55:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56805 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933196AbeGFQzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 12:55:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w66GtWow1576019
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 6 Jul 2018 09:55:32 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w66GtWZc1576015;
        Fri, 6 Jul 2018 09:55:32 -0700
Date:   Fri, 6 Jul 2018 09:55:32 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dan Williams <tipbot@zytor.com>
Message-ID: <tip-cc9aec03e58fea4dbab04c05d1e15852f801ca53@git.kernel.org>
Cc:     richard.weiyang@gmail.com, dan.j.williams@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        rientjes@google.com, peterz@infradead.org
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          torvalds@linux-foundation.org, mingo@kernel.org,
          peterz@infradead.org, rientjes@google.com,
          richard.weiyang@gmail.com, dan.j.williams@intel.com,
          hpa@zytor.com
In-Reply-To: <153089328617.27680.14930758266174305832.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <153089328617.27680.14930758266174305832.stgit@dwillia2-desk3.amr.corp.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/numa_emulation: Introduce uniform split
 capability
Git-Commit-ID: cc9aec03e58fea4dbab04c05d1e15852f801ca53
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  cc9aec03e58fea4dbab04c05d1e15852f801ca53
Gitweb:     https://git.kernel.org/tip/cc9aec03e58fea4dbab04c05d1e15852f801ca53
Author:     Dan Williams <dan.j.williams@intel.com>
AuthorDate: Fri, 6 Jul 2018 09:08:06 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 6 Jul 2018 18:48:58 +0200

x86/numa_emulation: Introduce uniform split capability

The current NUMA emulation capabilities for splitting System RAM by a
fixed size or by a set number of nodes may result in some nodes being
larger than others. The implementation prioritizes establishing a
minimum usable memory size over satisfying the requested number of NUMA
nodes.

Introduce a uniform split capability that evenly partitions each
physical NUMA node into N emulated nodes. For example numa=fake=3U
creates 6 emulated nodes total on a system that has 2 physical nodes.

This capability is useful for debugging and evaluating platform
memory-side-cache capabilities as described by the ACPI HMAT (see
5.2.27.5 Memory Side Cache Information Structure in ACPI 6.2a)

Compare numa=fake=6 that results in only 5 nodes being created against
numa=fake=3U which takes the 2 physical nodes and evenly divides them.

numa=fake=6
available: 5 nodes (0-4)
node 0 cpus: 0 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38
node 0 size: 2648 MB
node 0 free: 2443 MB
node 1 cpus: 1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39
node 1 size: 2672 MB
node 1 free: 2442 MB
node 2 cpus: 0 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38
node 2 size: 5291 MB
node 2 free: 5278 MB
node 3 cpus: 1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39
node 3 size: 2677 MB
node 3 free: 2665 MB
node 4 cpus: 1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39
node 4 size: 2676 MB
node 4 free: 2663 MB
node distances:
node   0   1   2   3   4
  0:  10  20  10  20  20
  1:  20  10  20  10  10
  2:  10  20  10  20  20
  3:  20  10  20  10  10
  4:  20  10  20  10  10

numa=fake=3U
available: 6 nodes (0-5)
node 0 cpus: 0 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38
node 0 size: 2900 MB
node 0 free: 2637 MB
node 1 cpus: 0 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38
node 1 size: 3023 MB
node 1 free: 3012 MB
node 2 cpus: 0 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38
node 2 size: 2015 MB
node 2 free: 2004 MB
node 3 cpus: 1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39
node 3 size: 2704 MB
node 3 free: 2522 MB
node 4 cpus: 1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39
node 4 size: 2709 MB
node 4 free: 2698 MB
node 5 cpus: 1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39
node 5 size: 2612 MB
node 5 free: 2601 MB
node distances:
node   0   1   2   3   4   5
  0:  10  10  10  20  20  20
  1:  10  10  10  20  20  20
  2:  10  10  10  20  20  20
  3:  20  20  20  10  10  10
  4:  20  20  20  10  10  10
  5:  20  20  20  10  10  10

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/153089328617.27680.14930758266174305832.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/x86/x86_64/boot-options.txt |   4 ++
 arch/x86/mm/numa_emulation.c              | 105 ++++++++++++++++++++++++------
 2 files changed, 90 insertions(+), 19 deletions(-)

diff --git a/Documentation/x86/x86_64/boot-options.txt b/Documentation/x86/x86_64/boot-options.txt
index 8d109ef67ab6..3a2ba436721a 100644
--- a/Documentation/x86/x86_64/boot-options.txt
+++ b/Documentation/x86/x86_64/boot-options.txt
@@ -156,6 +156,10 @@ NUMA
 		If given as an integer, fills all system RAM with N fake nodes
 		interleaved over physical nodes.
 
+  numa=fake=<N>U
+		If given as an integer followed by 'U', it will divide each
+		physical node into N emulated nodes.
+
 ACPI
 
   acpi=off	Don't enable ACPI
diff --git a/arch/x86/mm/numa_emulation.c b/arch/x86/mm/numa_emulation.c
index 22cbad56acab..b54d52a2d00a 100644
--- a/arch/x86/mm/numa_emulation.c
+++ b/arch/x86/mm/numa_emulation.c
@@ -198,40 +198,73 @@ static u64 __init find_end_of_node(u64 start, u64 max_addr, u64 size)
 	return end;
 }
 
+static u64 uniform_size(u64 max_addr, u64 base, u64 hole, int nr_nodes)
+{
+	unsigned long max_pfn = PHYS_PFN(max_addr);
+	unsigned long base_pfn = PHYS_PFN(base);
+	unsigned long hole_pfns = PHYS_PFN(hole);
+
+	return PFN_PHYS((max_pfn - base_pfn - hole_pfns) / nr_nodes);
+}
+
 /*
  * Sets up fake nodes of `size' interleaved over physical nodes ranging from
  * `addr' to `max_addr'.
  *
  * Returns zero on success or negative on error.
  */
-static int __init split_nodes_size_interleave(struct numa_meminfo *ei,
+static int __init split_nodes_size_interleave_uniform(struct numa_meminfo *ei,
 					      struct numa_meminfo *pi,
-					      u64 addr, u64 max_addr, u64 size)
+					      u64 addr, u64 max_addr, u64 size,
+					      int nr_nodes, struct numa_memblk *pblk,
+					      int nid)
 {
 	nodemask_t physnode_mask = numa_nodes_parsed;
+	int i, ret, uniform = 0;
 	u64 min_size;
-	int nid = 0;
-	int i, ret;
 
-	if (!size)
+	if ((!size && !nr_nodes) || (nr_nodes && !pblk))
 		return -1;
+
 	/*
-	 * The limit on emulated nodes is MAX_NUMNODES, so the size per node is
-	 * increased accordingly if the requested size is too small.  This
-	 * creates a uniform distribution of node sizes across the entire
-	 * machine (but not necessarily over physical nodes).
+	 * In the 'uniform' case split the passed in physical node by
+	 * nr_nodes, in the non-uniform case, ignore the passed in
+	 * physical block and try to create nodes of at least size
+	 * @size.
+	 *
+	 * In the uniform case, split the nodes strictly by physical
+	 * capacity, i.e. ignore holes. In the non-uniform case account
+	 * for holes and treat @size as a minimum floor.
 	 */
-	min_size = (max_addr - addr - mem_hole_size(addr, max_addr)) / MAX_NUMNODES;
-	min_size = max(min_size, FAKE_NODE_MIN_SIZE);
-	if ((min_size & FAKE_NODE_MIN_HASH_MASK) < min_size)
-		min_size = (min_size + FAKE_NODE_MIN_SIZE) &
-						FAKE_NODE_MIN_HASH_MASK;
+	if (!nr_nodes)
+		nr_nodes = MAX_NUMNODES;
+	else {
+		nodes_clear(physnode_mask);
+		node_set(pblk->nid, physnode_mask);
+		uniform = 1;
+	}
+
+	if (uniform) {
+		min_size = uniform_size(max_addr, addr, 0, nr_nodes);
+		size = min_size;
+	} else {
+		/*
+		 * The limit on emulated nodes is MAX_NUMNODES, so the
+		 * size per node is increased accordingly if the
+		 * requested size is too small.  This creates a uniform
+		 * distribution of node sizes across the entire machine
+		 * (but not necessarily over physical nodes).
+		 */
+		min_size = uniform_size(max_addr, addr,
+				mem_hole_size(addr, max_addr), nr_nodes);
+	}
+	min_size = ALIGN(max(min_size, FAKE_NODE_MIN_SIZE), FAKE_NODE_MIN_SIZE);
 	if (size < min_size) {
 		pr_err("Fake node size %LuMB too small, increasing to %LuMB\n",
 			size >> 20, min_size >> 20);
 		size = min_size;
 	}
-	size &= FAKE_NODE_MIN_HASH_MASK;
+	size = ALIGN_DOWN(size, FAKE_NODE_MIN_SIZE);
 
 	/*
 	 * Fill physical nodes with fake nodes of size until there is no memory
@@ -248,10 +281,14 @@ static int __init split_nodes_size_interleave(struct numa_meminfo *ei,
 				node_clear(i, physnode_mask);
 				continue;
 			}
+
 			start = pi->blk[phys_blk].start;
 			limit = pi->blk[phys_blk].end;
 
-			end = find_end_of_node(start, limit, size);
+			if (uniform)
+				end = start + size;
+			else
+				end = find_end_of_node(start, limit, size);
 			/*
 			 * If there won't be at least FAKE_NODE_MIN_SIZE of
 			 * non-reserved memory in ZONE_DMA32 for the next node,
@@ -266,7 +303,8 @@ static int __init split_nodes_size_interleave(struct numa_meminfo *ei,
 			 * next node, this one must extend to the end of the
 			 * physical node.
 			 */
-			if (limit - end - mem_hole_size(end, limit) < size)
+			if ((limit - end - mem_hole_size(end, limit) < size)
+					&& !uniform)
 				end = limit;
 
 			ret = emu_setup_memblk(ei, pi, nid++ % MAX_NUMNODES,
@@ -276,7 +314,15 @@ static int __init split_nodes_size_interleave(struct numa_meminfo *ei,
 				return ret;
 		}
 	}
-	return 0;
+	return nid;
+}
+
+static int __init split_nodes_size_interleave(struct numa_meminfo *ei,
+					      struct numa_meminfo *pi,
+					      u64 addr, u64 max_addr, u64 size)
+{
+	return split_nodes_size_interleave_uniform(ei, pi, addr, max_addr, size,
+			0, NULL, NUMA_NO_NODE);
 }
 
 int __init setup_emu2phys_nid(int *dfl_phys_nid)
@@ -346,7 +392,28 @@ void __init numa_emulation(struct numa_meminfo *numa_meminfo, int numa_dist_cnt)
 	 * the fixed node size.  Otherwise, if it is just a single number N,
 	 * split the system RAM into N fake nodes.
 	 */
-	if (strchr(emu_cmdline, 'M') || strchr(emu_cmdline, 'G')) {
+	if (strchr(emu_cmdline, 'U')) {
+		nodemask_t physnode_mask = numa_nodes_parsed;
+		unsigned long n;
+		int nid = 0;
+
+		n = simple_strtoul(emu_cmdline, &emu_cmdline, 0);
+		ret = -1;
+		for_each_node_mask(i, physnode_mask) {
+			ret = split_nodes_size_interleave_uniform(&ei, &pi,
+					pi.blk[i].start, pi.blk[i].end, 0,
+					n, &pi.blk[i], nid);
+			if (ret < 0)
+				break;
+			if (ret < n) {
+				pr_info("%s: phys: %d only got %d of %ld nodes, failing\n",
+						__func__, i, ret, n);
+				ret = -1;
+				break;
+			}
+			nid = ret;
+		}
+	} else if (strchr(emu_cmdline, 'M') || strchr(emu_cmdline, 'G')) {
 		u64 size;
 
 		size = memparse(emu_cmdline, &emu_cmdline);

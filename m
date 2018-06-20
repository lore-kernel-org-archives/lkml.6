Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED51C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F7A20836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:20:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F7A20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754278AbeFTAUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 20:20:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37069 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754264AbeFTAUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 20:20:41 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5K0KYbl3297254
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 19 Jun 2018 17:20:34 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5K0KYM23297251;
        Tue, 19 Jun 2018 17:20:34 -0700
Date:   Tue, 19 Jun 2018 17:20:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-dd53bdb91ab6df66aad039bfde93381ba7232939@git.kernel.org>
Cc:     mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        reinette.chatre@intel.com, linux-kernel@vger.kernel.org
Reply-To: reinette.chatre@intel.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com
In-Reply-To: <f85d246c1ea699cf0aa9ba9addc5095a3e112a71.1527593970.git.reinette.chatre@intel.com>
References: <f85d246c1ea699cf0aa9ba9addc5095a3e112a71.1527593970.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Documentation for Cache
 Pseudo-Locking
Git-Commit-ID: dd53bdb91ab6df66aad039bfde93381ba7232939
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

Commit-ID:  dd53bdb91ab6df66aad039bfde93381ba7232939
Gitweb:     https://git.kernel.org/tip/dd53bdb91ab6df66aad039bfde93381ba7232939
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Tue, 29 May 2018 05:57:40 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 20 Jun 2018 00:56:32 +0200

x86/intel_rdt: Documentation for Cache Pseudo-Locking

Add description of Cache Pseudo-Locking feature, its interface, as well as
an example of its usage.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/f85d246c1ea699cf0aa9ba9addc5095a3e112a71.1527593970.git.reinette.chatre@intel.com

---
 Documentation/x86/intel_rdt_ui.txt | 280 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 278 insertions(+), 2 deletions(-)

diff --git a/Documentation/x86/intel_rdt_ui.txt b/Documentation/x86/intel_rdt_ui.txt
index de913e00e922..bcd0a6d2fcf8 100644
--- a/Documentation/x86/intel_rdt_ui.txt
+++ b/Documentation/x86/intel_rdt_ui.txt
@@ -29,7 +29,11 @@ mount options are:
 L2 and L3 CDP are controlled seperately.
 
 RDT features are orthogonal. A particular system may support only
-monitoring, only control, or both monitoring and control.
+monitoring, only control, or both monitoring and control.  Cache
+pseudo-locking is a unique way of using cache control to "pin" or
+"lock" data in the cache. Details can be found in
+"Cache Pseudo-Locking".
+
 
 The mount succeeds if either of allocation or monitoring is present, but
 only those files and directories supported by the system will be created.
@@ -86,6 +90,8 @@ related to allocation:
 			      and available for sharing.
 			"E" - Corresponding region is used exclusively by
 			      one resource group. No sharing allowed.
+			"P" - Corresponding region is pseudo-locked. No
+			      sharing allowed.
 
 Memory bandwitdh(MB) subdirectory contains the following files
 with respect to allocation:
@@ -192,7 +198,12 @@ When control is enabled all CTRL_MON groups will also contain:
 "mode":
 	The "mode" of the resource group dictates the sharing of its
 	allocations. A "shareable" resource group allows sharing of its
-	allocations while an "exclusive" resource group does not.
+	allocations while an "exclusive" resource group does not. A
+	cache pseudo-locked region is created by first writing
+	"pseudo-locksetup" to the "mode" file before writing the cache
+	pseudo-locked region's schemata to the resource group's "schemata"
+	file. On successful pseudo-locked region creation the mode will
+	automatically change to "pseudo-locked".
 
 When monitoring is enabled all MON groups will also contain:
 
@@ -410,6 +421,170 @@ L3CODE:0=fffff;1=fffff;2=fffff;3=fffff
 L3DATA:0=fffff;1=fffff;2=3c0;3=fffff
 L3CODE:0=fffff;1=fffff;2=fffff;3=fffff
 
+Cache Pseudo-Locking
+--------------------
+CAT enables a user to specify the amount of cache space that an
+application can fill. Cache pseudo-locking builds on the fact that a
+CPU can still read and write data pre-allocated outside its current
+allocated area on a cache hit. With cache pseudo-locking, data can be
+preloaded into a reserved portion of cache that no application can
+fill, and from that point on will only serve cache hits. The cache
+pseudo-locked memory is made accessible to user space where an
+application can map it into its virtual address space and thus have
+a region of memory with reduced average read latency.
+
+The creation of a cache pseudo-locked region is triggered by a request
+from the user to do so that is accompanied by a schemata of the region
+to be pseudo-locked. The cache pseudo-locked region is created as follows:
+- Create a CAT allocation CLOSNEW with a CBM matching the schemata
+  from the user of the cache region that will contain the pseudo-locked
+  memory. This region must not overlap with any current CAT allocation/CLOS
+  on the system and no future overlap with this cache region is allowed
+  while the pseudo-locked region exists.
+- Create a contiguous region of memory of the same size as the cache
+  region.
+- Flush the cache, disable hardware prefetchers, disable preemption.
+- Make CLOSNEW the active CLOS and touch the allocated memory to load
+  it into the cache.
+- Set the previous CLOS as active.
+- At this point the closid CLOSNEW can be released - the cache
+  pseudo-locked region is protected as long as its CBM does not appear in
+  any CAT allocation. Even though the cache pseudo-locked region will from
+  this point on not appear in any CBM of any CLOS an application running with
+  any CLOS will be able to access the memory in the pseudo-locked region since
+  the region continues to serve cache hits.
+- The contiguous region of memory loaded into the cache is exposed to
+  user-space as a character device.
+
+Cache pseudo-locking increases the probability that data will remain
+in the cache via carefully configuring the CAT feature and controlling
+application behavior. There is no guarantee that data is placed in
+cache. Instructions like INVD, WBINVD, CLFLUSH, etc. can still evict
+“locked” data from cache. Power management C-states may shrink or
+power off cache. It is thus recommended to limit the processor maximum
+C-state, for example, by setting the processor.max_cstate kernel parameter.
+
+It is required that an application using a pseudo-locked region runs
+with affinity to the cores (or a subset of the cores) associated
+with the cache on which the pseudo-locked region resides. A sanity check
+within the code will not allow an application to map pseudo-locked memory
+unless it runs with affinity to cores associated with the cache on which the
+pseudo-locked region resides. The sanity check is only done during the
+initial mmap() handling, there is no enforcement afterwards and the
+application self needs to ensure it remains affine to the correct cores.
+
+Pseudo-locking is accomplished in two stages:
+1) During the first stage the system administrator allocates a portion
+   of cache that should be dedicated to pseudo-locking. At this time an
+   equivalent portion of memory is allocated, loaded into allocated
+   cache portion, and exposed as a character device.
+2) During the second stage a user-space application maps (mmap()) the
+   pseudo-locked memory into its address space.
+
+Cache Pseudo-Locking Interface
+------------------------------
+A pseudo-locked region is created using the resctrl interface as follows:
+
+1) Create a new resource group by creating a new directory in /sys/fs/resctrl.
+2) Change the new resource group's mode to "pseudo-locksetup" by writing
+   "pseudo-locksetup" to the "mode" file.
+3) Write the schemata of the pseudo-locked region to the "schemata" file. All
+   bits within the schemata should be "unused" according to the "bit_usage"
+   file.
+
+On successful pseudo-locked region creation the "mode" file will contain
+"pseudo-locked" and a new character device with the same name as the resource
+group will exist in /dev/pseudo_lock. This character device can be mmap()'ed
+by user space in order to obtain access to the pseudo-locked memory region.
+
+An example of cache pseudo-locked region creation and usage can be found below.
+
+Cache Pseudo-Locking Debugging Interface
+---------------------------------------
+The pseudo-locking debugging interface is enabled by default (if
+CONFIG_DEBUG_FS is enabled) and can be found in /sys/kernel/debug/resctrl.
+
+There is no explicit way for the kernel to test if a provided memory
+location is present in the cache. The pseudo-locking debugging interface uses
+the tracing infrastructure to provide two ways to measure cache residency of
+the pseudo-locked region:
+1) Memory access latency using the pseudo_lock_mem_latency tracepoint. Data
+   from these measurements are best visualized using a hist trigger (see
+   example below). In this test the pseudo-locked region is traversed at
+   a stride of 32 bytes while hardware prefetchers and preemption
+   are disabled. This also provides a substitute visualization of cache
+   hits and misses.
+2) Cache hit and miss measurements using model specific precision counters if
+   available. Depending on the levels of cache on the system the pseudo_lock_l2
+   and pseudo_lock_l3 tracepoints are available.
+   WARNING: triggering this  measurement uses from two (for just L2
+   measurements) to four (for L2 and L3 measurements) precision counters on
+   the system, if any other measurements are in progress the counters and
+   their corresponding event registers will be clobbered.
+
+When a pseudo-locked region is created a new debugfs directory is created for
+it in debugfs as /sys/kernel/debug/resctrl/<newdir>. A single
+write-only file, pseudo_lock_measure, is present in this directory. The
+measurement on the pseudo-locked region depends on the number, 1 or 2,
+written to this debugfs file. Since the measurements are recorded with the
+tracing infrastructure the relevant tracepoints need to be enabled before the
+measurement is triggered.
+
+Example of latency debugging interface:
+In this example a pseudo-locked region named "newlock" was created. Here is
+how we can measure the latency in cycles of reading from this region and
+visualize this data with a histogram that is available if CONFIG_HIST_TRIGGERS
+is set:
+# :> /sys/kernel/debug/tracing/trace
+# echo 'hist:keys=latency' > /sys/kernel/debug/tracing/events/resctrl/pseudo_lock_mem_latency/trigger
+# echo 1 > /sys/kernel/debug/tracing/events/resctrl/pseudo_lock_mem_latency/enable
+# echo 1 > /sys/kernel/debug/resctrl/newlock/pseudo_lock_measure
+# echo 0 > /sys/kernel/debug/tracing/events/resctrl/pseudo_lock_mem_latency/enable
+# cat /sys/kernel/debug/tracing/events/resctrl/pseudo_lock_mem_latency/hist
+
+# event histogram
+#
+# trigger info: hist:keys=latency:vals=hitcount:sort=hitcount:size=2048 [active]
+#
+
+{ latency:        456 } hitcount:          1
+{ latency:         50 } hitcount:         83
+{ latency:         36 } hitcount:         96
+{ latency:         44 } hitcount:        174
+{ latency:         48 } hitcount:        195
+{ latency:         46 } hitcount:        262
+{ latency:         42 } hitcount:        693
+{ latency:         40 } hitcount:       3204
+{ latency:         38 } hitcount:       3484
+
+Totals:
+    Hits: 8192
+    Entries: 9
+   Dropped: 0
+
+Example of cache hits/misses debugging:
+In this example a pseudo-locked region named "newlock" was created on the L2
+cache of a platform. Here is how we can obtain details of the cache hits
+and misses using the platform's precision counters.
+
+# :> /sys/kernel/debug/tracing/trace
+# echo 1 > /sys/kernel/debug/tracing/events/resctrl/pseudo_lock_l2/enable
+# echo 2 > /sys/kernel/debug/resctrl/newlock/pseudo_lock_measure
+# echo 0 > /sys/kernel/debug/tracing/events/resctrl/pseudo_lock_l2/enable
+# cat /sys/kernel/debug/tracing/trace
+
+# tracer: nop
+#
+#                              _-----=> irqs-off
+#                             / _----=> need-resched
+#                            | / _---=> hardirq/softirq
+#                            || / _--=> preempt-depth
+#                            ||| /     delay
+#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
+#              | |       |   ||||       |         |
+ pseudo_lock_mea-1672  [002] ....  3132.860500: pseudo_lock_l2: hits=4097 miss=0
+
+
 Examples for RDT allocation usage:
 
 Example 1
@@ -596,6 +771,107 @@ A resource group cannot be forced to overlap with an exclusive resource group:
 # cat info/last_cmd_status
 overlaps with exclusive group
 
+Example of Cache Pseudo-Locking
+-------------------------------
+Lock portion of L2 cache from cache id 1 using CBM 0x3. Pseudo-locked
+region is exposed at /dev/pseudo_lock/newlock that can be provided to
+application for argument to mmap().
+
+# mount -t resctrl resctrl /sys/fs/resctrl/
+# cd /sys/fs/resctrl
+
+Ensure that there are bits available that can be pseudo-locked, since only
+unused bits can be pseudo-locked the bits to be pseudo-locked needs to be
+removed from the default resource group's schemata:
+# cat info/L2/bit_usage
+0=SSSSSSSS;1=SSSSSSSS
+# echo 'L2:1=0xfc' > schemata
+# cat info/L2/bit_usage
+0=SSSSSSSS;1=SSSSSS00
+
+Create a new resource group that will be associated with the pseudo-locked
+region, indicate that it will be used for a pseudo-locked region, and
+configure the requested pseudo-locked region capacity bitmask:
+
+# mkdir newlock
+# echo pseudo-locksetup > newlock/mode
+# echo 'L2:1=0x3' > newlock/schemata
+
+On success the resource group's mode will change to pseudo-locked, the
+bit_usage will reflect the pseudo-locked region, and the character device
+exposing the pseudo-locked region will exist:
+
+# cat newlock/mode
+pseudo-locked
+# cat info/L2/bit_usage
+0=SSSSSSSS;1=SSSSSSPP
+# ls -l /dev/pseudo_lock/newlock
+crw------- 1 root root 243, 0 Apr  3 05:01 /dev/pseudo_lock/newlock
+
+/*
+ * Example code to access one page of pseudo-locked cache region
+ * from user space.
+ */
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/mman.h>
+
+/*
+ * It is required that the application runs with affinity to only
+ * cores associated with the pseudo-locked region. Here the cpu
+ * is hardcoded for convenience of example.
+ */
+static int cpuid = 2;
+
+int main(int argc, char *argv[])
+{
+	cpu_set_t cpuset;
+	long page_size;
+	void *mapping;
+	int dev_fd;
+	int ret;
+
+	page_size = sysconf(_SC_PAGESIZE);
+
+	CPU_ZERO(&cpuset);
+	CPU_SET(cpuid, &cpuset);
+	ret = sched_setaffinity(0, sizeof(cpuset), &cpuset);
+	if (ret < 0) {
+		perror("sched_setaffinity");
+		exit(EXIT_FAILURE);
+	}
+
+	dev_fd = open("/dev/pseudo_lock/newlock", O_RDWR);
+	if (dev_fd < 0) {
+		perror("open");
+		exit(EXIT_FAILURE);
+	}
+
+	mapping = mmap(0, page_size, PROT_READ | PROT_WRITE, MAP_SHARED,
+		       dev_fd, 0);
+	if (mapping == MAP_FAILED) {
+		perror("mmap");
+		close(dev_fd);
+		exit(EXIT_FAILURE);
+	}
+
+	/* Application interacts with pseudo-locked memory @mapping */
+
+	ret = munmap(mapping, page_size);
+	if (ret < 0) {
+		perror("munmap");
+		close(dev_fd);
+		exit(EXIT_FAILURE);
+	}
+
+	close(dev_fd);
+	exit(EXIT_SUCCESS);
+}
+
 Locking between applications
 ----------------------------
 

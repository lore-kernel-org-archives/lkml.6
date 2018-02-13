Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966193AbeBMXtf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 18:49:35 -0500
Received: from mga17.intel.com ([192.55.52.151]:53392 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966102AbeBMXtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 18:49:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,509,1511856000";
   d="scan'208";a="29822293"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com
Cc: gavin.hindman@intel.com, vikas.shivappa@linux.intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [RFC PATCH V2 01/22] x86/intel_rdt: Documentation for Cache Pseudo-Locking
Date: Tue, 13 Feb 2018 07:46:45 -0800
Message-Id: <9416db57e47e2040a7108ba269f5432d0c91f1f7.1518443616.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1518443616.git.reinette.chatre@intel.com>
References: <cover.1518443616.git.reinette.chatre@intel.com>
MIME-Version: 1.0
In-Reply-To: <cover.1518443616.git.reinette.chatre@intel.com>
References: <cover.1518443616.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description of Cache Pseudo-Locking feature, its interface,
as well as an example of its usage.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 Documentation/x86/intel_rdt_ui.txt | 229 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 228 insertions(+), 1 deletion(-)

diff --git a/Documentation/x86/intel_rdt_ui.txt b/Documentation/x86/intel_rdt_ui.txt
index 756fd76b78a6..bb3d6fe0a3e4 100644
--- a/Documentation/x86/intel_rdt_ui.txt
+++ b/Documentation/x86/intel_rdt_ui.txt
@@ -27,7 +27,10 @@ mount options are:
 L2 and L3 CDP are controlled seperately.
 
 RDT features are orthogonal. A particular system may support only
-monitoring, only control, or both monitoring and control.
+monitoring, only control, or both monitoring and control. Cache
+pseudo-locking is a unique way of using cache control to "pin" or
+"lock" data in the cache. Details can be found in
+"Cache Pseudo-Locking".
 
 The mount succeeds if either of allocation or monitoring is present, but
 only those files and directories supported by the system will be created.
@@ -329,6 +332,149 @@ L3CODE:0=fffff;1=fffff;2=fffff;3=fffff
 L3DATA:0=fffff;1=fffff;2=3c0;3=fffff
 L3CODE:0=fffff;1=fffff;2=fffff;3=fffff
 
+Cache Pseudo-Locking
+--------------------
+CAT enables a user to specify the amount of cache space into which an
+application can fill. Cache pseudo-locking builds on the fact that a
+CPU can still read and write data pre-allocated outside its current
+allocated area on a cache hit. With cache pseudo-locking, data can be
+preloaded into a reserved portion of cache that no application can
+fill, and from that point on will only serve cache hits. The cache
+pseudo-locked memory is made accessible to user space where an
+application can map it into its virtual address space and thus have
+a region of memory with reduced average read latency.
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
+with the cache on which the pseudo-locked region resides. This is
+enforced by the implementation.
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
+Platforms supporting cache pseudo-locking will expose a new
+"/sys/fs/restrl/pseudo_lock" directory after successful mount of the
+resctrl filesystem. Initially this directory will contain a single file,
+"avail" that contains the schemata, one line per resource, of cache region
+available for pseudo-locking.
+
+A pseudo-locked region is created by creating a new directory within
+/sys/fs/resctrl/pseudo_lock. On success two new files will appear in
+the directory:
+
+"schemata":
+	Shows the schemata representing the pseudo-locked cache region.
+	User writes schemata of requested locked area to file.
+	Only one id of single resource accepted - can only lock from
+	single cache instance. Writing of schemata to this file will
+	return success on successful pseudo-locked region setup.
+"size":
+	After successful pseudo-locked region setup this read-only file
+	will contain the size in bytes of pseudo-locked region.
+
+Cache Pseudo-Locking Debugging Interface
+---------------------------------------
+The pseudo-locking debugging interface is enabled with
+CONFIG_INTEL_RDT_DEBUGFS and can be found in
+/sys/kernel/debug/resctrl/pseudo_lock.
+
+There is no explicit way for the kernel to test if a provided memory
+location is present in the cache. The pseudo-locking debugging interface uses
+the tracing infrastructure to provide two ways to measure cache residency of
+the pseudo-locked region:
+1) Memory access latency using the pseudo_lock_mem_latency tracepoint. Data
+   from these measurements are best visualized using a hist trigger (see
+   example below). In this test the pseudo-locked region is traversed at
+   a stride of 32 bytes while hardware prefetchers, preemption, and interrupts
+   are disabled. This also provides a substitute visualization of cache
+   hits and misses.
+2) Cache hit and miss measurements using model specific precision counters if
+   available. Depending on the levels of cache on the system the following
+   tracepoints are available: pseudo_lock_l2_hits, pseudo_lock_l2_miss,
+   pseudo_lock_l3_miss, and pseudo_lock_l3_hits. WARNING: triggering this
+   measurement uses from two (for just L2 measurements) to four (for L2 and L3
+   measurements) precision counters on the system, if any other
+   measurements are in progress the counters and their corresponding event
+   registers will be clobbered.
+
+When a pseudo-locked region is created a new debugfs directory is created for
+it in debugfs as /sys/kernel/debug/resctrl/pseudo_lock/<newdir>. A single
+write-only file, measure_trigger, is present in this directory. The
+measurement on the pseudo-locked region depends on the number, 1 or 2,
+written to this debugfs file. Since the measurements are recorded with the
+tracing infrastructure the relevant tracepoints need to be enabled before the
+measurement is triggered.
+
+Example of latency debugging interface:
+In this example a pseudo-locked region named "newlock" was created. Here is
+how we can measure the latency in cycles of reading from this region:
+# :> /sys/kernel/debug/tracing/trace
+# echo 'hist:keys=latency' > /sys/kernel/debug/tracing/events/pseudo_lock/pseudo_lock_mem_latency/trigger
+# echo 1 > /sys/kernel/debug/tracing/events/pseudo_lock/pseudo_lock_mem_latency/enable
+# echo 1 > /sys/kernel/debug/resctrl/pseudo_lock/newlock/measure_trigger
+# echo 0 > /sys/kernel/debug/tracing/events/pseudo_lock/pseudo_lock_mem_latency/enable
+# cat /sys/kernel/debug/tracing/events/pseudo_lock/pseudo_lock_mem_latency/hist
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
+    Dropped: 0
+
+Example of cache hits/misses debugging:
+In this example a pseudo-locked region named "newlock" was created on the L2
+cache of a platform. Here is how we can obtain details of the cache hits
+and misses using the platform's precision counters.
+
+# :> /sys/kernel/debug/tracing/trace
+# echo 1 > /sys/kernel/debug/tracing/events/pseudo_lock/pseudo_lock_l2_hits/enable
+# echo 1 > /sys/kernel/debug/tracing/events/pseudo_lock/pseudo_lock_l2_miss/enable
+# echo 2 > /sys/kernel/debug/resctrl/pseudo_lock/newlock/measure_trigger
+# echo 0 > /sys/kernel/debug/tracing/events/pseudo_lock/pseudo_lock_l2_hits/enable
+# echo 0 > /sys/kernel/debug/tracing/events/pseudo_lock/pseudo_lock_l2_miss/enable
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
+ pseudo_lock_mea-1039  [002] ....  1598.825180: pseudo_lock_l2_hits: L2 hits=4097
+ pseudo_lock_mea-1039  [002] ....  1598.825184: pseudo_lock_l2_miss: L2 miss=2
+
 Examples for RDT allocation usage:
 
 Example 1
@@ -443,6 +589,87 @@ siblings and only the real time threads are scheduled on the cores 4-7.
 
 # echo F0 > p0/cpus
 
+Example of Cache Pseudo-Locking
+-------------------------------
+Lock portion of L2 cache from cache id 1 using CBM 0x3. Pseudo-locked
+region is exposed at /dev/pseudo_lock/newlock that can be provided to
+application for argument to mmap().
+
+# cd /sys/fs/resctrl/pseudo_lock
+# cat avail
+L2:0=ff;1=ff
+# mkdir newlock
+# cd newlock
+# cat schemata
+# L2:uninitialized
+# echo ‘L2:1=3’ > schemata
+# ls -l /dev/pseudo_lock/newlock
+crw------- 1 root root 244, 0 Mar 30 03:00 /dev/pseudo_lock/newlock
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
 4) Locking between applications
 
 Certain operations on the resctrl filesystem, composed of read/writes
-- 
2.13.6

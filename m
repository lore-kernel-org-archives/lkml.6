Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752216AbeC2W3X (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 18:29:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:60712 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751209AbeC2W3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 18:29:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,378,1517904000";
   d="scan'208";a="28690090"
From: Vikas Shivappa <vikas.shivappa@linux.intel.com>
To: vikas.shivappa@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, fenghua.yu@intel.com,
        sai.praneeth.prakhya@intel.com, x86@kernel.org, tglx@linutronix.de,
        hpa@zytor.com
Cc: linux-kernel@vger.kernel.org, ak@linux.intel.com,
        vikas.shivappa@linux.intel.com
Subject: [PATCH 1/6] x86/intel_rdt/mba_sc: Add documentation for MBA software controller
Date: Thu, 29 Mar 2018 15:26:11 -0700
Message-Id: <1522362376-3505-2-git-send-email-vikas.shivappa@linux.intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1522362376-3505-1-git-send-email-vikas.shivappa@linux.intel.com>
References: <1522362376-3505-1-git-send-email-vikas.shivappa@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation about usage which includes the "schemata" format and
use case for MBA software controller.

Signed-off-by: Vikas Shivappa <vikas.shivappa@linux.intel.com>
---
 Documentation/x86/intel_rdt_ui.txt | 63 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/Documentation/x86/intel_rdt_ui.txt b/Documentation/x86/intel_rdt_ui.txt
index 71c3098..3b9634e 100644
--- a/Documentation/x86/intel_rdt_ui.txt
+++ b/Documentation/x86/intel_rdt_ui.txt
@@ -315,6 +315,60 @@ Memory b/w domain is L3 cache.
 
 	MB:<cache_id0>=bandwidth0;<cache_id1>=bandwidth1;...
 
+Memory bandwidth(b/w) in MegaBytes
+----------------------------------
+
+Memory bandwidth is a core specific mechanism which means that when the
+Memory b/w percentage is specified in the schemata per package it
+actually is applied on a per core basis via IA32_MBA_THRTL_MSR
+interface. This may lead to confusion in scenarios below:
+
+1. User may not see increase in actual b/w when percentage values are
+   increased:
+
+This can occur when aggregate L2 external b/w is more than L3 external
+b/w. Consider an SKL SKU with 24 cores on a package and where L2
+external b/w is 10GBps (hence aggregate L2 external b/w is 240GBps) and
+L3 external b/w is 100GBps. Now a workload with '20 threads, having 50%
+b/w, each consuming 5GBps' consumes the max L3 b/w of 100GBps although
+the percentage value specified is only 50% << 100%. Hence increasing
+the b/w percentage will not yeild any more b/w. This is because
+although the L2 external b/w still has capacity, the L3 external b/w
+is fully used. Also note that this would be dependent on number of
+cores the benchmark is run on.
+
+2. Same b/w percentage may mean different actual b/w depending on # of
+   threads:
+
+For the same SKU in #1, a 'single thread, with 10% b/w' and '4 thread,
+with 10% b/w' can consume upto 10GBps and 40GBps although they have same
+percentage b/w of 10%. This is simply because as threads start using
+more cores in an rdtgroup, the actual b/w may increase or vary although
+user specified b/w percentage is same.
+
+In order to mitigate this and make the interface more user friendly, we
+can let the user specify the max bandwidth per rdtgroup in bytes(or mega
+bytes). The kernel underneath would use a software feedback mechanism or
+a "Software Controller" which reads the actual b/w using MBM counters
+and adjust the memowy bandwidth percentages to ensure the "actual b/w
+< user b/w".
+
+The legacy behaviour is default and user can switch to the "MBA software
+controller" mode using a mount option 'mba_MB'.
+
+To use the feature mount the file system using mba_MB option:
+ 
+# mount -t resctrl resctrl [-o cdp[,cdpl2][mba_MB]] /sys/fs/resctrl
+
+The schemata format is below:
+
+Memory b/w Allocation in Megabytes
+----------------------------------
+
+Memory b/w domain is L3 cache.
+
+	MB:<cache_id0>=bw_MB0;<cache_id1>=bw_MB1;...
+
 Reading/writing the schemata file
 ---------------------------------
 Reading the schemata file will show the state of all resources
@@ -358,6 +412,15 @@ allocations can overlap or not. The allocations specifies the maximum
 b/w that the group may be able to use and the system admin can configure
 the b/w accordingly.
 
+If the MBA is specified in MB(megabytes) then user can enter the max b/w in MB
+rather than the percentage values.
+
+# echo "L3:0=3;1=c\nMB:0=1024;1=500" > /sys/fs/resctrl/p0/schemata
+# echo "L3:0=3;1=3\nMB:0=1024;1=500" > /sys/fs/resctrl/p1/schemata
+
+In the above example the tasks in "p1" and "p0" on socket 0 would use a max b/w
+of 1024MB where as on socket 1 they would use 500MB.
+
 Example 2
 ---------
 Again two sockets, but this time with a more realistic 20-bit mask.
-- 
1.9.1

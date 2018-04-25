Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756017AbeDYSMh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 14:12:37 -0400
Received: from mga02.intel.com ([134.134.136.20]:41708 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755712AbeDYSM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 14:12:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,327,1520924400";
   d="scan'208";a="35243603"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V3 01/39] x86/intel_rdt: Document new mode, size, and bit_usage
Date: Wed, 25 Apr 2018 03:09:37 -0700
Message-Id: <40573e1687803b6aca3ad7ae9ecc8636fbe76c8c.1524649902.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
References: <cover.1524649902.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
References: <cover.1524649902.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default resource groups allow sharing of their cache allocations.
There is nothing that prevents a resource group from configuring
a cache allocation that overlaps with that of an existing resource
group.

To enable resource groups to specify that their cache allocations cannot
be shared a resource group "mode" is introduced to support two possible
modes: "shareable" and "exclusive". A "shareable" resource group allows
sharing of its cache allocations, an "exclusive" resource group does
not. A new resctrl file "mode" associated with each resource group is
used to communicate its (the associated resource group's) mode setting
and allow the mode to be changed.  The new "mode" file as well as two
other resctrl files, "bit_usage" and "size", are introduced in this
series.

Add documentation for the three new resctrl files as well as one example
demonstrating their use.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 Documentation/x86/intel_rdt_ui.txt | 99 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 2 deletions(-)

diff --git a/Documentation/x86/intel_rdt_ui.txt b/Documentation/x86/intel_rdt_ui.txt
index 756fd76b78a6..f1210ac40e3d 100644
--- a/Documentation/x86/intel_rdt_ui.txt
+++ b/Documentation/x86/intel_rdt_ui.txt
@@ -63,6 +63,27 @@ related to allocation:
 			some platforms support devices that have their
 			own settings for cache use which can over-ride
 			these bits.
+"bit_usage":		Annotated capacity bitmasks showing how all
+			instances of the resource are used. The legend is:
+			"0" - Corresponding region is unused. When the system's
+			      resources have been allocated and a "0" is found
+			      in "bit_usage" it is a sign that resources are
+			      wasted.
+			"H" - Corresponding region is used by hardware only
+			      but available for software use. If a resource
+			      has bits set in "shareable_bits" but not all
+			      of these bits appear in the resource groups'
+			      schematas then the bits appearing in
+			      "shareable_bits" but no resource group will
+			      be marked as "H".
+			"X" - Corresponding region is available for sharing and
+			      used by hardware and software. These are the
+			      bits that appear in "shareable_bits" as
+			      well as a resource group's allocation.
+			"S" - Corresponding region is used by software
+			      and available for sharing.
+			"E" - Corresponding region is used exclusively by
+			      one resource group. No sharing allowed.
 
 Memory bandwitdh(MB) subdirectory contains the following files
 with respect to allocation:
@@ -161,6 +182,16 @@ When control is enabled all CTRL_MON groups will also contain:
 	A list of all the resources available to this group.
 	Each resource has its own line and format - see below for details.
 
+"size":
+	Mirrors the display of the "schemata" file to display the size in
+	bytes of each allocation instead of the bits representing the
+	allocation.
+
+"mode":
+	The "mode" of the resource group dictates the sharing of its
+	allocations. A "shareable" resource group allows sharing of its
+	allocations while an "exclusive" resource group does not.
+
 When monitoring is enabled all MON groups will also contain:
 
 "mon_data":
@@ -443,7 +474,71 @@ siblings and only the real time threads are scheduled on the cores 4-7.
 
 # echo F0 > p0/cpus
 
-4) Locking between applications
+Example 4
+---------
+
+The resource groups in previous examples were all in the default "shareable"
+mode allowing sharing of their cache allocations. If one resource group
+configures a cache allocation then nothing prevents another resource group
+to overlap with that allocation.
+
+In this example a new exclusive resource group will be created on a L2 CAT
+system with two L2 cache instances that can be configured with an 8-bit
+capacity bitmask. The new exclusive resource group will be configured to use
+25% of each cache instance.
+
+# mount -t resctrl resctrl /sys/fs/resctrl/
+# cd /sys/fs/resctrl
+
+First, we observe that the default group is configured to allocate to all L2
+cache:
+
+# cat schemata
+L2:0=ff;1=ff
+
+We could attempt to create the new resource group at this point, but it will
+fail because of the overlap with the schemata of the default group:
+# mkdir p0
+# echo 'L2:0=0x3;1=0x3' > p0/schemata
+# cat p0/mode
+shareable
+# echo exclusive > p0/mode
+-sh: echo: write error: Invalid argument
+# cat info/last_cmd_status
+schemata overlaps
+
+To ensure that there is no overlap with another resource group the default
+resource group's schemata has to change, making it possible for the new
+resource group to become exclusive.
+# echo 'L2:0=0xfc;1=0xfc' > schemata
+# echo exclusive > p0/mode
+# grep . p0/*
+p0/cpus:0
+p0/mode:exclusive
+p0/schemata:L2:0=03;1=03
+p0/size:L2:0=262144;1=262144
+
+A new resource group will on creation not overlap with an exclusive resource
+group:
+# mkdir p1
+# grep . p1/*
+p1/cpus:0
+p1/mode:shareable
+p1/schemata:L2:0=fc;1=fc
+p1/size:L2:0=786432;1=786432
+
+The bit_usage will reflect how the cache is used:
+# cat info/L2/bit_usage
+0=SSSSSSEE;1=SSSSSSEE
+
+A resource group cannot be forced to overlap with an exclusive resource group:
+# echo 'L2:0=0x1;1=0x1' > p1/schemata
+-sh: echo: write error: Invalid argument
+# cat info/last_cmd_status
+overlaps with exclusive group
+
+Locking between applications
+----------------------------
 
 Certain operations on the resctrl filesystem, composed of read/writes
 to/from multiple files, must be atomic.
@@ -451,7 +546,7 @@ to/from multiple files, must be atomic.
 As an example, the allocation of an exclusive reservation of L3 cache
 involves:
 
-  1. Read the cbmmasks from each directory
+  1. Read the cbmmasks from each directory or the per-resource "bit_usage"
   2. Find a contiguous set of bits in the global CBM bitmask that is clear
      in any of the directory cbmmasks
   3. Create a new directory
-- 
2.13.6

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967334AbeE2VDv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 17:03:51 -0400
Received: from mga01.intel.com ([192.55.52.88]:53965 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937192AbeE2VBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 17:01:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,457,1520924400";
   d="scan'208";a="60127715"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V5 16/38] x86/intel_rdt: Introduce the Cache Pseudo-Locking modes
Date: Tue, 29 May 2018 05:57:41 -0700
Message-Id: <6ab82fb595f4b0ffa305dc204255b921eed51de7.1527593970.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1527593970.git.reinette.chatre@intel.com>
References: <cover.1527593970.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1527593970.git.reinette.chatre@intel.com>
References: <cover.1527593970.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The two modes used to manage Cache Pseudo-Locked regions are introduced.
A resource group is assigned "pseudo-locksetup" mode when the user
indicates that this resource group will be used for a Cache
Pseudo-Locked region. When the Cache Pseudo-Locked region has been set
up successfully after the user wrote the requested schemata to the
"schemata" file, then the mode will automatically changed to
"pseudo-locked".  The user is not able to modify the mode to
"pseudo-locked" by writing "pseudo-locked" to the "mode" file directly.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt.h          | 10 ++++++++++
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 13 +++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 8bbb047bf37c..bda87f5ef7bc 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -84,15 +84,25 @@ enum rdt_group_type {
  * enum rdtgrp_mode - Mode of a RDT resource group
  * @RDT_MODE_SHAREABLE: This resource group allows sharing of its allocations
  * @RDT_MODE_EXCLUSIVE: No sharing of this resource group's allocations allowed
+ * @RDT_MODE_PSEUDO_LOCKSETUP: Resource group will be used for Pseudo-Locking
+ * @RDT_MODE_PSEUDO_LOCKED: No sharing of this resource group's allocations
+ *                          allowed AND the allocations are Cache Pseudo-Locked
  *
  * The mode of a resource group enables control over the allowed overlap
  * between allocations associated with different resource groups (classes
  * of service). User is able to modify the mode of a resource group by
  * writing to the "mode" resctrl file associated with the resource group.
+ *
+ * The "shareable", "exclusive", and "pseudo-locksetup" modes are set by
+ * writing the appropriate text to the "mode" file. A resource group enters
+ * "pseudo-locked" mode after the schemata is written while the resource
+ * group is in "pseudo-locksetup" mode.
  */
 enum rdtgrp_mode {
 	RDT_MODE_SHAREABLE = 0,
 	RDT_MODE_EXCLUSIVE,
+	RDT_MODE_PSEUDO_LOCKSETUP,
+	RDT_MODE_PSEUDO_LOCKED,
 
 	/* Must be last */
 	RDT_NUM_MODES,
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index ef86264cf5a9..7ff5f4be2e16 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -161,8 +161,10 @@ enum rdtgrp_mode rdtgroup_mode_by_closid(int closid)
 }
 
 static const char * const rdt_mode_str[] = {
-	[RDT_MODE_SHAREABLE]	= "shareable",
-	[RDT_MODE_EXCLUSIVE]	= "exclusive",
+	[RDT_MODE_SHAREABLE]		= "shareable",
+	[RDT_MODE_EXCLUSIVE]		= "exclusive",
+	[RDT_MODE_PSEUDO_LOCKSETUP]	= "pseudo-locksetup",
+	[RDT_MODE_PSEUDO_LOCKED]	= "pseudo-locked",
 };
 
 /**
@@ -759,6 +761,13 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 			case RDT_MODE_EXCLUSIVE:
 				exclusive |= *ctrl;
 				break;
+			/*
+			 * Temporarily handle pseudo-locking enums
+			 * to silence compile warnings until handling
+			 * added in later patches.
+			 */
+			case RDT_MODE_PSEUDO_LOCKSETUP:
+			case RDT_MODE_PSEUDO_LOCKED:
 			case RDT_NUM_MODES:
 				WARN(1,
 				     "invalid mode for closid %d\n", i);
-- 
2.13.6

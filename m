Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932121AbeDYSZa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 14:25:30 -0400
Received: from mga02.intel.com ([134.134.136.20]:41714 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932135AbeDYSMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 14:12:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,327,1520924400";
   d="scan'208";a="35243683"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V3 16/39] x86/intel_rdt: Introduce the Cache Pseudo-Locking modes
Date: Wed, 25 Apr 2018 03:09:52 -0700
Message-Id: <28015495278b862704a3921f33aaeae51a7df50a.1524649902.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
References: <cover.1524649902.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
References: <cover.1524649902.git.reinette.chatre@intel.com>
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
index 6658608330fb..fa2aa7e8ad73 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -83,15 +83,25 @@ enum rdt_group_type {
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
index 9337f72983ec..595a40ec69d2 100644
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
@@ -758,6 +760,13 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 				case RDT_MODE_EXCLUSIVE:
 					exclusive |= *ctrl;
 					break;
+				/*
+				 * Temporarily handle pseudo-locking enums
+				 * to silence compile warnings until handling
+				 * added in later patches.
+				 */
+				case RDT_MODE_PSEUDO_LOCKSETUP:
+				case RDT_MODE_PSEUDO_LOCKED:
 				case RDT_NUM_MODES:
 					WARN(1,
 					     "invalid mode for closid %d\n", i);
-- 
2.13.6

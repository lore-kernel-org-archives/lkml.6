Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752822AbeEVTex (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 15:34:53 -0400
Received: from mga07.intel.com ([134.134.136.100]:16708 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752605AbeEVTcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 15:32:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,430,1520924400";
   d="scan'208";a="226406429"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V4 31/38] x86/intel_rdt: resctrl files reflect pseudo-locked information
Date: Tue, 22 May 2018 04:29:19 -0700
Message-Id: <43a611a77ca4f09be41fad4592296cdc803ed79c.1526987654.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1526987654.git.reinette.chatre@intel.com>
References: <cover.1526987654.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1526987654.git.reinette.chatre@intel.com>
References: <cover.1526987654.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Information about resources as well as resource groups are contained in
a variety of resctrl files. Now that pseudo-locked regions can be
created the files can be updated to present appropriate information to
the user.

Update the resource group's schemata file to show only the information
of the pseudo-locked region.

Update the resource group's size file to show the size in bytes of only
the pseudo-locked region.

Update the bit_usage file to use the letter 'P' for all pseudo-locked
regions.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c |  3 +++
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c    | 31 +++++++++++++++++++++++------
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
index 6f4c0002b2c1..af358ca05160 100644
--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
@@ -402,6 +402,9 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
 		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
 			for_each_alloc_enabled_rdt_resource(r)
 				seq_printf(s, "%s:uninitialized\n", r->name);
+		} else if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED) {
+			seq_printf(s, "%s:%d=%x\n", rdtgrp->plr->r->name,
+				   rdtgrp->plr->d->id, rdtgrp->plr->cbm);
 		} else {
 			closid = rdtgrp->closid;
 			for_each_alloc_enabled_rdt_resource(r) {
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 88ffd1311c40..d08670ea1a3d 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -771,14 +771,16 @@ static int rdt_shareable_bits_show(struct kernfs_open_file *of,
  *   H - currently used by hardware only but available for software use
  *   S - currently used and shareable by software only
  *   E - currently used exclusively by one resource group
+ *   P - currently pseudo-locked by one resource group
  */
 static int rdt_bit_usage_show(struct kernfs_open_file *of,
 			      struct seq_file *seq, void *v)
 {
 	struct rdt_resource *r = of->kn->parent->priv;
-	u32 sw_shareable, hw_shareable, exclusive;
+	u32 sw_shareable = 0, hw_shareable = 0;
+	u32 exclusive = 0, pseudo_locked = 0;
 	struct rdt_domain *dom;
-	int i, hwb, swb, excl;
+	int i, hwb, swb, excl, psl;
 	enum rdtgrp_mode mode;
 	bool sep = false;
 	u32 *ctrl;
@@ -803,12 +805,15 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 			case RDT_MODE_EXCLUSIVE:
 				exclusive |= *ctrl;
 				break;
+			case RDT_MODE_PSEUDO_LOCKSETUP:
 			/*
-			 * Temporarily handle pseudo-locking enums
-			 * to silence compile warnings until handling
-			 * added in later patches.
+			 * RDT_MODE_PSEUDO_LOCKSETUP is possible
+			 * here but not included since the CBM
+			 * associated with this CLOSID in this mode
+			 * is not initialized and no task or cpu can be
+			 * assigned this CLOSID.
 			 */
-			case RDT_MODE_PSEUDO_LOCKSETUP:
+				break;
 			case RDT_MODE_PSEUDO_LOCKED:
 			case RDT_NUM_MODES:
 				WARN(1,
@@ -817,9 +822,11 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 			}
 		}
 		for (i = r->cache.cbm_len - 1; i >= 0; i--) {
+			pseudo_locked = dom->plr ? dom->plr->cbm : 0;
 			hwb = test_bit(i, (unsigned long *)&hw_shareable);
 			swb = test_bit(i, (unsigned long *)&sw_shareable);
 			excl = test_bit(i, (unsigned long *)&exclusive);
+			psl = test_bit(i, (unsigned long *)&pseudo_locked);
 			if (hwb && swb)
 				seq_puts(seq, "X");
 			else if (hwb && !swb)
@@ -828,6 +835,8 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 				seq_puts(seq, "S");
 			else if (excl)
 				seq_puts(seq, "E");
+			else if (psl)
+				seq_puts(seq, "P");
 			else /* Unused bits remain */
 				seq_puts(seq, "0");
 		}
@@ -1146,6 +1155,15 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 		return -ENOENT;
 	}
 
+	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED) {
+		seq_printf(s, "%*s:", max_name_width, rdtgrp->plr->r->name);
+		size = rdtgroup_cbm_to_size(rdtgrp->plr->r,
+					    rdtgrp->plr->d,
+					    rdtgrp->plr->cbm);
+		seq_printf(s, "%d=%u\n", rdtgrp->plr->d->id, size);
+		goto out;
+	}
+
 	for_each_alloc_enabled_rdt_resource(r) {
 		seq_printf(s, "%*s:", max_name_width, r->name);
 		list_for_each_entry(d, &r->domains, list) {
@@ -1163,6 +1181,7 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 		seq_puts(s, "\n");
 	}
 
+out:
 	rdtgroup_kn_unlock(of->kn);
 
 	return 0;
-- 
2.13.6

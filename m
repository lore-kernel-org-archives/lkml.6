Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756191AbeDYS2D (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 14:28:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:41713 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755986AbeDYSMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 14:12:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,327,1520924400";
   d="scan'208";a="35243653"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V3 09/39] x86/intel_rdt: Enable setting of exclusive mode
Date: Wed, 25 Apr 2018 03:09:45 -0700
Message-Id: <975917b4b8e0ac91fa2b315d9ea1016c93d80870.1524649902.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
References: <cover.1524649902.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
References: <cover.1524649902.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new "mode" file now accepts "exclusive" that means that the
allocations of this resource group cannot be shared.

Enable users to modify a resource group's mode to "exclusive". To
succeed it is required that there is no overlap between resource group's
current schemata and that of all the other active resource groups as
well as cache regions potentially used by other hardware entities.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 97 +++++++++++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 9afcb667df3a..0bacfdb85de1 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -812,6 +812,93 @@ static int rdtgroup_mode_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+/**
+ * rdtgroup_cbm_overlaps - Does CBM for intended closid overlap with other
+ * @r: Resource to which domain instance @d belongs.
+ * @d: The domain instance for which @closid is being tested.
+ * @cbm: Capacity bitmask being tested.
+ * @closid: Intended closid for @cbm.
+ * @exclusive: Only check if overlaps with exclusive resource groups
+ *
+ * Checks if provided @cbm intended to be used for @closid on domain
+ * @d overlaps with any other closids or other hardware usage associated
+ * with this domain. If @exclusive is true then only overlaps with
+ * resource groups in exclusive mode will be considered. If @exclusive
+ * is false then overlaps with any resource group or hardware entities
+ * will be considered.
+ *
+ * Return: 0 if CBM does not overlap, 1 if it does.
+ */
+static int rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
+				 u32 _cbm, int closid, bool exclusive)
+{
+	unsigned long *cbm = (unsigned long *)&_cbm;
+	unsigned long *ctrl_b;
+	enum rdtgrp_mode mode;
+	u32 *ctrl;
+	int i;
+
+	/* Check for any overlap with regions used by hardware directly */
+	if (!exclusive) {
+		if (bitmap_intersects(cbm,
+				      (unsigned long *)&r->cache.shareable_bits,
+				      r->cache.cbm_len))
+			return 1;
+	}
+
+	/* Check for overlap with other resource groups */
+	ctrl = d->ctrl_val;
+	for (i = 0; i < r->num_closid; i++, ctrl++) {
+		ctrl_b = (unsigned long *)ctrl;
+		if (closid_allocated(i) && i != closid) {
+			if (bitmap_intersects(cbm, ctrl_b, r->cache.cbm_len)) {
+				mode = rdtgroup_mode_by_closid(i);
+				if (exclusive) {
+					if (mode == RDT_MODE_EXCLUSIVE)
+						return 1;
+					continue;
+				}
+				return 1;
+			}
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * rdtgroup_mode_test_exclusive - Test if this resource group can be exclusive
+ *
+ * An exclusive resource group implies that there should be no sharing of
+ * its allocated resources. At the time this group is considered to be
+ * exclusive this test can determine if its current schemata supports this
+ * setting by testing for overlap with all other resource groups.
+ *
+ * Return: 1 if resource group can be exclusive, 0 if there is overlap
+ * with allocations of other resource groups and thus this resource group
+ * cannot be exclusive.
+ */
+static int rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
+{
+	int closid = rdtgrp->closid;
+	struct rdt_resource *r;
+	struct rdt_domain *d;
+
+	for_each_alloc_enabled_rdt_resource(r) {
+		list_for_each_entry(d, &r->domains, list) {
+			if (rdtgroup_cbm_overlaps(r, d, d->ctrl_val[closid],
+						  rdtgrp->closid, false))
+				return 0;
+		}
+	}
+
+	return 1;
+}
+
+/**
+ * rdtgroup_mode_write - Modify the resource group's mode
+ *
+ */
 static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
 				   char *buf, size_t nbytes, loff_t off)
 {
@@ -834,11 +921,19 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
 
 	mode = rdtgrp->mode;
 
-	if ((!strcmp(buf, "shareable") && mode == RDT_MODE_SHAREABLE))
+	if ((!strcmp(buf, "shareable") && mode == RDT_MODE_SHAREABLE) ||
+	    (!strcmp(buf, "exclusive") && mode == RDT_MODE_EXCLUSIVE))
 		goto out;
 
 	if (!strcmp(buf, "shareable")) {
 		rdtgrp->mode = RDT_MODE_SHAREABLE;
+	} else if (!strcmp(buf, "exclusive")) {
+		if (!rdtgroup_mode_test_exclusive(rdtgrp)) {
+			rdt_last_cmd_printf("schemata overlaps\n");
+			ret = -EINVAL;
+			goto out;
+		}
+		rdtgrp->mode = RDT_MODE_EXCLUSIVE;
 	} else {
 		rdt_last_cmd_printf("unknown/unsupported mode\n");
 		ret = -EINVAL;
-- 
2.13.6

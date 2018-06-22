Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F49C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E07D824995
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E07D824995
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754796AbeFVWsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 18:48:40 -0400
Received: from mga02.intel.com ([134.134.136.20]:22312 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754654AbeFVWmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 18:42:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2018 15:42:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,259,1526367600"; 
   d="scan'208";a="234843378"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga005.jf.intel.com with ESMTP; 22 Jun 2018 15:42:47 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V7 10/41] x86/intel_rdt: Enable setting of exclusive mode
Date:   Fri, 22 Jun 2018 15:42:01 -0700
Message-Id: <83642cbba3c8c21db7fa6bb36fe7d385d3b275f2.1529706536.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1529706536.git.reinette.chatre@intel.com>
References: <cover.1529706536.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1529706536.git.reinette.chatre@intel.com>
References: <cover.1529706536.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new "mode" file now accepts "exclusive" that means that the
allocations of this resource group cannot be shared.

Enable users to modify a resource group's mode to "exclusive". To
succeed it is required that there is no overlap between resource group's
current schemata and that of all the other active resource groups as
well as cache regions potentially used by other hardware entities.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/de6b02cb2da65d3abd492ad115ed9813940869a1.1527593970.git.reinette.chatre@intel.com
---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 97 +++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 0bee382fcad5..7f24e0808eef 100644
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
+ * Return: false if CBM does not overlap, true if it does.
+ */
+static bool rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
+				  u32 _cbm, int closid, bool exclusive)
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
+			return true;
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
+						return true;
+					continue;
+				}
+				return true;
+			}
+		}
+	}
+
+	return false;
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
+ * Return: true if resource group can be exclusive, false if there is overlap
+ * with allocations of other resource groups and thus this resource group
+ * cannot be exclusive.
+ */
+static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
+{
+	int closid = rdtgrp->closid;
+	struct rdt_resource *r;
+	struct rdt_domain *d;
+
+	for_each_alloc_enabled_rdt_resource(r) {
+		list_for_each_entry(d, &r->domains, list) {
+			if (rdtgroup_cbm_overlaps(r, d, d->ctrl_val[closid],
+						  rdtgrp->closid, false))
+				return false;
+		}
+	}
+
+	return true;
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
2.17.0


Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207F9C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D337020693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D337020693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754085AbeFTARa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 20:17:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54611 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750949AbeFTAR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 20:17:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5K0HLCJ3296681
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 19 Jun 2018 17:17:21 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5K0HLBB3296678;
        Tue, 19 Jun 2018 17:17:21 -0700
Date:   Tue, 19 Jun 2018 17:17:21 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-55e18a5f1eee476e5747dd09b57f6c422ba950ba@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        reinette.chatre@intel.com, tglx@linutronix.de, hpa@zytor.com
Reply-To: reinette.chatre@intel.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <de6b02cb2da65d3abd492ad115ed9813940869a1.1527593970.git.reinette.chatre@intel.com>
References: <de6b02cb2da65d3abd492ad115ed9813940869a1.1527593970.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Enable setting of exclusive mode
Git-Commit-ID: 55e18a5f1eee476e5747dd09b57f6c422ba950ba
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

Commit-ID:  55e18a5f1eee476e5747dd09b57f6c422ba950ba
Gitweb:     https://git.kernel.org/tip/55e18a5f1eee476e5747dd09b57f6c422ba950ba
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Tue, 29 May 2018 05:57:34 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 20 Jun 2018 00:56:29 +0200

x86/intel_rdt: Enable setting of exclusive mode

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
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 97 +++++++++++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 43b532bea735..e2909a479dc3 100644
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

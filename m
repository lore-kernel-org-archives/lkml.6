Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA445C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F3820693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:26:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F3820693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754239AbeFTA0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 20:26:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52835 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752787AbeFTA0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 20:26:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5K0Q9rW3299492
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 19 Jun 2018 17:26:09 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5K0Q9K73299489;
        Tue, 19 Jun 2018 17:26:09 -0700
Date:   Tue, 19 Jun 2018 17:26:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-139a67166b274176ee804260cb2c4c6de5689535@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        reinette.chatre@intel.com, tglx@linutronix.de, hpa@zytor.com
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org,
          reinette.chatre@intel.com, hpa@zytor.com, tglx@linutronix.de
In-Reply-To: <bbf8b7d6985e7a4df508cdc141e01b2d5c92372b.1528405411.git.reinette.chatre@intel.com>
References: <bbf8b7d6985e7a4df508cdc141e01b2d5c92372b.1528405411.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Enable entering of pseudo-locksetup
 mode
Git-Commit-ID: 139a67166b274176ee804260cb2c4c6de5689535
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

Commit-ID:  139a67166b274176ee804260cb2c4c6de5689535
Gitweb:     https://git.kernel.org/tip/139a67166b274176ee804260cb2c4c6de5689535
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Thu, 7 Jun 2018 14:26:44 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 20 Jun 2018 00:56:36 +0200

x86/intel_rdt: Enable entering of pseudo-locksetup mode

The user can request entering pseudo-locksetup mode by writing
"pseudo-locksetup" to the mode file. Act on this request as well as
support switching from a pseudo-locksetup mode (before pseudo-locked
mode was entered). It is not supported to modify the mode once
pseudo-locked mode has been entered.

The schemata reflects the new mode by adding "uninitialized" to all
resources. The size resctrl file reports zero for all cache domains in
support of the uninitialized nature. Since there are no users of this
class of service its allocations can be ignored when searching for
appropriate default allocations for new resource groups. For the same
reason resource groups in pseudo-locksetup mode are not considered when
testing if new resource groups may overlap.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/bbf8b7d6985e7a4df508cdc141e01b2d5c92372b.1528405411.git.reinette.chatre@intel.com

---
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c | 16 +++++++----
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c    | 41 +++++++++++++++++++++++++----
 2 files changed, 47 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
index bc79396c5dad..1ed273220ffa 100644
--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
@@ -156,7 +156,8 @@ int parse_cbm(void *_data, struct rdt_resource *r, struct rdt_domain *d)
 	}
 
 	if (rdtgroup_cbm_overlaps(r, d, cbm_val, rdtgrp->closid, false)) {
-		if (rdtgrp->mode == RDT_MODE_EXCLUSIVE) {
+		if (rdtgrp->mode == RDT_MODE_EXCLUSIVE ||
+		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
 			rdt_last_cmd_printf("overlaps with other group\n");
 			return -EINVAL;
 		}
@@ -356,10 +357,15 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
 
 	rdtgrp = rdtgroup_kn_lock_live(of->kn);
 	if (rdtgrp) {
-		closid = rdtgrp->closid;
-		for_each_alloc_enabled_rdt_resource(r) {
-			if (closid < r->num_closid)
-				show_doms(s, r, closid);
+		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
+			for_each_alloc_enabled_rdt_resource(r)
+				seq_printf(s, "%s:uninitialized\n", r->name);
+		} else {
+			closid = rdtgrp->closid;
+			for_each_alloc_enabled_rdt_resource(r) {
+				if (closid < r->num_closid)
+					show_doms(s, r, closid);
+			}
 		}
 	} else {
 		ret = -ENOENT;
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index e27583f3823e..8f50914dc45e 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -974,9 +974,10 @@ bool rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
 	ctrl = d->ctrl_val;
 	for (i = 0; i < r->num_closid; i++, ctrl++) {
 		ctrl_b = (unsigned long *)ctrl;
-		if (closid_allocated(i) && i != closid) {
+		mode = rdtgroup_mode_by_closid(i);
+		if (closid_allocated(i) && i != closid &&
+		    mode != RDT_MODE_PSEUDO_LOCKSETUP) {
 			if (bitmap_intersects(cbm, ctrl_b, r->cache.cbm_len)) {
-				mode = rdtgroup_mode_by_closid(i);
 				if (exclusive) {
 					if (mode == RDT_MODE_EXCLUSIVE)
 						return true;
@@ -1046,10 +1047,24 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
 	mode = rdtgrp->mode;
 
 	if ((!strcmp(buf, "shareable") && mode == RDT_MODE_SHAREABLE) ||
-	    (!strcmp(buf, "exclusive") && mode == RDT_MODE_EXCLUSIVE))
+	    (!strcmp(buf, "exclusive") && mode == RDT_MODE_EXCLUSIVE) ||
+	    (!strcmp(buf, "pseudo-locksetup") &&
+	     mode == RDT_MODE_PSEUDO_LOCKSETUP) ||
+	    (!strcmp(buf, "pseudo-locked") && mode == RDT_MODE_PSEUDO_LOCKED))
 		goto out;
 
+	if (mode == RDT_MODE_PSEUDO_LOCKED) {
+		rdt_last_cmd_printf("cannot change pseudo-locked group\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
 	if (!strcmp(buf, "shareable")) {
+		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
+			ret = rdtgroup_locksetup_exit(rdtgrp);
+			if (ret)
+				goto out;
+		}
 		rdtgrp->mode = RDT_MODE_SHAREABLE;
 	} else if (!strcmp(buf, "exclusive")) {
 		if (!rdtgroup_mode_test_exclusive(rdtgrp)) {
@@ -1057,7 +1072,17 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
 			ret = -EINVAL;
 			goto out;
 		}
+		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
+			ret = rdtgroup_locksetup_exit(rdtgrp);
+			if (ret)
+				goto out;
+		}
 		rdtgrp->mode = RDT_MODE_EXCLUSIVE;
+	} else if (!strcmp(buf, "pseudo-locksetup")) {
+		ret = rdtgroup_locksetup_enter(rdtgrp);
+		if (ret)
+			goto out;
+		rdtgrp->mode = RDT_MODE_PSEUDO_LOCKSETUP;
 	} else {
 		rdt_last_cmd_printf("unknown/unsupported mode\n");
 		ret = -EINVAL;
@@ -1127,8 +1152,12 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 		list_for_each_entry(d, &r->domains, list) {
 			if (sep)
 				seq_putc(s, ';');
-			cbm = d->ctrl_val[rdtgrp->closid];
-			size = rdtgroup_cbm_to_size(r, d, cbm);
+			if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
+				size = 0;
+			} else {
+				cbm = d->ctrl_val[rdtgrp->closid];
+				size = rdtgroup_cbm_to_size(r, d, cbm);
+			}
 			seq_printf(s, "%d=%u", d->id, size);
 			sep = true;
 		}
@@ -2269,6 +2298,8 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 			for (i = 0; i < r->num_closid; i++, ctrl++) {
 				if (closid_allocated(i) && i != closid) {
 					mode = rdtgroup_mode_by_closid(i);
+					if (mode == RDT_MODE_PSEUDO_LOCKSETUP)
+						break;
 					used_b |= *ctrl;
 					if (mode == RDT_MODE_SHAREABLE)
 						d->new_ctrl |= *ctrl;

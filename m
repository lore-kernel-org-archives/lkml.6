Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id n78aA+qgGVubXwAAmS7hNA
	; Thu, 07 Jun 2018 21:26:55 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7CBB86074D; Thu,  7 Jun 2018 21:26:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D7B3B60115;
	Thu,  7 Jun 2018 21:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D7B3B60115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752621AbeFGV0x (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 17:26:53 -0400
Received: from mga03.intel.com ([134.134.136.65]:9189 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752561AbeFGV0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 17:26:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2018 14:26:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,488,1520924400";
   d="scan'208";a="47634958"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga008.jf.intel.com with ESMTP; 07 Jun 2018 14:26:51 -0700
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V6 25/38] x86/intel_rdt: Enable entering of pseudo-locksetup mode
Date: Thu,  7 Jun 2018 14:26:44 -0700
Message-Id: <bbf8b7d6985e7a4df508cdc141e01b2d5c92372b.1528405411.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <2d019e91959799576299ff6974e0716163aad052.1527593971.git.reinette.chatre@intel.com>
References: <2d019e91959799576299ff6974e0716163aad052.1527593971.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
V6: A resource group in pseudo-locksetup mode does have a CLOSID associated
    with it but until its mode is changed to pseudo-locked there is no way
    in which this CLOSID can be active. When a new allocation is considered
    for a different resource group the new allocation should not be
    compared to the unusable allocation associated with the CLOSID assigned
    to the resource group in pseudo-locksetup mode.

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
index 59b5bdbb6597..0277c4fe433c 100644
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
@@ -2261,6 +2290,8 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 			for (i = 0; i < r->num_closid; i++, ctrl++) {
 				if (closid_allocated(i) && i != closid) {
 					mode = rdtgroup_mode_by_closid(i);
+					if (mode == RDT_MODE_PSEUDO_LOCKSETUP)
+						break;
 					used_b |= *ctrl;
 					if (mode == RDT_MODE_SHAREABLE)
 						d->new_ctrl |= *ctrl;
-- 
2.13.6

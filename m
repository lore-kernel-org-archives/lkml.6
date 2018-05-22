Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752666AbeEVTcJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 15:32:09 -0400
Received: from mga07.intel.com ([134.134.136.100]:16708 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752594AbeEVTcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 15:32:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,430,1520924400";
   d="scan'208";a="226406410"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V4 25/38] x86/intel_rdt: Enable entering of pseudo-locksetup mode
Date: Tue, 22 May 2018 04:29:13 -0700
Message-Id: <4aca867a8204626c5aaf97994c1ced815ae54149.1526987654.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1526987654.git.reinette.chatre@intel.com>
References: <cover.1526987654.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1526987654.git.reinette.chatre@intel.com>
References: <cover.1526987654.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
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
appropriate default allocations for new resource groups.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c | 16 +++++++++----
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c    | 36 ++++++++++++++++++++++++++---
 2 files changed, 44 insertions(+), 8 deletions(-)

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
index 2df8bcabe085..31dd9a2cc394 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -1046,10 +1046,24 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
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
@@ -1057,7 +1071,17 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
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
@@ -1127,8 +1151,12 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 		list_for_each_entry(d, &r->domains, list) {
 			if (sep)
 				seq_puts(s, ";");
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
@@ -2230,6 +2258,8 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
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

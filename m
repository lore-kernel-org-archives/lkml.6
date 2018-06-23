Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674B5C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D0D524BDD
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D0D524BDD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751984AbeFWMXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 08:23:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46955 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751442AbeFWMXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 08:23:20 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5NCNFO7465473
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 23 Jun 2018 05:23:15 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5NCNFZm465470;
        Sat, 23 Jun 2018 05:23:15 -0700
Date:   Sat, 23 Jun 2018 05:23:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-e0bdfe8e36f3fbbdc91e70bf927f743ca23917b0@git.kernel.org>
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        reinette.chatre@intel.com, mingo@kernel.org
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
          mingo@kernel.org, reinette.chatre@intel.com
In-Reply-To: <8929c3a9e2ba600e79649abe584aa28b8d0ff639.1529706536.git.reinette.chatre@intel.com>
References: <8929c3a9e2ba600e79649abe584aa28b8d0ff639.1529706536.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Support creation/removal of
 pseudo-locked region
Git-Commit-ID: e0bdfe8e36f3fbbdc91e70bf927f743ca23917b0
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

Commit-ID:  e0bdfe8e36f3fbbdc91e70bf927f743ca23917b0
Gitweb:     https://git.kernel.org/tip/e0bdfe8e36f3fbbdc91e70bf927f743ca23917b0
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Fri, 22 Jun 2018 15:42:22 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 23 Jun 2018 13:03:50 +0200

x86/intel_rdt: Support creation/removal of pseudo-locked region

The user triggers the creation of a pseudo-locked region when writing a
valid schemata to the schemata file of a resource group in the
pseudo-locksetup mode.

A valid schemata is one that: (1) does not overlap with any other resource
group, (2) does not involve a cache that already contains a pseudo-locked
region within its hierarchy.

After a valid schemata is parsed the system is programmed to associate the
to be pseudo-lock bitmask with the closid associated with the resource
group. With the system set up the pseudo-locked region can be created.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/8929c3a9e2ba600e79649abe584aa28b8d0ff639.1529706536.git.reinette.chatre@intel.com

---
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c | 42 +++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c    | 25 +++++++++++++----
 2 files changed, 62 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
index 1ed273220ffa..6f4c0002b2c1 100644
--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
@@ -143,9 +143,26 @@ int parse_cbm(void *_data, struct rdt_resource *r, struct rdt_domain *d)
 		return -EINVAL;
 	}
 
+	/*
+	 * Cannot set up more than one pseudo-locked region in a cache
+	 * hierarchy.
+	 */
+	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP &&
+	    rdtgroup_pseudo_locked_in_hierarchy(d)) {
+		rdt_last_cmd_printf("pseudo-locked region in hierarchy\n");
+		return -EINVAL;
+	}
+
 	if (!cbm_validate(data->buf, &cbm_val, r))
 		return -EINVAL;
 
+	if ((rdtgrp->mode == RDT_MODE_EXCLUSIVE ||
+	     rdtgrp->mode == RDT_MODE_SHAREABLE) &&
+	    rdtgroup_cbm_overlaps_pseudo_locked(d, cbm_val)) {
+		rdt_last_cmd_printf("CBM overlaps with pseudo-locked region\n");
+		return -EINVAL;
+	}
+
 	/*
 	 * The CBM may not overlap with the CBM of another closid if
 	 * either is exclusive.
@@ -199,6 +216,21 @@ next:
 			data.rdtgrp = rdtgrp;
 			if (r->parse_ctrlval(&data, r, d))
 				return -EINVAL;
+			if (rdtgrp->mode ==  RDT_MODE_PSEUDO_LOCKSETUP) {
+				/*
+				 * In pseudo-locking setup mode and just
+				 * parsed a valid CBM that should be
+				 * pseudo-locked. Only one locked region per
+				 * resource group and domain so just do
+				 * the required initialization for single
+				 * region and return.
+				 */
+				rdtgrp->plr->r = r;
+				rdtgrp->plr->d = d;
+				rdtgrp->plr->cbm = d->new_ctrl;
+				d->plr = rdtgrp->plr;
+				return 0;
+			}
 			goto next;
 		}
 	}
@@ -322,6 +354,16 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 			goto out;
 	}
 
+	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
+		/*
+		 * If pseudo-locking fails we keep the resource group in
+		 * mode RDT_MODE_PSEUDO_LOCKSETUP with its class of service
+		 * active and updated for just the domain the pseudo-locked
+		 * region was requested for.
+		 */
+		ret = rdtgroup_pseudo_lock_create(rdtgrp);
+	}
+
 out:
 	rdtgroup_kn_unlock(of->kn);
 	return ret ?: nbytes;
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 526cd4a97054..d3fb7bd8cbba 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -1771,6 +1771,9 @@ void rdtgroup_kn_unlock(struct kernfs_node *kn)
 
 	if (atomic_dec_and_test(&rdtgrp->waitcount) &&
 	    (rdtgrp->flags & RDT_DELETED)) {
+		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP ||
+		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED)
+			rdtgroup_pseudo_lock_remove(rdtgrp);
 		kernfs_unbreak_active_protection(kn);
 		kernfs_put(rdtgrp->kn);
 		kfree(rdtgrp);
@@ -2002,6 +2005,10 @@ static void rmdir_all_sub(void)
 		if (rdtgrp == &rdtgroup_default)
 			continue;
 
+		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP ||
+		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED)
+			rdtgroup_pseudo_lock_remove(rdtgrp);
+
 		/*
 		 * Give any CPUs back to the default group. We cannot copy
 		 * cpu_online_mask because a CPU might have executed the
@@ -2313,6 +2320,8 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 						d->new_ctrl |= *ctrl;
 				}
 			}
+			if (d->plr && d->plr->cbm > 0)
+				used_b |= d->plr->cbm;
 			unused_b = used_b ^ (BIT_MASK(r->cache.cbm_len) - 1);
 			unused_b &= BIT_MASK(r->cache.cbm_len) - 1;
 			d->new_ctrl |= unused_b;
@@ -2696,13 +2705,19 @@ static int rdtgroup_rmdir(struct kernfs_node *kn)
 	 * If the rdtgroup is a mon group and parent directory
 	 * is a valid "mon_groups" directory, remove the mon group.
 	 */
-	if (rdtgrp->type == RDTCTRL_GROUP && parent_kn == rdtgroup_default.kn)
-		ret = rdtgroup_rmdir_ctrl(kn, rdtgrp, tmpmask);
-	else if (rdtgrp->type == RDTMON_GROUP &&
-		 is_mon_groups(parent_kn, kn->name))
+	if (rdtgrp->type == RDTCTRL_GROUP && parent_kn == rdtgroup_default.kn) {
+		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP ||
+		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED) {
+			ret = rdtgroup_ctrl_remove(kn, rdtgrp);
+		} else {
+			ret = rdtgroup_rmdir_ctrl(kn, rdtgrp, tmpmask);
+		}
+	} else if (rdtgrp->type == RDTMON_GROUP &&
+		 is_mon_groups(parent_kn, kn->name)) {
 		ret = rdtgroup_rmdir_mon(kn, rdtgrp, tmpmask);
-	else
+	} else {
 		ret = -EPERM;
+	}
 
 out:
 	rdtgroup_kn_unlock(kn);

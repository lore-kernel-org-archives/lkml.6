Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1262C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA4820693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA4820693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754201AbeFTA3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 20:29:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42933 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752707AbeFTA3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 20:29:11 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5K0T7PI3299944
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 19 Jun 2018 17:29:07 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5K0T6Y23299941;
        Tue, 19 Jun 2018 17:29:06 -0700
Date:   Tue, 19 Jun 2018 17:29:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-8484928b48d80f463916ee14c6fa10e641125f9a@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        reinette.chatre@intel.com, tglx@linutronix.de, hpa@zytor.com
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org,
          reinette.chatre@intel.com, tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <80dc404e8011c96476dcd046b0d03fdcc6a893f2.1527593971.git.reinette.chatre@intel.com>
References: <80dc404e8011c96476dcd046b0d03fdcc6a893f2.1527593971.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Support creation/removal of
 pseudo-locked region
Git-Commit-ID: 8484928b48d80f463916ee14c6fa10e641125f9a
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

Commit-ID:  8484928b48d80f463916ee14c6fa10e641125f9a
Gitweb:     https://git.kernel.org/tip/8484928b48d80f463916ee14c6fa10e641125f9a
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Tue, 29 May 2018 05:57:55 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 20 Jun 2018 00:56:38 +0200

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
Link: https://lkml.kernel.org/r/80dc404e8011c96476dcd046b0d03fdcc6a893f2.1527593971.git.reinette.chatre@intel.com

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
index 5a197cdb8ab4..3b21aa2cea4f 100644
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
@@ -1994,6 +1997,10 @@ static void rmdir_all_sub(void)
 		if (rdtgrp == &rdtgroup_default)
 			continue;
 
+		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP ||
+		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED)
+			rdtgroup_pseudo_lock_remove(rdtgrp);
+
 		/*
 		 * Give any CPUs back to the default group. We cannot copy
 		 * cpu_online_mask because a CPU might have executed the
@@ -2305,6 +2312,8 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 						d->new_ctrl |= *ctrl;
 				}
 			}
+			if (d->plr && d->plr->cbm > 0)
+				used_b |= d->plr->cbm;
 			unused_b = used_b ^ (BIT_MASK(r->cache.cbm_len) - 1);
 			unused_b &= BIT_MASK(r->cache.cbm_len) - 1;
 			d->new_ctrl |= unused_b;
@@ -2688,13 +2697,19 @@ static int rdtgroup_rmdir(struct kernfs_node *kn)
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

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932365AbeDYSN1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 14:13:27 -0400
Received: from mga17.intel.com ([192.55.52.151]:41183 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755937AbeDYSMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 14:12:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,327,1520924400";
   d="scan'208";a="35243753"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V3 30/39] x86/intel_rdt: Support creation/removal of pseudo-locked region
Date: Wed, 25 Apr 2018 03:10:06 -0700
Message-Id: <0977cf20351cfbfc83d81c63425ac438700b00f4.1524649902.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
References: <cover.1524649902.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
References: <cover.1524649902.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The user triggers the creation of a pseudo-locked region when writing a
valid schemata to the schemata file of a resource group in the
pseudo-locksetup mode.

A valid schemata is one that: (1) does not overlap with any other resource
group, (2) does not involve a cache that already contains a
pseudo-locked region within its hierarchy.

After a valid schemata is parsed the system is programmed to associate
the to be pseudo-lock bitmask with the closid associated with the
resource group. With the system set up the pseudo-locked region can be
created.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c | 42 +++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c    | 25 +++++++++++++----
 2 files changed, 62 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
index 0cc9f8a1f44c..7a57307f439c 100644
--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
@@ -142,9 +142,26 @@ int parse_cbm(void *_data, struct rdt_resource *r, struct rdt_domain *d)
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
@@ -198,6 +215,21 @@ static int parse_line(char *line, struct rdt_resource *r,
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
@@ -312,6 +344,16 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
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
index e911aa58e316..677645a231ae 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -1739,6 +1739,9 @@ void rdtgroup_kn_unlock(struct kernfs_node *kn)
 
 	if (atomic_dec_and_test(&rdtgrp->waitcount) &&
 	    (rdtgrp->flags & RDT_DELETED)) {
+		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP ||
+		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED)
+			rdtgroup_pseudo_lock_remove(rdtgrp);
 		kernfs_unbreak_active_protection(kn);
 		kernfs_put(rdtgrp->kn);
 		kfree(rdtgrp);
@@ -1962,6 +1965,10 @@ static void rmdir_all_sub(void)
 		if (rdtgrp == &rdtgroup_default)
 			continue;
 
+		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP ||
+		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED)
+			rdtgroup_pseudo_lock_remove(rdtgrp);
+
 		/*
 		 * Give any CPUs back to the default group. We cannot copy
 		 * cpu_online_mask because a CPU might have executed the
@@ -2232,6 +2239,8 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 						d->new_ctrl |= *ctrl;
 				}
 			}
+			if (d->plr && d->plr->cbm > 0)
+				used_b |= d->plr->cbm;
 			unused_b = used_b ^ (BIT_MASK(r->cache.cbm_len) - 1);
 			unused_b &= BIT_MASK(r->cache.cbm_len) - 1;
 			d->new_ctrl |= unused_b;
@@ -2607,13 +2616,19 @@ static int rdtgroup_rmdir(struct kernfs_node *kn)
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
-- 
2.13.6

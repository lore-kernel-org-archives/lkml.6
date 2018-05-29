Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967168AbeE2VCk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 17:02:40 -0400
Received: from mga01.intel.com ([192.55.52.88]:53965 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966829AbeE2VBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 17:01:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,457,1520924400";
   d="scan'208";a="60127746"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V5 26/38] x86/intel_rdt: Split resource group removal in two
Date: Tue, 29 May 2018 05:57:51 -0700
Message-Id: <cf83951ef28f138aeb9a9242cd074a6e01a1fbb2.1527593971.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1527593970.git.reinette.chatre@intel.com>
References: <cover.1527593970.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1527593970.git.reinette.chatre@intel.com>
References: <cover.1527593970.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resource groups used for pseudo-locking do not require the same work on
removal as the other resource groups.

The resource group removal is split in two in preparation for support of
pseudo-locking resource groups. A single re-ordering occurs - the
setting of the rdtgrp flag is moved to later. This flag is not used by
any of the code between its original and new location.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index f0213fa5d630..a24a5ca41692 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -2565,6 +2565,21 @@ static int rdtgroup_rmdir_mon(struct kernfs_node *kn, struct rdtgroup *rdtgrp,
 	return 0;
 }
 
+static int rdtgroup_ctrl_remove(struct kernfs_node *kn,
+				struct rdtgroup *rdtgrp)
+{
+	rdtgrp->flags = RDT_DELETED;
+	list_del(&rdtgrp->rdtgroup_list);
+
+	/*
+	 * one extra hold on this, will drop when we kfree(rdtgrp)
+	 * in rdtgroup_kn_unlock()
+	 */
+	kernfs_get(kn);
+	kernfs_remove(rdtgrp->kn);
+	return 0;
+}
+
 static int rdtgroup_rmdir_ctrl(struct kernfs_node *kn, struct rdtgroup *rdtgrp,
 			       cpumask_var_t tmpmask)
 {
@@ -2590,7 +2605,6 @@ static int rdtgroup_rmdir_ctrl(struct kernfs_node *kn, struct rdtgroup *rdtgrp,
 	cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
 	update_closid_rmid(tmpmask, NULL);
 
-	rdtgrp->flags = RDT_DELETED;
 	closid_free(rdtgrp->closid);
 	free_rmid(rdtgrp->mon.rmid);
 
@@ -2599,14 +2613,7 @@ static int rdtgroup_rmdir_ctrl(struct kernfs_node *kn, struct rdtgroup *rdtgrp,
 	 */
 	free_all_child_rdtgrp(rdtgrp);
 
-	list_del(&rdtgrp->rdtgroup_list);
-
-	/*
-	 * one extra hold on this, will drop when we kfree(rdtgrp)
-	 * in rdtgroup_kn_unlock()
-	 */
-	kernfs_get(kn);
-	kernfs_remove(rdtgrp->kn);
+	rdtgroup_ctrl_remove(kn, rdtgrp);
 
 	return 0;
 }
-- 
2.13.6

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932245AbeDYSMv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 14:12:51 -0400
Received: from mga02.intel.com ([134.134.136.20]:41709 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755937AbeDYSMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 14:12:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,327,1520924400";
   d="scan'208";a="35243636"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V3 07/39] x86/intel_rdt: Initialize new resource group with sane defaults
Date: Wed, 25 Apr 2018 03:09:43 -0700
Message-Id: <4c08b710419f4d381442911dd6f836f6452cd9f9.1524649902.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
References: <cover.1524649902.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
References: <cover.1524649902.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently when a new resource group is created its allocations would be
those that belonged to the resource group to which its closid belonged
previously.

That is, we can encounter a case like:
mkdir newgroup
cat newgroup/schemata
L2:0=ff;1=ff
echo 'L2:0=0xf0;1=0xf0' > newgroup/schemata
cat newgroup/schemata
L2:0=0xf0;1=0xf0
rmdir newgroup
mkdir newnewgroup
cat newnewgroup/schemata
L2:0=0xf0;1=0xf0

When the new group is created it would be reasonable to expect its
allocations to be initialized with all regions that it can possibly use.
At this time these regions would be all that are shareable by other
resource groups as well as regions that are not currently used.

When a new resource group is created the hardware is initialized with
these new default allocations.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 69 ++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index bc392ff597c3..d66283f83ece 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -133,7 +133,7 @@ void closid_free(int closid)
  * Return: true if @closid is currently associated with a resource group,
  * false if @closid is free
  */
-static bool __attribute__ ((unused)) closid_allocated(unsigned int closid)
+static bool closid_allocated(unsigned int closid)
 {
 	return (closid_free_map & (1 << closid)) == 0;
 }
@@ -1766,6 +1766,64 @@ static int mkdir_mondata_all(struct kernfs_node *parent_kn,
 	return ret;
 }
 
+/**
+ * rdtgroup_init_alloc - Initialize the new RDT group's allocations
+ *
+ * A new RDT group is being created on an allocation capable (CAT)
+ * supporting system. Set this group up to start off with all usable
+ * allocations. That is, all shareable and unused bits.
+ *
+ * All-zero CBM is invalid. If there are no more shareable bits available
+ * on any domain then the entire allocation will fail.
+ */
+static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
+{
+	u32 used_b = 0, unused_b = 0;
+	u32 closid = rdtgrp->closid;
+	struct rdt_resource *r;
+	enum rdtgrp_mode mode;
+	struct rdt_domain *d;
+	int i, ret;
+	u32 *ctrl;
+
+	for_each_alloc_enabled_rdt_resource(r) {
+		list_for_each_entry(d, &r->domains, list) {
+			d->have_new_ctrl = false;
+			d->new_ctrl = r->cache.shareable_bits;
+			used_b = r->cache.shareable_bits;
+			ctrl = d->ctrl_val;
+			for (i = 0; i < r->num_closid; i++, ctrl++) {
+				if (closid_allocated(i) && i != closid) {
+					mode = rdtgroup_mode_by_closid(i);
+					used_b |= *ctrl;
+					if (mode == RDT_MODE_SHAREABLE)
+						d->new_ctrl |= *ctrl;
+				}
+			}
+			unused_b = used_b ^ (BIT_MASK(r->cache.cbm_len) - 1);
+			unused_b &= BIT_MASK(r->cache.cbm_len) - 1;
+			d->new_ctrl |= unused_b;
+			if (d->new_ctrl == 0) {
+				rdt_last_cmd_printf("no space on %s:%d\n",
+						    r->name, d->id);
+				return -ENOSPC;
+			}
+			d->have_new_ctrl = true;
+		}
+	}
+
+	for_each_alloc_enabled_rdt_resource(r) {
+		ret = update_domains(r, rdtgrp->closid);
+		if (ret < 0) {
+			rdt_last_cmd_puts("failed to initialize allocations\n");
+			return ret;
+		}
+		rdtgrp->mode = RDT_MODE_SHAREABLE;
+	}
+
+	return 0;
+}
+
 static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
 			     struct kernfs_node *prgrp_kn,
 			     const char *name, umode_t mode,
@@ -1923,6 +1981,10 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
 	closid = ret;
 
 	rdtgrp->closid = closid;
+	ret = rdtgroup_init_alloc(rdtgrp);
+	if (ret < 0)
+		goto out_id_free;
+
 	list_add(&rdtgrp->rdtgroup_list, &rdt_all_groups);
 
 	if (rdt_mon_capable) {
@@ -1933,15 +1995,16 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
 		ret = mongroup_create_dir(kn, NULL, "mon_groups", NULL);
 		if (ret) {
 			rdt_last_cmd_puts("kernfs subdir error\n");
-			goto out_id_free;
+			goto out_del_list;
 		}
 	}
 
 	goto out_unlock;
 
+out_del_list:
+	list_del(&rdtgrp->rdtgroup_list);
 out_id_free:
 	closid_free(closid);
-	list_del(&rdtgrp->rdtgroup_list);
 out_common_fail:
 	mkdir_rdt_prepare_clean(rdtgrp);
 out_unlock:
-- 
2.13.6

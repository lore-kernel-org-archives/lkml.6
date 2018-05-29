Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937171AbeE2VGw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 17:06:52 -0400
Received: from mga07.intel.com ([134.134.136.100]:33627 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937093AbeE2VA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 17:00:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,457,1520924400";
   d="scan'208";a="60127783"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V5 38/38] x86/intel_rdt: Limit C-states dynamically when pseudo-locking active
Date: Tue, 29 May 2018 05:58:03 -0700
Message-Id: <1282e07cd1a5291bc42dfcd117be12916e538ff2.1527593971.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1527593970.git.reinette.chatre@intel.com>
References: <cover.1527593970.git.reinette.chatre@intel.com>
MIME-Version: 1.0
In-Reply-To: <cover.1527593970.git.reinette.chatre@intel.com>
References: <cover.1527593970.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deeper C-states impact cache content through shrinking of the cache or
flushing entire cache to memory before reducing power to the cache.
Deeper C-states will thus negatively impact the pseudo-locked regions.

To avoid impacting pseudo-locked regions C-states are limited on
pseudo-locked region creation so that cores associated with the
pseudo-locked region are prevented from entering deeper C-states.
This is accomplished by requesting a CPU latency target which will
prevent the core from entering C6 across all supported platforms.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 Documentation/x86/intel_rdt_ui.txt          |  4 +-
 arch/x86/kernel/cpu/intel_rdt.h             |  2 +
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 85 ++++++++++++++++++++++++++++-
 3 files changed, 87 insertions(+), 4 deletions(-)

diff --git a/Documentation/x86/intel_rdt_ui.txt b/Documentation/x86/intel_rdt_ui.txt
index bcd0a6d2fcf8..acac30b67c62 100644
--- a/Documentation/x86/intel_rdt_ui.txt
+++ b/Documentation/x86/intel_rdt_ui.txt
@@ -461,8 +461,8 @@ in the cache via carefully configuring the CAT feature and controlling
 application behavior. There is no guarantee that data is placed in
 cache. Instructions like INVD, WBINVD, CLFLUSH, etc. can still evict
 “locked” data from cache. Power management C-states may shrink or
-power off cache. It is thus recommended to limit the processor maximum
-C-state, for example, by setting the processor.max_cstate kernel parameter.
+power off cache. Deeper C-states will automatically be restricted on
+pseudo-locked region creation.
 
 It is required that an application using a pseudo-locked region runs
 with affinity to the cores (or a subset of the cores) associated
diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index b8e490a43290..2d9cbb9d7a58 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -142,6 +142,7 @@ struct mongroup {
  *			region
  * @debugfs_dir:	pointer to this region's directory in the debugfs
  *			filesystem
+ * @pm_reqs:		Power management QoS requests related to this region
  */
 struct pseudo_lock_region {
 	struct rdt_resource	*r;
@@ -155,6 +156,7 @@ struct pseudo_lock_region {
 	void			*kmem;
 	unsigned int		minor;
 	struct dentry		*debugfs_dir;
+	struct list_head	pm_reqs;
 };
 
 /**
diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index a293487b3a44..3153c4dcdc28 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -17,6 +17,7 @@
 #include <linux/debugfs.h>
 #include <linux/kthread.h>
 #include <linux/mman.h>
+#include <linux/pm_qos.h>
 #include <linux/slab.h>
 #include <asm/cacheflush.h>
 #include <asm/intel-family.h>
@@ -173,6 +174,76 @@ static struct rdtgroup *region_find_by_minor(unsigned int minor)
 }
 
 /**
+ * pseudo_lock_pm_req - A power management QoS request list entry
+ * @list:	Entry within the @pm_reqs list for a pseudo-locked region
+ * @req:	PM QoS request
+ */
+struct pseudo_lock_pm_req {
+	struct list_head list;
+	struct dev_pm_qos_request req;
+};
+
+static void pseudo_lock_cstates_relax(struct pseudo_lock_region *plr)
+{
+	struct pseudo_lock_pm_req *pm_req, *next;
+
+	list_for_each_entry_safe(pm_req, next, &plr->pm_reqs, list) {
+		dev_pm_qos_remove_request(&pm_req->req);
+		list_del(&pm_req->list);
+		kfree(pm_req);
+	}
+}
+
+/**
+ * pseudo_lock_cstates_constrain - Restrict cores from entering C6
+ *
+ * To prevent the cache from being affected by power management entering
+ * C6 has to be avoided. This is accomplished by requesting a latency
+ * requirement lower than lowest C6 exit latency of all supported
+ * platforms as found in the cpuidle state tables in the intel_idle driver.
+ * At this time it is possible to do so with a single latency requirement
+ * for all supported platforms.
+ *
+ * Since Goldmont is supported, which is affected by X86_BUG_MONITOR,
+ * the ACPI latencies need to be considered while keeping in mind that C2
+ * may be set to map to deeper sleep states. In this case the latency
+ * requirement needs to prevent entering C2 also.
+ */
+static int pseudo_lock_cstates_constrain(struct pseudo_lock_region *plr)
+{
+	struct pseudo_lock_pm_req *pm_req;
+	int cpu;
+	int ret;
+
+	for_each_cpu(cpu, &plr->d->cpu_mask) {
+		pm_req = kzalloc(sizeof(*pm_req), GFP_KERNEL);
+		if (!pm_req) {
+			rdt_last_cmd_puts("fail allocating mem for PM QoS\n");
+			ret = -ENOMEM;
+			goto out_err;
+		}
+		ret = dev_pm_qos_add_request(get_cpu_device(cpu),
+					     &pm_req->req,
+					     DEV_PM_QOS_RESUME_LATENCY,
+					     30);
+		if (ret < 0) {
+			rdt_last_cmd_printf("fail to add latency req cpu%d\n",
+					    cpu);
+			kfree(pm_req);
+			ret = -1;
+			goto out_err;
+		}
+		list_add(&pm_req->list, &plr->pm_reqs);
+	}
+
+	return 0;
+
+out_err:
+	pseudo_lock_cstates_relax(plr);
+	return ret;
+}
+
+/**
  * pseudo_lock_region_init - Initialize pseudo-lock region information
  * @plr: pseudo-lock region
  *
@@ -237,6 +308,7 @@ static int pseudo_lock_init(struct rdtgroup *rdtgrp)
 		return -ENOMEM;
 
 	init_waitqueue_head(&plr->lock_thread_wq);
+	INIT_LIST_HEAD(&plr->pm_reqs);
 	rdtgrp->plr = plr;
 	return 0;
 }
@@ -1112,6 +1184,12 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
 	if (ret < 0)
 		return ret;
 
+	ret = pseudo_lock_cstates_constrain(plr);
+	if (ret < 0) {
+		ret = -EINVAL;
+		goto out_region;
+	}
+
 	plr->thread_done = 0;
 
 	thread = kthread_create_on_node(pseudo_lock_fn, rdtgrp,
@@ -1120,7 +1198,7 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
 	if (IS_ERR(thread)) {
 		ret = PTR_ERR(thread);
 		rdt_last_cmd_printf("locking thread returned error %d\n", ret);
-		goto out_region;
+		goto out_cstates;
 	}
 
 	kthread_bind(thread, plr->cpu);
@@ -1138,7 +1216,7 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
 		 * empty pseudo-locking loop.
 		 */
 		rdt_last_cmd_puts("locking thread interrupted\n");
-		goto out_region;
+		goto out_cstates;
 	}
 
 	if (!IS_ERR_OR_NULL(debugfs_resctrl)) {
@@ -1199,6 +1277,8 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
 	pseudo_lock_minor_release(new_minor);
 out_debugfs:
 	debugfs_remove_recursive(plr->debugfs_dir);
+out_cstates:
+	pseudo_lock_cstates_relax(plr);
 out_region:
 	pseudo_lock_region_clear(plr);
 out:
@@ -1232,6 +1312,7 @@ void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp)
 		goto free;
 	}
 
+	pseudo_lock_cstates_relax(plr);
 	debugfs_remove_recursive(rdtgrp->plr->debugfs_dir);
 	device_destroy(pseudo_lock_class, MKDEV(pseudo_lock_major, plr->minor));
 	pseudo_lock_minor_release(plr->minor);
-- 
2.13.6

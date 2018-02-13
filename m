Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966263AbeBMXtq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 18:49:46 -0500
Received: from mga17.intel.com ([192.55.52.151]:53399 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966234AbeBMXtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 18:49:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,509,1511856000";
   d="scan'208";a="29822364"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com
Cc: gavin.hindman@intel.com, vikas.shivappa@linux.intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [RFC PATCH V2 20/22] x86/intel_rdt: Limit C-states dynamically when pseudo-locking active
Date: Tue, 13 Feb 2018 07:47:04 -0800
Message-Id: <0ac56339a2966691b61cd7f5cdc0fb738c920ec3.1518443616.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1518443616.git.reinette.chatre@intel.com>
References: <cover.1518443616.git.reinette.chatre@intel.com>
MIME-Version: 1.0
In-Reply-To: <cover.1518443616.git.reinette.chatre@intel.com>
References: <cover.1518443616.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deeper C-states impact cache content through shrinking of the cache or
flushing entire cache to memory before reducing power to the cache.
Deeper C-states will thus negatively impact the pseudo-locked regions.

To avoid impacting pseudo-locked regions we limit C-states on
pseudo-locked region creation so that cores associated with the
pseudo-locked region are prevented from entering deeper C-states.
This is accomplished by requesting a CPU latency target which will
prevent the core from entering C6 across all supported platforms.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 Documentation/x86/intel_rdt_ui.txt          |  4 +-
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 89 ++++++++++++++++++++++++++++-
 2 files changed, 88 insertions(+), 5 deletions(-)

diff --git a/Documentation/x86/intel_rdt_ui.txt b/Documentation/x86/intel_rdt_ui.txt
index bb3d6fe0a3e4..755d16ae7db6 100644
--- a/Documentation/x86/intel_rdt_ui.txt
+++ b/Documentation/x86/intel_rdt_ui.txt
@@ -349,8 +349,8 @@ in the cache via carefully configuring the CAT feature and controlling
 application behavior. There is no guarantee that data is placed in
 cache. Instructions like INVD, WBINVD, CLFLUSH, etc. can still evict
 “locked” data from cache. Power management C-states may shrink or
-power off cache. It is thus recommended to limit the processor maximum
-C-state, for example, by setting the processor.max_cstate kernel parameter.
+power off cache. Deeper C-states will automatically be restricted on
+pseudo-locked region creation.
 
 It is required that an application using a pseudo-locked region runs
 with affinity to the cores (or a subset of the cores) associated
diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index 7511c2089d07..90f040166fcd 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -27,6 +27,7 @@
 #include <linux/kref.h>
 #include <linux/kthread.h>
 #include <linux/mman.h>
+#include <linux/pm_qos.h>
 #include <linux/seq_file.h>
 #include <linux/stat.h>
 #include <linux/slab.h>
@@ -120,6 +121,7 @@ static struct dentry *debugfs_pseudo;
  * @kmem:		the kernel memory associated with pseudo-locked region
  * @debugfs_dir:	pointer to this region's directory in the debugfs
  *			filesystem
+ * @pm_reqs:		Power management QoS requests related to this region
  */
 struct pseudo_lock_region {
 	struct kernfs_node	*kn;
@@ -138,6 +140,17 @@ struct pseudo_lock_region {
 #ifdef CONFIG_INTEL_RDT_DEBUGFS
 	struct dentry		*debugfs_dir;
 #endif
+	struct list_head	pm_reqs;
+};
+
+/**
+ * pseudo_lock_pm_req - A power management QoS request list entry
+ * @list:	Entry within the @pm_reqs list for a pseudo-locked region
+ * @req:	PM QoS request
+ */
+struct pseudo_lock_pm_req {
+	struct list_head list;
+	struct dev_pm_qos_request req;
 };
 
 /*
@@ -208,6 +221,66 @@ static void pseudo_lock_minor_release(unsigned int minor)
 	__set_bit(minor, &pseudo_lock_minor_avail);
 }
 
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
+ * To prevent the cache from being affected by power management we have to
+ * avoid entering C6. We accomplish this by requesting a latency
+ * requirement lower than lowest C6 exit latency of all supported
+ * platforms as found in the cpuidle state tables in the intel_idle driver.
+ * At this time it is possible to do so with a single latency requirement
+ * for all supported platforms.
+ *
+ * Since we do support Goldmont, which is affected by X86_BUG_MONITOR, we
+ * need to consider the ACPI latencies while keeping in mind that C2 may be
+ * set to map to deeper sleep states. In this case the latency requirement
+ * needs to prevent entering C2 also.
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
 static void __pseudo_lock_region_release(struct pseudo_lock_region *plr)
 {
 	bool is_new_plr = (plr == new_plr);
@@ -218,6 +291,7 @@ static void __pseudo_lock_region_release(struct pseudo_lock_region *plr)
 
 	if (plr->locked) {
 		plr->d->plr = NULL;
+		pseudo_lock_cstates_relax(plr);
 		device_destroy(pseudo_lock_class,
 			       MKDEV(pseudo_lock_major, plr->minor));
 		pseudo_lock_minor_release(plr->minor);
@@ -1077,6 +1151,12 @@ static int pseudo_lock_doit(struct pseudo_lock_region *plr,
 		goto out_clos_def;
 	}
 
+	ret = pseudo_lock_cstates_constrain(plr);
+	if (ret < 0) {
+		ret = -EINVAL;
+		goto out_clos_def;
+	}
+
 	plr->closid = closid;
 
 	thread_done = 0;
@@ -1092,7 +1172,7 @@ static int pseudo_lock_doit(struct pseudo_lock_region *plr,
 		 * error path since that will result in a CBM of all
 		 * zeroes which is an illegal MSR write.
 		 */
-		goto out_clos_def;
+		goto out_cstates;
 	}
 
 	kthread_bind(thread, plr->cpu);
@@ -1101,7 +1181,7 @@ static int pseudo_lock_doit(struct pseudo_lock_region *plr,
 	ret = wait_event_interruptible(wq, thread_done == 1);
 	if (ret < 0) {
 		rdt_last_cmd_puts("locking thread interrupted\n");
-		goto out_clos_def;
+		goto out_cstates;
 	}
 
 	/*
@@ -1118,7 +1198,7 @@ static int pseudo_lock_doit(struct pseudo_lock_region *plr,
 	ret = pseudo_lock_minor_get(&new_minor);
 	if (ret < 0) {
 		rdt_last_cmd_puts("unable to obtain a new minor number\n");
-		goto out_clos_def;
+		goto out_cstates;
 	}
 
 	plr->locked = true;
@@ -1163,6 +1243,8 @@ static int pseudo_lock_doit(struct pseudo_lock_region *plr,
 
 out_minor:
 	pseudo_lock_minor_release(new_minor);
+out_cstates:
+	pseudo_lock_cstates_relax(plr);
 out_clos_def:
 	pseudo_lock_clos_set(plr, 0, d->ctrl_val[0] | plr->cbm);
 out_closid:
@@ -1355,6 +1437,7 @@ int rdt_pseudo_lock_mkdir(const char *name, umode_t mode)
 	}
 #endif
 
+	INIT_LIST_HEAD(&plr->pm_reqs);
 	kref_init(&plr->refcount);
 	kernfs_activate(kn);
 	new_plr = plr;
-- 
2.13.6

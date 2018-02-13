Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966211AbeBMXtg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 18:49:36 -0500
Received: from mga17.intel.com ([192.55.52.151]:53394 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966064AbeBMXte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 18:49:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,509,1511856000";
   d="scan'208";a="29822314"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com
Cc: gavin.hindman@intel.com, vikas.shivappa@linux.intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [RFC PATCH V2 06/22] x86/intel_rdt: Create pseudo-locked regions
Date: Tue, 13 Feb 2018 07:46:50 -0800
Message-Id: <17cceeb077f3ac5f50b110285b36905091a345b0.1518443616.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1518443616.git.reinette.chatre@intel.com>
References: <cover.1518443616.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1518443616.git.reinette.chatre@intel.com>
References: <cover.1518443616.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

System administrator creates/removes pseudo-locked regions by
creating/removing directories in the pseudo-lock subdirectory of the
resctrl filesystem. Here we add directory creation and removal support.

A "pseudo-lock region" is introduced, which represents an
instance of a pseudo-locked cache region. During mkdir a new region is
created but since we do not know which cache it belongs to at that time
we maintain a global pointer to it from where it will be moved to the cache
(rdt_domain) it belongs to after initialization. This implies that
we only support one uninitialized pseudo-locked region at a time.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt.h             |   3 +
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 220 +++++++++++++++++++++++++++-
 2 files changed, 222 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 8f5ded384e19..55f085985072 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -352,6 +352,7 @@ extern struct mutex rdtgroup_mutex;
 extern struct rdt_resource rdt_resources_all[];
 extern struct rdtgroup rdtgroup_default;
 DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
+extern struct kernfs_node *pseudo_lock_kn;
 
 int __init rdtgroup_init(void);
 
@@ -457,5 +458,7 @@ bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
 void __check_limbo(struct rdt_domain *d, bool force_free);
 int rdt_pseudo_lock_fs_init(struct kernfs_node *root);
 void rdt_pseudo_lock_fs_remove(void);
+int rdt_pseudo_lock_mkdir(const char *name, umode_t mode);
+int rdt_pseudo_lock_rmdir(struct kernfs_node *kn);
 
 #endif /* _ASM_X86_INTEL_RDT_H */
diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index a787a103c432..7a22e367b82f 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -20,11 +20,142 @@
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
 #include <linux/kernfs.h>
+#include <linux/kref.h>
 #include <linux/seq_file.h>
 #include <linux/stat.h>
+#include <linux/slab.h>
 #include "intel_rdt.h"
 
-static struct kernfs_node *pseudo_lock_kn;
+struct kernfs_node *pseudo_lock_kn;
+
+/*
+ * Protect the pseudo_lock_region access. Since we will link to
+ * pseudo_lock_region from rdt domains rdtgroup_mutex should be obtained
+ * first if needed.
+ */
+static DEFINE_MUTEX(rdt_pseudo_lock_mutex);
+
+/**
+ * struct pseudo_lock_region - pseudo-lock region information
+ * @kn:			kernfs node representing this region in the resctrl
+ *			filesystem
+ * @cbm:		bitmask of the pseudo-locked region
+ * @cpu:		core associated with the cache on which the setup code
+ *			will be run
+ * @minor:		minor number of character device associated with this
+ *			region
+ * @locked:		state indicating if this region has been locked or not
+ * @refcount:		how many are waiting to access this pseudo-lock
+ *			region via kernfs
+ * @deleted:		user requested removal of region via rmdir on kernfs
+ */
+struct pseudo_lock_region {
+	struct kernfs_node	*kn;
+	u32			cbm;
+	int			cpu;
+	unsigned int		minor;
+	bool			locked;
+	struct kref		refcount;
+	bool			deleted;
+};
+
+/*
+ * Only one uninitialized pseudo-locked region can exist at a time. An
+ * uninitialized pseudo-locked region is created when the user creates a
+ * new directory within the pseudo_lock subdirectory of the resctrl
+ * filsystem. The user will initialize the pseudo-locked region by writing
+ * to its schemata file at which point this structure will be moved to the
+ * cache domain it belongs to.
+ */
+static struct pseudo_lock_region *new_plr;
+
+static void __pseudo_lock_region_release(struct pseudo_lock_region *plr)
+{
+	bool is_new_plr = (plr == new_plr);
+
+	WARN_ON(!plr->deleted);
+	if (!plr->deleted)
+		return;
+
+	kfree(plr);
+	if (is_new_plr)
+		new_plr = NULL;
+}
+
+static void pseudo_lock_region_release(struct kref *ref)
+{
+	struct pseudo_lock_region *plr = container_of(ref,
+						      struct pseudo_lock_region,
+						      refcount);
+
+	mutex_lock(&rdt_pseudo_lock_mutex);
+	__pseudo_lock_region_release(plr);
+	mutex_unlock(&rdt_pseudo_lock_mutex);
+}
+
+/**
+ * pseudo_lock_region_kn_lock - Obtain lock to pseudo-lock region kernfs node
+ *
+ * This is called from the kernfs related functions which are called with
+ * an active reference to the kernfs_node that contains a valid pointer to
+ * the pseudo-lock region it represents. We can thus safely take an active
+ * reference to the pseudo-lock region before dropping the reference to the
+ * kernfs_node.
+ *
+ * We need to handle the scenarios where the kernfs directory representing
+ * this pseudo-lock region can be removed while an application still has an
+ * open handle to one of the directory's files and operations on this
+ * handle are attempted.
+ * To support this we allow a file operation to drop its reference to the
+ * kernfs_node so that the removal can proceed, while using the mutex to
+ * ensure these operations on the pseudo-lock region are serialized. At the
+ * time an operation does obtain access to the region it may thus have been
+ * deleted.
+ */
+static struct pseudo_lock_region *pseudo_lock_region_kn_lock(
+						struct kernfs_node *kn)
+{
+	struct pseudo_lock_region *plr = (kernfs_type(kn) == KERNFS_DIR) ?
+						kn->priv : kn->parent->priv;
+
+	WARN_ON(!plr);
+	if (!plr)
+		return NULL;
+
+	kref_get(&plr->refcount);
+	kernfs_break_active_protection(kn);
+
+	mutex_lock(&rdtgroup_mutex);
+	mutex_lock(&rdt_pseudo_lock_mutex);
+
+	if (plr->deleted)
+		return NULL;
+
+	return plr;
+}
+
+/**
+ * pseudo_lock_region_kn_unlock - Release lock to pseudo-lock region kernfs node
+ *
+ * The pseudo-lock region's kernfs_node did not have protection against
+ * removal while the lock was held. Here we do actual cleanup if the region
+ * was removed while the lock was held.
+ */
+static void pseudo_lock_region_kn_unlock(struct kernfs_node *kn)
+{
+	struct pseudo_lock_region *plr = (kernfs_type(kn) == KERNFS_DIR) ?
+						kn->priv : kn->parent->priv;
+
+	WARN_ON(!plr);
+	if (!plr)
+		return;
+
+	mutex_unlock(&rdt_pseudo_lock_mutex);
+	mutex_unlock(&rdtgroup_mutex);
+
+	kernfs_unbreak_active_protection(kn);
+	kref_put(&plr->refcount, pseudo_lock_region_release);
+}
 
 /**
  * pseudo_lock_avail_get - return bitmask of cache available for locking
@@ -96,6 +227,87 @@ static struct kernfs_ops pseudo_lock_avail_ops = {
 	.seq_show		= pseudo_lock_avail_show,
 };
 
+int rdt_pseudo_lock_mkdir(const char *name, umode_t mode)
+{
+	struct pseudo_lock_region *plr;
+	struct kernfs_node *kn;
+	int ret = 0;
+
+	mutex_lock(&rdtgroup_mutex);
+	mutex_lock(&rdt_pseudo_lock_mutex);
+
+	if (new_plr) {
+		ret = -ENOSPC;
+		goto out;
+	}
+
+	plr = kzalloc(sizeof(*plr), GFP_KERNEL);
+	if (!plr) {
+		ret = -ENOSPC;
+		goto out;
+	}
+
+	kn = kernfs_create_dir(pseudo_lock_kn, name, mode, plr);
+	if (IS_ERR(kn)) {
+		ret = PTR_ERR(kn);
+		goto out_free;
+	}
+
+	plr->kn = kn;
+	ret = rdtgroup_kn_set_ugid(kn);
+	if (ret)
+		goto out_remove;
+
+	kref_init(&plr->refcount);
+	kernfs_activate(kn);
+	new_plr = plr;
+	ret = 0;
+	goto out;
+
+out_remove:
+	kernfs_remove(kn);
+out_free:
+	kfree(plr);
+out:
+	mutex_unlock(&rdt_pseudo_lock_mutex);
+	mutex_unlock(&rdtgroup_mutex);
+	return ret;
+}
+
+/*
+ * rdt_pseudo_lock_rmdir - Remove pseudo-lock region
+ *
+ * LOCKING:
+ * Since the pseudo-locked region can be associated with a RDT domain at
+ * removal we take both rdtgroup_mutex and rdt_pseudo_lock_mutex to protect
+ * the rdt_domain access as well as the pseudo_lock_region access.
+ */
+int rdt_pseudo_lock_rmdir(struct kernfs_node *kn)
+{
+	struct kernfs_node *parent_kn = kn->parent;
+	struct pseudo_lock_region *plr;
+	int ret = 0;
+
+	plr = pseudo_lock_region_kn_lock(kn);
+	if (!plr) {
+		ret = -EPERM;
+		goto out;
+	}
+
+	if (parent_kn != pseudo_lock_kn) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	kernfs_remove(kn);
+	plr->deleted = true;
+	kref_put(&plr->refcount, pseudo_lock_region_release);
+
+out:
+	pseudo_lock_region_kn_unlock(kn);
+	return ret;
+}
+
 /**
  * rdt_pseudo_lock_fs_init - Create and initialize pseudo-locking files
  * @root: location in kernfs where directory and files should be created
@@ -159,7 +371,13 @@ int rdt_pseudo_lock_fs_init(struct kernfs_node *root)
 void rdt_pseudo_lock_fs_remove(void)
 {
 	lockdep_assert_held(&rdtgroup_mutex);
+	mutex_lock(&rdt_pseudo_lock_mutex);
 
+	if (new_plr) {
+		new_plr->deleted = true;
+		__pseudo_lock_region_release(new_plr);
+	}
 	kernfs_remove(pseudo_lock_kn);
 	pseudo_lock_kn = NULL;
+	mutex_unlock(&rdt_pseudo_lock_mutex);
 }
-- 
2.13.6

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966251AbeBMXwp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 18:52:45 -0500
Received: from mga17.intel.com ([192.55.52.151]:53397 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966102AbeBMXtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 18:49:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,509,1511856000";
   d="scan'208";a="29822320"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com
Cc: gavin.hindman@intel.com, vikas.shivappa@linux.intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [RFC PATCH V2 08/22] x86/intel_rdt: Introduce pseudo-locking resctrl files
Date: Tue, 13 Feb 2018 07:46:52 -0800
Message-Id: <fadd2bd34f8cff46ecaf1071d2ff93340c683ed1.1518443616.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1518443616.git.reinette.chatre@intel.com>
References: <cover.1518443616.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1518443616.git.reinette.chatre@intel.com>
References: <cover.1518443616.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each sub-directory within the pseudo-lock directory represents a
pseudo-locked region. Each of these sub-directories now receive the
files that will be used by the user to specify requirements for the
particular region and for the kernel to communicate some details about
the region.

Only support reading operations on these files in this commit. Since
writing to these files will trigger the locking of a region we also just
support reading of unlocked region data.

Two files are created:
schemata:
	Print the details of the portion of cache locked. If this has
	not yet been locked all resources will be listed as uninitialized.
size:
	Print the size in bytes of the memory region pseudo-locked to
	the cache. Value is not yet initialized.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt.h             |  5 +++
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 49 +++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c    | 14 +++++++++
 3 files changed, 68 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 55f085985072..060a0976ac00 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -134,6 +134,7 @@ struct rdtgroup {
 #define RFTYPE_CTRL			BIT(RF_CTRLSHIFT)
 #define RFTYPE_MON			BIT(RF_MONSHIFT)
 #define RFTYPE_TOP			BIT(RF_TOPSHIFT)
+#define RF_PSEUDO_LOCK			BIT(7)
 #define RFTYPE_RES_CACHE		BIT(8)
 #define RFTYPE_RES_MB			BIT(9)
 #define RF_CTRL_INFO			(RFTYPE_INFO | RFTYPE_CTRL)
@@ -460,5 +461,9 @@ int rdt_pseudo_lock_fs_init(struct kernfs_node *root);
 void rdt_pseudo_lock_fs_remove(void);
 int rdt_pseudo_lock_mkdir(const char *name, umode_t mode);
 int rdt_pseudo_lock_rmdir(struct kernfs_node *kn);
+int pseudo_lock_schemata_show(struct kernfs_open_file *of,
+			      struct seq_file *seq, void *v);
+int pseudo_lock_size_show(struct kernfs_open_file *of,
+			  struct seq_file *seq, void *v);
 
 #endif /* _ASM_X86_INTEL_RDT_H */
diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index 7a22e367b82f..94bd1b4fbfee 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -40,6 +40,7 @@ static DEFINE_MUTEX(rdt_pseudo_lock_mutex);
  * @kn:			kernfs node representing this region in the resctrl
  *			filesystem
  * @cbm:		bitmask of the pseudo-locked region
+ * @size:		size of pseudo-locked region in bytes
  * @cpu:		core associated with the cache on which the setup code
  *			will be run
  * @minor:		minor number of character device associated with this
@@ -52,6 +53,7 @@ static DEFINE_MUTEX(rdt_pseudo_lock_mutex);
 struct pseudo_lock_region {
 	struct kernfs_node	*kn;
 	u32			cbm;
+	unsigned int		size;
 	int			cpu;
 	unsigned int		minor;
 	bool			locked;
@@ -227,6 +229,49 @@ static struct kernfs_ops pseudo_lock_avail_ops = {
 	.seq_show		= pseudo_lock_avail_show,
 };
 
+int pseudo_lock_schemata_show(struct kernfs_open_file *of,
+			      struct seq_file *seq, void *v)
+{
+	struct pseudo_lock_region *plr;
+	struct rdt_resource *r;
+	int ret = 0;
+
+	plr = pseudo_lock_region_kn_lock(of->kn);
+	if (!plr) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	if (!plr->locked) {
+		for_each_alloc_enabled_rdt_resource(r) {
+			seq_printf(seq, "%s:uninitialized\n", r->name);
+		}
+	}
+
+out:
+	pseudo_lock_region_kn_unlock(of->kn);
+	return ret;
+}
+
+int pseudo_lock_size_show(struct kernfs_open_file *of,
+			  struct seq_file *seq, void *v)
+{
+	struct pseudo_lock_region *plr;
+	int ret = 0;
+
+	plr = pseudo_lock_region_kn_lock(of->kn);
+	if (!plr) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	seq_printf(seq, "%u\n", plr->size);
+
+out:
+	pseudo_lock_region_kn_unlock(of->kn);
+	return ret;
+}
+
 int rdt_pseudo_lock_mkdir(const char *name, umode_t mode)
 {
 	struct pseudo_lock_region *plr;
@@ -258,6 +303,10 @@ int rdt_pseudo_lock_mkdir(const char *name, umode_t mode)
 	if (ret)
 		goto out_remove;
 
+	ret = rdtgroup_add_files(kn, RF_PSEUDO_LOCK);
+	if (ret)
+		goto out_remove;
+
 	kref_init(&plr->refcount);
 	kernfs_activate(kn);
 	new_plr = plr;
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 24d2def37797..a7cbaf85ed54 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -859,6 +859,20 @@ static struct rftype res_common_files[] = {
 		.seq_show	= rdtgroup_schemata_show,
 		.fflags		= RF_CTRL_BASE,
 	},
+	{
+		.name		= "schemata",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= pseudo_lock_schemata_show,
+		.fflags		= RF_PSEUDO_LOCK,
+	},
+	{
+		.name		= "size",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= pseudo_lock_size_show,
+		.fflags		= RF_PSEUDO_LOCK,
+	},
 };
 
 int rdtgroup_add_files(struct kernfs_node *kn, unsigned long fflags)
-- 
2.13.6

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752797AbeEVTe0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 15:34:26 -0400
Received: from mga07.intel.com ([134.134.136.100]:16706 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752618AbeEVTcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 15:32:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,430,1520924400";
   d="scan'208";a="226406435"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V4 33/38] x86/intel_rdt: Create resctrl debug area
Date: Tue, 22 May 2018 04:29:21 -0700
Message-Id: <6471cf0240686dcf0a600b93a50163fb795564bb.1526987654.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1526987654.git.reinette.chatre@intel.com>
References: <cover.1526987654.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1526987654.git.reinette.chatre@intel.com>
References: <cover.1526987654.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for support of debugging of RDT sub features the user can
now enable a RDT debugfs region.

Introduce the Kconfig option to enable this debug area and the subsequent
creation of the resctrl debugfs directory.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/Kconfig                         | 10 ++++++++
 arch/x86/kernel/cpu/intel_rdt.h          |  4 ++++
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 41 ++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c07f492b871a..4fa24d0cce5a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -448,6 +448,16 @@ config INTEL_RDT
 
 	  Say N if unsure.
 
+config INTEL_RDT_DEBUGFS
+	bool "Intel RDT debugfs interface"
+	depends on INTEL_RDT
+	select DEBUG_FS
+	help
+	  Enable the creation of Intel RDT debugfs files. In support of
+	  debugging and validation of Intel RDT sub-features that use it.
+
+	  Say N if unsure.
+
 if X86_32
 config X86_BIGSMP
 	bool "Support for big SMP systems with more than 8 CPUs"
diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index c948266d59c8..c4ff638e3bc6 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -432,6 +432,10 @@ extern struct rdt_resource rdt_resources_all[];
 extern struct rdtgroup rdtgroup_default;
 DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
 
+#ifdef CONFIG_INTEL_RDT_DEBUGFS
+extern struct dentry *debugfs_resctrl;
+#endif
+
 enum {
 	RDT_RESOURCE_L3,
 	RDT_RESOURCE_L3DATA,
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index e3380cbca914..da9d470294aa 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -22,6 +22,7 @@
 
 #include <linux/cacheinfo.h>
 #include <linux/cpu.h>
+#include <linux/debugfs.h>
 #include <linux/fs.h>
 #include <linux/sysfs.h>
 #include <linux/kernfs.h>
@@ -56,6 +57,10 @@ static struct kernfs_node *kn_mondata;
 static struct seq_buf last_cmd_status;
 static char last_cmd_status_buf[512];
 
+#ifdef CONFIG_INTEL_RDT_DEBUGFS
+struct dentry *debugfs_resctrl;
+#endif
+
 void rdt_last_cmd_clear(void)
 {
 	lockdep_assert_held(&rdtgroup_mutex);
@@ -2764,8 +2769,41 @@ int __init rdtgroup_init(void)
 	if (ret)
 		goto cleanup_mountpoint;
 
+	/*
+	 * Adding the resctrl debugfs directory here may not be ideal since
+	 * it would let the resctrl debugfs directory appear on the debugfs
+	 * filesystem before the resctrl filesystem is mounted.
+	 * It may also be ok since that would enable debugging of RDT before
+	 * resctrl is mounted.
+	 * The reason why the debugfs directory is created here and not in
+	 * rdt_mount() is because rdt_mount() takes rdtgroup_mutex and
+	 * during the debugfs directory creation also &sb->s_type->i_mutex_key
+	 * (the lockdep class of inode->i_rwsem). Other filesystem
+	 * interactions (eg. SyS_getdents) have the lock ordering:
+	 * &sb->s_type->i_mutex_key --> &mm->mmap_sem
+	 * During mmap(), called with &mm->mmap_sem, the rdtgroup_mutex
+	 * is taken, thus creating dependency:
+	 * &mm->mmap_sem --> rdtgroup_mutex for the latter that can cause
+	 * issues considering the other two lock dependencies.
+	 * By creating the debugfs directory here we avoid a dependency
+	 * that may cause deadlock (even though file operations cannot
+	 * occur until the filesystem is mounted, but I do not know how to
+	 * tell lockdep that).
+	 */
+#ifdef CONFIG_INTEL_RDT_DEBUGFS
+	debugfs_resctrl = debugfs_create_dir("resctrl", NULL);
+	if (IS_ERR(debugfs_resctrl)) {
+		ret = PTR_ERR(debugfs_resctrl);
+		goto cleanup_register;
+	}
+#endif
+
 	return 0;
 
+#ifdef CONFIG_INTEL_RDT_DEBUGFS
+cleanup_register:
+	unregister_filesystem(&rdt_fs_type);
+#endif
 cleanup_mountpoint:
 	sysfs_remove_mount_point(fs_kobj, "resctrl");
 cleanup_root:
@@ -2776,6 +2814,9 @@ int __init rdtgroup_init(void)
 
 void __exit rdtgroup_exit(void)
 {
+#ifdef CONFIG_INTEL_RDT_DEBUGFS
+	debugfs_remove_recursive(debugfs_resctrl);
+#endif
 	unregister_filesystem(&rdt_fs_type);
 	sysfs_remove_mount_point(fs_kobj, "resctrl");
 	kernfs_destroy_root(rdt_root);
-- 
2.13.6

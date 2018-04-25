Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754880AbeDYSNf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 14:13:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:34633 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932253AbeDYSM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 14:12:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,327,1520924400";
   d="scan'208";a="35243763"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V3 33/39] x86/intel_rdt: Create resctrl debug area
Date: Wed, 25 Apr 2018 03:10:09 -0700
Message-Id: <a80a7b7cb595726497a8fc1ca68f30681389e485.1524649902.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
References: <cover.1524649902.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
References: <cover.1524649902.git.reinette.chatre@intel.com>
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
index 20da391b5f32..9c1dc17e7a46 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -455,6 +455,16 @@ config INTEL_RDT
 
 	  Say N if unsure.
 
+config INTEL_RDT_DEBUGFS
+	bool "Intel RDT debugfs interface"
+	depends on INTEL_RDT
+	select DEBUG_FS
+	---help---
+	  Enable the creation of Intel RDT debugfs files. In support of
+	  debugging and validation of Intel RDT sub-features that use it.
+
+	  Say N if unsure.
+
 if X86_32
 config X86_EXTENDED_PLATFORM
 	bool "Support for extended (non-PC) x86 platforms"
diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index ecbded448685..e96ef28d7d42 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -417,6 +417,10 @@ extern struct rdt_resource rdt_resources_all[];
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
index 00b125e5562f..0d8dbe11b8dd 100644
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
@@ -2730,8 +2735,41 @@ int __init rdtgroup_init(void)
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
@@ -2742,6 +2780,9 @@ int __init rdtgroup_init(void)
 
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

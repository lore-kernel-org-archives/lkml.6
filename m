Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967063AbeE2VBw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 17:01:52 -0400
Received: from mga01.intel.com ([192.55.52.88]:53962 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966925AbeE2VBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 17:01:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,457,1520924400";
   d="scan'208";a="60127769"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V5 33/38] x86/intel_rdt: Create resctrl debug area
Date: Tue, 29 May 2018 05:57:58 -0700
Message-Id: <1200798a50791186cd959d75aa3145409ca5151a.1527593971.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1527593970.git.reinette.chatre@intel.com>
References: <cover.1527593970.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1527593970.git.reinette.chatre@intel.com>
References: <cover.1527593970.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for support of debugging of RDT sub features the user can
now enable a RDT debugfs region.

The debug area is always enabled when CONFIG_DEBUG_FS is set as advised
in http://lkml.kernel.org/r/20180523080501.GA6822@kroah.com

Also from same discussion in above linked email, no error checking on the
debugfs creation return value since code should not behave differently when
debugging passes or fails. Even on failure the returned value can be passed
safely to other debugfs calls.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt.h          |  2 ++
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index c948266d59c8..bd3050c1ab6c 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -432,6 +432,8 @@ extern struct rdt_resource rdt_resources_all[];
 extern struct rdtgroup rdtgroup_default;
 DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
 
+extern struct dentry *debugfs_resctrl;
+
 enum {
 	RDT_RESOURCE_L3,
 	RDT_RESOURCE_L3DATA,
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 55a82f1a75d3..e4d061fc2f68 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -22,6 +22,7 @@
 
 #include <linux/cacheinfo.h>
 #include <linux/cpu.h>
+#include <linux/debugfs.h>
 #include <linux/fs.h>
 #include <linux/sysfs.h>
 #include <linux/kernfs.h>
@@ -56,6 +57,8 @@ static struct kernfs_node *kn_mondata;
 static struct seq_buf last_cmd_status;
 static char last_cmd_status_buf[512];
 
+struct dentry *debugfs_resctrl;
+
 void rdt_last_cmd_clear(void)
 {
 	lockdep_assert_held(&rdtgroup_mutex);
@@ -2764,6 +2767,29 @@ int __init rdtgroup_init(void)
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
+	debugfs_resctrl = debugfs_create_dir("resctrl", NULL);
+
 	return 0;
 
 cleanup_mountpoint:
@@ -2776,6 +2802,7 @@ int __init rdtgroup_init(void)
 
 void __exit rdtgroup_exit(void)
 {
+	debugfs_remove_recursive(debugfs_resctrl);
 	unregister_filesystem(&rdt_fs_type);
 	sysfs_remove_mount_point(fs_kobj, "resctrl");
 	kernfs_destroy_root(rdt_root);
-- 
2.13.6

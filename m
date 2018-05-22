Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752805AbeEVTev (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 15:34:51 -0400
Received: from mga07.intel.com ([134.134.136.100]:16707 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752611AbeEVTcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 15:32:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,430,1520924400";
   d="scan'208";a="226406432"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V4 32/38] x86/intel_rdt: Ensure RDT cleanup on exit
Date: Tue, 22 May 2018 04:29:20 -0700
Message-Id: <67f746928704c4a7a11a4c21cadc7ba4d487929a.1526987654.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1526987654.git.reinette.chatre@intel.com>
References: <cover.1526987654.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1526987654.git.reinette.chatre@intel.com>
References: <cover.1526987654.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RDT system's initialization does not have the corresponding exit
handling to ensure everything initialized on load is cleaned up also.

Introduce the cleanup routines that complement all initialization. This
includes the removal of a duplicate rdtgroup_init() declaration.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt.c          | 11 +++++++++++
 arch/x86/kernel/cpu/intel_rdt.h          |  3 +--
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c |  7 +++++++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.c b/arch/x86/kernel/cpu/intel_rdt.c
index 24bfa63e86cf..35dca2187cdc 100644
--- a/arch/x86/kernel/cpu/intel_rdt.c
+++ b/arch/x86/kernel/cpu/intel_rdt.c
@@ -857,6 +857,8 @@ static __init bool get_rdt_resources(void)
 	return (rdt_mon_capable || rdt_alloc_capable);
 }
 
+static enum cpuhp_state rdt_online;
+
 static int __init intel_rdt_late_init(void)
 {
 	struct rdt_resource *r;
@@ -878,6 +880,7 @@ static int __init intel_rdt_late_init(void)
 		cpuhp_remove_state(state);
 		return ret;
 	}
+	rdt_online = state;
 
 	for_each_alloc_capable_rdt_resource(r)
 		pr_info("Intel RDT %s allocation detected\n", r->name);
@@ -889,3 +892,11 @@ static int __init intel_rdt_late_init(void)
 }
 
 late_initcall(intel_rdt_late_init);
+
+static void __exit intel_rdt_exit(void)
+{
+	cpuhp_remove_state(rdt_online);
+	rdtgroup_exit();
+}
+
+__exitcall(intel_rdt_exit);
diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 886cd28b305f..c948266d59c8 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -209,6 +209,7 @@ extern struct list_head rdt_all_groups;
 extern int max_name_width, max_data_width;
 
 int __init rdtgroup_init(void);
+void __exit rdtgroup_exit(void);
 
 /**
  * struct rftype - describe each file in the resctrl file system
@@ -431,8 +432,6 @@ extern struct rdt_resource rdt_resources_all[];
 extern struct rdtgroup rdtgroup_default;
 DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
 
-int __init rdtgroup_init(void);
-
 enum {
 	RDT_RESOURCE_L3,
 	RDT_RESOURCE_L3DATA,
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index d08670ea1a3d..e3380cbca914 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -2773,3 +2773,10 @@ int __init rdtgroup_init(void)
 
 	return ret;
 }
+
+void __exit rdtgroup_exit(void)
+{
+	unregister_filesystem(&rdt_fs_type);
+	sysfs_remove_mount_point(fs_kobj, "resctrl");
+	kernfs_destroy_root(rdt_root);
+}
-- 
2.13.6

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756268AbeDYSSc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 14:18:32 -0400
Received: from mga06.intel.com ([134.134.136.31]:34634 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932251AbeDYSMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 14:12:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,327,1520924400";
   d="scan'208";a="35243760"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V3 32/39] x86/intel_rdt: Ensure RDT cleanup on exit
Date: Wed, 25 Apr 2018 03:10:08 -0700
Message-Id: <78d06bcfa6e51a8fb2d03ca2d1ffdea5d89e24af.1524649902.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
References: <cover.1524649902.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
References: <cover.1524649902.git.reinette.chatre@intel.com>
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
index 410629f10ad3..e80e58058cc0 100644
--- a/arch/x86/kernel/cpu/intel_rdt.c
+++ b/arch/x86/kernel/cpu/intel_rdt.c
@@ -833,6 +833,8 @@ static __init bool get_rdt_resources(void)
 	return (rdt_mon_capable || rdt_alloc_capable);
 }
 
+static enum cpuhp_state rdt_online;
+
 static int __init intel_rdt_late_init(void)
 {
 	struct rdt_resource *r;
@@ -854,6 +856,7 @@ static int __init intel_rdt_late_init(void)
 		cpuhp_remove_state(state);
 		return ret;
 	}
+	rdt_online = state;
 
 	for_each_alloc_capable_rdt_resource(r)
 		pr_info("Intel RDT %s allocation detected\n", r->name);
@@ -865,3 +868,11 @@ static int __init intel_rdt_late_init(void)
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
index c33bad31bf9f..ecbded448685 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -208,6 +208,7 @@ extern struct list_head rdt_all_groups;
 extern int max_name_width, max_data_width;
 
 int __init rdtgroup_init(void);
+void __exit rdtgroup_exit(void);
 
 /**
  * struct rftype - describe each file in the resctrl file system
@@ -416,8 +417,6 @@ extern struct rdt_resource rdt_resources_all[];
 extern struct rdtgroup rdtgroup_default;
 DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
 
-int __init rdtgroup_init(void);
-
 enum {
 	RDT_RESOURCE_L3,
 	RDT_RESOURCE_L3DATA,
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 00467f9edb27..00b125e5562f 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -2739,3 +2739,10 @@ int __init rdtgroup_init(void)
 
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

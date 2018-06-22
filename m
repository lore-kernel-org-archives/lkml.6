Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC34C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81EF524996
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:43:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81EF524996
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934187AbeFVWnD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 18:43:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:22311 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933953AbeFVWmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 18:42:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2018 15:42:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,259,1526367600"; 
   d="scan'208";a="234843448"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga005.jf.intel.com with ESMTP; 22 Jun 2018 15:42:48 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V7 33/41] x86/intel_rdt: Ensure RDT cleanup on exit
Date:   Fri, 22 Jun 2018 15:42:24 -0700
Message-Id: <a9e3a2bbd731d13915d2d7bf05d4f675b4fa109b.1529706536.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1529706536.git.reinette.chatre@intel.com>
References: <cover.1529706536.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1529706536.git.reinette.chatre@intel.com>
References: <cover.1529706536.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RDT system's initialization does not have the corresponding exit
handling to ensure everything initialized on load is cleaned up also.

Introduce the cleanup routines that complement all initialization. This
includes the removal of a duplicate rdtgroup_init() declaration.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/72dee9c18ed095942783868eb1e299f13fefa3ff.1527593971.git.reinette.chatre@intel.com
---
 arch/x86/kernel/cpu/intel_rdt.c          | 11 +++++++++++
 arch/x86/kernel/cpu/intel_rdt.h          |  3 +--
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c |  7 +++++++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.c b/arch/x86/kernel/cpu/intel_rdt.c
index ec4754f81cbd..abb71ac70443 100644
--- a/arch/x86/kernel/cpu/intel_rdt.c
+++ b/arch/x86/kernel/cpu/intel_rdt.c
@@ -859,6 +859,8 @@ static __init bool get_rdt_resources(void)
 	return (rdt_mon_capable || rdt_alloc_capable);
 }
 
+static enum cpuhp_state rdt_online;
+
 static int __init intel_rdt_late_init(void)
 {
 	struct rdt_resource *r;
@@ -880,6 +882,7 @@ static int __init intel_rdt_late_init(void)
 		cpuhp_remove_state(state);
 		return ret;
 	}
+	rdt_online = state;
 
 	for_each_alloc_capable_rdt_resource(r)
 		pr_info("Intel RDT %s allocation detected\n", r->name);
@@ -891,3 +894,11 @@ static int __init intel_rdt_late_init(void)
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
index cecf26e63e2c..75fe5f2719be 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -2837,3 +2837,10 @@ int __init rdtgroup_init(void)
 
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
2.17.0


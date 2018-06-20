Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7719EC1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A4CE20693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:30:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A4CE20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754271AbeFTAaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 20:30:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51095 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752809AbeFTAaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 20:30:17 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5K0UD7o3300224
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 19 Jun 2018 17:30:13 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5K0UDeG3300221;
        Tue, 19 Jun 2018 17:30:13 -0700
Date:   Tue, 19 Jun 2018 17:30:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-8b7a62905e930d7fb3f81362f41003ba03c78afb@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        hpa@zytor.com, reinette.chatre@intel.com
Reply-To: reinette.chatre@intel.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          mingo@kernel.org
In-Reply-To: <72dee9c18ed095942783868eb1e299f13fefa3ff.1527593971.git.reinette.chatre@intel.com>
References: <72dee9c18ed095942783868eb1e299f13fefa3ff.1527593971.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Ensure RDT cleanup on exit
Git-Commit-ID: 8b7a62905e930d7fb3f81362f41003ba03c78afb
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  8b7a62905e930d7fb3f81362f41003ba03c78afb
Gitweb:     https://git.kernel.org/tip/8b7a62905e930d7fb3f81362f41003ba03c78afb
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Tue, 29 May 2018 05:57:57 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 20 Jun 2018 00:56:38 +0200

x86/intel_rdt: Ensure RDT cleanup on exit

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
index 4e4b64338f9f..89ac02f91238 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -2820,3 +2820,10 @@ cleanup_root:
 
 	return ret;
 }
+
+void __exit rdtgroup_exit(void)
+{
+	unregister_filesystem(&rdt_fs_type);
+	sysfs_remove_mount_point(fs_kobj, "resctrl");
+	kernfs_destroy_root(rdt_root);
+}

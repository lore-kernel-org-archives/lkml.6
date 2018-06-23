Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423D4C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B2124BE0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04B2124BE0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752066AbeFWMYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 08:24:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45287 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751818AbeFWMYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 08:24:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5NCOIBs467085
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 23 Jun 2018 05:24:18 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5NCOIuc467082;
        Sat, 23 Jun 2018 05:24:18 -0700
Date:   Sat, 23 Jun 2018 05:24:18 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-0af6a48da481109affc4ea8295034f69993a91ef@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, reinette.chatre@intel.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          reinette.chatre@intel.com, hpa@zytor.com, mingo@kernel.org
In-Reply-To: <a9e3a2bbd731d13915d2d7bf05d4f675b4fa109b.1529706536.git.reinette.chatre@intel.com>
References: <a9e3a2bbd731d13915d2d7bf05d4f675b4fa109b.1529706536.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Ensure RDT cleanup on exit
Git-Commit-ID: 0af6a48da481109affc4ea8295034f69993a91ef
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

Commit-ID:  0af6a48da481109affc4ea8295034f69993a91ef
Gitweb:     https://git.kernel.org/tip/0af6a48da481109affc4ea8295034f69993a91ef
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Fri, 22 Jun 2018 15:42:24 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 23 Jun 2018 13:03:50 +0200

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
Link: https://lkml.kernel.org/r/a9e3a2bbd731d13915d2d7bf05d4f675b4fa109b.1529706536.git.reinette.chatre@intel.com

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
index f245aaae514e..2b3f7619be48 100644
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
index f301919ae9b2..960066249374 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -2828,3 +2828,10 @@ cleanup_root:
 
 	return ret;
 }
+
+void __exit rdtgroup_exit(void)
+{
+	unregister_filesystem(&rdt_fs_type);
+	sysfs_remove_mount_point(fs_kobj, "resctrl");
+	kernfs_destroy_root(rdt_root);
+}

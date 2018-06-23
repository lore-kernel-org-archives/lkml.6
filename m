Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9AEC43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51C7B2173F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51C7B2173F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752203AbeFWMTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 08:19:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58565 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751865AbeFWMTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 08:19:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5NCJU0X464894
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 23 Jun 2018 05:19:30 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5NCJTai464889;
        Sat, 23 Jun 2018 05:19:29 -0700
Date:   Sat, 23 Jun 2018 05:19:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-e8140a2d13d429364f18ca41b1e4960708c3a40e@git.kernel.org>
Cc:     mingo@kernel.org, reinette.chatre@intel.com, hpa@zytor.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, mingo@kernel.org, reinette.chatre@intel.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <9f69eb159051067703bcbc714de62e69874d5dee.1529706536.git.reinette.chatre@intel.com>
References: <9f69eb159051067703bcbc714de62e69874d5dee.1529706536.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Introduce pseudo-locked region
Git-Commit-ID: e8140a2d13d429364f18ca41b1e4960708c3a40e
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

Commit-ID:  e8140a2d13d429364f18ca41b1e4960708c3a40e
Gitweb:     https://git.kernel.org/tip/e8140a2d13d429364f18ca41b1e4960708c3a40e
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Fri, 22 Jun 2018 15:42:15 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 23 Jun 2018 13:03:47 +0200

x86/intel_rdt: Introduce pseudo-locked region

A pseudo-locked region is introduced representing an instance of a
pseudo-locked cache region. Each cache instance (domain) can support one
pseudo-locked region. Similarly a resource group can be used for one
pseudo-locked region.

Include a pointer to a pseudo-locked region from the domain and resource
group structures.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/9f69eb159051067703bcbc714de62e69874d5dee.1529706536.git.reinette.chatre@intel.com

---
 arch/x86/kernel/cpu/intel_rdt.h | 64 ++++++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 8d56776a3bd2..f3dcbcd03dfa 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -122,6 +122,20 @@ struct mongroup {
 	u32			rmid;
 };
 
+/**
+ * struct pseudo_lock_region - pseudo-lock region information
+ * @r:			RDT resource to which this pseudo-locked region
+ *			belongs
+ * @d:			RDT domain to which this pseudo-locked region
+ *			belongs
+ * @cbm:		bitmask of the pseudo-locked region
+ */
+struct pseudo_lock_region {
+	struct rdt_resource	*r;
+	struct rdt_domain	*d;
+	u32			cbm;
+};
+
 /**
  * struct rdtgroup - store rdtgroup's data in resctrl file system.
  * @kn:				kernfs node
@@ -135,17 +149,19 @@ struct mongroup {
  *				monitor only or ctrl_mon group
  * @mon:			mongroup related data
  * @mode:			mode of resource group
+ * @plr:			pseudo-locked region
  */
 struct rdtgroup {
-	struct kernfs_node	*kn;
-	struct list_head	rdtgroup_list;
-	u32			closid;
-	struct cpumask		cpu_mask;
-	int			flags;
-	atomic_t		waitcount;
-	enum rdt_group_type	type;
-	struct mongroup		mon;
-	enum rdtgrp_mode	mode;
+	struct kernfs_node		*kn;
+	struct list_head		rdtgroup_list;
+	u32				closid;
+	struct cpumask			cpu_mask;
+	int				flags;
+	atomic_t			waitcount;
+	enum rdt_group_type		type;
+	struct mongroup			mon;
+	enum rdtgrp_mode		mode;
+	struct pseudo_lock_region	*plr;
 };
 
 /* rdtgroup.flags */
@@ -246,22 +262,24 @@ struct mbm_state {
  * @mbps_val:	When mba_sc is enabled, this holds the bandwidth in MBps
  * @new_ctrl:	new ctrl value to be loaded
  * @have_new_ctrl: did user provide new_ctrl for this domain
+ * @plr:	pseudo-locked region (if any) associated with domain
  */
 struct rdt_domain {
-	struct list_head	list;
-	int			id;
-	struct cpumask		cpu_mask;
-	unsigned long		*rmid_busy_llc;
-	struct mbm_state	*mbm_total;
-	struct mbm_state	*mbm_local;
-	struct delayed_work	mbm_over;
-	struct delayed_work	cqm_limbo;
-	int			mbm_work_cpu;
-	int			cqm_work_cpu;
-	u32			*ctrl_val;
-	u32			*mbps_val;
-	u32			new_ctrl;
-	bool			have_new_ctrl;
+	struct list_head		list;
+	int				id;
+	struct cpumask			cpu_mask;
+	unsigned long			*rmid_busy_llc;
+	struct mbm_state		*mbm_total;
+	struct mbm_state		*mbm_local;
+	struct delayed_work		mbm_over;
+	struct delayed_work		cqm_limbo;
+	int				mbm_work_cpu;
+	int				cqm_work_cpu;
+	u32				*ctrl_val;
+	u32				*mbps_val;
+	u32				new_ctrl;
+	bool				have_new_ctrl;
+	struct pseudo_lock_region	*plr;
 };
 
 /**

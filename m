Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E08EC1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4242083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:25:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B4242083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754198AbeFTAZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 20:25:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37947 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752915AbeFTAZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 20:25:05 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5K0P0wO3299351
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 19 Jun 2018 17:25:01 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5K0P0KG3299348;
        Tue, 19 Jun 2018 17:25:00 -0700
Date:   Tue, 19 Jun 2018 17:25:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-165371cf12415680ee4833bae63d08b2a4475ea4@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, reinette.chatre@intel.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org,
          reinette.chatre@intel.com, mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <9bdcbce670d1ca6067d6a0f2d1c27297901bc56a.1527593971.git.reinette.chatre@intel.com>
References: <9bdcbce670d1ca6067d6a0f2d1c27297901bc56a.1527593971.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Introduce pseudo-locked region
Git-Commit-ID: 165371cf12415680ee4833bae63d08b2a4475ea4
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

Commit-ID:  165371cf12415680ee4833bae63d08b2a4475ea4
Gitweb:     https://git.kernel.org/tip/165371cf12415680ee4833bae63d08b2a4475ea4
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Tue, 29 May 2018 05:57:48 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 20 Jun 2018 00:56:35 +0200

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
Link: https://lkml.kernel.org/r/9bdcbce670d1ca6067d6a0f2d1c27297901bc56a.1527593971.git.reinette.chatre@intel.com

---
 arch/x86/kernel/cpu/intel_rdt.h | 64 ++++++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index c9b8d3d1d413..02ae088fd745 100644
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

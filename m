Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D990C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C28324981
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:46:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C28324981
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754930AbeFVWqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 18:46:39 -0400
Received: from mga02.intel.com ([134.134.136.20]:22310 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754675AbeFVWmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 18:42:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2018 15:42:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,259,1526367600"; 
   d="scan'208";a="234843421"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga005.jf.intel.com with ESMTP; 22 Jun 2018 15:42:47 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V7 24/41] x86/intel_rdt: Introduce pseudo-locked region
Date:   Fri, 22 Jun 2018 15:42:15 -0700
Message-Id: <9f69eb159051067703bcbc714de62e69874d5dee.1529706536.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1529706536.git.reinette.chatre@intel.com>
References: <cover.1529706536.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1529706536.git.reinette.chatre@intel.com>
References: <cover.1529706536.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 arch/x86/kernel/cpu/intel_rdt.h | 64 +++++++++++++++++++++------------
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
-- 
2.17.0


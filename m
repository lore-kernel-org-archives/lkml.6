Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932338AbeDYSNS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 14:13:18 -0400
Received: from mga02.intel.com ([134.134.136.20]:41720 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932214AbeDYSMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 14:12:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,327,1520924400";
   d="scan'208";a="35243720"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V3 23/39] x86/intel_rdt: Introduce pseudo-locked region
Date: Wed, 25 Apr 2018 03:09:59 -0700
Message-Id: <e918500df8a98dccf51a418d9b72b226d23b6fb6.1524649902.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
References: <cover.1524649902.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
References: <cover.1524649902.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A pseudo-locked region is introduced representing an instance of a
pseudo-locked cache region. Each cache instance (domain) can support
one pseudo-locked region. Similarly a resource group can be used for
one pseudo-locked region.

Include a pointer to a pseudo-locked region from the domain and resource
group structures.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt.h | 62 ++++++++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 24399f2407d7..75dede416fdb 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -122,6 +122,20 @@ struct mongroup {
 };
 
 /**
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
+/**
  * struct rdtgroup - store rdtgroup's data in resctrl file system.
  * @kn:				kernfs node
  * @rdtgroup_list:		linked list for all rdtgroups
@@ -134,17 +148,19 @@ struct mongroup {
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
@@ -234,21 +250,23 @@ struct mbm_state {
  * @ctrl_val:	array of cache or mem ctrl values (indexed by CLOSID)
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
+	u32				new_ctrl;
+	bool				have_new_ctrl;
+	struct pseudo_lock_region	*plr;
 };
 
 /**
-- 
2.13.6

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967253AbeE2VCu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 17:02:50 -0400
Received: from mga01.intel.com ([192.55.52.88]:53962 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966790AbeE2VBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 17:01:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,457,1520924400";
   d="scan'208";a="60127736"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V5 23/38] x86/intel_rdt: Introduce pseudo-locked region
Date: Tue, 29 May 2018 05:57:48 -0700
Message-Id: <9bdcbce670d1ca6067d6a0f2d1c27297901bc56a.1527593971.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1527593970.git.reinette.chatre@intel.com>
References: <cover.1527593970.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1527593970.git.reinette.chatre@intel.com>
References: <cover.1527593970.git.reinette.chatre@intel.com>
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
 arch/x86/kernel/cpu/intel_rdt.h | 64 ++++++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index c9b8d3d1d413..02ae088fd745 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -123,6 +123,20 @@ struct mongroup {
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
2.13.6

Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344BEC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B611421762
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B611421762
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727293AbeHXOUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 10:20:03 -0400
Received: from foss.arm.com ([217.140.101.70]:55434 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbeHXOUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 10:20:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA6341650;
        Fri, 24 Aug 2018 03:45:58 -0700 (PDT)
Received: from melchizedek.Emea.Arm.com (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2AFFF3F5A0;
        Fri, 24 Aug 2018 03:45:57 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Vikas Shivappa <vikas.shivappa@linux.intel.com>
Subject: [RFC PATCH 01/20] x86/intel_rdt: Split struct rdt_resource
Date:   Fri, 24 Aug 2018 11:45:00 +0100
Message-Id: <20180824104519.11203-2-james.morse@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180824104519.11203-1-james.morse@arm.com>
References: <20180824104519.11203-1-james.morse@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resctrl is the defacto Linux ABI for SoC resource partitioning features.
To support it on another architecture, we need to abstract it from
Intel RDT, and move it to /fs/.

Lets start by splitting struct rdt_resource, (the name is kept for now
to keep the noise down), and add some type-trickery to keep the foreach
helpers working.

Move everything that that is particular to resctrl into a new header
file, keeping the x86 msr specific stuff where it is. resctrl code
paths touching a 'hw' struct indicates where an abstraction is needed.

We split rdt_domain up in a similar way in the next patch.
No change in behaviour, this patch just moves types around.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/intel_rdt.c             | 193 +++++++++++---------
 arch/x86/kernel/cpu/intel_rdt.h             | 112 +++---------
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c |   6 +-
 arch/x86/kernel/cpu/intel_rdt_monitor.c     |  23 ++-
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c    |  37 ++--
 include/linux/resctrl.h                     | 103 +++++++++++
 6 files changed, 275 insertions(+), 199 deletions(-)
 create mode 100644 include/linux/resctrl.h

diff --git a/arch/x86/kernel/cpu/intel_rdt.c b/arch/x86/kernel/cpu/intel_rdt.c
index ec4754f81cbd..8cb2639b8a56 100644
--- a/arch/x86/kernel/cpu/intel_rdt.c
+++ b/arch/x86/kernel/cpu/intel_rdt.c
@@ -64,122 +64,137 @@ mba_wrmsr(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r);
 static void
 cat_wrmsr(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r);
 
-#define domain_init(id) LIST_HEAD_INIT(rdt_resources_all[id].domains)
+#define domain_init(id) LIST_HEAD_INIT(rdt_resources_all[id].resctrl.domains)
 
-struct rdt_resource rdt_resources_all[] = {
+struct rdt_hw_resource rdt_resources_all[] = {
 	[RDT_RESOURCE_L3] =
 	{
 		.rid			= RDT_RESOURCE_L3,
-		.name			= "L3",
-		.domains		= domain_init(RDT_RESOURCE_L3),
+		.resctrl = {
+			.name			= "L3",
+			.cache_level		= 3,
+			.cache = {
+				.min_cbm_bits	= 1,
+				.cbm_idx_mult	= 1,
+				.cbm_idx_offset	= 0,
+			},
+			.domains		= domain_init(RDT_RESOURCE_L3),
+			.parse_ctrlval		= parse_cbm,
+			.format_str		= "%d=%0*x",
+			.fflags			= RFTYPE_RES_CACHE,
+		},
 		.msr_base		= IA32_L3_CBM_BASE,
 		.msr_update		= cat_wrmsr,
-		.cache_level		= 3,
-		.cache = {
-			.min_cbm_bits	= 1,
-			.cbm_idx_mult	= 1,
-			.cbm_idx_offset	= 0,
-		},
-		.parse_ctrlval		= parse_cbm,
-		.format_str		= "%d=%0*x",
-		.fflags			= RFTYPE_RES_CACHE,
 	},
 	[RDT_RESOURCE_L3DATA] =
 	{
 		.rid			= RDT_RESOURCE_L3DATA,
-		.name			= "L3DATA",
-		.domains		= domain_init(RDT_RESOURCE_L3DATA),
+		.resctrl = {
+			.name			= "L3DATA",
+			.cache_level		= 3,
+			.cache = {
+				.min_cbm_bits	= 1,
+				.cbm_idx_mult	= 2,
+				.cbm_idx_offset	= 0,
+			},
+			.domains		= domain_init(RDT_RESOURCE_L3DATA),
+			.parse_ctrlval		= parse_cbm,
+			.format_str		= "%d=%0*x",
+			.fflags			= RFTYPE_RES_CACHE,
+		},
 		.msr_base		= IA32_L3_CBM_BASE,
 		.msr_update		= cat_wrmsr,
-		.cache_level		= 3,
-		.cache = {
-			.min_cbm_bits	= 1,
-			.cbm_idx_mult	= 2,
-			.cbm_idx_offset	= 0,
-		},
-		.parse_ctrlval		= parse_cbm,
-		.format_str		= "%d=%0*x",
-		.fflags			= RFTYPE_RES_CACHE,
+
 	},
 	[RDT_RESOURCE_L3CODE] =
 	{
 		.rid			= RDT_RESOURCE_L3CODE,
-		.name			= "L3CODE",
-		.domains		= domain_init(RDT_RESOURCE_L3CODE),
+		.resctrl = {
+			.name			= "L3CODE",
+			.cache_level		= 3,
+			.cache = {
+				.min_cbm_bits	= 1,
+				.cbm_idx_mult	= 2,
+				.cbm_idx_offset	= 1,
+			},
+			.domains		= domain_init(RDT_RESOURCE_L3CODE),
+			.parse_ctrlval		= parse_cbm,
+			.format_str		= "%d=%0*x",
+			.fflags			= RFTYPE_RES_CACHE,
+		},
 		.msr_base		= IA32_L3_CBM_BASE,
 		.msr_update		= cat_wrmsr,
-		.cache_level		= 3,
-		.cache = {
-			.min_cbm_bits	= 1,
-			.cbm_idx_mult	= 2,
-			.cbm_idx_offset	= 1,
-		},
-		.parse_ctrlval		= parse_cbm,
-		.format_str		= "%d=%0*x",
-		.fflags			= RFTYPE_RES_CACHE,
 	},
 	[RDT_RESOURCE_L2] =
 	{
 		.rid			= RDT_RESOURCE_L2,
-		.name			= "L2",
-		.domains		= domain_init(RDT_RESOURCE_L2),
+		.resctrl = {
+			.name			= "L2",
+			.cache_level		= 2,
+			.cache = {
+				.min_cbm_bits	= 1,
+				.cbm_idx_mult	= 1,
+				.cbm_idx_offset	= 0,
+			},
+			.domains		= domain_init(RDT_RESOURCE_L2),
+			.parse_ctrlval		= parse_cbm,
+			.format_str		= "%d=%0*x",
+			.fflags			= RFTYPE_RES_CACHE,
+		},
 		.msr_base		= IA32_L2_CBM_BASE,
 		.msr_update		= cat_wrmsr,
-		.cache_level		= 2,
-		.cache = {
-			.min_cbm_bits	= 1,
-			.cbm_idx_mult	= 1,
-			.cbm_idx_offset	= 0,
-		},
-		.parse_ctrlval		= parse_cbm,
-		.format_str		= "%d=%0*x",
-		.fflags			= RFTYPE_RES_CACHE,
 	},
 	[RDT_RESOURCE_L2DATA] =
 	{
 		.rid			= RDT_RESOURCE_L2DATA,
-		.name			= "L2DATA",
-		.domains		= domain_init(RDT_RESOURCE_L2DATA),
+		.resctrl = {
+			.name			= "L2DATA",
+			.cache_level		= 2,
+			.cache = {
+				.min_cbm_bits	= 1,
+				.cbm_idx_mult	= 2,
+				.cbm_idx_offset	= 0,
+			},
+			.domains		= domain_init(RDT_RESOURCE_L2DATA),
+			.parse_ctrlval		= parse_cbm,
+			.format_str		= "%d=%0*x",
+			.fflags			= RFTYPE_RES_CACHE,
+		},
 		.msr_base		= IA32_L2_CBM_BASE,
 		.msr_update		= cat_wrmsr,
-		.cache_level		= 2,
-		.cache = {
-			.min_cbm_bits	= 1,
-			.cbm_idx_mult	= 2,
-			.cbm_idx_offset	= 0,
-		},
-		.parse_ctrlval		= parse_cbm,
-		.format_str		= "%d=%0*x",
-		.fflags			= RFTYPE_RES_CACHE,
 	},
 	[RDT_RESOURCE_L2CODE] =
 	{
 		.rid			= RDT_RESOURCE_L2CODE,
-		.name			= "L2CODE",
-		.domains		= domain_init(RDT_RESOURCE_L2CODE),
+		.resctrl = {
+			.name			= "L2CODE",
+			.cache_level		= 2,
+			.cache = {
+				.min_cbm_bits	= 1,
+				.cbm_idx_mult	= 2,
+				.cbm_idx_offset	= 1,
+			},
+			.domains		= domain_init(RDT_RESOURCE_L2CODE),
+			.parse_ctrlval		= parse_cbm,
+			.format_str		= "%d=%0*x",
+			.fflags			= RFTYPE_RES_CACHE,
+		},
 		.msr_base		= IA32_L2_CBM_BASE,
 		.msr_update		= cat_wrmsr,
-		.cache_level		= 2,
-		.cache = {
-			.min_cbm_bits	= 1,
-			.cbm_idx_mult	= 2,
-			.cbm_idx_offset	= 1,
-		},
-		.parse_ctrlval		= parse_cbm,
-		.format_str		= "%d=%0*x",
-		.fflags			= RFTYPE_RES_CACHE,
 	},
 	[RDT_RESOURCE_MBA] =
 	{
 		.rid			= RDT_RESOURCE_MBA,
-		.name			= "MB",
-		.domains		= domain_init(RDT_RESOURCE_MBA),
+		.resctrl = {
+			.name			= "MB",
+			.cache_level		= 3,
+			.domains		= domain_init(RDT_RESOURCE_MBA),
+			.parse_ctrlval		= parse_bw,
+			.format_str		= "%d=%*u",
+			.fflags			= RFTYPE_RES_MB,
+		},
 		.msr_base		= IA32_MBA_THRTL_BASE,
 		.msr_update		= mba_wrmsr,
-		.cache_level		= 3,
-		.parse_ctrlval		= parse_bw,
-		.format_str		= "%d=%*u",
-		.fflags			= RFTYPE_RES_MB,
 	},
 };
 
@@ -208,7 +223,7 @@ static unsigned int cbm_idx(struct rdt_resource *r, unsigned int closid)
  */
 static inline void cache_alloc_hsw_probe(void)
 {
-	struct rdt_resource *r  = &rdt_resources_all[RDT_RESOURCE_L3];
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].resctrl;
 	u32 l, h, max_cbm = BIT_MASK(20) - 1;
 
 	if (wrmsr_safe(IA32_L3_CBM_BASE, max_cbm, 0))
@@ -233,7 +248,7 @@ static inline void cache_alloc_hsw_probe(void)
 bool is_mba_sc(struct rdt_resource *r)
 {
 	if (!r)
-		return rdt_resources_all[RDT_RESOURCE_MBA].membw.mba_sc;
+		return rdt_resources_all[RDT_RESOURCE_MBA].resctrl.membw.mba_sc;
 
 	return r->membw.mba_sc;
 }
@@ -303,8 +318,8 @@ static void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
 
 static void rdt_get_cdp_config(int level, int type)
 {
-	struct rdt_resource *r_l = &rdt_resources_all[level];
-	struct rdt_resource *r = &rdt_resources_all[type];
+	struct rdt_resource *r_l = &rdt_resources_all[level].resctrl;
+	struct rdt_resource *r = &rdt_resources_all[type].resctrl;
 
 	r->num_closid = r_l->num_closid / 2;
 	r->cache.cbm_len = r_l->cache.cbm_len;
@@ -362,19 +377,21 @@ static void
 mba_wrmsr(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
 {
 	unsigned int i;
+	struct rdt_hw_resource *hw_res = resctrl_to_rdt(r);
 
 	/*  Write the delay values for mba. */
 	for (i = m->low; i < m->high; i++)
-		wrmsrl(r->msr_base + i, delay_bw_map(d->ctrl_val[i], r));
+		wrmsrl(hw_res->msr_base + i, delay_bw_map(d->ctrl_val[i], r));
 }
 
 static void
 cat_wrmsr(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
 {
 	unsigned int i;
+	struct rdt_hw_resource *hw_res = resctrl_to_rdt(r);
 
 	for (i = m->low; i < m->high; i++)
-		wrmsrl(r->msr_base + cbm_idx(r, i), d->ctrl_val[i]);
+		wrmsrl(hw_res->msr_base + cbm_idx(r, i), d->ctrl_val[i]);
 }
 
 struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r)
@@ -394,12 +411,13 @@ void rdt_ctrl_update(void *arg)
 {
 	struct msr_param *m = arg;
 	struct rdt_resource *r = m->res;
+	struct rdt_hw_resource *hw_res = resctrl_to_rdt(r);
 	int cpu = smp_processor_id();
 	struct rdt_domain *d;
 
 	d = get_domain_from_cpu(cpu, r);
 	if (d) {
-		r->msr_update(d, m, r);
+		hw_res->msr_update(d, m, r);
 		return;
 	}
 	pr_warn_once("cpu %d not found in any domain for resource %s\n",
@@ -457,6 +475,7 @@ void setup_default_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm)
 
 static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
 {
+	struct rdt_hw_resource *hw_res = resctrl_to_rdt(r);
 	struct msr_param m;
 	u32 *dc, *dm;
 
@@ -476,7 +495,7 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
 
 	m.low = 0;
 	m.high = r->num_closid;
-	r->msr_update(d, &m, r);
+	hw_res->msr_update(d, &m, r);
 	return 0;
 }
 
@@ -619,7 +638,7 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 		return;
 	}
 
-	if (r == &rdt_resources_all[RDT_RESOURCE_L3]) {
+	if (r == &rdt_resources_all[RDT_RESOURCE_L3].resctrl) {
 		if (is_mbm_enabled() && cpu == d->mbm_work_cpu) {
 			cancel_delayed_work(&d->mbm_over);
 			mbm_setup_overflow_handler(d, 0);
@@ -800,21 +819,21 @@ static __init bool get_rdt_alloc_resources(void)
 		return false;
 
 	if (rdt_cpu_has(X86_FEATURE_CAT_L3)) {
-		rdt_get_cache_alloc_cfg(1, &rdt_resources_all[RDT_RESOURCE_L3]);
+		rdt_get_cache_alloc_cfg(1, &rdt_resources_all[RDT_RESOURCE_L3].resctrl);
 		if (rdt_cpu_has(X86_FEATURE_CDP_L3))
 			rdt_get_cdp_l3_config();
 		ret = true;
 	}
 	if (rdt_cpu_has(X86_FEATURE_CAT_L2)) {
 		/* CPUID 0x10.2 fields are same format at 0x10.1 */
-		rdt_get_cache_alloc_cfg(2, &rdt_resources_all[RDT_RESOURCE_L2]);
+		rdt_get_cache_alloc_cfg(2, &rdt_resources_all[RDT_RESOURCE_L2].resctrl);
 		if (rdt_cpu_has(X86_FEATURE_CDP_L2))
 			rdt_get_cdp_l2_config();
 		ret = true;
 	}
 
 	if (rdt_cpu_has(X86_FEATURE_MBA)) {
-		if (rdt_get_mem_config(&rdt_resources_all[RDT_RESOURCE_MBA]))
+		if (rdt_get_mem_config(&rdt_resources_all[RDT_RESOURCE_MBA].resctrl))
 			ret = true;
 	}
 	return ret;
@@ -832,7 +851,7 @@ static __init bool get_rdt_mon_resources(void)
 	if (!rdt_mon_features)
 		return false;
 
-	return !rdt_get_mon_l3_config(&rdt_resources_all[RDT_RESOURCE_L3]);
+	return !rdt_get_mon_l3_config(&rdt_resources_all[RDT_RESOURCE_L3].resctrl);
 }
 
 static __init void rdt_quirks(void)
diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 39752825e376..20a6674ac67c 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_X86_INTEL_RDT_H
 #define _ASM_X86_INTEL_RDT_H
 
+#include <linux/resctrl.h>
 #include <linux/sched.h>
 #include <linux/kernfs.h>
 #include <linux/jump_label.h>
@@ -246,44 +247,6 @@ struct msr_param {
 	int			high;
 };
 
-/**
- * struct rdt_cache - Cache allocation related data
- * @cbm_len:		Length of the cache bit mask
- * @min_cbm_bits:	Minimum number of consecutive bits to be set
- * @cbm_idx_mult:	Multiplier of CBM index
- * @cbm_idx_offset:	Offset of CBM index. CBM index is computed by:
- *			closid * cbm_idx_multi + cbm_idx_offset
- *			in a cache bit mask
- * @shareable_bits:	Bitmask of shareable resource with other
- *			executing entities
- */
-struct rdt_cache {
-	unsigned int	cbm_len;
-	unsigned int	min_cbm_bits;
-	unsigned int	cbm_idx_mult;
-	unsigned int	cbm_idx_offset;
-	unsigned int	shareable_bits;
-};
-
-/**
- * struct rdt_membw - Memory bandwidth allocation related data
- * @max_delay:		Max throttle delay. Delay is the hardware
- *			representation for memory bandwidth.
- * @min_bw:		Minimum memory bandwidth percentage user can request
- * @bw_gran:		Granularity at which the memory bandwidth is allocated
- * @delay_linear:	True if memory B/W delay is in linear scale
- * @mba_sc:		True if MBA software controller(mba_sc) is enabled
- * @mb_map:		Mapping of memory B/W percentage to memory B/W delay
- */
-struct rdt_membw {
-	u32		max_delay;
-	u32		min_bw;
-	u32		bw_gran;
-	u32		delay_linear;
-	bool		mba_sc;
-	u32		*mb_map;
-};
-
 static inline bool is_llc_occupancy_enabled(void)
 {
 	return (rdt_mon_features & (1 << QOS_L3_OCCUP_EVENT_ID));
@@ -312,59 +275,33 @@ static inline bool is_mbm_event(int e)
 
 /**
  * struct rdt_resource - attributes of an RDT resource
+ * @resctrl:		Properties exposed to the resctrl filesystem
  * @rid:		The index of the resource
- * @alloc_enabled:	Is allocation enabled on this machine
- * @mon_enabled:		Is monitoring enabled for this feature
- * @alloc_capable:	Is allocation available on this machine
- * @mon_capable:		Is monitor feature available on this machine
- * @name:		Name to use in "schemata" file
- * @num_closid:		Number of CLOSIDs available
- * @cache_level:	Which cache level defines scope of this resource
- * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
  * @msr_base:		Base MSR address for CBMs
  * @msr_update:		Function pointer to update QOS MSRs
- * @data_width:		Character width of data when displaying
- * @domains:		All domains for this resource
- * @cache:		Cache allocation related data
- * @format_str:		Per resource format string to show domain value
- * @parse_ctrlval:	Per resource function pointer to parse control values
- * @evt_list:			List of monitoring events
- * @num_rmid:			Number of RMIDs available
  * @mon_scale:			cqm counter * mon_scale = occupancy in bytes
  * @fflags:			flags to choose base and info files
  */
-struct rdt_resource {
+struct rdt_hw_resource {
+	struct rdt_resource	resctrl;
 	int			rid;
-	bool			alloc_enabled;
-	bool			mon_enabled;
-	bool			alloc_capable;
-	bool			mon_capable;
-	char			*name;
-	int			num_closid;
-	int			cache_level;
-	u32			default_ctrl;
 	unsigned int		msr_base;
 	void (*msr_update)	(struct rdt_domain *d, struct msr_param *m,
 				 struct rdt_resource *r);
-	int			data_width;
-	struct list_head	domains;
-	struct rdt_cache	cache;
-	struct rdt_membw	membw;
-	const char		*format_str;
-	int (*parse_ctrlval)	(char *buf, struct rdt_resource *r,
-				 struct rdt_domain *d);
-	struct list_head	evt_list;
-	int			num_rmid;
 	unsigned int		mon_scale;
-	unsigned long		fflags;
 };
 
+static inline struct rdt_hw_resource *resctrl_to_rdt(struct rdt_resource *r)
+{
+	return container_of(r, struct rdt_hw_resource, resctrl);
+}
+
 int parse_cbm(char *buf, struct rdt_resource *r, struct rdt_domain *d);
 int parse_bw(char *buf, struct rdt_resource *r,  struct rdt_domain *d);
 
 extern struct mutex rdtgroup_mutex;
 
-extern struct rdt_resource rdt_resources_all[];
+extern struct rdt_hw_resource rdt_resources_all[];
 extern struct rdtgroup rdtgroup_default;
 DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
 
@@ -383,29 +320,38 @@ enum {
 	RDT_NUM_RESOURCES,
 };
 
+static inline struct rdt_resource *resctrl_inc(struct rdt_resource *res)
+{
+	struct rdt_hw_resource *hw_res = resctrl_to_rdt(res);
+
+	hw_res++;
+	return &hw_res->resctrl;
+}
+
+
 #define for_each_capable_rdt_resource(r)				      \
-	for (r = rdt_resources_all; r < rdt_resources_all + RDT_NUM_RESOURCES;\
-	     r++)							      \
+	for (r = &rdt_resources_all[0].resctrl; r < &rdt_resources_all[RDT_NUM_RESOURCES].resctrl;\
+	     r = resctrl_inc(r))							\
 		if (r->alloc_capable || r->mon_capable)
 
 #define for_each_alloc_capable_rdt_resource(r)				      \
-	for (r = rdt_resources_all; r < rdt_resources_all + RDT_NUM_RESOURCES;\
-	     r++)							      \
+	for (r = &rdt_resources_all[0].resctrl; r < &rdt_resources_all[RDT_NUM_RESOURCES].resctrl;\
+	     r = resctrl_inc(r))							\
 		if (r->alloc_capable)
 
 #define for_each_mon_capable_rdt_resource(r)				      \
-	for (r = rdt_resources_all; r < rdt_resources_all + RDT_NUM_RESOURCES;\
-	     r++)							      \
+	for (r = &rdt_resources_all[0].resctrl; r < &rdt_resources_all[RDT_NUM_RESOURCES].resctrl;\
+	     r = resctrl_inc(r))							\
 		if (r->mon_capable)
 
 #define for_each_alloc_enabled_rdt_resource(r)				      \
-	for (r = rdt_resources_all; r < rdt_resources_all + RDT_NUM_RESOURCES;\
-	     r++)							      \
+	for (r = &rdt_resources_all[0].resctrl; r < &rdt_resources_all[RDT_NUM_RESOURCES].resctrl;\
+	     r = resctrl_inc(r))							\
 		if (r->alloc_enabled)
 
 #define for_each_mon_enabled_rdt_resource(r)				      \
-	for (r = rdt_resources_all; r < rdt_resources_all + RDT_NUM_RESOURCES;\
-	     r++)							      \
+	for (r = &rdt_resources_all[0].resctrl; r < &rdt_resources_all[RDT_NUM_RESOURCES].resctrl;\
+	     r = resctrl_inc(r))						\
 		if (r->mon_enabled)
 
 /* CPUID.(EAX=10H, ECX=ResID=1).EAX */
diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
index 116d57b248d3..58890612ca8d 100644
--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
@@ -348,6 +348,7 @@ void mon_event_read(struct rmid_read *rr, struct rdt_domain *d,
 int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 {
 	struct kernfs_open_file *of = m->private;
+	struct rdt_hw_resource *hw_res;
 	u32 resid, evtid, domid;
 	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
@@ -363,7 +364,8 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	domid = md.u.domid;
 	evtid = md.u.evtid;
 
-	r = &rdt_resources_all[resid];
+	hw_res = &rdt_resources_all[resid];
+	r = &hw_res->resctrl;
 	d = rdt_find_domain(r, domid, NULL);
 	if (!d) {
 		ret = -ENOENT;
@@ -377,7 +379,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	else if (rr.val & RMID_VAL_UNAVAIL)
 		seq_puts(m, "Unavailable\n");
 	else
-		seq_printf(m, "%llu\n", rr.val * r->mon_scale);
+		seq_printf(m, "%llu\n", rr.val * hw_res->mon_scale);
 
 out:
 	rdtgroup_kn_unlock(of->kn);
diff --git a/arch/x86/kernel/cpu/intel_rdt_monitor.c b/arch/x86/kernel/cpu/intel_rdt_monitor.c
index b0f3aed76b75..493d264a0dbe 100644
--- a/arch/x86/kernel/cpu/intel_rdt_monitor.c
+++ b/arch/x86/kernel/cpu/intel_rdt_monitor.c
@@ -122,7 +122,7 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
 	struct rdt_resource *r;
 	u32 crmid = 1, nrmid;
 
-	r = &rdt_resources_all[RDT_RESOURCE_L3];
+	r = &rdt_resources_all[RDT_RESOURCE_L3].resctrl;
 
 	/*
 	 * Skip RMID 0 and start from RMID 1 and check all the RMIDs that
@@ -180,7 +180,7 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 	int cpu;
 	u64 val;
 
-	r = &rdt_resources_all[RDT_RESOURCE_L3];
+	r = &rdt_resources_all[RDT_RESOURCE_L3].resctrl;
 
 	entry->busy = 0;
 	cpu = get_cpu();
@@ -281,7 +281,7 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
  */
 static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
 {
-	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3];
+	struct rdt_hw_resource *r = &rdt_resources_all[RDT_RESOURCE_L3];
 	struct mbm_state *m = &rr->d->mbm_local[rmid];
 	u64 tval, cur_bw, chunks;
 
@@ -365,13 +365,15 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 {
 	u32 closid, rmid, cur_msr, cur_msr_val, new_msr_val;
 	struct mbm_state *pmbm_data, *cmbm_data;
+	struct rdt_hw_resource *hw_r_mba;
 	u32 cur_bw, delta_bw, user_bw;
 	struct rdt_resource *r_mba;
 	struct rdt_domain *dom_mba;
 	struct list_head *head;
 	struct rdtgroup *entry;
 
-	r_mba = &rdt_resources_all[RDT_RESOURCE_MBA];
+	hw_r_mba = &rdt_resources_all[RDT_RESOURCE_MBA];
+	r_mba = &hw_r_mba->resctrl;
 	closid = rgrp->closid;
 	rmid = rgrp->mon.rmid;
 	pmbm_data = &dom_mbm->mbm_local[rmid];
@@ -420,7 +422,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 		return;
 	}
 
-	cur_msr = r_mba->msr_base + closid;
+	cur_msr = hw_r_mba->msr_base + closid;
 	wrmsrl(cur_msr, delay_bw_map(new_msr_val, r_mba));
 	dom_mba->ctrl_val[closid] = new_msr_val;
 
@@ -484,7 +486,7 @@ void cqm_handle_limbo(struct work_struct *work)
 
 	mutex_lock(&rdtgroup_mutex);
 
-	r = &rdt_resources_all[RDT_RESOURCE_L3];
+	r = &rdt_resources_all[RDT_RESOURCE_L3].resctrl;
 	d = get_domain_from_cpu(cpu, r);
 
 	if (!d) {
@@ -507,7 +509,7 @@ void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms)
 	struct rdt_resource *r;
 	int cpu;
 
-	r = &rdt_resources_all[RDT_RESOURCE_L3];
+	r = &rdt_resources_all[RDT_RESOURCE_L3].resctrl;
 
 	cpu = cpumask_any(&dom->cpu_mask);
 	dom->cqm_work_cpu = cpu;
@@ -528,7 +530,7 @@ void mbm_handle_overflow(struct work_struct *work)
 	if (!static_branch_likely(&rdt_enable_key))
 		goto out_unlock;
 
-	d = get_domain_from_cpu(cpu, &rdt_resources_all[RDT_RESOURCE_L3]);
+	d = get_domain_from_cpu(cpu, &rdt_resources_all[RDT_RESOURCE_L3].resctrl);
 	if (!d)
 		goto out_unlock;
 
@@ -626,8 +628,9 @@ static void l3_mon_evt_init(struct rdt_resource *r)
 int rdt_get_mon_l3_config(struct rdt_resource *r)
 {
 	int ret;
+	struct rdt_hw_resource *hw_res = resctrl_to_rdt(r);
 
-	r->mon_scale = boot_cpu_data.x86_cache_occ_scale;
+	hw_res->mon_scale = boot_cpu_data.x86_cache_occ_scale;
 	r->num_rmid = boot_cpu_data.x86_cache_max_rmid + 1;
 
 	/*
@@ -640,7 +643,7 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
 	intel_cqm_threshold = boot_cpu_data.x86_cache_size * 1024 / r->num_rmid;
 
 	/* h/w works in units of "boot_cpu_data.x86_cache_occ_scale" */
-	intel_cqm_threshold /= r->mon_scale;
+	intel_cqm_threshold /= hw_res->mon_scale;
 
 	ret = dom_data_init(r);
 	if (ret)
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 749856a2e736..3afe642e3ede 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -715,8 +715,9 @@ static int max_threshold_occ_show(struct kernfs_open_file *of,
 				  struct seq_file *seq, void *v)
 {
 	struct rdt_resource *r = of->kn->parent->priv;
+	struct rdt_hw_resource *hw_res = resctrl_to_rdt(r);
 
-	seq_printf(seq, "%u\n", intel_cqm_threshold * r->mon_scale);
+	seq_printf(seq, "%u\n", intel_cqm_threshold * hw_res->mon_scale);
 
 	return 0;
 }
@@ -725,6 +726,7 @@ static ssize_t max_threshold_occ_write(struct kernfs_open_file *of,
 				       char *buf, size_t nbytes, loff_t off)
 {
 	struct rdt_resource *r = of->kn->parent->priv;
+	struct rdt_hw_resource *hw_res = resctrl_to_rdt(r);
 	unsigned int bytes;
 	int ret;
 
@@ -735,7 +737,7 @@ static ssize_t max_threshold_occ_write(struct kernfs_open_file *of,
 	if (bytes > (boot_cpu_data.x86_cache_size * 1024))
 		return -EINVAL;
 
-	intel_cqm_threshold = bytes / r->mon_scale;
+	intel_cqm_threshold = bytes / hw_res->mon_scale;
 
 	return nbytes;
 }
@@ -1007,7 +1009,7 @@ static void l2_qos_cfg_update(void *arg)
 
 static inline bool is_mba_linear(void)
 {
-	return rdt_resources_all[RDT_RESOURCE_MBA].membw.delay_linear;
+	return rdt_resources_all[RDT_RESOURCE_MBA].resctrl.membw.delay_linear;
 }
 
 static int set_cache_qos_cfg(int level, bool enable)
@@ -1028,7 +1030,7 @@ static int set_cache_qos_cfg(int level, bool enable)
 	else
 		return -EINVAL;
 
-	r_l = &rdt_resources_all[level];
+	r_l = &rdt_resources_all[level].resctrl;
 	list_for_each_entry(d, &r_l->domains, list) {
 		/* Pick one CPU from each domain instance to update MSR */
 		cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
@@ -1054,7 +1056,7 @@ static int set_cache_qos_cfg(int level, bool enable)
  */
 static int set_mba_sc(bool mba_sc)
 {
-	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA];
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].resctrl;
 	struct rdt_domain *d;
 
 	if (!is_mbm_enabled() || !is_mba_linear() ||
@@ -1070,9 +1072,9 @@ static int set_mba_sc(bool mba_sc)
 
 static int cdp_enable(int level, int data_type, int code_type)
 {
-	struct rdt_resource *r_ldata = &rdt_resources_all[data_type];
-	struct rdt_resource *r_lcode = &rdt_resources_all[code_type];
-	struct rdt_resource *r_l = &rdt_resources_all[level];
+	struct rdt_resource *r_ldata = &rdt_resources_all[data_type].resctrl;
+	struct rdt_resource *r_lcode = &rdt_resources_all[code_type].resctrl;
+	struct rdt_resource *r_l = &rdt_resources_all[level].resctrl;
 	int ret;
 
 	if (!r_l->alloc_capable || !r_ldata->alloc_capable ||
@@ -1102,13 +1104,13 @@ static int cdpl2_enable(void)
 
 static void cdp_disable(int level, int data_type, int code_type)
 {
-	struct rdt_resource *r = &rdt_resources_all[level];
+	struct rdt_resource *r = &rdt_resources_all[level].resctrl;
 
 	r->alloc_enabled = r->alloc_capable;
 
-	if (rdt_resources_all[data_type].alloc_enabled) {
-		rdt_resources_all[data_type].alloc_enabled = false;
-		rdt_resources_all[code_type].alloc_enabled = false;
+	if (rdt_resources_all[data_type].resctrl.alloc_enabled) {
+		rdt_resources_all[data_type].resctrl.alloc_enabled = false;
+		rdt_resources_all[code_type].resctrl.alloc_enabled = false;
 		set_cache_qos_cfg(level, false);
 	}
 }
@@ -1125,9 +1127,9 @@ static void cdpl2_disable(void)
 
 static void cdp_disable_all(void)
 {
-	if (rdt_resources_all[RDT_RESOURCE_L3DATA].alloc_enabled)
+	if (rdt_resources_all[RDT_RESOURCE_L3DATA].resctrl.alloc_enabled)
 		cdpl3_disable();
-	if (rdt_resources_all[RDT_RESOURCE_L2DATA].alloc_enabled)
+	if (rdt_resources_all[RDT_RESOURCE_L2DATA].resctrl.alloc_enabled)
 		cdpl2_disable();
 }
 
@@ -1303,7 +1305,7 @@ static struct dentry *rdt_mount(struct file_system_type *fs_type,
 		static_branch_enable_cpuslocked(&rdt_enable_key);
 
 	if (is_mbm_enabled()) {
-		r = &rdt_resources_all[RDT_RESOURCE_L3];
+		r = &rdt_resources_all[RDT_RESOURCE_L3].resctrl;
 		list_for_each_entry(dom, &r->domains, list)
 			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL);
 	}
@@ -1542,6 +1544,7 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
 				struct rdt_domain *d,
 				struct rdt_resource *r, struct rdtgroup *prgrp)
 {
+	struct rdt_hw_resource *hw_res = resctrl_to_rdt(r);
 	union mon_data_bits priv;
 	struct kernfs_node *kn;
 	struct mon_evt *mevt;
@@ -1569,7 +1572,7 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
 		goto out_destroy;
 	}
 
-	priv.u.rid = r->rid;
+	priv.u.rid = hw_res->rid;
 	priv.u.domid = d->id;
 	list_for_each_entry(mevt, &r->evt_list, list) {
 		priv.u.evtid = mevt->evtid;
@@ -2030,7 +2033,7 @@ static int rdtgroup_rmdir(struct kernfs_node *kn)
 
 static int rdtgroup_show_options(struct seq_file *seq, struct kernfs_root *kf)
 {
-	if (rdt_resources_all[RDT_RESOURCE_L3DATA].alloc_enabled)
+	if (rdt_resources_all[RDT_RESOURCE_L3DATA].resctrl.alloc_enabled)
 		seq_puts(seq, ",cdp");
 	return 0;
 }
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
new file mode 100644
index 000000000000..8d32b2c6d72b
--- /dev/null
+++ b/include/linux/resctrl.h
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0
+// Based on arch/x86/kernel/cpu/intel_rdt.h
+
+#ifndef __LINUX_RESCTRL_H
+#define __LINUX_RESCTRL_H
+
+#include <linux/list.h>
+#include <linux/kernel.h>
+
+struct rdt_domain;
+
+/**
+ * struct resctrl_cache - Cache allocation related data
+ * @cbm_len:		Length of the cache bit mask
+ * @min_cbm_bits:	Minimum number of consecutive bits to be set
+ * @cbm_idx_mult:	Multiplier of CBM index
+ * @cbm_idx_offset:	Offset of CBM index. CBM index is computed by:
+ *			closid * cbm_idx_multi + cbm_idx_offset
+ *			in a cache bit mask
+ * @shareable_bits:	Bitmask of shareable resource with other
+ *			executing entities
+ */
+struct resctrl_cache {
+	u32		cbm_len;
+	u32		min_cbm_bits;
+	unsigned int	cbm_idx_mult;	// TODO remove this
+	unsigned int	cbm_idx_offset; // TODO remove this
+	u32		shareable_bits;
+};
+
+/**
+ * struct resctrl_membw - Memory bandwidth allocation related data
+ * @max_delay:		Max throttle delay. Delay is the hardware
+ *			representation for memory bandwidth.
+ * @min_bw:		Minimum memory bandwidth percentage user can request
+ * @bw_gran:		Granularity at which the memory bandwidth is allocated
+ * @delay_linear:	True if memory B/W delay is in linear scale
+ * @mba_sc:		True if MBA software controller(mba_sc) is enabled
+ * @mb_map:		Mapping of memory B/W percentage to memory B/W delay
+ */
+struct resctrl_membw {
+	u32		max_delay;
+	u32		min_bw;
+	u32		bw_gran;
+	u32		delay_linear;
+	bool		mba_sc;
+	u32		*mb_map;
+};
+
+/**
+ * @alloc_enabled:	Is allocation enabled on this machine
+ * @mon_enabled:	Is monitoring enabled for this feature
+ * @alloc_capable:	Is allocation available on this machine
+ * @mon_capable:	Is monitor feature available on this machine
+ *
+ * @cache_level:	Which cache level defines scope of this resource.
+ *
+ * @cache:		If the component has cache controls, their properties.
+ * @membw:		If the component has bandwidth controls, their properties.
+ *
+ * @num_closid:		Number of CLOSIDs available.
+ * @num_rmid:		Number of RMIDs available.
+ *
+ * @domains:		All domains for this resource
+ *
+ * @name:		Name to use in "schemata" file.
+ * @data_width:		Character width of data when displaying.
+ * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
+ * @format_str:		Per resource format string to show domain value
+ * @parse_ctrlval:	Per resource function pointer to parse control values
+ *
+ * @evt_list:		List of monitoring events
+ * @fflags:		flags to choose base and info files
+ */
+struct rdt_resource {
+	bool				alloc_enabled;
+	bool				mon_enabled;
+	bool				alloc_capable;
+	bool				mon_capable;
+
+	int				cache_level;
+
+	struct resctrl_cache		cache;
+	struct resctrl_membw		membw;
+
+	int				num_closid;
+	int				num_rmid;
+
+	struct list_head		domains;
+
+	char				*name;
+	int				data_width;
+	u32				default_ctrl;
+	const char			*format_str;
+	int (*parse_ctrlval)		(char *buf, struct rdt_resource *r,
+					 struct rdt_domain *d);
+
+	struct list_head		evt_list;
+	unsigned long			fflags;
+
+};
+
+#endif /* __LINUX_RESCTRL_H */
-- 
2.18.0


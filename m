Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BB9C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E7692157C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:46:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E7692157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbeHXOUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 10:20:42 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55646 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727997AbeHXOUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 10:20:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A24BC1688;
        Fri, 24 Aug 2018 03:46:37 -0700 (PDT)
Received: from melchizedek.Emea.Arm.com (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 05F5C3F5A0;
        Fri, 24 Aug 2018 03:46:35 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Vikas Shivappa <vikas.shivappa@linux.intel.com>
Subject: [RFC PATCH 17/20] x86/intel_rdt: Stop using Lx CODE/DATA resources
Date:   Fri, 24 Aug 2018 11:45:16 +0100
Message-Id: <20180824104519.11203-18-james.morse@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180824104519.11203-1-james.morse@arm.com>
References: <20180824104519.11203-1-james.morse@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that CDP enable/disable is global, and the closid offset correction
is based on the configuration being applied, we can use the same
Lx resource twice for CDP's CODE/DATA schema. This keeps the illusion
of separate caches in the resctrl code.

When CDP is enabled for a cache, create two schema generating the names
and setting the configuration type.

We can now remove the initialisation of of the illusionary hw_resources:
'cdp_capable' just requires setting a flag, resctrl knows what to do
from there.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/intel_rdt.c          | 49 ++----------
 arch/x86/kernel/cpu/intel_rdt.h          |  1 -
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 98 +++++++++++++-----------
 3 files changed, 58 insertions(+), 90 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.c b/arch/x86/kernel/cpu/intel_rdt.c
index 3a0d7de15afa..96b1aab36053 100644
--- a/arch/x86/kernel/cpu/intel_rdt.c
+++ b/arch/x86/kernel/cpu/intel_rdt.c
@@ -81,7 +81,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.format_str		= "%d=%0*x",
 			.fflags			= RFTYPE_RES_CACHE,
 		},
-		.cdp_type		= CDP_BOTH,
 		.msr_base		= IA32_L3_CBM_BASE,
 		.msr_update		= cat_wrmsr,
 	},
@@ -99,7 +98,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.format_str		= "%d=%0*x",
 			.fflags			= RFTYPE_RES_CACHE,
 		},
-		.cdp_type		= CDP_DATA,
 		.msr_base		= IA32_L3_CBM_BASE,
 		.msr_update		= cat_wrmsr,
 
@@ -118,7 +116,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.format_str		= "%d=%0*x",
 			.fflags			= RFTYPE_RES_CACHE,
 		},
-		.cdp_type		= CDP_CODE,
 		.msr_base		= IA32_L3_CBM_BASE,
 		.msr_update		= cat_wrmsr,
 	},
@@ -136,7 +133,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.format_str		= "%d=%0*x",
 			.fflags			= RFTYPE_RES_CACHE,
 		},
-		.cdp_type		= CDP_BOTH,
 		.msr_base		= IA32_L2_CBM_BASE,
 		.msr_update		= cat_wrmsr,
 	},
@@ -154,7 +150,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.format_str		= "%d=%0*x",
 			.fflags			= RFTYPE_RES_CACHE,
 		},
-		.cdp_type		= CDP_DATA,
 		.msr_base		= IA32_L2_CBM_BASE,
 		.msr_update		= cat_wrmsr,
 	},
@@ -172,7 +167,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.format_str		= "%d=%0*x",
 			.fflags			= RFTYPE_RES_CACHE,
 		},
-		.cdp_type		= CDP_CODE,
 		.msr_base		= IA32_L2_CBM_BASE,
 		.msr_update		= cat_wrmsr,
 	},
@@ -312,39 +306,6 @@ static void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
 	r->alloc_enabled = true;
 }
 
-static void rdt_get_cdp_config(int level, int type)
-{
-	struct rdt_resource *r_l = &rdt_resources_all[level].resctrl;
-	struct rdt_hw_resource *hw_res_t = &rdt_resources_all[type];
-	struct rdt_resource *r = &hw_res_t->resctrl;
-
-	r->num_closid = r_l->num_closid / 2;
-	hw_res_t->hw_num_closid = r_l->num_closid;
-	r->cache.cbm_len = r_l->cache.cbm_len;
-	r->default_ctrl = r_l->default_ctrl;
-	r->cache.shareable_bits = r_l->cache.shareable_bits;
-	r->data_width = (r->cache.cbm_len + 3) / 4;
-	r->alloc_capable = true;
-	/*
-	 * By default, CDP is disabled. CDP can be enabled by mount parameter
-	 * "cdp" during resctrl file system mount time.
-	 */
-	r_l->cdp_capable = true;
-	r->alloc_enabled = false;
-}
-
-static void rdt_get_cdp_l3_config(void)
-{
-	rdt_get_cdp_config(RDT_RESOURCE_L3, RDT_RESOURCE_L3DATA);
-	rdt_get_cdp_config(RDT_RESOURCE_L3, RDT_RESOURCE_L3CODE);
-}
-
-static void rdt_get_cdp_l2_config(void)
-{
-	rdt_get_cdp_config(RDT_RESOURCE_L2, RDT_RESOURCE_L2DATA);
-	rdt_get_cdp_config(RDT_RESOURCE_L2, RDT_RESOURCE_L2CODE);
-}
-
 static int get_cache_id(int cpu, int level)
 {
 	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(cpu);
@@ -813,6 +774,8 @@ static bool __init rdt_cpu_has(int flag)
 static __init bool get_rdt_alloc_resources(void)
 {
 	bool ret = false;
+	struct rdt_hw_resource *l2 = &rdt_resources_all[RDT_RESOURCE_L2];
+	struct rdt_hw_resource *l3 = &rdt_resources_all[RDT_RESOURCE_L3];
 
 	if (rdt_alloc_capable)
 		return true;
@@ -821,16 +784,16 @@ static __init bool get_rdt_alloc_resources(void)
 		return false;
 
 	if (rdt_cpu_has(X86_FEATURE_CAT_L3)) {
-		rdt_get_cache_alloc_cfg(1, &rdt_resources_all[RDT_RESOURCE_L3].resctrl);
+		rdt_get_cache_alloc_cfg(1, &l3->resctrl);
 		if (rdt_cpu_has(X86_FEATURE_CDP_L3))
-			rdt_get_cdp_l3_config();
+			l3->resctrl.cdp_capable = true;
 		ret = true;
 	}
 	if (rdt_cpu_has(X86_FEATURE_CAT_L2)) {
 		/* CPUID 0x10.2 fields are same format at 0x10.1 */
-		rdt_get_cache_alloc_cfg(2, &rdt_resources_all[RDT_RESOURCE_L2].resctrl);
+		rdt_get_cache_alloc_cfg(2, &l2->resctrl);
 		if (rdt_cpu_has(X86_FEATURE_CDP_L2))
-			rdt_get_cdp_l2_config();
+			l2->resctrl.cdp_capable = true;
 		ret = true;
 	}
 
diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index b72448186532..fd5c0b3dc797 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -285,7 +285,6 @@ struct rdt_hw_resource {
 	struct rdt_resource	resctrl;
 	int			rid;
 	u32			hw_num_closid;
-	enum resctrl_conf_type  cdp_type; // temporary
 	unsigned int		msr_base;
 	void (*msr_update)	(struct rdt_domain *d, struct msr_param *m,
 				 struct rdt_resource *r);
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index b3d3acbb2ef7..39038bdfa7d6 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -1078,47 +1078,28 @@ static int set_mba_sc(bool mba_sc)
 	return 0;
 }
 
-static int cdp_enable(int level, int data_type, int code_type)
+static int cdp_enable(int level)
 {
-	struct rdt_resource *r_ldata = &rdt_resources_all[data_type].resctrl;
-	struct rdt_resource *r_lcode = &rdt_resources_all[code_type].resctrl;
 	struct rdt_resource *r_l = &rdt_resources_all[level].resctrl;
 	int ret;
 
-	if (!r_l->alloc_capable || !r_ldata->alloc_capable ||
-	    !r_lcode->alloc_capable || !r_l->cdp_capable)
+	if (!r_l->alloc_capable || !r_l->cdp_capable)
 		return -EINVAL;
 
 	ret = set_cache_qos_cfg(level, true);
-	if (!ret) {
-		r_l->alloc_enabled = false;
-		r_ldata->alloc_enabled = true;
-		r_lcode->alloc_enabled = true;
-
+	if (!ret)
 		r_l->cdp_enabled = true;
-		r_ldata->cdp_enabled = true;
-		r_lcode->cdp_enabled = true;
-	}
+
 	return ret;
 }
 
-static void cdp_disable(int level, int data_type, int code_type)
+static void cdp_disable(int level)
 {
 	struct rdt_resource *r = &rdt_resources_all[level].resctrl;
 
-	if (!r->cdp_enabled)
-		return;
-
-	r->alloc_enabled = r->alloc_capable;
-
-	if (rdt_resources_all[data_type].resctrl.alloc_enabled) {
-		rdt_resources_all[data_type].resctrl.alloc_enabled = false;
-		rdt_resources_all[code_type].resctrl.alloc_enabled = false;
+	if (r->cdp_enabled) {
 		set_cache_qos_cfg(level, false);
-
 		r->cdp_enabled = false;
-		rdt_resources_all[data_type].resctrl.cdp_enabled = false;
-		rdt_resources_all[code_type].resctrl.cdp_enabled = false;
 	}
 }
 
@@ -1130,22 +1111,18 @@ int resctrl_arch_set_cdp_enabled(bool enable)
 
 	if (l3 && l3->resctrl.cdp_capable) {
 		if (!enable) {
-			cdp_disable(RDT_RESOURCE_L3, RDT_RESOURCE_L3DATA,
-				    RDT_RESOURCE_L3CODE);
+			cdp_disable(RDT_RESOURCE_L3);
 			ret = 0;
 		} else {
-			ret = cdp_enable(RDT_RESOURCE_L3, RDT_RESOURCE_L3DATA,
-				    RDT_RESOURCE_L3CODE);
+			ret = cdp_enable(RDT_RESOURCE_L3);
 		}
 	}
 	if (l2 && l2->resctrl.cdp_capable) {
 		if (!enable) {
-			cdp_disable(RDT_RESOURCE_L2, RDT_RESOURCE_L2DATA,
-				    RDT_RESOURCE_L2CODE);
+			cdp_disable(RDT_RESOURCE_L2);
 			ret = 0;
 		} else {
-			ret = cdp_enable(RDT_RESOURCE_L2, RDT_RESOURCE_L2DATA,
-				    RDT_RESOURCE_L2CODE);
+			ret = cdp_enable(RDT_RESOURCE_L2);
 		}
 	}
 
@@ -1293,28 +1270,57 @@ static int mkdir_mondata_all(struct kernfs_node *parent_kn,
 			     struct kernfs_node **mon_data_kn);
 
 
-static int create_schemata_list(void)
+static int add_schema(enum resctrl_conf_type t, struct rdt_resource *r)
 {
-	struct rdt_resource *r;
+	char *suffix = "";
 	struct resctrl_schema *s;
 
-	for_each_alloc_enabled_rdt_resource(r) {
-		s = kzalloc(sizeof(*s), GFP_KERNEL);
-		if (!s)
-			return -ENOMEM;
+	s = kzalloc(sizeof(*s), GFP_KERNEL);
+	if (!s)
+		return -ENOMEM;
 
-		s->res = r;
-		s->conf_type = resctrl_to_rdt(r)->cdp_type;
+	s->res = r;
+	s->conf_type = t;
+
+	switch (t) {
+	case CDP_CODE:
+		suffix = "CODE";
+		break;
+	case CDP_DATA:
+		suffix = "DATA";
+		break;
+	case CDP_BOTH:
+		suffix = "";
+		break;
+	}
 
-		snprintf(s->name, sizeof(s->name), "%s", r->name);
+	snprintf(s->name, sizeof(s->name), "%s%s", r->name, suffix);
 
-		INIT_LIST_HEAD(&s->list);
-		list_add(&s->list, &resctrl_all_schema);
-	}
+	INIT_LIST_HEAD(&s->list);
+	list_add(&s->list, &resctrl_all_schema);
 
 	return 0;
 }
 
+static int create_schemata_list(void)
+{
+	int ret = 0;
+	struct rdt_resource *r;
+
+	for_each_alloc_enabled_rdt_resource(r) {
+		if (r->cdp_enabled) {
+			ret = add_schema(CDP_CODE, r);
+			ret |= add_schema(CDP_DATA, r);
+		} else {
+			ret = add_schema(CDP_BOTH, r);
+		}
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
 static void destroy_schemata_list(void)
 {
 	struct resctrl_schema *s, *tmp;
@@ -2133,7 +2139,7 @@ static int rdtgroup_rmdir(struct kernfs_node *kn)
 
 static int rdtgroup_show_options(struct seq_file *seq, struct kernfs_root *kf)
 {
-	if (rdt_resources_all[RDT_RESOURCE_L3DATA].resctrl.alloc_enabled)
+	if (rdt_resources_all[RDT_RESOURCE_L3].resctrl.cdp_enabled)
 		seq_puts(seq, ",cdp");
 	return 0;
 }
-- 
2.18.0


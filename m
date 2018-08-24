Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8970C43615
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D4572157C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D4572157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbeHXOU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 10:20:29 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55586 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbeHXOU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 10:20:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E62D81682;
        Fri, 24 Aug 2018 03:46:24 -0700 (PDT)
Received: from melchizedek.Emea.Arm.com (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4A3633F5A0;
        Fri, 24 Aug 2018 03:46:23 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Vikas Shivappa <vikas.shivappa@linux.intel.com>
Subject: [RFC PATCH 12/20] x86/intel_rdt: Correct the closid when staging configuration changes
Date:   Fri, 24 Aug 2018 11:45:11 +0100
Message-Id: <20180824104519.11203-13-james.morse@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180824104519.11203-1-james.morse@arm.com>
References: <20180824104519.11203-1-james.morse@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that apply_config() and update_domains() know the code/data/both value
of what they are writing, and ctrl_val is correctly sized: use the
hardware closid slot, based on the configuration type.

This means cbm_idx() and its illusionary cache-properties can go.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/intel_rdt.c             | 18 +-----------
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c | 32 ++++++++++++++-------
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c    |  2 +-
 include/linux/resctrl.h                     |  6 ++--
 4 files changed, 25 insertions(+), 33 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.c b/arch/x86/kernel/cpu/intel_rdt.c
index 8d3544b6c149..6466c172c045 100644
--- a/arch/x86/kernel/cpu/intel_rdt.c
+++ b/arch/x86/kernel/cpu/intel_rdt.c
@@ -75,8 +75,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.cache_level		= 3,
 			.cache = {
 				.min_cbm_bits	= 1,
-				.cbm_idx_mult	= 1,
-				.cbm_idx_offset	= 0,
 			},
 			.domains		= domain_init(RDT_RESOURCE_L3),
 			.parse_ctrlval		= parse_cbm,
@@ -95,8 +93,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.cache_level		= 3,
 			.cache = {
 				.min_cbm_bits	= 1,
-				.cbm_idx_mult	= 2,
-				.cbm_idx_offset	= 0,
 			},
 			.domains		= domain_init(RDT_RESOURCE_L3DATA),
 			.parse_ctrlval		= parse_cbm,
@@ -116,8 +112,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.cache_level		= 3,
 			.cache = {
 				.min_cbm_bits	= 1,
-				.cbm_idx_mult	= 2,
-				.cbm_idx_offset	= 1,
 			},
 			.domains		= domain_init(RDT_RESOURCE_L3CODE),
 			.parse_ctrlval		= parse_cbm,
@@ -136,8 +130,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.cache_level		= 2,
 			.cache = {
 				.min_cbm_bits	= 1,
-				.cbm_idx_mult	= 1,
-				.cbm_idx_offset	= 0,
 			},
 			.domains		= domain_init(RDT_RESOURCE_L2),
 			.parse_ctrlval		= parse_cbm,
@@ -156,8 +148,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.cache_level		= 2,
 			.cache = {
 				.min_cbm_bits	= 1,
-				.cbm_idx_mult	= 2,
-				.cbm_idx_offset	= 0,
 			},
 			.domains		= domain_init(RDT_RESOURCE_L2DATA),
 			.parse_ctrlval		= parse_cbm,
@@ -176,8 +166,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.cache_level		= 2,
 			.cache = {
 				.min_cbm_bits	= 1,
-				.cbm_idx_mult	= 2,
-				.cbm_idx_offset	= 1,
 			},
 			.domains		= domain_init(RDT_RESOURCE_L2CODE),
 			.parse_ctrlval		= parse_cbm,
@@ -204,10 +192,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 	},
 };
 
-static unsigned int cbm_idx(struct rdt_resource *r, unsigned int closid)
-{
-	return closid * r->cache.cbm_idx_mult + r->cache.cbm_idx_offset;
-}
 
 /*
  * cache_alloc_hsw_probe() - Have to probe for Intel haswell server CPUs
@@ -408,7 +392,7 @@ cat_wrmsr(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
 	struct rdt_hw_resource *hw_res = resctrl_to_rdt(r);
 
 	for (i = m->low; i < m->high; i++)
-		wrmsrl(hw_res->msr_base + cbm_idx(r, i), hw_dom->ctrl_val[i]);
+		wrmsrl(hw_res->msr_base + i, hw_dom->ctrl_val[i]);
 }
 
 struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r)
diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
index bab6032704c3..05c14d9f797c 100644
--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
@@ -28,6 +28,16 @@
 #include <linux/slab.h>
 #include "intel_rdt.h"
 
+static u32 resctrl_closid_cdp_map(u32 closid, enum resctrl_conf_type t)
+{
+	if (t == CDP_CODE)
+		return (closid * 2) + 1;
+	else if (t == CDP_DATA)
+		return (closid * 2);
+	else
+		return closid;
+}
+
 /*
  * Check whether MBA bandwidth percentage value is correct. The value is
  * checked against the minimum and max bandwidth values specified by the
@@ -77,7 +87,7 @@ int parse_bw(char *buf, struct rdt_resource *r, struct rdt_domain *d,
 
 	if (!bw_validate(buf, &data, r))
 		return -EINVAL;
-	cfg->closid = closid;
+	cfg->hw_closid = resctrl_closid_cdp_map(closid, t);
 	cfg->new_ctrl = data;
 	cfg->new_ctrl_type = t;
 	cfg->have_new_ctrl = true;
@@ -143,7 +153,7 @@ int parse_cbm(char *buf, struct rdt_resource *r, struct rdt_domain *d,
 
 	if(!cbm_validate(buf, &data, r))
 		return -EINVAL;
-	cfg->closid = closid;
+	cfg->hw_closid = resctrl_closid_cdp_map(closid, t);
 	cfg->new_ctrl = data;
 	cfg->new_ctrl_type = t;
 	cfg->have_new_ctrl = true;
@@ -190,10 +200,10 @@ static void apply_config(struct rdt_hw_domain *hw_dom,
 {
 	u32 *dc = !mba_sc ? hw_dom->ctrl_val : hw_dom->mbps_val;
 
-	if (cfg->new_ctrl != dc[cfg->closid]) {
+	if (cfg->new_ctrl != dc[cfg->hw_closid]) {
 		cpumask_set_cpu(cpumask_any(&hw_dom->resctrl.cpu_mask),
 				cpu_mask);
-		dc[cfg->closid] = cfg->new_ctrl;
+		dc[cfg->hw_closid] = cfg->new_ctrl;
 		cfg->have_new_ctrl = false;
 	}
 }
@@ -222,10 +232,9 @@ int resctrl_arch_update_domains(struct rdt_resource *r)
 			cfg = &hw_dom->resctrl.staged_config[i];
 			if (!cfg->have_new_ctrl)
 				continue;
-
 			apply_config(hw_dom, cfg, cpu_mask, mba_sc);
 
-			closid = cfg->closid;
+			closid = cfg->hw_closid;
 			if (!msr_param_init) {
 				msr_param.low = closid;
 				msr_param.high = closid;
@@ -328,14 +337,14 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 }
 
 void resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
-				    u32 closid, u32 *value)
+				    u32 hw_closid, u32 *value)
 {
 	struct rdt_hw_domain *hw_dom = rc_dom_to_rdt(d);
 
 	if (!is_mba_sc(r))
-		*value = hw_dom->ctrl_val[closid];
+		*value = hw_dom->ctrl_val[hw_closid];
 	else
-		*value = hw_dom->mbps_val[closid];
+		*value = hw_dom->mbps_val[hw_closid];
 }
 
 static void show_doms(struct seq_file *s, struct rdt_resource *r, int closid)
@@ -343,14 +352,15 @@ static void show_doms(struct seq_file *s, struct rdt_resource *r, int closid)
 
 	struct rdt_domain *dom;
 	bool sep = false;
-	u32 ctrl_val;
+	u32 ctrl_val, hw_closid;
 
 	seq_printf(s, "%*s:", max_name_width, r->name);
 	list_for_each_entry(dom, &r->domains, list) {
 		if (sep)
 			seq_puts(s, ";");
 
-		resctrl_arch_get_config(r, dom, closid, &ctrl_val);
+		hw_closid = resctrl_closid_cdp_map(closid, resctrl_to_rdt(r)->cdp_type);
+		resctrl_arch_get_config(r, dom, hw_closid, &ctrl_val);
 		seq_printf(s, r->format_str, dom->id, max_data_width,
 			   ctrl_val);
 		sep = true;
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index e2a9202674f3..f3dfed9c609a 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -1394,7 +1394,7 @@ static int reset_all_ctrls(struct rdt_resource *r)
 
 	msr_param.res = r;
 	msr_param.low = 0;
-	msr_param.high = r->num_closid;
+	msr_param.high = hw_res->hw_num_closid;
 
 	/*
 	 * Disable resource control for this resource by setting all
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 592242635204..dad266f9b0fe 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -15,13 +15,13 @@ enum resctrl_conf_type {
 
 /**
  * struct resctrl_staged_config - parsed configuration to be applied
- * @closid:		The closid the new configuration applies to
+ * @hw_closid:		raw closid for this configuration, regardless of CDP
  * @new_ctrl:		new ctrl value to be loaded
  * @have_new_ctrl:	did user provide new_ctrl for this domain
  * @new_ctrl_type:	CDP property of the new ctrl
  */
 struct resctrl_staged_config {
-	u32			closid;
+	u32			hw_closid;
 	u32			new_ctrl;
 	bool			have_new_ctrl;
 	enum resctrl_conf_type  new_ctrl_type;
@@ -56,8 +56,6 @@ struct rdt_domain {
 struct resctrl_cache {
 	u32		cbm_len;
 	u32		min_cbm_bits;
-	unsigned int	cbm_idx_mult;	// TODO remove this
-	unsigned int	cbm_idx_offset; // TODO remove this
 	u32		shareable_bits;
 };
 
-- 
2.18.0


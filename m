Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3455BC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0682168B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:46:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB0682168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbeHXOUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 10:20:23 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55544 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbeHXOUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 10:20:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E54819BF;
        Fri, 24 Aug 2018 03:46:17 -0700 (PDT)
Received: from melchizedek.Emea.Arm.com (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E67A03F5A0;
        Fri, 24 Aug 2018 03:46:15 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Vikas Shivappa <vikas.shivappa@linux.intel.com>
Subject: [RFC PATCH 09/20] x86/intel_rdt: Track the actual number of closids separately
Date:   Fri, 24 Aug 2018 11:45:08 +0100
Message-Id: <20180824104519.11203-10-james.morse@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180824104519.11203-1-james.morse@arm.com>
References: <20180824104519.11203-1-james.morse@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

num_closid is different for the illusionary CODE/DATA caches, and
these resource's ctrlval is sized on this parameter. When it comes
to writing the configuration values into hardware, a correction is
applied.

The next step in moving this behaviour into the resctrl code is
to make the arch code always work with the full range of closids, and
size its ctrlval arrays based on this number.

This means another architecture doesn't need to emulate CDP.

Add a separate field to hold hw_num_closids and use this in the
arch code. The CODE/DATA caches use the full range for their hardware
struct, but the half sized version for the resctrl visible part.
This means the ctrlval array is the full size, but only the first
half is used.

A later patch will correct the closid when the configuration is
written, at which point we can merge the illusionary caches.

A short lived quirk of this is when a resource is reset(), both
the code and data illusionary caches reset the full closid range.
This disappears in a later patch that merges the caches together.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/intel_rdt.c          | 19 ++++++++++++++-----
 arch/x86/kernel/cpu/intel_rdt.h          |  2 ++
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c |  3 ++-
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.c b/arch/x86/kernel/cpu/intel_rdt.c
index 0e651447956e..c035280b4398 100644
--- a/arch/x86/kernel/cpu/intel_rdt.c
+++ b/arch/x86/kernel/cpu/intel_rdt.c
@@ -223,7 +223,8 @@ static unsigned int cbm_idx(struct rdt_resource *r, unsigned int closid)
  */
 static inline void cache_alloc_hsw_probe(void)
 {
-	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].resctrl;
+	struct rdt_hw_resource *hw_res  = &rdt_resources_all[RDT_RESOURCE_L3];
+	struct rdt_resource *r = &hw_res->resctrl;
 	u32 l, h, max_cbm = BIT_MASK(20) - 1;
 
 	if (wrmsr_safe(IA32_L3_CBM_BASE, max_cbm, 0))
@@ -235,6 +236,7 @@ static inline void cache_alloc_hsw_probe(void)
 		return;
 
 	r->num_closid = 4;
+	hw_res->hw_num_closid = 4;
 	r->default_ctrl = max_cbm;
 	r->cache.cbm_len = 20;
 	r->cache.shareable_bits = 0xc0000;
@@ -276,12 +278,14 @@ static inline bool rdt_get_mb_table(struct rdt_resource *r)
 
 static bool rdt_get_mem_config(struct rdt_resource *r)
 {
+	struct rdt_hw_resource *hw_res = resctrl_to_rdt(r);
 	union cpuid_0x10_3_eax eax;
 	union cpuid_0x10_x_edx edx;
 	u32 ebx, ecx;
 
 	cpuid_count(0x00000010, 3, &eax.full, &ebx, &ecx, &edx.full);
 	r->num_closid = edx.split.cos_max + 1;
+	hw_res->hw_num_closid = r->num_closid;
 	r->membw.max_delay = eax.split.max_delay + 1;
 	r->default_ctrl = MAX_MBA_BW;
 	if (ecx & MBA_IS_LINEAR) {
@@ -302,12 +306,14 @@ static bool rdt_get_mem_config(struct rdt_resource *r)
 
 static void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
 {
+	struct rdt_hw_resource *hw_res = resctrl_to_rdt(r);
 	union cpuid_0x10_1_eax eax;
 	union cpuid_0x10_x_edx edx;
 	u32 ebx, ecx;
 
 	cpuid_count(0x00000010, idx, &eax.full, &ebx, &ecx, &edx.full);
 	r->num_closid = edx.split.cos_max + 1;
+	hw_res->hw_num_closid = r->num_closid;
 	r->cache.cbm_len = eax.split.cbm_len + 1;
 	r->default_ctrl = BIT_MASK(eax.split.cbm_len + 1) - 1;
 	r->cache.shareable_bits = ebx & r->default_ctrl;
@@ -319,9 +325,11 @@ static void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
 static void rdt_get_cdp_config(int level, int type)
 {
 	struct rdt_resource *r_l = &rdt_resources_all[level].resctrl;
-	struct rdt_resource *r = &rdt_resources_all[type].resctrl;
+	struct rdt_hw_resource *hw_res_t = &rdt_resources_all[type];
+	struct rdt_resource *r = &hw_res_t->resctrl;
 
 	r->num_closid = r_l->num_closid / 2;
+	hw_res_t->hw_num_closid = r_l->num_closid;
 	r->cache.cbm_len = r_l->cache.cbm_len;
 	r->default_ctrl = r_l->default_ctrl;
 	r->cache.shareable_bits = r_l->cache.shareable_bits;
@@ -463,6 +471,7 @@ struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
 void setup_default_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm)
 {
 	int i;
+	struct rdt_hw_resource *hw_res = resctrl_to_rdt(r);
 
 	/*
 	 * Initialize the Control MSRs to having no control.
@@ -470,7 +479,7 @@ void setup_default_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm)
 	 * For Memory Allocation: Set b/w requested to 100%
 	 * and the bandwidth in MBps to U32_MAX
 	 */
-	for (i = 0; i < r->num_closid; i++, dc++, dm++) {
+	for (i = 0; i < hw_res->hw_num_closid; i++, dc++, dm++) {
 		*dc = r->default_ctrl;
 		*dm = MBA_MAX_MBPS;
 	}
@@ -483,7 +492,7 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
 	struct msr_param m;
 	u32 *dc, *dm;
 
-	dc = kmalloc_array(r->num_closid, sizeof(*hw_dom->ctrl_val), GFP_KERNEL);
+	dc = kmalloc_array(hw_res->hw_num_closid, sizeof(*hw_dom->ctrl_val), GFP_KERNEL);
 	if (!dc)
 		return -ENOMEM;
 
@@ -498,7 +507,7 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
 	setup_default_ctrlval(r, dc, dm);
 
 	m.low = 0;
-	m.high = r->num_closid;
+	m.high = hw_res->hw_num_closid;
 	hw_res->msr_update(d, &m, r);
 	return 0;
 }
diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 8df549ef016d..92822ff99f1a 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -275,6 +275,7 @@ static inline bool is_mbm_event(int e)
  * struct rdt_resource - attributes of an RDT resource
  * @resctrl:		Properties exposed to the resctrl filesystem
  * @rid:		The index of the resource
+ * @hw_num_closid:	The actual number of closids, regardless of CDP
  * @msr_base:		Base MSR address for CBMs
  * @msr_update:		Function pointer to update QOS MSRs
  * @mon_scale:			cqm counter * mon_scale = occupancy in bytes
@@ -283,6 +284,7 @@ static inline bool is_mbm_event(int e)
 struct rdt_hw_resource {
 	struct rdt_resource	resctrl;
 	int			rid;
+	u32			hw_num_closid;
 	unsigned int		msr_base;
 	void (*msr_update)	(struct rdt_domain *d, struct msr_param *m,
 				 struct rdt_resource *r);
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index f4f76c193495..58dceaad6863 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -1362,6 +1362,7 @@ static struct dentry *rdt_mount(struct file_system_type *fs_type,
 
 static int reset_all_ctrls(struct rdt_resource *r)
 {
+	struct rdt_hw_resource *hw_res = resctrl_to_rdt(r);
 	struct rdt_hw_domain *hw_dom;
 	struct msr_param msr_param;
 	cpumask_var_t cpu_mask;
@@ -1384,7 +1385,7 @@ static int reset_all_ctrls(struct rdt_resource *r)
 		hw_dom = rc_dom_to_rdt(d);
 		cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
 
-		for (i = 0; i < r->num_closid; i++)
+		for (i = 0; i < hw_res->hw_num_closid; i++)
 			hw_dom->ctrl_val[i] = r->default_ctrl;
 	}
 	cpu = get_cpu();
-- 
2.18.0


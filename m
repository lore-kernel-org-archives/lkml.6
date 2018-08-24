Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98EEC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957CD21763
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:46:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 957CD21763
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbeHXOUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 10:20:51 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55682 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727997AbeHXOUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 10:20:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11478168F;
        Fri, 24 Aug 2018 03:46:45 -0700 (PDT)
Received: from melchizedek.Emea.Arm.com (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6951D3F5A0;
        Fri, 24 Aug 2018 03:46:43 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Vikas Shivappa <vikas.shivappa@linux.intel.com>
Subject: [RFC PATCH 20/20] x86/intel_rdt: Merge cdp enable/disable calls
Date:   Fri, 24 Aug 2018 11:45:19 +0100
Message-Id: <20180824104519.11203-21-james.morse@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180824104519.11203-1-james.morse@arm.com>
References: <20180824104519.11203-1-james.morse@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the cdp_enable() and cdp_disable() calls are basically the same,
merge them into cdp_set_enabled(true/false).

All these functions are behind resctrl_arch_set_cdp_enabled(),
so the can take the rdt_hw_resource directly.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 49 ++++++------------------
 1 file changed, 12 insertions(+), 37 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 38cd463443e8..b9b7375ef8a9 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -1017,10 +1017,9 @@ static inline bool is_mba_linear(void)
 	return rdt_resources_all[RDT_RESOURCE_MBA].resctrl.membw.delay_linear;
 }
 
-static int set_cache_qos_cfg(int level, bool enable)
+static int set_cache_qos_cfg(struct rdt_hw_resource *hw_res, bool enable)
 {
 	void (*update)(void *arg);
-	struct rdt_resource *r_l;
 	cpumask_var_t cpu_mask;
 	struct rdt_domain *d;
 	int cpu;
@@ -1028,15 +1027,14 @@ static int set_cache_qos_cfg(int level, bool enable)
 	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
 		return -ENOMEM;
 
-	if (level == RDT_RESOURCE_L3)
+	if (hw_res == &rdt_resources_all[RDT_RESOURCE_L3])
 		update = l3_qos_cfg_update;
-	else if (level == RDT_RESOURCE_L2)
+	else if (hw_res == &rdt_resources_all[RDT_RESOURCE_L2])
 		update = l2_qos_cfg_update;
 	else
 		return -EINVAL;
 
-	r_l = &rdt_resources_all[level].resctrl;
-	list_for_each_entry(d, &r_l->domains, list) {
+	list_for_each_entry(d, &hw_res->resctrl.domains, list) {
 		/* Pick one CPU from each domain instance to update MSR */
 		cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
 	}
@@ -1078,53 +1076,30 @@ static int set_mba_sc(bool mba_sc)
 	return 0;
 }
 
-static int cdp_enable(int level)
+static int cdp_set_enabled(struct rdt_hw_resource *hw_res, bool enable)
 {
-	struct rdt_resource *r_l = &rdt_resources_all[level].resctrl;
 	int ret;
 
-	if (!r_l->alloc_capable || !r_l->cdp_capable)
+	if (!hw_res->resctrl.cdp_capable)
 		return -EINVAL;
 
-	ret = set_cache_qos_cfg(level, true);
+	ret = set_cache_qos_cfg(hw_res, enable);
 	if (!ret)
-		r_l->cdp_enabled = true;
+		hw_res->resctrl.cdp_enabled = enable;
 
 	return ret;
 }
 
-static void cdp_disable(int level)
-{
-	struct rdt_resource *r = &rdt_resources_all[level].resctrl;
-
-	if (r->cdp_enabled) {
-		set_cache_qos_cfg(level, false);
-		r->cdp_enabled = false;
-	}
-}
-
 int resctrl_arch_set_cdp_enabled(bool enable)
 {
 	int ret = -EINVAL;
 	struct rdt_hw_resource *l3 = &rdt_resources_all[RDT_RESOURCE_L3];
 	struct rdt_hw_resource *l2 = &rdt_resources_all[RDT_RESOURCE_L2];
 
-	if (l3 && l3->resctrl.cdp_capable) {
-		if (!enable) {
-			cdp_disable(RDT_RESOURCE_L3);
-			ret = 0;
-		} else {
-			ret = cdp_enable(RDT_RESOURCE_L3);
-		}
-	}
-	if (l2 && l2->resctrl.cdp_capable) {
-		if (!enable) {
-			cdp_disable(RDT_RESOURCE_L2);
-			ret = 0;
-		} else {
-			ret = cdp_enable(RDT_RESOURCE_L2);
-		}
-	}
+	if (l3 && l3->resctrl.cdp_capable)
+		ret = cdp_set_enabled(l3, enable);
+	if (l2 && l2->resctrl.cdp_capable)
+		ret = cdp_set_enabled(l2, enable);
 
 	return ret;
 }
-- 
2.18.0


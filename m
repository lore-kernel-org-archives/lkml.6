Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD1BC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9636B2168B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9636B2168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbeHXOUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 10:20:20 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55532 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbeHXOUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 10:20:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F280174E;
        Fri, 24 Aug 2018 03:46:15 -0700 (PDT)
Received: from melchizedek.Emea.Arm.com (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A7F1F3F5A0;
        Fri, 24 Aug 2018 03:46:13 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Vikas Shivappa <vikas.shivappa@linux.intel.com>
Subject: [RFC PATCH 08/20] x86/intel_rdt: Make cdp enable/disable global
Date:   Fri, 24 Aug 2018 11:45:07 +0100
Message-Id: <20180824104519.11203-9-james.morse@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180824104519.11203-1-james.morse@arm.com>
References: <20180824104519.11203-1-james.morse@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the CPU supports Intel's Code and Data Prioritization (CDP), software
can specify a separate bitmap for code and data. This feature needs
enabling in a model-specific-register, and changes the properties of
the cache-controls: it halves the effective number of closids.

This changes how closids are allocated, and so applies to all
alloc_enabled caches. If a system has multiple levels of RDT-like
controls CDP should be enabled/disabled across them all.

Make the CDP enable/disable calls global.

Add CDP capable/enabled flags, and unify the enable/disable behind a
single resctrl_arch_set_cdp_enabled(true/false) call. Architectures
that have nothing to do here can just update the flags.

This subtly changes resctrl's '-o cdp' (l3) and '-o cdpl2' parameters
to mean enable globally if this level supports cdp. The difference
can't be seen on a system which only has one of the two.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/intel_rdt.c          |  1 +
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 72 ++++++++++++++++--------
 include/linux/resctrl.h                  |  7 +++
 3 files changed, 57 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.c b/arch/x86/kernel/cpu/intel_rdt.c
index c4e6dcdd235b..0e651447956e 100644
--- a/arch/x86/kernel/cpu/intel_rdt.c
+++ b/arch/x86/kernel/cpu/intel_rdt.c
@@ -331,6 +331,7 @@ static void rdt_get_cdp_config(int level, int type)
 	 * By default, CDP is disabled. CDP can be enabled by mount parameter
 	 * "cdp" during resctrl file system mount time.
 	 */
+	r_l->cdp_capable = true;
 	r->alloc_enabled = false;
 }
 
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 3ed88d4fedd0..f4f76c193495 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -1081,7 +1081,7 @@ static int cdp_enable(int level, int data_type, int code_type)
 	int ret;
 
 	if (!r_l->alloc_capable || !r_ldata->alloc_capable ||
-	    !r_lcode->alloc_capable)
+	    !r_lcode->alloc_capable || !r_l->cdp_capable)
 		return -EINVAL;
 
 	ret = set_cache_qos_cfg(level, true);
@@ -1089,51 +1089,77 @@ static int cdp_enable(int level, int data_type, int code_type)
 		r_l->alloc_enabled = false;
 		r_ldata->alloc_enabled = true;
 		r_lcode->alloc_enabled = true;
+
+		r_l->cdp_enabled = true;
+		r_ldata->cdp_enabled = true;
+		r_lcode->cdp_enabled = true;
 	}
 	return ret;
 }
 
-static int cdpl3_enable(void)
-{
-	return cdp_enable(RDT_RESOURCE_L3, RDT_RESOURCE_L3DATA,
-			  RDT_RESOURCE_L3CODE);
-}
-
-static int cdpl2_enable(void)
-{
-	return cdp_enable(RDT_RESOURCE_L2, RDT_RESOURCE_L2DATA,
-			  RDT_RESOURCE_L2CODE);
-}
-
 static void cdp_disable(int level, int data_type, int code_type)
 {
 	struct rdt_resource *r = &rdt_resources_all[level].resctrl;
 
+	if (!r->cdp_enabled)
+		return;
+
 	r->alloc_enabled = r->alloc_capable;
 
 	if (rdt_resources_all[data_type].resctrl.alloc_enabled) {
 		rdt_resources_all[data_type].resctrl.alloc_enabled = false;
 		rdt_resources_all[code_type].resctrl.alloc_enabled = false;
 		set_cache_qos_cfg(level, false);
+
+		r->cdp_enabled = false;
+		rdt_resources_all[data_type].resctrl.cdp_enabled = false;
+		rdt_resources_all[code_type].resctrl.cdp_enabled = false;
 	}
 }
 
-static void cdpl3_disable(void)
+int resctrl_arch_set_cdp_enabled(bool enable)
 {
-	cdp_disable(RDT_RESOURCE_L3, RDT_RESOURCE_L3DATA, RDT_RESOURCE_L3CODE);
+	int ret = -EINVAL;
+	struct rdt_hw_resource *l3 = &rdt_resources_all[RDT_RESOURCE_L3];
+	struct rdt_hw_resource *l2 = &rdt_resources_all[RDT_RESOURCE_L2];
+
+	if (l3 && l3->resctrl.cdp_capable) {
+		if (!enable) {
+			cdp_disable(RDT_RESOURCE_L3, RDT_RESOURCE_L3DATA,
+				    RDT_RESOURCE_L3CODE);
+			ret = 0;
+		} else {
+			ret = cdp_enable(RDT_RESOURCE_L3, RDT_RESOURCE_L3DATA,
+				    RDT_RESOURCE_L3CODE);
+		}
+	}
+	if (l2 && l2->resctrl.cdp_capable) {
+		if (!enable) {
+			cdp_disable(RDT_RESOURCE_L2, RDT_RESOURCE_L2DATA,
+				    RDT_RESOURCE_L2CODE);
+			ret = 0;
+		} else {
+			ret = cdp_enable(RDT_RESOURCE_L2, RDT_RESOURCE_L2DATA,
+				    RDT_RESOURCE_L2CODE);
+		}
+	}
+
+	return ret;
 }
 
-static void cdpl2_disable(void)
+static int try_to_enable_cdp(int level)
 {
-	cdp_disable(RDT_RESOURCE_L2, RDT_RESOURCE_L2DATA, RDT_RESOURCE_L2CODE);
+	struct rdt_resource *r = &rdt_resources_all[level].resctrl;
+
+	if (!r->cdp_capable)
+		return -EINVAL;
+
+	return resctrl_arch_set_cdp_enabled(true);
 }
 
 static void cdp_disable_all(void)
 {
-	if (rdt_resources_all[RDT_RESOURCE_L3DATA].resctrl.alloc_enabled)
-		cdpl3_disable();
-	if (rdt_resources_all[RDT_RESOURCE_L2DATA].resctrl.alloc_enabled)
-		cdpl2_disable();
+	resctrl_arch_set_cdp_enabled(false);
 }
 
 static int parse_rdtgroupfs_options(char *data)
@@ -1148,11 +1174,11 @@ static int parse_rdtgroupfs_options(char *data)
 		}
 
 		if (!strcmp(token, "cdp")) {
-			ret = cdpl3_enable();
+			ret = try_to_enable_cdp(RDT_RESOURCE_L3);
 			if (ret)
 				goto out;
 		} else if (!strcmp(token, "cdpl2")) {
-			ret = cdpl2_enable();
+			ret = try_to_enable_cdp(RDT_RESOURCE_L2);
 			if (ret)
 				goto out;
 		} else if (!strcmp(token, "mba_MBps")) {
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 9fe7d7de53d7..8bf813071039 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -75,8 +75,10 @@ struct resctrl_membw {
 /**
  * @alloc_enabled:	Is allocation enabled on this machine
  * @mon_enabled:	Is monitoring enabled for this feature
+ * @cdp_enabled		Is CDP enabled for this resource
  * @alloc_capable:	Is allocation available on this machine
  * @mon_capable:	Is monitor feature available on this machine
+ * @cdp_capable:	Is CDP feature available on this resource
  *
  * @cache_level:	Which cache level defines scope of this resource.
  *
@@ -100,8 +102,10 @@ struct resctrl_membw {
 struct rdt_resource {
 	bool				alloc_enabled;
 	bool				mon_enabled;
+	bool				cdp_enabled;
 	bool				alloc_capable;
 	bool				mon_capable;
+	bool				cdp_capable;
 
 	int				cache_level;
 
@@ -129,4 +133,7 @@ int resctrl_arch_update_domains(struct rdt_resource *r);
 void resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 			     u32 closid, u32 *value);
 
+/* Enable/Disable CDP on all applicable resources */
+int resctrl_arch_set_cdp_enabled(bool enable);
+
 #endif /* __LINUX_RESCTRL_H */
-- 
2.18.0


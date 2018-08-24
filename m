Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D61C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA452168B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:46:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BA452168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbeHXOUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 10:20:10 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55464 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbeHXOUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 10:20:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC6B41688;
        Fri, 24 Aug 2018 03:46:03 -0700 (PDT)
Received: from melchizedek.Emea.Arm.com (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4071F3F5A0;
        Fri, 24 Aug 2018 03:46:02 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Vikas Shivappa <vikas.shivappa@linux.intel.com>
Subject: [RFC PATCH 03/20] x86/intel_rdt: Group staged configuration into a separate struct
Date:   Fri, 24 Aug 2018 11:45:02 +0100
Message-Id: <20180824104519.11203-4-james.morse@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180824104519.11203-1-james.morse@arm.com>
References: <20180824104519.11203-1-james.morse@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to merge the L2/L2CODE/L2DATA resources to be a single resource,
but we still need to be able to apply separate CODE and DATA schema to
the domain.

Move the new_ctrl bitmap value and flag into a struct, and create an
array of them. Today there is only one element in the array, but
eventually resctrl will use the array slots for CODE/DATA/BOTH to
detect a duplicate schema being written.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c | 44 +++++++++++++++------
 include/linux/resctrl.h                     | 16 ++++++--
 2 files changed, 43 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
index e3dcb5161122..1068a19e03c5 100644
--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
@@ -67,16 +67,17 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
 int parse_bw(char *buf, struct rdt_resource *r, struct rdt_domain *d)
 {
 	unsigned long data;
+	struct resctrl_staged_config *cfg = &d->staged_config[0];
 
-	if (d->have_new_ctrl) {
+	if (cfg->have_new_ctrl) {
 		rdt_last_cmd_printf("duplicate domain %d\n", d->id);
 		return -EINVAL;
 	}
 
 	if (!bw_validate(buf, &data, r))
 		return -EINVAL;
-	d->new_ctrl = data;
-	d->have_new_ctrl = true;
+	cfg->new_ctrl = data;
+	cfg->have_new_ctrl = true;
 
 	return 0;
 }
@@ -129,16 +130,17 @@ static bool cbm_validate(char *buf, unsigned long *data, struct rdt_resource *r)
 int parse_cbm(char *buf, struct rdt_resource *r, struct rdt_domain *d)
 {
 	unsigned long data;
+	struct resctrl_staged_config *cfg = &d->staged_config[0];
 
-	if (d->have_new_ctrl) {
+	if (cfg->have_new_ctrl) {
 		rdt_last_cmd_printf("duplicate domain %d\n", d->id);
 		return -EINVAL;
 	}
 
 	if(!cbm_validate(buf, &data, r))
 		return -EINVAL;
-	d->new_ctrl = data;
-	d->have_new_ctrl = true;
+	cfg->new_ctrl = data;
+	cfg->have_new_ctrl = true;
 
 	return 0;
 }
@@ -175,15 +177,29 @@ static int parse_line(char *line, struct rdt_resource *r)
 	return -EINVAL;
 }
 
+static void apply_config(struct rdt_hw_domain *hw_dom,
+			 struct resctrl_staged_config *cfg, int closid,
+			 cpumask_var_t cpu_mask, bool mba_sc)
+{
+	u32 *dc = !mba_sc ? hw_dom->ctrl_val : hw_dom->mbps_val;
+
+	if (cfg->new_ctrl != dc[closid]) {
+		cpumask_set_cpu(cpumask_any(&hw_dom->resctrl.cpu_mask),
+				cpu_mask);
+		dc[closid] = cfg->new_ctrl;
+		cfg->have_new_ctrl = false;
+	}
+}
+
 static int update_domains(struct rdt_resource *r, int closid)
 {
+	struct resctrl_staged_config *cfg;
 	struct rdt_hw_domain *hw_dom;
 	struct msr_param msr_param;
 	cpumask_var_t cpu_mask;
 	struct rdt_domain *d;
 	bool mba_sc;
-	u32 *dc;
-	int cpu;
+	int i, cpu;
 
 	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
 		return -ENOMEM;
@@ -195,10 +211,12 @@ static int update_domains(struct rdt_resource *r, int closid)
 	mba_sc = is_mba_sc(r);
 	list_for_each_entry(d, &r->domains, list) {
 		hw_dom = rc_dom_to_rdt(d);
-		dc = !mba_sc ? hw_dom->ctrl_val : hw_dom->mbps_val;
-		if (d->have_new_ctrl && d->new_ctrl != dc[closid]) {
-			cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
-			dc[closid] = d->new_ctrl;
+		for (i = 0; i < ARRAY_SIZE(d->staged_config); i++) {
+			cfg = &hw_dom->resctrl.staged_config[i];
+			if (!cfg->have_new_ctrl)
+				continue;
+
+			apply_config(hw_dom, cfg, closid, cpu_mask, mba_sc);
 		}
 	}
 
@@ -259,7 +277,7 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 
 	for_each_alloc_enabled_rdt_resource(r) {
 		list_for_each_entry(dom, &r->domains, list)
-			dom->have_new_ctrl = false;
+			memset(dom->staged_config, 0, sizeof(dom->staged_config));
 	}
 
 	while ((tok = strsep(&buf, "\n")) != NULL) {
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 5950c30fcc30..0b57a55f4b3d 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -7,21 +7,29 @@
 #include <linux/list.h>
 #include <linux/kernel.h>
 
+/**
+ * struct resctrl_staged_config - parsed configuration to be applied
+ * @new_ctrl:		new ctrl value to be loaded
+ * @have_new_ctrl:	did user provide new_ctrl for this domain
+ */
+struct resctrl_staged_config {
+	u32			new_ctrl;
+	bool			have_new_ctrl;
+};
+
 /**
  * struct rdt_domain - group of cpus sharing an RDT resource
  * @list:	all instances of this resource
  * @id:		unique id for this instance
  * @cpu_mask:	which cpus share this resource
- * @new_ctrl:	new ctrl value to be loaded
- * @have_new_ctrl: did user provide new_ctrl for this domain
+ * @staged_config: parsed configuration to be applied
  */
 struct rdt_domain {
 	struct list_head	list;
 	int			id;
 	struct cpumask		cpu_mask;
 
-	u32			new_ctrl;
-	bool			have_new_ctrl;
+	struct resctrl_staged_config	staged_config[1];
 };
 
 /**
-- 
2.18.0


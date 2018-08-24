Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627F4C43615
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 105042168B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 105042168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeHXOUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 10:20:11 -0400
Received: from foss.arm.com ([217.140.101.70]:55478 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbeHXOUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 10:20:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 499F6168F;
        Fri, 24 Aug 2018 03:46:06 -0700 (PDT)
Received: from melchizedek.Emea.Arm.com (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A1FD23F5A0;
        Fri, 24 Aug 2018 03:46:04 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Vikas Shivappa <vikas.shivappa@linux.intel.com>
Subject: [RFC PATCH 04/20] x86/intel_rdt: Add closid to the staged config
Date:   Fri, 24 Aug 2018 11:45:03 +0100
Message-Id: <20180824104519.11203-5-james.morse@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180824104519.11203-1-james.morse@arm.com>
References: <20180824104519.11203-1-james.morse@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once we merge the L2/L2CODE/L2DATA resources, we still want to have
two configurations staged for one resource when CDP is enabled.

These two configurations would have different closid as far as the
hardware is concerned.

In preparation, add closid as a staged parameter, and pass it down
when the schema is being parsed. In the future this will be the
hardware closid, with the CDP correction already applied by resctrl.
This allows another architecture to work with resctrl, without
having to emulate CDP.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/intel_rdt.h             |  4 ++--
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c | 21 ++++++++++++---------
 include/linux/resctrl.h                     |  4 +++-
 3 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 7c17d74fd36c..5e271e0fe1f5 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -294,8 +294,8 @@ static inline struct rdt_hw_resource *resctrl_to_rdt(struct rdt_resource *r)
 	return container_of(r, struct rdt_hw_resource, resctrl);
 }
 
-int parse_cbm(char *buf, struct rdt_resource *r, struct rdt_domain *d);
-int parse_bw(char *buf, struct rdt_resource *r,  struct rdt_domain *d);
+int parse_cbm(char *buf, struct rdt_resource *r, struct rdt_domain *d, u32 closid);
+int parse_bw(char *buf, struct rdt_resource *r,  struct rdt_domain *d, u32 closid);
 
 extern struct mutex rdtgroup_mutex;
 
diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
index 1068a19e03c5..0c849653a99d 100644
--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
@@ -64,7 +64,7 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
 	return true;
 }
 
-int parse_bw(char *buf, struct rdt_resource *r, struct rdt_domain *d)
+int parse_bw(char *buf, struct rdt_resource *r, struct rdt_domain *d, u32 closid)
 {
 	unsigned long data;
 	struct resctrl_staged_config *cfg = &d->staged_config[0];
@@ -76,6 +76,7 @@ int parse_bw(char *buf, struct rdt_resource *r, struct rdt_domain *d)
 
 	if (!bw_validate(buf, &data, r))
 		return -EINVAL;
+	cfg->closid = closid;
 	cfg->new_ctrl = data;
 	cfg->have_new_ctrl = true;
 
@@ -127,7 +128,7 @@ static bool cbm_validate(char *buf, unsigned long *data, struct rdt_resource *r)
  * Read one cache bit mask (hex). Check that it is valid for the current
  * resource type.
  */
-int parse_cbm(char *buf, struct rdt_resource *r, struct rdt_domain *d)
+int parse_cbm(char *buf, struct rdt_resource *r, struct rdt_domain *d, u32 closid)
 {
 	unsigned long data;
 	struct resctrl_staged_config *cfg = &d->staged_config[0];
@@ -139,6 +140,7 @@ int parse_cbm(char *buf, struct rdt_resource *r, struct rdt_domain *d)
 
 	if(!cbm_validate(buf, &data, r))
 		return -EINVAL;
+	cfg->closid = closid;
 	cfg->new_ctrl = data;
 	cfg->have_new_ctrl = true;
 
@@ -151,7 +153,7 @@ int parse_cbm(char *buf, struct rdt_resource *r, struct rdt_domain *d)
  * separated by ";". The "id" is in decimal, and must match one of
  * the "id"s for this resource.
  */
-static int parse_line(char *line, struct rdt_resource *r)
+static int parse_line(char *line, struct rdt_resource *r, u32 closid)
 {
 	char *dom = NULL, *id;
 	struct rdt_domain *d;
@@ -169,7 +171,7 @@ static int parse_line(char *line, struct rdt_resource *r)
 	dom = strim(dom);
 	list_for_each_entry(d, &r->domains, list) {
 		if (d->id == dom_id) {
-			if (r->parse_ctrlval(dom, r, d))
+			if (r->parse_ctrlval(dom, r, d, closid))
 				return -EINVAL;
 			goto next;
 		}
@@ -178,15 +180,15 @@ static int parse_line(char *line, struct rdt_resource *r)
 }
 
 static void apply_config(struct rdt_hw_domain *hw_dom,
-			 struct resctrl_staged_config *cfg, int closid,
+			 struct resctrl_staged_config *cfg, 
 			 cpumask_var_t cpu_mask, bool mba_sc)
 {
 	u32 *dc = !mba_sc ? hw_dom->ctrl_val : hw_dom->mbps_val;
 
-	if (cfg->new_ctrl != dc[closid]) {
+	if (cfg->new_ctrl != dc[cfg->closid]) {
 		cpumask_set_cpu(cpumask_any(&hw_dom->resctrl.cpu_mask),
 				cpu_mask);
-		dc[closid] = cfg->new_ctrl;
+		dc[cfg->closid] = cfg->new_ctrl;
 		cfg->have_new_ctrl = false;
 	}
 }
@@ -204,6 +206,7 @@ static int update_domains(struct rdt_resource *r, int closid)
 	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
 		return -ENOMEM;
 
+	/* TODO: learn these two by looping the config */
 	msr_param.low = closid;
 	msr_param.high = msr_param.low + 1;
 	msr_param.res = r;
@@ -216,7 +219,7 @@ static int update_domains(struct rdt_resource *r, int closid)
 			if (!cfg->have_new_ctrl)
 				continue;
 
-			apply_config(hw_dom, cfg, closid, cpu_mask, mba_sc);
+			apply_config(hw_dom, cfg, cpu_mask, mba_sc);
 		}
 	}
 
@@ -246,7 +249,7 @@ static int rdtgroup_parse_resource(char *resname, char *tok, int closid)
 
 	for_each_alloc_enabled_rdt_resource(r) {
 		if (!strcmp(resname, r->name) && closid < r->num_closid)
-			return parse_line(tok, r);
+			return parse_line(tok, r, closid);
 	}
 	rdt_last_cmd_printf("unknown/unsupported resource name '%s'\n", resname);
 	return -EINVAL;
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 0b57a55f4b3d..370db085ee77 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -9,10 +9,12 @@
 
 /**
  * struct resctrl_staged_config - parsed configuration to be applied
+ * @closid:		The closid the new configuration applies to
  * @new_ctrl:		new ctrl value to be loaded
  * @have_new_ctrl:	did user provide new_ctrl for this domain
  */
 struct resctrl_staged_config {
+	u32			closid;
 	u32			new_ctrl;
 	bool			have_new_ctrl;
 };
@@ -116,7 +118,7 @@ struct rdt_resource {
 	u32				default_ctrl;
 	const char			*format_str;
 	int (*parse_ctrlval)		(char *buf, struct rdt_resource *r,
-					 struct rdt_domain *d);
+					 struct rdt_domain *d, u32 closid);
 
 	struct list_head		evt_list;
 	unsigned long			fflags;
-- 
2.18.0


Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80E4C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C50F2157C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:46:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C50F2157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbeHXOU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 10:20:28 -0400
Received: from foss.arm.com ([217.140.101.70]:55574 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbeHXOU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 10:20:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C9E515A2;
        Fri, 24 Aug 2018 03:46:22 -0700 (PDT)
Received: from melchizedek.Emea.Arm.com (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D4E9E3F5A0;
        Fri, 24 Aug 2018 03:46:20 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Vikas Shivappa <vikas.shivappa@linux.intel.com>
Subject: [RFC PATCH 11/20] x86/intel_rdt: Pass in the code/data/both configuration value when parsing
Date:   Fri, 24 Aug 2018 11:45:10 +0100
Message-Id: <20180824104519.11203-12-james.morse@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180824104519.11203-1-james.morse@arm.com>
References: <20180824104519.11203-1-james.morse@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The illusion of three types of cache at each level is a neat trick to
allow a static table of resources to be used. This is a problem if the
cache topology and partitioning abilities have to be discovered at boot.

We want to fold the three code/data/both caches into one, and move the
CDP configuration details to be a property of the configuration and
its closid, not the cache. The resctrl filesystem can then re-create
the illusion of separate caches.

Temporarily label the configuration property of the cache, and pass
this value down to the configuration helpers. Eventually we will move
this label up to become a property of the schema.

A later patch will correct the closid for CDP when the configuration is
staged, which will let us merge the three types of resource.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/intel_rdt.c             |  6 ++++++
 arch/x86/kernel/cpu/intel_rdt.h             |  7 +++++--
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c | 15 ++++++++++-----
 include/linux/resctrl.h                     | 11 ++++++++++-
 4 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.c b/arch/x86/kernel/cpu/intel_rdt.c
index c035280b4398..8d3544b6c149 100644
--- a/arch/x86/kernel/cpu/intel_rdt.c
+++ b/arch/x86/kernel/cpu/intel_rdt.c
@@ -83,6 +83,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.format_str		= "%d=%0*x",
 			.fflags			= RFTYPE_RES_CACHE,
 		},
+		.cdp_type		= CDP_BOTH,
 		.msr_base		= IA32_L3_CBM_BASE,
 		.msr_update		= cat_wrmsr,
 	},
@@ -102,6 +103,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.format_str		= "%d=%0*x",
 			.fflags			= RFTYPE_RES_CACHE,
 		},
+		.cdp_type		= CDP_DATA,
 		.msr_base		= IA32_L3_CBM_BASE,
 		.msr_update		= cat_wrmsr,
 
@@ -122,6 +124,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.format_str		= "%d=%0*x",
 			.fflags			= RFTYPE_RES_CACHE,
 		},
+		.cdp_type		= CDP_CODE,
 		.msr_base		= IA32_L3_CBM_BASE,
 		.msr_update		= cat_wrmsr,
 	},
@@ -141,6 +144,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.format_str		= "%d=%0*x",
 			.fflags			= RFTYPE_RES_CACHE,
 		},
+		.cdp_type		= CDP_BOTH,
 		.msr_base		= IA32_L2_CBM_BASE,
 		.msr_update		= cat_wrmsr,
 	},
@@ -160,6 +164,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.format_str		= "%d=%0*x",
 			.fflags			= RFTYPE_RES_CACHE,
 		},
+		.cdp_type		= CDP_DATA,
 		.msr_base		= IA32_L2_CBM_BASE,
 		.msr_update		= cat_wrmsr,
 	},
@@ -179,6 +184,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.format_str		= "%d=%0*x",
 			.fflags			= RFTYPE_RES_CACHE,
 		},
+		.cdp_type		= CDP_CODE,
 		.msr_base		= IA32_L2_CBM_BASE,
 		.msr_update		= cat_wrmsr,
 	},
diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 92822ff99f1a..cc8dea58b74f 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -285,6 +285,7 @@ struct rdt_hw_resource {
 	struct rdt_resource	resctrl;
 	int			rid;
 	u32			hw_num_closid;
+	enum resctrl_conf_type  cdp_type; // temporary
 	unsigned int		msr_base;
 	void (*msr_update)	(struct rdt_domain *d, struct msr_param *m,
 				 struct rdt_resource *r);
@@ -296,8 +297,10 @@ static inline struct rdt_hw_resource *resctrl_to_rdt(struct rdt_resource *r)
 	return container_of(r, struct rdt_hw_resource, resctrl);
 }
 
-int parse_cbm(char *buf, struct rdt_resource *r, struct rdt_domain *d, u32 closid);
-int parse_bw(char *buf, struct rdt_resource *r,  struct rdt_domain *d, u32 closid);
+int parse_cbm(char *buf, struct rdt_resource *r, struct rdt_domain *d,
+	      enum resctrl_conf_type t, u32 closid);
+int parse_bw(char *buf, struct rdt_resource *r,  struct rdt_domain *d,
+	     enum resctrl_conf_type t,  u32 closid);
 
 extern struct mutex rdtgroup_mutex;
 
diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
index 766c3e62ad91..bab6032704c3 100644
--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
@@ -64,7 +64,8 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
 	return true;
 }
 
-int parse_bw(char *buf, struct rdt_resource *r, struct rdt_domain *d, u32 closid)
+int parse_bw(char *buf, struct rdt_resource *r, struct rdt_domain *d,
+	     enum resctrl_conf_type t, u32 closid)
 {
 	unsigned long data;
 	struct resctrl_staged_config *cfg = &d->staged_config[0];
@@ -78,6 +79,7 @@ int parse_bw(char *buf, struct rdt_resource *r, struct rdt_domain *d, u32 closid
 		return -EINVAL;
 	cfg->closid = closid;
 	cfg->new_ctrl = data;
+	cfg->new_ctrl_type = t;
 	cfg->have_new_ctrl = true;
 
 	return 0;
@@ -128,7 +130,8 @@ static bool cbm_validate(char *buf, unsigned long *data, struct rdt_resource *r)
  * Read one cache bit mask (hex). Check that it is valid for the current
  * resource type.
  */
-int parse_cbm(char *buf, struct rdt_resource *r, struct rdt_domain *d, u32 closid)
+int parse_cbm(char *buf, struct rdt_resource *r, struct rdt_domain *d,
+	      enum resctrl_conf_type t, u32 closid)
 {
 	unsigned long data;
 	struct resctrl_staged_config *cfg = &d->staged_config[0];
@@ -142,6 +145,7 @@ int parse_cbm(char *buf, struct rdt_resource *r, struct rdt_domain *d, u32 closi
 		return -EINVAL;
 	cfg->closid = closid;
 	cfg->new_ctrl = data;
+	cfg->new_ctrl_type = t;
 	cfg->have_new_ctrl = true;
 
 	return 0;
@@ -153,7 +157,8 @@ int parse_cbm(char *buf, struct rdt_resource *r, struct rdt_domain *d, u32 closi
  * separated by ";". The "id" is in decimal, and must match one of
  * the "id"s for this resource.
  */
-static int parse_line(char *line, struct rdt_resource *r, u32 closid)
+static int parse_line(char *line, struct rdt_resource *r,
+		      enum resctrl_conf_type t, u32 closid)
 {
 	char *dom = NULL, *id;
 	struct rdt_domain *d;
@@ -171,7 +176,7 @@ static int parse_line(char *line, struct rdt_resource *r, u32 closid)
 	dom = strim(dom);
 	list_for_each_entry(d, &r->domains, list) {
 		if (d->id == dom_id) {
-			if (r->parse_ctrlval(dom, r, d, closid))
+			if (r->parse_ctrlval(dom, r, d, t, closid))
 				return -EINVAL;
 			goto next;
 		}
@@ -260,7 +265,7 @@ static int rdtgroup_parse_resource(char *resname, char *tok, int closid)
 
 	for_each_alloc_enabled_rdt_resource(r) {
 		if (!strcmp(resname, r->name) && closid < r->num_closid)
-			return parse_line(tok, r, closid);
+			return parse_line(tok, r, resctrl_to_rdt(r)->cdp_type, closid);
 	}
 	rdt_last_cmd_printf("unknown/unsupported resource name '%s'\n", resname);
 	return -EINVAL;
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 8bf813071039..592242635204 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -7,16 +7,24 @@
 #include <linux/list.h>
 #include <linux/kernel.h>
 
+enum resctrl_conf_type {
+	CDP_BOTH = 0,
+	CDP_CODE,
+	CDP_DATA,
+};
+
 /**
  * struct resctrl_staged_config - parsed configuration to be applied
  * @closid:		The closid the new configuration applies to
  * @new_ctrl:		new ctrl value to be loaded
  * @have_new_ctrl:	did user provide new_ctrl for this domain
+ * @new_ctrl_type:	CDP property of the new ctrl
  */
 struct resctrl_staged_config {
 	u32			closid;
 	u32			new_ctrl;
 	bool			have_new_ctrl;
+	enum resctrl_conf_type  new_ctrl_type;
 };
 
 /**
@@ -122,7 +130,8 @@ struct rdt_resource {
 	u32				default_ctrl;
 	const char			*format_str;
 	int (*parse_ctrlval)		(char *buf, struct rdt_resource *r,
-					 struct rdt_domain *d, u32 closid);
+					 struct rdt_domain *d,
+					 enum resctrl_conf_type t, u32 closid);
 
 	struct list_head		evt_list;
 	unsigned long			fflags;
-- 
2.18.0


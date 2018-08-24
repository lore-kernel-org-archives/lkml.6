Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB10CC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A91212157C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A91212157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbeHXOUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 10:20:39 -0400
Received: from foss.arm.com ([217.140.101.70]:55634 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727997AbeHXOUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 10:20:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68EAC1650;
        Fri, 24 Aug 2018 03:46:34 -0700 (PDT)
Received: from melchizedek.Emea.Arm.com (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C163F3F5A0;
        Fri, 24 Aug 2018 03:46:32 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Vikas Shivappa <vikas.shivappa@linux.intel.com>
Subject: [RFC PATCH 16/20] x86/intel_rdt: Move the schemata names into struct resctrl_schema
Date:   Fri, 24 Aug 2018 11:45:15 +0100
Message-Id: <20180824104519.11203-17-james.morse@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180824104519.11203-1-james.morse@arm.com>
References: <20180824104519.11203-1-james.morse@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the names used for the schemata file out of the resource and
into struct resctrl_schema. This lets us give one resource two
different names, based on the other schema properties.

For now we copy the name, once we merge the L2/L2CODE/L2DATA
resources resctrl will generate it.

Remove the arch code's max_name_width, this is now resctrl's
problem.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/intel_rdt.c             | 9 ++-------
 arch/x86/kernel/cpu/intel_rdt.h             | 2 +-
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c | 4 ++--
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c    | 4 +++-
 include/linux/resctrl.h                     | 7 +++++++
 5 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.c b/arch/x86/kernel/cpu/intel_rdt.c
index 6466c172c045..3a0d7de15afa 100644
--- a/arch/x86/kernel/cpu/intel_rdt.c
+++ b/arch/x86/kernel/cpu/intel_rdt.c
@@ -48,10 +48,10 @@ DEFINE_MUTEX(rdtgroup_mutex);
 DEFINE_PER_CPU(struct intel_pqr_state, pqr_state);
 
 /*
- * Used to store the max resource name width and max resource data width
+ * Used to store the max resource data width
  * to display the schemata in a tabular format
  */
-int max_name_width, max_data_width;
+int max_data_width;
 
 /*
  * Global boolean for rdt_alloc which is true if any
@@ -722,13 +722,8 @@ static int intel_rdt_offline_cpu(unsigned int cpu)
 static __init void rdt_init_padding(void)
 {
 	struct rdt_resource *r;
-	int cl;
 
 	for_each_alloc_capable_rdt_resource(r) {
-		cl = strlen(r->name);
-		if (cl > max_name_width)
-			max_name_width = cl;
-
 		if (r->data_width > max_data_width)
 			max_data_width = r->data_width;
 	}
diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index cc8dea58b74f..b72448186532 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -146,7 +146,7 @@ struct rdtgroup {
 /* List of all resource groups */
 extern struct list_head rdt_all_groups;
 
-extern int max_name_width, max_data_width;
+extern int max_data_width;
 
 int __init rdtgroup_init(void);
 
diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
index 3038ecfdeec0..e8264637a4d3 100644
--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
@@ -275,7 +275,7 @@ static int rdtgroup_parse_resource(char *resname, char *tok, int closid)
 
 	list_for_each_entry(s, &resctrl_all_schema, list) {
 		r = s->res;
-		if (!strcmp(resname, r->name) && closid < r->num_closid)
+		if (!strcmp(resname, s->name) && closid < r->num_closid)
 			return parse_line(tok, r, s->conf_type, closid);
 	}
 	rdt_last_cmd_printf("unknown/unsupported resource name '%s'\n", resname);
@@ -358,7 +358,7 @@ static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int clo
 	bool sep = false;
 	u32 ctrl_val, hw_closid;
 
-	seq_printf(s, "%*s:", max_name_width, r->name);
+	seq_printf(s, "%*s:", sizeof(schema->name), schema->name);
 	list_for_each_entry(dom, &r->domains, list) {
 		if (sep)
 			seq_puts(s, ";");
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 0bd748defc73..b3d3acbb2ef7 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -932,7 +932,7 @@ static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
 	list_for_each_entry(s, &resctrl_all_schema, list) {
 		r = s->res;
 		fflags =  r->fflags | RF_CTRL_INFO;
-		ret = rdtgroup_mkdir_info_resdir(r, r->name, fflags);
+		ret = rdtgroup_mkdir_info_resdir(r, s->name, fflags);
 		if (ret)
 			goto out_destroy;
 	}
@@ -1306,6 +1306,8 @@ static int create_schemata_list(void)
 		s->res = r;
 		s->conf_type = resctrl_to_rdt(r)->cdp_type;
 
+		snprintf(s->name, sizeof(s->name), "%s", r->name);
+
 		INIT_LIST_HEAD(&s->list);
 		list_add(&s->list, &resctrl_all_schema);
 	}
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 9ed0beb241d8..8b06ed8e7407 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -7,6 +7,11 @@
 #include <linux/list.h>
 #include <linux/kernel.h>
 
+/*
+ * The longest name we expect in the schemata file:
+ */
+#define RESCTRL_NAME_LEN	7
+
 enum resctrl_conf_type {
 	CDP_BOTH = 0,
 	CDP_CODE,
@@ -147,11 +152,13 @@ int resctrl_arch_set_cdp_enabled(bool enable);
 
 /**
  * @list:	Member of resctrl's schema list
+ * @name:	Name visible in the schemata file
  * @conf_type:	Type of configuration, e.g. code/data/both
  * @res:	The rdt_resource for this entry
  */
 struct resctrl_schema {
 	struct list_head		list;
+	char				name[RESCTRL_NAME_LEN];
 	enum resctrl_conf_type		conf_type;
 	struct rdt_resource		*res;
 };
-- 
2.18.0


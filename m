Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39ACC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F5521785
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:46:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F5521785
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbeHXOUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 10:20:37 -0400
Received: from foss.arm.com ([217.140.101.70]:55622 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727997AbeHXOUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 10:20:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0C2115A2;
        Fri, 24 Aug 2018 03:46:31 -0700 (PDT)
Received: from melchizedek.Emea.Arm.com (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5410D3F5A0;
        Fri, 24 Aug 2018 03:46:30 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Vikas Shivappa <vikas.shivappa@linux.intel.com>
Subject: [RFC PATCH 15/20] x86/intel_rdt: Walk the resctrl schema list instead of the arch's resource list
Date:   Fri, 24 Aug 2018 11:45:14 +0100
Message-Id: <20180824104519.11203-16-james.morse@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180824104519.11203-1-james.morse@arm.com>
References: <20180824104519.11203-1-james.morse@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that resctrl has a list of resources it is using, walk that list
instead of the architectures list. This lets us keep schema properties
with the resource that is using them.

Most users of for_each_alloc_enabled_rdt_resource() are per-schema,
switch these to walk the schema list. The remainder are working with
a per-resource property.

Previously we littered resctrl_to_rdt() wherever we needed to know the
cdp_type of a cache. Now that this has a home, fix all those callers
to read the value from the relevant schema entry.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c | 24 +++++++++++++--------
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c    |  4 +++-
 include/linux/resctrl.h                     |  2 +-
 3 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
index f80a838cc36d..3038ecfdeec0 100644
--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
@@ -271,10 +271,12 @@ int resctrl_arch_update_domains(struct rdt_resource *r)
 static int rdtgroup_parse_resource(char *resname, char *tok, int closid)
 {
 	struct rdt_resource *r;
+	struct resctrl_schema *s;
 
-	for_each_alloc_enabled_rdt_resource(r) {
+	list_for_each_entry(s, &resctrl_all_schema, list) {
+		r = s->res;
 		if (!strcmp(resname, r->name) && closid < r->num_closid)
-			return parse_line(tok, r, resctrl_to_rdt(r)->cdp_type, closid);
+			return parse_line(tok, r, s->conf_type, closid);
 	}
 	rdt_last_cmd_printf("unknown/unsupported resource name '%s'\n", resname);
 	return -EINVAL;
@@ -283,6 +285,7 @@ static int rdtgroup_parse_resource(char *resname, char *tok, int closid)
 ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 				char *buf, size_t nbytes, loff_t off)
 {
+	struct resctrl_schema *s;
 	struct rdtgroup *rdtgrp;
 	struct rdt_domain *dom;
 	struct rdt_resource *r;
@@ -303,9 +306,10 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 
 	closid = rdtgrp->closid;
 
-	for_each_alloc_enabled_rdt_resource(r) {
-		list_for_each_entry(dom, &r->domains, list)
+	list_for_each_entry(s, &resctrl_all_schema, list) {
+		list_for_each_entry(dom, &s->res->domains, list) {
 			memset(dom->staged_config, 0, sizeof(dom->staged_config));
+		}
 	}
 
 	while ((tok = strsep(&buf, "\n")) != NULL) {
@@ -347,9 +351,9 @@ void resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 		*value = hw_dom->mbps_val[hw_closid];
 }
 
-static void show_doms(struct seq_file *s, struct rdt_resource *r, int closid)
+static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int closid)
 {
-
+	struct rdt_resource *r = schema->res;
 	struct rdt_domain *dom;
 	bool sep = false;
 	u32 ctrl_val, hw_closid;
@@ -359,7 +363,7 @@ static void show_doms(struct seq_file *s, struct rdt_resource *r, int closid)
 		if (sep)
 			seq_puts(s, ";");
 
-		hw_closid = resctrl_closid_cdp_map(closid, resctrl_to_rdt(r)->cdp_type);
+		hw_closid = resctrl_closid_cdp_map(closid, schema->conf_type);
 		resctrl_arch_get_config(r, dom, hw_closid, &ctrl_val);
 		seq_printf(s, r->format_str, dom->id, max_data_width,
 			   ctrl_val);
@@ -371,6 +375,7 @@ static void show_doms(struct seq_file *s, struct rdt_resource *r, int closid)
 int rdtgroup_schemata_show(struct kernfs_open_file *of,
 			   struct seq_file *s, void *v)
 {
+	struct resctrl_schema *schema;
 	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
 	int ret = 0;
@@ -379,9 +384,10 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
 	rdtgrp = rdtgroup_kn_lock_live(of->kn);
 	if (rdtgrp) {
 		closid = rdtgrp->closid;
-		for_each_alloc_enabled_rdt_resource(r) {
+		list_for_each_entry(schema, &resctrl_all_schema, list) {
+			r = schema->res;
 			if (closid < r->num_closid)
-				show_doms(s, r, closid);
+				show_doms(s, schema, closid);
 		}
 	} else {
 		ret = -ENOENT;
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 2015d99ca388..0bd748defc73 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -913,6 +913,7 @@ static int rdtgroup_mkdir_info_resdir(struct rdt_resource *r, char *name,
 
 static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
 {
+	struct resctrl_schema *s;
 	struct rdt_resource *r;
 	unsigned long fflags;
 	char name[32];
@@ -928,7 +929,8 @@ static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
 	if (ret)
 		goto out_destroy;
 
-	for_each_alloc_enabled_rdt_resource(r) {
+	list_for_each_entry(s, &resctrl_all_schema, list) {
+		r = s->res;
 		fflags =  r->fflags | RF_CTRL_INFO;
 		ret = rdtgroup_mkdir_info_resdir(r, r->name, fflags);
 		if (ret)
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 071b2cc9c402..9ed0beb241d8 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -147,7 +147,7 @@ int resctrl_arch_set_cdp_enabled(bool enable);
 
 /**
  * @list:	Member of resctrl's schema list
- * @cdp_type:	Whether this entry is for code/data/both
+ * @conf_type:	Type of configuration, e.g. code/data/both
  * @res:	The rdt_resource for this entry
  */
 struct resctrl_schema {
-- 
2.18.0


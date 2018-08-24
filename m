Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B55C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A352157C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22A352157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbeHXOUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 10:20:35 -0400
Received: from foss.arm.com ([217.140.101.70]:55610 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727977AbeHXOUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 10:20:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7ED171AC1;
        Fri, 24 Aug 2018 03:46:29 -0700 (PDT)
Received: from melchizedek.Emea.Arm.com (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D6E753F5A0;
        Fri, 24 Aug 2018 03:46:27 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Vikas Shivappa <vikas.shivappa@linux.intel.com>
Subject: [RFC PATCH 14/20] x86/intel_rdt: Add a separate resource list for resctrl
Date:   Fri, 24 Aug 2018 11:45:13 +0100
Message-Id: <20180824104519.11203-15-james.morse@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180824104519.11203-1-james.morse@arm.com>
References: <20180824104519.11203-1-james.morse@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to merge the L2/L2CODE/L2DATA resources together so that
there is one resource per cache. The CDP properties are then
part of the configuration.

Currently the cdp type to use with the configuration is hidden
in the resource. This needs to be part of the schema, but resctrl
doesn't have a structure for this, (its all flattened out into
extra resources).

Create a list of schema that resctrl presents via the schemata file.
We want to move the illusion of an "L2CODE" cache into resctrl so that
this part of the ABI is dealt with by core code.
This change will allow us to have the same resource represented twice
as code/data, with the appropriate cdp_type for configuration.

This will also let us generate the names in resctrl.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 45 +++++++++++++++++++++++-
 include/linux/resctrl.h                  | 13 +++++++
 2 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index f3dfed9c609a..2015d99ca388 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -43,6 +43,9 @@ static struct kernfs_root *rdt_root;
 struct rdtgroup rdtgroup_default;
 LIST_HEAD(rdt_all_groups);
 
+/* list of entries for the schemata file */
+LIST_HEAD(resctrl_all_schema);
+
 /* Kernel fs node for "info" directory under root */
 static struct kernfs_node *kn_info;
 
@@ -1287,6 +1290,37 @@ static int mkdir_mondata_all(struct kernfs_node *parent_kn,
 			     struct rdtgroup *prgrp,
 			     struct kernfs_node **mon_data_kn);
 
+
+static int create_schemata_list(void)
+{
+	struct rdt_resource *r;
+	struct resctrl_schema *s;
+
+	for_each_alloc_enabled_rdt_resource(r) {
+		s = kzalloc(sizeof(*s), GFP_KERNEL);
+		if (!s)
+			return -ENOMEM;
+
+		s->res = r;
+		s->conf_type = resctrl_to_rdt(r)->cdp_type;
+
+		INIT_LIST_HEAD(&s->list);
+		list_add(&s->list, &resctrl_all_schema);
+	}
+
+	return 0;
+}
+
+static void destroy_schemata_list(void)
+{
+	struct resctrl_schema *s, *tmp;
+
+	list_for_each_entry_safe(s, tmp, &resctrl_all_schema, list) {
+		list_del(&s->list);
+		kfree(s);
+	}
+}
+
 static struct dentry *rdt_mount(struct file_system_type *fs_type,
 				int flags, const char *unused_dev_name,
 				void *data)
@@ -1312,12 +1346,18 @@ static struct dentry *rdt_mount(struct file_system_type *fs_type,
 		goto out_cdp;
 	}
 
+	ret = create_schemata_list();
+	if (ret) {
+		dentry = ERR_PTR(ret);
+		goto out_schemata_free;
+	}
+
 	closid_init();
 
 	ret = rdtgroup_create_info_dir(rdtgroup_default.kn);
 	if (ret) {
 		dentry = ERR_PTR(ret);
-		goto out_cdp;
+		goto out_schemata_free;
 	}
 
 	if (rdt_mon_capable) {
@@ -1370,6 +1410,8 @@ static struct dentry *rdt_mount(struct file_system_type *fs_type,
 		kernfs_remove(kn_mongrp);
 out_info:
 	kernfs_remove(kn_info);
+out_schemata_free:
+	destroy_schemata_list();
 out_cdp:
 	cdp_disable_all();
 out:
@@ -1538,6 +1580,7 @@ static void rdt_kill_sb(struct super_block *sb)
 		reset_all_ctrls(r);
 	cdp_disable_all();
 	rmdir_all_sub();
+	destroy_schemata_list();
 	static_branch_disable_cpuslocked(&rdt_alloc_enable_key);
 	static_branch_disable_cpuslocked(&rdt_mon_enable_key);
 	static_branch_disable_cpuslocked(&rdt_enable_key);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index ede5c40756b4..071b2cc9c402 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -145,4 +145,17 @@ void resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 /* Enable/Disable CDP on all applicable resources */
 int resctrl_arch_set_cdp_enabled(bool enable);
 
+/**
+ * @list:	Member of resctrl's schema list
+ * @cdp_type:	Whether this entry is for code/data/both
+ * @res:	The rdt_resource for this entry
+ */
+struct resctrl_schema {
+	struct list_head		list;
+	enum resctrl_conf_type		conf_type;
+	struct rdt_resource		*res;
+};
+
+extern struct list_head resctrl_all_schema;
+
 #endif /* __LINUX_RESCTRL_H */
-- 
2.18.0


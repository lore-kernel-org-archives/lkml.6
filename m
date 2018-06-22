Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02CFC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A08C2249BA
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A08C2249BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934117AbeFVWvS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 18:51:18 -0400
Received: from mga17.intel.com ([192.55.52.151]:52514 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933310AbeFVWmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 18:42:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2018 15:42:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,259,1526367600"; 
   d="scan'208";a="234843359"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga005.jf.intel.com with ESMTP; 22 Jun 2018 15:42:47 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V7 04/41] x86/intel_rdt: Associate mode with each RDT resource group
Date:   Fri, 22 Jun 2018 15:41:55 -0700
Message-Id: <797e4e1de4e4fcdf5b5e0039354d6a28079e2015.1529706536.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1529706536.git.reinette.chatre@intel.com>
References: <cover.1529706536.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1529706536.git.reinette.chatre@intel.com>
References: <cover.1529706536.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each RDT resource group is associated with a mode that will reflect
the level of sharing of its allocations. The default, shareable, will be
associated with each resource group on creation since it is zero and
resource groups are created with kzalloc. The managing of the mode of a
resource group will follow. The default resource group always remain
though so ensure that it is reset to the default mode when the resctrl
filesystem is unmounted.

Also introduce a utility that can be used to determine the mode of a
resource group when it is searched for based on its class of service.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/2f1844c590a87f96b8b948d5d6da54b532d25888.1527593970.git.reinette.chatre@intel.com
---
 arch/x86/kernel/cpu/intel_rdt.h          |  3 +++
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index c08eee73ecd3..7ff1f633bebe 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -122,6 +122,7 @@ struct mongroup {
  * @type:			indicates type of this rdtgroup - either
  *				monitor only or ctrl_mon group
  * @mon:			mongroup related data
+ * @mode:			mode of resource group
  */
 struct rdtgroup {
 	struct kernfs_node	*kn;
@@ -132,6 +133,7 @@ struct rdtgroup {
 	atomic_t		waitcount;
 	enum rdt_group_type	type;
 	struct mongroup		mon;
+	enum rdtgrp_mode	mode;
 };
 
 /* rdtgroup.flags */
@@ -461,6 +463,7 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 				char *buf, size_t nbytes, loff_t off);
 int rdtgroup_schemata_show(struct kernfs_open_file *of,
 			   struct seq_file *s, void *v);
+enum rdtgrp_mode rdtgroup_mode_by_closid(int closid);
 struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);
 int alloc_rmid(void);
 void free_rmid(u32 rmid);
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 7f32bca02b75..51e99d1b1caa 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -126,6 +126,27 @@ static void closid_free(int closid)
 	closid_free_map |= 1 << closid;
 }
 
+/**
+ * rdtgroup_mode_by_closid - Return mode of resource group with closid
+ * @closid: closid if the resource group
+ *
+ * Each resource group is associated with a @closid. Here the mode
+ * of a resource group can be queried by searching for it using its closid.
+ *
+ * Return: mode as &enum rdtgrp_mode of resource group with closid @closid
+ */
+enum rdtgrp_mode rdtgroup_mode_by_closid(int closid)
+{
+	struct rdtgroup *rdtgrp;
+
+	list_for_each_entry(rdtgrp, &rdt_all_groups, rdtgroup_list) {
+		if (rdtgrp->closid == closid)
+			return rdtgrp->mode;
+	}
+
+	return RDT_NUM_MODES;
+}
+
 /* set uid and gid of rdtgroup dirs and files to that of the creator */
 static int rdtgroup_kn_set_ugid(struct kernfs_node *kn)
 {
@@ -1500,6 +1521,7 @@ static void rdt_kill_sb(struct super_block *sb)
 		reset_all_ctrls(r);
 	cdp_disable_all();
 	rmdir_all_sub();
+	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
 	static_branch_disable_cpuslocked(&rdt_alloc_enable_key);
 	static_branch_disable_cpuslocked(&rdt_mon_enable_key);
 	static_branch_disable_cpuslocked(&rdt_enable_key);
-- 
2.17.0


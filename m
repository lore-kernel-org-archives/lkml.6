Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2726FC43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAFFE24BAA
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAFFE24BAA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751958AbeFWMIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 08:08:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53119 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbeFWMIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 08:08:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5NC8jXT463286
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 23 Jun 2018 05:08:45 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5NC8jMp463279;
        Sat, 23 Jun 2018 05:08:45 -0700
Date:   Sat, 23 Jun 2018 05:08:45 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-472ef09b40c5802a2e014ae2503ad8619486f9e6@git.kernel.org>
Cc:     tglx@linutronix.de, reinette.chatre@intel.com, hpa@zytor.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
          reinette.chatre@intel.com, tglx@linutronix.de
In-Reply-To: <797e4e1de4e4fcdf5b5e0039354d6a28079e2015.1529706536.git.reinette.chatre@intel.com>
References: <797e4e1de4e4fcdf5b5e0039354d6a28079e2015.1529706536.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Associate mode with each RDT
 resource group
Git-Commit-ID: 472ef09b40c5802a2e014ae2503ad8619486f9e6
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  472ef09b40c5802a2e014ae2503ad8619486f9e6
Gitweb:     https://git.kernel.org/tip/472ef09b40c5802a2e014ae2503ad8619486f9e6
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Fri, 22 Jun 2018 15:41:55 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 23 Jun 2018 13:03:41 +0200

x86/intel_rdt: Associate mode with each RDT resource group

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
Link: https://lkml.kernel.org/r/797e4e1de4e4fcdf5b5e0039354d6a28079e2015.1529706536.git.reinette.chatre@intel.com

---
 arch/x86/kernel/cpu/intel_rdt.h          |  3 +++
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index fef254e85da4..482dd6d3b8c5 100644
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
index fa668f967062..4a72061df7cd 100644
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
@@ -1491,6 +1512,7 @@ static void rdt_kill_sb(struct super_block *sb)
 		reset_all_ctrls(r);
 	cdp_disable_all();
 	rmdir_all_sub();
+	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
 	static_branch_disable_cpuslocked(&rdt_alloc_enable_key);
 	static_branch_disable_cpuslocked(&rdt_mon_enable_key);
 	static_branch_disable_cpuslocked(&rdt_enable_key);

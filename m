Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27104C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB72E20693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB72E20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754268AbeFTA0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 20:26:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59365 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753011AbeFTA0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 20:26:52 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5K0Qlrc3299548
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 19 Jun 2018 17:26:47 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5K0Ql393299545;
        Tue, 19 Jun 2018 17:26:47 -0700
Date:   Tue, 19 Jun 2018 17:26:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-fb3800795098d56468f755368f3cbc08da39dde1@git.kernel.org>
Cc:     reinette.chatre@intel.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de
Reply-To: mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com,
          linux-kernel@vger.kernel.org, reinette.chatre@intel.com
In-Reply-To: <cf83951ef28f138aeb9a9242cd074a6e01a1fbb2.1527593971.git.reinette.chatre@intel.com>
References: <cf83951ef28f138aeb9a9242cd074a6e01a1fbb2.1527593971.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Split resource group removal in two
Git-Commit-ID: fb3800795098d56468f755368f3cbc08da39dde1
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

Commit-ID:  fb3800795098d56468f755368f3cbc08da39dde1
Gitweb:     https://git.kernel.org/tip/fb3800795098d56468f755368f3cbc08da39dde1
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Tue, 29 May 2018 05:57:51 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 20 Jun 2018 00:56:36 +0200

x86/intel_rdt: Split resource group removal in two

Resource groups used for pseudo-locking do not require the same work on
removal as the other resource groups.

The resource group removal is split in two in preparation for support of
pseudo-locking resource groups. A single re-ordering occurs - the
setting of the rdtgrp flag is moved to later. This flag is not used by
any of the code between its original and new location.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/cf83951ef28f138aeb9a9242cd074a6e01a1fbb2.1527593971.git.reinette.chatre@intel.com

---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 8f50914dc45e..5a197cdb8ab4 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -2612,6 +2612,21 @@ static int rdtgroup_rmdir_mon(struct kernfs_node *kn, struct rdtgroup *rdtgrp,
 	return 0;
 }
 
+static int rdtgroup_ctrl_remove(struct kernfs_node *kn,
+				struct rdtgroup *rdtgrp)
+{
+	rdtgrp->flags = RDT_DELETED;
+	list_del(&rdtgrp->rdtgroup_list);
+
+	/*
+	 * one extra hold on this, will drop when we kfree(rdtgrp)
+	 * in rdtgroup_kn_unlock()
+	 */
+	kernfs_get(kn);
+	kernfs_remove(rdtgrp->kn);
+	return 0;
+}
+
 static int rdtgroup_rmdir_ctrl(struct kernfs_node *kn, struct rdtgroup *rdtgrp,
 			       cpumask_var_t tmpmask)
 {
@@ -2637,7 +2652,6 @@ static int rdtgroup_rmdir_ctrl(struct kernfs_node *kn, struct rdtgroup *rdtgrp,
 	cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
 	update_closid_rmid(tmpmask, NULL);
 
-	rdtgrp->flags = RDT_DELETED;
 	closid_free(rdtgrp->closid);
 	free_rmid(rdtgrp->mon.rmid);
 
@@ -2646,14 +2660,7 @@ static int rdtgroup_rmdir_ctrl(struct kernfs_node *kn, struct rdtgroup *rdtgrp,
 	 */
 	free_all_child_rdtgrp(rdtgrp);
 
-	list_del(&rdtgrp->rdtgroup_list);
-
-	/*
-	 * one extra hold on this, will drop when we kfree(rdtgrp)
-	 * in rdtgroup_kn_unlock()
-	 */
-	kernfs_get(kn);
-	kernfs_remove(rdtgrp->kn);
+	rdtgroup_ctrl_remove(kn, rdtgrp);
 
 	return 0;
 }

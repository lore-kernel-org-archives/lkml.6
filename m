Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D9DC43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47FDE24BD4
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47FDE24BD4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752249AbeFWMVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 08:21:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45563 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751654AbeFWMVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 08:21:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5NCL5Bt465224
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 23 Jun 2018 05:21:05 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5NCL5Mi465221;
        Sat, 23 Jun 2018 05:21:05 -0700
Date:   Sat, 23 Jun 2018 05:21:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-17eafd076291ed23eeb17b28132fa33b0688bc57@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        hpa@zytor.com, reinette.chatre@intel.com
Reply-To: reinette.chatre@intel.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de
In-Reply-To: <c8cbf7a7c72480b39bb946a929dbae96c0f9aca1.1529706536.git.reinette.chatre@intel.com>
References: <c8cbf7a7c72480b39bb946a929dbae96c0f9aca1.1529706536.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Split resource group removal in two
Git-Commit-ID: 17eafd076291ed23eeb17b28132fa33b0688bc57
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

Commit-ID:  17eafd076291ed23eeb17b28132fa33b0688bc57
Gitweb:     https://git.kernel.org/tip/17eafd076291ed23eeb17b28132fa33b0688bc57
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Fri, 22 Jun 2018 15:42:18 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 23 Jun 2018 13:03:48 +0200

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
Link: https://lkml.kernel.org/r/c8cbf7a7c72480b39bb946a929dbae96c0f9aca1.1529706536.git.reinette.chatre@intel.com

---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index bd4e2de303dc..526cd4a97054 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -2620,6 +2620,21 @@ static int rdtgroup_rmdir_mon(struct kernfs_node *kn, struct rdtgroup *rdtgrp,
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
@@ -2645,7 +2660,6 @@ static int rdtgroup_rmdir_ctrl(struct kernfs_node *kn, struct rdtgroup *rdtgrp,
 	cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
 	update_closid_rmid(tmpmask, NULL);
 
-	rdtgrp->flags = RDT_DELETED;
 	closid_free(rdtgrp->closid);
 	free_rmid(rdtgrp->mon.rmid);
 
@@ -2654,14 +2668,7 @@ static int rdtgroup_rmdir_ctrl(struct kernfs_node *kn, struct rdtgroup *rdtgrp,
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

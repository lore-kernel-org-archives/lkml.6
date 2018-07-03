Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708E8C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6B521468
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:44:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C6B521468
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754408AbeGCGok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:44:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43089 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751760AbeGCGoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:44:39 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w636iYqr184225
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 2 Jul 2018 23:44:34 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w636iYYs184222;
        Mon, 2 Jul 2018 23:44:34 -0700
Date:   Mon, 2 Jul 2018 23:44:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-33dc3e410a0d99f394905143b26d34f1fd64c962@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        reinette.chatre@intel.com, tglx@linutronix.de, hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org,
          reinette.chatre@intel.com, hpa@zytor.com, tglx@linutronix.de
In-Reply-To: <12756b7963b6abc1bffe8fb560b87b75da827bd1.1530421961.git.reinette.chatre@intel.com>
References: <12756b7963b6abc1bffe8fb560b87b75da827bd1.1530421961.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Make CPU information accessible for
 pseudo-locked regions
Git-Commit-ID: 33dc3e410a0d99f394905143b26d34f1fd64c962
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

Commit-ID:  33dc3e410a0d99f394905143b26d34f1fd64c962
Gitweb:     https://git.kernel.org/tip/33dc3e410a0d99f394905143b26d34f1fd64c962
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Sat, 30 Jun 2018 22:17:33 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 3 Jul 2018 08:38:40 +0200

x86/intel_rdt: Make CPU information accessible for pseudo-locked regions

When a resource group enters pseudo-locksetup mode it reflects that the
platform supports cache pseudo-locking and the resource group is unused,
ready to be used for a pseudo-locked region. Until it is set up as a
pseudo-locked region the resource group is "locked down" such that no new
tasks or cpus can be assigned to it. This is accomplished in a user visible
way by making the cpus, cpus_list, and tasks resctrl files inaccassible
(user cannot read from or write to these files).

When the resource group changes to pseudo-locked mode it represents a cache
pseudo-locked region. While not appropriate to make any changes to the cpus
assigned to this region it is useful to make it easy for the user to see
which cpus are associated with the pseudo-locked region.

Modify the permissions of the cpus/cpus_list file when the resource group
changes to pseudo-locked mode to support reading (not writing).  The
information presented to the user when reading the file are the cpus
associated with the pseudo-locked region.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/12756b7963b6abc1bffe8fb560b87b75da827bd1.1530421961.git.reinette.chatre@intel.com

---
 Documentation/x86/intel_rdt_ui.txt          | 3 +++
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 3 +++
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c    | 8 ++++++--
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/x86/intel_rdt_ui.txt b/Documentation/x86/intel_rdt_ui.txt
index acac30b67c62..f662d3c530e5 100644
--- a/Documentation/x86/intel_rdt_ui.txt
+++ b/Documentation/x86/intel_rdt_ui.txt
@@ -178,6 +178,9 @@ All groups contain the following files:
 	CPUs to/from this group. As with the tasks file a hierarchy is
 	maintained where MON groups may only include CPUs owned by the
 	parent CTRL_MON group.
+	When the resouce group is in pseudo-locked mode this file will
+	only be readable, reflecting the CPUs associated with the
+	pseudo-locked region.
 
 
 "cpus_list":
diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index 5dfe4008c58f..751c78f9992f 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -1303,6 +1303,9 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
 
 	rdtgrp->mode = RDT_MODE_PSEUDO_LOCKED;
 	closid_free(rdtgrp->closid);
+	rdtgroup_kn_mode_restore(rdtgrp, "cpus", 0444);
+	rdtgroup_kn_mode_restore(rdtgrp, "cpus_list", 0444);
+
 	ret = 0;
 	goto out;
 
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index c20b51afd62d..d6d7ea7349d0 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -265,8 +265,12 @@ static int rdtgroup_cpus_show(struct kernfs_open_file *of,
 	rdtgrp = rdtgroup_kn_lock_live(of->kn);
 
 	if (rdtgrp) {
-		seq_printf(s, is_cpu_list(of) ? "%*pbl\n" : "%*pb\n",
-			   cpumask_pr_args(&rdtgrp->cpu_mask));
+		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED)
+			seq_printf(s, is_cpu_list(of) ? "%*pbl\n" : "%*pb\n",
+				   cpumask_pr_args(&rdtgrp->plr->d->cpu_mask));
+		else
+			seq_printf(s, is_cpu_list(of) ? "%*pbl\n" : "%*pb\n",
+				   cpumask_pr_args(&rdtgrp->cpu_mask));
 	} else {
 		ret = -ENOENT;
 	}

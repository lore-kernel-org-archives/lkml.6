Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FBCC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 05:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6624D2523B
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 05:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6624D2523B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752088AbeGAFSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 01:18:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:16836 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751708AbeGAFRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 01:17:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jun 2018 22:17:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,293,1526367600"; 
   d="scan'208";a="54226739"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga006.jf.intel.com with ESMTP; 30 Jun 2018 22:17:50 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH 2/2] x86/intel_rdt: cpu information accessible for pseudo-locked regions
Date:   Sat, 30 Jun 2018 22:17:33 -0700
Message-Id: <12756b7963b6abc1bffe8fb560b87b75da827bd1.1530421961.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1530421961.git.reinette.chatre@intel.com>
References: <cover.1530421961.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1530421961.git.reinette.chatre@intel.com>
References: <cover.1530421961.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a resource group enters pseudo-locksetup mode it reflects that the
platform supports cache pseudo-locking and the resource group is unused,
ready to be used for a pseudo-locked region. Until it is set up as a
pseudo-locked region the resource group is "locked down" such that no
new tasks or cpus can be assigned to it. This is accomplished in a user
visible way by making the cpus, cpus_list, and tasks resctrl files
inaccassible (user cannot read from or write to these files).

When the resource group changes to pseudo-locked mode it represents a
cache pseudo-locked region. While not appropriate to make any changes to
the cpus assigned to this region it is useful to make it easy for the
user to see which cpus are associated with the pseudo-locked region.

Modify the permissions of the cpus/cpus_list file when the resource
group changes to pseudo-locked mode to support reading (not writing).
The information presented to the user when reading the file are the cpus
associated with the pseudo-locked region.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
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
-- 
2.17.0


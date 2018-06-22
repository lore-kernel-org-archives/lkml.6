Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDB2C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A8824969
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A8824969
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934051AbeFVWnB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 18:43:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:52514 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933839AbeFVWmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 18:42:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2018 15:42:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,259,1526367600"; 
   d="scan'208";a="234843412"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga005.jf.intel.com with ESMTP; 22 Jun 2018 15:42:47 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V7 21/41] x86/intel_rdt: Protect against resource group changes during locking
Date:   Fri, 22 Jun 2018 15:42:12 -0700
Message-Id: <0c5cb006e81ead0b8bfff2df530c5d3017fd31d1.1529706536.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1529706536.git.reinette.chatre@intel.com>
References: <cover.1529706536.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1529706536.git.reinette.chatre@intel.com>
References: <cover.1529706536.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We intend to modify file permissions to make the "tasks", "cpus", and
"cpus_list" not accessible to the user when cache pseudo-locking in
progress. Even so, it is still possible for the user to force the file
permissions (using chmod) to make them writeable. Similarly, directory
permissions will be modified to prevent future monitor group creation but
the user can override these restrictions also.

Add additional checks to the files we intend to restrict to ensure that no
modifications from user space are attempted while setting up a
pseudo-locking or after a pseudo-locked region is set up.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/14b7a6e8ab2991130a98381d7075bb254e761050.1527593971.git.reinette.chatre@intel.com
---
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c | 10 +++++++
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c    | 32 ++++++++++++++++++---
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
index 0e6210a043f0..bc79396c5dad 100644
--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
@@ -283,6 +283,16 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 	}
 	rdt_last_cmd_clear();
 
+	/*
+	 * No changes to pseudo-locked region allowed. It has to be removed
+	 * and re-created instead.
+	 */
+	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED) {
+		ret = -EINVAL;
+		rdt_last_cmd_puts("resource group is pseudo-locked\n");
+		goto out;
+	}
+
 	for_each_alloc_enabled_rdt_resource(r) {
 		list_for_each_entry(dom, &r->domains, list)
 			dom->have_new_ctrl = false;
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index c17d5399b9f1..717f19035309 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -449,6 +449,13 @@ static ssize_t rdtgroup_cpus_write(struct kernfs_open_file *of,
 		goto unlock;
 	}
 
+	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED ||
+	    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
+		ret = -EINVAL;
+		rdt_last_cmd_puts("pseudo-locking in progress\n");
+		goto unlock;
+	}
+
 	if (is_cpu_list(of))
 		ret = cpulist_parse(buf, newmask);
 	else
@@ -651,13 +658,22 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
 	if (kstrtoint(strstrip(buf), 0, &pid) || pid < 0)
 		return -EINVAL;
 	rdtgrp = rdtgroup_kn_lock_live(of->kn);
+	if (!rdtgrp) {
+		rdtgroup_kn_unlock(of->kn);
+		return -ENOENT;
+	}
 	rdt_last_cmd_clear();
 
-	if (rdtgrp)
-		ret = rdtgroup_move_task(pid, rdtgrp, of);
-	else
-		ret = -ENOENT;
+	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED ||
+	    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
+		ret = -EINVAL;
+		rdt_last_cmd_puts("pseudo-locking in progress\n");
+		goto unlock;
+	}
+
+	ret = rdtgroup_move_task(pid, rdtgrp, of);
 
+unlock:
 	rdtgroup_kn_unlock(of->kn);
 
 	return ret ?: nbytes;
@@ -2324,6 +2340,14 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
 		goto out_unlock;
 	}
 
+	if (rtype == RDTMON_GROUP &&
+	    (prdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP ||
+	     prdtgrp->mode == RDT_MODE_PSEUDO_LOCKED)) {
+		ret = -EINVAL;
+		rdt_last_cmd_puts("pseudo-locking in progress\n");
+		goto out_unlock;
+	}
+
 	/* allocate the rdtgroup. */
 	rdtgrp = kzalloc(sizeof(*rdtgrp), GFP_KERNEL);
 	if (!rdtgrp) {
-- 
2.17.0


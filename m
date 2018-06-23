Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73036C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3336424BCB
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3336424BCB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752127AbeFWMRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 08:17:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51389 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751520AbeFWMRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 08:17:53 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5NCHmgd464575
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 23 Jun 2018 05:17:48 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5NCHmT8464572;
        Sat, 23 Jun 2018 05:17:48 -0700
Date:   Sat, 23 Jun 2018 05:17:48 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-c966dac8a5ede5d5f9b730512d8bdbcec307fe38@git.kernel.org>
Cc:     mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, reinette.chatre@intel.com
Reply-To: reinette.chatre@intel.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org
In-Reply-To: <0c5cb006e81ead0b8bfff2df530c5d3017fd31d1.1529706536.git.reinette.chatre@intel.com>
References: <0c5cb006e81ead0b8bfff2df530c5d3017fd31d1.1529706536.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Protect against resource group
 changes during locking
Git-Commit-ID: c966dac8a5ede5d5f9b730512d8bdbcec307fe38
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

Commit-ID:  c966dac8a5ede5d5f9b730512d8bdbcec307fe38
Gitweb:     https://git.kernel.org/tip/c966dac8a5ede5d5f9b730512d8bdbcec307fe38
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Fri, 22 Jun 2018 15:42:12 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 23 Jun 2018 13:03:46 +0200

x86/intel_rdt: Protect against resource group changes during locking

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
Link: https://lkml.kernel.org/r/0c5cb006e81ead0b8bfff2df530c5d3017fd31d1.1529706536.git.reinette.chatre@intel.com

---
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c | 10 +++++++++
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c    | 32 +++++++++++++++++++++++++----
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
index 08a412e0b47a..013cbfedc753 100644
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
@@ -2315,6 +2331,14 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
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

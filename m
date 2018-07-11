Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33010C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD04E20C0E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD04E20C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388073AbeGKUMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:12:16 -0400
Received: from mga03.intel.com ([134.134.136.65]:27511 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733070AbeGKUMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:12:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2018 13:06:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,338,1526367600"; 
   d="scan'208";a="66156806"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by fmsmga002.fm.intel.com with ESMTP; 11 Jul 2018 13:06:19 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH] x86/intel_rdt: Fix possible circular lock dependency
Date:   Wed, 11 Jul 2018 13:06:07 -0700
Message-Id: <fffb57f9c6b8285904c9a60cc91ce21591af17fe.1531332480.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lockdep is reporting a possible circular locking dependency:

 ======================================================
 WARNING: possible circular locking dependency detected
 4.18.0-rc1-test-test+ #4 Not tainted
 ------------------------------------------------------
 user_example/766 is trying to acquire lock:
 0000000073479a0f (rdtgroup_mutex){+.+.}, at: pseudo_lock_dev_mmap

 but task is already holding lock:
 000000001ef7a35b (&mm->mmap_sem){++++}, at: vm_mmap_pgoff+0x9f/0x

 which lock already depends on the new lock.

 the existing dependency chain (in reverse order) is:

 -> #2 (&mm->mmap_sem){++++}:
        _copy_to_user+0x1e/0x70
        filldir+0x91/0x100
        dcache_readdir+0x54/0x160
        iterate_dir+0x142/0x190
        __x64_sys_getdents+0xb9/0x170
        do_syscall_64+0x86/0x200
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

 -> #1 (&sb->s_type->i_mutex_key#3){++++}:
        start_creating+0x60/0x100
        debugfs_create_dir+0xc/0xc0
        rdtgroup_pseudo_lock_create+0x217/0x4d0
        rdtgroup_schemata_write+0x313/0x3d0
        kernfs_fop_write+0xf0/0x1a0
        __vfs_write+0x36/0x190
        vfs_write+0xb7/0x190
        ksys_write+0x52/0xc0
        do_syscall_64+0x86/0x200
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

 -> #0 (rdtgroup_mutex){+.+.}:
        __mutex_lock+0x80/0x9b0
        pseudo_lock_dev_mmap+0x2f/0x170
        mmap_region+0x3d6/0x610
        do_mmap+0x387/0x580
        vm_mmap_pgoff+0xcf/0x110
        ksys_mmap_pgoff+0x170/0x1f0
        do_syscall_64+0x86/0x200
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

 other info that might help us debug this:

 Chain exists of:
   rdtgroup_mutex --> &sb->s_type->i_mutex_key#3 --> &mm->mmap_sem

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&mm->mmap_sem);
                                lock(&sb->s_type->i_mutex_key#3);
                                lock(&mm->mmap_sem);
   lock(rdtgroup_mutex);

  *** DEADLOCK ***

 1 lock held by user_example/766:
  #0: 000000001ef7a35b (&mm->mmap_sem){++++}, at: vm_mmap_pgoff+0x9f/0x110

rdtgroup_mutex is already being released temporarily during pseudo-lock
region creation to prevent the potential deadlock between rdtgroup_mutex
and mm->mmap_sem that is obtained during device_create(). Move the
debugfs creation into this area to avoid the same circular dependency.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 29 ++++++++++-----------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index 751c78f9992f..f80c58f8adc3 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -1254,19 +1254,10 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
 		goto out_cstates;
 	}
 
-	if (!IS_ERR_OR_NULL(debugfs_resctrl)) {
-		plr->debugfs_dir = debugfs_create_dir(rdtgrp->kn->name,
-						      debugfs_resctrl);
-		if (!IS_ERR_OR_NULL(plr->debugfs_dir))
-			debugfs_create_file("pseudo_lock_measure", 0200,
-					    plr->debugfs_dir, rdtgrp,
-					    &pseudo_measure_fops);
-	}
-
 	ret = pseudo_lock_minor_get(&new_minor);
 	if (ret < 0) {
 		rdt_last_cmd_puts("unable to obtain a new minor number\n");
-		goto out_debugfs;
+		goto out_cstates;
 	}
 
 	/*
@@ -1275,11 +1266,20 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
 	 *
 	 * The mutex has to be released temporarily to avoid a potential
 	 * deadlock with the mm->mmap_sem semaphore which is obtained in
-	 * the device_create() callpath below as well as before the mmap()
-	 * callback is called.
+	 * the device_create() and debugfs_create_dir() callpath below
+	 * as well as before the mmap() callback is called.
 	 */
 	mutex_unlock(&rdtgroup_mutex);
 
+	if (!IS_ERR_OR_NULL(debugfs_resctrl)) {
+		plr->debugfs_dir = debugfs_create_dir(rdtgrp->kn->name,
+						      debugfs_resctrl);
+		if (!IS_ERR_OR_NULL(plr->debugfs_dir))
+			debugfs_create_file("pseudo_lock_measure", 0200,
+					    plr->debugfs_dir, rdtgrp,
+					    &pseudo_measure_fops);
+	}
+
 	dev = device_create(pseudo_lock_class, NULL,
 			    MKDEV(pseudo_lock_major, new_minor),
 			    rdtgrp, "%s", rdtgrp->kn->name);
@@ -1290,7 +1290,7 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
 		ret = PTR_ERR(dev);
 		rdt_last_cmd_printf("failed to create character device: %d\n",
 				    ret);
-		goto out_minor;
+		goto out_debugfs;
 	}
 
 	/* We released the mutex - check if group was removed while we did so */
@@ -1311,10 +1311,9 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
 
 out_device:
 	device_destroy(pseudo_lock_class, MKDEV(pseudo_lock_major, new_minor));
-out_minor:
-	pseudo_lock_minor_release(new_minor);
 out_debugfs:
 	debugfs_remove_recursive(plr->debugfs_dir);
+	pseudo_lock_minor_release(new_minor);
 out_cstates:
 	pseudo_lock_cstates_relax(plr);
 out_region:
-- 
2.17.0


Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82D6ECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 19:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3F320841
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 19:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C3F320841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbeGLTsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 15:48:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60423 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbeGLTsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 15:48:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6CJas4n4025646
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 12 Jul 2018 12:36:54 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6CJasiv4025643;
        Thu, 12 Jul 2018 12:36:54 -0700
Date:   Thu, 12 Jul 2018 12:36:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-2989360d9c6669d8ae64edc933088e640481b48b@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@kernel.org,
        reinette.chatre@intel.com, hpa@zytor.com
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
          reinette.chatre@intel.com, mingo@kernel.org
In-Reply-To: <fffb57f9c6b8285904c9a60cc91ce21591af17fe.1531332480.git.reinette.chatre@intel.com>
References: <fffb57f9c6b8285904c9a60cc91ce21591af17fe.1531332480.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Fix possible circular lock
 dependency
Git-Commit-ID: 2989360d9c6669d8ae64edc933088e640481b48b
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

Commit-ID:  2989360d9c6669d8ae64edc933088e640481b48b
Gitweb:     https://git.kernel.org/tip/2989360d9c6669d8ae64edc933088e640481b48b
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Wed, 11 Jul 2018 13:06:07 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 12 Jul 2018 21:33:43 +0200

x86/intel_rdt: Fix possible circular lock dependency

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
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/fffb57f9c6b8285904c9a60cc91ce21591af17fe.1531332480.git.reinette.chatre@intel.com

---
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 29 ++++++++++++++---------------
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

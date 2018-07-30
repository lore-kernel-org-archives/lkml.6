Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33424FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2EE120873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2EE120873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbeG3Ipa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 04:45:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53270 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726344AbeG3Ipa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 04:45:30 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 651297C6A9;
        Mon, 30 Jul 2018 07:11:55 +0000 (UTC)
Received: from rhel3.localdomain (ovpn-12-81.pek2.redhat.com [10.72.12.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F2A02156701;
        Mon, 30 Jul 2018 07:11:53 +0000 (UTC)
From:   xiubli@redhat.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     mchristi@redhat.com
Subject: [PATCH] uio: fix possible circular locking dependency
Date:   Mon, 30 Jul 2018 03:11:48 -0400
Message-Id: <1532934708-101561-1-git-send-email-xiubli@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 30 Jul 2018 07:11:55 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 30 Jul 2018 07:11:55 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'xiubli@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

The call trace:
XXX/1910 is trying to acquire lock:
 (&mm->mmap_sem){++++++}, at: [<ffffffff97008c87>] might_fault+0x57/0xb0

but task is already holding lock:
 (&idev->info_lock){+.+...}, at: [<ffffffffc0638a06>] uio_write+0x46/0x130 [uio]

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (&idev->info_lock){+.+...}:
       [<ffffffff96f31fc9>] lock_acquire+0x99/0x1e0
       [<ffffffff975edad3>] mutex_lock_nested+0x93/0x410
       [<ffffffffc063873d>] uio_mmap+0x2d/0x170 [uio]
       [<ffffffff97016b58>] mmap_region+0x428/0x650
       [<ffffffff97017138>] do_mmap+0x3b8/0x4e0
       [<ffffffff96ffaba3>] vm_mmap_pgoff+0xd3/0x120
       [<ffffffff97015261>] SyS_mmap_pgoff+0x1f1/0x270
       [<ffffffff96e387c2>] SyS_mmap+0x22/0x30
       [<ffffffff975ff315>] system_call_fastpath+0x1c/0x21

-> #0 (&mm->mmap_sem){++++++}:
       [<ffffffff96f30e9c>] __lock_acquire+0xdac/0x15f0
       [<ffffffff96f31fc9>] lock_acquire+0x99/0x1e0
       [<ffffffff97008cb4>] might_fault+0x84/0xb0
       [<ffffffffc0638a74>] uio_write+0xb4/0x130 [uio]
       [<ffffffff9706ffa3>] vfs_write+0xc3/0x1f0
       [<ffffffff97070e2a>] SyS_write+0x8a/0x100
       [<ffffffff975ff315>] system_call_fastpath+0x1c/0x21

other info that might help us debug this:
 Possible unsafe locking scenario:
       CPU0                    CPU1
       ----                    ----
  lock(&idev->info_lock);
                               lock(&mm->mmap_sem);
                               lock(&idev->info_lock);
  lock(&mm->mmap_sem);

 *** DEADLOCK ***
1 lock held by XXX/1910:
 #0:  (&idev->info_lock){+.+...}, at: [<ffffffffc0638a06>] uio_write+0x46/0x130 [uio]

stack backtrace:
CPU: 0 PID: 1910 Comm: XXX Kdump: loaded Not tainted #1
Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 05/19/2017
Call Trace:
 [<ffffffff975e9211>] dump_stack+0x19/0x1b
 [<ffffffff975e260a>] print_circular_bug+0x1f9/0x207
 [<ffffffff96f2f6a7>] check_prevs_add+0x957/0x960
 [<ffffffff96f30e9c>] __lock_acquire+0xdac/0x15f0
 [<ffffffff96f2fb19>] ? mark_held_locks+0xb9/0x140
 [<ffffffff96f31fc9>] lock_acquire+0x99/0x1e0
 [<ffffffff97008c87>] ? might_fault+0x57/0xb0
 [<ffffffff97008cb4>] might_fault+0x84/0xb0
 [<ffffffff97008c87>] ? might_fault+0x57/0xb0
 [<ffffffffc0638a74>] uio_write+0xb4/0x130 [uio]
 [<ffffffff9706ffa3>] vfs_write+0xc3/0x1f0
 [<ffffffff9709349c>] ? fget_light+0xfc/0x510
 [<ffffffff97070e2a>] SyS_write+0x8a/0x100
 [<ffffffff975ff315>] system_call_fastpath+0x1c/0x21

Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 drivers/uio/uio.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 5d421d7..7b5daba 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -625,6 +625,12 @@ static ssize_t uio_write(struct file *filep, const char __user *buf,
 	ssize_t retval;
 	s32 irq_on;
 
+	if (count != sizeof(s32))
+		return -EINVAL;
+
+	if (copy_from_user(&irq_on, buf, count))
+		return -EFAULT;
+
 	mutex_lock(&idev->info_lock);
 	if (!idev->info) {
 		retval = -EINVAL;
@@ -636,21 +642,11 @@ static ssize_t uio_write(struct file *filep, const char __user *buf,
 		goto out;
 	}
 
-	if (count != sizeof(s32)) {
-		retval = -EINVAL;
-		goto out;
-	}
-
 	if (!idev->info->irqcontrol) {
 		retval = -ENOSYS;
 		goto out;
 	}
 
-	if (copy_from_user(&irq_on, buf, count)) {
-		retval = -EFAULT;
-		goto out;
-	}
-
 	retval = idev->info->irqcontrol(idev->info, irq_on);
 
 out:
-- 
1.8.3.1


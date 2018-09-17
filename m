Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2C4ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4967214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4967214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732425AbeIRElG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:41:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50570 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731765AbeIRElF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:41:05 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0BAC7707;
        Mon, 17 Sep 2018 23:11:32 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiubo Li <xiubli@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 074/158] uio: fix possible circular locking dependency
Date:   Tue, 18 Sep 2018 00:41:44 +0200
Message-Id: <20180917211714.682812666@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xiubo Li <xiubli@redhat.com>

[ Upstream commit b34e9a15b37b8ddbf06a4da142b0c39c74211eb4 ]

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/uio/uio.c |   16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -622,6 +622,12 @@ static ssize_t uio_write(struct file *fi
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
@@ -633,21 +639,11 @@ static ssize_t uio_write(struct file *fi
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



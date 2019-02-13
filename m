Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A464C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 218E120811
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083331;
	bh=Dn9PSI0wYJpmUUWNDjM7QLj3G/oB3jy1Qpk5nEOC+Ro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jxKbIBRGs82ACIrki3gibNNexkDpnL8YnWU8/w8mqd27IvWn6hb7LKxy46qk1onUn
	 mhx6cbxNZ0aOcSoI3Qa3cmeuzmhBPN1iKmjs6sKrHzq7yr8ypTzvZqLES5HRfFkCIB
	 CxUWmWA2rn6VkvVH5RZGia9z217nP0YEXK/UouTs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405592AbfBMSmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:42:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:40612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405578AbfBMSmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:42:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25F90222D5;
        Wed, 13 Feb 2019 18:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083325;
        bh=Dn9PSI0wYJpmUUWNDjM7QLj3G/oB3jy1Qpk5nEOC+Ro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iyEAsXsNW+tZEr0BE69/u1iyugBBNbuiy4KFTBg3T2t57HEynDWOWrAA1aMjLoXFB
         fVLnV2XHFDvacdwxCD+BcV0tfhC6faoFaWvf9qLs0BOFussbxHi+NS2qtJetSMUvSH
         nOPh+V/PPwwopQbzMNWiu+JdlenFFvjP4N3JzWWY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Xiubo Li <xiubli@redhat.com>,
        Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH 4.14 34/35] uio: fix possible circular locking dependency
Date:   Wed, 13 Feb 2019 19:38:29 +0100
Message-Id: <20190213183707.565347028@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183706.176685027@linuxfoundation.org>
References: <20190213183706.176685027@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xiubo Li <xiubli@redhat.com>

commit b34e9a15b37b8ddbf06a4da142b0c39c74211eb4 upstream.

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
Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/uio/uio.c |   16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -627,6 +627,12 @@ static ssize_t uio_write(struct file *fi
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
@@ -638,21 +644,11 @@ static ssize_t uio_write(struct file *fi
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



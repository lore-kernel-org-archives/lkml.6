Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9D7C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F192146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EiNY8igL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6F192146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733219AbeK3BdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:33:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:33396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731824AbeK3BdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:33:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65F1A2133F;
        Thu, 29 Nov 2018 14:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501649;
        bh=hKgTb9/F6g1je62aL9KVwQJfL/CJgMIbmO9zgTTZ/Yc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EiNY8igLm4VpX1IpOEcgEs0+MiK1B77w2WyjsPqWqh/sAN0TUKawMei83ubC8OXuk
         WoHyMFXA1TpHmISzok92dv3JPN/ywMDy+ZX/faRbNgFqQBftBHsJX23gY1PdN/0cLe
         rvq3nfFzCPoHFxYAm1KggrNZ4yTg2g6PKsCy7BWs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 051/100] floppy: fix race condition in __floppy_read_block_0()
Date:   Thu, 29 Nov 2018 15:12:21 +0100
Message-Id: <20181129140103.612671151@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140058.768942700@linuxfoundation.org>
References: <20181129140058.768942700@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit de7b75d82f70c5469675b99ad632983c50b6f7e7 ]

LKP recently reported a hang at bootup in the floppy code:

[  245.678853] INFO: task mount:580 blocked for more than 120 seconds.
[  245.679906]       Tainted: G                T 4.19.0-rc6-00172-ga9f38e1 #1
[  245.680959] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  245.682181] mount           D 6372   580      1 0x00000004
[  245.683023] Call Trace:
[  245.683425]  __schedule+0x2df/0x570
[  245.683975]  schedule+0x2d/0x80
[  245.684476]  schedule_timeout+0x19d/0x330
[  245.685090]  ? wait_for_common+0xa5/0x170
[  245.685735]  wait_for_common+0xac/0x170
[  245.686339]  ? do_sched_yield+0x90/0x90
[  245.686935]  wait_for_completion+0x12/0x20
[  245.687571]  __floppy_read_block_0+0xfb/0x150
[  245.688244]  ? floppy_resume+0x40/0x40
[  245.688844]  floppy_revalidate+0x20f/0x240
[  245.689486]  check_disk_change+0x43/0x60
[  245.690087]  floppy_open+0x1ea/0x360
[  245.690653]  __blkdev_get+0xb4/0x4d0
[  245.691212]  ? blkdev_get+0x1db/0x370
[  245.691777]  blkdev_get+0x1f3/0x370
[  245.692351]  ? path_put+0x15/0x20
[  245.692871]  ? lookup_bdev+0x4b/0x90
[  245.693539]  blkdev_get_by_path+0x3d/0x80
[  245.694165]  mount_bdev+0x2a/0x190
[  245.694695]  squashfs_mount+0x10/0x20
[  245.695271]  ? squashfs_alloc_inode+0x30/0x30
[  245.695960]  mount_fs+0xf/0x90
[  245.696451]  vfs_kern_mount+0x43/0x130
[  245.697036]  do_mount+0x187/0xc40
[  245.697563]  ? memdup_user+0x28/0x50
[  245.698124]  ksys_mount+0x60/0xc0
[  245.698639]  sys_mount+0x19/0x20
[  245.699167]  do_int80_syscall_32+0x61/0x130
[  245.699813]  entry_INT80_32+0xc7/0xc7

showing that we never complete that read request. The reason is that
the completion setup is racy - it initializes the completion event
AFTER submitting the IO, which means that the IO could complete
before/during the init. If it does, we are passing garbage to
complete() and we may sleep forever waiting for the event to
occur.

Fixes: 7b7b68bba5ef ("floppy: bail out in open() if drive is not responding to block0 read")
Reviewed-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/floppy.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 3d0287e212fe..a7f212ea17bf 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4146,10 +4146,11 @@ static int __floppy_read_block_0(struct block_device *bdev, int drive)
 	bio.bi_end_io = floppy_rb0_cb;
 	bio_set_op_attrs(&bio, REQ_OP_READ, 0);
 
+	init_completion(&cbdata.complete);
+
 	submit_bio(&bio);
 	process_fd_request();
 
-	init_completion(&cbdata.complete);
 	wait_for_completion(&cbdata.complete);
 
 	__free_page(page);
-- 
2.17.1




Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B11C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F08218F0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbfBCNuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:50:35 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53686 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728323AbfBCNt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:58 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9k-0003to-Hj; Sun, 03 Feb 2019 13:49:56 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9f-0007A2-Ey; Sun, 03 Feb 2019 14:49:51 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Jens Axboe" <axboe@kernel.dk>, "Omar Sandoval" <osandov@fb.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.87291872@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 182/305] floppy: fix race condition in
 __floppy_read_block_0()
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

commit de7b75d82f70c5469675b99ad632983c50b6f7e7 upstream.

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
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/block/floppy.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3819,10 +3819,11 @@ static int __floppy_read_block_0(struct
 	bio.bi_private = &cbdata;
 	bio.bi_end_io = floppy_rb0_cb;
 
+	init_completion(&cbdata.complete);
+
 	submit_bio(READ, &bio);
 	process_fd_request();
 
-	init_completion(&cbdata.complete);
 	wait_for_completion(&cbdata.complete);
 
 	__free_page(page);


Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA012C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5872184B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217773;
	bh=LE1Di3SxB5ExhGbspW9AAj8GtPuEF83SGNSxZ7p4nmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Virw9NsuGKSiJGK97C/rZ+wXhQ83VTMDtPEVWoTJ5uMRdGsQRKMTJSyZvlQashuBK
	 4chqZI07hi/3nm7oOd1+EByisXfUosDZwX/Gew2+vGRaSAEYd08+Hqrpa1J4A1akfy
	 74cKp3q7CDw8SGaMQnkMRpF1qrm52UQ9WZqYKTNg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404259AbfAKOmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:42:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:35534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403847AbfAKOmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:42:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DCAD2063F;
        Fri, 11 Jan 2019 14:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217765;
        bh=LE1Di3SxB5ExhGbspW9AAj8GtPuEF83SGNSxZ7p4nmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j+s2++qOYfzDU9+tpiaLTG6NyDUDMeYcG3XGWMKuiemUXzMWo3x8syj2CPRtQplm5
         RPI66NGqKTDC5r04Q70hKwFiHLnnWtpTQhI3aGXKt+7jmnnRdbxWEZc3o/44QqoavQ
         14/y67h5+PXVpnfP9P3oRQDP7Vvw6juu9fedr0TI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Joey Pabalinas <joeypabalinas@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.20 04/65] zram: fix double free backing device
Date:   Fri, 11 Jan 2019 15:14:50 +0100
Message-Id: <20190111131056.679232043@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131055.331350141@linuxfoundation.org>
References: <20190111131055.331350141@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Minchan Kim <minchan@kernel.org>

commit 5547932dc67a48713eece4fa4703bfdf0cfcb818 upstream.

If blkdev_get fails, we shouldn't do blkdev_put.  Otherwise, kernel emits
below log.  This patch fixes it.

  WARNING: CPU: 0 PID: 1893 at fs/block_dev.c:1828 blkdev_put+0x105/0x120
  Modules linked in:
  CPU: 0 PID: 1893 Comm: swapoff Not tainted 4.19.0+ #453
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
  RIP: 0010:blkdev_put+0x105/0x120
  Call Trace:
    __x64_sys_swapoff+0x46d/0x490
    do_syscall_64+0x5a/0x190
    entry_SYSCALL_64_after_hwframe+0x49/0xbe
  irq event stamp: 4466
  hardirqs last  enabled at (4465):  __free_pages_ok+0x1e3/0x490
  hardirqs last disabled at (4466):  trace_hardirqs_off_thunk+0x1a/0x1c
  softirqs last  enabled at (3420):  __do_softirq+0x333/0x446
  softirqs last disabled at (3407):  irq_exit+0xd1/0xe0

Link: http://lkml.kernel.org/r/20181127055429.251614-3-minchan@kernel.org
Signed-off-by: Minchan Kim <minchan@kernel.org>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Reviewed-by: Joey Pabalinas <joeypabalinas@gmail.com>
Cc: <stable@vger.kernel.org>	[4.14+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/zram/zram_drv.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -382,8 +382,10 @@ static ssize_t backing_dev_store(struct
 
 	bdev = bdgrab(I_BDEV(inode));
 	err = blkdev_get(bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL, zram);
-	if (err < 0)
+	if (err < 0) {
+		bdev = NULL;
 		goto out;
+	}
 
 	nr_pages = i_size_read(inode) >> PAGE_SHIFT;
 	bitmap_sz = BITS_TO_LONGS(nr_pages) * sizeof(long);



Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D087C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61FE225586
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:06:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61FE225586
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753674AbeGAREk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:04:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37660 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032211AbeGAQmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:42:37 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2E106AA6;
        Sun,  1 Jul 2018 16:42:37 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Luis Henriques <lhenriques@suse.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.17 132/220] scsi: scsi_debug: Fix memory leak on module unload
Date:   Sun,  1 Jul 2018 18:22:36 +0200
Message-Id: <20180701160913.836770119@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luis Henriques <lhenriques@suse.com>

commit 52ab9768f723823a71dc659f0fad803a90f80236 upstream.

Since commit 80c49563e250 ("scsi: scsi_debug: implement IMMED bit") there
are long delays in F_SYNC_DELAY and F_SSU_DELAY.  This can cause a memory
leak in schedule_resp(), which can be invoked while unloading the
scsi_debug module: free_all_queued() had already freed all sd_dp and
schedule_resp will alloc a new one, which will never get freed.  Here's the
kmemleak report while running xfstests generic/350:

unreferenced object 0xffff88007d752b00 (size 128):
  comm "rmmod", pid 26940, jiffies 4295816945 (age 7.588s)
  hex dump (first 32 bytes):
    00 2b 75 7d 00 88 ff ff 00 00 00 00 00 00 00 00  .+u}............
    00 00 00 00 00 00 00 00 8e 31 a2 34 5f 03 00 00  .........1.4_...
  backtrace:
    [<000000002abd83d0>] 0xffffffffa000705e
    [<000000004c063fda>] scsi_dispatch_cmd+0xc7/0x1a0
    [<000000000c119a00>] scsi_request_fn+0x251/0x550
    [<000000009de0c736>] __blk_run_queue+0x3f/0x60
    [<000000001c4453c8>] blk_execute_rq_nowait+0x98/0xd0
    [<00000000d17ec79f>] blk_execute_rq+0x3a/0x50
    [<00000000a7654b6e>] scsi_execute+0x113/0x250
    [<00000000fd78f7cd>] sd_sync_cache+0x95/0x160
    [<0000000024dacb14>] sd_shutdown+0x9b/0xd0
    [<00000000e9101710>] sd_remove+0x5f/0xb0
    [<00000000c43f0d63>] device_release_driver_internal+0x13c/0x1f0
    [<00000000e8ad57b6>] bus_remove_device+0xe9/0x160
    [<00000000713a7b8a>] device_del+0x120/0x320
    [<00000000e5db670c>] __scsi_remove_device+0x115/0x150
    [<00000000eccbef30>] scsi_forget_host+0x20/0x60
    [<00000000cd5a0738>] scsi_remove_host+0x6d/0x120

Cc: stable@vger.kernel.org # v4.17+
Signed-off-by: Luis Henriques <lhenriques@suse.com>
Acked-by: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/scsi_debug.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -5506,9 +5506,9 @@ static void __exit scsi_debug_exit(void)
 	int k = sdebug_add_host;
 
 	stop_all_queued();
-	free_all_queued();
 	for (; k; k--)
 		sdebug_remove_adapter();
+	free_all_queued();
 	driver_unregister(&sdebug_driverfs_driver);
 	bus_unregister(&pseudo_lld_bus);
 	root_device_unregister(pseudo_primary);



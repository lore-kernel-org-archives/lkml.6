Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B59C282DB
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 843F9218D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbfBCNuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:50:50 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:54286 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728683AbfBCNu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:50:29 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIAF-0003tq-LB; Sun, 03 Feb 2019 13:50:27 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9t-0007Q8-0w; Sun, 03 Feb 2019 14:50:05 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Christoph Hellwig" <hch@lst.de>, "Jens Axboe" <axboe@kernel.dk>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.491524555@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 283/305] scsi: sd: use mempool for discard special page
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

commit 61cce6f6eeced5ddd9cac55e807fe28b4f18c1ba upstream.

When boxes are run near (or to) OOM, we have a problem with the discard
page allocation in sd. If we fail allocating the special page, we return
busy, and it'll get retried. But since ordering is honored for dispatch
requests, we can keep retrying this same IO and failing. Behind that IO
could be requests that want to free memory, but they never get the
chance. This means you get repeated spews of traces like this:

[1201401.625972] Call Trace:
[1201401.631748]  dump_stack+0x4d/0x65
[1201401.639445]  warn_alloc+0xec/0x190
[1201401.647335]  __alloc_pages_slowpath+0xe84/0xf30
[1201401.657722]  ? get_page_from_freelist+0x11b/0xb10
[1201401.668475]  ? __alloc_pages_slowpath+0x2e/0xf30
[1201401.679054]  __alloc_pages_nodemask+0x1f9/0x210
[1201401.689424]  alloc_pages_current+0x8c/0x110
[1201401.699025]  sd_setup_write_same16_cmnd+0x51/0x150
[1201401.709987]  sd_init_command+0x49c/0xb70
[1201401.719029]  scsi_setup_cmnd+0x9c/0x160
[1201401.727877]  scsi_queue_rq+0x4d9/0x610
[1201401.736535]  blk_mq_dispatch_rq_list+0x19a/0x360
[1201401.747113]  blk_mq_sched_dispatch_requests+0xff/0x190
[1201401.758844]  __blk_mq_run_hw_queue+0x95/0xa0
[1201401.768653]  blk_mq_run_work_fn+0x2c/0x30
[1201401.777886]  process_one_work+0x14b/0x400
[1201401.787119]  worker_thread+0x4b/0x470
[1201401.795586]  kthread+0x110/0x150
[1201401.803089]  ? rescuer_thread+0x320/0x320
[1201401.812322]  ? kthread_park+0x90/0x90
[1201401.820787]  ? do_syscall_64+0x53/0x150
[1201401.829635]  ret_from_fork+0x29/0x40

Ensure that the discard page allocation has a mempool backing, so we
know we can make progress.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
[bwh: Backported to 3.16: Only sd_setup_discard_cmnd() does page-allocation]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -129,6 +129,7 @@ static DEFINE_MUTEX(sd_ref_mutex);
 
 static struct kmem_cache *sd_cdb_cache;
 static mempool_t *sd_cdb_pool;
+static mempool_t *sd_page_pool;
 
 static const char *sd_cache_types[] = {
 	"write through", "none", "write back",
@@ -704,9 +705,10 @@ static int sd_setup_discard_cmnd(struct
 
 	memset(rq->cmd, 0, rq->cmd_len);
 
-	page = alloc_page(GFP_ATOMIC | __GFP_ZERO);
+	page = mempool_alloc(sd_page_pool, GFP_ATOMIC);
 	if (!page)
 		return BLKPREP_DEFER;
+	clear_highpage(page);
 
 	switch (sdkp->provisioning_mode) {
 	case SD_LBP_UNMAP:
@@ -758,7 +760,7 @@ static int sd_setup_discard_cmnd(struct
 
 out:
 	if (ret != BLKPREP_OK)
-		__free_page(page);
+		mempool_free(page, sd_page_pool);
 	return ret;
 }
 
@@ -3260,6 +3262,13 @@ static int __init init_sd(void)
 		goto err_out_cache;
 	}
 
+	sd_page_pool = mempool_create_page_pool(SD_MEMPOOL_SIZE, 0);
+	if (!sd_page_pool) {
+		printk(KERN_ERR "sd: can't init discard page pool\n");
+		err = -ENOMEM;
+		goto err_out_ppool;
+	}
+
 	err = scsi_register_driver(&sd_template.gendrv);
 	if (err)
 		goto err_out_driver;
@@ -3267,6 +3276,9 @@ static int __init init_sd(void)
 	return 0;
 
 err_out_driver:
+	mempool_destroy(sd_page_pool);
+
+err_out_ppool:
 	mempool_destroy(sd_cdb_pool);
 
 err_out_cache:
@@ -3293,6 +3305,7 @@ static void __exit exit_sd(void)
 
 	scsi_unregister_driver(&sd_template.gendrv);
 	mempool_destroy(sd_cdb_pool);
+	mempool_destroy(sd_page_pool);
 	kmem_cache_destroy(sd_cdb_cache);
 
 	class_unregister(&sd_disk_class);


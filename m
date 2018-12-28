Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A96C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B3F820675
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999604;
	bh=Liq8qazdZDIG7tH2JTdF8guvYol5TCVP2KHaBinCv0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p86CXMdavWTnUxfPfeEwwcZ9b2wvWGHpbRbqP0/CMzV3SdNGHYo/LN/jB/y2CXAg2
	 gZ5L31JyZM2r7H+lRlQVWinsQLHLzS5NC5JtapiAbKNMbG7lsxEFwQNuGy3GdshZGy
	 nik49zMnhrAmhUMrrR+ezmzIOP7/JqEQ/m6sXNHI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731240AbeL1MUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:20:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:35950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732783AbeL1MQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:16:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E154218F0;
        Fri, 28 Dec 2018 12:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999409;
        bh=Liq8qazdZDIG7tH2JTdF8guvYol5TCVP2KHaBinCv0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O5hpTspG1opRYC+Jf3gW9q/Xey8db8CAIcDdJieCBodyvksN7CiSov7wZ7RWFO2kA
         CXWJhFZGWRYngDvukeLLdDm0mC193E6+DS6ApPd4mKuvVB5qK++Rv1bpujKMNNwb4W
         ftQhT743Uhrv49+onQ7dgNkOBsFrk2dl9KeeLWBU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 16/36] scsi: sd: use mempool for discard special page
Date:   Fri, 28 Dec 2018 12:52:32 +0100
Message-Id: <20181228113127.705075534@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113126.526729877@linuxfoundation.org>
References: <20181228113126.526729877@linuxfoundation.org>
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

Cc: stable@vger.kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/sd.c |   23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -133,6 +133,7 @@ static DEFINE_MUTEX(sd_ref_mutex);
 
 static struct kmem_cache *sd_cdb_cache;
 static mempool_t *sd_cdb_pool;
+static mempool_t *sd_page_pool;
 
 static const char *sd_cache_types[] = {
 	"write through", "none", "write back",
@@ -759,9 +760,10 @@ static int sd_setup_unmap_cmnd(struct sc
 	unsigned int data_len = 24;
 	char *buf;
 
-	rq->special_vec.bv_page = alloc_page(GFP_ATOMIC | __GFP_ZERO);
+	rq->special_vec.bv_page = mempool_alloc(sd_page_pool, GFP_ATOMIC);
 	if (!rq->special_vec.bv_page)
 		return BLKPREP_DEFER;
+	clear_highpage(rq->special_vec.bv_page);
 	rq->special_vec.bv_offset = 0;
 	rq->special_vec.bv_len = data_len;
 	rq->rq_flags |= RQF_SPECIAL_PAYLOAD;
@@ -792,9 +794,10 @@ static int sd_setup_write_same16_cmnd(st
 	u32 nr_sectors = blk_rq_sectors(rq) >> (ilog2(sdp->sector_size) - 9);
 	u32 data_len = sdp->sector_size;
 
-	rq->special_vec.bv_page = alloc_page(GFP_ATOMIC | __GFP_ZERO);
+	rq->special_vec.bv_page = mempool_alloc(sd_page_pool, GFP_ATOMIC);
 	if (!rq->special_vec.bv_page)
 		return BLKPREP_DEFER;
+	clear_highpage(rq->special_vec.bv_page);
 	rq->special_vec.bv_offset = 0;
 	rq->special_vec.bv_len = data_len;
 	rq->rq_flags |= RQF_SPECIAL_PAYLOAD;
@@ -822,9 +825,10 @@ static int sd_setup_write_same10_cmnd(st
 	u32 nr_sectors = blk_rq_sectors(rq) >> (ilog2(sdp->sector_size) - 9);
 	u32 data_len = sdp->sector_size;
 
-	rq->special_vec.bv_page = alloc_page(GFP_ATOMIC | __GFP_ZERO);
+	rq->special_vec.bv_page = mempool_alloc(sd_page_pool, GFP_ATOMIC);
 	if (!rq->special_vec.bv_page)
 		return BLKPREP_DEFER;
+	clear_highpage(rq->special_vec.bv_page);
 	rq->special_vec.bv_offset = 0;
 	rq->special_vec.bv_len = data_len;
 	rq->rq_flags |= RQF_SPECIAL_PAYLOAD;
@@ -1299,7 +1303,7 @@ static void sd_uninit_command(struct scs
 		sd_zbc_write_unlock_zone(SCpnt);
 
 	if (rq->rq_flags & RQF_SPECIAL_PAYLOAD)
-		__free_page(rq->special_vec.bv_page);
+		mempool_free(rq->special_vec.bv_page, sd_page_pool);
 
 	if (SCpnt->cmnd != scsi_req(rq)->cmd) {
 		cmnd = SCpnt->cmnd;
@@ -3655,6 +3659,13 @@ static int __init init_sd(void)
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
@@ -3662,6 +3673,9 @@ static int __init init_sd(void)
 	return 0;
 
 err_out_driver:
+	mempool_destroy(sd_page_pool);
+
+err_out_ppool:
 	mempool_destroy(sd_cdb_pool);
 
 err_out_cache:
@@ -3688,6 +3702,7 @@ static void __exit exit_sd(void)
 
 	scsi_unregister_driver(&sd_template.gendrv);
 	mempool_destroy(sd_cdb_pool);
+	mempool_destroy(sd_page_pool);
 	kmem_cache_destroy(sd_cdb_cache);
 
 	class_unregister(&sd_disk_class);



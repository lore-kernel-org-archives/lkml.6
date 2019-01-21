Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51378C2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F82A2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079452;
	bh=JrKQi6eWSA72yLucNcMaDlmlvDPF/ZGhR4+XubhNSoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PgZZa7LQlf5PLSbHh/FwZgJof4F3LG9pAGVsV3uVYOloK6RfqErZj+CYpJ9beEFvk
	 EcMqGCkktWErBxEnsWYLCve0BBPVXG64bWavV8kSaRHfoTd+mKyp/mUp1vb5iZgJuR
	 EIdhcnOIWTR421TWSOUhWFR418HyUyRGWnw6/iAU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732787AbfAUOCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:02:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:49828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732774AbfAUOCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:02:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B3C42089F;
        Mon, 21 Jan 2019 14:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548079340;
        bh=JrKQi6eWSA72yLucNcMaDlmlvDPF/ZGhR4+XubhNSoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rcuf/VMy+4ElAxbBKFaeor0HAKZiqlAfacwWh3hgfv4cevoagV9Qd8eLRQs8AR0nB
         pUvg8gFg/ilnwcZZrjC6h4sgxZYBUyKrym4uFTEzEBaGHCnWRqavzfG4dCxu1OA2gV
         ser9kyTUyjmqNaHui/RvRJQOiF9kNNtfnRgCbeEM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.19 91/99] loop: Move special partition reread handling in loop_clr_fd()
Date:   Mon, 21 Jan 2019 14:49:23 +0100
Message-Id: <20190121134918.132836499@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121134913.924726465@linuxfoundation.org>
References: <20190121134913.924726465@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>

commit d57f3374ba4817f7c8d26fae8a13d20ac8d31b92 upstream.

The call of __blkdev_reread_part() from loop_reread_partition() happens
only when we need to invalidate partitions from loop_release(). Thus
move a detection for this into loop_clr_fd() and simplify
loop_reread_partition().

This makes loop_reread_partition() safe to use without loop_ctl_mutex
because we use only lo->lo_number and lo->lo_file_name in case of error
for reporting purposes (thus possibly reporting outdate information is
not a big deal) and we are safe from 'lo' going away under us by
elevated lo->lo_refcnt.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/loop.c |   33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -631,18 +631,7 @@ static void loop_reread_partitions(struc
 {
 	int rc;
 
-	/*
-	 * bd_mutex has been held already in release path, so don't
-	 * acquire it if this function is called in such case.
-	 *
-	 * If the reread partition isn't from release path, lo_refcnt
-	 * must be at least one and it can only become zero when the
-	 * current holder is released.
-	 */
-	if (!atomic_read(&lo->lo_refcnt))
-		rc = __blkdev_reread_part(bdev);
-	else
-		rc = blkdev_reread_part(bdev);
+	rc = blkdev_reread_part(bdev);
 	if (rc)
 		pr_warn("%s: partition scan of loop%d (%s) failed (rc=%d)\n",
 			__func__, lo->lo_number, lo->lo_file_name, rc);
@@ -1096,8 +1085,24 @@ static int __loop_clr_fd(struct loop_dev
 	module_put(THIS_MODULE);
 	blk_mq_unfreeze_queue(lo->lo_queue);
 
-	if (lo->lo_flags & LO_FLAGS_PARTSCAN && bdev)
-		loop_reread_partitions(lo, bdev);
+	if (lo->lo_flags & LO_FLAGS_PARTSCAN && bdev) {
+		/*
+		 * bd_mutex has been held already in release path, so don't
+		 * acquire it if this function is called in such case.
+		 *
+		 * If the reread partition isn't from release path, lo_refcnt
+		 * must be at least one and it can only become zero when the
+		 * current holder is released.
+		 */
+		if (!atomic_read(&lo->lo_refcnt))
+			err = __blkdev_reread_part(bdev);
+		else
+			err = blkdev_reread_part(bdev);
+		pr_warn("%s: partition scan of loop%d failed (rc=%d)\n",
+			__func__, lo->lo_number, err);
+		/* Device is gone, no point in returning error */
+		err = 0;
+	}
 	lo->lo_flags = 0;
 	if (!part_shift)
 		lo->lo_disk->flags |= GENHD_FL_NO_PART_SCAN;



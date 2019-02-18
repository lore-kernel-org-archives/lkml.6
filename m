Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0605CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B7A21901
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498203;
	bh=6+8eCPrMMsgOWUPSZkyKBmxhdsQ2I/LU4UQPABVGEYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QbSrwdmqa1BHH/GHWD4X84r7/Vua2MiYqAcPW9f4MFTBoj1MAZF79ZRRHgB/EyIls
	 qBHbWj2aoolDqKOwyFC+gNbRi8B4R4Vy8xEMRSwdIG+L9T3wGFLcXWXpa4uZyP3SXd
	 ++UC1Ia71BytdOIS17BFmzaaPcamR66mKINTQIN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387872AbfBRN4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:56:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:36902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733245AbfBRN4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:56:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBE06217D9;
        Mon, 18 Feb 2019 13:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498198;
        bh=6+8eCPrMMsgOWUPSZkyKBmxhdsQ2I/LU4UQPABVGEYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pnmbb9/a7wAIfj20s2J2nNzfAdK01qCACu6fJJ1QJ8tyAK0VJiiAi3Gra4pM0f/Vp
         CX3a+hpUkX9j7X0XQuI4fJfuBNAPd8HvX3t8jzIzf1JE2xVeAFfULul2TQ7sN29IZB
         KzYLmO8Q4nD9WrHwJJt2zXoKHceNpClKlZs65T/U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jack Wang <jinpu.wang@cloud.ionos.com>,
        Nate Dailey <nate.dailey@stratus.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 4.14 55/62] md/raid1: dont clear bitmap bits on interrupted recovery.
Date:   Mon, 18 Feb 2019 14:44:01 +0100
Message-Id: <20190218133510.482165160@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133505.801423074@linuxfoundation.org>
References: <20190218133505.801423074@linuxfoundation.org>
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

From: Nate Dailey <nate.dailey@stratus.com>

commit dfcc34c99f3ebc16b787b118763bf9cb6b1efc7a upstream.

sync_request_write no longer submits writes to a Faulty device. This has
the unfortunate side effect that bitmap bits can be incorrectly cleared
if a recovery is interrupted (previously, end_sync_write would have
prevented this). This means the next recovery may not copy everything
it should, potentially corrupting data.

Add a function for doing the proper md_bitmap_end_sync, called from
end_sync_write and the Faulty case in sync_request_write.

backport note to 4.14: s/md_bitmap_end_sync/bitmap_end_sync
Cc: stable@vger.kernel.org 4.14+
Fixes: 0c9d5b127f69 ("md/raid1: avoid reusing a resync bio after error handling.")
Reviewed-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Tested-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Nate Dailey <nate.dailey@stratus.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/raid1.c |   29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1854,6 +1854,20 @@ static void end_sync_read(struct bio *bi
 		reschedule_retry(r1_bio);
 }
 
+static void abort_sync_write(struct mddev *mddev, struct r1bio *r1_bio)
+{
+	sector_t sync_blocks = 0;
+	sector_t s = r1_bio->sector;
+	long sectors_to_go = r1_bio->sectors;
+
+	/* make sure these bits don't get cleared. */
+	do {
+		bitmap_end_sync(mddev->bitmap, s, &sync_blocks, 1);
+		s += sync_blocks;
+		sectors_to_go -= sync_blocks;
+	} while (sectors_to_go > 0);
+}
+
 static void end_sync_write(struct bio *bio)
 {
 	int uptodate = !bio->bi_status;
@@ -1865,16 +1879,7 @@ static void end_sync_write(struct bio *b
 	struct md_rdev *rdev = conf->mirrors[find_bio_disk(r1_bio, bio)].rdev;
 
 	if (!uptodate) {
-		sector_t sync_blocks = 0;
-		sector_t s = r1_bio->sector;
-		long sectors_to_go = r1_bio->sectors;
-		/* make sure these bits doesn't get cleared. */
-		do {
-			bitmap_end_sync(mddev->bitmap, s,
-					&sync_blocks, 1);
-			s += sync_blocks;
-			sectors_to_go -= sync_blocks;
-		} while (sectors_to_go > 0);
+		abort_sync_write(mddev, r1_bio);
 		set_bit(WriteErrorSeen, &rdev->flags);
 		if (!test_and_set_bit(WantReplacement, &rdev->flags))
 			set_bit(MD_RECOVERY_NEEDED, &
@@ -2164,8 +2169,10 @@ static void sync_request_write(struct md
 		     (i == r1_bio->read_disk ||
 		      !test_bit(MD_RECOVERY_SYNC, &mddev->recovery))))
 			continue;
-		if (test_bit(Faulty, &conf->mirrors[i].rdev->flags))
+		if (test_bit(Faulty, &conf->mirrors[i].rdev->flags)) {
+			abort_sync_write(mddev, r1_bio);
 			continue;
+		}
 
 		bio_set_op_attrs(wbio, REQ_OP_WRITE, 0);
 		if (test_bit(FailFast, &conf->mirrors[i].rdev->flags))



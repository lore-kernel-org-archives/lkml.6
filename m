Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1E5C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DEA320661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DEA320661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbeLIWIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:08:19 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37312 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727690AbeLIWIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:08:14 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73L-0002pp-EV; Sun, 09 Dec 2018 21:55:55 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72a-0003IE-S4; Sun, 09 Dec 2018 21:55:08 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Jens Axboe" <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Greg Edwards" <gedwards@ddn.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.648818470@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 076/328] block: move bio_integrity_{intervals,bytes}
 into blkdev.h
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Edwards <gedwards@ddn.com>

commit 359f642700f2ff05d9c94cd9216c97af7b8e9553 upstream.

This allows bio_integrity_bytes() to be called from drivers instead of
open coding it.

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Edwards <gedwards@ddn.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[bwh: Backported to 3.16: bio_integrity_intervals() was called
 bio_integrity_hw_sectors() and had a different implementation.  Move it
 without renaming.]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 block/bio-integrity.c  | 22 ----------------------
 include/linux/blkdev.h | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 22 deletions(-)

--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -194,32 +194,6 @@ int bio_integrity_enabled(struct bio *bi
 EXPORT_SYMBOL(bio_integrity_enabled);
 
 /**
- * bio_integrity_hw_sectors - Convert 512b sectors to hardware ditto
- * @bi:		blk_integrity profile for device
- * @sectors:	Number of 512 sectors to convert
- *
- * Description: The block layer calculates everything in 512 byte
- * sectors but integrity metadata is done in terms of the hardware
- * sector size of the storage device.  Convert the block layer sectors
- * to physical sectors.
- */
-static inline unsigned int bio_integrity_hw_sectors(struct blk_integrity *bi,
-						    unsigned int sectors)
-{
-	/* At this point there are only 512b or 4096b DIF/EPP devices */
-	if (bi->sector_size == 4096)
-		return sectors >>= 3;
-
-	return sectors;
-}
-
-static inline unsigned int bio_integrity_bytes(struct blk_integrity *bi,
-					       unsigned int sectors)
-{
-	return bio_integrity_hw_sectors(bi, sectors) * bi->tuple_size;
-}
-
-/**
  * bio_integrity_tag_size - Retrieve integrity tag space
  * @bio:	bio to inspect
  *
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1542,6 +1542,32 @@ queue_max_integrity_segments(struct requ
 	return q->limits.max_integrity_segments;
 }
 
+/**
+ * bio_integrity_hw_sectors - Convert 512b sectors to hardware ditto
+ * @bi:		blk_integrity profile for device
+ * @sectors:	Number of 512 sectors to convert
+ *
+ * Description: The block layer calculates everything in 512 byte
+ * sectors but integrity metadata is done in terms of the hardware
+ * sector size of the storage device.  Convert the block layer sectors
+ * to physical sectors.
+ */
+static inline unsigned int bio_integrity_hw_sectors(struct blk_integrity *bi,
+						    unsigned int sectors)
+{
+	/* At this point there are only 512b or 4096b DIF/EPP devices */
+	if (bi->sector_size == 4096)
+		return sectors >>= 3;
+
+	return sectors;
+}
+
+static inline unsigned int bio_integrity_bytes(struct blk_integrity *bi,
+					       unsigned int sectors)
+{
+	return bio_integrity_hw_sectors(bi, sectors) * bi->tuple_size;
+}
+
 #else /* CONFIG_BLK_DEV_INTEGRITY */
 
 struct bio;
@@ -1608,6 +1634,18 @@ static inline bool blk_integrity_is_init
 {
 	return 0;
 }
+
+static inline unsigned int bio_integrity_hw_sectors(struct blk_integrity *bi,
+						   unsigned int sectors)
+{
+	return 0;
+}
+
+static inline unsigned int bio_integrity_bytes(struct blk_integrity *bi,
+					       unsigned int sectors)
+{
+	return 0;
+}
 
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
 


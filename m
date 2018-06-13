Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3942EC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB86208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDB86208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935986AbeFMVYP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 17:24:15 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:45412 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935881AbeFMVYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 17:24:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 1185518198DC1;
        Wed, 13 Jun 2018 23:24:04 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 08/14] ubi: fastmap: Scan empty space if fastmap is preseeded
Date:   Wed, 13 Jun 2018 23:23:38 +0200
Message-Id: <20180613212344.11608-9-richard@nod.at>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180613212344.11608-1-richard@nod.at>
References: <20180613212344.11608-1-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The creation tool does not know the real size of the MTD, therefore the
preseeded fastmap references only used PEBs.
Free PEBs need to be discovered during the initial attach of the
preseeded fastmap.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/mtd/ubi/fastmap.c | 123 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 117 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/ubi/fastmap.c b/drivers/mtd/ubi/fastmap.c
index 976d371d7cef..09a9d3a0ccf5 100644
--- a/drivers/mtd/ubi/fastmap.c
+++ b/drivers/mtd/ubi/fastmap.c
@@ -422,6 +422,96 @@ static void unmap_peb(struct ubi_attach_info *ai, int pnum)
 		}
 	}
 }
+/**
+ * scan_empty_space - scan empty space.
+ *
+ * @ubi: UBI device object
+ * @ai: attach info object
+ * @start: PEB number where empty space is expected to start
+ *
+ * Is is the fastmap preseeded, it references only used PEBs, the creation
+ * does not know the real MTD size. Therefore many PEBs are 0xff and unknown
+ * to the fastmap. Scan for this PEBs during attach and make them known.
+ * These PEBs are only allowed to be 0xff or have a valid EC header.
+ * EC headers are allowed because the initial scan+erase operation could be
+ * interrupted by a power cycle.
+ */
+static int scan_empty_space(struct ubi_device *ubi, struct ubi_attach_info *ai,
+			    int start)
+{
+	int pnum, err, scrub, empty, image_seq;
+	unsigned long long ec;
+	struct ubi_ec_hdr *ech = NULL;
+	struct ubi_vid_io_buf *vb = NULL;
+	struct ubi_vid_hdr *vh;
+
+	err = -ENOMEM;
+
+	ech = kzalloc(ubi->ec_hdr_alsize, GFP_KERNEL);
+	if (!ech)
+		goto out;
+
+	vb = ubi_alloc_vid_buf(ubi, GFP_KERNEL);
+	if (!vb)
+		goto out;
+
+	vh = ubi_get_vid_hdr(vb);
+
+	ubi_msg(ubi, "scanning %i additional PEBs", ubi->peb_count - start);
+
+	for (pnum = start; pnum < ubi->peb_count; pnum++) {
+		if (ubi_io_is_bad(ubi, pnum))
+			continue;
+
+		scrub = empty = ec = 0;
+		err = ubi_io_read_ec_hdr(ubi, pnum, ech, 0);
+		switch (err) {
+			case UBI_IO_FF_BITFLIPS:
+				scrub = 1;
+				/* fall through */
+			case UBI_IO_FF:
+				empty = 1;
+				break;
+			case UBI_IO_BITFLIPS:
+				scrub = 1;
+				/* fall through */
+			case 0:
+				ec = be64_to_cpu(ech->ec);
+				image_seq = be32_to_cpu(ech->image_seq);
+
+				if (image_seq && (image_seq != ubi->image_seq)) {
+					ubi_err(ubi, "bad image seq: 0x%x, expected: 0x%x",
+						image_seq, ubi->image_seq);
+					err = UBI_BAD_FASTMAP;
+					goto out;
+				}
+				break;
+			default:
+				ubi_err(ubi, "Unable to read EC header in empty space: %i",
+					err);
+				err = UBI_BAD_FASTMAP;
+				goto out;
+		}
+
+		err = ubi_io_read_vid_hdr(ubi, pnum, vb, 0);
+		if (err != UBI_IO_FF && err != UBI_IO_FF_BITFLIPS) {
+			ubi_err(ubi, "Unexpected data in empty space: %i", err);
+			err = UBI_BAD_FASTMAP;
+			goto out;
+		}
+
+		if (empty)
+			add_aeb(ai, &ai->erase, pnum, ec, scrub);
+		else
+			add_aeb(ai, &ai->free, pnum, ec, scrub);
+	}
+
+	err = 0;
+out:
+	kfree(ech);
+	ubi_free_vid_buf(vb);
+	return err;
+}
 
 /**
  * scan_pool - scans a pool for changed (no longer empty PEBs).
@@ -818,13 +908,34 @@ static int ubi_attach_fastmap(struct ubi_device *ubi,
 		}
 	}
 
-	ret = scan_pool(ubi, ai, fmpl->pebs, pool_size, &max_sqnum, &free);
-	if (ret)
-		goto fail;
+	if (!(fm->flags & UBI_FM_SB_PRESEEDED_FLG)) {
+		ret = scan_pool(ubi, ai, fmpl->pebs, pool_size, &max_sqnum, &free);
+		if (ret)
+			goto fail;
 
-	ret = scan_pool(ubi, ai, fmpl_wl->pebs, wl_pool_size, &max_sqnum, &free);
-	if (ret)
-		goto fail;
+		ret = scan_pool(ubi, ai, fmpl_wl->pebs, wl_pool_size, &max_sqnum, &free);
+		if (ret)
+			goto fail;
+	}
+
+	if (fm->flags & UBI_FM_SB_PRESEEDED_FLG) {
+		int empty_start = be32_to_cpu(fmhdr->used_peb_count) + \
+				  be32_to_cpu(fmhdr->erase_peb_count) + fm->used_blocks;
+
+		if (empty_start + ai->bad_peb_count > ubi->peb_count) {
+			ubi_err(ubi, "fastmap points beyond end of device!");
+			goto fail_bad;
+		} else if (empty_start + ai->bad_peb_count == ubi->peb_count) {
+			ubi_msg(ubi, "no need to scan empty space");
+		} else {
+			if (!read_pnum(ubi, ai, cpu_to_be32(empty_start), &empty_start))
+				goto fail_bad;
+
+			ret = scan_empty_space(ubi, ai, empty_start);
+			if (ret)
+				goto fail;
+		}
+	}
 
 	if (max_sqnum > ai->max_sqnum)
 		ai->max_sqnum = max_sqnum;
-- 
2.13.6


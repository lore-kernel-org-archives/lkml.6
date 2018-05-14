Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752691AbeENLZZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 07:25:25 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:35640 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752550AbeENLYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 07:24:37 -0400
From: Richard Weinberger <richard@nod.at>
To: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 6/8] ubi: fastmap: Scan empty space if fastmap is preseeded
Date: Mon, 14 May 2018 13:24:20 +0200
Message-Id: <20180514112422.23988-7-richard@nod.at>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180514112422.23988-1-richard@nod.at>
References: <20180514112422.23988-1-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The creation tool does not know the real size of the MTD, therefore the
preseeded fastmap references only used PEBs.
Free PEBs need to be discovered during the initial attach of the
preseeded fastmap.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/mtd/ubi/fastmap.c | 109 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 103 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/ubi/fastmap.c b/drivers/mtd/ubi/fastmap.c
index 0d1274b69274..5ec14fd70c13 100644
--- a/drivers/mtd/ubi/fastmap.c
+++ b/drivers/mtd/ubi/fastmap.c
@@ -400,6 +400,94 @@ static void unmap_peb(struct ubi_attach_info *ai, int pnum)
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
@@ -784,13 +872,22 @@ static int ubi_attach_fastmap(struct ubi_device *ubi,
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
+		int empty_start = fix_pnum(ai, be32_to_cpu(fmhdr->used_peb_count) + fm->used_blocks);
+		ret = scan_empty_space(ubi, ai, empty_start);
+		if (ret)
+			goto fail;
+	}
 
 	if (max_sqnum > ai->max_sqnum)
 		ai->max_sqnum = max_sqnum;
-- 
2.13.6

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933852AbeE1UFQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 16:05:16 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:38886 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932761AbeE1UFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 16:05:10 -0400
From: Richard Weinberger <richard@nod.at>
To: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Martinbayern@outlook.com,
        Richard Weinberger <richard@nod.at>, stable@vger.kernel.org
Subject: [PATCH 1/3] ubi: fastmap: Correctly handle interrupted erasures in EBA
Date: Mon, 28 May 2018 22:04:32 +0200
Message-Id: <20180528200434.19811-1-richard@nod.at>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fastmap cannot track the LEB unmap operation, therefore it can
happen that after an interrupted erasure the mapping still looks
good from Fastmap's point of view, while reading from the PEB will
cause an ECC error and confuses the upper layer.

Instead of teaching users of UBI how to deal with that, we read back
the VID header and check for errors. If the PEB is empty or shows ECC
errors we fixup the mapping and schedule the PEB for erasure.

Fixes: dbb7d2a88d2a ("UBI: Add fastmap core")
Cc: <stable@vger.kernel.org>
Reported-by: martin bayern <Martinbayern@outlook.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/mtd/ubi/eba.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/eba.c b/drivers/mtd/ubi/eba.c
index 250e30fac61b..593a4f9d97e3 100644
--- a/drivers/mtd/ubi/eba.c
+++ b/drivers/mtd/ubi/eba.c
@@ -490,6 +490,82 @@ int ubi_eba_unmap_leb(struct ubi_device *ubi, struct ubi_volume *vol,
 	return err;
 }
 
+#ifdef CONFIG_MTD_UBI_FASTMAP
+/**
+ * check_mapping - check and fixup a mapping
+ * @ubi: UBI device description object
+ * @vol: volume description object
+ * @lnum: logical eraseblock number
+ * @pnum: physical eraseblock number
+ *
+ * Checks whether a given mapping is valid. Fastmap cannot track LEB unmap
+ * operations, if such an operation is interrupted the mapping still looks
+ * good, but upon first read an ECC is reported to the upper layer.
+ * Normaly during the full-scan at attach time this is fixed, for Fastmap
+ * we have to deal with it while reading.
+ * If the PEB behind a LEB shows this symthom we change the mapping to
+ * %UBI_LEB_UNMAPPED and schedule the PEB for erasure.
+ *
+ * Returns 0 on success, negative error code in case of failure.
+ */
+static int check_mapping(struct ubi_device *ubi, struct ubi_volume *vol, int lnum,
+			 int *pnum)
+{
+	int err;
+	struct ubi_vid_io_buf *vidb;
+
+	if (!ubi->fast_attach)
+		return 0;
+
+	vidb = ubi_alloc_vid_buf(ubi, GFP_NOFS);
+	if (!vidb)
+		return -ENOMEM;
+
+	err = ubi_io_read_vid_hdr(ubi, *pnum, vidb, 0);
+	if (err > 0 && err != UBI_IO_BITFLIPS) {
+		int torture = 0;
+
+		switch (err) {
+			case UBI_IO_FF:
+			case UBI_IO_FF_BITFLIPS:
+			case UBI_IO_BAD_HDR:
+			case UBI_IO_BAD_HDR_EBADMSG:
+				break;
+			default:
+				ubi_assert(0);
+		}
+
+		if (err == UBI_IO_BAD_HDR_EBADMSG || err == UBI_IO_FF_BITFLIPS)
+			torture = 1;
+
+		down_read(&ubi->fm_eba_sem);
+		vol->eba_tbl->entries[lnum].pnum = UBI_LEB_UNMAPPED;
+		up_read(&ubi->fm_eba_sem);
+		ubi_wl_put_peb(ubi, vol->vol_id, lnum, *pnum, torture);
+
+		*pnum = UBI_LEB_UNMAPPED;
+	} else if (err < 0) {
+		ubi_err(ubi, "unable to read VID header back from PEB %i: %i",
+			*pnum, err);
+
+		goto out_free;
+	}
+
+	err = 0;
+
+out_free:
+	ubi_free_vid_buf(vidb);
+
+	return err;
+}
+#else
+static int check_mapping(struct ubi_device *ubi, struct ubi_volume *vol, int lnum,
+		  int *pnum)
+{
+	return 0;
+}
+#endif
+
 /**
  * ubi_eba_read_leb - read data.
  * @ubi: UBI device description object
@@ -522,7 +598,13 @@ int ubi_eba_read_leb(struct ubi_device *ubi, struct ubi_volume *vol, int lnum,
 		return err;
 
 	pnum = vol->eba_tbl->entries[lnum].pnum;
-	if (pnum < 0) {
+	if (pnum >= 0) {
+		err = check_mapping(ubi, vol, lnum, &pnum);
+		if (err < 0)
+			goto out_unlock;
+	}
+
+	if (pnum == UBI_LEB_UNMAPPED) {
 		/*
 		 * The logical eraseblock is not mapped, fill the whole buffer
 		 * with 0xFF bytes. The exception is static volumes for which
@@ -931,6 +1013,12 @@ int ubi_eba_write_leb(struct ubi_device *ubi, struct ubi_volume *vol, int lnum,
 
 	pnum = vol->eba_tbl->entries[lnum].pnum;
 	if (pnum >= 0) {
+		err = check_mapping(ubi, vol, lnum, &pnum);
+		if (err < 0)
+			goto out;
+	}
+
+	if (pnum >= 0) {
 		dbg_eba("write %d bytes at offset %d of LEB %d:%d, PEB %d",
 			len, offset, vol_id, lnum, pnum);
 
-- 
2.13.6

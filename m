Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752735AbeENL1x (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 07:27:53 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:35574 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752436AbeENLYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 07:24:34 -0400
From: Richard Weinberger <richard@nod.at>
To: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 1/8] ubi: fastmap: Add support for flags
Date: Mon, 14 May 2018 13:24:15 +0200
Message-Id: <20180514112422.23988-2-richard@nod.at>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180514112422.23988-1-richard@nod.at>
References: <20180514112422.23988-1-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With version 2 of fastmap, flags are supported.
We fall back to scanning mode if unsupported flags are found.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/mtd/ubi/fastmap.c   | 24 ++++++++++++++++++++----
 drivers/mtd/ubi/ubi-media.h | 11 +++++++++--
 drivers/mtd/ubi/ubi.h       |  2 ++
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/ubi/fastmap.c b/drivers/mtd/ubi/fastmap.c
index 91705962ba73..131cfc461fce 100644
--- a/drivers/mtd/ubi/fastmap.c
+++ b/drivers/mtd/ubi/fastmap.c
@@ -914,9 +914,24 @@ int ubi_scan_fastmap(struct ubi_device *ubi, struct ubi_attach_info *ai,
 		goto free_fm_sb;
 	}
 
-	if (fmsb->version != UBI_FM_FMT_VERSION) {
-		ubi_err(ubi, "bad fastmap version: %i, expected: %i",
-			fmsb->version, UBI_FM_FMT_VERSION);
+	fm->flags = be32_to_cpu(fmsb->flags);
+
+	if (fmsb->version == 1) {
+		if (fm->flags != 0) {
+			ubi_err(ubi, "fastmap flags are non-zero: %#x",
+				fm->flags);
+			ret = UBI_BAD_FASTMAP;
+			goto free_fm_sb;
+		}
+	} else if (fmsb->version == 2) {
+		if ((fm->flags & UBI_FM_SB_FLG_MASK) != UBI_FM_SB_FLG_MASK) {
+			ubi_err(ubi, "unsupported fastmap flags present: %#x",
+				fm->flags);
+			ret = UBI_BAD_FASTMAP;
+			goto free_fm_sb;
+		}
+	} else {
+		ubi_err(ubi, "bad fastmap version: %i", fmsb->version);
 		ret = UBI_BAD_FASTMAP;
 		goto free_fm_sb;
 	}
@@ -1164,10 +1179,11 @@ static int ubi_write_fastmap(struct ubi_device *ubi,
 	ubi_assert(fm_pos <= ubi->fm_size);
 
 	fmsb->magic = cpu_to_be32(UBI_FM_SB_MAGIC);
-	fmsb->version = UBI_FM_FMT_VERSION;
+	fmsb->version = UBI_FM_FMT_WRITE_VERSION;
 	fmsb->used_blocks = cpu_to_be32(new_fm->used_blocks);
 	/* the max sqnum will be filled in while *reading* the fastmap */
 	fmsb->sqnum = 0;
+	fmsb->flags = 0;
 
 	fmh->magic = cpu_to_be32(UBI_FM_HDR_MAGIC);
 	free_peb_count = 0;
diff --git a/drivers/mtd/ubi/ubi-media.h b/drivers/mtd/ubi/ubi-media.h
index bfceae5a890e..d25ced1285e2 100644
--- a/drivers/mtd/ubi/ubi-media.h
+++ b/drivers/mtd/ubi/ubi-media.h
@@ -381,7 +381,10 @@ struct ubi_vtbl_record {
 #define UBI_FM_DATA_VOLUME_ID	(UBI_LAYOUT_VOLUME_ID + 2)
 
 /* fastmap on-flash data structure format version */
-#define UBI_FM_FMT_VERSION	1
+#define UBI_FM_FMT_VERSION		2
+
+/* this implementation writes always version 1 */
+#define UBI_FM_FMT_WRITE_VERSION	1
 
 #define UBI_FM_SB_MAGIC		0x7B11D69F
 #define UBI_FM_HDR_MAGIC	0xD4B82EF7
@@ -403,6 +406,8 @@ struct ubi_vtbl_record {
 #define UBI_FM_MIN_POOL_SIZE	8
 #define UBI_FM_MAX_POOL_SIZE	256
 
+#define UBI_FM_SB_FLG_MASK	0
+
 /**
  * struct ubi_fm_sb - UBI fastmap super block
  * @magic: fastmap super block magic number (%UBI_FM_SB_MAGIC)
@@ -412,6 +417,7 @@ struct ubi_vtbl_record {
  * @block_loc: an array containing the location of all PEBs of the fastmap
  * @block_ec: the erase counter of each used PEB
  * @sqnum: highest sequence number value at the time while taking the fastmap
+ * @flags: fastmap specific flags, only used with @version > 1, zero otherwise
  *
  */
 struct ubi_fm_sb {
@@ -423,7 +429,8 @@ struct ubi_fm_sb {
 	__be32 block_loc[UBI_FM_MAX_BLOCKS];
 	__be32 block_ec[UBI_FM_MAX_BLOCKS];
 	__be64 sqnum;
-	__u8 padding2[32];
+	__be32 flags;
+	__u8 padding2[28];
 } __packed;
 
 /**
diff --git a/drivers/mtd/ubi/ubi.h b/drivers/mtd/ubi/ubi.h
index 5fe62653995e..af1c5809e567 100644
--- a/drivers/mtd/ubi/ubi.h
+++ b/drivers/mtd/ubi/ubi.h
@@ -249,6 +249,7 @@ struct ubi_volume_desc;
  * @used_blocks: number of used PEBs
  * @max_pool_size: maximal size of the user pool
  * @max_wl_pool_size: maximal size of the pool used by the WL sub-system
+ * @flags: fastmap flags
  */
 struct ubi_fastmap_layout {
 	struct ubi_wl_entry *e[UBI_FM_MAX_BLOCKS];
@@ -256,6 +257,7 @@ struct ubi_fastmap_layout {
 	int used_blocks;
 	int max_pool_size;
 	int max_wl_pool_size;
+	int flags;
 };
 
 /**
-- 
2.13.6

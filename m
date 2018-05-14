Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752612AbeENL0b (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 07:26:31 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:35764 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752342AbeENLZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 07:25:40 -0400
From: Richard Weinberger <richard@nod.at>
To: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, goliath@sigma-star.at,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 1/5] Sync ubi-media.h with Linux
Date: Mon, 14 May 2018 13:25:24 +0200
Message-Id: <20180514112528.24092-2-richard@nod.at>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180514112528.24092-1-richard@nod.at>
References: <20180514112528.24092-1-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...to get UBI Fastmap on-fast layout.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 include/mtd/ubi-media.h | 158 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 152 insertions(+), 6 deletions(-)

diff --git a/include/mtd/ubi-media.h b/include/mtd/ubi-media.h
index 08bec3ed96f0..a2c471210202 100644
--- a/include/mtd/ubi-media.h
+++ b/include/mtd/ubi-media.h
@@ -149,10 +149,10 @@ enum {
  * The @image_seq field is used to validate a UBI image that has been prepared
  * for a UBI device. The @image_seq value can be any value, but it must be the
  * same on all eraseblocks. UBI will ensure that all new erase counter headers
- * also contain this value, and will check the value when scanning at start-up.
+ * also contain this value, and will check the value when attaching the flash.
  * One way to make use of @image_seq is to increase its value by one every time
  * an image is flashed over an existing image, then, if the flashing does not
- * complete, UBI will detect the error when scanning.
+ * complete, UBI will detect the error when attaching the media.
  */
 struct ubi_ec_hdr {
 	__be32  magic;
@@ -229,7 +229,7 @@ struct ubi_ec_hdr {
  * copy. UBI also calculates data CRC when the data is moved and stores it at
  * the @data_crc field of the copy (P1). So when UBI needs to pick one physical
  * eraseblock of two (P or P1), the @copy_flag of the newer one (P1) is
- * examined. If it is cleared, the situation* is simple and the newer one is
+ * examined. If it is cleared, the situation is simple and the newer one is
  * picked. If it is set, the data CRC of the copy (P1) is examined. If the CRC
  * checksum is correct, this physical eraseblock is selected (P1). Otherwise
  * the older one (P) is selected.
@@ -283,7 +283,7 @@ struct ubi_vid_hdr {
 	__u8    compat;
 	__be32  vol_id;
 	__be32  lnum;
-	__be32  leb_ver;
+	__u8    padding1[4];
 	__be32  data_size;
 	__be32  used_ebs;
 	__be32  data_pad;
@@ -298,8 +298,8 @@ struct ubi_vid_hdr {
 #define UBI_INT_VOL_COUNT 1
 
 /*
- * Starting ID of internal volumes. There is reserved room for 4096 internal
- * volumes.
+ * Starting ID of internal volumes: 0x7fffefff.
+ * There is reserved room for 4096 internal volumes.
  */
 #define UBI_INTERNAL_VOL_START (0x7FFFFFFF - 4096)
 
@@ -375,4 +375,150 @@ struct ubi_vtbl_record {
 	__be32  crc;
 } __attribute__ ((packed));
 
+/* UBI fastmap on-flash data structures */
+
+#define UBI_FM_SB_VOLUME_ID	(UBI_LAYOUT_VOLUME_ID + 1)
+#define UBI_FM_DATA_VOLUME_ID	(UBI_LAYOUT_VOLUME_ID + 2)
+
+/* fastmap on-flash data structure format version */
+#define UBI_FM_FMT_VERSION		2
+
+/* this implementation writes always version 1 */
+#define UBI_FM_FMT_WRITE_VERSION	1
+
+#define UBI_FM_SB_MAGIC		0x7B11D69F
+#define UBI_FM_HDR_MAGIC	0xD4B82EF7
+#define UBI_FM_VHDR_MAGIC	0xFA370ED1
+#define UBI_FM_POOL_MAGIC	0x67AF4D08
+#define UBI_FM_EBA_MAGIC	0xf0c040a8
+
+/* A fastmap super block can be located between PEB 0 and
+ * UBI_FM_MAX_START */
+#define UBI_FM_MAX_START	64
+
+/* A fastmap can use up to UBI_FM_MAX_BLOCKS PEBs */
+#define UBI_FM_MAX_BLOCKS	32
+
+/* 5% of the total number of PEBs have to be scanned while attaching
+ * from a fastmap.
+ * But the size of this pool is limited to be between UBI_FM_MIN_POOL_SIZE and
+ * UBI_FM_MAX_POOL_SIZE */
+#define UBI_FM_MIN_POOL_SIZE	8
+#define UBI_FM_MAX_POOL_SIZE	256
+
+enum {
+	UBI_FM_SB_PRESEEDED_FLG	= 0x1,
+};
+
+#define UBI_FM_SB_FLG_MASK (UBI_FM_SB_PRESEEDED_FLG)
+
+/**
+ * struct ubi_fm_sb - UBI fastmap super block
+ * @magic: fastmap super block magic number (%UBI_FM_SB_MAGIC)
+ * @version: format version of this fastmap
+ * @data_crc: CRC over the fastmap data
+ * @used_blocks: number of PEBs used by this fastmap
+ * @block_loc: an array containing the location of all PEBs of the fastmap
+ * @block_ec: the erase counter of each used PEB
+ * @sqnum: highest sequence number value at the time while taking the fastmap
+ * @flags: fastmap specific flags, only used with @version > 1, zero otherwise
+ *
+ */
+struct ubi_fm_sb {
+	__be32 magic;
+	__u8 version;
+	__u8 padding1[3];
+	__be32 data_crc;
+	__be32 used_blocks;
+	__be32 block_loc[UBI_FM_MAX_BLOCKS];
+	__be32 block_ec[UBI_FM_MAX_BLOCKS];
+	__be64 sqnum;
+	__be32 flags;
+	__u8 padding2[28];
+} __attribute__ ((packed));
+
+/**
+ * struct ubi_fm_hdr - header of the fastmap data set
+ * @magic: fastmap header magic number (%UBI_FM_HDR_MAGIC)
+ * @free_peb_count: number of free PEBs known by this fastmap
+ * @used_peb_count: number of used PEBs known by this fastmap
+ * @scrub_peb_count: number of to be scrubbed PEBs known by this fastmap
+ * @bad_peb_count: number of bad PEBs known by this fastmap
+ * @erase_peb_count: number of bad PEBs which have to be erased
+ * @vol_count: number of UBI volumes known by this fastmap
+ */
+struct ubi_fm_hdr {
+	__be32 magic;
+	__be32 free_peb_count;
+	__be32 used_peb_count;
+	__be32 scrub_peb_count;
+	__be32 bad_peb_count;
+	__be32 erase_peb_count;
+	__be32 vol_count;
+	__u8 padding[4];
+} __attribute__ ((packed));
+
+/* struct ubi_fm_hdr is followed by two struct ubi_fm_scan_pool */
+
+/**
+ * struct ubi_fm_scan_pool - Fastmap pool PEBs to be scanned while attaching
+ * @magic: pool magic numer (%UBI_FM_POOL_MAGIC)
+ * @size: current pool size
+ * @max_size: maximal pool size
+ * @pebs: an array containing the location of all PEBs in this pool
+ */
+struct ubi_fm_scan_pool {
+	__be32 magic;
+	__be16 size;
+	__be16 max_size;
+	__be32 pebs[UBI_FM_MAX_POOL_SIZE];
+	__be32 padding[4];
+} __attribute__ ((packed));
+
+/* ubi_fm_scan_pool is followed by nfree+nused struct ubi_fm_ec records */
+
+/**
+ * struct ubi_fm_ec - stores the erase counter of a PEB
+ * @pnum: PEB number
+ * @ec: ec of this PEB
+ */
+struct ubi_fm_ec {
+	__be32 pnum;
+	__be32 ec;
+} __attribute__ ((packed));
+
+/**
+ * struct ubi_fm_volhdr - Fastmap volume header
+ * it identifies the start of an eba table
+ * @magic: Fastmap volume header magic number (%UBI_FM_VHDR_MAGIC)
+ * @vol_id: volume id of the fastmapped volume
+ * @vol_type: type of the fastmapped volume
+ * @data_pad: data_pad value of the fastmapped volume
+ * @used_ebs: number of used LEBs within this volume
+ * @last_eb_bytes: number of bytes used in the last LEB
+ */
+struct ubi_fm_volhdr {
+	__be32 magic;
+	__be32 vol_id;
+	__u8 vol_type;
+	__u8 padding1[3];
+	__be32 data_pad;
+	__be32 used_ebs;
+	__be32 last_eb_bytes;
+	__u8 padding2[8];
+} __attribute__ ((packed));
+
+/* struct ubi_fm_volhdr is followed by one struct ubi_fm_eba records */
+
+/**
+ * struct ubi_fm_eba - denotes an association between a PEB and LEB
+ * @magic: EBA table magic number
+ * @reserved_pebs: number of table entries
+ * @pnum: PEB number of LEB (LEB is the index)
+ */
+struct ubi_fm_eba {
+	__be32 magic;
+	__be32 reserved_pebs;
+	__be32 pnum[0];
+} __attribute__ ((packed));
 #endif /* !__UBI_MEDIA_H__ */
-- 
2.13.6

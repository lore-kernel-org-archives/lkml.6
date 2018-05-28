Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933826AbeE1UFN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 16:05:13 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:38902 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933586AbeE1UFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 16:05:09 -0400
From: Richard Weinberger <richard@nod.at>
To: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Martinbayern@outlook.com,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 2/3] ubi: fastmap: Check each mapping only once
Date: Mon, 28 May 2018 22:04:33 +0200
Message-Id: <20180528200434.19811-2-richard@nod.at>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180528200434.19811-1-richard@nod.at>
References: <20180528200434.19811-1-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maintain a bitmap to keep track of which LEB->PEB mapping
was checked already.
That way we have to read back VID headers only once.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/mtd/ubi/build.c   |  1 +
 drivers/mtd/ubi/eba.c     |  4 ++++
 drivers/mtd/ubi/fastmap.c | 20 ++++++++++++++++++++
 drivers/mtd/ubi/ubi.h     | 11 +++++++++++
 drivers/mtd/ubi/vmt.c     |  1 +
 drivers/mtd/ubi/vtbl.c    | 16 +++++++++++++++-
 6 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index 753494e042d5..da91306a935c 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -526,6 +526,7 @@ void ubi_free_internal_volumes(struct ubi_device *ubi)
 	for (i = ubi->vtbl_slots;
 	     i < ubi->vtbl_slots + UBI_INT_VOL_COUNT; i++) {
 		ubi_eba_replace_table(ubi->volumes[i], NULL);
+		ubi_fastmap_destroy_checkmap(ubi->volumes[i]);
 		kfree(ubi->volumes[i]);
 	}
 }
diff --git a/drivers/mtd/ubi/eba.c b/drivers/mtd/ubi/eba.c
index 593a4f9d97e3..1ceab201a27b 100644
--- a/drivers/mtd/ubi/eba.c
+++ b/drivers/mtd/ubi/eba.c
@@ -517,6 +517,9 @@ static int check_mapping(struct ubi_device *ubi, struct ubi_volume *vol, int lnu
 	if (!ubi->fast_attach)
 		return 0;
 
+	if (!vol->checkmap || test_bit(lnum, vol->checkmap))
+		return 0;
+
 	vidb = ubi_alloc_vid_buf(ubi, GFP_NOFS);
 	if (!vidb)
 		return -ENOMEM;
@@ -551,6 +554,7 @@ static int check_mapping(struct ubi_device *ubi, struct ubi_volume *vol, int lnu
 		goto out_free;
 	}
 
+	set_bit(lnum, vol->checkmap);
 	err = 0;
 
 out_free:
diff --git a/drivers/mtd/ubi/fastmap.c b/drivers/mtd/ubi/fastmap.c
index 91705962ba73..462526a10537 100644
--- a/drivers/mtd/ubi/fastmap.c
+++ b/drivers/mtd/ubi/fastmap.c
@@ -1100,6 +1100,26 @@ int ubi_scan_fastmap(struct ubi_device *ubi, struct ubi_attach_info *ai,
 	goto out;
 }
 
+int ubi_fastmap_init_checkmap(struct ubi_volume *vol, int leb_count)
+{
+	struct ubi_device *ubi = vol->ubi;
+
+	if (!ubi->fast_attach)
+		return 0;
+
+	vol->checkmap = kcalloc(BITS_TO_LONGS(leb_count), sizeof(unsigned long),
+				GFP_KERNEL);
+	if (!vol->checkmap)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void ubi_fastmap_destroy_checkmap(struct ubi_volume *vol)
+{
+	kfree(vol->checkmap);
+}
+
 /**
  * ubi_write_fastmap - writes a fastmap.
  * @ubi: UBI device object
diff --git a/drivers/mtd/ubi/ubi.h b/drivers/mtd/ubi/ubi.h
index 5fe62653995e..f5ba97c46160 100644
--- a/drivers/mtd/ubi/ubi.h
+++ b/drivers/mtd/ubi/ubi.h
@@ -334,6 +334,9 @@ struct ubi_eba_leb_desc {
  * @changing_leb: %1 if the atomic LEB change ioctl command is in progress
  * @direct_writes: %1 if direct writes are enabled for this volume
  *
+ * @checkmap: bitmap to remember which PEB->LEB mappings got checked,
+ *            protected by UBI LEB lock tree.
+ *
  * The @corrupted field indicates that the volume's contents is corrupted.
  * Since UBI protects only static volumes, this field is not relevant to
  * dynamic volumes - it is user's responsibility to assure their data
@@ -377,6 +380,10 @@ struct ubi_volume {
 	unsigned int updating:1;
 	unsigned int changing_leb:1;
 	unsigned int direct_writes:1;
+
+#ifdef CONFIG_MTD_UBI_FASTMAP
+	unsigned long *checkmap;
+#endif
 };
 
 /**
@@ -965,8 +972,12 @@ size_t ubi_calc_fm_size(struct ubi_device *ubi);
 int ubi_update_fastmap(struct ubi_device *ubi);
 int ubi_scan_fastmap(struct ubi_device *ubi, struct ubi_attach_info *ai,
 		     struct ubi_attach_info *scan_ai);
+int ubi_fastmap_init_checkmap(struct ubi_volume *vol, int leb_count);
+void ubi_fastmap_destroy_checkmap(struct ubi_volume *vol);
 #else
 static inline int ubi_update_fastmap(struct ubi_device *ubi) { return 0; }
+int static inline ubi_fastmap_init_checkmap(struct ubi_volume *vol, int leb_count) { return 0; }
+static inline void ubi_fastmap_destroy_checkmap(struct ubi_volume *vol) {}
 #endif
 
 /* block.c */
diff --git a/drivers/mtd/ubi/vmt.c b/drivers/mtd/ubi/vmt.c
index 3fd8d7ff7a02..0be516780e92 100644
--- a/drivers/mtd/ubi/vmt.c
+++ b/drivers/mtd/ubi/vmt.c
@@ -139,6 +139,7 @@ static void vol_release(struct device *dev)
 	struct ubi_volume *vol = container_of(dev, struct ubi_volume, dev);
 
 	ubi_eba_replace_table(vol, NULL);
+	ubi_fastmap_destroy_checkmap(vol);
 	kfree(vol);
 }
 
diff --git a/drivers/mtd/ubi/vtbl.c b/drivers/mtd/ubi/vtbl.c
index 263743e7b741..94d7a865b135 100644
--- a/drivers/mtd/ubi/vtbl.c
+++ b/drivers/mtd/ubi/vtbl.c
@@ -534,7 +534,7 @@ static int init_volumes(struct ubi_device *ubi,
 			const struct ubi_attach_info *ai,
 			const struct ubi_vtbl_record *vtbl)
 {
-	int i, reserved_pebs = 0;
+	int i, err, reserved_pebs = 0;
 	struct ubi_ainf_volume *av;
 	struct ubi_volume *vol;
 
@@ -620,6 +620,16 @@ static int init_volumes(struct ubi_device *ubi,
 			(long long)(vol->used_ebs - 1) * vol->usable_leb_size;
 		vol->used_bytes += av->last_data_size;
 		vol->last_eb_bytes = av->last_data_size;
+
+		/*
+		 * We use ubi->peb_count and not vol->reserved_pebs because
+		 * we want to keep the code simple. Otherwise we'd have to
+		 * resize/check the bitmap upon volume resize too.
+		 * Allocating a few bytes more does not hurt.
+		 */
+		err = ubi_fastmap_init_checkmap(vol, ubi->peb_count);
+		if (err)
+			return err;
 	}
 
 	/* And add the layout volume */
@@ -645,6 +655,9 @@ static int init_volumes(struct ubi_device *ubi,
 	reserved_pebs += vol->reserved_pebs;
 	ubi->vol_count += 1;
 	vol->ubi = ubi;
+	err = ubi_fastmap_init_checkmap(vol, UBI_LAYOUT_VOLUME_EBS);
+	if (err)
+		return err;
 
 	if (reserved_pebs > ubi->avail_pebs) {
 		ubi_err(ubi, "not enough PEBs, required %d, available %d",
@@ -849,6 +862,7 @@ int ubi_read_volume_table(struct ubi_device *ubi, struct ubi_attach_info *ai)
 out_free:
 	vfree(ubi->vtbl);
 	for (i = 0; i < ubi->vtbl_slots + UBI_INT_VOL_COUNT; i++) {
+		ubi_fastmap_destroy_checkmap(ubi->volumes[i]);
 		kfree(ubi->volumes[i]);
 		ubi->volumes[i] = NULL;
 	}
-- 
2.13.6

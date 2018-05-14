Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752632AbeENL1L (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 07:27:11 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:35632 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752544AbeENLYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 07:24:36 -0400
From: Richard Weinberger <richard@nod.at>
To: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 3/8] ubi: fastmap: Implement PEB fixup
Date: Mon, 14 May 2018 13:24:17 +0200
Message-Id: <20180514112422.23988-4-richard@nod.at>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180514112422.23988-1-richard@nod.at>
References: <20180514112422.23988-1-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a fastmap is preseeded we have to fix PEB numbers because
during the creation of the fastmap the creation tool cannot know
which blocks are bad on the target(s).

Therefore fastmap has to learn all bad blocks during attach and
changes PEB numbers accordingly.
This feature assumes that bad blocks are skipped while the image was
flashed, what nandwrite does by default.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/mtd/ubi/attach.c  |  1 +
 drivers/mtd/ubi/fastmap.c | 87 ++++++++++++++++++++++++++++++++++++++++++-----
 drivers/mtd/ubi/ubi.h     |  2 ++
 3 files changed, 82 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/ubi/attach.c b/drivers/mtd/ubi/attach.c
index 93ceea4f27d5..9a8072cf458c 100644
--- a/drivers/mtd/ubi/attach.c
+++ b/drivers/mtd/ubi/attach.c
@@ -1370,6 +1370,7 @@ static void destroy_ai(struct ubi_attach_info *ai)
 	}
 
 	kmem_cache_destroy(ai->aeb_slab_cache);
+	kfree(ai->bb_trans);
 	kfree(ai);
 }
 
diff --git a/drivers/mtd/ubi/fastmap.c b/drivers/mtd/ubi/fastmap.c
index 131cfc461fce..a351860f420a 100644
--- a/drivers/mtd/ubi/fastmap.c
+++ b/drivers/mtd/ubi/fastmap.c
@@ -101,6 +101,13 @@ size_t ubi_calc_fm_size(struct ubi_device *ubi)
 	return roundup(size, ubi->leb_size);
 }
 
+static int fix_pnum(struct ubi_attach_info *ai, int pnum)
+{
+	if (!ai->bb_trans || pnum < 0)
+		return pnum;
+	else
+		return ai->bb_trans[pnum];
+}
 
 /**
  * new_fm_vhdr - allocate a new volume header for fastmap usage.
@@ -438,7 +445,7 @@ static int scan_pool(struct ubi_device *ubi, struct ubi_attach_info *ai,
 		int scrub = 0;
 		int image_seq;
 
-		pnum = be32_to_cpu(pebs[i]);
+		pnum = fix_pnum(ai, be32_to_cpu(pebs[i]));
 
 		if (ubi_io_is_bad(ubi, pnum)) {
 			ubi_err(ubi, "bad PEB in fastmap pool!");
@@ -647,7 +654,7 @@ static int ubi_attach_fastmap(struct ubi_device *ubi,
 		if (fm_pos >= fm_size)
 			goto fail_bad;
 
-		add_aeb(ai, &ai->free, be32_to_cpu(fmec->pnum),
+		add_aeb(ai, &ai->free, fix_pnum(ai, be32_to_cpu(fmec->pnum)),
 			be32_to_cpu(fmec->ec), 0);
 	}
 
@@ -658,7 +665,7 @@ static int ubi_attach_fastmap(struct ubi_device *ubi,
 		if (fm_pos >= fm_size)
 			goto fail_bad;
 
-		add_aeb(ai, &used, be32_to_cpu(fmec->pnum),
+		add_aeb(ai, &used, fix_pnum(ai, be32_to_cpu(fmec->pnum)),
 			be32_to_cpu(fmec->ec), 0);
 	}
 
@@ -669,7 +676,7 @@ static int ubi_attach_fastmap(struct ubi_device *ubi,
 		if (fm_pos >= fm_size)
 			goto fail_bad;
 
-		add_aeb(ai, &used, be32_to_cpu(fmec->pnum),
+		add_aeb(ai, &used, fix_pnum(ai, be32_to_cpu(fmec->pnum)),
 			be32_to_cpu(fmec->ec), 1);
 	}
 
@@ -680,7 +687,7 @@ static int ubi_attach_fastmap(struct ubi_device *ubi,
 		if (fm_pos >= fm_size)
 			goto fail_bad;
 
-		add_aeb(ai, &ai->erase, be32_to_cpu(fmec->pnum),
+		add_aeb(ai, &ai->erase, fix_pnum(ai, be32_to_cpu(fmec->pnum)),
 			be32_to_cpu(fmec->ec), 1);
 	}
 
@@ -731,7 +738,7 @@ static int ubi_attach_fastmap(struct ubi_device *ubi,
 		}
 
 		for (j = 0; j < be32_to_cpu(fm_eba->reserved_pebs); j++) {
-			int pnum = be32_to_cpu(fm_eba->pnum[j]);
+			int pnum = fix_pnum(ai, be32_to_cpu(fm_eba->pnum[j]));
 
 			if (pnum < 0)
 				continue;
@@ -845,6 +852,61 @@ static struct ubi_ainf_peb *clone_aeb(struct ubi_attach_info *ai,
 	return new;
 }
 
+/*
+ * build_bb_trans_table - create a translation table to fix PEB numbers.
+ * @ubi: UBI device object
+ * @ai: UBI attach info object
+ *
+ * A preseeded Fastmap has no knowledge of bad blocks. During first attach
+ * UBI has to update PEB numbers to leave out existing bad blocks.
+ */
+static int build_bb_trans_table(struct ubi_device *ubi,
+				struct ubi_attach_info *ai)
+{
+	int pnum, new_pnum, ret;
+	unsigned long *claimed_blocks;
+
+	ret = -ENOMEM;
+	claimed_blocks = kcalloc(BITS_TO_LONGS(ubi->peb_count),
+			       sizeof(unsigned long), GFP_KERNEL);
+	if (!claimed_blocks)
+		goto out;
+
+	/* ai->bb_trans will get free'ed via destroy_ai() */
+	ai->bb_trans = kcalloc(ubi->peb_count, sizeof(int), GFP_KERNEL);
+	if (!ai->bb_trans)
+		goto out;
+
+	/* Find all bad blocks and mark them as claimed */
+	for (pnum = 0; pnum < ubi->peb_count; pnum++) {
+		ret = ubi_io_is_bad(ubi, pnum);
+		if (ret < 0)
+			goto out;
+
+		if (ret == 1) {
+			set_bit(pnum, claimed_blocks);
+			ai->bad_peb_count++;
+		}
+	}
+
+	/*
+	 * Start with PEB 0 and try to place each PEB around all bad blocks
+	 * to create the translation table.
+	 */
+	for (pnum = 0; pnum < ubi->peb_count - ai->bad_peb_count; pnum++) {
+		ubi_assert(!bitmap_full(claimed_blocks, ubi->peb_count));
+
+		new_pnum = find_first_zero_bit(claimed_blocks, ubi->peb_count);
+		ai->bb_trans[pnum] = new_pnum;
+		set_bit(new_pnum, claimed_blocks);
+	}
+
+out:
+	kfree(claimed_blocks);
+
+	return ret;
+}
+
 /**
  * ubi_scan_fastmap - scan the fastmap.
  * @ubi: UBI device object
@@ -952,6 +1014,15 @@ int ubi_scan_fastmap(struct ubi_device *ubi, struct ubi_attach_info *ai,
 		goto free_fm_sb;
 	}
 
+	if (fm->flags & UBI_FM_SB_PRESEEDED_FLG) {
+		ubi_msg(ubi, "preseeded fastmap found");
+		ret = build_bb_trans_table(ubi, ai);
+		if (ret) {
+			ubi_err(ubi, "failed to construct bb translation table");
+			goto free_fm_sb;
+		}
+	}
+
 	ech = kzalloc(ubi->ec_hdr_alsize, GFP_KERNEL);
 	if (!ech) {
 		ret = -ENOMEM;
@@ -969,7 +1040,7 @@ int ubi_scan_fastmap(struct ubi_device *ubi, struct ubi_attach_info *ai,
 	for (i = 0; i < used_blocks; i++) {
 		int image_seq;
 
-		pnum = be32_to_cpu(fmsb->block_loc[i]);
+		pnum = fix_pnum(ai, be32_to_cpu(fmsb->block_loc[i]));
 
 		if (ubi_io_is_bad(ubi, pnum)) {
 			ret = UBI_BAD_FASTMAP;
@@ -1083,7 +1154,7 @@ int ubi_scan_fastmap(struct ubi_device *ubi, struct ubi_attach_info *ai,
 			goto free_hdr;
 		}
 
-		e->pnum = be32_to_cpu(fmsb2->block_loc[i]);
+		e->pnum = fix_pnum(ai, be32_to_cpu(fmsb2->block_loc[i]));
 		e->ec = be32_to_cpu(fmsb2->block_ec[i]);
 		fm->e[i] = e;
 	}
diff --git a/drivers/mtd/ubi/ubi.h b/drivers/mtd/ubi/ubi.h
index af1c5809e567..dad9d654b01a 100644
--- a/drivers/mtd/ubi/ubi.h
+++ b/drivers/mtd/ubi/ubi.h
@@ -753,6 +753,7 @@ struct ubi_ainf_volume {
  * @aeb_slab_cache: slab cache for &struct ubi_ainf_peb objects
  * @ech: temporary EC header. Only available during scan
  * @vidh: temporary VID buffer. Only available during scan
+ * @bb_trans: bad block translation table, used by fastmap, NULL otherwise
  *
  * This data structure contains the result of attaching an MTD device and may
  * be used by other UBI sub-systems to build final UBI data structures, further
@@ -783,6 +784,7 @@ struct ubi_attach_info {
 	struct kmem_cache *aeb_slab_cache;
 	struct ubi_ec_hdr *ech;
 	struct ubi_vid_io_buf *vidb;
+	int *bb_trans;
 };
 
 /**
-- 
2.13.6

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933806AbeE1UFM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 16:05:12 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:38910 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933692AbeE1UFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 16:05:09 -0400
From: Richard Weinberger <richard@nod.at>
To: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Martinbayern@outlook.com,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 3/3] ubi: fastmap: Detect EBA mismatches on-the-fly
Date: Mon, 28 May 2018 22:04:34 +0200
Message-Id: <20180528200434.19811-3-richard@nod.at>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180528200434.19811-1-richard@nod.at>
References: <20180528200434.19811-1-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now we have the machinery to detect EBA mismatches on-the-fly
by comparing the in-memory volume ID and LEB number with the found
VID header.
This helps to detect malfunction of Fastmap.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/mtd/ubi/eba.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/mtd/ubi/eba.c b/drivers/mtd/ubi/eba.c
index 1ceab201a27b..edb1c8362faa 100644
--- a/drivers/mtd/ubi/eba.c
+++ b/drivers/mtd/ubi/eba.c
@@ -513,6 +513,7 @@ static int check_mapping(struct ubi_device *ubi, struct ubi_volume *vol, int lnu
 {
 	int err;
 	struct ubi_vid_io_buf *vidb;
+	struct ubi_vid_hdr *vid_hdr;
 
 	if (!ubi->fast_attach)
 		return 0;
@@ -552,6 +553,22 @@ static int check_mapping(struct ubi_device *ubi, struct ubi_volume *vol, int lnu
 			*pnum, err);
 
 		goto out_free;
+	} else {
+		int found_vol_id, found_lnum;
+
+		ubi_assert(err == 0 || err == UBI_IO_BITFLIPS);
+
+		vid_hdr = ubi_get_vid_hdr(vidb);
+		found_vol_id = be32_to_cpu(vid_hdr->vol_id);
+		found_lnum = be32_to_cpu(vid_hdr->lnum);
+
+		if (found_lnum != lnum || found_vol_id != vol->vol_id) {
+			ubi_err(ubi, "EBA mismatch! PEB %i is LEB %i:%i instead of LEB %i:%i",
+				*pnum, found_vol_id, found_lnum, vol->vol_id, lnum);
+			ubi_ro_mode(ubi);
+			err = -EINVAL;
+			goto out_free;
+		}
 	}
 
 	set_bit(lnum, vol->checkmap);
-- 
2.13.6

Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CF8EBC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E60208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:24:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90E60208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935925AbeFMVYI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 17:24:08 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:45334 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935682AbeFMVYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 17:24:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id A4792181B5049;
        Wed, 13 Jun 2018 23:24:00 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 01/14] ubi: fastmap: Read PEB numbers more carefully
Date:   Wed, 13 Jun 2018 23:23:31 +0200
Message-Id: <20180613212344.11608-2-richard@nod.at>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180613212344.11608-1-richard@nod.at>
References: <20180613212344.11608-1-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PEB numbers can be used as indices, make sure that they
are within bounds.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/mtd/ubi/fastmap.c | 71 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 58 insertions(+), 13 deletions(-)

diff --git a/drivers/mtd/ubi/fastmap.c b/drivers/mtd/ubi/fastmap.c
index 462526a10537..768fa8a76867 100644
--- a/drivers/mtd/ubi/fastmap.c
+++ b/drivers/mtd/ubi/fastmap.c
@@ -101,6 +101,29 @@ size_t ubi_calc_fm_size(struct ubi_device *ubi)
 	return roundup(size, ubi->leb_size);
 }
 
+static bool read_pnum(struct ubi_device *ubi, struct ubi_attach_info *ai,
+		     __be32 pnum, int *out_pnum)
+{
+	int ret = true;
+	int max_pnum = ubi->peb_count;
+
+	pnum = be32_to_cpu(pnum);
+	if (pnum == UBI_UNKNOWN) {
+		*out_pnum = pnum;
+		goto out;
+	}
+
+	if (pnum < 0 || pnum >= max_pnum) {
+		ubi_err(ubi, "fastmap references PEB out of range: %i", pnum);
+		ret = false;
+		goto out;
+	} else {
+		*out_pnum = pnum;
+	}
+
+out:
+	return ret;
+}
 
 /**
  * new_fm_vhdr - allocate a new volume header for fastmap usage.
@@ -438,7 +461,10 @@ static int scan_pool(struct ubi_device *ubi, struct ubi_attach_info *ai,
 		int scrub = 0;
 		int image_seq;
 
-		pnum = be32_to_cpu(pebs[i]);
+		if (!read_pnum(ubi, ai, pebs[i], &pnum)) {
+			ret = UBI_BAD_FASTMAP;
+			goto out;
+		}
 
 		if (ubi_io_is_bad(ubi, pnum)) {
 			ubi_err(ubi, "bad PEB in fastmap pool!");
@@ -565,7 +591,7 @@ static int ubi_attach_fastmap(struct ubi_device *ubi,
 	struct ubi_fm_ec *fmec;
 	struct ubi_fm_volhdr *fmvhdr;
 	struct ubi_fm_eba *fm_eba;
-	int ret, i, j, pool_size, wl_pool_size;
+	int ret, i, j, pool_size, wl_pool_size, pnum;
 	size_t fm_pos = 0, fm_size = ubi->fm_size;
 	unsigned long long max_sqnum = 0;
 	void *fm_raw = ubi->fm_buf;
@@ -647,8 +673,10 @@ static int ubi_attach_fastmap(struct ubi_device *ubi,
 		if (fm_pos >= fm_size)
 			goto fail_bad;
 
-		add_aeb(ai, &ai->free, be32_to_cpu(fmec->pnum),
-			be32_to_cpu(fmec->ec), 0);
+		if (!read_pnum(ubi, ai, fmec->pnum, &pnum))
+			goto fail_bad;
+
+		add_aeb(ai, &ai->free, pnum, be32_to_cpu(fmec->ec), 0);
 	}
 
 	/* read EC values from used list */
@@ -658,8 +686,10 @@ static int ubi_attach_fastmap(struct ubi_device *ubi,
 		if (fm_pos >= fm_size)
 			goto fail_bad;
 
-		add_aeb(ai, &used, be32_to_cpu(fmec->pnum),
-			be32_to_cpu(fmec->ec), 0);
+		if (!read_pnum(ubi, ai, fmec->pnum, &pnum))
+			goto fail_bad;
+
+		add_aeb(ai, &used, pnum, be32_to_cpu(fmec->ec), 0);
 	}
 
 	/* read EC values from scrub list */
@@ -669,8 +699,10 @@ static int ubi_attach_fastmap(struct ubi_device *ubi,
 		if (fm_pos >= fm_size)
 			goto fail_bad;
 
-		add_aeb(ai, &used, be32_to_cpu(fmec->pnum),
-			be32_to_cpu(fmec->ec), 1);
+		if (!read_pnum(ubi, ai, fmec->pnum, &pnum))
+			goto fail_bad;
+
+		add_aeb(ai, &used, pnum, be32_to_cpu(fmec->ec), 1);
 	}
 
 	/* read EC values from erase list */
@@ -680,8 +712,10 @@ static int ubi_attach_fastmap(struct ubi_device *ubi,
 		if (fm_pos >= fm_size)
 			goto fail_bad;
 
-		add_aeb(ai, &ai->erase, be32_to_cpu(fmec->pnum),
-			be32_to_cpu(fmec->ec), 1);
+		if (!read_pnum(ubi, ai, fmec->pnum, &pnum))
+			goto fail_bad;
+
+		add_aeb(ai, &ai->erase, pnum, be32_to_cpu(fmec->ec), 1);
 	}
 
 	ai->mean_ec = div_u64(ai->ec_sum, ai->ec_count);
@@ -731,7 +765,8 @@ static int ubi_attach_fastmap(struct ubi_device *ubi,
 		}
 
 		for (j = 0; j < be32_to_cpu(fm_eba->reserved_pebs); j++) {
-			int pnum = be32_to_cpu(fm_eba->pnum[j]);
+			if (!read_pnum(ubi, ai, fm_eba->pnum[j], &pnum))
+				goto fail_bad;
 
 			if (pnum < 0)
 				continue;
@@ -954,7 +989,10 @@ int ubi_scan_fastmap(struct ubi_device *ubi, struct ubi_attach_info *ai,
 	for (i = 0; i < used_blocks; i++) {
 		int image_seq;
 
-		pnum = be32_to_cpu(fmsb->block_loc[i]);
+		if (!read_pnum(ubi, ai, fmsb->block_loc[i], &pnum)) {
+			ret = UBI_BAD_FASTMAP;
+			goto free_hdr;
+		}
 
 		if (ubi_io_is_bad(ubi, pnum)) {
 			ret = UBI_BAD_FASTMAP;
@@ -1068,7 +1106,14 @@ int ubi_scan_fastmap(struct ubi_device *ubi, struct ubi_attach_info *ai,
 			goto free_hdr;
 		}
 
-		e->pnum = be32_to_cpu(fmsb2->block_loc[i]);
+		if (!read_pnum(ubi, ai, fmsb2->block_loc[i], &e->pnum)) {
+			while (i--)
+				kmem_cache_free(ubi_wl_entry_slab, fm->e[i]);
+
+			ret = -ENOMEM;
+			goto free_hdr;
+		}
+
 		e->ec = be32_to_cpu(fmsb2->block_ec[i]);
 		fm->e[i] = e;
 	}
-- 
2.13.6


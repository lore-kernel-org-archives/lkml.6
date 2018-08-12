Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D86C46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 14:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA09721A0A
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 14:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPlIU93j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA09721A0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbeHLQkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 12:40:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:58904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbeHLQkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 12:40:43 -0400
Received: from localhost.localdomain (unknown [58.212.144.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 393CF21A02;
        Sun, 12 Aug 2018 14:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534082553;
        bh=ebF/crHp2BafdiqEYVg7MrJsK9WwkdULIypC+UZo8Ws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iPlIU93jzP5ZkxG73RWhTYE4Y+20J9MwPxmSm1OLhIV74rdVI2QLpZ2vZZqfFfVGT
         L2w/1YyVlQIfQ5E5DjEszeXe37cbOgCZjAS9sTdxB4wNLvZH0ie8hGcgwsyf69AG8E
         /P9VM5/VtWkJITKGY7g8LOTlcVGQETRzQScjW7Rg=
From:   Chao Yu <chao@kernel.org>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/8] staging: erofs: introduce erofs_grab_bio
Date:   Sun, 12 Aug 2018 22:01:43 +0800
Message-Id: <20180812140150.13397-2-chao@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180812140150.13397-1-chao@kernel.org>
References: <20180812140150.13397-1-chao@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Xiang <gaoxiang25@huawei.com>

this patch renames prepare_bio to erofs_grab_bio, and
adds a nofail option in order to retry in the bio allocator
under memory pressure.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 drivers/staging/erofs/data.c      | 12 +++++++++--
 drivers/staging/erofs/internal.h  | 36 +++++++++++++++----------------
 drivers/staging/erofs/unzip_vle.c |  4 ++--
 3 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/erofs/data.c b/drivers/staging/erofs/data.c
index ac263a180253..e0c046df6665 100644
--- a/drivers/staging/erofs/data.c
+++ b/drivers/staging/erofs/data.c
@@ -60,7 +60,8 @@ struct page *erofs_get_meta_page(struct super_block *sb,
 		struct bio *bio;
 		int err;
 
-		bio = prepare_bio(sb, blkaddr, 1, read_endio);
+		bio = erofs_grab_bio(sb, blkaddr, 1, read_endio, true);
+
 		err = bio_add_page(bio, page, PAGE_SIZE, 0);
 		BUG_ON(err != PAGE_SIZE);
 
@@ -278,7 +279,14 @@ static inline struct bio *erofs_read_raw_page(
 		if (nblocks > BIO_MAX_PAGES)
 			nblocks = BIO_MAX_PAGES;
 
-		bio = prepare_bio(inode->i_sb, blknr, nblocks, read_endio);
+		bio = erofs_grab_bio(inode->i_sb,
+			blknr, nblocks, read_endio, false);
+
+		if (IS_ERR(bio)) {
+			err = PTR_ERR(bio);
+			bio = NULL;
+			goto err_out;
+		}
 	}
 
 	err = bio_add_page(bio, page, PAGE_SIZE, 0);
diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index 367b39fe46e5..1353b3ff8401 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -420,26 +420,26 @@ struct erofs_map_blocks {
 #define EROFS_GET_BLOCKS_RAW    0x0001
 
 /* data.c */
-static inline struct bio *prepare_bio(
-	struct super_block *sb,
-	erofs_blk_t blkaddr, unsigned nr_pages,
-	bio_end_io_t endio)
+static inline struct bio *
+erofs_grab_bio(struct super_block *sb,
+	       erofs_blk_t blkaddr, unsigned int nr_pages,
+	       bio_end_io_t endio, bool nofail)
 {
-	gfp_t gfp = GFP_NOIO;
-	struct bio *bio = bio_alloc(gfp, nr_pages);
-
-	if (unlikely(bio == NULL) &&
-		(current->flags & PF_MEMALLOC)) {
-		do {
-			nr_pages /= 2;
-			if (unlikely(!nr_pages)) {
-				bio = bio_alloc(gfp | __GFP_NOFAIL, 1);
-				BUG_ON(bio == NULL);
-				break;
+	const gfp_t gfp = GFP_NOIO;
+	struct bio *bio;
+
+	do {
+		if (nr_pages == 1) {
+			bio = bio_alloc(gfp | (nofail ? __GFP_NOFAIL : 0), 1);
+			if (unlikely(bio == NULL)) {
+				DBG_BUGON(nofail);
+				return ERR_PTR(-ENOMEM);
 			}
-			bio = bio_alloc(gfp, nr_pages);
-		} while (bio == NULL);
-	}
+			break;
+		}
+		bio = bio_alloc(gfp, nr_pages);
+		nr_pages /= 2;
+	} while (unlikely(bio == NULL));
 
 	bio->bi_end_io = endio;
 	bio_set_dev(bio, sb->s_bdev);
diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index 8721f0a41d15..375c1711bb6b 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -1213,8 +1213,8 @@ static bool z_erofs_vle_submit_all(struct super_block *sb,
 		}
 
 		if (bio == NULL) {
-			bio = prepare_bio(sb, first_index + i,
-				BIO_MAX_PAGES, z_erofs_vle_read_endio);
+			bio = erofs_grab_bio(sb, first_index + i,
+				BIO_MAX_PAGES, z_erofs_vle_read_endio, true);
 			bio->bi_private = tagptr_cast_ptr(bi_private);
 
 			++nr_bios;
-- 
2.18.0


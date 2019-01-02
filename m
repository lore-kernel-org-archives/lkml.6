Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AE2C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3161921871
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbfABJIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 04:08:52 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:53731 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729067AbfABJIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 04:08:51 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 816504E0D64F2;
        Wed,  2 Jan 2019 17:08:47 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Wed, 2 Jan 2019
 17:08:40 +0800
From:   sunqiuyang <sunqiuyang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <sunqiuyang@huawei.com>
Subject: [PATCH 2/2] fs: support direct IO in a multi-device FS
Date:   Wed, 2 Jan 2019 17:07:18 +0800
Message-ID: <20190102090718.8115-1-sunqiuyang@huawei.com>
X-Mailer: git-send-email 2.14.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiuyang Sun <sunqiuyang@huawei.com>

Don't use the bdev pointer in struct buffer_head for dio_bio_alloc(),
since it may have been changed to another device in the FS in
get_more_blocks().

Signed-off-by: Qiuyang Sun <sunqiuyang@huawei.com>
---
 fs/direct-io.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index 722d17c..6cd6029 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -99,6 +99,7 @@ struct dio_submit {
 	unsigned cur_page_offset;	/* Offset into it, in bytes */
 	unsigned cur_page_len;		/* Nr of bytes at cur_page_offset */
 	sector_t cur_page_block;	/* Where it starts */
+	struct block_device *cur_page_dev;
 	loff_t cur_page_fs_offset;	/* Offset in file */
 
 	struct iov_iter *iter;
@@ -729,7 +730,7 @@ static int get_more_blocks(struct dio *dio, struct dio_submit *sdio,
  * There is no bio.  Make one now.
  */
 static inline int dio_new_bio(struct dio *dio, struct dio_submit *sdio,
-		sector_t start_sector, struct buffer_head *map_bh)
+		sector_t start_sector)
 {
 	sector_t sector;
 	int ret, nr_pages;
@@ -740,7 +741,7 @@ static inline int dio_new_bio(struct dio *dio, struct dio_submit *sdio,
 	sector = start_sector << (sdio->blkbits - 9);
 	nr_pages = min(sdio->pages_in_io, BIO_MAX_PAGES);
 	BUG_ON(nr_pages <= 0);
-	dio_bio_alloc(dio, sdio, map_bh->b_bdev, sector, nr_pages);
+	dio_bio_alloc(dio, sdio, sdio->cur_page_dev, sector, nr_pages);
 	sdio->boundary = 0;
 out:
 	return ret;
@@ -785,8 +786,7 @@ static inline int dio_bio_add_page(struct dio_submit *sdio)
  * The caller of this function is responsible for removing cur_page from the
  * dio, and for dropping the refcount which came from that presence.
  */
-static inline int dio_send_cur_page(struct dio *dio, struct dio_submit *sdio,
-		struct buffer_head *map_bh)
+static inline int dio_send_cur_page(struct dio *dio, struct dio_submit *sdio)
 {
 	int ret = 0;
 
@@ -815,14 +815,14 @@ static inline int dio_send_cur_page(struct dio *dio, struct dio_submit *sdio,
 	}
 
 	if (sdio->bio == NULL) {
-		ret = dio_new_bio(dio, sdio, sdio->cur_page_block, map_bh);
+		ret = dio_new_bio(dio, sdio, sdio->cur_page_block);
 		if (ret)
 			goto out;
 	}
 
 	if (dio_bio_add_page(sdio) != 0) {
 		dio_bio_submit(dio, sdio);
-		ret = dio_new_bio(dio, sdio, sdio->cur_page_block, map_bh);
+		ret = dio_new_bio(dio, sdio, sdio->cur_page_block);
 		if (ret == 0) {
 			ret = dio_bio_add_page(sdio);
 			BUG_ON(ret != 0);
@@ -878,7 +878,7 @@ static inline int dio_send_cur_page(struct dio *dio, struct dio_submit *sdio,
 	 * If there's a deferred page already there then send it.
 	 */
 	if (sdio->cur_page) {
-		ret = dio_send_cur_page(dio, sdio, map_bh);
+		ret = dio_send_cur_page(dio, sdio);
 		put_page(sdio->cur_page);
 		sdio->cur_page = NULL;
 		if (ret)
@@ -890,6 +890,7 @@ static inline int dio_send_cur_page(struct dio *dio, struct dio_submit *sdio,
 	sdio->cur_page_offset = offset;
 	sdio->cur_page_len = len;
 	sdio->cur_page_block = blocknr;
+	sdio->cur_page_dev = map_bh->b_bdev;
 	sdio->cur_page_fs_offset = sdio->block_in_file << sdio->blkbits;
 out:
 	/*
@@ -897,7 +898,7 @@ static inline int dio_send_cur_page(struct dio *dio, struct dio_submit *sdio,
 	 * avoid metadata seeks.
 	 */
 	if (sdio->boundary) {
-		ret = dio_send_cur_page(dio, sdio, map_bh);
+		ret = dio_send_cur_page(dio, sdio);
 		if (sdio->bio)
 			dio_bio_submit(dio, sdio);
 		put_page(sdio->cur_page);
@@ -1348,7 +1349,7 @@ static inline int drop_refcount(struct dio *dio)
 	if (sdio.cur_page) {
 		ssize_t ret2;
 
-		ret2 = dio_send_cur_page(dio, &sdio, &map_bh);
+		ret2 = dio_send_cur_page(dio, &sdio);
 		if (retval == 0)
 			retval = ret2;
 		put_page(sdio.cur_page);
-- 
1.8.3.1


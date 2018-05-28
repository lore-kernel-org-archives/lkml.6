Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938808AbeE1MYK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:24:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:49048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938034AbeE1LBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:01:32 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <Bart.VanAssche@wdc.com>,
        Shaohua Li <shli@kernel.org>,
        weiping zhang <zhangweiping@didichuxing.com>,
        Yi Zhang <yi.zhang@redhat.com>, Ming Lei <ming.lei@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Kyungchan Koh <kkc6196@fb.com>
Subject: [PATCH 4.14 444/496] block: null_blk: fix Invalid parameters when loading module
Date: Mon, 28 May 2018 12:03:49 +0200
Message-Id: <20180528100338.573484285@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 66231ad3e2886ba99fbf440cea44cab547e5163f ]

On ARM64, the default page size has been 64K on some distributions, and
we should allow ARM64 people to play null_blk.

This patch fixes the issue by extend page bitmap size for supporting
other non-4KB PAGE_SIZE.

Cc: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: Shaohua Li <shli@kernel.org>
Cc: Kyungchan Koh <kkc6196@fb.com>,
Cc: weiping zhang <zhangweiping@didichuxing.com>
Cc: Yi Zhang <yi.zhang@redhat.com>
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/null_blk.c |   46 +++++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

--- a/drivers/block/null_blk.c
+++ b/drivers/block/null_blk.c
@@ -68,6 +68,7 @@ enum nullb_device_flags {
 	NULLB_DEV_FL_CACHE	= 3,
 };
 
+#define MAP_SZ		((PAGE_SIZE >> SECTOR_SHIFT) + 2)
 /*
  * nullb_page is a page in memory for nullb devices.
  *
@@ -82,10 +83,10 @@ enum nullb_device_flags {
  */
 struct nullb_page {
 	struct page *page;
-	unsigned long bitmap;
+	DECLARE_BITMAP(bitmap, MAP_SZ);
 };
-#define NULLB_PAGE_LOCK (sizeof(unsigned long) * 8 - 1)
-#define NULLB_PAGE_FREE (sizeof(unsigned long) * 8 - 2)
+#define NULLB_PAGE_LOCK (MAP_SZ - 1)
+#define NULLB_PAGE_FREE (MAP_SZ - 2)
 
 struct nullb_device {
 	struct nullb *nullb;
@@ -725,7 +726,7 @@ static struct nullb_page *null_alloc_pag
 	if (!t_page->page)
 		goto out_freepage;
 
-	t_page->bitmap = 0;
+	memset(t_page->bitmap, 0, sizeof(t_page->bitmap));
 	return t_page;
 out_freepage:
 	kfree(t_page);
@@ -735,13 +736,20 @@ out:
 
 static void null_free_page(struct nullb_page *t_page)
 {
-	__set_bit(NULLB_PAGE_FREE, &t_page->bitmap);
-	if (test_bit(NULLB_PAGE_LOCK, &t_page->bitmap))
+	__set_bit(NULLB_PAGE_FREE, t_page->bitmap);
+	if (test_bit(NULLB_PAGE_LOCK, t_page->bitmap))
 		return;
 	__free_page(t_page->page);
 	kfree(t_page);
 }
 
+static bool null_page_empty(struct nullb_page *page)
+{
+	int size = MAP_SZ - 2;
+
+	return find_first_bit(page->bitmap, size) == size;
+}
+
 static void null_free_sector(struct nullb *nullb, sector_t sector,
 	bool is_cache)
 {
@@ -756,9 +764,9 @@ static void null_free_sector(struct null
 
 	t_page = radix_tree_lookup(root, idx);
 	if (t_page) {
-		__clear_bit(sector_bit, &t_page->bitmap);
+		__clear_bit(sector_bit, t_page->bitmap);
 
-		if (!t_page->bitmap) {
+		if (null_page_empty(t_page)) {
 			ret = radix_tree_delete_item(root, idx, t_page);
 			WARN_ON(ret != t_page);
 			null_free_page(ret);
@@ -829,7 +837,7 @@ static struct nullb_page *__null_lookup_
 	t_page = radix_tree_lookup(root, idx);
 	WARN_ON(t_page && t_page->page->index != idx);
 
-	if (t_page && (for_write || test_bit(sector_bit, &t_page->bitmap)))
+	if (t_page && (for_write || test_bit(sector_bit, t_page->bitmap)))
 		return t_page;
 
 	return NULL;
@@ -892,10 +900,10 @@ static int null_flush_cache_page(struct
 
 	t_page = null_insert_page(nullb, idx << PAGE_SECTORS_SHIFT, true);
 
-	__clear_bit(NULLB_PAGE_LOCK, &c_page->bitmap);
-	if (test_bit(NULLB_PAGE_FREE, &c_page->bitmap)) {
+	__clear_bit(NULLB_PAGE_LOCK, c_page->bitmap);
+	if (test_bit(NULLB_PAGE_FREE, c_page->bitmap)) {
 		null_free_page(c_page);
-		if (t_page && t_page->bitmap == 0) {
+		if (t_page && null_page_empty(t_page)) {
 			ret = radix_tree_delete_item(&nullb->dev->data,
 				idx, t_page);
 			null_free_page(t_page);
@@ -911,11 +919,11 @@ static int null_flush_cache_page(struct
 
 	for (i = 0; i < PAGE_SECTORS;
 			i += (nullb->dev->blocksize >> SECTOR_SHIFT)) {
-		if (test_bit(i, &c_page->bitmap)) {
+		if (test_bit(i, c_page->bitmap)) {
 			offset = (i << SECTOR_SHIFT);
 			memcpy(dst + offset, src + offset,
 				nullb->dev->blocksize);
-			__set_bit(i, &t_page->bitmap);
+			__set_bit(i, t_page->bitmap);
 		}
 	}
 
@@ -952,10 +960,10 @@ again:
 		 * We found the page which is being flushed to disk by other
 		 * threads
 		 */
-		if (test_bit(NULLB_PAGE_LOCK, &c_pages[i]->bitmap))
+		if (test_bit(NULLB_PAGE_LOCK, c_pages[i]->bitmap))
 			c_pages[i] = NULL;
 		else
-			__set_bit(NULLB_PAGE_LOCK, &c_pages[i]->bitmap);
+			__set_bit(NULLB_PAGE_LOCK, c_pages[i]->bitmap);
 	}
 
 	one_round = 0;
@@ -1008,7 +1016,7 @@ static int copy_to_nullb(struct nullb *n
 		kunmap_atomic(dst);
 		kunmap_atomic(src);
 
-		__set_bit(sector & SECTOR_MASK, &t_page->bitmap);
+		__set_bit(sector & SECTOR_MASK, t_page->bitmap);
 
 		if (is_fua)
 			null_free_sector(nullb, sector, true);
@@ -1922,10 +1930,6 @@ static int __init null_init(void)
 	struct nullb *nullb;
 	struct nullb_device *dev;
 
-	/* check for nullb_page.bitmap */
-	if (sizeof(unsigned long) * 8 - 2 < (PAGE_SIZE >> SECTOR_SHIFT))
-		return -EINVAL;
-
 	if (g_bs > PAGE_SIZE) {
 		pr_warn("null_blk: invalid block size\n");
 		pr_warn("null_blk: defaults block size to %lu\n", PAGE_SIZE);

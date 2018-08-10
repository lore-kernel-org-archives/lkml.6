Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BF3C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0F18223E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:56:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0F18223E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbeHJR0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 13:26:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57818 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726180AbeHJR0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 13:26:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5909981663D5;
        Fri, 10 Aug 2018 14:56:30 +0000 (UTC)
Received: from max.home.com (ovpn-117-44.ams2.redhat.com [10.36.117.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 276A010CD7EA;
        Fri, 10 Aug 2018 14:56:28 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] iomap: Switch to offset_in_page for clarity
Date:   Fri, 10 Aug 2018 16:56:27 +0200
Message-Id: <20180810145627.12266-1-agruenba@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 10 Aug 2018 14:56:30 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 10 Aug 2018 14:56:30 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'agruenba@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of open-coding pos & (PAGE_SIZE - 1) and pos & ~PAGE_MASK, use
the offset_in_page macro.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/iomap.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/iomap.c b/fs/iomap.c
index 13cdcf33e6c0..ae317ac7e925 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -150,7 +150,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 {
 	struct iomap_readpage_ctx *ctx = data;
 	struct page *page = ctx->cur_page;
-	unsigned poff = pos & (PAGE_SIZE - 1);
+	unsigned poff = offset_in_page(pos);
 	unsigned plen = min_t(loff_t, PAGE_SIZE - poff, length);
 	bool is_contig = false;
 	sector_t sector;
@@ -280,7 +280,7 @@ iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
 	loff_t done, ret;
 
 	for (done = 0; done < length; done += ret) {
-		if (ctx->cur_page && ((pos + done) & (PAGE_SIZE - 1)) == 0) {
+		if (ctx->cur_page && offset_in_page(pos + done) == 0) {
 			if (!ctx->cur_page_in_bio)
 				unlock_page(ctx->cur_page);
 			put_page(ctx->cur_page);
@@ -382,9 +382,9 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len,
 	loff_t block_size = i_blocksize(inode);
 	loff_t block_start = pos & ~(block_size - 1);
 	loff_t block_end = (pos + len + block_size - 1) & ~(block_size - 1);
-	unsigned poff = block_start & (PAGE_SIZE - 1);
+	unsigned poff = offset_in_page(block_start);
 	unsigned plen = min_t(loff_t, PAGE_SIZE - poff, block_end - block_start);
-	unsigned from = pos & (PAGE_SIZE - 1), to = from + len;
+	unsigned from = offset_in_page(pos), to = from + len;
 
 	WARN_ON_ONCE(i_blocksize(inode) < PAGE_SIZE);
 
@@ -538,7 +538,7 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		unsigned long bytes;	/* Bytes to write to page */
 		size_t copied;		/* Bytes copied from user */
 
-		offset = (pos & (PAGE_SIZE - 1));
+		offset = offset_in_page(pos);
 		bytes = min_t(unsigned long, PAGE_SIZE - offset,
 						iov_iter_count(i));
 again:
@@ -652,7 +652,7 @@ iomap_dirty_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		unsigned long offset;	/* Offset into pagecache page */
 		unsigned long bytes;	/* Bytes to write to page */
 
-		offset = (pos & (PAGE_SIZE - 1));
+		offset = offset_in_page(pos);
 		bytes = min_t(loff_t, PAGE_SIZE - offset, length);
 
 		rpage = __iomap_read_page(inode, pos);
@@ -744,7 +744,7 @@ iomap_zero_range_actor(struct inode *inode, loff_t pos, loff_t count,
 	do {
 		unsigned offset, bytes;
 
-		offset = pos & (PAGE_SIZE - 1); /* Within page */
+		offset = offset_in_page(pos);
 		bytes = min_t(loff_t, PAGE_SIZE - offset, count);
 
 		if (IS_DAX(inode))
@@ -837,7 +837,7 @@ int iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
 
 	/* page is wholly or partially inside EOF */
 	if (((page->index + 1) << PAGE_SHIFT) > size)
-		length = size & ~PAGE_MASK;
+		length = offset_in_page(size);
 	else
 		length = PAGE_SIZE;
 
@@ -1000,7 +1000,7 @@ page_seek_hole_data(struct inode *inode, struct page *page, loff_t *lastoff,
 		goto out_unlock_not_found;
 
 	for (off = 0; off < PAGE_SIZE; off += bsize) {
-		if ((*lastoff & ~PAGE_MASK) >= off + bsize)
+		if (offset_in_page(*lastoff) >= off + bsize)
 			continue;
 		if (ops->is_partially_uptodate(page, off, bsize) == seek_data) {
 			unlock_page(page);
-- 
2.17.1


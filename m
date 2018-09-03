Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132C1C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4FDF20779
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4FDF20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbeICV0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:26:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39456 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729077AbeICV0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:26:17 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DE040D02;
        Mon,  3 Sep 2018 17:05:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Anatoly Trosinenko <anatoly.trosinenko@gmail.com>,
        Willy Tarreau <w@1wt.eu>, Al Viro <viro@zeniv.linux.org.uk>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 041/107] squashfs metadata 2: electric boogaloo
Date:   Mon,  3 Sep 2018 18:56:05 +0200
Message-Id: <20180903165639.273236136@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165637.293735109@linuxfoundation.org>
References: <20180903165637.293735109@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

[ Upstream commit cdbb65c4c7ead680ebe54f4f0d486e2847a500ea ]

Anatoly continues to find issues with fuzzed squashfs images.

This time, corrupt, missing, or undersized data for the page filling
wasn't checked for, because the squashfs_{copy,read}_cache() functions
did the squashfs_copy_data() call without checking the resulting data
size.

Which could result in the page cache pages being incompletely filled in,
and no error indication to the user space reading garbage data.

So make a helper function for the "fill in pages" case, because the
exact same incomplete sequence existed in two places.

[ I should have made a squashfs branch for these things, but I didn't
  intend to start doing them in the first place.

  My historical connection through cramfs is why I got into looking at
  these issues at all, and every time I (continue to) think it's a
  one-off.

  Because _this_ time is always the last time. Right?   - Linus ]

Reported-by: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Tested-by: Willy Tarreau <w@1wt.eu>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Phillip Lougher <phillip@squashfs.org.uk>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/squashfs/file.c        |   25 ++++++++++++++++++-------
 fs/squashfs/file_direct.c |    8 +-------
 fs/squashfs/squashfs.h    |    1 +
 3 files changed, 20 insertions(+), 14 deletions(-)

--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -374,13 +374,29 @@ static int read_blocklist(struct inode *
 	return squashfs_block_size(size);
 }
 
+void squashfs_fill_page(struct page *page, struct squashfs_cache_entry *buffer, int offset, int avail)
+{
+	int copied;
+	void *pageaddr;
+
+	pageaddr = kmap_atomic(page);
+	copied = squashfs_copy_data(pageaddr, buffer, offset, avail);
+	memset(pageaddr + copied, 0, PAGE_SIZE - copied);
+	kunmap_atomic(pageaddr);
+
+	flush_dcache_page(page);
+	if (copied == avail)
+		SetPageUptodate(page);
+	else
+		SetPageError(page);
+}
+
 /* Copy data into page cache  */
 void squashfs_copy_cache(struct page *page, struct squashfs_cache_entry *buffer,
 	int bytes, int offset)
 {
 	struct inode *inode = page->mapping->host;
 	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
-	void *pageaddr;
 	int i, mask = (1 << (msblk->block_log - PAGE_SHIFT)) - 1;
 	int start_index = page->index & ~mask, end_index = start_index | mask;
 
@@ -406,12 +422,7 @@ void squashfs_copy_cache(struct page *pa
 		if (PageUptodate(push_page))
 			goto skip_page;
 
-		pageaddr = kmap_atomic(push_page);
-		squashfs_copy_data(pageaddr, buffer, offset, avail);
-		memset(pageaddr + avail, 0, PAGE_SIZE - avail);
-		kunmap_atomic(pageaddr);
-		flush_dcache_page(push_page);
-		SetPageUptodate(push_page);
+		squashfs_fill_page(push_page, buffer, offset, avail);
 skip_page:
 		unlock_page(push_page);
 		if (i != page->index)
--- a/fs/squashfs/file_direct.c
+++ b/fs/squashfs/file_direct.c
@@ -144,7 +144,6 @@ static int squashfs_read_cache(struct pa
 	struct squashfs_cache_entry *buffer = squashfs_get_datablock(i->i_sb,
 						 block, bsize);
 	int bytes = buffer->length, res = buffer->error, n, offset = 0;
-	void *pageaddr;
 
 	if (res) {
 		ERROR("Unable to read page, block %llx, size %x\n", block,
@@ -159,12 +158,7 @@ static int squashfs_read_cache(struct pa
 		if (page[n] == NULL)
 			continue;
 
-		pageaddr = kmap_atomic(page[n]);
-		squashfs_copy_data(pageaddr, buffer, offset, avail);
-		memset(pageaddr + avail, 0, PAGE_SIZE - avail);
-		kunmap_atomic(pageaddr);
-		flush_dcache_page(page[n]);
-		SetPageUptodate(page[n]);
+		squashfs_fill_page(page[n], buffer, offset, avail);
 		unlock_page(page[n]);
 		if (page[n] != target_page)
 			put_page(page[n]);
--- a/fs/squashfs/squashfs.h
+++ b/fs/squashfs/squashfs.h
@@ -67,6 +67,7 @@ extern __le64 *squashfs_read_fragment_in
 				u64, u64, unsigned int);
 
 /* file.c */
+void squashfs_fill_page(struct page *, struct squashfs_cache_entry *, int, int);
 void squashfs_copy_cache(struct page *, struct squashfs_cache_entry *, int,
 				int);
 



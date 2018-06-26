Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086E0C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B121E269EA
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W0J0/gC4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B121E269EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933699AbeFZR33 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:29:29 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38607 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754091AbeFZR3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:29:24 -0400
Received: by mail-pf0-f196.google.com with SMTP id a1-v6so4545694pfi.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 10:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XqThHeG+onI6r0VecFxtvcxhaHWoDCEeuUZrNCn/7zQ=;
        b=W0J0/gC4agPgI3XFXXoyFvJPfgOxO/Y6buIi5VuOYkFgahYRy2lACJ+SFW+jXsWB6K
         bm2cxupzYKiQGEdHl3vGFc7cz9zgYzqy6joXLG7b2jcphDt+fLn5kDgvpvJTdpIKxdec
         DDbxLOgM9bs/xCjZt3I30v3kcCBlJ3sO2I4+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XqThHeG+onI6r0VecFxtvcxhaHWoDCEeuUZrNCn/7zQ=;
        b=b1fqS+tAUzBj1J/7i4OwnyjE2Rfir8JnosOzXEcQLwssHkEVXROpQjFL6+tjK+CvZv
         cNLRPe5CWCI7Evz5hrEtE6pcNMwnzls1NsWq2dGUZ2QQqtVYzLdSyMlxPfJIPaQKCAit
         HwexDPl3AUHyHauc2UYtuf2vgcW2X2K97j6+0py1VdpHSqAYA3P/LuehAy7uNAMBHqza
         +4FgqDPZ4CbNPaHP4UB/dfsPA/+ApjMxY/rB3AEisv28gBVWemERJu+AefCLboggkY6a
         edRzDAAopsMjlTWHmPi0kVYnrQWntwZd7hA5f9M/1PImcnbtN4uWLjcrqi0aHKWG/IUb
         SUFQ==
X-Gm-Message-State: APt69E1mws35Vh/P80MDbwLgYn4xCWQQT1IlbaujtaZvI/hkiphJms9q
        qqE5GzwHuEduxogQ9Y6ZzLdleQ==
X-Google-Smtp-Source: AAOMgpee0xb0TGKhxwfct6SjDgvBVi0tCnfoapoziE4VjMqAwl6cmgVuqjGsYal+40QKqdEA9FKtYQ==
X-Received: by 2002:a63:b00f:: with SMTP id h15-v6mr1668696pgf.442.1530034163631;
        Tue, 26 Jun 2018 10:29:23 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id l14-v6sm3631902pgc.0.2018.06.26.10.29.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 10:29:20 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] NTFS: decompress: Remove VLA usage
Date:   Tue, 26 Jun 2018 10:29:08 -0700
Message-Id: <20180626172909.41453-3-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626172909.41453-1-keescook@chromium.org>
References: <20180626172909.41453-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this moves
the stack buffer used during decompression to be allocated externally.
The existing "dest_max_index" used in the VLA is bounded by cb_max_page.
cb_max_page is bounded by max_page, and max_page is bounded by nr_pages.
Since nr_pages is used for the "pages" allocation, it can similarly
be used for the "completed_pages" allocation and passed into the
decompression function. The error paths are updated to free the new
allocation.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Cc: Anton Altaparmakov <anton@tuxera.com>
Cc: linux-ntfs-dev@lists.sourceforge.net
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/ntfs/compress.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c
index fbd0090d7d0c..df7c32b5fac7 100644
--- a/fs/ntfs/compress.c
+++ b/fs/ntfs/compress.c
@@ -128,6 +128,7 @@ static inline void handle_bounds_compressed_page(struct page *page,
 /**
  * ntfs_decompress - decompress a compression block into an array of pages
  * @dest_pages:		destination array of pages
+ * @completed_pages:	scratch space to track completed pages
  * @dest_index:		current index into @dest_pages (IN/OUT)
  * @dest_ofs:		current offset within @dest_pages[@dest_index] (IN/OUT)
  * @dest_max_index:	maximum index into @dest_pages (IN)
@@ -162,10 +163,10 @@ static inline void handle_bounds_compressed_page(struct page *page,
  * Note to hackers: This function may not sleep until it has finished accessing
  * the compression block @cb_start as it is a per-CPU buffer.
  */
-static int ntfs_decompress(struct page *dest_pages[], int *dest_index,
-		int *dest_ofs, const int dest_max_index, const int dest_max_ofs,
-		const int xpage, char *xpage_done, u8 *const cb_start,
-		const u32 cb_size, const loff_t i_size,
+static int ntfs_decompress(struct page *dest_pages[], int completed_pages[],
+		int *dest_index, int *dest_ofs, const int dest_max_index,
+		const int dest_max_ofs, const int xpage, char *xpage_done,
+		u8 *const cb_start, const u32 cb_size, const loff_t i_size,
 		const s64 initialized_size)
 {
 	/*
@@ -190,9 +191,6 @@ static int ntfs_decompress(struct page *dest_pages[], int *dest_index,
 	/* Variables for tag and token parsing. */
 	u8 tag;			/* Current tag. */
 	int token;		/* Loop counter for the eight tokens in tag. */
-
-	/* Need this because we can't sleep, so need two stages. */
-	int completed_pages[dest_max_index - *dest_index + 1];
 	int nr_completed_pages = 0;
 
 	/* Default error code. */
@@ -516,6 +514,7 @@ int ntfs_read_compressed_block(struct page *page)
 	unsigned int cb_clusters, cb_max_ofs;
 	int block, max_block, cb_max_page, bhs_size, nr_bhs, err = 0;
 	struct page **pages;
+	int *completed_pages;
 	unsigned char xpage_done = 0;
 
 	ntfs_debug("Entering, page->index = 0x%lx, cb_size = 0x%x, nr_pages = "
@@ -528,14 +527,16 @@ int ntfs_read_compressed_block(struct page *page)
 	BUG_ON(ni->name_len);
 
 	pages = kmalloc_array(nr_pages, sizeof(struct page *), GFP_NOFS);
+	completed_pages = kmalloc_array(nr_pages + 1, sizeof(int), GFP_NOFS);
 
 	/* Allocate memory to store the buffer heads we need. */
 	bhs_size = cb_size / block_size * sizeof(struct buffer_head *);
 	bhs = kmalloc(bhs_size, GFP_NOFS);
 
-	if (unlikely(!pages || !bhs)) {
+	if (unlikely(!pages || !bhs || !completed_pages)) {
 		kfree(bhs);
 		kfree(pages);
+		kfree(completed_pages);
 		unlock_page(page);
 		ntfs_error(vol->sb, "Failed to allocate internal buffers.");
 		return -ENOMEM;
@@ -562,6 +563,7 @@ int ntfs_read_compressed_block(struct page *page)
 	if (xpage >= max_page) {
 		kfree(bhs);
 		kfree(pages);
+		kfree(completed_pages);
 		zero_user(page, 0, PAGE_SIZE);
 		ntfs_debug("Compressed read outside i_size - truncated?");
 		SetPageUptodate(page);
@@ -854,10 +856,10 @@ int ntfs_read_compressed_block(struct page *page)
 		unsigned int prev_cur_page = cur_page;
 
 		ntfs_debug("Found compressed compression block.");
-		err = ntfs_decompress(pages, &cur_page, &cur_ofs,
-				cb_max_page, cb_max_ofs, xpage, &xpage_done,
-				cb_pos,	cb_size - (cb_pos - cb), i_size,
-				initialized_size);
+		err = ntfs_decompress(pages, completed_pages, &cur_page,
+				&cur_ofs, cb_max_page, cb_max_ofs, xpage,
+				&xpage_done, cb_pos, cb_size - (cb_pos - cb),
+				i_size, initialized_size);
 		/*
 		 * We can sleep from now on, lock already dropped by
 		 * ntfs_decompress().
@@ -912,6 +914,7 @@ int ntfs_read_compressed_block(struct page *page)
 
 	/* We no longer need the list of pages. */
 	kfree(pages);
+	kfree(completed_pages);
 
 	/* If we have completed the requested page, we return success. */
 	if (likely(xpage_done))
@@ -956,5 +959,6 @@ int ntfs_read_compressed_block(struct page *page)
 		}
 	}
 	kfree(pages);
+	kfree(completed_pages);
 	return -EIO;
 }
-- 
2.17.1


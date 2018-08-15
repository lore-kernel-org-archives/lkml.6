Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D2FC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC1CC20841
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UB2tmptK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC1CC20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbeHPCVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 22:21:03 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41679 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbeHPCVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 22:21:03 -0400
Received: by mail-yw1-f68.google.com with SMTP id q129-v6so2137239ywg.8;
        Wed, 15 Aug 2018 16:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1UTc2L4LhkJkY7VTEHGfee3HIFoGSa5nro7rtkd8hrI=;
        b=UB2tmptKf4qrLZgi2wPExbO8AwamEwToluLgc3/pUONJ6LesZFeuH+cttQ5EVQYfcy
         02kUYE/sFmHDpvlol+hVe0Do0/QUu7AjLUDpTLi31MsQTsCcQjYkiefOWbdkmzUt7Q9S
         cS2j8p2LMLMltwFuiTSEDjYOn8YH2M9F6BYEzOYN+KE6zJ9kMbDIQXCE31E0iLuGRbSD
         FD2j+1F0sSJoVK9HchZ4PKp6NLCnLciQmLsVkAsGjazeqn5umk321/8/4SnU12v0YY0z
         EM6ChXax1ZEDrv5Xb1+kt33bSM54v4aZD8ad3Q8ep50AZAOPfbacqgcecBPYun69DLF/
         2feA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1UTc2L4LhkJkY7VTEHGfee3HIFoGSa5nro7rtkd8hrI=;
        b=ZgasGYtUuNOVgVK8Ng0ryY8Q3rqeEN8QdUjysNut6OUfQwajRga9N2mg+f0NZY9T0M
         PL4NXWiuiKIhIVxfU6fNXwRuNpJ7QOHuEKEHhrkRa1KXWgXfLL4dghRFodzV7mQ8avNx
         0jCVY3YSS/Yg/VTzYDkme2ZuPXSePckPA9TbroN6fbqYAtkfS7XT57wPtCiEe347HKDY
         XomdwpVOcZSUzdhJsl2k2U30GRaVhlCenEcvGrBB19wv3/cC8sxQ46bIAEabcKTeFr6Y
         kgQrMgeB6zxyMTzNbzeqfl3A5iLGs/re4HfJfl6Ql9b0Kr3+w7UWgT4tGMTB137ugqoQ
         BPHw==
X-Gm-Message-State: AOUpUlFBs7BcYqNWNJvYSvj7Bx5HCco3aNipzM0fj5Whj7GNnpcyt6Kh
        viGopzz8jr5zPUU1gFJp+r30Atw=
X-Google-Smtp-Source: AA+uWPzHzCdzmTw8SE06QnSm5RBmWqDstMFAXC9WFNfpK+J159Y/J+qGA/7EhLxSWDoMjNL8F/guhg==
X-Received: by 2002:a81:9251:: with SMTP id j78-v6mr16220219ywg.5.1534375599343;
        Wed, 15 Aug 2018 16:26:39 -0700 (PDT)
Received: from localhost.localdomain (c-71-234-172-214.hsd1.vt.comcast.net. [71.234.172.214])
        by smtp.gmail.com with ESMTPSA id h10-v6sm6204361ywa.35.2018.08.15.16.26.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 16:26:38 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Cc:     Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 1/2] fs: Break generic_file_buffered_read up into multiple functions
Date:   Wed, 15 Aug 2018 19:26:31 -0400
Message-Id: <20180815232632.32548-2-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180815232632.32548-1-kent.overstreet@gmail.com>
References: <20180815232632.32548-1-kent.overstreet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is prep work for changing generic_file_buffered_read() to use
find_get_pages_contig() to batch up all the pagecache lookups.

This patch should be functionally identical to the existing code and
changes as little as of the flow control as possible. More refactoring
could be done, this patch is intended to be relatively minimal.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 mm/filemap.c | 418 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 228 insertions(+), 190 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index c7723bbbbd..308bdd466f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2110,6 +2110,210 @@ static void shrink_readahead_size_eio(struct file *filp,
 	ra->ra_pages /= 4;
 }
 
+static int generic_file_buffered_read_page_ok(struct kiocb *iocb,
+			struct iov_iter *iter,
+			struct page *page)
+{
+	struct address_space *mapping = iocb->ki_filp->f_mapping;
+	struct inode *inode = mapping->host;
+	struct file_ra_state *ra = &iocb->ki_filp->f_ra;
+	unsigned offset = iocb->ki_pos & ~PAGE_MASK;
+	unsigned bytes, copied;
+	loff_t isize, end_offset;
+
+	BUG_ON(iocb->ki_pos >> PAGE_SHIFT != page->index);
+
+	/*
+	 * i_size must be checked after we know the page is Uptodate.
+	 *
+	 * Checking i_size after the check allows us to calculate
+	 * the correct value for "bytes", which means the zero-filled
+	 * part of the page is not copied back to userspace (unless
+	 * another truncate extends the file - this is desired though).
+	 */
+
+	isize = i_size_read(inode);
+	if (unlikely(iocb->ki_pos >= isize))
+		return 1;
+
+	end_offset = min_t(loff_t, isize, iocb->ki_pos + iter->count);
+
+	bytes = min_t(loff_t, end_offset - iocb->ki_pos, PAGE_SIZE - offset);
+
+	/* If users can be writing to this page using arbitrary
+	 * virtual addresses, take care about potential aliasing
+	 * before reading the page on the kernel side.
+	 */
+	if (mapping_writably_mapped(mapping))
+		flush_dcache_page(page);
+
+	/*
+	 * Ok, we have the page, and it's up-to-date, so
+	 * now we can copy it to user space...
+	 */
+
+	copied = copy_page_to_iter(page, offset, bytes, iter);
+
+	iocb->ki_pos += copied;
+
+	/*
+	 * When a sequential read accesses a page several times,
+	 * only mark it as accessed the first time.
+	 */
+	if (iocb->ki_pos >> PAGE_SHIFT != ra->prev_pos >> PAGE_SHIFT)
+		mark_page_accessed(page);
+
+	ra->prev_pos = iocb->ki_pos;
+
+	if (copied < bytes)
+		return -EFAULT;
+
+	return !iov_iter_count(iter) || iocb->ki_pos == isize;
+}
+
+static struct page *
+generic_file_buffered_read_readpage(struct file *filp,
+				    struct address_space *mapping,
+				    struct page *page)
+{
+	struct file_ra_state *ra = &filp->f_ra;
+	int error;
+
+	/*
+	 * A previous I/O error may have been due to temporary
+	 * failures, eg. multipath errors.
+	 * PG_error will be set again if readpage fails.
+	 */
+	ClearPageError(page);
+	/* Start the actual read. The read will unlock the page. */
+	error = mapping->a_ops->readpage(filp, page);
+
+	if (unlikely(error)) {
+		put_page(page);
+		return error != AOP_TRUNCATED_PAGE ? ERR_PTR(error) : NULL;
+	}
+
+	if (!PageUptodate(page)) {
+		error = lock_page_killable(page);
+		if (unlikely(error)) {
+			put_page(page);
+			return ERR_PTR(error);
+		}
+		if (!PageUptodate(page)) {
+			if (page->mapping == NULL) {
+				/*
+				 * invalidate_mapping_pages got it
+				 */
+				unlock_page(page);
+				put_page(page);
+				return NULL;
+			}
+			unlock_page(page);
+			shrink_readahead_size_eio(filp, ra);
+			put_page(page);
+			return ERR_PTR(-EIO);
+		}
+		unlock_page(page);
+	}
+
+	return page;
+}
+
+static struct page *
+generic_file_buffered_read_pagenotuptodate(struct file *filp,
+					   struct iov_iter *iter,
+					   struct page *page,
+					   loff_t pos, loff_t count)
+{
+	struct address_space *mapping = filp->f_mapping;
+	struct inode *inode = mapping->host;
+	int error;
+
+	/*
+	 * See comment in do_read_cache_page on why
+	 * wait_on_page_locked is used to avoid unnecessarily
+	 * serialisations and why it's safe.
+	 */
+	error = wait_on_page_locked_killable(page);
+	if (unlikely(error)) {
+		put_page(page);
+		return ERR_PTR(error);
+	}
+
+	if (PageUptodate(page))
+		return page;
+
+	if (inode->i_blkbits == PAGE_SHIFT ||
+	    !mapping->a_ops->is_partially_uptodate)
+		goto page_not_up_to_date;
+	/* pipes can't handle partially uptodate pages */
+	if (unlikely(iter->type & ITER_PIPE))
+		goto page_not_up_to_date;
+	if (!trylock_page(page))
+		goto page_not_up_to_date;
+	/* Did it get truncated before we got the lock? */
+	if (!page->mapping)
+		goto page_not_up_to_date_locked;
+
+	if (!mapping->a_ops->is_partially_uptodate(page,
+				pos & ~PAGE_MASK, count))
+		goto page_not_up_to_date_locked;
+	unlock_page(page);
+	return page;
+
+page_not_up_to_date:
+	/* Get exclusive access to the page ... */
+	error = lock_page_killable(page);
+	if (unlikely(error)) {
+		put_page(page);
+		return ERR_PTR(error);
+	}
+
+page_not_up_to_date_locked:
+	/* Did it get truncated before we got the lock? */
+	if (!page->mapping) {
+		unlock_page(page);
+		put_page(page);
+		return NULL;
+	}
+
+	/* Did somebody else fill it already? */
+	if (PageUptodate(page)) {
+		unlock_page(page);
+		return page;
+	}
+
+	return generic_file_buffered_read_readpage(filp, mapping, page);
+}
+
+static struct page *
+generic_file_buffered_read_no_cached_page(struct kiocb *iocb,
+					  struct iov_iter *iter)
+{
+	struct file *filp = iocb->ki_filp;
+	struct address_space *mapping = filp->f_mapping;
+	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
+	struct page *page;
+	int error;
+
+	/*
+	 * Ok, it wasn't cached, so we need to create a new
+	 * page..
+	 */
+	page = page_cache_alloc(mapping);
+	if (!page)
+		return ERR_PTR(-ENOMEM);
+
+	error = add_to_page_cache_lru(page, mapping, index,
+				      mapping_gfp_constraint(mapping, GFP_KERNEL));
+	if (error) {
+		put_page(page);
+		return error != -EEXIST ? ERR_PTR(error) : NULL;
+	}
+
+	return generic_file_buffered_read_readpage(filp, mapping, page);
+}
+
 /**
  * generic_file_buffered_read - generic file read routine
  * @iocb:	the iocb to read
@@ -2129,29 +2333,19 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 	struct address_space *mapping = filp->f_mapping;
 	struct inode *inode = mapping->host;
 	struct file_ra_state *ra = &filp->f_ra;
-	loff_t *ppos = &iocb->ki_pos;
-	pgoff_t index;
+	size_t orig_count = iov_iter_count(iter);
 	pgoff_t last_index;
-	pgoff_t prev_index;
-	unsigned long offset;      /* offset into pagecache page */
-	unsigned int prev_offset;
 	int error = 0;
 
-	if (unlikely(*ppos >= inode->i_sb->s_maxbytes))
+	if (unlikely(iocb->ki_pos >= inode->i_sb->s_maxbytes))
 		return 0;
 	iov_iter_truncate(iter, inode->i_sb->s_maxbytes);
 
-	index = *ppos >> PAGE_SHIFT;
-	prev_index = ra->prev_pos >> PAGE_SHIFT;
-	prev_offset = ra->prev_pos & (PAGE_SIZE-1);
-	last_index = (*ppos + iter->count + PAGE_SIZE-1) >> PAGE_SHIFT;
-	offset = *ppos & ~PAGE_MASK;
+	last_index = (iocb->ki_pos + iter->count + PAGE_SIZE-1) >> PAGE_SHIFT;
 
 	for (;;) {
+		pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
 		struct page *page;
-		pgoff_t end_index;
-		loff_t isize;
-		unsigned long nr, ret;
 
 		cond_resched();
 find_page:
@@ -2168,8 +2362,15 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 					ra, filp,
 					index, last_index - index);
 			page = find_get_page(mapping, index);
-			if (unlikely(page == NULL))
-				goto no_cached_page;
+			if (unlikely(page == NULL)) {
+				page = generic_file_buffered_read_no_cached_page(iocb, iter);
+				if (!page)
+					goto find_page;
+				if (IS_ERR(page)) {
+					error = PTR_ERR(page);
+					goto out;
+				}
+			}
 		}
 		if (PageReadahead(page)) {
 			page_cache_async_readahead(mapping,
@@ -2179,199 +2380,36 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		if (!PageUptodate(page)) {
 			if (iocb->ki_flags & IOCB_NOWAIT) {
 				put_page(page);
-				goto would_block;
-			}
-
-			/*
-			 * See comment in do_read_cache_page on why
-			 * wait_on_page_locked is used to avoid unnecessarily
-			 * serialisations and why it's safe.
-			 */
-			error = wait_on_page_locked_killable(page);
-			if (unlikely(error))
-				goto readpage_error;
-			if (PageUptodate(page))
-				goto page_ok;
-
-			if (inode->i_blkbits == PAGE_SHIFT ||
-					!mapping->a_ops->is_partially_uptodate)
-				goto page_not_up_to_date;
-			/* pipes can't handle partially uptodate pages */
-			if (unlikely(iter->type & ITER_PIPE))
-				goto page_not_up_to_date;
-			if (!trylock_page(page))
-				goto page_not_up_to_date;
-			/* Did it get truncated before we got the lock? */
-			if (!page->mapping)
-				goto page_not_up_to_date_locked;
-			if (!mapping->a_ops->is_partially_uptodate(page,
-							offset, iter->count))
-				goto page_not_up_to_date_locked;
-			unlock_page(page);
-		}
-page_ok:
-		/*
-		 * i_size must be checked after we know the page is Uptodate.
-		 *
-		 * Checking i_size after the check allows us to calculate
-		 * the correct value for "nr", which means the zero-filled
-		 * part of the page is not copied back to userspace (unless
-		 * another truncate extends the file - this is desired though).
-		 */
-
-		isize = i_size_read(inode);
-		end_index = (isize - 1) >> PAGE_SHIFT;
-		if (unlikely(!isize || index > end_index)) {
-			put_page(page);
-			goto out;
-		}
-
-		/* nr is the maximum number of bytes to copy from this page */
-		nr = PAGE_SIZE;
-		if (index == end_index) {
-			nr = ((isize - 1) & ~PAGE_MASK) + 1;
-			if (nr <= offset) {
-				put_page(page);
+				error = -EAGAIN;
 				goto out;
 			}
-		}
-		nr = nr - offset;
-
-		/* If users can be writing to this page using arbitrary
-		 * virtual addresses, take care about potential aliasing
-		 * before reading the page on the kernel side.
-		 */
-		if (mapping_writably_mapped(mapping))
-			flush_dcache_page(page);
-
-		/*
-		 * When a sequential read accesses a page several times,
-		 * only mark it as accessed the first time.
-		 */
-		if (prev_index != index || offset != prev_offset)
-			mark_page_accessed(page);
-		prev_index = index;
-
-		/*
-		 * Ok, we have the page, and it's up-to-date, so
-		 * now we can copy it to user space...
-		 */
-
-		ret = copy_page_to_iter(page, offset, nr, iter);
-		offset += ret;
-		index += offset >> PAGE_SHIFT;
-		offset &= ~PAGE_MASK;
-		prev_offset = offset;
 
-		put_page(page);
-		written += ret;
-		if (!iov_iter_count(iter))
-			goto out;
-		if (ret < nr) {
-			error = -EFAULT;
-			goto out;
-		}
-		continue;
-
-page_not_up_to_date:
-		/* Get exclusive access to the page ... */
-		error = lock_page_killable(page);
-		if (unlikely(error))
-			goto readpage_error;
-
-page_not_up_to_date_locked:
-		/* Did it get truncated before we got the lock? */
-		if (!page->mapping) {
-			unlock_page(page);
-			put_page(page);
-			continue;
-		}
-
-		/* Did somebody else fill it already? */
-		if (PageUptodate(page)) {
-			unlock_page(page);
-			goto page_ok;
-		}
-
-readpage:
-		/*
-		 * A previous I/O error may have been due to temporary
-		 * failures, eg. multipath errors.
-		 * PG_error will be set again if readpage fails.
-		 */
-		ClearPageError(page);
-		/* Start the actual read. The read will unlock the page. */
-		error = mapping->a_ops->readpage(filp, page);
-
-		if (unlikely(error)) {
-			if (error == AOP_TRUNCATED_PAGE) {
-				put_page(page);
-				error = 0;
+			page = generic_file_buffered_read_pagenotuptodate(filp,
+					iter, page, iocb->ki_pos, iter->count);
+			if (!page)
 				goto find_page;
+			if (IS_ERR(page)) {
+				error = PTR_ERR(page);
+				goto out;
 			}
-			goto readpage_error;
-		}
-
-		if (!PageUptodate(page)) {
-			error = lock_page_killable(page);
-			if (unlikely(error))
-				goto readpage_error;
-			if (!PageUptodate(page)) {
-				if (page->mapping == NULL) {
-					/*
-					 * invalidate_mapping_pages got it
-					 */
-					unlock_page(page);
-					put_page(page);
-					goto find_page;
-				}
-				unlock_page(page);
-				shrink_readahead_size_eio(filp, ra);
-				error = -EIO;
-				goto readpage_error;
-			}
-			unlock_page(page);
 		}
 
-		goto page_ok;
-
-readpage_error:
-		/* UHHUH! A synchronous read error occurred. Report it */
+		error = generic_file_buffered_read_page_ok(iocb, iter, page);
 		put_page(page);
-		goto out;
 
-no_cached_page:
-		/*
-		 * Ok, it wasn't cached, so we need to create a new
-		 * page..
-		 */
-		page = page_cache_alloc(mapping);
-		if (!page) {
-			error = -ENOMEM;
-			goto out;
-		}
-		error = add_to_page_cache_lru(page, mapping, index,
-				mapping_gfp_constraint(mapping, GFP_KERNEL));
 		if (error) {
-			put_page(page);
-			if (error == -EEXIST) {
+			if (error > 0)
 				error = 0;
-				goto find_page;
-			}
 			goto out;
 		}
-		goto readpage;
 	}
 
 would_block:
 	error = -EAGAIN;
 out:
-	ra->prev_pos = prev_index;
-	ra->prev_pos <<= PAGE_SHIFT;
-	ra->prev_pos |= prev_offset;
-
-	*ppos = ((loff_t)index << PAGE_SHIFT) + offset;
 	file_accessed(filp);
+	written += orig_count - iov_iter_count(iter);
+
 	return written ? written : error;
 }
 
-- 
2.18.0


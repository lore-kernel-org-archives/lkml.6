Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F7BC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ADA320665
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfAGWdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 17:33:22 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:58856 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfAGWdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 17:33:21 -0500
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net [24.6.170.16])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id ACC0F4A4;
        Mon,  7 Jan 2019 22:33:20 +0000 (UTC)
Date:   Mon, 7 Jan 2019 14:33:19 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Remove redundant test from find_get_pages_contig
Message-Id: <20190107143319.c74593a70c86441b80e7cccc@linux-foundation.org>
In-Reply-To: <20190107200224.13260-1-willy@infradead.org>
References: <20190107200224.13260-1-willy@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  7 Jan 2019 12:02:24 -0800 Matthew Wilcox <willy@infradead.org> wrote:

> After we establish a reference on the page, we check the pointer continues
> to be in the correct position in i_pages.  There's no need to check the
> page->mapping or page->index afterwards; if those can change after we've
> got the reference, they can change after we return the page to the caller.

But that isn't what the comment says.

> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1837,16 +1837,6 @@ unsigned find_get_pages_contig(struct address_space *mapping, pgoff_t index,
>  		if (unlikely(page != xas_reload(&xas)))
>  			goto put_page;
>  
> -		/*
> -		 * must check mapping and index after taking the ref.
> -		 * otherwise we can get both false positives and false
> -		 * negatives, which is just confusing to the caller.
> -		 */
> -		if (!page->mapping || page_to_pgoff(page) != xas.xa_index) {
> -			put_page(page);
> -			break;
> -		}

The assertion here is that the page's state can alter before we take
the ref but not afterwards.  Which is contrary to your assertion that
"they can change after we return the page to the caller".

This:

commit 9cbb4cb21b19fff46cf1174d0ed699ef710e641c
Author:     Nick Piggin <npiggin@kernel.dk>
AuthorDate: Thu Jan 13 15:45:51 2011 -0800
Commit:     Linus Torvalds <torvalds@linux-foundation.org>
CommitDate: Thu Jan 13 17:32:32 2011 -0800

    mm: find_get_pages_contig fixlet
    
    Testing ->mapping and ->index without a ref is not stable as the page
    may have been reused at this point.
    
    Signed-off-by: Nick Piggin <npiggin@kernel.dk>
    Reviewed-by: Wu Fengguang <fengguang.wu@intel.com>
    Reviewed-by: Minchan Kim <minchan.kim@gmail.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

diff --git a/mm/filemap.c b/mm/filemap.c
index ca389394fa2a..1a3dd5914726 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -837,9 +837,6 @@ unsigned find_get_pages_contig(struct address_space *mapping, pgoff_t index,
 		if (radix_tree_deref_retry(page))
 			goto restart;
 
-		if (page->mapping == NULL || page->index != index)
-			break;
-
 		if (!page_cache_get_speculative(page))
 			goto repeat;
 
@@ -849,6 +846,16 @@ unsigned find_get_pages_contig(struct address_space *mapping, pgoff_t index,
 			goto repeat;
 		}
 
+		/*
+		 * must check mapping and index after taking the ref.
+		 * otherwise we can get both false positives and false
+		 * negatives, which is just confusing to the caller.
+		 */
+		if (page->mapping == NULL || page->index != index) {
+			page_cache_release(page);
+			break;
+		}
+
 		pages[ret] = page;
 		ret++;
 		index++;



Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49BKRHNzCVqXmXQxrfkG8P6jUCuRgBqj7UG9U+egVjE1IBiE3IaTtoHLMpcpeNF6BrzsXTr
ARC-Seal: i=1; a=rsa-sha256; t=1524406224; cv=none;
        d=google.com; s=arc-20160816;
        b=HiGpAjxHOtlfktAV8oWkL3NkRPgCT1OZNyyZ+kfc5D/aVmJrPhOOYqrhPOC9G5PAd9
         h2VM23feTzBsh8W7va166KsR1L4n6ipu4MUGN/o/I5/cgAZmpOmMh9IkDgayPq4r+UFh
         p270Tw1cwx1ftp78wJM2jjINuWAWj0g/udA8jqZqzfh4s+kB8ijlOe4UTu/sy5LN8PSV
         +V01obnjOnr0iDNXYN8C5K9+graGHHloDMRDoR2avOXQOlQpbpnN/Tm6TUmgKiMiEZqu
         2yWUZRr7QCteWvKcG5/H4hwnWrRPsDgtOQXylkieXNeRVfuh8Q8J1I1malmOVD3/pWbE
         NCww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Zm2rSTgv0UsdoQywxVQxEe0+RZP5GP6L3dl6y7d6q+g=;
        b=ixpibNLxt7SSsW8Dc3vosjXs9QGljIfUoZkLmDF86UsNvtDhIWXtqOKMs77saLC+Zd
         AIi4EqeWwMJ/AR4gBlJnmxOQlFdqmZH/o6w8kKhaBLb29ELkDisFJ109U+mj7eNCW4e+
         iJ9Ui9np4E56qTzbnU1uUaLWKfjocYWiYWSnpZUuDHyWrjVQkE9jRJbdQQ2XqTqmQwJl
         3Fq39ocoKWqOYi//NdpIKAkSkDtAM7o3e1wY19FU4LMGMMRKcoGzIFKEgopU3iPXuTyL
         tU3fZ5zKSgFxjoPGP3TLkifVkLHaHV9wGck8ClwNqWpfSUcvBXOrZAFvaCl/4/QJjXIg
         76lg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Matthew Wilcox <mawilcox@microsoft.com>,
	Chris Fries <cfries@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 158/164] mm/filemap.c: fix NULL pointer in page_cache_tree_insert()
Date: Sun, 22 Apr 2018 15:53:45 +0200
Message-Id: <20180422135142.066736920@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455322200106051?=
X-GMAIL-MSGID: =?utf-8?q?1598455780988519164?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Wilcox <mawilcox@microsoft.com>

commit abc1be13fd113ddef5e2d807a466286b864caed3 upstream.

f2fs specifies the __GFP_ZERO flag for allocating some of its pages.
Unfortunately, the page cache also uses the mapping's GFP flags for
allocating radix tree nodes.  It always masked off the __GFP_HIGHMEM
flag, and masks off __GFP_ZERO in some paths, but not all.  That causes
radix tree nodes to be allocated with a NULL list_head, which causes
backtraces like:

  __list_del_entry+0x30/0xd0
  list_lru_del+0xac/0x1ac
  page_cache_tree_insert+0xd8/0x110

The __GFP_DMA and __GFP_DMA32 flags would also be able to sneak through
if they are ever used.  Fix them all by using GFP_RECLAIM_MASK at the
innermost location, and remove it from earlier in the callchain.

Link: http://lkml.kernel.org/r/20180411060320.14458-2-willy@infradead.org
Fixes: 449dd6984d0e ("mm: keep page cache radix tree nodes in check")
Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
Reported-by: Chris Fries <cfries@google.com>
Debugged-by: Minchan Kim <minchan@kernel.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/filemap.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -688,7 +688,7 @@ int replace_page_cache_page(struct page
 	VM_BUG_ON_PAGE(!PageLocked(new), new);
 	VM_BUG_ON_PAGE(new->mapping, new);
 
-	error = radix_tree_preload(gfp_mask & ~__GFP_HIGHMEM);
+	error = radix_tree_preload(gfp_mask & GFP_RECLAIM_MASK);
 	if (!error) {
 		struct address_space *mapping = old->mapping;
 		void (*freepage)(struct page *);
@@ -744,7 +744,7 @@ static int __add_to_page_cache_locked(st
 			return error;
 	}
 
-	error = radix_tree_maybe_preload(gfp_mask & ~__GFP_HIGHMEM);
+	error = radix_tree_maybe_preload(gfp_mask & GFP_RECLAIM_MASK);
 	if (error) {
 		if (!huge)
 			mem_cgroup_cancel_charge(page, memcg, false);
@@ -1486,8 +1486,7 @@ no_page:
 		if (fgp_flags & FGP_ACCESSED)
 			__SetPageReferenced(page);
 
-		err = add_to_page_cache_lru(page, mapping, offset,
-				gfp_mask & GFP_RECLAIM_MASK);
+		err = add_to_page_cache_lru(page, mapping, offset, gfp_mask);
 		if (unlikely(err)) {
 			put_page(page);
 			page = NULL;
@@ -2275,7 +2274,7 @@ static int page_cache_read(struct file *
 		if (!page)
 			return -ENOMEM;
 
-		ret = add_to_page_cache_lru(page, mapping, offset, gfp_mask & GFP_KERNEL);
+		ret = add_to_page_cache_lru(page, mapping, offset, gfp_mask);
 		if (ret == 0)
 			ret = mapping->a_ops->readpage(file, page);
 		else if (ret == -EEXIST)

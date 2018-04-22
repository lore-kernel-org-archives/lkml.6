Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+PZ9KLbzekzQ6uxWqEbQXFvStd99xosVX5dNVyWgYIMdL1UAjPYWhEbcGjbblNYqLq8erq
ARC-Seal: i=1; a=rsa-sha256; t=1524406762; cv=none;
        d=google.com; s=arc-20160816;
        b=M6W0Wk0Lhjjbo+i4a6EIkcCQipMuNLGNS8TtEgA+itrHUsoyjLh3uI9AmvdHfs7HDl
         uhsERW74aCZ6KrPStqcj9gMAyYjz7cQqTpzWnAMph4S9EcZb8KHbYpln/iJD2b8bp9iW
         83w4hnJoRd06vYupNPP+lIA5Vwa7X81xJof6wMEV6A4LwT49ccvk++jN2jgcKbFtDW2Y
         vYdA9hbbjadTnPKP8ou7jlCTvl00f1QtcPT4gjtNi7dhnhMdzrhY94W4m69kPTxEgJkl
         ZQRBzyR41iaqiKfKTWoT47Ibz8ilD7eKO4d+Yr+GC4+ZviBSCJVVX0WGnkJYHuQ2XmrK
         a90g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=DU42CsYFyGDRRoAoJw4vT91oOr7RqlMjuglxWR4fUlE=;
        b=KOp3mu0IM34s5yZCmvZ7/dj6GG65bqGx+kZ0eRg8MVPEk7KA9ph/Yna5LTBN1j9mhT
         4+n/2IwhXL0N/x+f2wHpq3/Ro3ea6Ua+pcawP6D435lGiDF8yBWaEPVTQJs39rxJLpwO
         WBoNmKT9B1unhRvw3kBwSKuGB2zOhOEri3FmAtKegyburnDRy5nhJMNglPl8tMuBqvkX
         w7ZvhJKc0sOqZJzl4ND+TqJM7rNv7al7DxJTkIVAjW2Sb8MNtSNQ57tbX447UL6z1LDz
         IqrlOQHh2V8MaYpJL+gLGVw+hUrgXVm9KstV2MqCXsofqf4tqqKzkCA04dphYU0ML5qy
         Ku1w==
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
Subject: [PATCH 4.4 94/97] mm/filemap.c: fix NULL pointer in page_cache_tree_insert()
Date: Sun, 22 Apr 2018 15:54:12 +0200
Message-Id: <20180422135310.303660182@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455322200106051?=
X-GMAIL-MSGID: =?utf-8?q?1598456345617919735?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -571,7 +571,7 @@ int replace_page_cache_page(struct page
 	VM_BUG_ON_PAGE(!PageLocked(new), new);
 	VM_BUG_ON_PAGE(new->mapping, new);
 
-	error = radix_tree_preload(gfp_mask & ~__GFP_HIGHMEM);
+	error = radix_tree_preload(gfp_mask & GFP_RECLAIM_MASK);
 	if (!error) {
 		struct address_space *mapping = old->mapping;
 		void (*freepage)(struct page *);
@@ -630,7 +630,7 @@ static int __add_to_page_cache_locked(st
 			return error;
 	}
 
-	error = radix_tree_maybe_preload(gfp_mask & ~__GFP_HIGHMEM);
+	error = radix_tree_maybe_preload(gfp_mask & GFP_RECLAIM_MASK);
 	if (error) {
 		if (!huge)
 			mem_cgroup_cancel_charge(page, memcg);
@@ -1192,8 +1192,7 @@ no_page:
 		if (fgp_flags & FGP_ACCESSED)
 			__SetPageReferenced(page);
 
-		err = add_to_page_cache_lru(page, mapping, offset,
-				gfp_mask & GFP_RECLAIM_MASK);
+		err = add_to_page_cache_lru(page, mapping, offset, gfp_mask);
 		if (unlikely(err)) {
 			page_cache_release(page);
 			page = NULL;
@@ -1838,7 +1837,7 @@ static int page_cache_read(struct file *
 		if (!page)
 			return -ENOMEM;
 
-		ret = add_to_page_cache_lru(page, mapping, offset, gfp_mask & GFP_KERNEL);
+		ret = add_to_page_cache_lru(page, mapping, offset, gfp_mask);
 		if (ret == 0)
 			ret = mapping->a_ops->readpage(file, page);
 		else if (ret == -EEXIST)

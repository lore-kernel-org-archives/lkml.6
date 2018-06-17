Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AA5C5CFC0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F7442086A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m+LOI1px"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F7442086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936563AbeFQCQV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 22:16:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58772 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933677AbeFQCBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 22:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Yeiu2kmNiusFRVYFnSwKz/rR6RSVxilKq9nNpzSrFOE=; b=m+LOI1px17ZSX5HKevG2D55D6
        WGE20+eKIdSX26zGYKp1NJ6fKmQVz9TeDZYY2DXweQpbJxgCHb3Hi5OE61FnLqgC9mCXy7ziofOeN
        9wrsRmwJGlNfGUUIX6s0jhoqytilmgM4katZytiJIuds+7k9iRJY0mVTVXPc+G9txr3bE2z8iCKPR
        w42OLBaGlBN/PWDF3t3EbBHftT2tyegU/WqWin9w+H/PFRZHu2IFFTXmhaTQ1DIOhMzcU2q4yNL0F
        sqRF1xwdUMq+DK8WxDBpeTFS51/Fu9NqDsrxJA8BmxnEyzJ3C93MWVLru6U1HWrEECsEWSazm8sIQ
        LaP1JPyjg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fUN00-0001Iu-NL; Sun, 17 Jun 2018 02:01:00 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        linux-nilfs@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH v14 30/74] page cache: Convert filemap_map_pages to XArray
Date:   Sat, 16 Jun 2018 19:00:08 -0700
Message-Id: <20180617020052.4759-31-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180617020052.4759-1-willy@infradead.org>
References: <20180617020052.4759-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Slight change of strategy here; if we have trouble getting hold of a
page for whatever reason (eg a compound page is split underneath us),
don't spin to stabilise the page, just continue the iteration, like we
would if we failed to trylock the page.  Since this is a speculative
optimisation, it feels like we should allow the process to take an extra
fault if it turns out to need this page instead of spending time to pin
down a page it may not need.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 mm/filemap.c | 42 +++++++++++++-----------------------------
 1 file changed, 13 insertions(+), 29 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 67f04bcdf9ef..4204d9df003b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2516,45 +2516,31 @@ EXPORT_SYMBOL(filemap_fault);
 void filemap_map_pages(struct vm_fault *vmf,
 		pgoff_t start_pgoff, pgoff_t end_pgoff)
 {
-	struct radix_tree_iter iter;
-	void **slot;
 	struct file *file = vmf->vma->vm_file;
 	struct address_space *mapping = file->f_mapping;
 	pgoff_t last_pgoff = start_pgoff;
 	unsigned long max_idx;
+	XA_STATE(xas, &mapping->i_pages, start_pgoff);
 	struct page *head, *page;
 
 	rcu_read_lock();
-	radix_tree_for_each_slot(slot, &mapping->i_pages, &iter, start_pgoff) {
-		if (iter.index > end_pgoff)
-			break;
-repeat:
-		page = radix_tree_deref_slot(slot);
-		if (unlikely(!page))
-			goto next;
-		if (radix_tree_exception(page)) {
-			if (radix_tree_deref_retry(page)) {
-				slot = radix_tree_iter_retry(&iter);
-				continue;
-			}
+	xas_for_each(&xas, page, end_pgoff) {
+		if (xas_retry(&xas, page))
+			continue;
+		if (xa_is_value(page))
 			goto next;
-		}
 
 		head = compound_head(page);
 		if (!page_cache_get_speculative(head))
-			goto repeat;
+			goto next;
 
 		/* The page was split under us? */
-		if (compound_head(page) != head) {
-			put_page(head);
-			goto repeat;
-		}
+		if (compound_head(page) != head)
+			goto skip;
 
 		/* Has the page moved? */
-		if (unlikely(page != *slot)) {
-			put_page(head);
-			goto repeat;
-		}
+		if (unlikely(page != xas_reload(&xas)))
+			goto skip;
 
 		if (!PageUptodate(page) ||
 				PageReadahead(page) ||
@@ -2573,10 +2559,10 @@ void filemap_map_pages(struct vm_fault *vmf,
 		if (file->f_ra.mmap_miss > 0)
 			file->f_ra.mmap_miss--;
 
-		vmf->address += (iter.index - last_pgoff) << PAGE_SHIFT;
+		vmf->address += (xas.xa_index - last_pgoff) << PAGE_SHIFT;
 		if (vmf->pte)
-			vmf->pte += iter.index - last_pgoff;
-		last_pgoff = iter.index;
+			vmf->pte += xas.xa_index - last_pgoff;
+		last_pgoff = xas.xa_index;
 		if (alloc_set_pte(vmf, NULL, page))
 			goto unlock;
 		unlock_page(page);
@@ -2589,8 +2575,6 @@ void filemap_map_pages(struct vm_fault *vmf,
 		/* Huge page is mapped? No need to proceed. */
 		if (pmd_trans_huge(*vmf->pmd))
 			break;
-		if (iter.index == end_pgoff)
-			break;
 	}
 	rcu_read_unlock();
 }
-- 
2.17.1


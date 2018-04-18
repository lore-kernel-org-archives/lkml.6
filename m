Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752810AbeDROpn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 10:45:43 -0400
Received: from resqmta-ch2-07v.sys.comcast.net ([69.252.207.39]:41658 "EHLO
        resqmta-ch2-07v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751305AbeDROpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 10:45:42 -0400
Date: Wed, 18 Apr 2018 09:45:39 -0500 (CDT)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Vlastimil Babka <vbabka@suse.cz>
cc: Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org,
        dm-devel@redhat.com, David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] SLUB: Do not fallback to mininum order if __GFP_NORETRY is
 set
Message-ID: <alpine.DEB.2.20.1804180944180.1062@nuc-kabylake>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfO6UUdSyMsAk5Jj8wXmnfPAhDaGSLyCgNZA+Hqz6SxxvcjIjbcjapAgU5Fmu4uuY6L/Xc1aMTORSchHe2Cz7jBr9F2wt6n23tReXiYJ7PTs3B0zUhaIX
 uyOm+w0orQlpgk5JdIphUNKxjxi9mVurjbvqqmcqu10iyUKgXAGRT69EvswO4NGnRXJ0ksfT/mfkzkciG0Y8f9NUFwyB7d/cNHqihkcMmHzxhyT6wSF+5qpS
 gcANBrmooS46BaJnuWgtMXl9S98kQ9NnJ/ljVhe1jXEdZAaaNImq7OWlK6dqHqkzgfQph1GqaKA3iruTKRjEzNZVVdz5jwrL1bIeOaLVwt98yudAyxV3zZHV
 0pEdRNAcgEXPhbG0uB/iNF1l1NTvSKMTxdLwDdJ9se0D0vcKcTE+xuB+/Bda1Zt7HJIk9OdAIzPXncgDjFsPamSty0zK/LPnSHU5wErPHoMla8gNgA6z6fkE
 p1jKqUTImnlp/aVs
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mikulas Patoka wants to ensure that no fallback to lower order happens. I
think __GFP_NORETRY should work correctly in that case too and not fall
back.



Allocating at a smaller order is a retry operation and should not
be attempted.

If the caller does not want retries then respect that.

GFP_NORETRY allows callers to ensure that only maximum order
allocations are attempted.

Signed-off-by: Christoph Lameter <cl@linux.com>

Index: linux/mm/slub.c
===================================================================
--- linux.orig/mm/slub.c
+++ linux/mm/slub.c
@@ -1598,7 +1598,7 @@ static struct page *allocate_slab(struct
 		alloc_gfp = (alloc_gfp | __GFP_NOMEMALLOC) & ~(__GFP_RECLAIM|__GFP_NOFAIL);

 	page = alloc_slab_page(s, alloc_gfp, node, oo);
-	if (unlikely(!page)) {
+	if (unlikely(!page) && !(flags & __GFP_NORETRY)) {
 		oo = s->min;
 		alloc_gfp = flags;
 		/*

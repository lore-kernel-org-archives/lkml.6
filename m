Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id I/I1G5nIG1vBMgAAmS7hNA
	; Sat, 09 Jun 2018 12:31:21 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 564886089E; Sat,  9 Jun 2018 12:31:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CE5266032D;
	Sat,  9 Jun 2018 12:31:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CE5266032D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753349AbeFIMbS (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 08:31:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753101AbeFIMbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 08:31:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8A1BD40122A6;
        Sat,  9 Jun 2018 12:31:15 +0000 (UTC)
Received: from localhost (ovpn-12-40.pek2.redhat.com [10.72.12.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 06C3E2166BB2;
        Sat,  9 Jun 2018 12:31:06 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc: David Sterba <dsterba@suse.cz>, Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V6 03/30] block: use bio_add_page in bio_iov_iter_get_pages
Date: Sat,  9 Jun 2018 20:29:47 +0800
Message-Id: <20180609123014.8861-4-ming.lei@redhat.com>
In-Reply-To: <20180609123014.8861-1-ming.lei@redhat.com>
References: <20180609123014.8861-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Sat, 09 Jun 2018 12:31:15 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Sat, 09 Jun 2018 12:31:15 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ming.lei@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

Replace a nasty hack with a different nasty hack to prepare for multipage
bio_vecs.  By moving the temporary page array as far up as possible in
the space allocated for the bio_vec array we can iterate forward over it
and thus use bio_add_page.  Using bio_add_page means we'll be able to
merge physically contiguous pages once support for multipath bio_vecs is
merged.

Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 45 +++++++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index ebd3ca62e037..cb0f46e2752b 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -902,6 +902,8 @@ int bio_add_page(struct bio *bio, struct page *page,
 }
 EXPORT_SYMBOL(bio_add_page);
 
+#define PAGE_PTRS_PER_BVEC	(sizeof(struct bio_vec) / sizeof(struct page *))
+
 /**
  * bio_iov_iter_get_pages - pin user or kernel pages and add them to a bio
  * @bio: bio to add pages to
@@ -913,38 +915,33 @@ EXPORT_SYMBOL(bio_add_page);
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 {
 	unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
+	unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
 	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
 	struct page **pages = (struct page **)bv;
-	size_t offset, diff;
-	ssize_t size;
+	ssize_t size, left;
+	unsigned len, i;
+	size_t offset;
+
+	/*
+	 * Move page array up in the allocated memory for the bio vecs as
+	 * far as possible so that we can start filling biovecs from the
+	 * beginning without overwriting the temporary page array.
+	 */
+	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
+	pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
 
 	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
 	if (unlikely(size <= 0))
 		return size ? size : -EFAULT;
-	nr_pages = (size + offset + PAGE_SIZE - 1) / PAGE_SIZE;
 
-	/*
-	 * Deep magic below:  We need to walk the pinned pages backwards
-	 * because we are abusing the space allocated for the bio_vecs
-	 * for the page array.  Because the bio_vecs are larger than the
-	 * page pointers by definition this will always work.  But it also
-	 * means we can't use bio_add_page, so any changes to it's semantics
-	 * need to be reflected here as well.
-	 */
-	bio->bi_iter.bi_size += size;
-	bio->bi_vcnt += nr_pages;
-
-	diff = (nr_pages * PAGE_SIZE - offset) - size;
-	while (nr_pages--) {
-		bv[nr_pages].bv_page = pages[nr_pages];
-		bv[nr_pages].bv_len = PAGE_SIZE;
-		bv[nr_pages].bv_offset = 0;
-	}
+	for (left = size, i = 0; left > 0; left -= len, i++) {
+		struct page *page = pages[i];
 
-	bv[0].bv_offset += offset;
-	bv[0].bv_len -= offset;
-	if (diff)
-		bv[bio->bi_vcnt - 1].bv_len -= diff;
+		len = min_t(size_t, PAGE_SIZE - offset, left);
+		if (WARN_ON_ONCE(bio_add_page(bio, page, len, offset) != len))
+			return -EINVAL;
+		offset = 0;
+	}
 
 	iov_iter_advance(iter, size);
 	return 0;
-- 
2.9.5

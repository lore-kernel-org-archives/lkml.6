Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3D6C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D25C920844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D25C920844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390372AbeHATJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:09:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50746 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389759AbeHATJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:09:18 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 83224CC3;
        Wed,  1 Aug 2018 17:22:36 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Ming Lei <ming.lei@redhat.com>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>, Martin Wilck <mwilck@suse.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.14 215/246] block: bio_iov_iter_get_pages: fix size of last iovec
Date:   Wed,  1 Aug 2018 18:52:05 +0200
Message-Id: <20180801165022.002412959@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
References: <20180801165011.700991984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Wilck <mwilck@suse.com>

commit b403ea2404889e1227812fa9657667a1deb9c694 upstream.

If the last page of the bio is not "full", the length of the last
vector slot needs to be corrected. This slot has the index
(bio->bi_vcnt - 1), but only in bio->bi_io_vec. In the "bv" helper
array, which is shifted by the value of bio->bi_vcnt at function
invocation, the correct index is (nr_pages - 1).

v2: improved readability following suggestions from Ming Lei.
v3: followed a formatting suggestion from Christoph Hellwig.

Fixes: 2cefe4dbaadf ("block: add bio_iov_iter_get_pages()")
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin Wilck <mwilck@suse.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/bio.c |   18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

--- a/block/bio.c
+++ b/block/bio.c
@@ -881,16 +881,16 @@ EXPORT_SYMBOL(bio_add_page);
  */
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 {
-	unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
+	unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt, idx;
 	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
 	struct page **pages = (struct page **)bv;
-	size_t offset, diff;
+	size_t offset;
 	ssize_t size;
 
 	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
 	if (unlikely(size <= 0))
 		return size ? size : -EFAULT;
-	nr_pages = (size + offset + PAGE_SIZE - 1) / PAGE_SIZE;
+	idx = nr_pages = (size + offset + PAGE_SIZE - 1) / PAGE_SIZE;
 
 	/*
 	 * Deep magic below:  We need to walk the pinned pages backwards
@@ -903,17 +903,15 @@ int bio_iov_iter_get_pages(struct bio *b
 	bio->bi_iter.bi_size += size;
 	bio->bi_vcnt += nr_pages;
 
-	diff = (nr_pages * PAGE_SIZE - offset) - size;
-	while (nr_pages--) {
-		bv[nr_pages].bv_page = pages[nr_pages];
-		bv[nr_pages].bv_len = PAGE_SIZE;
-		bv[nr_pages].bv_offset = 0;
+	while (idx--) {
+		bv[idx].bv_page = pages[idx];
+		bv[idx].bv_len = PAGE_SIZE;
+		bv[idx].bv_offset = 0;
 	}
 
 	bv[0].bv_offset += offset;
 	bv[0].bv_len -= offset;
-	if (diff)
-		bv[bio->bi_vcnt - 1].bv_len -= diff;
+	bv[nr_pages - 1].bv_len -= nr_pages * PAGE_SIZE - offset - size;
 
 	iov_iter_advance(iter, size);
 	return 0;



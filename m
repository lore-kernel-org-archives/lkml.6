Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935724AbeEYDx3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 23:53:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41618 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754950AbeEYDwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 23:52:21 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc: David Sterba <dsterba@suse.cz>, Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>, Coly Li <colyli@suse.de>,
        Filipe Manana <fdmanana@gmail.com>, Ming Lei <ming.lei@redhat.com>
Subject: [RESEND PATCH V5 30/33] block: enable multipage bvecs
Date: Fri, 25 May 2018 11:46:18 +0800
Message-Id: <20180525034621.31147-31-ming.lei@redhat.com>
In-Reply-To: <20180525034621.31147-1-ming.lei@redhat.com>
References: <20180525034621.31147-1-ming.lei@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch pulls the trigger for multipage bvecs.

Now any request queue which supports queue cluster will see multipage
bvecs.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index c160c143cc1b..bc3992f52fe8 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -876,6 +876,11 @@ int bio_add_page(struct bio *bio, struct page *page,
 	 * a consecutive offset.  Optimize this special case.
 	 */
 	if (bio->bi_vcnt > 0) {
+		struct request_queue *q = NULL;
+
+		if (bio->bi_disk)
+			q = bio->bi_disk->queue;
+
 		bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
 
 		if (page == bv->bv_page &&
@@ -883,6 +888,14 @@ int bio_add_page(struct bio *bio, struct page *page,
 			bv->bv_len += len;
 			goto done;
 		}
+
+		/* disable multipage bvec too if cluster isn't enabled */
+		if (q && blk_queue_cluster(q) &&
+		    (bvec_to_phys(bv) + bv->bv_len ==
+		     page_to_phys(page) + offset)) {
+			bv->bv_len += len;
+			goto done;
+		}
 	}
 
 	if (bio->bi_vcnt >= bio->bi_max_vecs)
-- 
2.9.5

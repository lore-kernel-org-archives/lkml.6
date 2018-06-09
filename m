Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id N+UKJIDJG1sIQAAAmS7hNA
	; Sat, 09 Jun 2018 12:35:55 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9C961607BB; Sat,  9 Jun 2018 12:35:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 34E0A606FA;
	Sat,  9 Jun 2018 12:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 34E0A606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932324AbeFIMfw (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 08:35:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38982 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932081AbeFIMft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 08:35:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E0AB54022407;
        Sat,  9 Jun 2018 12:35:48 +0000 (UTC)
Received: from localhost (ovpn-12-40.pek2.redhat.com [10.72.12.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 74402422BA;
        Sat,  9 Jun 2018 12:35:39 +0000 (UTC)
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
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V6 28/30] block: enable multipage bvecs
Date: Sat,  9 Jun 2018 20:30:12 +0800
Message-Id: <20180609123014.8861-29-ming.lei@redhat.com>
In-Reply-To: <20180609123014.8861-1-ming.lei@redhat.com>
References: <20180609123014.8861-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Sat, 09 Jun 2018 12:35:49 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Sat, 09 Jun 2018 12:35:49 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ming.lei@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch pulls the trigger for multipage bvecs.

Now any request queue which supports queue cluster will see multipage
bvecs.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 276fc35ec559..284085ab97e7 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -870,12 +870,23 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
 
 	if (bio->bi_vcnt > 0) {
 		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
-
-		if (page == bv->bv_page && off == bv->bv_offset + bv->bv_len) {
-			bv->bv_len += len;
-			bio->bi_iter.bi_size += len;
-			return true;
-		}
+		struct request_queue *q = NULL;
+
+		if (page == bv->bv_page && off == bv->bv_offset + bv->bv_len)
+			goto merge;
+
+		if (bio->bi_disk)
+			q = bio->bi_disk->queue;
+
+		/* disable multipage bvec too if cluster isn't enabled */
+		if (!q || !blk_queue_cluster(q) ||
+		    (bvec_to_phys(bv) + bv->bv_len !=
+		     page_to_phys(page) + off))
+			return false;
+ merge:
+		bv->bv_len += len;
+		bio->bi_iter.bi_size += len;
+		return true;
 	}
 	return false;
 }
-- 
2.9.5

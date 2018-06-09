Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id nBDzON3IG1vWOgAAmS7hNA
	; Sat, 09 Jun 2018 12:34:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 48435607A4; Sat,  9 Jun 2018 12:34:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CC0676032D;
	Sat,  9 Jun 2018 12:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CC0676032D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753535AbeFIMeE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 08:34:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38312 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753248AbeFIMeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 08:34:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C0279818BAF3;
        Sat,  9 Jun 2018 12:34:00 +0000 (UTC)
Received: from localhost (ovpn-12-40.pek2.redhat.com [10.72.12.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9C1641116709;
        Sat,  9 Jun 2018 12:33:51 +0000 (UTC)
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
Subject: [PATCH V6 17/30] block: introduce bio_for_each_chunk_all and bio_for_each_chunk_segment_all
Date: Sat,  9 Jun 2018 20:30:01 +0800
Message-Id: <20180609123014.8861-18-ming.lei@redhat.com>
In-Reply-To: <20180609123014.8861-1-ming.lei@redhat.com>
References: <20180609123014.8861-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Sat, 09 Jun 2018 12:34:00 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Sat, 09 Jun 2018 12:34:00 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ming.lei@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces bio_for_each_chunk_all() and bio_for_each_chunk_segment_all(),
which are for replacing the current bio_for_each_segment_all().

bio_for_each_chunk_all() will iterate one chunk by chunk, which is multipage based.

bio_for_each_chunk_segment_all() will iterate one segment by segment, which is
singlepage based.

For using bio_for_each_chunk_segment_all(), one 24-bytes extra local variable has to
be introduced.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/bio.h  | 13 +++++++++++++
 include/linux/bvec.h | 31 +++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 0fa1035dde38..f21384be9b51 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -168,6 +168,19 @@ static inline bool bio_full(struct bio *bio)
 #define bio_for_each_segment_all(bvl, bio, i)				\
 	for (i = 0, bvl = (bio)->bi_io_vec; i < (bio)->bi_vcnt; i++, bvl++)
 
+#define bio_for_each_chunk_all(bvl, bio, i)		\
+	bio_for_each_segment_all(bvl, bio, i)
+
+#define chunk_for_each_segment(bv, bvl, i, citer)			\
+	for (bv = bvec_init_chunk_iter(&citer);				\
+		(citer.done < (bvl)->bv_len) &&				\
+		((chunk_next_segment((bvl), &citer)), 1);		\
+		citer.done += bv->bv_len, i += 1)
+
+#define bio_for_each_chunk_segment_all(bvl, bio, i, citer)		\
+	for (i = 0, citer.idx = 0; citer.idx < (bio)->bi_vcnt; citer.idx++)	\
+		chunk_for_each_segment(bvl, &((bio)->bi_io_vec[citer.idx]), i, citer)
+
 static inline void __bio_advance_iter(struct bio *bio, struct bvec_iter *iter,
 				      unsigned bytes, bool chunk)
 {
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index aac75d87d884..d4eaa0c26bb5 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -84,6 +84,12 @@ struct bvec_iter {
 						   current bvec */
 };
 
+struct bvec_chunk_iter {
+	struct bio_vec	bv;
+	int		idx;
+	unsigned	done;
+};
+
 /*
  * various member access, note that bio_data should of course not be used
  * on highmem page vectors
@@ -219,6 +225,31 @@ static inline bool bvec_iter_chunk_advance(const struct bio_vec *bv,
 	.bi_bvec_done	= 0,						\
 }
 
+static inline struct bio_vec *bvec_init_chunk_iter(struct bvec_chunk_iter *citer)
+{
+	citer->bv.bv_page = NULL;
+	citer->done = 0;
+
+	return &citer->bv;
+}
+
+/* used for chunk_for_each_segment */
+static inline void chunk_next_segment(const struct bio_vec *chunk,
+		struct bvec_chunk_iter *iter)
+{
+	struct bio_vec *bv = &iter->bv;
+
+	if (bv->bv_page) {
+		bv->bv_page += 1;
+		bv->bv_offset = 0;
+	} else {
+		bv->bv_page = chunk->bv_page;
+		bv->bv_offset = chunk->bv_offset;
+	}
+	bv->bv_len = min_t(unsigned int, PAGE_SIZE - bv->bv_offset,
+			chunk->bv_len - iter->done);
+}
+
 /*
  * Get the last singlepage segment from the multipage bvec and store it
  * in @seg
-- 
2.9.5

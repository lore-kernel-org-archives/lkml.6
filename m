Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id MkGJM/fIG1srOwAAmS7hNA
	; Sat, 09 Jun 2018 12:32:59 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 33B816074D; Sat,  9 Jun 2018 12:32:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C00B7602FC;
	Sat,  9 Jun 2018 12:32:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C00B7602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753450AbeFIMc5 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 08:32:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36016 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753176AbeFIMcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 08:32:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 02749859A5;
        Sat,  9 Jun 2018 12:32:54 +0000 (UTC)
Received: from localhost (ovpn-12-40.pek2.redhat.com [10.72.12.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1FE2A42236;
        Sat,  9 Jun 2018 12:32:42 +0000 (UTC)
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
Subject: [PATCH V6 11/30] block: implement bio_pages_all() via bio_for_each_segment_all()
Date: Sat,  9 Jun 2018 20:29:55 +0800
Message-Id: <20180609123014.8861-12-ming.lei@redhat.com>
In-Reply-To: <20180609123014.8861-1-ming.lei@redhat.com>
References: <20180609123014.8861-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Sat, 09 Jun 2018 12:32:54 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Sat, 09 Jun 2018 12:32:54 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ming.lei@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As multipage bvec will be enabled soon, bio->bi_vcnt isn't same with
page count in the bio any more, so use bio_for_each_segment_all() to
compute the number because we will keep bio_for_each_segment_all()
to iterate each page.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/bio.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index e9f74c73bbe6..c17b8f80d650 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -339,8 +339,14 @@ static inline void bio_get_last_bvec(struct bio *bio, struct bio_vec *bv)
 
 static inline unsigned bio_pages_all(struct bio *bio)
 {
+	unsigned i;
+	struct bio_vec *bv;
+
 	WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED));
-	return bio->bi_vcnt;
+
+	bio_for_each_segment_all(bv, bio, i)
+		;
+	return i;
 }
 
 static inline struct bio_vec *bio_first_bvec_all(struct bio *bio)
-- 
2.9.5

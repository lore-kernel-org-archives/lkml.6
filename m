Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id qcqGD3nIG1uyNwAAmS7hNA
	; Sat, 09 Jun 2018 12:32:34 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0E6F2608C8; Sat,  9 Jun 2018 12:32:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4083C607BB;
	Sat,  9 Jun 2018 12:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4083C607BB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753425AbeFIMca (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 08:32:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42080 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753211AbeFIMc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 08:32:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D5E68BB42D;
        Sat,  9 Jun 2018 12:32:26 +0000 (UTC)
Received: from localhost (ovpn-12-40.pek2.redhat.com [10.72.12.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 17F1342236;
        Sat,  9 Jun 2018 12:32:15 +0000 (UTC)
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
Subject: [PATCH V6 09/30] fs/buffer.c: use bvec iterator to truncate the bio
Date: Sat,  9 Jun 2018 20:29:53 +0800
Message-Id: <20180609123014.8861-10-ming.lei@redhat.com>
In-Reply-To: <20180609123014.8861-1-ming.lei@redhat.com>
References: <20180609123014.8861-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Sat, 09 Jun 2018 12:32:26 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Sat, 09 Jun 2018 12:32:26 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ming.lei@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once multipage bvec is enabled, the last bvec may include more than one
page, this patch use chunk_last_segment() to truncate the bio.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 fs/buffer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index cabc045f483d..630ae3e0238b 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -3021,7 +3021,10 @@ void guard_bio_eod(int op, struct bio *bio)
 
 	/* ..and clear the end of the buffer for reads */
 	if (op == REQ_OP_READ) {
-		zero_user(bvec->bv_page, bvec->bv_offset + bvec->bv_len,
+		struct bio_vec bv;
+
+		chunk_last_segment(bvec, &bv);
+		zero_user(bv.bv_page, bv.bv_offset + bv.bv_len,
 				truncated_bytes);
 	}
 }
-- 
2.9.5

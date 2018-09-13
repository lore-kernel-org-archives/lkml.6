Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEF3C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3194C20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3194C20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730685AbeIMS7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:59:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33106 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728513AbeIMS7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:59:39 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3B8B1D1B;
        Thu, 13 Sep 2018 13:50:05 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>,
        Jens Axboe <axboe@kernel.dk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 098/115] lightnvm: pblk: free padded entries in write buffer
Date:   Thu, 13 Sep 2018 15:31:58 +0200
Message-Id: <20180913131829.449589335@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131823.327472833@linuxfoundation.org>
References: <20180913131823.327472833@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Javier González <javier@cnexlabs.com>

commit cd8ddbf7a5e206fe6995ab0aee245d597dd6a7f2 upstream.

When a REQ_FLUSH reaches pblk, the bio cannot be directly completed.
Instead, data on the write buffer is flushed and the bio is completed on
the completion pah. This might require some sectors to be padded in
order to guarantee a successful write.

This patch fixes a memory leak on the padded pages. A consequence of
this bad free was that internal bios not containing data (only a flush)
were not being completed.

Fixes: a4bd217b4326 ("lightnvm: physical block device (pblk) target")
Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/lightnvm/pblk-core.c  |    1 -
 drivers/lightnvm/pblk-write.c |    7 ++++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -190,7 +190,6 @@ void pblk_bio_free_pages(struct pblk *pb
 
 	WARN_ON(off + nr_pages != bio->bi_vcnt);
 
-	bio_advance(bio, off * PBLK_EXPOSED_PAGE_SIZE);
 	for (i = off; i < nr_pages + off; i++) {
 		bv = bio->bi_io_vec[i];
 		mempool_free(bv.bv_page, pblk->page_bio_pool);
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -33,6 +33,10 @@ static unsigned long pblk_end_w_bio(stru
 			bio_endio(original_bio);
 	}
 
+	if (c_ctx->nr_padded)
+		pblk_bio_free_pages(pblk, rqd->bio, c_ctx->nr_valid,
+							c_ctx->nr_padded);
+
 #ifdef CONFIG_NVM_DEBUG
 	atomic_long_add(c_ctx->nr_valid, &pblk->sync_writes);
 #endif
@@ -521,7 +525,8 @@ static void pblk_free_write_rqd(struct p
 	struct bio *bio = rqd->bio;
 
 	if (c_ctx->nr_padded)
-		pblk_bio_free_pages(pblk, bio, rqd->nr_ppas, c_ctx->nr_padded);
+		pblk_bio_free_pages(pblk, bio, c_ctx->nr_valid,
+							c_ctx->nr_padded);
 }
 
 static int pblk_submit_write(struct pblk *pblk)



Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D900CC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A4F7208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A4F7208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406254AbeHATJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:09:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50770 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405177AbeHATJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:09:24 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CF14ED27;
        Wed,  1 Aug 2018 17:22:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Greg Edwards <gedwards@ddn.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.14 217/246] block: reset bi_iter.bi_done after splitting bio
Date:   Wed,  1 Aug 2018 18:52:07 +0200
Message-Id: <20180801165022.105121223@linuxfoundation.org>
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

From: Greg Edwards <gedwards@ddn.com>

commit 5151842b9d8732d4cbfa8400b40bff894f501b2f upstream.

After the bio has been updated to represent the remaining sectors, reset
bi_done so bio_rewind_iter() does not rewind further than it should.

This resolves a bio_integrity_process() failure on reads where the
original request was split.

Fixes: 63573e359d05 ("bio-integrity: Restore original iterator on verify stage")
Signed-off-by: Greg Edwards <gedwards@ddn.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/bio.c |    1 +
 1 file changed, 1 insertion(+)

--- a/block/bio.c
+++ b/block/bio.c
@@ -1889,6 +1889,7 @@ struct bio *bio_split(struct bio *bio, i
 		bio_integrity_trim(split);
 
 	bio_advance(bio, split->bi_iter.bi_size);
+	bio->bi_iter.bi_done = 0;
 
 	if (bio_flagged(bio, BIO_TRACE_COMPLETION))
 		bio_set_flag(split, BIO_TRACE_COMPLETION);



Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F87FC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC31D208A5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC31D208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405173AbeHATJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:09:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50758 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389759AbeHATJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:09:21 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AD9A4CC3;
        Wed,  1 Aug 2018 17:22:39 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>, Martin Wilck <mwilck@suse.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.14 216/246] blkdev: __blkdev_direct_IO_simple: fix leak in error case
Date:   Wed,  1 Aug 2018 18:52:06 +0200
Message-Id: <20180801165022.052181579@linuxfoundation.org>
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

commit 9362dd1109f87a9d0a798fbc890cb339c171ed35 upstream.

Fixes: 72ecad22d9f1 ("block: support a full bio worth of IO for simplified bdev direct-io")
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin Wilck <mwilck@suse.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/block_dev.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -231,7 +231,7 @@ __blkdev_direct_IO_simple(struct kiocb *
 
 	ret = bio_iov_iter_get_pages(&bio, iter);
 	if (unlikely(ret))
-		return ret;
+		goto out;
 	ret = bio.bi_iter.bi_size;
 
 	if (iov_iter_rw(iter) == READ) {
@@ -260,12 +260,13 @@ __blkdev_direct_IO_simple(struct kiocb *
 		put_page(bvec->bv_page);
 	}
 
-	if (vecs != inline_vecs)
-		kfree(vecs);
-
 	if (unlikely(bio.bi_status))
 		ret = blk_status_to_errno(bio.bi_status);
 
+out:
+	if (vecs != inline_vecs)
+		kfree(vecs);
+
 	bio_uninit(&bio);
 
 	return ret;



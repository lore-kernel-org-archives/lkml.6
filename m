Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BA0C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 924172064D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I+JHLTUq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 924172064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbeGZJpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 05:45:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45326 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728600AbeGZJpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 05:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nWYLFKCdlp6xfIgDg0KLOsAE/l8DTqSzy4anvvY/av0=; b=I+JHLTUqPfterC2Oi++M0xus8
        N7yOi6t0WtlWhQxZpljoA4JbyKc0nXwI/XFfqT5K4TfPamxIV3qpCBzO9nkD4okbN7E4Xe6+4IYA5
        ZrWOr45zLLxcmy9kFlwCeM4L61nhX4c6DACy5fBQvx6CL3WssaP5Y6QWSdz1PK+vxexCxt+NkekZE
        kXEZ5+n9tBcnkDW03WlM+vSg7tzfFGF5/kFu2uKIuMJ2KegE+OIuJCpY+aboyyEW7U1brV5fMMmzH
        3MVhhdyihTdTLe9lFCsDL0xFPo5bgxuPFjmlic4XWmcXXD1InuuaoEqKwT6cef73kvimN+y9pWic7
        QUu9Makuw==;
Received: from 089144199017.atnat0008.highway.a1.net ([89.144.199.17] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fibeB-0007y3-4W; Thu, 26 Jul 2018 08:29:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     viro@zeniv.linux.org.uk
Cc:     Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] aio: add a iocb refcount
Date:   Thu, 26 Jul 2018 10:29:01 +0200
Message-Id: <20180726082903.30273-3-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726082903.30273-1-hch@lst.de>
References: <20180726082903.30273-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is needed to prevent races caused by the way the ->poll API works.
To avoid introducing overhead for other users of the iocbs we initialize
it to zero and only do refcount operations if it is non-zero in the
completion path.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/aio.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 27454594e37a..7f3c159b3e2e 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -178,6 +178,7 @@ struct aio_kiocb {
 
 	struct list_head	ki_list;	/* the aio core uses this
 						 * for cancellation */
+	atomic_t		ki_refcnt;
 
 	/*
 	 * If the aio_resfd field of the userspace iocb is not zero,
@@ -1015,6 +1016,7 @@ static inline struct aio_kiocb *aio_get_req(struct kioctx *ctx)
 
 	percpu_ref_get(&ctx->reqs);
 	INIT_LIST_HEAD(&req->ki_list);
+	atomic_set(&req->ki_refcnt, 0);
 	req->ki_ctx = ctx;
 	return req;
 out_put:
@@ -1049,6 +1051,15 @@ static struct kioctx *lookup_ioctx(unsigned long ctx_id)
 	return ret;
 }
 
+static inline void iocb_put(struct aio_kiocb *iocb)
+{
+	if (atomic_read(&iocb->ki_refcnt) == 0 ||
+	    atomic_dec_and_test(&iocb->ki_refcnt)) {
+		percpu_ref_put(&iocb->ki_ctx->reqs);
+		kmem_cache_free(kiocb_cachep, iocb);
+	}
+}
+
 /* aio_complete
  *	Called when the io request on the given iocb is complete.
  */
@@ -1118,8 +1129,6 @@ static void aio_complete(struct aio_kiocb *iocb, long res, long res2)
 		eventfd_ctx_put(iocb->ki_eventfd);
 	}
 
-	kmem_cache_free(kiocb_cachep, iocb);
-
 	/*
 	 * We have to order our ring_info tail store above and test
 	 * of the wait list below outside the wait lock.  This is
@@ -1130,8 +1139,7 @@ static void aio_complete(struct aio_kiocb *iocb, long res, long res2)
 
 	if (waitqueue_active(&ctx->wait))
 		wake_up(&ctx->wait);
-
-	percpu_ref_put(&ctx->reqs);
+	iocb_put(iocb);
 }
 
 /* aio_read_events_ring
-- 
2.18.0


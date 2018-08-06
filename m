Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C0EC46472
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5998219E9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aYxeI4cL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5998219E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbeHFKjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 06:39:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51888 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeHFKjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 06:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xxfPtHwXdLte2DXR0KAEpLeSaJ5qF0xd+FK5pXMi3LU=; b=aYxeI4cL0mApYwsA7wkyKmCMk
        zhLL9kM2JNHcIUikB/L83sRvkClpDkmv+I5C1kNea0gmvWhKi3Z4bPGov0o7+rMmVBeJUCBAREnnX
        OgkJPr4Ke3H1Zhy4tpne7h4GwrJ6cyrxI57uSJqh2TO1nsvjbc43zmEfuCfxHF99zaxIWojMon2+b
        nLjHa6CC7CEHp8cAHcTTxw+NHzONjyao2xCHAA9ntgjS6KkSXaIwkuwaqZByNEIP/5sSOoVslnMa+
        5VSOSZn1Fv95Ue8lgQCSUE3LsuJ0oR3gli8XOBVWAhRECA7q8xuq6wJVLCDdSTJjmh7oIiCQUtqg9
        SVTRsmEMw==;
Received: from 212095005054.public.telering.at ([212.95.5.54] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fmauy-0001Nn-GS; Mon, 06 Aug 2018 08:31:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     viro@zeniv.linux.org.uk
Cc:     Avi Kivity <avi@scylladb.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] aio: add a iocb refcount
Date:   Mon,  6 Aug 2018 10:30:56 +0200
Message-Id: <20180806083058.14724-3-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180806083058.14724-1-hch@lst.de>
References: <20180806083058.14724-1-hch@lst.de>
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
Tested-by: Avi Kivity <avi@scylladb.com>
---
 fs/aio.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 27454594e37a..fe2018ada32c 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -18,6 +18,7 @@
 #include <linux/export.h>
 #include <linux/syscalls.h>
 #include <linux/backing-dev.h>
+#include <linux/refcount.h>
 #include <linux/uio.h>
 
 #include <linux/sched/signal.h>
@@ -178,6 +179,7 @@ struct aio_kiocb {
 
 	struct list_head	ki_list;	/* the aio core uses this
 						 * for cancellation */
+	refcount_t		ki_refcnt;
 
 	/*
 	 * If the aio_resfd field of the userspace iocb is not zero,
@@ -1015,6 +1017,7 @@ static inline struct aio_kiocb *aio_get_req(struct kioctx *ctx)
 
 	percpu_ref_get(&ctx->reqs);
 	INIT_LIST_HEAD(&req->ki_list);
+	refcount_set(&req->ki_refcnt, 0);
 	req->ki_ctx = ctx;
 	return req;
 out_put:
@@ -1049,6 +1052,15 @@ static struct kioctx *lookup_ioctx(unsigned long ctx_id)
 	return ret;
 }
 
+static inline void iocb_put(struct aio_kiocb *iocb)
+{
+	if (refcount_read(&iocb->ki_refcnt) == 0 ||
+	    refcount_dec_and_test(&iocb->ki_refcnt)) {
+		percpu_ref_put(&iocb->ki_ctx->reqs);
+		kmem_cache_free(kiocb_cachep, iocb);
+	}
+}
+
 /* aio_complete
  *	Called when the io request on the given iocb is complete.
  */
@@ -1118,8 +1130,6 @@ static void aio_complete(struct aio_kiocb *iocb, long res, long res2)
 		eventfd_ctx_put(iocb->ki_eventfd);
 	}
 
-	kmem_cache_free(kiocb_cachep, iocb);
-
 	/*
 	 * We have to order our ring_info tail store above and test
 	 * of the wait list below outside the wait lock.  This is
@@ -1130,8 +1140,7 @@ static void aio_complete(struct aio_kiocb *iocb, long res, long res2)
 
 	if (waitqueue_active(&ctx->wait))
 		wake_up(&ctx->wait);
-
-	percpu_ref_put(&ctx->reqs);
+	iocb_put(iocb);
 }
 
 /* aio_read_events_ring
-- 
2.18.0


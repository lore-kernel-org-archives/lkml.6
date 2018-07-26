Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C932C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B21AC2064D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nBCftmjs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B21AC2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbeGZJpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 05:45:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45364 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728600AbeGZJpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 05:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HXy3zv26q8SH0hFyF5lTNkg3u2wWghn9TvenKr+09hM=; b=nBCftmjsZya3DMI/VUXGmM1LO
        9JWURRK/5rukucSefomhXqxRNi4Use/8ZDZ0EnTmlp6gM2i1AF6bjD3q9KfkVhR4pvqrrnKZH2KJB
        /3SmSH8QY4L4Yoamk8yHY/mCfAAwd2dpwxxncGlPougMG5HleD8s2ze+do2o1M320jLXW2+H64Cgf
        2i42SiZuOniQDbPl5K/JKmxj+djapHnZwlcfHx4wfnVcddhuhxfk5J71px/IO2ieZNQGLYX9VK3sE
        j2i7+xix9FX8pd7gPh9Ryw+YF/ZayozWPURTlYvPgd0uTdQro4oCPCEWMYrIwPtul4CWXfcpRhlUC
        XjGHpS3lg==;
Received: from 089144199017.atnat0008.highway.a1.net ([89.144.199.17] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fibeK-00080R-T2; Thu, 26 Jul 2018 08:29:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     viro@zeniv.linux.org.uk
Cc:     Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] aio: allow direct aio poll comletions for keyed wakeups
Date:   Thu, 26 Jul 2018 10:29:03 +0200
Message-Id: <20180726082903.30273-5-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726082903.30273-1-hch@lst.de>
References: <20180726082903.30273-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we get a keyed wakeup for a aio poll waitqueue and wake can acquire the
ctx_lock without spinning we can just complete the iocb straight from the
wakeup callback to avoid a context switch.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/aio.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index cf364d75abe9..ea744092387d 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1673,11 +1673,25 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 		void *key)
 {
 	struct poll_iocb *req = container_of(wait, struct poll_iocb, wait);
+	struct aio_kiocb *iocb = container_of(req, struct aio_kiocb, poll);
 	__poll_t mask = key_to_poll(key);
 
 	/* for instances that support it check for an event match first: */
-	if (mask && !(mask & req->events))
-		return 0;
+	if (mask) {
+		if (!(mask & req->events))
+			return 0;
+
+		/* try to complete the iocb inline if we can: */
+		if (spin_trylock(&iocb->ki_ctx->ctx_lock)) {
+			req->done = true;
+			list_del(&iocb->ki_list);
+			spin_unlock(&iocb->ki_ctx->ctx_lock);
+
+			list_del_init(&req->wait.entry);
+			aio_poll_complete(iocb, mask);
+			return 1;
+		}
+	}
 
 	list_del_init(&req->wait.entry);
 	schedule_work(&req->work);
-- 
2.18.0


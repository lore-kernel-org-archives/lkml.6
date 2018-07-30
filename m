Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E44C46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED0C920893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eS9l7v0A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED0C920893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbeG3Itr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 04:49:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33468 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbeG3Itq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 04:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zVifwcnZBWlJrKiu7x5RvybRHcPmPcZJmynAIWjhYB4=; b=eS9l7v0Ar9E9nrOeDZNDOqzKo
        zNEePtCgRnJahL3QpJVtpWFNEwJfSmhVEApwb8On8Kqt4YYV3wapApaCZn3p1vbbhfLFlUoDb0EP8
        z7rh4unEPnf0gIQk0UotihjROX5DrKrJHcKvkHc0STWKK75XOrErBHvmAEtIgQZ1zNDPjqnD/YIDD
        D9swTSYRCzD6bEwjcEi0RKCQOVb0uCk/DiUMhiiOIKHjCA6FR6CG0HNHQoy532KQJSNqff26toIQS
        At76g50I+H4whepee2clqL2loU4JMMVSkOKbFpoNrpfecYMT+ZE+a6YKji222h9ecc0qOCJOlcx+b
        fImkMR0Cw==;
Received: from 089144213232.atnat0022.highway.a1.net ([89.144.213.232] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fk2PZ-0001KO-5k; Mon, 30 Jul 2018 07:16:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     viro@zeniv.linux.org.uk
Cc:     Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] aio: allow direct aio poll comletions for keyed wakeups
Date:   Mon, 30 Jul 2018 09:15:44 +0200
Message-Id: <20180730071544.23998-5-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180730071544.23998-1-hch@lst.de>
References: <20180730071544.23998-1-hch@lst.de>
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
index 6993684d0665..158c5e41b17c 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1674,11 +1674,25 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
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


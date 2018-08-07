Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777B5C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E50021775
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E50021775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388702AbeHGNx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 09:53:27 -0400
Received: from verein.lst.de ([213.95.11.211]:60606 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbeHGNx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 09:53:26 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 1DFE968B02; Tue,  7 Aug 2018 13:44:51 +0200 (CEST)
Date:   Tue, 7 Aug 2018 13:44:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     viro@zeniv.linux.org.uk
Cc:     Avi Kivity <avi@scylladb.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4 v2] aio: allow direct aio poll comletions for keyed
        wakeups
Message-ID: <20180807114451.GA8853@lst.de>
References: <20180806083058.14724-1-hch@lst.de> <20180806083058.14724-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806083058.14724-5-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we get a keyed wakeup for a aio poll waitqueue and wake can acquire the
ctx_lock without spinning we can just complete the iocb straight from the
wakeup callback to avoid a context switch.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Avi Kivity <avi@scylladb.com>
---

Fix a subject line typo and improve a comment.

 fs/aio.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 2fd19521d8a8..5943098a87c6 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1672,13 +1672,29 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 		void *key)
 {
 	struct poll_iocb *req = container_of(wait, struct poll_iocb, wait);
+	struct aio_kiocb *iocb = container_of(req, struct aio_kiocb, poll);
 	__poll_t mask = key_to_poll(key);
 
 	req->woken = true;
 
 	/* for instances that support it check for an event match first: */
-	if (mask && !(mask & req->events))
-		return 0;
+	if (mask) {
+		if (!(mask & req->events))
+			return 0;
+
+		/*
+		 * Try to complete the iocb inline if we can to avoid a costly
+		 * context switch.
+		 */
+		if (spin_trylock(&iocb->ki_ctx->ctx_lock)) {
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


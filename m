Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1568BC1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE53520C0B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Oki2hAGh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE53520C0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390470AbeGKVJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 17:09:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47004 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387727AbeGKVIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 17:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Hs8EMjkyEQxDuSEGOg8/90rPeegDKI9TpdBvQ+/5ZKs=; b=Oki2hAGhnigvrsSCMU42laeUO
        2FQk3D1pUp+7fwZ9H5MPMjoBTkwvASdpHy92HMvbq8C+EZpdSSng/M52YutBwJmRH1TEJhsSFSQ9L
        AW4uJ4ymm5khh2LUD9skkEyYcx3vj6ddgfRe5arwQQoHGJnxuIO8XStKAuNFYi3Eu5c8IZ8s8LjaH
        ILZxiOJ0cDoA6NZiWs8S91yU4CN6op00VgSKogAp8cwGZ8iesJ32b2eP7Yi6+5TyX1tq3oH88D2vd
        BjDA2JrYVtLjsSuyL0tyXWZQhrFIFatOCVImQiTVF4rwuKTV4gYQl2fwc8rd0KtoYgvDpkxgyQ8IB
        dbB3DMcug==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdMFq-0005AK-Ay; Wed, 11 Jul 2018 21:02:30 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        v9fs-developer@lists.sourceforge.net,
        Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 4/6] 9p: Embed wait_queue_head into p9_req_t
Date:   Wed, 11 Jul 2018 14:02:23 -0700
Message-Id: <20180711210225.19730-5-willy@infradead.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180711210225.19730-1-willy@infradead.org>
References: <20180711210225.19730-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a 64-bit system, the wait_queue_head_t is 24 bytes while the pointer
to it is 8 bytes.  Growing the p9_req_t by 16 bytes is better than
performing a 24-byte memory allocation.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 include/net/9p/client.h |  2 +-
 net/9p/client.c         | 19 +++++--------------
 net/9p/trans_virtio.c   |  2 +-
 3 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/include/net/9p/client.h b/include/net/9p/client.h
index e405729cd1c7..0fa0fbab33b0 100644
--- a/include/net/9p/client.h
+++ b/include/net/9p/client.h
@@ -113,7 +113,7 @@ enum p9_req_status_t {
 struct p9_req_t {
 	int status;
 	int t_err;
-	wait_queue_head_t *wq;
+	wait_queue_head_t wq;
 	struct p9_fcall *tc;
 	struct p9_fcall *rc;
 	void *aux;
diff --git a/net/9p/client.c b/net/9p/client.c
index b89c7298267c..bc8aba6b5ce0 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -282,8 +282,9 @@ p9_tag_alloc(struct p9_client *c, u16 tag, unsigned int max_size)
 				return ERR_PTR(-ENOMEM);
 			}
 			for (col = 0; col < P9_ROW_MAXTAG; col++) {
-				c->reqs[row][col].status = REQ_STATUS_IDLE;
-				c->reqs[row][col].tc = NULL;
+				req = &c->reqs[row][col];
+				req->status = REQ_STATUS_IDLE;
+				init_waitqueue_head(&req->wq);
 			}
 			c->max_tag += P9_ROW_MAXTAG;
 		}
@@ -293,13 +294,6 @@ p9_tag_alloc(struct p9_client *c, u16 tag, unsigned int max_size)
 	col = tag % P9_ROW_MAXTAG;
 
 	req = &c->reqs[row][col];
-	if (!req->wq) {
-		req->wq = kmalloc(sizeof(wait_queue_head_t), GFP_NOFS);
-		if (!req->wq)
-			goto grow_failed;
-		init_waitqueue_head(req->wq);
-	}
-
 	if (!req->tc)
 		req->tc = p9_fcall_alloc(alloc_msize);
 	if (!req->rc)
@@ -319,9 +313,7 @@ p9_tag_alloc(struct p9_client *c, u16 tag, unsigned int max_size)
 	pr_err("Couldn't grow tag array\n");
 	kfree(req->tc);
 	kfree(req->rc);
-	kfree(req->wq);
 	req->tc = req->rc = NULL;
-	req->wq = NULL;
 	return ERR_PTR(-ENOMEM);
 }
 
@@ -409,7 +401,6 @@ static void p9_tag_cleanup(struct p9_client *c)
 	/* free requests associated with tags */
 	for (row = 0; row < (c->max_tag/P9_ROW_MAXTAG); row++) {
 		for (col = 0; col < P9_ROW_MAXTAG; col++) {
-			kfree(c->reqs[row][col].wq);
 			kfree(c->reqs[row][col].tc);
 			kfree(c->reqs[row][col].rc);
 		}
@@ -452,7 +443,7 @@ void p9_client_cb(struct p9_client *c, struct p9_req_t *req, int status)
 	smp_wmb();
 	req->status = status;
 
-	wake_up(req->wq);
+	wake_up(&req->wq);
 	p9_debug(P9_DEBUG_MUX, "wakeup: %d\n", req->tc->tag);
 }
 EXPORT_SYMBOL(p9_client_cb);
@@ -773,7 +764,7 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
 	}
 again:
 	/* Wait for the response */
-	err = wait_event_killable(*req->wq, req->status >= REQ_STATUS_RCVD);
+	err = wait_event_killable(req->wq, req->status >= REQ_STATUS_RCVD);
 
 	/*
 	 * Make sure our req is coherent with regard to updates in other
diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 05006cbb3361..3e096c98313c 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -490,7 +490,7 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 	virtqueue_kick(chan->vq);
 	spin_unlock_irqrestore(&chan->lock, flags);
 	p9_debug(P9_DEBUG_TRANS, "virtio request kicked\n");
-	err = wait_event_killable(*req->wq, req->status >= REQ_STATUS_RCVD);
+	err = wait_event_killable(req->wq, req->status >= REQ_STATUS_RCVD);
 	/*
 	 * Non kernel buffers are pinned, unpin them
 	 */
-- 
2.18.0


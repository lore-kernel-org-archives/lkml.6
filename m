Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69089C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25EC22084A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25EC22084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbeLKMmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 07:42:21 -0500
Received: from nautica.notk.org ([91.121.71.147]:49681 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbeLKMmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 07:42:16 -0500
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 7D057C01F; Tue, 11 Dec 2018 13:42:14 +0100 (CET)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     v9fs-developer@lists.sourceforge.net
Cc:     Dominique Martinet <dominique.martinet@cea.fr>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Tomas Bortoli <tomasbortoli@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH 3/3] 9p/net: make flush asynchronous
Date:   Tue, 11 Dec 2018 13:41:48 +0100
Message-Id: <1544532108-21689-3-git-send-email-asmadeus@codewreck.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1544532108-21689-1-git-send-email-asmadeus@codewreck.org>
References: <1544532108-21689-1-git-send-email-asmadeus@codewreck.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dominique Martinet <dominique.martinet@cea.fr>

Make the client flush asynchronous so we don't need to ignore signals in
rpc functions:
 - on signal, send a flush request as we previously did but use the new
asynchronous helper and return immediately
 - when the reply has been received or connection is destroyed, free
both tags in the handler

Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
Cc: Eric Van Hensbergen <ericvh@gmail.com>
Cc: Latchesar Ionkov <lucho@ionkov.net>
Cc: Tomas Bortoli <tomasbortoli@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
---
 include/net/9p/client.h |   2 +
 net/9p/client.c         | 172 ++++++++++++++++++----------------------
 2 files changed, 78 insertions(+), 96 deletions(-)

diff --git a/include/net/9p/client.h b/include/net/9p/client.h
index 75d7f83e5b94..dcd40e7ef202 100644
--- a/include/net/9p/client.h
+++ b/include/net/9p/client.h
@@ -91,6 +91,7 @@ enum p9_req_status_t {
  * @aux: transport specific data (provided for trans_fd migration)
  * @req_list: link used by trans_fd
  * @async_list: link used to check on async requests
+ * @flushed_req: for flush, points to matching flushed req
  * @clunked_fid: for clunk, points to fid
  */
 struct p9_req_t {
@@ -104,6 +105,7 @@ struct p9_req_t {
 	struct list_head req_list;
 	struct list_head async_list;
 	union {
+		struct p9_req_t *flushed_req;
 		struct p9_fid *clunked_fid;
 	};
 };
diff --git a/net/9p/client.c b/net/9p/client.c
index a47b5a54573d..666a722088e9 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -694,50 +694,6 @@ static void p9_fid_destroy(struct p9_fid *fid)
 	kfree(fid);
 }
 
-static struct p9_req_t *
-p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...);
-
-/**
- * p9_client_flush - flush (cancel) a request
- * @c: client state
- * @oldreq: request to cancel
- *
- * This sents a flush for a particular request and links
- * the flush request to the original request.  The current
- * code only supports a single flush request although the protocol
- * allows for multiple flush requests to be sent for a single request.
- *
- */
-
-static int p9_client_flush(struct p9_client *c, struct p9_req_t *oldreq)
-{
-	struct p9_req_t *req;
-	int16_t oldtag;
-	int err;
-
-	err = p9_parse_header(&oldreq->tc, NULL, NULL, &oldtag, 1);
-	if (err)
-		return err;
-
-	p9_debug(P9_DEBUG_9P, ">>> TFLUSH tag %d\n", oldtag);
-
-	req = p9_client_rpc(c, P9_TFLUSH, "w", oldtag);
-	if (IS_ERR(req))
-		return PTR_ERR(req);
-
-	/*
-	 * if we haven't received a response for oldreq,
-	 * remove it from the list
-	 */
-	if (oldreq->status == REQ_STATUS_SENT) {
-		if (c->trans_mod->cancelled)
-			c->trans_mod->cancelled(c, oldreq);
-	}
-
-	p9_tag_remove(c, req);
-	return 0;
-}
-
 static struct p9_req_t *p9_client_prepare_req(struct p9_client *c,
 					      int8_t type, int req_size,
 					      const char *fmt, va_list ap)
@@ -800,6 +756,39 @@ p9_client_async_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
 	return req;
 }
 
+/**
+ * p9_client_flush - flush (cancel) a request
+ * @c: client state
+ * @oldreq: request to cancel
+ *
+ * This sents a flush for a particular request and links
+ * the flush request to the original request.  The current
+ * code only supports a single flush request although the protocol
+ * allows for multiple flush requests to be sent for a single request.
+ *
+ */
+
+static int p9_client_flush(struct p9_client *c, struct p9_req_t *oldreq)
+{
+	struct p9_req_t *req;
+	int16_t oldtag = oldreq->tc.tag;
+
+	p9_debug(P9_DEBUG_9P, ">>> TFLUSH tag %d\n", oldtag);
+	req = p9_client_async_rpc(c, P9_TFLUSH, "w", oldtag);
+	if (IS_ERR(req)) {
+		return PTR_ERR(req);
+	}
+
+	p9_debug(P9_DEBUG_MUX, "sent flush for oldreq %d type %d with flush tag %d\n",
+		 oldtag, oldreq->tc.id, req->tc.tag);
+	req->flushed_req = oldreq;
+	spin_lock_irq(&c->lock);
+	list_add(&req->async_list, &c->async_req_list);
+	spin_unlock_irq(&c->lock);
+
+	return 0;
+}
+
 static void p9_client_handle_async(struct p9_client *c, bool free_all)
 {
 	struct p9_req_t *req, *nreq;
@@ -823,6 +812,24 @@ static void p9_client_handle_async(struct p9_client *c, bool free_all)
 		}
 		if (free_all || req->status >= REQ_STATUS_RCVD) {
 			/* Put old refs whatever reqs actually returned */
+			if (req->tc.id == P9_TFLUSH) {
+				p9_debug(P9_DEBUG_MUX,
+					 "flushing oldreq tag %d status %d, flush_req tag %d\n",
+					 req->flushed_req->tc.tag,
+					 req->flushed_req->status,
+					 req->tc.tag);
+				if (req->flushed_req->status < REQ_STATUS_RCVD) {
+					/* won't receive reply now */
+					if (c->trans_mod->cancelled)
+						c->trans_mod->cancelled(c, req);
+					p9_req_put(req->flushed_req);
+				}
+				if (!p9_tag_remove(c, req->flushed_req))
+					p9_debug(P9_DEBUG_ERROR,
+						 "oldreq tag %d status %d still has ref\n",
+						 req->flushed_req->tc.tag,
+						 req->flushed_req->status);
+			}
 			if (req->tc.id == P9_TCLUNK) {
 				p9_fid_destroy(req->clunked_fid);
 			}
@@ -846,8 +853,8 @@ static struct p9_req_t *
 p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
 {
 	va_list ap;
-	int sigpending, err;
-	unsigned long flags;
+	int err;
+	int flushing = 0;
 	struct p9_req_t *req;
 
 	p9_client_handle_async(c, 0);
@@ -859,10 +866,11 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
 		return req;
 
 	if (signal_pending(current)) {
-		sigpending = 1;
-		clear_thread_flag(TIF_SIGPENDING);
-	} else
-		sigpending = 0;
+		err = -ERESTARTSYS;
+		/* write won't happen */
+		p9_req_put(req);
+		goto reterr;
+	}
 
 	err = c->trans_mod->request(c, req);
 	if (err < 0) {
@@ -870,9 +878,9 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
 		p9_req_put(req);
 		if (err != -ERESTARTSYS && err != -EFAULT)
 			c->status = Disconnected;
-		goto recalc_sigpending;
+		goto reterr;
 	}
-again:
+
 	/* Wait for the response */
 	err = wait_event_killable(req->wq, req->status >= REQ_STATUS_RCVD);
 
@@ -882,34 +890,15 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
 	 */
 	smp_rmb();
 
-	if ((err == -ERESTARTSYS) && (c->status == Connected)
-				  && (type == P9_TFLUSH)) {
-		sigpending = 1;
-		clear_thread_flag(TIF_SIGPENDING);
-		goto again;
-	}
-
 	if (req->status == REQ_STATUS_ERROR) {
 		p9_debug(P9_DEBUG_ERROR, "req_status error %d\n", req->t_err);
 		err = req->t_err;
 	}
 	if ((err == -ERESTARTSYS) && (c->status == Connected)) {
 		p9_debug(P9_DEBUG_MUX, "flushing\n");
-		sigpending = 1;
-		clear_thread_flag(TIF_SIGPENDING);
-
-		if (c->trans_mod->cancel(c, req))
-			p9_client_flush(c, req);
 
-		/* if we received the response anyway, don't signal error */
-		if (req->status == REQ_STATUS_RCVD)
-			err = 0;
-	}
-recalc_sigpending:
-	if (sigpending) {
-		spin_lock_irqsave(&current->sighand->siglock, flags);
-		recalc_sigpending();
-		spin_unlock_irqrestore(&current->sighand->siglock, flags);
+		if (c->trans_mod->cancel(c, req) && !p9_client_flush(c, req))
+				flushing = 1;
 	}
 	if (err < 0)
 		goto reterr;
@@ -919,7 +908,8 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
 	if (!err)
 		return req;
 reterr:
-	p9_tag_remove(c, req);
+	if (!flushing)
+		p9_tag_remove(c, req);
 	return ERR_PTR(safe_errno(err));
 }
 
@@ -943,8 +933,8 @@ static struct p9_req_t *p9_client_zc_rpc(struct p9_client *c, int8_t type,
 					 const char *fmt, ...)
 {
 	va_list ap;
-	int sigpending, err;
-	unsigned long flags;
+	int err;
+	int flushing = 0;
 	struct p9_req_t *req;
 
 	p9_client_handle_async(c, 0);
@@ -960,10 +950,11 @@ static struct p9_req_t *p9_client_zc_rpc(struct p9_client *c, int8_t type,
 		return req;
 
 	if (signal_pending(current)) {
-		sigpending = 1;
-		clear_thread_flag(TIF_SIGPENDING);
-	} else
-		sigpending = 0;
+		err = -ERESTARTSYS;
+		/* write won't happen */
+		p9_req_put(req);
+		goto reterr;
+	}
 
 	err = c->trans_mod->zc_request(c, req, uidata, uodata,
 				       inlen, olen, in_hdrlen);
@@ -971,7 +962,7 @@ static struct p9_req_t *p9_client_zc_rpc(struct p9_client *c, int8_t type,
 		if (err == -EIO)
 			c->status = Disconnected;
 		if (err != -ERESTARTSYS)
-			goto recalc_sigpending;
+			goto reterr;
 	}
 	if (req->status == REQ_STATUS_ERROR) {
 		p9_debug(P9_DEBUG_ERROR, "req_status error %d\n", req->t_err);
@@ -979,21 +970,9 @@ static struct p9_req_t *p9_client_zc_rpc(struct p9_client *c, int8_t type,
 	}
 	if ((err == -ERESTARTSYS) && (c->status == Connected)) {
 		p9_debug(P9_DEBUG_MUX, "flushing\n");
-		sigpending = 1;
-		clear_thread_flag(TIF_SIGPENDING);
-
-		if (c->trans_mod->cancel(c, req))
-			p9_client_flush(c, req);
 
-		/* if we received the response anyway, don't signal error */
-		if (req->status == REQ_STATUS_RCVD)
-			err = 0;
-	}
-recalc_sigpending:
-	if (sigpending) {
-		spin_lock_irqsave(&current->sighand->siglock, flags);
-		recalc_sigpending();
-		spin_unlock_irqrestore(&current->sighand->siglock, flags);
+		if (c->trans_mod->cancel(c, req) && !p9_client_flush(c, req))
+			flushing = 1;
 	}
 	if (err < 0)
 		goto reterr;
@@ -1003,7 +982,8 @@ static struct p9_req_t *p9_client_zc_rpc(struct p9_client *c, int8_t type,
 	if (!err)
 		return req;
 reterr:
-	p9_tag_remove(c, req);
+	if (!flushing)
+		p9_tag_remove(c, req);
 	return ERR_PTR(safe_errno(err));
 }
 
-- 
2.19.2


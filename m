Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315AFC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F14462084A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:42:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F14462084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbeLKMmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 07:42:14 -0500
Received: from nautica.notk.org ([91.121.71.147]:49663 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbeLKMmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 07:42:14 -0500
Received: by nautica.notk.org (Postfix, from userid 1001)
        id E5B0BC01D; Tue, 11 Dec 2018 13:42:11 +0100 (CET)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     v9fs-developer@lists.sourceforge.net
Cc:     Dominique Martinet <dominique.martinet@cea.fr>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Tomas Bortoli <tomasbortoli@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH 1/3] 9p/net: implement asynchronous rpc
Date:   Tue, 11 Dec 2018 13:41:46 +0100
Message-Id: <1544532108-21689-1-git-send-email-asmadeus@codewreck.org>
X-Mailer: git-send-email 1.7.10.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dominique Martinet <dominique.martinet@cea.fr>

Add p9_client_async_rpc that will let us send an rpc without waiting
for the reply, as well as an async handler hook.

The work done in the hook could mostly be done in the client callback,
but I prefered not to for a couple of reasons:
 - the callback can be called in an IRQ for some transports, and the
handler needs to call p9_tag_remove which takes the client lock that has
recently been reworked to not be irq-compatible (as it was never taken
in IRQs until now)
 - the handled replies can be handled anytime, there is nothing the
userspace would care about and want to be notified of quickly
 - the async request list and this function would be needed anyway for
when we disconnect the client, in order to not leak async requests that
haven't been replied to

Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
Cc: Eric Van Hensbergen <ericvh@gmail.com>
Cc: Latchesar Ionkov <lucho@ionkov.net>
Cc: Tomas Bortoli <tomasbortoli@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
---

I've been sitting on these patches for almost a month now because I
wanted to fix the cancel race, but I think it's what the most recent
syzbot email is about so if it could find it without this it probably
won't hurt to at least get some reviews for these three patches first.

I won't submit these for next cycle, so will only put them into -next
after 4.20 is released; hopefully I'll have time to look at the two
pending refcount races around that time.
Until then, comments please!


 include/net/9p/client.h |  9 +++++-
 net/9p/client.c         | 64 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/include/net/9p/client.h b/include/net/9p/client.h
index 947a570307a6..a4ded7666c73 100644
--- a/include/net/9p/client.h
+++ b/include/net/9p/client.h
@@ -89,7 +89,8 @@ enum p9_req_status_t {
  * @tc: the request fcall structure
  * @rc: the response fcall structure
  * @aux: transport specific data (provided for trans_fd migration)
- * @req_list: link for higher level objects to chain requests
+ * @req_list: link used by trans_fd
+ * @async_list: link used to check on async requests
  */
 struct p9_req_t {
 	int status;
@@ -100,6 +101,7 @@ struct p9_req_t {
 	struct p9_fcall rc;
 	void *aux;
 	struct list_head req_list;
+	struct list_head async_list;
 };
 
 /**
@@ -110,6 +112,9 @@ struct p9_req_t {
  * @trans_mod: module API instantiated with this client
  * @status: connection state
  * @trans: tranport instance state and API
+ * @fcall_cache: kmem cache for client request data (msize-specific)
+ * @async_req_lock: protects @async_req_list
+ * @async_req_list: list of requests waiting a reply
  * @fids: All active FID handles
  * @reqs: All active requests.
  * @name: node name used as client id
@@ -125,6 +130,8 @@ struct p9_client {
 	enum p9_trans_status status;
 	void *trans;
 	struct kmem_cache *fcall_cache;
+	spinlock_t async_req_lock;
+	struct list_head async_req_list;
 
 	union {
 		struct {
diff --git a/net/9p/client.c b/net/9p/client.c
index 357214a51f13..0a67c3ccd4fd 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -729,6 +729,62 @@ static struct p9_req_t *p9_client_prepare_req(struct p9_client *c,
 	return ERR_PTR(err);
 }
 
+static struct p9_req_t *
+p9_client_async_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
+{
+	va_list ap;
+	int err;
+	struct p9_req_t *req;
+
+	va_start(ap, fmt);
+	req = p9_client_prepare_req(c, type, c->msize, fmt, ap);
+	va_end(ap);
+	if (IS_ERR(req))
+		return req;
+
+	err = c->trans_mod->request(c, req);
+	if (err < 0) {
+		/* bail out without flushing... */
+		p9_req_put(req);
+		p9_tag_remove(c, req);
+		if (err != -ERESTARTSYS && err != -EFAULT)
+			c->status = Disconnected;
+		return ERR_PTR(safe_errno(err));
+	}
+
+	return req;
+}
+
+static void p9_client_handle_async(struct p9_client *c, bool free_all)
+{
+	struct p9_req_t *req, *nreq;
+
+	/* it's ok to miss some async replies here, do a quick check without
+	 * lock first unless called with free_all
+	 */
+	if (!free_all && list_empty(&c->async_req_list))
+		return;
+
+	spin_lock_irq(&c->async_req_lock);
+	list_for_each_entry_safe(req, nreq, &c->async_req_list, async_list) {
+		if (free_all && req->status < REQ_STATUS_RCVD) {
+			p9_debug(P9_DEBUG_ERROR,
+				 "final async handler found req tag %d type %d status %d\n",
+				 req->tc.tag, req->tc.id, req->status);
+			if (c->trans_mod->cancelled)
+				c->trans_mod->cancelled(c, req);
+			/* won't receive reply now */
+			p9_req_put(req);
+		}
+		if (free_all || req->status >= REQ_STATUS_RCVD) {
+			/* Put old refs whatever reqs actually returned */
+			list_del(&req->async_list);
+			p9_tag_remove(c, req);
+		}
+	}
+	spin_unlock_irq(&c->async_req_lock);
+}
+
 /**
  * p9_client_rpc - issue a request and wait for a response
  * @c: client session
@@ -746,6 +802,8 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
 	unsigned long flags;
 	struct p9_req_t *req;
 
+	p9_client_handle_async(c, 0);
+
 	va_start(ap, fmt);
 	req = p9_client_prepare_req(c, type, c->msize, fmt, ap);
 	va_end(ap);
@@ -841,6 +899,8 @@ static struct p9_req_t *p9_client_zc_rpc(struct p9_client *c, int8_t type,
 	unsigned long flags;
 	struct p9_req_t *req;
 
+	p9_client_handle_async(c, 0);
+
 	va_start(ap, fmt);
 	/*
 	 * We allocate a inline protocol data of only 4k bytes.
@@ -1030,6 +1090,8 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
 	memcpy(clnt->name, client_id, strlen(client_id) + 1);
 
 	spin_lock_init(&clnt->lock);
+	spin_lock_init(&clnt->async_req_lock);
+	INIT_LIST_HEAD(&clnt->async_req_list);
 	idr_init(&clnt->fids);
 	idr_init(&clnt->reqs);
 
@@ -1101,6 +1163,8 @@ void p9_client_destroy(struct p9_client *clnt)
 
 	v9fs_put_trans(clnt->trans_mod);
 
+	p9_client_handle_async(clnt, 1);
+
 	idr_for_each_entry(&clnt->fids, fid, id) {
 		pr_info("Found fid %d not clunked\n", fid->fid);
 		p9_fid_destroy(fid);
-- 
2.19.2


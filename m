Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DDEC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 387D627441
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jsdDYVlW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 387D627441
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966210AbeF1N1M (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 09:27:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49842 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753807AbeF1N1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 09:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xCd/WCZxmkMVLq7Rv0ciFq6w5NRKj1v1Ic46DvGUkzE=; b=jsdDYVlW6kTraG8pgezhVzeyB
        wuChAAhhPWPF7kbDYjJvg1lw7H8v7sR7SIc0h99B6OOsFGOTwgPDSwqxC7yudHsKiVOLUC1zbP87A
        7ml2PV6BBp/njy6U6zEFTwJUpBJzTn6Tpdcu7UvxmzsA/S+bVgTSZHODhju+bs8xOqnjeRDBLGJ1J
        1ObmaKlB5BopUbUniWjpu2Vqg0fIoWqpiiUBvFhODIGZAFYYAisxXXv/4iYeBS1bgCAMEjtwpj/aa
        e/ueEd+BxJAf28PGEPDE2TiGKE/+653P8HNOukMSHoyNg7Frta/FBV9y3m6KWiODSHOrVjKJc58T0
        s3mpIUW3Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fYWwt-0000s1-QZ; Thu, 28 Jun 2018 13:26:59 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     v9fs-developer@lists.sourceforge.net
Cc:     linux-fsdevel@vger.kernel.org,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 5/6] 9p: Use a slab for allocating requests
Date:   Thu, 28 Jun 2018 06:26:28 -0700
Message-Id: <20180628132629.3148-6-willy@infradead.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180628132629.3148-1-willy@infradead.org>
References: <20180628132629.3148-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the custom batch allocation with a slab.  Use an IDR to store
pointers to the active requests instead of an array.  We don't try to
handle P9_NOTAG specially; the IDR will happily shrink all the way back
once the TVERSION call has completed.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 include/net/9p/client.h |  51 ++-------
 net/9p/client.c         | 240 +++++++++++++++-------------------------
 net/9p/mod.c            |   7 +-
 3 files changed, 102 insertions(+), 196 deletions(-)

diff --git a/include/net/9p/client.h b/include/net/9p/client.h
index 0fa0fbab33b0..fd326811ebd4 100644
--- a/include/net/9p/client.h
+++ b/include/net/9p/client.h
@@ -64,22 +64,15 @@ enum p9_trans_status {
 
 /**
  * enum p9_req_status_t - status of a request
- * @REQ_STATUS_IDLE: request slot unused
  * @REQ_STATUS_ALLOC: request has been allocated but not sent
  * @REQ_STATUS_UNSENT: request waiting to be sent
  * @REQ_STATUS_SENT: request sent to server
  * @REQ_STATUS_RCVD: response received from server
  * @REQ_STATUS_FLSHD: request has been flushed
  * @REQ_STATUS_ERROR: request encountered an error on the client side
- *
- * The @REQ_STATUS_IDLE state is used to mark a request slot as unused
- * but use is actually tracked by the idpool structure which handles tag
- * id allocation.
- *
  */
 
 enum p9_req_status_t {
-	REQ_STATUS_IDLE,
 	REQ_STATUS_ALLOC,
 	REQ_STATUS_UNSENT,
 	REQ_STATUS_SENT,
@@ -92,24 +85,12 @@ enum p9_req_status_t {
  * struct p9_req_t - request slots
  * @status: status of this request slot
  * @t_err: transport error
- * @flush_tag: tag of request being flushed (for flush requests)
  * @wq: wait_queue for the client to block on for this request
  * @tc: the request fcall structure
  * @rc: the response fcall structure
  * @aux: transport specific data (provided for trans_fd migration)
  * @req_list: link for higher level objects to chain requests
- *
- * Transport use an array to track outstanding requests
- * instead of a list.  While this may incurr overhead during initial
- * allocation or expansion, it makes request lookup much easier as the
- * tag id is a index into an array.  (We use tag+1 so that we can accommodate
- * the -1 tag for the T_VERSION request).
- * This also has the nice effect of only having to allocate wait_queues
- * once, instead of constantly allocating and freeing them.  Its possible
- * other resources could benefit from this scheme as well.
- *
  */
-
 struct p9_req_t {
 	int status;
 	int t_err;
@@ -117,40 +98,26 @@ struct p9_req_t {
 	struct p9_fcall *tc;
 	struct p9_fcall *rc;
 	void *aux;
-
 	struct list_head req_list;
 };
 
 /**
  * struct p9_client - per client instance state
- * @lock: protect @fidlist
+ * @lock: protect @fids and @reqs
  * @msize: maximum data size negotiated by protocol
- * @dotu: extension flags negotiated by protocol
  * @proto_version: 9P protocol version to use
  * @trans_mod: module API instantiated with this client
+ * @status: XXX
  * @trans: tranport instance state and API
  * @fids: All active FID handles
- * @tagpool - transaction id accounting for session
- * @reqs - 2D array of requests
- * @max_tag - current maximum tag id allocated
- * @name - node name used as client id
+ * @reqs: All active requests.
+ * @name: node name used as client id
  *
  * The client structure is used to keep track of various per-client
  * state that has been instantiated.
- * In order to minimize per-transaction overhead we use a
- * simple array to lookup requests instead of a hash table
- * or linked list.  In order to support larger number of
- * transactions, we make this a 2D array, allocating new rows
- * when we need to grow the total number of the transactions.
- *
- * Each row is 256 requests and we'll support up to 256 rows for
- * a total of 64k concurrent requests per session.
- *
- * Bugs: duplicated data and potentially unnecessary elements.
  */
-
 struct p9_client {
-	spinlock_t lock; /* protect client structure */
+	spinlock_t lock;
 	unsigned int msize;
 	unsigned char proto_version;
 	struct p9_trans_module *trans_mod;
@@ -170,10 +137,7 @@ struct p9_client {
 	} trans_opts;
 
 	struct idr fids;
-
-	struct p9_idpool *tagpool;
-	struct p9_req_t *reqs[P9_ROW_MAXTAG];
-	int max_tag;
+	struct idr reqs;
 
 	char name[__NEW_UTS_LEN + 1];
 };
@@ -279,4 +243,7 @@ struct p9_fid *p9_client_xattrwalk(struct p9_fid *, const char *, u64 *);
 int p9_client_xattrcreate(struct p9_fid *, const char *, u64, int);
 int p9_client_readlink(struct p9_fid *fid, char **target);
 
+int p9_client_init(void);
+void p9_client_exit(void);
+
 #endif /* NET_9P_CLIENT_H */
diff --git a/net/9p/client.c b/net/9p/client.c
index 2dce8d8307cc..fd5446377445 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -241,132 +241,104 @@ static struct p9_fcall *p9_fcall_alloc(int alloc_msize)
 	return fc;
 }
 
+static struct kmem_cache *p9_req_cache;
+
 /**
- * p9_tag_alloc - lookup/allocate a request by tag
- * @c: client session to lookup tag within
- * @tag: numeric id for transaction
- *
- * this is a simple array lookup, but will grow the
- * request_slots as necessary to accommodate transaction
- * ids which did not previously have a slot.
- *
- * this code relies on the client spinlock to manage locks, its
- * possible we should switch to something else, but I'd rather
- * stick with something low-overhead for the common case.
+ * p9_req_alloc - Allocate a new request.
+ * @c: Client session.
+ * @type: Transaction type.
+ * @max_size: Maximum packet size for this request.
  *
+ * Context: Process context.  What mutex might we be holding that
+ * requires GFP_NOFS?
+ * Return: Pointer to new request.
  */
-
 static struct p9_req_t *
-p9_tag_alloc(struct p9_client *c, u16 tag, unsigned int max_size)
+p9_tag_alloc(struct p9_client *c, int8_t type, unsigned int max_size)
 {
-	unsigned long flags;
-	int row, col;
-	struct p9_req_t *req;
+	struct p9_req_t *req = kmem_cache_alloc(p9_req_cache, GFP_NOFS);
 	int alloc_msize = min(c->msize, max_size);
+	int tag;
 
-	/* This looks up the original request by tag so we know which
-	 * buffer to read the data into */
-	tag++;
-
-	if (tag >= c->max_tag) {
-		spin_lock_irqsave(&c->lock, flags);
-		/* check again since original check was outside of lock */
-		while (tag >= c->max_tag) {
-			row = (tag / P9_ROW_MAXTAG);
-			c->reqs[row] = kcalloc(P9_ROW_MAXTAG,
-					sizeof(struct p9_req_t), GFP_ATOMIC);
-
-			if (!c->reqs[row]) {
-				pr_err("Couldn't grow tag array\n");
-				spin_unlock_irqrestore(&c->lock, flags);
-				return ERR_PTR(-ENOMEM);
-			}
-			for (col = 0; col < P9_ROW_MAXTAG; col++) {
-				req = &c->reqs[row][col];
-				req->status = REQ_STATUS_IDLE;
-				init_waitqueue_head(&req->wq);
-			}
-			c->max_tag += P9_ROW_MAXTAG;
-		}
-		spin_unlock_irqrestore(&c->lock, flags);
-	}
-	row = tag / P9_ROW_MAXTAG;
-	col = tag % P9_ROW_MAXTAG;
+	if (!req)
+		return NULL;
 
-	req = &c->reqs[row][col];
-	if (!req->tc)
-		req->tc = p9_fcall_alloc(alloc_msize);
-	if (!req->rc)
-		req->rc = p9_fcall_alloc(alloc_msize);
+	req->tc = p9_fcall_alloc(alloc_msize);
+	req->rc = p9_fcall_alloc(alloc_msize);
 	if (!req->tc || !req->rc)
-		goto grow_failed;
+		goto free;
 
 	p9pdu_reset(req->tc);
 	p9pdu_reset(req->rc);
-
-	req->tc->tag = tag-1;
 	req->status = REQ_STATUS_ALLOC;
+	init_waitqueue_head(&req->wq);
+	INIT_LIST_HEAD(&req->req_list);
+
+	idr_preload(GFP_NOFS);
+	spin_lock_irq(&c->lock);
+	if (type == P9_TVERSION)
+		tag = idr_alloc(&c->reqs, req, P9_NOTAG, P9_NOTAG + 1,
+				GFP_NOWAIT);
+	else
+		tag = idr_alloc(&c->reqs, req, 0, P9_NOTAG, GFP_NOWAIT);
+	req->tc->tag = tag;
+	spin_unlock_irq(&c->lock);
+	idr_preload_end();
+	if (tag < 0)
+		goto free;
 
 	return req;
 
-grow_failed:
-	pr_err("Couldn't grow tag array\n");
+free:
 	kfree(req->tc);
 	kfree(req->rc);
-	req->tc = req->rc = NULL;
+	kmem_cache_free(p9_req_cache, req);
 	return ERR_PTR(-ENOMEM);
 }
 
 /**
- * p9_tag_lookup - lookup a request by tag
- * @c: client session to lookup tag within
- * @tag: numeric id for transaction
+ * p9_tag_lookup - Look up a request by tag.
+ * @c: Client session.
+ * @tag: Transaction ID.
  *
+ * Context: Any context.
+ * Return: A request, or %NULL if there is no request with that tag.
  */
-
 struct p9_req_t *p9_tag_lookup(struct p9_client *c, u16 tag)
 {
-	int row, col;
-
-	/* This looks up the original request by tag so we know which
-	 * buffer to read the data into */
-	tag++;
-
-	if(tag >= c->max_tag) 
-		return NULL;
+	struct p9_req_t *req;
 
-	row = tag / P9_ROW_MAXTAG;
-	col = tag % P9_ROW_MAXTAG;
+	rcu_read_lock();
+	req = idr_find(&c->reqs, tag);
+	/*
+	 * There's no refcount on the req; a malicious server could cause
+	 * us to dereference a NULL pointer
+	 */
+	rcu_read_unlock();
 
-	return &c->reqs[row][col];
+	return req;
 }
 EXPORT_SYMBOL(p9_tag_lookup);
 
 /**
- * p9_tag_init - setup tags structure and contents
- * @c:  v9fs client struct
- *
- * This initializes the tags structure for each client instance.
+ * p9_free_req - Free a request.
+ * @c: Client session.
+ * @r: Request to free.
  *
+ * Context: Any context.
  */
-
-static int p9_tag_init(struct p9_client *c)
+static void p9_free_req(struct p9_client *c, struct p9_req_t *r)
 {
-	int err = 0;
+	unsigned long flags;
+	u16 tag = r->tc->tag;
 
-	c->tagpool = p9_idpool_create();
-	if (IS_ERR(c->tagpool)) {
-		err = PTR_ERR(c->tagpool);
-		goto error;
-	}
-	err = p9_idpool_get(c->tagpool); /* reserve tag 0 */
-	if (err < 0) {
-		p9_idpool_destroy(c->tagpool);
-		goto error;
-	}
-	c->max_tag = 0;
-error:
-	return err;
+	p9_debug(P9_DEBUG_MUX, "clnt %p req %p tag: %d\n", c, r, tag);
+	spin_lock_irqsave(&c->lock, flags);
+	idr_remove(&c->reqs, tag);
+	spin_unlock_irqrestore(&c->lock, flags);
+	kfree(r->tc);
+	kfree(r->rc);
+	kmem_cache_free(p9_req_cache, r);
 }
 
 /**
@@ -378,52 +350,15 @@ static int p9_tag_init(struct p9_client *c)
  */
 static void p9_tag_cleanup(struct p9_client *c)
 {
-	int row, col;
-
-	/* check to insure all requests are idle */
-	for (row = 0; row < (c->max_tag/P9_ROW_MAXTAG); row++) {
-		for (col = 0; col < P9_ROW_MAXTAG; col++) {
-			if (c->reqs[row][col].status != REQ_STATUS_IDLE) {
-				p9_debug(P9_DEBUG_MUX,
-					 "Attempting to cleanup non-free tag %d,%d\n",
-					 row, col);
-				/* TODO: delay execution of cleanup */
-				return;
-			}
-		}
-	}
-
-	if (c->tagpool) {
-		p9_idpool_put(0, c->tagpool); /* free reserved tag 0 */
-		p9_idpool_destroy(c->tagpool);
-	}
+	struct p9_req_t *req;
+	int id;
 
-	/* free requests associated with tags */
-	for (row = 0; row < (c->max_tag/P9_ROW_MAXTAG); row++) {
-		for (col = 0; col < P9_ROW_MAXTAG; col++) {
-			kfree(c->reqs[row][col].tc);
-			kfree(c->reqs[row][col].rc);
-		}
-		kfree(c->reqs[row]);
+	rcu_read_lock();
+	idr_for_each_entry(&c->reqs, req, id) {
+		pr_info("Tag %d still in use\n", id);
+		p9_free_req(c, req);
 	}
-	c->max_tag = 0;
-}
-
-/**
- * p9_free_req - free a request and clean-up as necessary
- * c: client state
- * r: request to release
- *
- */
-
-static void p9_free_req(struct p9_client *c, struct p9_req_t *r)
-{
-	int tag = r->tc->tag;
-	p9_debug(P9_DEBUG_MUX, "clnt %p req %p tag: %d\n", c, r, tag);
-
-	r->status = REQ_STATUS_IDLE;
-	if (tag != P9_NOTAG && p9_idpool_check(tag, c->tagpool))
-		p9_idpool_put(tag, c->tagpool);
+	rcu_read_unlock();
 }
 
 /**
@@ -686,7 +621,7 @@ static struct p9_req_t *p9_client_prepare_req(struct p9_client *c,
 					      int8_t type, int req_size,
 					      const char *fmt, va_list ap)
 {
-	int tag, err;
+	int err;
 	struct p9_req_t *req;
 
 	p9_debug(P9_DEBUG_MUX, "client %p op %d\n", c, type);
@@ -699,24 +634,17 @@ static struct p9_req_t *p9_client_prepare_req(struct p9_client *c,
 	if ((c->status == BeginDisconnect) && (type != P9_TCLUNK))
 		return ERR_PTR(-EIO);
 
-	tag = P9_NOTAG;
-	if (type != P9_TVERSION) {
-		tag = p9_idpool_get(c->tagpool);
-		if (tag < 0)
-			return ERR_PTR(-ENOMEM);
-	}
-
-	req = p9_tag_alloc(c, tag, req_size);
+	req = p9_tag_alloc(c, type, req_size);
 	if (IS_ERR(req))
 		return req;
 
 	/* marshall the data */
-	p9pdu_prepare(req->tc, tag, type);
+	p9pdu_prepare(req->tc, req->tc->tag, type);
 	err = p9pdu_vwritef(req->tc, c->proto_version, fmt, ap);
 	if (err)
 		goto reterr;
 	p9pdu_finalize(c, req->tc);
-	trace_9p_client_req(c, type, tag);
+	trace_9p_client_req(c, type, req->tc->tag);
 	return req;
 reterr:
 	p9_free_req(c, req);
@@ -1012,14 +940,11 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
 
 	spin_lock_init(&clnt->lock);
 	idr_init(&clnt->fids);
-
-	err = p9_tag_init(clnt);
-	if (err < 0)
-		goto free_client;
+	idr_init(&clnt->reqs);
 
 	err = parse_opts(options, clnt);
 	if (err < 0)
-		goto destroy_tagpool;
+		goto free_client;
 
 	if (!clnt->trans_mod)
 		clnt->trans_mod = v9fs_get_default_trans();
@@ -1028,7 +953,7 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
 		err = -EPROTONOSUPPORT;
 		p9_debug(P9_DEBUG_ERROR,
 			 "No transport defined or default transport\n");
-		goto destroy_tagpool;
+		goto free_client;
 	}
 
 	p9_debug(P9_DEBUG_MUX, "clnt %p trans %p msize %d protocol %d\n",
@@ -1051,8 +976,6 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
 	clnt->trans_mod->close(clnt);
 put_trans:
 	v9fs_put_trans(clnt->trans_mod);
-destroy_tagpool:
-	p9_idpool_destroy(clnt->tagpool);
 free_client:
 	kfree(clnt);
 	return ERR_PTR(err);
@@ -2268,3 +2191,14 @@ int p9_client_readlink(struct p9_fid *fid, char **target)
 	return err;
 }
 EXPORT_SYMBOL(p9_client_readlink);
+
+int __init p9_client_init(void)
+{
+	p9_req_cache = KMEM_CACHE(p9_req_t, 0);
+	return p9_req_cache ? 0 : -ENOMEM;
+}
+
+void __exit p9_client_exit(void)
+{
+	kmem_cache_destroy(p9_req_cache);
+}
diff --git a/net/9p/mod.c b/net/9p/mod.c
index eb9777f05755..0da56d6af73b 100644
--- a/net/9p/mod.c
+++ b/net/9p/mod.c
@@ -171,7 +171,11 @@ void v9fs_put_trans(struct p9_trans_module *m)
  */
 static int __init init_p9(void)
 {
-	int ret = 0;
+	int ret;
+
+	ret = p9_client_init();
+	if (ret)
+		return ret;
 
 	p9_error_init();
 	pr_info("Installing 9P2000 support\n");
@@ -190,6 +194,7 @@ static void __exit exit_p9(void)
 	pr_info("Unloading 9P2000 support\n");
 
 	p9_trans_fd_exit();
+	p9_client_exit();
 }
 
 module_init(init_p9)
-- 
2.18.0


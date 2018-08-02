Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7F5C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 02:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8B2208A3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 02:38:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B8B2208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbeHBE0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 00:26:52 -0400
Received: from nautica.notk.org ([91.121.71.147]:35053 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbeHBE0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 00:26:52 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 71AA5C01A; Thu,  2 Aug 2018 04:37:57 +0200 (CEST)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     v9fs-developer@lists.sourceforge.net
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dominique Martinet <dominique.martinet@cea.fr>,
        Matthew Wilcox <willy@infradead.org>,
        Greg Kurz <groug@kaod.org>, Jun Piao <piaojun@huawei.com>
Subject: [PATCH v2 2/2] net/9p: add a per-client fcall kmem_cache
Date:   Thu,  2 Aug 2018 04:37:32 +0200
Message-Id: <1533177452-2165-2-git-send-email-asmadeus@codewreck.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1533177452-2165-1-git-send-email-asmadeus@codewreck.org>
References: <1532943263-24378-1-git-send-email-asmadeus@codewreck.org>
 <1533177452-2165-1-git-send-email-asmadeus@codewreck.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dominique Martinet <dominique.martinet@cea.fr>

Having a specific cache for the fcall allocations helps speed up
allocations a bit, especially in case of non-"round" msizes.

The caches will automatically be merged if there are multiple caches
of items with the same size so we do not need to try to share a cache
between different clients of the same size.

Since the msize is negotiated with the server, only allocate the cache
after that negotiation has happened - previous allocations or
allocations of different sizes (e.g. zero-copy fcall) are made with
kmalloc directly.

Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Greg Kurz <groug@kaod.org>
Cc: Jun Piao <piaojun@huawei.com>
---
v2: 
 - Add a pointer to the cache in p9_fcall to make sure a buffer
allocated with kmalloc gets freed with kfree and vice-versa
This could have been smaller with a bool but this spares having
to look at the client so looked a bit cleaner, I'm expecting this
patch will need a v3 one way or another so I went for the bolder
approach - please say if you think a smaller item is better ; I *think*
nothing relies on this being ordered the same way as the data on the
wire (struct isn't packed anyway) so we can move id after tag and add
another u8 to not have any overhead

 - added likely() to cache existence check in allocation, but nothing
for msize check or free because of zc request being of different size

 include/net/9p/9p.h     |  1 +
 include/net/9p/client.h |  2 ++
 net/9p/client.c         | 34 ++++++++++++++++++++++++++++------
 net/9p/trans_rdma.c     |  2 +-
 4 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/include/net/9p/9p.h b/include/net/9p/9p.h
index e23896116d9a..f1d2ed3cee61 100644
--- a/include/net/9p/9p.h
+++ b/include/net/9p/9p.h
@@ -558,6 +558,7 @@ struct p9_fcall {
 	size_t offset;
 	size_t capacity;
 
+	struct kmem_cache *cache;
 	u8 *sdata;
 };
 
diff --git a/include/net/9p/client.h b/include/net/9p/client.h
index 4b4ac1362ad5..735f3979d559 100644
--- a/include/net/9p/client.h
+++ b/include/net/9p/client.h
@@ -123,6 +123,7 @@ struct p9_client {
 	struct p9_trans_module *trans_mod;
 	enum p9_trans_status status;
 	void *trans;
+	struct kmem_cache *fcall_cache;
 
 	union {
 		struct {
@@ -230,6 +231,7 @@ int p9_client_mkdir_dotl(struct p9_fid *fid, const char *name, int mode,
 				kgid_t gid, struct p9_qid *);
 int p9_client_lock_dotl(struct p9_fid *fid, struct p9_flock *flock, u8 *status);
 int p9_client_getlock_dotl(struct p9_fid *fid, struct p9_getlock *fl);
+void p9_fcall_fini(struct p9_fcall *fc);
 struct p9_req_t *p9_tag_lookup(struct p9_client *, u16);
 void p9_client_cb(struct p9_client *c, struct p9_req_t *req, int status);
 
diff --git a/net/9p/client.c b/net/9p/client.c
index bc40bb11b832..0e0f8bb3fd3c 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -231,19 +231,36 @@ static int parse_opts(char *opts, struct p9_client *clnt)
 	return ret;
 }
 
-static int p9_fcall_init(struct p9_fcall *fc, int alloc_msize)
+static int p9_fcall_init(struct p9_client *c, struct p9_fcall *fc,
+			 int alloc_msize)
 {
-	fc->sdata = kmalloc(alloc_msize, GFP_NOFS);
+	if (likely(c->fcall_cache) && alloc_msize == c->msize) {
+		fc->sdata = kmem_cache_alloc(c->fcall_cache, GFP_NOFS);
+		fc->cache = c->fcall_cache;
+	} else {
+		fc->sdata = kmalloc(alloc_msize, GFP_NOFS);
+		fc->cache = NULL;
+	}
 	if (!fc->sdata)
 		return -ENOMEM;
 	fc->capacity = alloc_msize;
 	return 0;
 }
 
-static void p9_fcall_fini(struct p9_fcall *fc)
+void p9_fcall_fini(struct p9_fcall *fc)
 {
-	kfree(fc->sdata);
+	/* sdata can be NULL for interrupted requests in trans_rdma,
+	 * and kmem_cache_free does not do NULL-check for us
+	 */
+	if (unlikely(!fc->sdata))
+		return;
+
+	if (fc->cache)
+		kmem_cache_free(fc->cache, fc->sdata);
+	else
+		kfree(fc->sdata);
 }
+EXPORT_SYMBOL(p9_fcall_fini);
 
 static struct kmem_cache *p9_req_cache;
 
@@ -266,9 +283,9 @@ p9_tag_alloc(struct p9_client *c, int8_t type, unsigned int max_size)
 	if (!req)
 		return NULL;
 
-	if (p9_fcall_init(&req->tc, alloc_msize))
+	if (p9_fcall_init(c, &req->tc, alloc_msize))
 		goto free_req;
-	if (p9_fcall_init(&req->rc, alloc_msize))
+	if (p9_fcall_init(c, &req->rc, alloc_msize))
 		goto free;
 
 	p9pdu_reset(&req->tc);
@@ -950,6 +967,7 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
 
 	clnt->trans_mod = NULL;
 	clnt->trans = NULL;
+	clnt->fcall_cache = NULL;
 
 	client_id = utsname()->nodename;
 	memcpy(clnt->name, client_id, strlen(client_id) + 1);
@@ -986,6 +1004,9 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
 	if (err)
 		goto close_trans;
 
+	clnt->fcall_cache = kmem_cache_create("9p-fcall-cache", clnt->msize,
+					      0, 0, NULL);
+
 	return clnt;
 
 close_trans:
@@ -1017,6 +1038,7 @@ void p9_client_destroy(struct p9_client *clnt)
 
 	p9_tag_cleanup(clnt);
 
+	kmem_cache_destroy(clnt->fcall_cache);
 	kfree(clnt);
 }
 EXPORT_SYMBOL(p9_client_destroy);
diff --git a/net/9p/trans_rdma.c b/net/9p/trans_rdma.c
index c5cac97df7f7..c60655c90c9e 100644
--- a/net/9p/trans_rdma.c
+++ b/net/9p/trans_rdma.c
@@ -445,7 +445,7 @@ static int rdma_request(struct p9_client *client, struct p9_req_t *req)
 	if (unlikely(atomic_read(&rdma->excess_rc) > 0)) {
 		if ((atomic_sub_return(1, &rdma->excess_rc) >= 0)) {
 			/* Got one! */
-			kfree(req->rc.sdata);
+			p9_fcall_fini(&req->rc);
 			req->rc.sdata = NULL;
 			goto dont_need_post_recv;
 		} else {
-- 
2.17.1


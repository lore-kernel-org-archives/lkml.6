Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09BFC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38353208FA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38353208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732393AbeHIQ7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 12:59:22 -0400
Received: from nautica.notk.org ([91.121.71.147]:37673 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731227AbeHIQ7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 12:59:22 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 692BBC01A; Thu,  9 Aug 2018 16:34:11 +0200 (CEST)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     v9fs-developer@lists.sourceforge.net
Cc:     Dominique Martinet <dominique.martinet@cea.fr>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Greg Kurz <groug@kaod.org>, Jun Piao <piaojun@huawei.com>
Subject: [PATCH v3 2/2] net/9p: add a per-client fcall kmem_cache
Date:   Thu,  9 Aug 2018 16:33:56 +0200
Message-Id: <1533825236-22896-2-git-send-email-asmadeus@codewreck.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1533825236-22896-1-git-send-email-asmadeus@codewreck.org>
References: <1533177452-2165-1-git-send-email-asmadeus@codewreck.org>
 <1533825236-22896-1-git-send-email-asmadeus@codewreck.org>
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

v3:
 - defined the userdata region in the cache, as read or write calls can
access the buffer directly (lead to warnings with HARDENED_USERCOPY=y)



I didn't get any comment on v2 for this patch, but I'm still not fully
happy with this in all honesty.

Part of me believes we might be better off always allocating from the
cache even for zero-copy headers, it's a waste of space but the buffers
are there and being reused constantly for non-zc calls, and mixing
kmallocs in could lead to these buffers being really freed and
reallocated all the time instead of reusing the slab buffers
continuously.

That would let me move the likely() for the fast path, with the only
exception being the TVERSION initial call on mount, for which I still
don't have any nice idea on how to handle, using a different size in
p9_client_rpc or prepare_req if the type is TVERSION and I'm really not
happy with that...


 include/net/9p/9p.h     |  4 ++++
 include/net/9p/client.h |  1 +
 net/9p/client.c         | 40 +++++++++++++++++++++++++++++++++++-----
 3 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/include/net/9p/9p.h b/include/net/9p/9p.h
index e23896116d9a..645266b74652 100644
--- a/include/net/9p/9p.h
+++ b/include/net/9p/9p.h
@@ -336,6 +336,9 @@ enum p9_qid_t {
 #define P9_NOFID	(u32)(~0)
 #define P9_MAXWELEM	16
 
+/* Minimal header size: len + id + tag */
+#define P9_HDRSZ	7
+
 /* ample room for Twrite/Rread header */
 #define P9_IOHDRSZ	24
 
@@ -558,6 +561,7 @@ struct p9_fcall {
 	size_t offset;
 	size_t capacity;
 
+	struct kmem_cache *cache;
 	u8 *sdata;
 };
 
diff --git a/include/net/9p/client.h b/include/net/9p/client.h
index c2671d40bb6b..735f3979d559 100644
--- a/include/net/9p/client.h
+++ b/include/net/9p/client.h
@@ -123,6 +123,7 @@ struct p9_client {
 	struct p9_trans_module *trans_mod;
 	enum p9_trans_status status;
 	void *trans;
+	struct kmem_cache *fcall_cache;
 
 	union {
 		struct {
diff --git a/net/9p/client.c b/net/9p/client.c
index ed78751aee7c..6c57ab1294d7 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -192,6 +192,9 @@ static int parse_opts(char *opts, struct p9_client *clnt)
 				goto free_and_return;
 			}
 
+			if (clnt->trans_mod) {
+				pr_warn("Had trans %s\n", clnt->trans_mod->name);
+			}
 			v9fs_put_trans(clnt->trans_mod);
 			clnt->trans_mod = v9fs_get_trans_by_name(s);
 			if (clnt->trans_mod == NULL) {
@@ -231,9 +234,16 @@ static int parse_opts(char *opts, struct p9_client *clnt)
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
@@ -242,7 +252,16 @@ static int p9_fcall_init(struct p9_fcall *fc, int alloc_msize)
 
 void p9_fcall_fini(struct p9_fcall *fc)
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
 EXPORT_SYMBOL(p9_fcall_fini);
 
@@ -267,9 +286,9 @@ p9_tag_alloc(struct p9_client *c, int8_t type, unsigned int max_size)
 	if (!req)
 		return NULL;
 
-	if (p9_fcall_init(&req->tc, alloc_msize))
+	if (p9_fcall_init(c, &req->tc, alloc_msize))
 		goto free_req;
-	if (p9_fcall_init(&req->rc, alloc_msize))
+	if (p9_fcall_init(c, &req->rc, alloc_msize))
 		goto free;
 
 	p9pdu_reset(&req->tc);
@@ -951,6 +970,7 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
 
 	clnt->trans_mod = NULL;
 	clnt->trans = NULL;
+	clnt->fcall_cache = NULL;
 
 	client_id = utsname()->nodename;
 	memcpy(clnt->name, client_id, strlen(client_id) + 1);
@@ -987,6 +1007,15 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
 	if (err)
 		goto close_trans;
 
+	/* P9_HDRSZ + 4 is the smallest packet header we can have that is
+	 * followed by data accessed from userspace by read
+	 */
+	clnt->fcall_cache =
+		kmem_cache_create_usercopy("9p-fcall-cache", clnt->msize,
+					   0, 0, P9_HDRSZ + 4,
+					   clnt->msize - (P9_HDRSZ + 4),
+					   NULL);
+
 	return clnt;
 
 close_trans:
@@ -1018,6 +1047,7 @@ void p9_client_destroy(struct p9_client *clnt)
 
 	p9_tag_cleanup(clnt);
 
+	kmem_cache_destroy(clnt->fcall_cache);
 	kfree(clnt);
 }
 EXPORT_SYMBOL(p9_client_destroy);
-- 
2.17.1


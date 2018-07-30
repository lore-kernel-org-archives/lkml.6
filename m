Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C085F13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D98320881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D98320881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbeG3LIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 07:08:42 -0400
Received: from nautica.notk.org ([91.121.71.147]:55812 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbeG3LIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 07:08:41 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 25BD9C009; Mon, 30 Jul 2018 11:34:31 +0200 (CEST)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     v9fs-developer@lists.sourceforge.net
Cc:     Greg Kurz <groug@kaod.org>, Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] net/9p: embed fcall in req to round down buffer allocs
Date:   Mon, 30 Jul 2018 11:34:22 +0200
Message-Id: <1532943263-24378-1-git-send-email-asmadeus@codewreck.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <20180730093101.GA7894@nautica>
References: <20180730093101.GA7894@nautica>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dominique Martinet <dominique.martinet@cea.fr>

'msize' is often a power of two, or at least page-aligned, so avoiding
an overhead of two dozen bytes for each allocation will help the
allocator do its work and reduce memory fragmentation.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
---
 include/net/9p/client.h |   4 +-
 net/9p/client.c         | 160 ++++++++++++++++++++--------------------
 net/9p/trans_fd.c       |  12 +--
 net/9p/trans_rdma.c     |  29 ++++----
 net/9p/trans_virtio.c   |  18 ++---
 net/9p/trans_xen.c      |  12 +--
 6 files changed, 117 insertions(+), 118 deletions(-)

diff --git a/include/net/9p/client.h b/include/net/9p/client.h
index a4dc42c53d18..4b4ac1362ad5 100644
--- a/include/net/9p/client.h
+++ b/include/net/9p/client.h
@@ -95,8 +95,8 @@ struct p9_req_t {
 	int status;
 	int t_err;
 	wait_queue_head_t wq;
-	struct p9_fcall *tc;
-	struct p9_fcall *rc;
+	struct p9_fcall tc;
+	struct p9_fcall rc;
 	void *aux;
 	struct list_head req_list;
 };
diff --git a/net/9p/client.c b/net/9p/client.c
index 88db45966740..ba99a94a12c9 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -231,15 +231,13 @@ static int parse_opts(char *opts, struct p9_client *clnt)
 	return ret;
 }
 
-static struct p9_fcall *p9_fcall_alloc(int alloc_msize)
+static int p9_fcall_alloc(struct p9_fcall *fc, int alloc_msize)
 {
-	struct p9_fcall *fc;
-	fc = kmalloc(sizeof(struct p9_fcall) + alloc_msize, GFP_NOFS);
-	if (!fc)
-		return NULL;
+	fc->sdata = kmalloc(alloc_msize, GFP_NOFS);
+	if (!fc->sdata)
+		return -ENOMEM;
 	fc->capacity = alloc_msize;
-	fc->sdata = (char *) fc + sizeof(struct p9_fcall);
-	return fc;
+	return 0;
 }
 
 static struct kmem_cache *p9_req_cache;
@@ -263,13 +261,13 @@ p9_tag_alloc(struct p9_client *c, int8_t type, unsigned int max_size)
 	if (!req)
 		return NULL;
 
-	req->tc = p9_fcall_alloc(alloc_msize);
-	req->rc = p9_fcall_alloc(alloc_msize);
-	if (!req->tc || !req->rc)
+	if (p9_fcall_alloc(&req->tc, alloc_msize))
+		goto free;
+	if (p9_fcall_alloc(&req->rc, alloc_msize))
 		goto free;
 
-	p9pdu_reset(req->tc);
-	p9pdu_reset(req->rc);
+	p9pdu_reset(&req->tc);
+	p9pdu_reset(&req->rc);
 	req->status = REQ_STATUS_ALLOC;
 	init_waitqueue_head(&req->wq);
 	INIT_LIST_HEAD(&req->req_list);
@@ -281,7 +279,7 @@ p9_tag_alloc(struct p9_client *c, int8_t type, unsigned int max_size)
 				GFP_NOWAIT);
 	else
 		tag = idr_alloc(&c->reqs, req, 0, P9_NOTAG, GFP_NOWAIT);
-	req->tc->tag = tag;
+	req->tc.tag = tag;
 	spin_unlock_irq(&c->lock);
 	idr_preload_end();
 	if (tag < 0)
@@ -290,8 +288,8 @@ p9_tag_alloc(struct p9_client *c, int8_t type, unsigned int max_size)
 	return req;
 
 free:
-	kfree(req->tc);
-	kfree(req->rc);
+	kfree(req->tc.sdata);
+	kfree(req->rc.sdata);
 	kmem_cache_free(p9_req_cache, req);
 	return ERR_PTR(-ENOMEM);
 }
@@ -329,14 +327,14 @@ EXPORT_SYMBOL(p9_tag_lookup);
 static void p9_free_req(struct p9_client *c, struct p9_req_t *r)
 {
 	unsigned long flags;
-	u16 tag = r->tc->tag;
+	u16 tag = r->tc.tag;
 
 	p9_debug(P9_DEBUG_MUX, "clnt %p req %p tag: %d\n", c, r, tag);
 	spin_lock_irqsave(&c->lock, flags);
 	idr_remove(&c->reqs, tag);
 	spin_unlock_irqrestore(&c->lock, flags);
-	kfree(r->tc);
-	kfree(r->rc);
+	kfree(r->tc.sdata);
+	kfree(r->rc.sdata);
 	kmem_cache_free(p9_req_cache, r);
 }
 
@@ -368,7 +366,7 @@ static void p9_tag_cleanup(struct p9_client *c)
  */
 void p9_client_cb(struct p9_client *c, struct p9_req_t *req, int status)
 {
-	p9_debug(P9_DEBUG_MUX, " tag %d\n", req->tc->tag);
+	p9_debug(P9_DEBUG_MUX, " tag %d\n", req->tc.tag);
 
 	/*
 	 * This barrier is needed to make sure any change made to req before
@@ -378,7 +376,7 @@ void p9_client_cb(struct p9_client *c, struct p9_req_t *req, int status)
 	req->status = status;
 
 	wake_up(&req->wq);
-	p9_debug(P9_DEBUG_MUX, "wakeup: %d\n", req->tc->tag);
+	p9_debug(P9_DEBUG_MUX, "wakeup: %d\n", req->tc.tag);
 }
 EXPORT_SYMBOL(p9_client_cb);
 
@@ -449,18 +447,18 @@ static int p9_check_errors(struct p9_client *c, struct p9_req_t *req)
 	int err;
 	int ecode;
 
-	err = p9_parse_header(req->rc, NULL, &type, NULL, 0);
-	if (req->rc->size >= c->msize) {
+	err = p9_parse_header(&req->rc, NULL, &type, NULL, 0);
+	if (req->rc.size >= c->msize) {
 		p9_debug(P9_DEBUG_ERROR,
 			 "requested packet size too big: %d\n",
-			 req->rc->size);
+			 req->rc.size);
 		return -EIO;
 	}
 	/*
 	 * dump the response from server
 	 * This should be after check errors which poplulate pdu_fcall.
 	 */
-	trace_9p_protocol_dump(c, req->rc);
+	trace_9p_protocol_dump(c, &req->rc);
 	if (err) {
 		p9_debug(P9_DEBUG_ERROR, "couldn't parse header %d\n", err);
 		return err;
@@ -470,7 +468,7 @@ static int p9_check_errors(struct p9_client *c, struct p9_req_t *req)
 
 	if (!p9_is_proto_dotl(c)) {
 		char *ename;
-		err = p9pdu_readf(req->rc, c->proto_version, "s?d",
+		err = p9pdu_readf(&req->rc, c->proto_version, "s?d",
 				  &ename, &ecode);
 		if (err)
 			goto out_err;
@@ -486,7 +484,7 @@ static int p9_check_errors(struct p9_client *c, struct p9_req_t *req)
 		}
 		kfree(ename);
 	} else {
-		err = p9pdu_readf(req->rc, c->proto_version, "d", &ecode);
+		err = p9pdu_readf(&req->rc, c->proto_version, "d", &ecode);
 		err = -ecode;
 
 		p9_debug(P9_DEBUG_9P, "<<< RLERROR (%d)\n", -ecode);
@@ -520,12 +518,12 @@ static int p9_check_zc_errors(struct p9_client *c, struct p9_req_t *req,
 	int8_t type;
 	char *ename = NULL;
 
-	err = p9_parse_header(req->rc, NULL, &type, NULL, 0);
+	err = p9_parse_header(&req->rc, NULL, &type, NULL, 0);
 	/*
 	 * dump the response from server
 	 * This should be after parse_header which poplulate pdu_fcall.
 	 */
-	trace_9p_protocol_dump(c, req->rc);
+	trace_9p_protocol_dump(c, &req->rc);
 	if (err) {
 		p9_debug(P9_DEBUG_ERROR, "couldn't parse header %d\n", err);
 		return err;
@@ -540,13 +538,13 @@ static int p9_check_zc_errors(struct p9_client *c, struct p9_req_t *req,
 		/* 7 = header size for RERROR; */
 		int inline_len = in_hdrlen - 7;
 
-		len =  req->rc->size - req->rc->offset;
+		len = req->rc.size - req->rc.offset;
 		if (len > (P9_ZC_HDR_SZ - 7)) {
 			err = -EFAULT;
 			goto out_err;
 		}
 
-		ename = &req->rc->sdata[req->rc->offset];
+		ename = &req->rc.sdata[req->rc.offset];
 		if (len > inline_len) {
 			/* We have error in external buffer */
 			if (!copy_from_iter_full(ename + inline_len,
@@ -556,7 +554,7 @@ static int p9_check_zc_errors(struct p9_client *c, struct p9_req_t *req,
 			}
 		}
 		ename = NULL;
-		err = p9pdu_readf(req->rc, c->proto_version, "s?d",
+		err = p9pdu_readf(&req->rc, c->proto_version, "s?d",
 				  &ename, &ecode);
 		if (err)
 			goto out_err;
@@ -572,7 +570,7 @@ static int p9_check_zc_errors(struct p9_client *c, struct p9_req_t *req,
 		}
 		kfree(ename);
 	} else {
-		err = p9pdu_readf(req->rc, c->proto_version, "d", &ecode);
+		err = p9pdu_readf(&req->rc, c->proto_version, "d", &ecode);
 		err = -ecode;
 
 		p9_debug(P9_DEBUG_9P, "<<< RLERROR (%d)\n", -ecode);
@@ -605,7 +603,7 @@ static int p9_client_flush(struct p9_client *c, struct p9_req_t *oldreq)
 	int16_t oldtag;
 	int err;
 
-	err = p9_parse_header(oldreq->tc, NULL, NULL, &oldtag, 1);
+	err = p9_parse_header(&oldreq->tc, NULL, NULL, &oldtag, 1);
 	if (err)
 		return err;
 
@@ -649,12 +647,12 @@ static struct p9_req_t *p9_client_prepare_req(struct p9_client *c,
 		return req;
 
 	/* marshall the data */
-	p9pdu_prepare(req->tc, req->tc->tag, type);
-	err = p9pdu_vwritef(req->tc, c->proto_version, fmt, ap);
+	p9pdu_prepare(&req->tc, req->tc.tag, type);
+	err = p9pdu_vwritef(&req->tc, c->proto_version, fmt, ap);
 	if (err)
 		goto reterr;
-	p9pdu_finalize(c, req->tc);
-	trace_9p_client_req(c, type, req->tc->tag);
+	p9pdu_finalize(c, &req->tc);
+	trace_9p_client_req(c, type, req->tc.tag);
 	return req;
 reterr:
 	p9_free_req(c, req);
@@ -739,7 +737,7 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
 		goto reterr;
 
 	err = p9_check_errors(c, req);
-	trace_9p_client_res(c, type, req->rc->tag, err);
+	trace_9p_client_res(c, type, req->rc.tag, err);
 	if (!err)
 		return req;
 reterr:
@@ -821,7 +819,7 @@ static struct p9_req_t *p9_client_zc_rpc(struct p9_client *c, int8_t type,
 		goto reterr;
 
 	err = p9_check_zc_errors(c, req, uidata, in_hdrlen);
-	trace_9p_client_res(c, type, req->rc->tag, err);
+	trace_9p_client_res(c, type, req->rc.tag, err);
 	if (!err)
 		return req;
 reterr:
@@ -904,10 +902,10 @@ static int p9_client_version(struct p9_client *c)
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	err = p9pdu_readf(req->rc, c->proto_version, "ds", &msize, &version);
+	err = p9pdu_readf(&req->rc, c->proto_version, "ds", &msize, &version);
 	if (err) {
 		p9_debug(P9_DEBUG_9P, "version error %d\n", err);
-		trace_9p_protocol_dump(c, req->rc);
+		trace_9p_protocol_dump(c, &req->rc);
 		goto error;
 	}
 
@@ -1056,9 +1054,9 @@ struct p9_fid *p9_client_attach(struct p9_client *clnt, struct p9_fid *afid,
 		goto error;
 	}
 
-	err = p9pdu_readf(req->rc, clnt->proto_version, "Q", &qid);
+	err = p9pdu_readf(&req->rc, clnt->proto_version, "Q", &qid);
 	if (err) {
-		trace_9p_protocol_dump(clnt, req->rc);
+		trace_9p_protocol_dump(clnt, &req->rc);
 		p9_free_req(clnt, req);
 		goto error;
 	}
@@ -1113,9 +1111,9 @@ struct p9_fid *p9_client_walk(struct p9_fid *oldfid, uint16_t nwname,
 		goto error;
 	}
 
-	err = p9pdu_readf(req->rc, clnt->proto_version, "R", &nwqids, &wqids);
+	err = p9pdu_readf(&req->rc, clnt->proto_version, "R", &nwqids, &wqids);
 	if (err) {
-		trace_9p_protocol_dump(clnt, req->rc);
+		trace_9p_protocol_dump(clnt, &req->rc);
 		p9_free_req(clnt, req);
 		goto clunk_fid;
 	}
@@ -1180,9 +1178,9 @@ int p9_client_open(struct p9_fid *fid, int mode)
 		goto error;
 	}
 
-	err = p9pdu_readf(req->rc, clnt->proto_version, "Qd", &qid, &iounit);
+	err = p9pdu_readf(&req->rc, clnt->proto_version, "Qd", &qid, &iounit);
 	if (err) {
-		trace_9p_protocol_dump(clnt, req->rc);
+		trace_9p_protocol_dump(clnt, &req->rc);
 		goto free_and_error;
 	}
 
@@ -1224,9 +1222,9 @@ int p9_client_create_dotl(struct p9_fid *ofid, const char *name, u32 flags, u32
 		goto error;
 	}
 
-	err = p9pdu_readf(req->rc, clnt->proto_version, "Qd", qid, &iounit);
+	err = p9pdu_readf(&req->rc, clnt->proto_version, "Qd", qid, &iounit);
 	if (err) {
-		trace_9p_protocol_dump(clnt, req->rc);
+		trace_9p_protocol_dump(clnt, &req->rc);
 		goto free_and_error;
 	}
 
@@ -1269,9 +1267,9 @@ int p9_client_fcreate(struct p9_fid *fid, const char *name, u32 perm, int mode,
 		goto error;
 	}
 
-	err = p9pdu_readf(req->rc, clnt->proto_version, "Qd", &qid, &iounit);
+	err = p9pdu_readf(&req->rc, clnt->proto_version, "Qd", &qid, &iounit);
 	if (err) {
-		trace_9p_protocol_dump(clnt, req->rc);
+		trace_9p_protocol_dump(clnt, &req->rc);
 		goto free_and_error;
 	}
 
@@ -1308,9 +1306,9 @@ int p9_client_symlink(struct p9_fid *dfid, const char *name,
 		goto error;
 	}
 
-	err = p9pdu_readf(req->rc, clnt->proto_version, "Q", qid);
+	err = p9pdu_readf(&req->rc, clnt->proto_version, "Q", qid);
 	if (err) {
-		trace_9p_protocol_dump(clnt, req->rc);
+		trace_9p_protocol_dump(clnt, &req->rc);
 		goto free_and_error;
 	}
 
@@ -1506,10 +1504,10 @@ p9_client_read(struct p9_fid *fid, u64 offset, struct iov_iter *to, int *err)
 			break;
 		}
 
-		*err = p9pdu_readf(req->rc, clnt->proto_version,
+		*err = p9pdu_readf(&req->rc, clnt->proto_version,
 				   "D", &count, &dataptr);
 		if (*err) {
-			trace_9p_protocol_dump(clnt, req->rc);
+			trace_9p_protocol_dump(clnt, &req->rc);
 			p9_free_req(clnt, req);
 			break;
 		}
@@ -1579,9 +1577,9 @@ p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err)
 			break;
 		}
 
-		*err = p9pdu_readf(req->rc, clnt->proto_version, "d", &count);
+		*err = p9pdu_readf(&req->rc, clnt->proto_version, "d", &count);
 		if (*err) {
-			trace_9p_protocol_dump(clnt, req->rc);
+			trace_9p_protocol_dump(clnt, &req->rc);
 			p9_free_req(clnt, req);
 			break;
 		}
@@ -1623,9 +1621,9 @@ struct p9_wstat *p9_client_stat(struct p9_fid *fid)
 		goto error;
 	}
 
-	err = p9pdu_readf(req->rc, clnt->proto_version, "wS", &ignored, ret);
+	err = p9pdu_readf(&req->rc, clnt->proto_version, "wS", &ignored, ret);
 	if (err) {
-		trace_9p_protocol_dump(clnt, req->rc);
+		trace_9p_protocol_dump(clnt, &req->rc);
 		p9_free_req(clnt, req);
 		goto error;
 	}
@@ -1676,9 +1674,9 @@ struct p9_stat_dotl *p9_client_getattr_dotl(struct p9_fid *fid,
 		goto error;
 	}
 
-	err = p9pdu_readf(req->rc, clnt->proto_version, "A", ret);
+	err = p9pdu_readf(&req->rc, clnt->proto_version, "A", ret);
 	if (err) {
-		trace_9p_protocol_dump(clnt, req->rc);
+		trace_9p_protocol_dump(clnt, &req->rc);
 		p9_free_req(clnt, req);
 		goto error;
 	}
@@ -1828,11 +1826,11 @@ int p9_client_statfs(struct p9_fid *fid, struct p9_rstatfs *sb)
 		goto error;
 	}
 
-	err = p9pdu_readf(req->rc, clnt->proto_version, "ddqqqqqqd", &sb->type,
-		&sb->bsize, &sb->blocks, &sb->bfree, &sb->bavail,
-		&sb->files, &sb->ffree, &sb->fsid, &sb->namelen);
+	err = p9pdu_readf(&req->rc, clnt->proto_version, "ddqqqqqqd", &sb->type,
+			  &sb->bsize, &sb->blocks, &sb->bfree, &sb->bavail,
+			  &sb->files, &sb->ffree, &sb->fsid, &sb->namelen);
 	if (err) {
-		trace_9p_protocol_dump(clnt, req->rc);
+		trace_9p_protocol_dump(clnt, &req->rc);
 		p9_free_req(clnt, req);
 		goto error;
 	}
@@ -1936,9 +1934,9 @@ struct p9_fid *p9_client_xattrwalk(struct p9_fid *file_fid,
 		err = PTR_ERR(req);
 		goto error;
 	}
-	err = p9pdu_readf(req->rc, clnt->proto_version, "q", attr_size);
+	err = p9pdu_readf(&req->rc, clnt->proto_version, "q", attr_size);
 	if (err) {
-		trace_9p_protocol_dump(clnt, req->rc);
+		trace_9p_protocol_dump(clnt, &req->rc);
 		p9_free_req(clnt, req);
 		goto clunk_fid;
 	}
@@ -2024,9 +2022,9 @@ int p9_client_readdir(struct p9_fid *fid, char *data, u32 count, u64 offset)
 		goto error;
 	}
 
-	err = p9pdu_readf(req->rc, clnt->proto_version, "D", &count, &dataptr);
+	err = p9pdu_readf(&req->rc, clnt->proto_version, "D", &count, &dataptr);
 	if (err) {
-		trace_9p_protocol_dump(clnt, req->rc);
+		trace_9p_protocol_dump(clnt, &req->rc);
 		goto free_and_error;
 	}
 	if (rsize < count) {
@@ -2065,9 +2063,9 @@ int p9_client_mknod_dotl(struct p9_fid *fid, const char *name, int mode,
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	err = p9pdu_readf(req->rc, clnt->proto_version, "Q", qid);
+	err = p9pdu_readf(&req->rc, clnt->proto_version, "Q", qid);
 	if (err) {
-		trace_9p_protocol_dump(clnt, req->rc);
+		trace_9p_protocol_dump(clnt, &req->rc);
 		goto error;
 	}
 	p9_debug(P9_DEBUG_9P, "<<< RMKNOD qid %x.%llx.%x\n", qid->type,
@@ -2096,9 +2094,9 @@ int p9_client_mkdir_dotl(struct p9_fid *fid, const char *name, int mode,
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	err = p9pdu_readf(req->rc, clnt->proto_version, "Q", qid);
+	err = p9pdu_readf(&req->rc, clnt->proto_version, "Q", qid);
 	if (err) {
-		trace_9p_protocol_dump(clnt, req->rc);
+		trace_9p_protocol_dump(clnt, &req->rc);
 		goto error;
 	}
 	p9_debug(P9_DEBUG_9P, "<<< RMKDIR qid %x.%llx.%x\n", qid->type,
@@ -2131,9 +2129,9 @@ int p9_client_lock_dotl(struct p9_fid *fid, struct p9_flock *flock, u8 *status)
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	err = p9pdu_readf(req->rc, clnt->proto_version, "b", status);
+	err = p9pdu_readf(&req->rc, clnt->proto_version, "b", status);
 	if (err) {
-		trace_9p_protocol_dump(clnt, req->rc);
+		trace_9p_protocol_dump(clnt, &req->rc);
 		goto error;
 	}
 	p9_debug(P9_DEBUG_9P, "<<< RLOCK status %i\n", *status);
@@ -2162,11 +2160,11 @@ int p9_client_getlock_dotl(struct p9_fid *fid, struct p9_getlock *glock)
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	err = p9pdu_readf(req->rc, clnt->proto_version, "bqqds", &glock->type,
-			&glock->start, &glock->length, &glock->proc_id,
-			&glock->client_id);
+	err = p9pdu_readf(&req->rc, clnt->proto_version, "bqqds", &glock->type,
+			  &glock->start, &glock->length, &glock->proc_id,
+			  &glock->client_id);
 	if (err) {
-		trace_9p_protocol_dump(clnt, req->rc);
+		trace_9p_protocol_dump(clnt, &req->rc);
 		goto error;
 	}
 	p9_debug(P9_DEBUG_9P, "<<< RGETLOCK type %i start %lld length %lld "
@@ -2192,9 +2190,9 @@ int p9_client_readlink(struct p9_fid *fid, char **target)
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	err = p9pdu_readf(req->rc, clnt->proto_version, "s", target);
+	err = p9pdu_readf(&req->rc, clnt->proto_version, "s", target);
 	if (err) {
-		trace_9p_protocol_dump(clnt, req->rc);
+		trace_9p_protocol_dump(clnt, &req->rc);
 		goto error;
 	}
 	p9_debug(P9_DEBUG_9P, "<<< RREADLINK target %s\n", *target);
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index e2ef3c782c53..20f46f13fe83 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -354,7 +354,7 @@ static void p9_read_work(struct work_struct *work)
 			goto error;
 		}
 
-		if (m->req->rc == NULL) {
+		if (m->req->rc.sdata == NULL) {
 			p9_debug(P9_DEBUG_ERROR,
 				 "No recv fcall for tag %d (req %p), disconnecting!\n",
 				 m->rc.tag, m->req);
@@ -362,7 +362,7 @@ static void p9_read_work(struct work_struct *work)
 			err = -EIO;
 			goto error;
 		}
-		m->rc.sdata = (char *)m->req->rc + sizeof(struct p9_fcall);
+		m->rc.sdata = m->req->rc.sdata;
 		memcpy(m->rc.sdata, m->tmp_buf, m->rc.capacity);
 		m->rc.capacity = m->rc.size;
 	}
@@ -372,7 +372,7 @@ static void p9_read_work(struct work_struct *work)
 	 */
 	if ((m->req) && (m->rc.offset == m->rc.capacity)) {
 		p9_debug(P9_DEBUG_TRANS, "got new packet\n");
-		m->req->rc->size = m->rc.offset;
+		m->req->rc.size = m->rc.offset;
 		spin_lock(&m->client->lock);
 		if (m->req->status != REQ_STATUS_ERROR)
 			status = REQ_STATUS_RCVD;
@@ -469,8 +469,8 @@ static void p9_write_work(struct work_struct *work)
 		p9_debug(P9_DEBUG_TRANS, "move req %p\n", req);
 		list_move_tail(&req->req_list, &m->req_list);
 
-		m->wbuf = req->tc->sdata;
-		m->wsize = req->tc->size;
+		m->wbuf = req->tc.sdata;
+		m->wsize = req->tc.size;
 		m->wpos = 0;
 		spin_unlock(&m->client->lock);
 	}
@@ -663,7 +663,7 @@ static int p9_fd_request(struct p9_client *client, struct p9_req_t *req)
 	struct p9_conn *m = &ts->conn;
 
 	p9_debug(P9_DEBUG_TRANS, "mux %p task %p tcall %p id %d\n",
-		 m, current, req->tc, req->tc->id);
+		 m, current, &req->tc, req->tc.id);
 	if (m->err < 0)
 		return m->err;
 
diff --git a/net/9p/trans_rdma.c b/net/9p/trans_rdma.c
index 2ab4574183c9..c5cac97df7f7 100644
--- a/net/9p/trans_rdma.c
+++ b/net/9p/trans_rdma.c
@@ -122,7 +122,7 @@ struct p9_rdma_context {
 	dma_addr_t busa;
 	union {
 		struct p9_req_t *req;
-		struct p9_fcall *rc;
+		struct p9_fcall rc;
 	};
 };
 
@@ -320,8 +320,8 @@ recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	if (wc->status != IB_WC_SUCCESS)
 		goto err_out;
 
-	c->rc->size = wc->byte_len;
-	err = p9_parse_header(c->rc, NULL, NULL, &tag, 1);
+	c->rc.size = wc->byte_len;
+	err = p9_parse_header(&c->rc, NULL, NULL, &tag, 1);
 	if (err)
 		goto err_out;
 
@@ -331,12 +331,13 @@ recv_done(struct ib_cq *cq, struct ib_wc *wc)
 
 	/* Check that we have not yet received a reply for this request.
 	 */
-	if (unlikely(req->rc)) {
+	if (unlikely(req->rc.sdata)) {
 		pr_err("Duplicate reply for request %d", tag);
 		goto err_out;
 	}
 
-	req->rc = c->rc;
+	req->rc.size = c->rc.size;
+	req->rc.sdata = c->rc.sdata;
 	p9_client_cb(client, req, REQ_STATUS_RCVD);
 
  out:
@@ -361,7 +362,7 @@ send_done(struct ib_cq *cq, struct ib_wc *wc)
 		container_of(wc->wr_cqe, struct p9_rdma_context, cqe);
 
 	ib_dma_unmap_single(rdma->cm_id->device,
-			    c->busa, c->req->tc->size,
+			    c->busa, c->req->tc.size,
 			    DMA_TO_DEVICE);
 	up(&rdma->sq_sem);
 	kfree(c);
@@ -401,7 +402,7 @@ post_recv(struct p9_client *client, struct p9_rdma_context *c)
 	struct ib_sge sge;
 
 	c->busa = ib_dma_map_single(rdma->cm_id->device,
-				    c->rc->sdata, client->msize,
+				    c->rc.sdata, client->msize,
 				    DMA_FROM_DEVICE);
 	if (ib_dma_mapping_error(rdma->cm_id->device, c->busa))
 		goto error;
@@ -443,9 +444,9 @@ static int rdma_request(struct p9_client *client, struct p9_req_t *req)
 	 **/
 	if (unlikely(atomic_read(&rdma->excess_rc) > 0)) {
 		if ((atomic_sub_return(1, &rdma->excess_rc) >= 0)) {
-			/* Got one ! */
-			kfree(req->rc);
-			req->rc = NULL;
+			/* Got one! */
+			kfree(req->rc.sdata);
+			req->rc.sdata = NULL;
 			goto dont_need_post_recv;
 		} else {
 			/* We raced and lost. */
@@ -459,7 +460,7 @@ static int rdma_request(struct p9_client *client, struct p9_req_t *req)
 		err = -ENOMEM;
 		goto recv_error;
 	}
-	rpl_context->rc = req->rc;
+	rpl_context->rc.sdata = req->rc.sdata;
 
 	/*
 	 * Post a receive buffer for this request. We need to ensure
@@ -479,7 +480,7 @@ static int rdma_request(struct p9_client *client, struct p9_req_t *req)
 		goto recv_error;
 	}
 	/* remove posted receive buffer from request structure */
-	req->rc = NULL;
+	req->rc.sdata = NULL;
 
 dont_need_post_recv:
 	/* Post the request */
@@ -491,7 +492,7 @@ static int rdma_request(struct p9_client *client, struct p9_req_t *req)
 	c->req = req;
 
 	c->busa = ib_dma_map_single(rdma->cm_id->device,
-				    c->req->tc->sdata, c->req->tc->size,
+				    c->req->tc.sdata, c->req->tc.size,
 				    DMA_TO_DEVICE);
 	if (ib_dma_mapping_error(rdma->cm_id->device, c->busa)) {
 		err = -EIO;
@@ -501,7 +502,7 @@ static int rdma_request(struct p9_client *client, struct p9_req_t *req)
 	c->cqe.done = send_done;
 
 	sge.addr = c->busa;
-	sge.length = c->req->tc->size;
+	sge.length = c->req->tc.size;
 	sge.lkey = rdma->pd->local_dma_lkey;
 
 	wr.next = NULL;
diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 6265d1d62749..80dd34d8a6af 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -157,7 +157,7 @@ static void req_done(struct virtqueue *vq)
 		}
 
 		if (len) {
-			req->rc->size = len;
+			req->rc.size = len;
 			p9_client_cb(chan->client, req, REQ_STATUS_RCVD);
 		}
 	}
@@ -274,12 +274,12 @@ p9_virtio_request(struct p9_client *client, struct p9_req_t *req)
 	out_sgs = in_sgs = 0;
 	/* Handle out VirtIO ring buffers */
 	out = pack_sg_list(chan->sg, 0,
-			   VIRTQUEUE_NUM, req->tc->sdata, req->tc->size);
+			   VIRTQUEUE_NUM, req->tc.sdata, req->tc.size);
 	if (out)
 		sgs[out_sgs++] = chan->sg;
 
 	in = pack_sg_list(chan->sg, out,
-			  VIRTQUEUE_NUM, req->rc->sdata, req->rc->capacity);
+			  VIRTQUEUE_NUM, req->rc.sdata, req->rc.capacity);
 	if (in)
 		sgs[out_sgs + in_sgs++] = chan->sg + out;
 
@@ -417,15 +417,15 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 		out_nr_pages = DIV_ROUND_UP(n + offs, PAGE_SIZE);
 		if (n != outlen) {
 			__le32 v = cpu_to_le32(n);
-			memcpy(&req->tc->sdata[req->tc->size - 4], &v, 4);
+			memcpy(&req->tc.sdata[req->tc.size - 4], &v, 4);
 			outlen = n;
 		}
 		/* The size field of the message must include the length of the
 		 * header and the length of the data.  We didn't actually know
 		 * the length of the data until this point so add it in now.
 		 */
-		sz = cpu_to_le32(req->tc->size + outlen);
-		memcpy(&req->tc->sdata[0], &sz, sizeof(sz));
+		sz = cpu_to_le32(req->tc.size + outlen);
+		memcpy(&req->tc.sdata[0], &sz, sizeof(sz));
 	} else if (uidata) {
 		int n = p9_get_mapped_pages(chan, &in_pages, uidata,
 					    inlen, &offs, &need_drop);
@@ -434,7 +434,7 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 		in_nr_pages = DIV_ROUND_UP(n + offs, PAGE_SIZE);
 		if (n != inlen) {
 			__le32 v = cpu_to_le32(n);
-			memcpy(&req->tc->sdata[req->tc->size - 4], &v, 4);
+			memcpy(&req->tc.sdata[req->tc.size - 4], &v, 4);
 			inlen = n;
 		}
 	}
@@ -446,7 +446,7 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 
 	/* out data */
 	out = pack_sg_list(chan->sg, 0,
-			   VIRTQUEUE_NUM, req->tc->sdata, req->tc->size);
+			   VIRTQUEUE_NUM, req->tc.sdata, req->tc.size);
 
 	if (out)
 		sgs[out_sgs++] = chan->sg;
@@ -465,7 +465,7 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 	 * alloced memory and payload onto the user buffer.
 	 */
 	in = pack_sg_list(chan->sg, out,
-			  VIRTQUEUE_NUM, req->rc->sdata, in_hdr_len);
+			  VIRTQUEUE_NUM, req->rc.sdata, in_hdr_len);
 	if (in)
 		sgs[out_sgs + in_sgs++] = chan->sg + out;
 
diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
index c2d54ac76bfd..1a5b38892eb4 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -141,7 +141,7 @@ static int p9_xen_request(struct p9_client *client, struct p9_req_t *p9_req)
 	struct xen_9pfs_front_priv *priv = NULL;
 	RING_IDX cons, prod, masked_cons, masked_prod;
 	unsigned long flags;
-	u32 size = p9_req->tc->size;
+	u32 size = p9_req->tc.size;
 	struct xen_9pfs_dataring *ring;
 	int num;
 
@@ -154,7 +154,7 @@ static int p9_xen_request(struct p9_client *client, struct p9_req_t *p9_req)
 	if (!priv || priv->client != client)
 		return -EINVAL;
 
-	num = p9_req->tc->tag % priv->num_rings;
+	num = p9_req->tc.tag % priv->num_rings;
 	ring = &priv->rings[num];
 
 again:
@@ -176,7 +176,7 @@ static int p9_xen_request(struct p9_client *client, struct p9_req_t *p9_req)
 	masked_prod = xen_9pfs_mask(prod, XEN_9PFS_RING_SIZE);
 	masked_cons = xen_9pfs_mask(cons, XEN_9PFS_RING_SIZE);
 
-	xen_9pfs_write_packet(ring->data.out, p9_req->tc->sdata, size,
+	xen_9pfs_write_packet(ring->data.out, p9_req->tc.sdata, size,
 			      &masked_prod, masked_cons, XEN_9PFS_RING_SIZE);
 
 	p9_req->status = REQ_STATUS_SENT;
@@ -229,12 +229,12 @@ static void p9_xen_response(struct work_struct *work)
 			continue;
 		}
 
-		memcpy(req->rc, &h, sizeof(h));
-		req->rc->offset = 0;
+		memcpy(&req->rc, &h, sizeof(h));
+		req->rc.offset = 0;
 
 		masked_cons = xen_9pfs_mask(cons, XEN_9PFS_RING_SIZE);
 		/* Then, read the whole packet (including the header) */
-		xen_9pfs_read_packet(req->rc->sdata, ring->data.in, h.size,
+		xen_9pfs_read_packet(req->rc.sdata, ring->data.in, h.size,
 				     masked_prod, &masked_cons,
 				     XEN_9PFS_RING_SIZE);
 
-- 
2.17.1


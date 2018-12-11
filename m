Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB5DC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24A82084C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:42:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A24A82084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbeLKMmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 07:42:19 -0500
Received: from nautica.notk.org ([91.121.71.147]:49675 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbeLKMmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 07:42:16 -0500
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 54B71C01E; Tue, 11 Dec 2018 13:42:13 +0100 (CET)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     v9fs-developer@lists.sourceforge.net
Cc:     Dominique Martinet <dominique.martinet@cea.fr>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Tomas Bortoli <tomasbortoli@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH 2/3] 9p/net: make clunk asynchronous
Date:   Tue, 11 Dec 2018 13:41:47 +0100
Message-Id: <1544532108-21689-2-git-send-email-asmadeus@codewreck.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1544532108-21689-1-git-send-email-asmadeus@codewreck.org>
References: <1544532108-21689-1-git-send-email-asmadeus@codewreck.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dominique Martinet <dominique.martinet@cea.fr>

clunk is defined as making the fid invalid whatever the server returns,
and we should ignore errors so it is a good candidate for async call.

The change should make 9p slightly faster (many vfs systeme calls won't
need to wait for that clunk), but more importantly the flush rework
means we won't clear pending signals and the current implementation of
"retry twice then leak the fid" will stop working, so this needed
improving.

Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
Cc: Eric Van Hensbergen <ericvh@gmail.com>
Cc: Latchesar Ionkov <lucho@ionkov.net>
Cc: Tomas Bortoli <tomasbortoli@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
---
 include/net/9p/client.h |   4 ++
 net/9p/client.c         | 124 +++++++++++++++++++---------------------
 2 files changed, 62 insertions(+), 66 deletions(-)

diff --git a/include/net/9p/client.h b/include/net/9p/client.h
index a4ded7666c73..75d7f83e5b94 100644
--- a/include/net/9p/client.h
+++ b/include/net/9p/client.h
@@ -91,6 +91,7 @@ enum p9_req_status_t {
  * @aux: transport specific data (provided for trans_fd migration)
  * @req_list: link used by trans_fd
  * @async_list: link used to check on async requests
+ * @clunked_fid: for clunk, points to fid
  */
 struct p9_req_t {
 	int status;
@@ -102,6 +103,9 @@ struct p9_req_t {
 	void *aux;
 	struct list_head req_list;
 	struct list_head async_list;
+	union {
+		struct p9_fid *clunked_fid;
+	};
 };
 
 /**
diff --git a/net/9p/client.c b/net/9p/client.c
index 0a67c3ccd4fd..a47b5a54573d 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -649,6 +649,51 @@ static int p9_check_zc_errors(struct p9_client *c, struct p9_req_t *req,
 	return err;
 }
 
+static struct p9_fid *p9_fid_create(struct p9_client *clnt)
+{
+	int ret;
+	struct p9_fid *fid;
+
+	p9_debug(P9_DEBUG_FID, "clnt %p\n", clnt);
+	fid = kmalloc(sizeof(struct p9_fid), GFP_KERNEL);
+	if (!fid)
+		return NULL;
+
+	memset(&fid->qid, 0, sizeof(struct p9_qid));
+	fid->mode = -1;
+	fid->uid = current_fsuid();
+	fid->clnt = clnt;
+	fid->rdir = NULL;
+	fid->fid = 0;
+
+	idr_preload(GFP_KERNEL);
+	spin_lock_irq(&clnt->lock);
+	ret = idr_alloc_u32(&clnt->fids, fid, &fid->fid, P9_NOFID - 1,
+			    GFP_NOWAIT);
+	spin_unlock_irq(&clnt->lock);
+	idr_preload_end();
+
+	if (!ret)
+		return fid;
+
+	kfree(fid);
+	return NULL;
+}
+
+static void p9_fid_destroy(struct p9_fid *fid)
+{
+	struct p9_client *clnt;
+	unsigned long flags;
+
+	p9_debug(P9_DEBUG_FID, "fid %d\n", fid->fid);
+	clnt = fid->clnt;
+	spin_lock_irqsave(&clnt->lock, flags);
+	idr_remove(&clnt->fids, fid->fid);
+	spin_unlock_irqrestore(&clnt->lock, flags);
+	kfree(fid->rdir);
+	kfree(fid);
+}
+
 static struct p9_req_t *
 p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...);
 
@@ -778,6 +823,9 @@ static void p9_client_handle_async(struct p9_client *c, bool free_all)
 		}
 		if (free_all || req->status >= REQ_STATUS_RCVD) {
 			/* Put old refs whatever reqs actually returned */
+			if (req->tc.id == P9_TCLUNK) {
+				p9_fid_destroy(req->clunked_fid);
+			}
 			list_del(&req->async_list);
 			p9_tag_remove(c, req);
 		}
@@ -959,51 +1007,6 @@ static struct p9_req_t *p9_client_zc_rpc(struct p9_client *c, int8_t type,
 	return ERR_PTR(safe_errno(err));
 }
 
-static struct p9_fid *p9_fid_create(struct p9_client *clnt)
-{
-	int ret;
-	struct p9_fid *fid;
-
-	p9_debug(P9_DEBUG_FID, "clnt %p\n", clnt);
-	fid = kmalloc(sizeof(struct p9_fid), GFP_KERNEL);
-	if (!fid)
-		return NULL;
-
-	memset(&fid->qid, 0, sizeof(struct p9_qid));
-	fid->mode = -1;
-	fid->uid = current_fsuid();
-	fid->clnt = clnt;
-	fid->rdir = NULL;
-	fid->fid = 0;
-
-	idr_preload(GFP_KERNEL);
-	spin_lock_irq(&clnt->lock);
-	ret = idr_alloc_u32(&clnt->fids, fid, &fid->fid, P9_NOFID - 1,
-			    GFP_NOWAIT);
-	spin_unlock_irq(&clnt->lock);
-	idr_preload_end();
-
-	if (!ret)
-		return fid;
-
-	kfree(fid);
-	return NULL;
-}
-
-static void p9_fid_destroy(struct p9_fid *fid)
-{
-	struct p9_client *clnt;
-	unsigned long flags;
-
-	p9_debug(P9_DEBUG_FID, "fid %d\n", fid->fid);
-	clnt = fid->clnt;
-	spin_lock_irqsave(&clnt->lock, flags);
-	idr_remove(&clnt->fids, fid->fid);
-	spin_unlock_irqrestore(&clnt->lock, flags);
-	kfree(fid->rdir);
-	kfree(fid);
-}
-
 static int p9_client_version(struct p9_client *c)
 {
 	int err = 0;
@@ -1534,7 +1537,6 @@ int p9_client_clunk(struct p9_fid *fid)
 	int err;
 	struct p9_client *clnt;
 	struct p9_req_t *req;
-	int retries = 0;
 
 	if (!fid) {
 		pr_warn("%s (%d): Trying to clunk with NULL fid\n",
@@ -1543,33 +1545,23 @@ int p9_client_clunk(struct p9_fid *fid)
 		return 0;
 	}
 
-again:
-	p9_debug(P9_DEBUG_9P, ">>> TCLUNK fid %d (try %d)\n", fid->fid,
-								retries);
+	p9_debug(P9_DEBUG_9P, ">>> TCLUNK fid %d\n", fid->fid);
 	err = 0;
 	clnt = fid->clnt;
 
-	req = p9_client_rpc(clnt, P9_TCLUNK, "d", fid->fid);
+	req = p9_client_async_rpc(clnt, P9_TCLUNK, "d", fid->fid);
 	if (IS_ERR(req)) {
-		err = PTR_ERR(req);
-		goto error;
+		return PTR_ERR(req);
 	}
 
-	p9_debug(P9_DEBUG_9P, "<<< RCLUNK fid %d\n", fid->fid);
+	p9_debug(P9_DEBUG_MUX, "sent clunk for fid %d, tag %d\n",
+		 fid->fid, req->tc.tag);
+	req->clunked_fid = fid;
+	spin_lock_irq(&clnt->lock);
+	list_add(&req->async_list, &clnt->async_req_list);
+	spin_unlock_irq(&clnt->lock);
 
-	p9_tag_remove(clnt, req);
-error:
-	/*
-	 * Fid is not valid even after a failed clunk
-	 * If interrupted, retry once then give up and
-	 * leak fid until umount.
-	 */
-	if (err == -ERESTARTSYS) {
-		if (retries++ == 0)
-			goto again;
-	} else
-		p9_fid_destroy(fid);
-	return err;
+	return 0;
 }
 EXPORT_SYMBOL(p9_client_clunk);
 
-- 
2.19.2


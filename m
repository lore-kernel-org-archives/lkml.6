Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B644C38A24
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C052420C0B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CLdHXgiO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C052420C0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389082AbeGKVJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 17:09:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47000 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390322AbeGKVIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 17:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Txkf7OXUzf6Cil7wD8wvzP02ZAJG4PjMRBP7TzEU6YM=; b=CLdHXgiO2FwShk6hu++SOAUev
        C5RpkmfX5o++OQ/OWYOJSCqCHWZSWQj5nDb7yhexN7ve4D9tEiTy4kvbfGocX5jPF0HWoQQeC7kb5
        JJf1R0tcHvRQzW3wd2Yw0ItRG0+oAvOO9xKW6vhTUo1u3aZvWf47ngB+Ich+33ABUBCtiHsEwzcX1
        +ccfDYJpbiN+1mBe5P6xThL34QzZxO98OsMD5PKovJwZk5u1IJPEhk1B9QSnGyFw4HhcnZnyEOCgm
        wZLOBUE/4ViC0mVxVUVpYBspYAM7NXYPFDI9ZgCi/D5hxNGYBnNi8Ezgq9x1hWflA4rBxbxRQp9gR
        tkC8EliLg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdMFq-0005AF-5x; Wed, 11 Jul 2018 21:02:30 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        v9fs-developer@lists.sourceforge.net,
        Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 3/6] 9p: Replace the fidlist with an IDR
Date:   Wed, 11 Jul 2018 14:02:22 -0700
Message-Id: <20180711210225.19730-4-willy@infradead.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180711210225.19730-1-willy@infradead.org>
References: <20180711210225.19730-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The p9_idpool being used to allocate the IDs uses an IDR to allocate
the IDs ... which we then keep in a doubly-linked list, rather than in
the IDR which allocated them.  We can use an IDR directly which saves
two pointers per p9_fid, and a tiny memory allocation per p9_client.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 include/net/9p/client.h |  9 +++------
 net/9p/client.c         | 44 +++++++++++++++--------------------------
 2 files changed, 19 insertions(+), 34 deletions(-)

diff --git a/include/net/9p/client.h b/include/net/9p/client.h
index 7af9d769b97d..e405729cd1c7 100644
--- a/include/net/9p/client.h
+++ b/include/net/9p/client.h
@@ -27,6 +27,7 @@
 #define NET_9P_CLIENT_H
 
 #include <linux/utsname.h>
+#include <linux/idr.h>
 
 /* Number of requests per row */
 #define P9_ROW_MAXTAG 255
@@ -128,8 +129,7 @@ struct p9_req_t {
  * @proto_version: 9P protocol version to use
  * @trans_mod: module API instantiated with this client
  * @trans: tranport instance state and API
- * @fidpool: fid handle accounting for session
- * @fidlist: List of active fid handles
+ * @fids: All active FID handles
  * @tagpool - transaction id accounting for session
  * @reqs - 2D array of requests
  * @max_tag - current maximum tag id allocated
@@ -169,8 +169,7 @@ struct p9_client {
 		} tcp;
 	} trans_opts;
 
-	struct p9_idpool *fidpool;
-	struct list_head fidlist;
+	struct idr fids;
 
 	struct p9_idpool *tagpool;
 	struct p9_req_t *reqs[P9_ROW_MAXTAG];
@@ -188,7 +187,6 @@ struct p9_client {
  * @iounit: the server reported maximum transaction size for this file
  * @uid: the numeric uid of the local user who owns this handle
  * @rdir: readdir accounting structure (allocated on demand)
- * @flist: per-client-instance fid tracking
  * @dlist: per-dentry fid tracking
  *
  * TODO: This needs lots of explanation.
@@ -204,7 +202,6 @@ struct p9_fid {
 
 	void *rdir;
 
-	struct list_head flist;
 	struct hlist_node dlist;	/* list of all fids attached to a dentry */
 };
 
diff --git a/net/9p/client.c b/net/9p/client.c
index 389a2904b7b3..b89c7298267c 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -908,30 +908,29 @@ static struct p9_fid *p9_fid_create(struct p9_client *clnt)
 {
 	int ret;
 	struct p9_fid *fid;
-	unsigned long flags;
 
 	p9_debug(P9_DEBUG_FID, "clnt %p\n", clnt);
 	fid = kmalloc(sizeof(struct p9_fid), GFP_KERNEL);
 	if (!fid)
 		return NULL;
 
-	ret = p9_idpool_get(clnt->fidpool);
-	if (ret < 0)
-		goto error;
-	fid->fid = ret;
-
 	memset(&fid->qid, 0, sizeof(struct p9_qid));
 	fid->mode = -1;
 	fid->uid = current_fsuid();
 	fid->clnt = clnt;
 	fid->rdir = NULL;
-	spin_lock_irqsave(&clnt->lock, flags);
-	list_add(&fid->flist, &clnt->fidlist);
-	spin_unlock_irqrestore(&clnt->lock, flags);
+	fid->fid = 0;
 
-	return fid;
+	idr_preload(GFP_KERNEL);
+	spin_lock_irq(&clnt->lock);
+	ret = idr_alloc_u32(&clnt->fids, fid, &fid->fid, P9_NOFID - 1,
+			GFP_NOWAIT);
+	spin_unlock_irq(&clnt->lock);
+	idr_preload_end();
+
+	if (!ret)
+		return fid;
 
-error:
 	kfree(fid);
 	return NULL;
 }
@@ -943,9 +942,8 @@ static void p9_fid_destroy(struct p9_fid *fid)
 
 	p9_debug(P9_DEBUG_FID, "fid %d\n", fid->fid);
 	clnt = fid->clnt;
-	p9_idpool_put(fid->fid, clnt->fidpool);
 	spin_lock_irqsave(&clnt->lock, flags);
-	list_del(&fid->flist);
+	idr_remove(&clnt->fids, fid->fid);
 	spin_unlock_irqrestore(&clnt->lock, flags);
 	kfree(fid->rdir);
 	kfree(fid);
@@ -1028,7 +1026,7 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
 	memcpy(clnt->name, client_id, strlen(client_id) + 1);
 
 	spin_lock_init(&clnt->lock);
-	INIT_LIST_HEAD(&clnt->fidlist);
+	idr_init(&clnt->fids);
 
 	err = p9_tag_init(clnt);
 	if (err < 0)
@@ -1048,18 +1046,12 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
 		goto destroy_tagpool;
 	}
 
-	clnt->fidpool = p9_idpool_create();
-	if (IS_ERR(clnt->fidpool)) {
-		err = PTR_ERR(clnt->fidpool);
-		goto put_trans;
-	}
-
 	p9_debug(P9_DEBUG_MUX, "clnt %p trans %p msize %d protocol %d\n",
 		 clnt, clnt->trans_mod, clnt->msize, clnt->proto_version);
 
 	err = clnt->trans_mod->create(clnt, dev_name, options);
 	if (err)
-		goto destroy_fidpool;
+		goto put_trans;
 
 	if (clnt->msize > clnt->trans_mod->maxsize)
 		clnt->msize = clnt->trans_mod->maxsize;
@@ -1072,8 +1064,6 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
 
 close_trans:
 	clnt->trans_mod->close(clnt);
-destroy_fidpool:
-	p9_idpool_destroy(clnt->fidpool);
 put_trans:
 	v9fs_put_trans(clnt->trans_mod);
 destroy_tagpool:
@@ -1086,7 +1076,8 @@ EXPORT_SYMBOL(p9_client_create);
 
 void p9_client_destroy(struct p9_client *clnt)
 {
-	struct p9_fid *fid, *fidptr;
+	struct p9_fid *fid;
+	int id;
 
 	p9_debug(P9_DEBUG_MUX, "clnt %p\n", clnt);
 
@@ -1095,14 +1086,11 @@ void p9_client_destroy(struct p9_client *clnt)
 
 	v9fs_put_trans(clnt->trans_mod);
 
-	list_for_each_entry_safe(fid, fidptr, &clnt->fidlist, flist) {
+	idr_for_each_entry(&clnt->fids, fid, id) {
 		pr_info("Found fid %d not clunked\n", fid->fid);
 		p9_fid_destroy(fid);
 	}
 
-	if (clnt->fidpool)
-		p9_idpool_destroy(clnt->fidpool);
-
 	p9_tag_cleanup(clnt);
 
 	kfree(clnt);
-- 
2.18.0


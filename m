Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD12C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B839520C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B839520C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbeGLGja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 02:39:30 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52675 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726854AbeGLGja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 02:39:30 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 01AEA2B38CA2A;
        Thu, 12 Jul 2018 14:31:17 +0800 (CST)
Received: from [10.177.253.249] (10.177.253.249) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.382.0; Thu, 12 Jul 2018
 14:31:13 +0800
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        <ericvh@gmail.com>, <rminnich@sandia.gov>, <lucho@ionkov.net>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <v9fs-developer@lists.sourceforge.net>
From:   piaojun <piaojun@huawei.com>
Subject: [PATCH] net/9p/client.c: fix misuse of spin_lock_irqsave for
 p9_client lock
Message-ID: <5B46F5AD.50200@huawei.com>
Date:   Thu, 12 Jul 2018 14:31:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.253.249]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In p9_read_work(), we use spin_lock for client->lock, but misuse
spin_lock_irqsave for it in p9_fid_create(). As p9_client lock won't be
locked in irq context, so spin_lock is enough. And that will improve the
performance.

Signed-off-by: Jun Piao <piaojun@huawei.com>
---
 net/9p/client.c   | 17 +++++++----------
 net/9p/trans_fd.c |  7 +++----
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index 8bc8b3e..b05cbfc 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -260,7 +260,6 @@ static struct p9_fcall *p9_fcall_alloc(int alloc_msize)
 static struct p9_req_t *
 p9_tag_alloc(struct p9_client *c, u16 tag, unsigned int max_size)
 {
-	unsigned long flags;
 	int row, col;
 	struct p9_req_t *req;
 	int alloc_msize = min(c->msize, max_size);
@@ -270,7 +269,7 @@ static struct p9_fcall *p9_fcall_alloc(int alloc_msize)
 	tag++;

 	if (tag >= c->max_tag) {
-		spin_lock_irqsave(&c->lock, flags);
+		spin_lock(&c->lock);
 		/* check again since original check was outside of lock */
 		while (tag >= c->max_tag) {
 			row = (tag / P9_ROW_MAXTAG);
@@ -279,7 +278,7 @@ static struct p9_fcall *p9_fcall_alloc(int alloc_msize)

 			if (!c->reqs[row]) {
 				pr_err("Couldn't grow tag array\n");
-				spin_unlock_irqrestore(&c->lock, flags);
+				spin_unlock(&c->lock);
 				return ERR_PTR(-ENOMEM);
 			}
 			for (col = 0; col < P9_ROW_MAXTAG; col++) {
@@ -288,7 +287,7 @@ static struct p9_fcall *p9_fcall_alloc(int alloc_msize)
 			}
 			c->max_tag += P9_ROW_MAXTAG;
 		}
-		spin_unlock_irqrestore(&c->lock, flags);
+		spin_unlock(&c->lock);
 	}
 	row = tag / P9_ROW_MAXTAG;
 	col = tag % P9_ROW_MAXTAG;
@@ -909,7 +908,6 @@ static struct p9_fid *p9_fid_create(struct p9_client *clnt)
 {
 	int ret;
 	struct p9_fid *fid;
-	unsigned long flags;

 	p9_debug(P9_DEBUG_FID, "clnt %p\n", clnt);
 	fid = kmalloc(sizeof(struct p9_fid), GFP_KERNEL);
@@ -928,9 +926,9 @@ static struct p9_fid *p9_fid_create(struct p9_client *clnt)
 	fid->uid = current_fsuid();
 	fid->clnt = clnt;
 	fid->rdir = NULL;
-	spin_lock_irqsave(&clnt->lock, flags);
+	spin_lock(&clnt->lock);
 	list_add(&fid->flist, &clnt->fidlist);
-	spin_unlock_irqrestore(&clnt->lock, flags);
+	spin_unlock(&clnt->lock);

 	return fid;

@@ -942,14 +940,13 @@ static struct p9_fid *p9_fid_create(struct p9_client *clnt)
 static void p9_fid_destroy(struct p9_fid *fid)
 {
 	struct p9_client *clnt;
-	unsigned long flags;

 	p9_debug(P9_DEBUG_FID, "fid %d\n", fid->fid);
 	clnt = fid->clnt;
 	p9_idpool_put(fid->fid, clnt->fidpool);
-	spin_lock_irqsave(&clnt->lock, flags);
+	spin_lock(&clnt->lock);
 	list_del(&fid->flist);
-	spin_unlock_irqrestore(&clnt->lock, flags);
+	spin_unlock(&clnt->lock);
 	kfree(fid->rdir);
 	kfree(fid);
 }
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 588bf88..96e1e68 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -197,15 +197,14 @@ static void p9_mux_poll_stop(struct p9_conn *m)
 static void p9_conn_cancel(struct p9_conn *m, int err)
 {
 	struct p9_req_t *req, *rtmp;
-	unsigned long flags;
 	LIST_HEAD(cancel_list);

 	p9_debug(P9_DEBUG_ERROR, "mux %p err %d\n", m, err);

-	spin_lock_irqsave(&m->client->lock, flags);
+	spin_lock(&m->client->lock);

 	if (m->err) {
-		spin_unlock_irqrestore(&m->client->lock, flags);
+		spin_unlock(&m->client->lock);
 		return;
 	}

@@ -217,7 +216,7 @@ static void p9_conn_cancel(struct p9_conn *m, int err)
 	list_for_each_entry_safe(req, rtmp, &m->unsent_req_list, req_list) {
 		list_move(&req->req_list, &cancel_list);
 	}
-	spin_unlock_irqrestore(&m->client->lock, flags);
+	spin_unlock(&m->client->lock);

 	list_for_each_entry_safe(req, rtmp, &cancel_list, req_list) {
 		p9_debug(P9_DEBUG_ERROR, "call back req %p\n", req);
-- 

Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB5AECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A83208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24A83208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729652AbeGQG5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 02:57:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9630 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728015AbeGQG5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 02:57:00 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 94AF4172FE010;
        Tue, 17 Jul 2018 14:25:43 +0800 (CST)
Received: from [10.177.253.249] (10.177.253.249) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.382.0; Tue, 17 Jul 2018
 14:25:40 +0800
To:     Dominique Martinet <asmadeus@codewreck.org>
CC:     Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <v9fs-developer@lists.sourceforge.net>
From:   piaojun <piaojun@huawei.com>
Subject: [PATCH v2] net/9p/client.c: fix misuse of spin_lock_irqsave for
 p9_client lock
Message-ID: <5B4D8BD8.3040009@huawei.com>
Date:   Tue, 17 Jul 2018 14:25:28 +0800
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

Rebased on 9p-next.

Signed-off-by: Jun Piao <piaojun@huawei.com>
---
 net/9p/client.c   | 18 ++++++++----------
 net/9p/trans_fd.c |  7 +++----
 2 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index 30f9aee..f6897ee 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -275,14 +275,14 @@ static struct p9_fcall *p9_fcall_alloc(int alloc_msize)
 	INIT_LIST_HEAD(&req->req_list);

 	idr_preload(GFP_NOFS);
-	spin_lock_irq(&c->lock);
+	spin_lock(&c->lock);
 	if (type == P9_TVERSION)
 		tag = idr_alloc(&c->reqs, req, P9_NOTAG, P9_NOTAG + 1,
 				GFP_NOWAIT);
 	else
 		tag = idr_alloc(&c->reqs, req, 0, P9_NOTAG, GFP_NOWAIT);
 	req->tc->tag = tag;
-	spin_unlock_irq(&c->lock);
+	spin_unlock(&c->lock);
 	idr_preload_end();
 	if (tag < 0)
 		goto free;
@@ -328,13 +328,12 @@ struct p9_req_t *p9_tag_lookup(struct p9_client *c, u16 tag)
  */
 static void p9_free_req(struct p9_client *c, struct p9_req_t *r)
 {
-	unsigned long flags;
 	u16 tag = r->tc->tag;

 	p9_debug(P9_DEBUG_MUX, "clnt %p req %p tag: %d\n", c, r, tag);
-	spin_lock_irqsave(&c->lock, flags);
+	spin_lock(&c->lock);
 	idr_remove(&c->reqs, tag);
-	spin_unlock_irqrestore(&c->lock, flags);
+	spin_unlock(&c->lock);
 	kfree(r->tc);
 	kfree(r->rc);
 	kmem_cache_free(p9_req_cache, r);
@@ -846,10 +845,10 @@ static struct p9_fid *p9_fid_create(struct p9_client *clnt)
 	fid->fid = 0;

 	idr_preload(GFP_KERNEL);
-	spin_lock_irq(&clnt->lock);
+	spin_lock(&clnt->lock);
 	ret = idr_alloc_u32(&clnt->fids, fid, &fid->fid, P9_NOFID - 1,
 			    GFP_NOWAIT);
-	spin_unlock_irq(&clnt->lock);
+	spin_unlock(&clnt->lock);
 	idr_preload_end();

 	if (!ret)
@@ -862,13 +861,12 @@ static struct p9_fid *p9_fid_create(struct p9_client *clnt)
 static void p9_fid_destroy(struct p9_fid *fid)
 {
 	struct p9_client *clnt;
-	unsigned long flags;

 	p9_debug(P9_DEBUG_FID, "fid %d\n", fid->fid);
 	clnt = fid->clnt;
-	spin_lock_irqsave(&clnt->lock, flags);
+	spin_lock(&clnt->lock);
 	idr_remove(&clnt->fids, fid->fid);
-	spin_unlock_irqrestore(&clnt->lock, flags);
+	spin_unlock(&clnt->lock);
 	kfree(fid->rdir);
 	kfree(fid);
 }
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index bf459ee..94ef685 100644
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

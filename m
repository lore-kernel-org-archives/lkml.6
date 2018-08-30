Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6B7C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 598E82082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 598E82082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbeH3Ogo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 10:36:44 -0400
Received: from nautica.notk.org ([91.121.71.147]:53017 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728098AbeH3Ogo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 10:36:44 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 342A9C009; Thu, 30 Aug 2018 12:35:14 +0200 (CEST)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>
Cc:     Dominique Martinet <dominique.martinet@cea.fr>,
        v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: [PATCH] 9p/rdma: do not disconnect on down_interruptible EAGAIN
Date:   Thu, 30 Aug 2018 12:35:07 +0200
Message-Id: <1535625307-18019-1-git-send-email-asmadeus@codewreck.org>
X-Mailer: git-send-email 1.7.10.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dominique Martinet <dominique.martinet@cea.fr>

9p/rdma would sometimes drop the connection and display errors in
recv_done when the user does ^C.
The errors were IB_WC_WR_FLUSH_ERR caused by recv buffers that were
posted at the time of disconnect, and we just do not want to disconnect
when down_interruptible is... interrupted.

As a bonus, re-evaluate the log importance of post_recv() failing: we
want to see that one if it ever happens.

Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
---

this had actually been bugging me forever, but I couldn't test the refcount
stuff properly around flush with that so I had to finally figure it out..

 net/9p/trans_rdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/9p/trans_rdma.c b/net/9p/trans_rdma.c
index 9cc9b3a19ee7..9719bc4d9424 100644
--- a/net/9p/trans_rdma.c
+++ b/net/9p/trans_rdma.c
@@ -477,7 +477,7 @@ static int rdma_request(struct p9_client *client, struct p9_req_t *req)
 
 	err = post_recv(client, rpl_context);
 	if (err) {
-		p9_debug(P9_DEBUG_FCALL, "POST RECV failed\n");
+		p9_debug(P9_DEBUG_ERROR, "POST RECV failed: %d\n", err);
 		goto recv_error;
 	}
 	/* remove posted receive buffer from request structure */
@@ -546,7 +546,7 @@ static int rdma_request(struct p9_client *client, struct p9_req_t *req)
  recv_error:
 	kfree(rpl_context);
 	spin_lock_irqsave(&rdma->req_lock, flags);
-	if (rdma->state < P9_RDMA_CLOSING) {
+	if (err != -EINTR && rdma->state < P9_RDMA_CLOSING) {
 		rdma->state = P9_RDMA_CLOSING;
 		spin_unlock_irqrestore(&rdma->req_lock, flags);
 		rdma_disconnect(rdma->cm_id);
-- 
2.17.1


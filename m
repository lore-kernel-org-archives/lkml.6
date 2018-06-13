Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AA1B6C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ACD4208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:01:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ACD4208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935466AbeFMMBn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 08:01:43 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:34242 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935296AbeFMMBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 08:01:41 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by andre.telenet-ops.be with bizsmtp
        id yC1f1x00C3XaVaC01C1f7x; Wed, 13 Jun 2018 14:01:40 +0200
Received: from ramsan.of.borg ([192.168.97.29] helo=ramsan)
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fT4T5-0002B3-6F; Wed, 13 Jun 2018 14:01:39 +0200
Received: from geert by ramsan with local (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fT4T5-0006xJ-4f; Wed, 13 Jun 2018 14:01:39 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Chuck Lever <chuck.lever@oracle.com>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] SUNRPC: Move inline xprt_alloc_xid() up to fix compiler warning
Date:   Wed, 13 Jun 2018 14:01:38 +0200
Message-Id: <1528891298-26694-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With gcc 4.1.2:

    net/sunrpc/xprt.c:69: warning: ‘xprt_alloc_xid’ declared inline after being called
    net/sunrpc/xprt.c:69: warning: previous declaration of ‘xprt_alloc_xid’ was here

To fix this, move the function up, before its caller, and remove the no
longer needed forward declaration.

Fixes: 37ac86c3a76c1136 ("SUNRPC: Initialize rpc_rqst outside of xprt->reserve_lock")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 net/sunrpc/xprt.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 3c85af058227d14b..60a8b9f91cf94b54 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -66,7 +66,6 @@
  * Local functions
  */
 static void	 xprt_init(struct rpc_xprt *xprt, struct net *net);
-static __be32	xprt_alloc_xid(struct rpc_xprt *xprt);
 static void	xprt_connect_status(struct rpc_task *task);
 static int      __xprt_get_cong(struct rpc_xprt *, struct rpc_task *);
 static void     __xprt_put_cong(struct rpc_xprt *, struct rpc_rqst *);
@@ -956,6 +955,11 @@ static void xprt_timer(struct rpc_task *task)
 		task->tk_status = 0;
 }
 
+static inline __be32 xprt_alloc_xid(struct rpc_xprt *xprt)
+{
+	return (__force __be32)xprt->xid++;
+}
+
 /**
  * xprt_prepare_transmit - reserve the transport before sending a request
  * @task: RPC task about to send a request
@@ -1296,11 +1300,6 @@ void xprt_retry_reserve(struct rpc_task *task)
 	xprt->ops->alloc_slot(xprt, task);
 }
 
-static inline __be32 xprt_alloc_xid(struct rpc_xprt *xprt)
-{
-	return (__force __be32)xprt->xid++;
-}
-
 static inline void xprt_init_xid(struct rpc_xprt *xprt)
 {
 	xprt->xid = prandom_u32();
-- 
2.7.4


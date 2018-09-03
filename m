Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695A6C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30F2D20658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:33:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30F2D20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731312AbeICVye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:54:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47650 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729001AbeICVyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:54:33 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B235FD16;
        Mon,  3 Sep 2018 17:33:23 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 4.18 004/123] xprtrdma: Fix disconnect regression
Date:   Mon,  3 Sep 2018 18:55:48 +0200
Message-Id: <20180903165719.676830902@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165719.499675257@linuxfoundation.org>
References: <20180903165719.499675257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

commit 8d4fb8ff427a23e573c9373b2bb3d1d6e8ea4399 upstream.

I found that injecting disconnects with v4.18-rc resulted in
random failures of the multi-threaded git regression test.

The root cause appears to be that, after a reconnect, the
RPC/RDMA transport is waking pending RPCs before the transport has
posted enough Receive buffers to receive the Replies. If a Reply
arrives before enough Receive buffers are posted, the connection
is dropped. A few connection drops happen in quick succession as
the client and server struggle to regain credit synchronization.

This regression was introduced with commit 7c8d9e7c8863 ("xprtrdma:
Move Receive posting to Receive handler"). The client is supposed to
post a single Receive when a connection is established because
it's not supposed to send more than one RPC Call before it gets
a fresh credit grant in the first RPC Reply [RFC 8166, Section
3.3.3].

Unfortunately there appears to be a longstanding bug in the Linux
client's credit accounting mechanism. On connect, it simply dumps
all pending RPC Calls onto the new connection. It's possible it has
done this ever since the RPC/RDMA transport was added to the kernel
ten years ago.

Servers have so far been tolerant of this bad behavior. Currently no
server implementation ever changes its credit grant over reconnects,
and servers always repost enough Receives before connections are
fully established.

The Linux client implementation used to post a Receive before each
of these Calls. This has covered up the flooding send behavior.

I could try to correct this old bug so that the client sends exactly
one RPC Call and waits for a Reply. Since we are so close to the
next merge window, I'm going to instead provide a simple patch to
post enough Receives before a reconnect completes (based on the
number of credits granted to the previous connection).

The spurious disconnects will be gone, but the client will still
send multiple RPC Calls immediately after a reconnect.

Addressing the latter problem will wait for a merge window because
a) I expect it to be a large change requiring lots of testing, and
b) obviously the Linux client has interoperated successfully since
day zero while still being broken.

Fixes: 7c8d9e7c8863 ("xprtrdma: Move Receive posting to ... ")
Cc: stable@vger.kernel.org # v4.18+
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sunrpc/xprtrdma/verbs.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -280,7 +280,6 @@ rpcrdma_conn_upcall(struct rdma_cm_id *i
 		++xprt->rx_xprt.connect_cookie;
 		connstate = -ECONNABORTED;
 connected:
-		xprt->rx_buf.rb_credits = 1;
 		ep->rep_connected = connstate;
 		rpcrdma_conn_func(ep);
 		wake_up_all(&ep->rep_connect_wait);
@@ -755,6 +754,7 @@ retry:
 	}
 
 	ep->rep_connected = 0;
+	rpcrdma_post_recvs(r_xprt, true);
 
 	rc = rdma_connect(ia->ri_id, &ep->rep_remote_cma);
 	if (rc) {
@@ -773,8 +773,6 @@ retry:
 
 	dprintk("RPC:       %s: connected\n", __func__);
 
-	rpcrdma_post_recvs(r_xprt, true);
-
 out:
 	if (rc)
 		ep->rep_connected = rc;
@@ -1171,6 +1169,7 @@ rpcrdma_buffer_create(struct rpcrdma_xpr
 		list_add(&req->rl_list, &buf->rb_send_bufs);
 	}
 
+	buf->rb_credits = 1;
 	buf->rb_posted_receives = 0;
 	INIT_LIST_HEAD(&buf->rb_recv_bufs);
 



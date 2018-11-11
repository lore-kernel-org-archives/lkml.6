Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A99C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D71820869
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NouEQ+8A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D71820869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388930AbeKLJVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:21:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:43864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388619AbeKLIUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:22 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D014C216FD;
        Sun, 11 Nov 2018 22:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975425;
        bh=lpDqAYzNXV6LeJY/aAkU3Y1qq5vaHvps461vzDZoQ/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NouEQ+8AEg1u/loYAshiEr+IhYWg0q7TM3iS0QFmasPghaVqo1gBWHmAWC4r4Xg7m
         dLt6Q9Ot75vNVYL0R5uD3OpLsQby29NGDdPntN+7KU739SXM7Oox9ItUf4vyE5CCIC
         xcFuCZ6oeHxRlZvmNy6SxWocmJ2ESqjqt5lN93cU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        stable@kernel.org, Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 158/350] xprtrdma: Reset credit grant properly after a disconnect
Date:   Sun, 11 Nov 2018 14:20:22 -0800
Message-Id: <20181111221714.664540660@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit ef739b2175dde9c05594f768cb78149f1ce2ac36 ]

On a fresh connection, an RPC/RDMA client is supposed to send only
one RPC Call until it gets a credit grant in the first RPC Reply
from the server [RFC 8166, Section 3.3.3].

There is a bug in the Linux client's credit accounting mechanism
introduced by commit e7ce710a8802 ("xprtrdma: Avoid deadlock when
credit window is reset"). On connect, it simply dumps all pending
RPC Calls onto the new connection.

Servers have been tolerant of this bad behavior. Currently no server
implementation ever changes its credit grant over reconnects, and
servers always repost enough Receives before connections are fully
established.

To correct this issue, ensure that the client resets both the credit
grant _and_ the congestion window when handling a reconnect.

Fixes: e7ce710a8802 ("xprtrdma: Avoid deadlock when credit ... ")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Cc: stable@kernel.org
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |    1 +
 net/sunrpc/xprtrdma/transport.c            |    6 ++++++
 2 files changed, 7 insertions(+)

--- a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
@@ -248,6 +248,7 @@ static void
 xprt_rdma_bc_close(struct rpc_xprt *xprt)
 {
 	dprintk("svcrdma: %s: xprt %p\n", __func__, xprt);
+	xprt->cwnd = RPC_CWNDSHIFT;
 }
 
 static void
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -468,6 +468,12 @@ xprt_rdma_close(struct rpc_xprt *xprt)
 		xprt->reestablish_timeout = 0;
 	xprt_disconnect_done(xprt);
 	rpcrdma_ep_disconnect(ep, ia);
+
+	/* Prepare @xprt for the next connection by reinitializing
+	 * its credit grant to one (see RFC 8166, Section 3.3.3).
+	 */
+	r_xprt->rx_buf.rb_credits = 1;
+	xprt->cwnd = RPC_CWNDSHIFT;
 }
 
 /**



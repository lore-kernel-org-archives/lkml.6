Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095CEC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C288920664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGd8bb9x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C288920664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730694AbeKAIcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:32:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730493AbeKAIJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:09:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20F7320843;
        Wed, 31 Oct 2018 23:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027363;
        bh=/CwvahwV96iKOdOahg9iozHHRKRAOFxZxtm5qC/FAIE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qGd8bb9xl8GyHgm+GYwvyVhjA0TY0WIclw/Aue9QMC+Zu+oJy7a5hhsM4ewfXLgVR
         HUf4e+WhDwQgDfzCOUpN7WBHxe/8bf3mDdd1MtNLc19C5Ov+8j/qnChpp5Ol7swcBg
         EiNo5oRKJ4rzc1HiiuYsUesM04Yd1a8g6TgB7K4I=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, stable@kernel.org,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 098/126] xprtrdma: Reset credit grant properly after a disconnect
Date:   Wed, 31 Oct 2018 19:07:26 -0400
Message-Id: <20181031230754.29029-98-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230754.29029-1-sashal@kernel.org>
References: <20181031230754.29029-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c | 1 +
 net/sunrpc/xprtrdma/transport.c            | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
index a68180090554..b9827665ff35 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
@@ -248,6 +248,7 @@ static void
 xprt_rdma_bc_close(struct rpc_xprt *xprt)
 {
 	dprintk("svcrdma: %s: xprt %p\n", __func__, xprt);
+	xprt->cwnd = RPC_CWNDSHIFT;
 }
 
 static void
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 143ce2579ba9..98cbc7b060ba 100644
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
-- 
2.17.1


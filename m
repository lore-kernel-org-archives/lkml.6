Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCBDC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B6820874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218941;
	bh=seTiWryhXIED45OrJys+hPz9N2hD+l54qqzsTk11m0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZGolAmnbUxxVeWA1PaeSu0ecPYAo5pabVQLUn7ll7OsslKMFGNiP0Xm3lY/MkCyYq
	 bM63YE3QiCDD4SzutkVuua3M/gv8EJaJi6ee9KA1Ny3UPaW3pqpneLsWpoFhaQ0kbz
	 itkQKAzYUQVUSxd4yqeZgrJqr1Q5VLn2/OeAcph0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391768AbfAKPCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:02:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:51326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388628AbfAKObg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:31:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 951A82133F;
        Fri, 11 Jan 2019 14:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217096;
        bh=seTiWryhXIED45OrJys+hPz9N2hD+l54qqzsTk11m0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t2TYT8FoSp5gg4/bIZsHVdi46ghPqqNtJwn0J1uUpLq8SlHI9+UGStNN9OacN7FNo
         KUeI2GxcP1MX15Ap6PV2Dm0Bg83ssEeg/7F3aOV+iILnJPRBVndlIl8jFTm7RFoHJ7
         vj8g5KACh/vjUebkhzk1wqsjHCBf1yBK1WCI/h+Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 041/105] SUNRPC: Fix a race with XPRT_CONNECTING
Date:   Fri, 11 Jan 2019 15:14:12 +0100
Message-Id: <20190111131106.598434268@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
References: <20190111131102.899065735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit cf76785d30712d90185455e752337acdb53d2a5d ]

Ensure that we clear XPRT_CONNECTING before releasing the XPRT_LOCK so that
we don't have races between the (asynchronous) socket setup code and
tasks in xprt_connect().

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Tested-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xprtsock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 30192abfdc3b..05a58cc1b0cd 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2223,8 +2223,8 @@ static void xs_udp_setup_socket(struct work_struct *work)
 	trace_rpc_socket_connect(xprt, sock, 0);
 	status = 0;
 out:
-	xprt_unlock_connect(xprt, transport);
 	xprt_clear_connecting(xprt);
+	xprt_unlock_connect(xprt, transport);
 	xprt_wake_pending_tasks(xprt, status);
 }
 
@@ -2451,8 +2451,8 @@ static void xs_tcp_setup_socket(struct work_struct *work)
 	}
 	status = -EAGAIN;
 out:
-	xprt_unlock_connect(xprt, transport);
 	xprt_clear_connecting(xprt);
+	xprt_unlock_connect(xprt, transport);
 	xprt_wake_pending_tasks(xprt, status);
 }
 
-- 
2.19.1




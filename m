Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD4BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C2D2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217437;
	bh=aX0b4cyCPGgPweQn0JfnwoUsN/Zp8icJmgKluS1L6T4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v6hhKSgzZpveZyCLIZS0cLNkDEcF//hbWx6TN7huoVcIQRC+iFTltbR+0gsHZW50R
	 cyV/9Eo/6erCOWruKHk1Iz9KN3kMnavUCU2mQiYWgAwtZClc0Of2JYyg5JbzrhV27l
	 XvyPJBatd6Fwo5GzjxNxzoSxH+DqysfBShLZtVxo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390597AbfAKOhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:37:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:57660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390578AbfAKOhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:37:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15A63204EC;
        Fri, 11 Jan 2019 14:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217432;
        bh=aX0b4cyCPGgPweQn0JfnwoUsN/Zp8icJmgKluS1L6T4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nByf681WQmidco2iXbaRp/SfOV+qN30YoMFzUyYjH9A6lMkqTiqpbuD0h0UgA6OSx
         mCd/x/VNke35hebYyq8i8LHJMHP8NhgtKXnYqTLDjbF3nTOKnAx+lifKOe6Kv3hdRB
         mK9p+x8NcnOnbSZ5K9a69R5wOCzlc45YPtRKa5YA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 057/148] SUNRPC: Fix a race with XPRT_CONNECTING
Date:   Fri, 11 Jan 2019 15:13:55 +0100
Message-Id: <20190111131116.546750373@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index 6b7539c0466e..7d8cce1dfcad 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2244,8 +2244,8 @@ static void xs_udp_setup_socket(struct work_struct *work)
 	trace_rpc_socket_connect(xprt, sock, 0);
 	status = 0;
 out:
-	xprt_unlock_connect(xprt, transport);
 	xprt_clear_connecting(xprt);
+	xprt_unlock_connect(xprt, transport);
 	xprt_wake_pending_tasks(xprt, status);
 }
 
@@ -2480,8 +2480,8 @@ static void xs_tcp_setup_socket(struct work_struct *work)
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




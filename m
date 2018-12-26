Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCA1C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A012821902
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864083;
	bh=bxh8PhzuVO60msNVCW5b2RDxhD0l6dt1tsk2G0kPxaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=09QsHmi3YTZK30W6F6rl3Hy2rU/wMD1IILWJ6nhk8ay7LB5bhxWn7ijPP02jkrGKZ
	 vcyfChLkOpZ0UBy6xzE15xt0Ta3OAevKiAtwy5c/RBF+0QFAJol5JhS9Jd3wdonMYk
	 NlqlZ/rYjlKWz5vxemsGm7gOqlkYqJjnf8b2rWPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbeLZWlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:41:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:41612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729380AbeLZWlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:41:18 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45AFE21741;
        Wed, 26 Dec 2018 22:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545864077;
        bh=bxh8PhzuVO60msNVCW5b2RDxhD0l6dt1tsk2G0kPxaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oyFFGGu+cGxkIl6K0C3mRWaYq3FGqgV8C+CY5htvxh23m0m5T11T0cDJJNUR61+mg
         DXg/xBUZHvK5eqoceExKkO0W6kSMr4km3d6gDugOl4sVkEyexQUk1HClaen4f0766L
         xrs8eCaXQVhLPXpnQAFeWSv23WcFZHX++QwZTDVE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 43/59] SUNRPC: Fix a race with XPRT_CONNECTING
Date:   Wed, 26 Dec 2018 17:38:23 -0500
Message-Id: <20181226223839.150262-43-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223839.150262-1-sashal@kernel.org>
References: <20181226223839.150262-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

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


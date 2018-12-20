Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7490C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916F921720
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297705;
	bh=xH4vDGsbPF2F4m9Lrfbv3EIgf5S1mn/jx9R/LO6HQfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZJ/5vIeFcEa/s/Xzuq0Sj6H7KtBnrqzaM59O/Lr9z5JOEEl/THnP1lLRr1L6AsbvQ
	 Jpsyrzb1VSS7doiWOeoqLZqCioxOxpVG9zu4ShaqQCUNXpntsmnG78+CmVj52NRFGn
	 wJUMgjjMWeaq9jUlPUfs4feqmoTK4/10c45FN3Ko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731171AbeLTJVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:21:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:36630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729276AbeLTJVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:21:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B13221720;
        Thu, 20 Dec 2018 09:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297702;
        bh=xH4vDGsbPF2F4m9Lrfbv3EIgf5S1mn/jx9R/LO6HQfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A89VVGCFvmkW/wOztv4SRn3Rvpjn44Sr5I/UuPYKls6EHBQo/FiENeR5nYFJMrKYv
         MUdioOIeOKWxCLlkqsPCVk2PmwJ0N22nzMl91wxW8lPdZ3dJ1VJtMk3PJ49qFbzNfE
         SdxYtINT9aOUVVx18tl86ihCiqCesOpknygQRbmU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 25/40] SUNRPC: Fix a potential race in xprt_connect()
Date:   Thu, 20 Dec 2018 10:18:37 +0100
Message-Id: <20181220085827.473533567@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085826.212663515@linuxfoundation.org>
References: <20181220085826.212663515@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 0a9a4304f3614e25d9de9b63502ca633c01c0d70 ]

If an asynchronous connection attempt completes while another task is
in xprt_connect(), then the call to rpc_sleep_on() could end up
racing with the call to xprt_wake_pending_tasks().
So add a second test of the connection state after we've put the
task to sleep and set the XPRT_CONNECTING flag, when we know that there
can be no asynchronous connection attempts still in progress.

Fixes: 0b9e79431377d ("SUNRPC: Move the test for XPRT_CONNECTING into...")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xprt.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 2e98f4a243e5..112c191b8336 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -758,8 +758,15 @@ void xprt_connect(struct rpc_task *task)
 			return;
 		if (xprt_test_and_set_connecting(xprt))
 			return;
-		xprt->stat.connect_start = jiffies;
-		xprt->ops->connect(xprt, task);
+		/* Race breaker */
+		if (!xprt_connected(xprt)) {
+			xprt->stat.connect_start = jiffies;
+			xprt->ops->connect(xprt, task);
+		} else {
+			xprt_clear_connecting(xprt);
+			task->tk_status = 0;
+			rpc_wake_up_queued_task(&xprt->pending, task);
+		}
 	}
 	xprt_release_write(xprt, task);
 }
-- 
2.19.1




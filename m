Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0021EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E7F2176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545299204;
	bh=rIRAAN8Z9qhxd5BHH+9BaYWy3Y/Ty0we7wQ0rX7yakU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jktHKfZbHujJqfJE4CzDeC2XP9/Z0O4f/J8t6nf1G7ptKpjceCUXjLBIJ/b9RNbDK
	 Wi3ojQBtXguaQBA9FMfxV6YpoNamCTAFzoRVvxm9dFA8Hg8Sw0GitJblBFZGkYEEH7
	 vccC0Hf7+ueu5odR/E2Iqgyq8CTNNXw9HQHInLPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730455AbeLTJTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:19:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:46146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730355AbeLTJTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:19:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78CCA21773;
        Thu, 20 Dec 2018 09:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297588;
        bh=rIRAAN8Z9qhxd5BHH+9BaYWy3Y/Ty0we7wQ0rX7yakU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TozPUxyQ8Umbb+BgQ5O8pMBtPQqrOLk8G0BgMI3v8hFKKbuWglZkJkJxi4giOou2o
         ABJhCJB7uWmmqHn3VSDCeXCh+pzWc4zlHvDT+bAyv472iLRGH/FNY9Yk4+UM1O45/o
         xyJcO0EZaeV4jJsa5S7GPxsyT2C68IaVrbQkB1cY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 16/31] SUNRPC: Fix a potential race in xprt_connect()
Date:   Thu, 20 Dec 2018 10:18:28 +0100
Message-Id: <20181220085743.241730415@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085742.601260254@linuxfoundation.org>
References: <20181220085742.601260254@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
index 56e4e150e80e..dca234b1f77d 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -721,8 +721,15 @@ void xprt_connect(struct rpc_task *task)
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
 }
 
-- 
2.19.1




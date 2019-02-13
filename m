Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA929C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C00E320811
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083841;
	bh=sEOcZCeUl1PPb+DLXoJvCsAxYq+keoVh2AfGsiL9ozs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f3EmLaydlMfCXgAIMx9MxQJfWYeM2D4y2MjNMXU+W894Ok1RLK5lFbzOoC1XCMNZC
	 vzYpJGwmUauue2wVz3pMTJ/THy8nu6XQ+iiqk4R6pFHfXJ6irj6dX/R5asaTvS7Kde
	 ylOAYSQB5fUQQEnVkc9IUVfNzoD5iSkg28KqoIsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406043AbfBMSoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:44:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:42610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729065AbfBMSn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:43:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B981620835;
        Wed, 13 Feb 2019 18:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083438;
        bh=sEOcZCeUl1PPb+DLXoJvCsAxYq+keoVh2AfGsiL9ozs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x0o7kEx3IqlJxkOFgAa0pGyZiE4IfoL2yTFGl5A7ec9WE15VBGK40g7XPiXPIU6mv
         UZun7ytfiK1nrE9jM7/yDfql4S0JWuRx0SbcivIq22D/4GjPd76hniuWqIEUjXUW2d
         OUMoU9e5ZA/J3tR2r1nsbPRKYoMNZMPCtbN73TZY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Benjamin Coddington <bcodding@redhat.com>
Subject: [PATCH 4.19 36/44] [STABLE PATCH] SUNRPC: Always drop the XPRT_LOCK on XPRT_CLOSE_WAIT
Date:   Wed, 13 Feb 2019 19:38:37 +0100
Message-Id: <20190213183654.822481720@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183651.648060257@linuxfoundation.org>
References: <20190213183651.648060257@linuxfoundation.org>
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

From: Benjamin Coddington <bcodding@redhat.com>

This patch is only appropriate for stable kernels v4.16 - v4.19

Since commit 9b30889c548a ("SUNRPC: Ensure we always close the socket after
a connection shuts down"), and until commit c544577daddb ("SUNRPC: Clean up
transport write space handling"), it is possible for the NFS client to spin
in the following tight loop:

269.964083: rpc_task_run_action: task:43@0 flags=5a81 state=0005 status=0 action=call_bind [sunrpc]
269.964083: rpc_task_run_action: task:43@0 flags=5a81 state=0005 status=0 action=call_connect [sunrpc]
269.964083: rpc_task_run_action: task:43@0 flags=5a81 state=0005 status=0 action=call_transmit [sunrpc]
269.964085: xprt_transmit: peer=[10.0.1.82]:2049 xid=0x761d3f77 status=-32
269.964085: rpc_task_run_action: task:43@0 flags=5a81 state=0005 status=-32 action=call_transmit_status [sunrpc]
269.964085: rpc_task_run_action: task:43@0 flags=5a81 state=0005 status=-32 action=call_status [sunrpc]
269.964085: rpc_call_status: task:43@0 status=-32

The issue is that the path through call_transmit_status does not release
the XPRT_LOCK when the transmit result is -EPIPE, so the socket cannot be
properly shut down.

The below commit fixed things up in mainline by unconditionally calling
xprt_end_transmit() and releasing the XPRT_LOCK after every pass through
call_transmit.  However, the entirety of this commit is not appropriate for
stable kernels because its original inclusion was part of a series that
modifies the sunrpc code to use a different queueing model.  As a result,
there are machinations within this patch that are not needed for a stable
fix and will not make sense without a larger backport of the mainline
series.

In this patch, we take the slightly modified bit of the mainline patch
below, which is to release the XPRT_LOCK on transmission error should we
detect that the transport is waiting to close.

commit c544577daddb618c7dd5fa7fb98d6a41782f020e upstream
Author: Trond Myklebust <trond.myklebust@hammerspace.com>
Date:   Mon Sep 3 23:39:27 2018 -0400

    SUNRPC: Clean up transport write space handling

    Treat socket write space handling in the same way we now treat transport
    congestion: by denying the XPRT_LOCK until the transport signals that it
    has free buffer space.

    Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>

The original discussion of the problem is here:

    https://lore.kernel.org/linux-nfs/20181212135157.4489-1-dwysocha@redhat.com/T/#t

This passes my usual cthon and xfstests on NFS as applied on v4.19 mainline.

Reported-by: Dave Wysochanski <dwysocha@redhat.com>
Suggested-by: Trond Myklebust <trondmy@hammerspace.com>
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/sunrpc/xprt.h |    5 +++++
 net/sunrpc/clnt.c           |    6 ++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -443,6 +443,11 @@ static inline int xprt_test_and_set_conn
 	return test_and_set_bit(XPRT_CONNECTING, &xprt->state);
 }
 
+static inline int xprt_close_wait(struct rpc_xprt *xprt)
+{
+	return test_bit(XPRT_CLOSE_WAIT, &xprt->state);
+}
+
 static inline void xprt_set_bound(struct rpc_xprt *xprt)
 {
 	test_and_set_bit(XPRT_BOUND, &xprt->state);
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1992,13 +1992,15 @@ call_transmit(struct rpc_task *task)
 static void
 call_transmit_status(struct rpc_task *task)
 {
+	struct rpc_xprt *xprt = task->tk_rqstp->rq_xprt;
 	task->tk_action = call_status;
 
 	/*
 	 * Common case: success.  Force the compiler to put this
-	 * test first.
+	 * test first.  Or, if any error and xprt_close_wait,
+	 * release the xprt lock so the socket can close.
 	 */
-	if (task->tk_status == 0) {
+	if (task->tk_status == 0 || xprt_close_wait(xprt)) {
 		xprt_end_transmit(task);
 		rpc_task_force_reencode(task);
 		return;



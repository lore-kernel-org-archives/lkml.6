Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7952C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E137206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025370;
	bh=Rglq5lF9ipUgzhoCyZMr5Plx+MCnMfiO3B62xEFU9o4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rgIgEYMm9b99h6m1YfC8fYOPohzABhe94eS1xR6/+jNFhJtbja2zbaHpObMvlW5i2
	 iYs+PdblMvEtdTzKcBfiN+0/ahD5K0N6w/xgYvzkESHtrSoslFOCxnw3qlyMlzS4Nj
	 F8qD+iQPdWZ5FLO0RSQ/GnR2dWPzpGf93aYMvSKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388054AbfBMCfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:35:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:39296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388039AbfBMCfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:35:34 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90C47222C9;
        Wed, 13 Feb 2019 02:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025333;
        bh=Rglq5lF9ipUgzhoCyZMr5Plx+MCnMfiO3B62xEFU9o4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2AA155LvomHNAtaYhRY/B2UHliO2Z71DHAQ6NlchUNUGUrpXR84/1TDaou61BP05y
         fQJaeDr9KmKZT73WhJStEXJMI4XNE7qMgvnrlQcqAfE4nEpiN2rlM6SmXl8WsvWKJI
         wZR6n/IBAFmvNJdDLCU2GeVXspKhd90ZFNd0WNwY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Trond Myklebust <trondmy@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 075/105] SUNRPC: Ensure rq_bytes_sent is reset before request transmission
Date:   Tue, 12 Feb 2019 21:33:06 -0500
Message-Id: <20190213023336.19019-75-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trondmy@gmail.com>

[ Upstream commit e66721f0436396f779291a29616858b76bfd9415 ]

When we resend a request, ensure that the 'rq_bytes_sent' is reset
to zero.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/clnt.c | 1 -
 net/sunrpc/xprt.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 24cbddc44c88..2189fbc4c570 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1738,7 +1738,6 @@ rpc_xdr_encode(struct rpc_task *task)
 	xdr_buf_init(&req->rq_rcv_buf,
 		     req->rq_rbuffer,
 		     req->rq_rcvsize);
-	req->rq_bytes_sent = 0;
 
 	p = rpc_encode_header(task);
 	if (p == NULL) {
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 943f08be7c38..f1ec2110efeb 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1151,6 +1151,7 @@ xprt_request_enqueue_transmit(struct rpc_task *task)
 	struct rpc_xprt *xprt = req->rq_xprt;
 
 	if (xprt_request_need_enqueue_transmit(task, req)) {
+		req->rq_bytes_sent = 0;
 		spin_lock(&xprt->queue_lock);
 		/*
 		 * Requests that carry congestion control credits are added
-- 
2.19.1


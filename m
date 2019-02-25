Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C20C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4491521850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130358;
	bh=ByVUQDijjR7QLHVFcAoSX0Q9cttAL1Y8wKwSkFim8yE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tcy//SyUetvIx+AGrzk2AjutPM3DVSc74qZ0KR+mFBcwCs0aapY8/9aQR0+kidokp
	 cc8OeqgMvqBnNlUtHPjkMXpMym9qCUGevvUyuOBmmy5TkAnLbrJ3Kv7NIYx/RUUgyO
	 9QTByyvs0dONt0+YW8ENHZFgFIRFggjbhs9vb1QQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732516AbfBYVch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:32:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:38178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732502AbfBYVcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:32:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFCD12184D;
        Mon, 25 Feb 2019 21:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130353;
        bh=ByVUQDijjR7QLHVFcAoSX0Q9cttAL1Y8wKwSkFim8yE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EBp/I1tQVsGKgO5kEUG5VRp9cTeye63EjMPxFhrz9LTAEhgedWooprDX26VmOhnK6
         BBf/H8r05WmWAAhKTmWTn9rOj/j5fQV11Ok3mpbO76ZkP7LUXhOA+WMa/DN4wOJtlw
         U+VtsG9xYhFxc5oYc+nWNRdlUnRpQUKqNSuKOyd0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 093/183] SUNRPC: Ensure rq_bytes_sent is reset before request transmission
Date:   Mon, 25 Feb 2019 22:11:06 +0100
Message-Id: <20190225195110.321630019@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 24cbddc44c884..2189fbc4c5704 100644
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
index 943f08be7c387..f1ec2110efebe 100644
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




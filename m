Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD685C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7358120882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548761857;
	bh=J3V2ge1SNFkjfFf833kFJLmhxbs3UgTytFlBLSRaLuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ag3uECfqJ4wAYHKMkwm2Hb7QYY5Px8vkc70w/+LIF0lXigrQIKBe/RlNdAxfNEWNy
	 KBKy9Kz0rcm88vUYFx7OYK5OGlgWrXnrzsp1ggjhH/ZOx9tPMzKJmvzT+S+tcQLVBu
	 PtWXwMNcEFxOBlYnMAbrigl9WOGnfFP3FzxEiv2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbfA2Lhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:37:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:54222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727728AbfA2Lhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:37:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B86F020882;
        Tue, 29 Jan 2019 11:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548761854;
        bh=J3V2ge1SNFkjfFf833kFJLmhxbs3UgTytFlBLSRaLuc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SQ/R3K8mTo7qzpeYZSpAx4Uaewcbgd/eq4AyEQb19v3beKkGzreb8xTicygVj1YVf
         Sn8kZQ0QgjV/q9h5cGOzvTqXOZJqNnKDIStbbUj7ZlWBqW7489Z2N5ajLQdVdyxz2k
         q6YU5zZh/EAz6gGZKAsYHtcvHqG/A2BDa8+IuJJI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 023/117] SUNRPC: Address Kerberos performance/behavior regression
Date:   Tue, 29 Jan 2019 12:34:34 +0100
Message-Id: <20190129113208.820427598@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
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

[ Upstream commit deaa5c96c2f7e8b934088a1e70a0fe8797bd1149 ]

When using Kerberos with v4.20, I've observed frequent connection
loss on heavy workloads. I traced it down to the client underrunning
the GSS sequence number window -- NFS servers are required to drop
the RPC with the low sequence number, and also drop the connection
to signal that an RPC was dropped.

Bisected to commit 918f3c1fe83c ("SUNRPC: Improve latency for
interactive tasks").

I've got a one-line workaround for this issue, which is easy to
backport to v4.20 while a more permanent solution is being derived.
Essentially, tk_owner-based sorting is disabled for RPCs that carry
a GSS sequence number.

Fixes: 918f3c1fe83c ("SUNRPC: Improve latency for interactive ... ")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sunrpc/xprt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1177,7 +1177,7 @@ xprt_request_enqueue_transmit(struct rpc
 				INIT_LIST_HEAD(&req->rq_xmit2);
 				goto out;
 			}
-		} else {
+		} else if (!req->rq_seqno) {
 			list_for_each_entry(pos, &xprt->xmit_queue, rq_xmit) {
 				if (pos->rq_task->tk_owner != task->tk_owner)
 					continue;



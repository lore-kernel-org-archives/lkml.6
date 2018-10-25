Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3B5C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818C82147A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFRth27l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 818C82147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbeJYWrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:47:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:56134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728704AbeJYWrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:47:53 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3BAE20848;
        Thu, 25 Oct 2018 14:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476897;
        bh=s8WLDJ7qM2OAUOJ9g91MXT/XYSWvOnHUBQyz9s45d9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DFRth27lykv5MsdJquy1zL7z1UARBU7aOgt8s8sUONpfMqSvIMiv+/X1ErrMDihkY
         eqZgk+o6C5AvrT+7Oj/LZuVEgISunDjZBiTWamayUxFLKydbcPOwKm9ic2filNXIbp
         gtAK5XOArttaBhvZSyxv7TQRQo35JAzHnMErug6U=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bob Peterson <rpeterso@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 21/98] tipc: Fix tipc_sk_reinit handling of -EAGAIN
Date:   Thu, 25 Oct 2018 10:13:06 -0400
Message-Id: <20181025141423.213774-21-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bob Peterson <rpeterso@redhat.com>

[ Upstream commit 6c7e983b220f89e03286dc70a41c7ef3a8b409df ]

In 9dbbfb0ab6680c6a85609041011484e6658e7d3c function tipc_sk_reinit
had additional logic added to loop in the event that function
rhashtable_walk_next() returned -EAGAIN. No worries.

However, if rhashtable_walk_start returns -EAGAIN, it does "continue",
and therefore skips the call to rhashtable_walk_stop(). That has
the effect of calling rcu_read_lock() without its paired call to
rcu_read_unlock(). Since rcu_read_lock() may be nested, the problem
may not be apparent for a while, especially since resize events may
be rare. But the comments to rhashtable_walk_start() state:

 * ...Note that we take the RCU lock in all
 * cases including when we return an error.  So you must always call
 * rhashtable_walk_stop to clean up.

This patch replaces the continue with a goto and label to ensure a
matching call to rhashtable_walk_stop().

Signed-off-by: Bob Peterson <rpeterso@redhat.com>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tipc/socket.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 25bc5c30d7fb..9d3f047305ce 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -2277,8 +2277,8 @@ void tipc_sk_reinit(struct net *net)
 
 	do {
 		tsk = ERR_PTR(rhashtable_walk_start(&iter));
-		if (tsk)
-			continue;
+		if (IS_ERR(tsk))
+			goto walk_stop;
 
 		while ((tsk = rhashtable_walk_next(&iter)) && !IS_ERR(tsk)) {
 			spin_lock_bh(&tsk->sk.sk_lock.slock);
@@ -2287,7 +2287,7 @@ void tipc_sk_reinit(struct net *net)
 			msg_set_orignode(msg, tn->own_addr);
 			spin_unlock_bh(&tsk->sk.sk_lock.slock);
 		}
-
+walk_stop:
 		rhashtable_walk_stop(&iter);
 	} while (tsk == ERR_PTR(-EAGAIN));
 }
-- 
2.17.1


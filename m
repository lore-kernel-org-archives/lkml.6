Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97E1ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9108B208A3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNS24iHX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9108B208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729845AbeKIHmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:42:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:34514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729920AbeKIHmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:42:37 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B69F208A3;
        Thu,  8 Nov 2018 22:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714707;
        bh=o54vluqQ5Fg8bJcCmiuPRN7paIhVBFw+bcLG3H6vm6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mNS24iHX7bcULiBerH3E+QUdOJO345ChrRM4NhqNkkIaj82P6lmmtNU56DjO8VGGU
         H2+GmzIo1jaUKHYQTHclwUU1nMiABDvVcP9hWnKtOq4BgGbaecz75c2NjLPu3oWroB
         AzE5R3V9y4Posymanzsbbn9SVvFW8fElBwsV3608=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 052/171] tipc: Fix tipc_sk_reinit handling of -EAGAIN
Date:   Thu,  8 Nov 2018 13:50:22 -0800
Message-Id: <20181108215131.285116345@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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




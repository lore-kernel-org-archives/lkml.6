Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A205DC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F042173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866063;
	bh=sSGDNusQdJ6gqPHaJSPYERXQV2vrAlUAUgWqKtD4yP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Cfk6CjH2ibm1ndbsv9Zqa3jmnulM6kuShZn93AfBFvfB2DV1PoLK0K0OaTn1PNsoG
	 JWp+XriYOB2kCNU/FyCxHrV7D2rHSlrcVeDjd86gC6940dRNkdvCNysbxNWEBbFyHZ
	 IpZIFgSeL7T17UFqBBmL7MqJ9uLjKAlXrY/zihhY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbfAGNBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:01:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:48460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730510AbfAGNBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:01:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36D942173C;
        Mon,  7 Jan 2019 13:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866059;
        bh=sSGDNusQdJ6gqPHaJSPYERXQV2vrAlUAUgWqKtD4yP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YHtLl4+qtIwp6F2LcBDgkQKRLmIBLRJCwq+la2IYOZXwPxbYGqyxJQiuZHoYzclq2
         /uEIuUOqEPNFE1JKdJFKkr1+4xbVCh2IPAvyteazXHnAIDIz9NJP2K6sV6frNPDD7w
         JHIMKS6DGWmyhuaw0a65Nnsf27GWrGjrW7G22x3Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Ying Xue <ying.xue@windriver.com>,
        Jon Maloy <jon.maloy@ericsson.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 031/101] tipc: use lock_sock() in tipc_sk_reinit()
Date:   Mon,  7 Jan 2019 13:32:19 +0100
Message-Id: <20190107105334.604662871@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.372621917@linuxfoundation.org>
References: <20190107105330.372621917@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit 15ef70e286176165d28b0b8a969b422561a68dfc ]

lock_sock() must be used in process context to be race-free with
other lock_sock() callers, for example, tipc_release(). Otherwise
using the spinlock directly can't serialize a parallel tipc_release().

As it is blocking, we have to hold the sock refcnt before
rhashtable_walk_stop() and release it after rhashtable_walk_start().

Fixes: 07f6c4bc048a ("tipc: convert tipc reference table to use generic rhashtable")
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Ying Xue <ying.xue@windriver.com>
Cc: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/socket.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -2261,11 +2261,15 @@ void tipc_sk_reinit(struct net *net)
 			goto walk_stop;
 
 		while ((tsk = rhashtable_walk_next(&iter)) && !IS_ERR(tsk)) {
-			spin_lock_bh(&tsk->sk.sk_lock.slock);
+			sock_hold(&tsk->sk);
+			rhashtable_walk_stop(&iter);
+			lock_sock(&tsk->sk);
 			msg = &tsk->phdr;
 			msg_set_prevnode(msg, tn->own_addr);
 			msg_set_orignode(msg, tn->own_addr);
-			spin_unlock_bh(&tsk->sk.sk_lock.slock);
+			release_sock(&tsk->sk);
+			rhashtable_walk_start(&iter);
+			sock_put(&tsk->sk);
 		}
 walk_stop:
 		rhashtable_walk_stop(&iter);



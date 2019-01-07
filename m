Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38871C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA22206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865265;
	bh=xZCAxdFRXTZ+tK3tH5w4V/S7V78r66t3yEPWX9dyOCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wxFN3K5Rga+u6UKwL2EqbjRoy9MbkY2X7X0UF0+zt+6fj5vf12WJe5x3GEFSNNrnc
	 0RxY1cXaPdwITC4nSnI0UY2FswjlGtj8D7wAb5k1SGiKoDXU90uZsM/vVXHRxw1KDs
	 XjR0maVBmthC3/SPGk8nykpHaU1EUoh+o6PjQFmw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbfAGMro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:47:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:38018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728716AbfAGMrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:47:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FD4E20651;
        Mon,  7 Jan 2019 12:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865261;
        bh=xZCAxdFRXTZ+tK3tH5w4V/S7V78r66t3yEPWX9dyOCc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RIv/IdjKjPiJmG9NdhF9GbL8PjL8DrK2EjFm2+dX2jnNuAvZ1j4dm4RfZbDuKLSy2
         HHeySuJEUR8Ls7ZYeHlXXSnOqb+S+9yDUfsG7i4gsZ03VulHmPqCuF+qrc3Teh5O/h
         RzmyiklS/LFNv/fYlDYqALpqah6QC/HkUmofw+sM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Ying Xue <ying.xue@windriver.com>,
        Jon Maloy <jon.maloy@ericsson.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 037/170] tipc: use lock_sock() in tipc_sk_reinit()
Date:   Mon,  7 Jan 2019 13:31:04 +0100
Message-Id: <20190107104457.612726267@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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
@@ -2686,11 +2686,15 @@ void tipc_sk_reinit(struct net *net)
 		rhashtable_walk_start(&iter);
 
 		while ((tsk = rhashtable_walk_next(&iter)) && !IS_ERR(tsk)) {
-			spin_lock_bh(&tsk->sk.sk_lock.slock);
+			sock_hold(&tsk->sk);
+			rhashtable_walk_stop(&iter);
+			lock_sock(&tsk->sk);
 			msg = &tsk->phdr;
 			msg_set_prevnode(msg, tipc_own_addr(net));
 			msg_set_orignode(msg, tipc_own_addr(net));
-			spin_unlock_bh(&tsk->sk.sk_lock.slock);
+			release_sock(&tsk->sk);
+			rhashtable_walk_start(&iter);
+			sock_put(&tsk->sk);
 		}
 
 		rhashtable_walk_stop(&iter);



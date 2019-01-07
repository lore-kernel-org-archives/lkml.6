Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76CCC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D29206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865283;
	bh=WRGvlTSk3f9qsQAFynU8JIsVoRIW9NdiKCBIK4yd5Lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RS9SeLT3kkexIaPgRCYLQk0iEdvjOl+xu4+ouxf04q9I9+kf92cDBUz7QOlNkKYxM
	 kzp5UlpifYadQFnX/LprkbG1+q3iT9BmeI+wHoBYecJ5Rr6IByRNBieqf9yKDrbHWI
	 qb7rZbLh7N8Ek81nf4B1RUqrcTtXfCtfGnL80UqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbfAGMsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:48:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:38474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728885AbfAGMsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:48:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AABF20859;
        Mon,  7 Jan 2019 12:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865279;
        bh=WRGvlTSk3f9qsQAFynU8JIsVoRIW9NdiKCBIK4yd5Lc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gJENBqEmYMuoLJMddjYBVunD1XQmbrEDAJsAV3ghXsK5Clge3rcKK+ariaRAy9AfC
         o5Ndvxq6YwlLgVsXADFKPxy1EaWJKwBZzeCSi3IoKaKHEf6/lCJRVFlPQGKhnAH1ac
         2d9v7iKz+egtCugy2kaArWMuBQpKN329FpmwxBpk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ying Xue <ying.xue@windriver.com>,
        Jon Maloy <jon.maloy@ericsson.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        syzbot+99f20222fc5018d2b97a@syzkaller.appspotmail.com
Subject: [PATCH 4.19 042/170] tipc: check group dests after tipc_wait_for_cond()
Date:   Mon,  7 Jan 2019 13:31:09 +0100
Message-Id: <20190107104458.216136135@linuxfoundation.org>
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

[ Upstream commit 3c6306d44082ef007a258ae1b86ea58e6974ee3f ]

Similar to commit 143ece654f9f ("tipc: check tsk->group in tipc_wait_for_cond()")
we have to reload grp->dests too after we re-take the sock lock.
This means we need to move the dsts check after tipc_wait_for_cond()
too.

Fixes: 75da2163dbb6 ("tipc: introduce communication groups")
Reported-and-tested-by: syzbot+99f20222fc5018d2b97a@syzkaller.appspotmail.com
Cc: Ying Xue <ying.xue@windriver.com>
Cc: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Acked-by: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/socket.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -1007,7 +1007,7 @@ static int tipc_send_group_bcast(struct
 	struct sock *sk = sock->sk;
 	struct net *net = sock_net(sk);
 	struct tipc_sock *tsk = tipc_sk(sk);
-	struct tipc_nlist *dsts = tipc_group_dests(tsk->group);
+	struct tipc_nlist *dsts;
 	struct tipc_mc_method *method = &tsk->mc_method;
 	bool ack = method->mandatory && method->rcast;
 	int blks = tsk_blocks(MCAST_H_SIZE + dlen);
@@ -1016,9 +1016,6 @@ static int tipc_send_group_bcast(struct
 	struct sk_buff_head pkts;
 	int rc = -EHOSTUNREACH;
 
-	if (!dsts->local && !dsts->remote)
-		return -EHOSTUNREACH;
-
 	/* Block or return if any destination link or member is congested */
 	rc = tipc_wait_for_cond(sock, &timeout,
 				!tsk->cong_link_cnt && tsk->group &&
@@ -1026,6 +1023,10 @@ static int tipc_send_group_bcast(struct
 	if (unlikely(rc))
 		return rc;
 
+	dsts = tipc_group_dests(tsk->group);
+	if (!dsts->local && !dsts->remote)
+		return -EHOSTUNREACH;
+
 	/* Complete message header */
 	if (dest) {
 		msg_set_type(hdr, TIPC_GRP_MCAST_MSG);



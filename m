Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEFAC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0763F206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865259;
	bh=S3JopAQCGQ845T2xv0GWi6bxBe6dAsZGwCAs3OXysmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s3RdJMBfskyhqaKitF9i9NmTlgHTqNg4o4BY9NMSCmEZvNJmzd/UleIMBmRD3sw9X
	 h46yPQ8eBBzvNXc2dajAx+7bfduIpI1/ltvquxuxU8T6VygB8KLOXLRWd9+SpfodPR
	 bL1Hz6X0xawc3HhxSIoi8u5Q1aCq0NqVUBO2qN1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbfAGMri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:47:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:37686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728047AbfAGMr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:47:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28476206BB;
        Mon,  7 Jan 2019 12:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865247;
        bh=S3JopAQCGQ845T2xv0GWi6bxBe6dAsZGwCAs3OXysmQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oBe91+5WLmjzbZzqxrKUSxd3wKTCGMnmyM7JIGmmRA0dQuktL7xGXu8rPZcP7s2wE
         EPP8SxaAmMFiioW7/54Tvv9EU1mWMhZ9W2aATBrU97JtTcsxEGOfAsa5HkAvssuZUv
         Ql9y26BmYJNOlTjL3moQ8paErf8X5EyA3I9DNu4A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+10a9db47c3a0e13eb31c@syzkaller.appspotmail.com,
        Ying Xue <ying.xue@windriver.com>,
        Jon Maloy <jon.maloy@ericsson.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 033/170] tipc: check tsk->group in tipc_wait_for_cond()
Date:   Mon,  7 Jan 2019 13:31:00 +0100
Message-Id: <20190107104457.113585261@linuxfoundation.org>
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

[ Upstream commit 143ece654f9f5b37bedea252a990be37e48ae3a5 ]

tipc_wait_for_cond() drops socket lock before going to sleep,
but tsk->group could be freed right after that release_sock().
So we have to re-check and reload tsk->group after it wakes up.

After this patch, tipc_wait_for_cond() returns -ERESTARTSYS when
tsk->group is NULL, instead of continuing with the assumption of
a non-NULL tsk->group.

(It looks like 'dsts' should be re-checked and reloaded too, but
it is a different bug.)

Similar for tipc_send_group_unicast() and tipc_send_group_anycast().

Reported-by: syzbot+10a9db47c3a0e13eb31c@syzkaller.appspotmail.com
Fixes: b7d42635517f ("tipc: introduce flow control for group broadcast messages")
Fixes: ee106d7f942d ("tipc: introduce group anycast messaging")
Fixes: 27bd9ec027f3 ("tipc: introduce group unicast messaging")
Cc: Ying Xue <ying.xue@windriver.com>
Cc: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Acked-by: Ying Xue <ying.xue@windriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/socket.c |   25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -878,7 +878,6 @@ static int tipc_send_group_unicast(struc
 	DECLARE_SOCKADDR(struct sockaddr_tipc *, dest, m->msg_name);
 	int blks = tsk_blocks(GROUP_H_SIZE + dlen);
 	struct tipc_sock *tsk = tipc_sk(sk);
-	struct tipc_group *grp = tsk->group;
 	struct net *net = sock_net(sk);
 	struct tipc_member *mb = NULL;
 	u32 node, port;
@@ -892,7 +891,9 @@ static int tipc_send_group_unicast(struc
 	/* Block or return if destination link or member is congested */
 	rc = tipc_wait_for_cond(sock, &timeout,
 				!tipc_dest_find(&tsk->cong_links, node, 0) &&
-				!tipc_group_cong(grp, node, port, blks, &mb));
+				tsk->group &&
+				!tipc_group_cong(tsk->group, node, port, blks,
+						 &mb));
 	if (unlikely(rc))
 		return rc;
 
@@ -922,7 +923,6 @@ static int tipc_send_group_anycast(struc
 	struct tipc_sock *tsk = tipc_sk(sk);
 	struct list_head *cong_links = &tsk->cong_links;
 	int blks = tsk_blocks(GROUP_H_SIZE + dlen);
-	struct tipc_group *grp = tsk->group;
 	struct tipc_msg *hdr = &tsk->phdr;
 	struct tipc_member *first = NULL;
 	struct tipc_member *mbr = NULL;
@@ -939,9 +939,10 @@ static int tipc_send_group_anycast(struc
 	type = msg_nametype(hdr);
 	inst = dest->addr.name.name.instance;
 	scope = msg_lookup_scope(hdr);
-	exclude = tipc_group_exclude(grp);
 
 	while (++lookups < 4) {
+		exclude = tipc_group_exclude(tsk->group);
+
 		first = NULL;
 
 		/* Look for a non-congested destination member, if any */
@@ -950,7 +951,8 @@ static int tipc_send_group_anycast(struc
 						 &dstcnt, exclude, false))
 				return -EHOSTUNREACH;
 			tipc_dest_pop(&dsts, &node, &port);
-			cong = tipc_group_cong(grp, node, port, blks, &mbr);
+			cong = tipc_group_cong(tsk->group, node, port, blks,
+					       &mbr);
 			if (!cong)
 				break;
 			if (mbr == first)
@@ -969,7 +971,8 @@ static int tipc_send_group_anycast(struc
 		/* Block or return if destination link or member is congested */
 		rc = tipc_wait_for_cond(sock, &timeout,
 					!tipc_dest_find(cong_links, node, 0) &&
-					!tipc_group_cong(grp, node, port,
+					tsk->group &&
+					!tipc_group_cong(tsk->group, node, port,
 							 blks, &mbr));
 		if (unlikely(rc))
 			return rc;
@@ -1004,8 +1007,7 @@ static int tipc_send_group_bcast(struct
 	struct sock *sk = sock->sk;
 	struct net *net = sock_net(sk);
 	struct tipc_sock *tsk = tipc_sk(sk);
-	struct tipc_group *grp = tsk->group;
-	struct tipc_nlist *dsts = tipc_group_dests(grp);
+	struct tipc_nlist *dsts = tipc_group_dests(tsk->group);
 	struct tipc_mc_method *method = &tsk->mc_method;
 	bool ack = method->mandatory && method->rcast;
 	int blks = tsk_blocks(MCAST_H_SIZE + dlen);
@@ -1018,8 +1020,9 @@ static int tipc_send_group_bcast(struct
 		return -EHOSTUNREACH;
 
 	/* Block or return if any destination link or member is congested */
-	rc = tipc_wait_for_cond(sock, &timeout,	!tsk->cong_link_cnt &&
-				!tipc_group_bc_cong(grp, blks));
+	rc = tipc_wait_for_cond(sock, &timeout,
+				!tsk->cong_link_cnt && tsk->group &&
+				!tipc_group_bc_cong(tsk->group, blks));
 	if (unlikely(rc))
 		return rc;
 
@@ -1034,7 +1037,7 @@ static int tipc_send_group_bcast(struct
 	msg_set_hdr_sz(hdr, GROUP_H_SIZE);
 	msg_set_destport(hdr, 0);
 	msg_set_destnode(hdr, 0);
-	msg_set_grp_bc_seqno(hdr, tipc_group_bc_snd_nxt(grp));
+	msg_set_grp_bc_seqno(hdr, tipc_group_bc_snd_nxt(tsk->group));
 
 	/* Avoid getting stuck with repeated forced replicasts */
 	msg_set_grp_bc_ack_req(hdr, ack);



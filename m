Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADD4C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44965214C2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIUQYJUp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44965214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731301AbeJICAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:00:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727510AbeJICAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:00:02 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A0C1214C4;
        Mon,  8 Oct 2018 18:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024415;
        bh=mz5Oj37bW0scKBhuyv2gb9WurdR167rGU8PUVRa2u2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PIUQYJUpAMuImoNvSDeAh46/9TBJJqNtwgPf9CPy4JdSu2Q6K01WH/yYVIIz6XK0G
         0jyg5VrvPq/fqImvKWbuzBFMbt/kb/Ox9j1lhj9dJBYbhtt6Zr9p7gx4iILluDXeSN
         4ONnyxYx9yMZ2x73PdEq3ZGcQO75iJDNbe6gviNc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+b9c8f3ab2994b7cd1625@syzkaller.appspotmail.com,
        Jon Maloy <jon.maloy@ericsson.com>,
        Ying Xue <ying.xue@windriver.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 031/168] tipc: switch to rhashtable iterator
Date:   Mon,  8 Oct 2018 20:30:11 +0200
Message-Id: <20181008175621.229680961@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit 9a07efa9aea2f4a59f35da0785a4e6a6b5a96192 ]

syzbot reported a use-after-free in tipc_group_fill_sock_diag(),
where tipc_group_fill_sock_diag() still reads tsk->group meanwhile
tipc_group_delete() just deletes it in tipc_release().

tipc_nl_sk_walk() aims to lock this sock when walking each sock
in the hash table to close race conditions with sock changes like
this one, by acquiring tsk->sk.sk_lock.slock spinlock, unfortunately
this doesn't work at all. All non-BH call path should take
lock_sock() instead to make it work.

tipc_nl_sk_walk() brutally iterates with raw rht_for_each_entry_rcu()
where RCU read lock is required, this is the reason why lock_sock()
can't be taken on this path. This could be resolved by switching to
rhashtable iterator API's, where taking a sleepable lock is possible.
Also, the iterator API's are friendly for restartable calls like
diag dump, the last position is remembered behind the scence,
all we need to do here is saving the iterator into cb->args[].

I tested this with parallel tipc diag dump and thousands of tipc
socket creation and release, no crash or memory leak.

Reported-by: syzbot+b9c8f3ab2994b7cd1625@syzkaller.appspotmail.com
Cc: Jon Maloy <jon.maloy@ericsson.com>
Cc: Ying Xue <ying.xue@windriver.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/diag.c    |    2 +
 net/tipc/netlink.c |    2 +
 net/tipc/socket.c  |   76 ++++++++++++++++++++++++++++++++++-------------------
 net/tipc/socket.h  |    2 +
 4 files changed, 56 insertions(+), 26 deletions(-)

--- a/net/tipc/diag.c
+++ b/net/tipc/diag.c
@@ -84,7 +84,9 @@ static int tipc_sock_diag_handler_dump(s
 
 	if (h->nlmsg_flags & NLM_F_DUMP) {
 		struct netlink_dump_control c = {
+			.start = tipc_dump_start,
 			.dump = tipc_diag_dump,
+			.done = tipc_dump_done,
 		};
 		netlink_dump_start(net->diag_nlsk, skb, h, &c);
 		return 0;
--- a/net/tipc/netlink.c
+++ b/net/tipc/netlink.c
@@ -167,7 +167,9 @@ static const struct genl_ops tipc_genl_v
 	},
 	{
 		.cmd	= TIPC_NL_SOCK_GET,
+		.start = tipc_dump_start,
 		.dumpit	= tipc_nl_sk_dump,
+		.done	= tipc_dump_done,
 		.policy = tipc_nl_policy,
 	},
 	{
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -3233,45 +3233,69 @@ int tipc_nl_sk_walk(struct sk_buff *skb,
 				       struct netlink_callback *cb,
 				       struct tipc_sock *tsk))
 {
-	struct net *net = sock_net(skb->sk);
-	struct tipc_net *tn = tipc_net(net);
-	const struct bucket_table *tbl;
-	u32 prev_portid = cb->args[1];
-	u32 tbl_id = cb->args[0];
-	struct rhash_head *pos;
+	struct rhashtable_iter *iter = (void *)cb->args[0];
 	struct tipc_sock *tsk;
 	int err;
 
-	rcu_read_lock();
-	tbl = rht_dereference_rcu((&tn->sk_rht)->tbl, &tn->sk_rht);
-	for (; tbl_id < tbl->size; tbl_id++) {
-		rht_for_each_entry_rcu(tsk, pos, tbl, tbl_id, node) {
-			spin_lock_bh(&tsk->sk.sk_lock.slock);
-			if (prev_portid && prev_portid != tsk->portid) {
-				spin_unlock_bh(&tsk->sk.sk_lock.slock);
+	rhashtable_walk_start(iter);
+	while ((tsk = rhashtable_walk_next(iter)) != NULL) {
+		if (IS_ERR(tsk)) {
+			err = PTR_ERR(tsk);
+			if (err == -EAGAIN) {
+				err = 0;
 				continue;
 			}
+			break;
+		}
 
-			err = skb_handler(skb, cb, tsk);
-			if (err) {
-				prev_portid = tsk->portid;
-				spin_unlock_bh(&tsk->sk.sk_lock.slock);
-				goto out;
-			}
-
-			prev_portid = 0;
-			spin_unlock_bh(&tsk->sk.sk_lock.slock);
+		sock_hold(&tsk->sk);
+		rhashtable_walk_stop(iter);
+		lock_sock(&tsk->sk);
+		err = skb_handler(skb, cb, tsk);
+		if (err) {
+			release_sock(&tsk->sk);
+			sock_put(&tsk->sk);
+			goto out;
 		}
+		release_sock(&tsk->sk);
+		rhashtable_walk_start(iter);
+		sock_put(&tsk->sk);
 	}
+	rhashtable_walk_stop(iter);
 out:
-	rcu_read_unlock();
-	cb->args[0] = tbl_id;
-	cb->args[1] = prev_portid;
-
 	return skb->len;
 }
 EXPORT_SYMBOL(tipc_nl_sk_walk);
 
+int tipc_dump_start(struct netlink_callback *cb)
+{
+	struct rhashtable_iter *iter = (void *)cb->args[0];
+	struct net *net = sock_net(cb->skb->sk);
+	struct tipc_net *tn = tipc_net(net);
+
+	if (!iter) {
+		iter = kmalloc(sizeof(*iter), GFP_KERNEL);
+		if (!iter)
+			return -ENOMEM;
+
+		cb->args[0] = (long)iter;
+	}
+
+	rhashtable_walk_enter(&tn->sk_rht, iter);
+	return 0;
+}
+EXPORT_SYMBOL(tipc_dump_start);
+
+int tipc_dump_done(struct netlink_callback *cb)
+{
+	struct rhashtable_iter *hti = (void *)cb->args[0];
+
+	rhashtable_walk_exit(hti);
+	kfree(hti);
+	return 0;
+}
+EXPORT_SYMBOL(tipc_dump_done);
+
 int tipc_sk_fill_sock_diag(struct sk_buff *skb, struct netlink_callback *cb,
 			   struct tipc_sock *tsk, u32 sk_filter_state,
 			   u64 (*tipc_diag_gen_cookie)(struct sock *sk))
--- a/net/tipc/socket.h
+++ b/net/tipc/socket.h
@@ -68,4 +68,6 @@ int tipc_nl_sk_walk(struct sk_buff *skb,
 		    int (*skb_handler)(struct sk_buff *skb,
 				       struct netlink_callback *cb,
 				       struct tipc_sock *tsk));
+int tipc_dump_start(struct netlink_callback *cb);
+int tipc_dump_done(struct netlink_callback *cb);
 #endif



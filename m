Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE28C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D7521470
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="asC2O+OP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D7521470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732220AbeJKXQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:16:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:50718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731315AbeJKXQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:16:45 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A890921477;
        Thu, 11 Oct 2018 15:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272939;
        bh=NDe3QPncw/y/mvZru5feYqEhYNV2uHxmWaCrtfQswak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=asC2O+OPuFQyAYmPyvLl5HOCLrEezTHegNmXbR/IPisR20yKr1mQCmAKWpo5SENq0
         42/C4+sv8dBMkGnyd4wE6j0zGjhor67xO3v61lNS6NTjCxpj09Xj7G9fIJpQeA2l1u
         mbYPu8ovF4OXzXbFL6rfrm0MG6fN1rqbY6Lt/BOE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Maloy <jon.maloy@ericsson.com>,
        Ying Xue <ying.xue@windriver.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 40/44] tipc: call start and done ops directly in __tipc_nl_compat_dumpit()
Date:   Thu, 11 Oct 2018 17:40:18 +0200
Message-Id: <20181011152454.213513083@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152452.571669983@linuxfoundation.org>
References: <20181011152452.571669983@linuxfoundation.org>
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

commit 8f5c5fcf353302374b36232d6885c1a3b579e5ca upstream.

__tipc_nl_compat_dumpit() uses a netlink_callback on stack,
so the only way to align it with other ->dumpit() call path
is calling tipc_dump_start() and tipc_dump_done() directly
inside it. Otherwise ->dumpit() would always get NULL from
cb->args[].

But tipc_dump_start() uses sock_net(cb->skb->sk) to retrieve
net pointer, the cb->skb here doesn't set skb->sk, the net pointer
is saved in msg->net instead, so introduce a helper function
__tipc_dump_start() to pass in msg->net.

Ying pointed out cb->args[0...3] are already used by other
callbacks on this call path, so we can't use cb->args[0] any
more, use cb->args[4] instead.

Fixes: 9a07efa9aea2 ("tipc: switch to rhashtable iterator")
Reported-and-tested-by: syzbot+e93a2c41f91b8e2c7d9b@syzkaller.appspotmail.com
Cc: Jon Maloy <jon.maloy@ericsson.com>
Cc: Ying Xue <ying.xue@windriver.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Acked-by: Ying Xue <ying.xue@windriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/tipc/netlink_compat.c |    2 ++
 net/tipc/socket.c         |   17 +++++++++++------
 net/tipc/socket.h         |    1 +
 3 files changed, 14 insertions(+), 6 deletions(-)

--- a/net/tipc/netlink_compat.c
+++ b/net/tipc/netlink_compat.c
@@ -185,6 +185,7 @@ static int __tipc_nl_compat_dumpit(struc
 		return -ENOMEM;
 
 	buf->sk = msg->dst_sk;
+	__tipc_dump_start(&cb, msg->net);
 
 	do {
 		int rem;
@@ -216,6 +217,7 @@ static int __tipc_nl_compat_dumpit(struc
 	err = 0;
 
 err_out:
+	tipc_dump_done(&cb);
 	kfree_skb(buf);
 
 	if (err == -EMSGSIZE) {
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -3233,7 +3233,7 @@ int tipc_nl_sk_walk(struct sk_buff *skb,
 				       struct netlink_callback *cb,
 				       struct tipc_sock *tsk))
 {
-	struct rhashtable_iter *iter = (void *)cb->args[0];
+	struct rhashtable_iter *iter = (void *)cb->args[4];
 	struct tipc_sock *tsk;
 	int err;
 
@@ -3269,8 +3269,14 @@ EXPORT_SYMBOL(tipc_nl_sk_walk);
 
 int tipc_dump_start(struct netlink_callback *cb)
 {
-	struct rhashtable_iter *iter = (void *)cb->args[0];
-	struct net *net = sock_net(cb->skb->sk);
+	return __tipc_dump_start(cb, sock_net(cb->skb->sk));
+}
+EXPORT_SYMBOL(tipc_dump_start);
+
+int __tipc_dump_start(struct netlink_callback *cb, struct net *net)
+{
+	/* tipc_nl_name_table_dump() uses cb->args[0...3]. */
+	struct rhashtable_iter *iter = (void *)cb->args[4];
 	struct tipc_net *tn = tipc_net(net);
 
 	if (!iter) {
@@ -3278,17 +3284,16 @@ int tipc_dump_start(struct netlink_callb
 		if (!iter)
 			return -ENOMEM;
 
-		cb->args[0] = (long)iter;
+		cb->args[4] = (long)iter;
 	}
 
 	rhashtable_walk_enter(&tn->sk_rht, iter);
 	return 0;
 }
-EXPORT_SYMBOL(tipc_dump_start);
 
 int tipc_dump_done(struct netlink_callback *cb)
 {
-	struct rhashtable_iter *hti = (void *)cb->args[0];
+	struct rhashtable_iter *hti = (void *)cb->args[4];
 
 	rhashtable_walk_exit(hti);
 	kfree(hti);
--- a/net/tipc/socket.h
+++ b/net/tipc/socket.h
@@ -69,5 +69,6 @@ int tipc_nl_sk_walk(struct sk_buff *skb,
 				       struct netlink_callback *cb,
 				       struct tipc_sock *tsk));
 int tipc_dump_start(struct netlink_callback *cb);
+int __tipc_dump_start(struct netlink_callback *cb, struct net *net);
 int tipc_dump_done(struct netlink_callback *cb);
 #endif



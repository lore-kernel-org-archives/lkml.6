Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E126BC2F3D5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B17FF20861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548080321;
	bh=glmkLuowO4r7MilHL/ar7HO/aQye/g1hqeylnZ401zM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X7+o7WNtOqEcfpfgGAGTyqN+vOlPCyyk/4TJooIgo2OW2N9rymZyZcB6epeF7kJI6
	 VRHb2HA5WEtBgsuKkD84nFtLzgzwrFaRmsm4XumT14257luDlcZHqiVu3pA0giN608
	 feWPyvDhcUodLqGbmP6t+IYEvz0Yd1XMQO1o3w7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbfAUOSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:18:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:60060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730235AbfAUNt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:49:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57B192087F;
        Mon, 21 Jan 2019 13:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078566;
        bh=glmkLuowO4r7MilHL/ar7HO/aQye/g1hqeylnZ401zM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sy/JxgmlacMuDxBxEpWL/BI5qlOIYk0NgHRpcIoouyBpzWBukDCfzns5uh/m6IG9D
         yas2Pt5os9+LQJ8DoWWJz2PlSKu1y0IR/LuP35lbA2zWN75F0VczKxkf/vomQJs0KT
         xi5H43qBNATe37SoLTK0VNoUbB0HHo8W27ZJ9Ktc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Piotr Sawicki <p.sawicki2@partner.samsung.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        syzbot <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 076/111] ipv6: make icmp6_send() robust against null skb->dev
Date:   Mon, 21 Jan 2019 14:43:10 +0100
Message-Id: <20190121122504.802512921@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

commit 8d933670452107e41165bea70a30dffbd281bef1 upstream.

syzbot was able to crash one host with the following stack trace :

kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 8625 Comm: syz-executor4 Not tainted 4.20.0+ #8
RIP: 0010:dev_net include/linux/netdevice.h:2169 [inline]
RIP: 0010:icmp6_send+0x116/0x2d30 net/ipv6/icmp.c:426
 icmpv6_send
 smack_socket_sock_rcv_skb
 security_sock_rcv_skb
 sk_filter_trim_cap
 __sk_receive_skb
 dccp_v6_do_rcv
 release_sock

This is because a RX packet found socket owned by user and
was stored into socket backlog. Before leaving RCU protected section,
skb->dev was cleared in __sk_receive_skb(). When socket backlog
was finally handled at release_sock() time, skb was fed to
smack_socket_sock_rcv_skb() then icmp6_send()

We could fix the bug in smack_socket_sock_rcv_skb(), or simply
make icmp6_send() more robust against such possibility.

In the future we might provide to icmp6_send() the net pointer
instead of infering it.

Fixes: d66a8acbda92 ("Smack: Inform peer that IPv6 traffic has been blocked")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Piotr Sawicki <p.sawicki2@partner.samsung.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Acked-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv6/icmp.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -421,10 +421,10 @@ static int icmp6_iif(const struct sk_buf
 static void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
 		       const struct in6_addr *force_saddr)
 {
-	struct net *net = dev_net(skb->dev);
 	struct inet6_dev *idev = NULL;
 	struct ipv6hdr *hdr = ipv6_hdr(skb);
 	struct sock *sk;
+	struct net *net;
 	struct ipv6_pinfo *np;
 	const struct in6_addr *saddr = NULL;
 	struct dst_entry *dst;
@@ -435,12 +435,16 @@ static void icmp6_send(struct sk_buff *s
 	int iif = 0;
 	int addr_type = 0;
 	int len;
-	u32 mark = IP6_REPLY_MARK(net, skb->mark);
+	u32 mark;
 
 	if ((u8 *)hdr < skb->head ||
 	    (skb_network_header(skb) + sizeof(*hdr)) > skb_tail_pointer(skb))
 		return;
 
+	if (!skb->dev)
+		return;
+	net = dev_net(skb->dev);
+	mark = IP6_REPLY_MARK(net, skb->mark);
 	/*
 	 *	Make sure we respect the rules
 	 *	i.e. RFC 1885 2.4(e)



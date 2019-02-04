Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E070DC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1EFF2075B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549276815;
	bh=20ymTtmY//YfJe8bCukmbRfQOq0OKsy/5HXrG4YdXyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Dal2csMtyxb/WiKxFn29kyHXgxyYiNqeIo6+gqq/9f94aV3ilKuuWPKC31DroekoH
	 y1vbhDNktX+vBT72H/46EsW/PkHIUjSZbB84n1OiiRmfG5zxuzXBPYUFbKM3hhG5ql
	 3Md4tygmxxcTsgaUD2nfWOxUX8cES6KoaQM3iQEI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbfBDKkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:40:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:38122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728433AbfBDKkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:40:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B20E32070C;
        Mon,  4 Feb 2019 10:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549276809;
        bh=20ymTtmY//YfJe8bCukmbRfQOq0OKsy/5HXrG4YdXyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=goDfRTyecaIz6jGvWCOrQGOYJrWu2VjG6VE0neZ2YEU83/fuHq2wiEvjo5Kq4TkAf
         0Ed2y5PILup8CaJnco3PjiDTjxMNTkEYnwzi4aSXvIF51kLwKcMLnpjNElvgmVpxzl
         cyg9aRC+q9I6WlrKwK5v52Vfe4EbObpNwdZPBxjA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, bridge@lists.linux-foundation.org,
        Nkolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Yunjian Wang <wangyunjian@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 05/65] net: bridge: Fix ethernet header pointer before check skb forwardable
Date:   Mon,  4 Feb 2019 11:35:58 +0100
Message-Id: <20190204103611.451902141@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103610.583715954@linuxfoundation.org>
References: <20190204103610.583715954@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yunjian Wang <wangyunjian@huawei.com>

[ Upstream commit 28c1382fa28f2e2d9d0d6f25ae879b5af2ecbd03 ]

The skb header should be set to ethernet header before using
is_skb_forwardable. Because the ethernet header length has been
considered in is_skb_forwardable(including dev->hard_header_len
length).

To reproduce the issue:
1, add 2 ports on linux bridge br using following commands:
$ brctl addbr br
$ brctl addif br eth0
$ brctl addif br eth1
2, the MTU of eth0 and eth1 is 1500
3, send a packet(Data 1480, UDP 8, IP 20, Ethernet 14, VLAN 4)
from eth0 to eth1

So the expect result is packet larger than 1500 cannot pass through
eth0 and eth1. But currently, the packet passes through success, it
means eth1's MTU limit doesn't take effect.

Fixes: f6367b4660dd ("bridge: use is_skb_forwardable in forward path")
Cc: bridge@lists.linux-foundation.org
Cc: Nkolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: Roopa Prabhu <roopa@cumulusnetworks.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bridge/br_forward.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -39,10 +39,10 @@ static inline int should_deliver(const s
 
 int br_dev_queue_push_xmit(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
+	skb_push(skb, ETH_HLEN);
 	if (!is_skb_forwardable(skb->dev, skb))
 		goto drop;
 
-	skb_push(skb, ETH_HLEN);
 	br_drop_fake_rtable(skb);
 	skb_sender_cpu_clear(skb);
 
@@ -88,12 +88,11 @@ static void __br_deliver(const struct ne
 	skb->dev = to->dev;
 
 	if (unlikely(netpoll_tx_running(to->br->dev))) {
+		skb_push(skb, ETH_HLEN);
 		if (!is_skb_forwardable(skb->dev, skb))
 			kfree_skb(skb);
-		else {
-			skb_push(skb, ETH_HLEN);
+		else
 			br_netpoll_send_skb(to, skb);
-		}
 		return;
 	}
 



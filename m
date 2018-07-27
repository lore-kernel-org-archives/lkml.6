Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7171C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA992089E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:10:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DA992089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388977AbeG0Lbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:31:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36550 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729431AbeG0Lbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:31:41 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 26084CB8;
        Fri, 27 Jul 2018 10:10:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 03/33] ip: hash fragments consistently
Date:   Fri, 27 Jul 2018 12:08:44 +0200
Message-Id: <20180727100827.792720769@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727100827.665729981@linuxfoundation.org>
References: <20180727100827.665729981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 3dd1c9a1270736029ffca670e9bd0265f4120600 ]

The skb hash for locally generated ip[v6] fragments belonging
to the same datagram can vary in several circumstances:
* for connected UDP[v6] sockets, the first fragment get its hash
  via set_owner_w()/skb_set_hash_from_sk()
* for unconnected IPv6 UDPv6 sockets, the first fragment can get
  its hash via ip6_make_flowlabel()/skb_get_hash_flowi6(), if
  auto_flowlabel is enabled

For the following frags the hash is usually computed via
skb_get_hash().
The above can cause OoO for unconnected IPv6 UDPv6 socket: in that
scenario the egress tx queue can be selected on a per packet basis
via the skb hash.
It may also fool flow-oriented schedulers to place fragments belonging
to the same datagram in different flows.

Fix the issue by copying the skb hash from the head frag into
the others at fragmentation time.

Before this commit:
perf probe -a "dev_queue_xmit skb skb->hash skb->l4_hash:b1@0/8 skb->sw_hash:b1@1/8"
netperf -H $IPV4 -t UDP_STREAM -l 5 -- -m 2000 -n &
perf record -e probe:dev_queue_xmit -e probe:skb_set_owner_w -a sleep 0.1
perf script
probe:dev_queue_xmit: (ffffffff8c6b1b20) hash=3713014309 l4_hash=1 sw_hash=0
probe:dev_queue_xmit: (ffffffff8c6b1b20) hash=0 l4_hash=0 sw_hash=0

After this commit:
probe:dev_queue_xmit: (ffffffff8c6b1b20) hash=2171763177 l4_hash=1 sw_hash=0
probe:dev_queue_xmit: (ffffffff8c6b1b20) hash=2171763177 l4_hash=1 sw_hash=0

Fixes: b73c3d0e4f0e ("net: Save TX flow hash in sock and set in skbuf on xmit")
Fixes: 67800f9b1f4e ("ipv6: Call skb_get_hash_flowi6 to get skb->hash in ip6_make_flowlabel")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_output.c  |    2 ++
 net/ipv6/ip6_output.c |    2 ++
 2 files changed, 4 insertions(+)

--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -497,6 +497,8 @@ static void ip_copy_metadata(struct sk_b
 	to->dev = from->dev;
 	to->mark = from->mark;
 
+	skb_copy_hash(to, from);
+
 	/* Copy the flags to each fragment. */
 	IPCB(to)->flags = IPCB(from)->flags;
 
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -576,6 +576,8 @@ static void ip6_copy_metadata(struct sk_
 	to->dev = from->dev;
 	to->mark = from->mark;
 
+	skb_copy_hash(to, from);
+
 #ifdef CONFIG_NET_SCHED
 	to->tc_index = from->tc_index;
 #endif



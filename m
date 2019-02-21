Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D531AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A12AA20700
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550760480;
	bh=hW9BE+LklFStiTvdHUtMWhUAnqoyis0FJjQ+SjW2QXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dtZ2OR8He4pLNHiK3ss6XFTOQWPvo5Ew5EZaj4Hzw+t9JciBEzVTiuQEF33YMb7el
	 QLQ2Vl/6kPgF/OHb5E+VFWKTeIzf7gMrNfFQhnzOkgAHqEB+rfR6k6xStCXaRd9e2S
	 D5sV2fORmEcZJzCx7JJ+YOrkxKgI/YuvQ+DCN7xk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbfBUOku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:40:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:35454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729186AbfBUOkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:40:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 985B12084F;
        Thu, 21 Feb 2019 14:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550760045;
        bh=hW9BE+LklFStiTvdHUtMWhUAnqoyis0FJjQ+SjW2QXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q3hQecrPIT8vSu1iG0GerENVcjZFT5RAaCYIVfSSzBIGxBWmqU/GbVrm52JiHIgEh
         J8stLy+vQjTFgoTXGOUW73vXhZgxA1cZfA33fGYG9XjtAu7GPTU0YNbVbfZxGuBBSI
         4ApCh+3Rq8xMwgdkLnhvzRBmnY0zOMGjJGCZc6/Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
        Maxim Mikityanskiy <maximmi@mellanox.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 01/30] af_packet: fix raw sockets over 6in4 tunnel
Date:   Thu, 21 Feb 2019 15:35:43 +0100
Message-Id: <20190221125250.618298270@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221125250.543158526@linuxfoundation.org>
References: <20190221125250.543158526@linuxfoundation.org>
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

[ Upstream commit 88a8121dc1d3d0dbddd411b79ed236b6b6ea415c ]

Since commit cb9f1b783850, scapy (which uses an AF_PACKET socket in
SOCK_RAW mode) is unable to send a basic icmp packet over a sit tunnel:

Here is a example of the setup:
$ ip link set ntfp2 up
$ ip addr add 10.125.0.1/24 dev ntfp2
$ ip tunnel add tun1 mode sit ttl 64 local 10.125.0.1 remote 10.125.0.2 dev ntfp2
$ ip addr add fd00:cafe:cafe::1/128 dev tun1
$ ip link set dev tun1 up
$ ip route add fd00:200::/64 dev tun1
$ scapy
>>> p = []
>>> p += IPv6(src='fd00:100::1', dst='fd00:200::1')/ICMPv6EchoRequest()
>>> send(p, count=1, inter=0.1)
>>> quit()
$ ip -s link ls dev tun1 | grep -A1 "TX.*errors"
    TX: bytes  packets  errors  dropped carrier collsns
    0          0        1       0       0       0

The problem is that the network offset is set to the hard_header_len of the
output device (tun1, ie 14 + 20) and in our case, because the packet is
small (48 bytes) the pskb_inet_may_pull() fails (it tries to pull 40 bytes
(ipv6 header) starting from the network offset).

This problem is more generally related to device with variable hard header
length. To avoid a too intrusive patch in the current release, a (ugly)
workaround is proposed in this patch. It has to be cleaned up in net-next.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=993675a3100b1
Link: http://patchwork.ozlabs.org/patch/1024489/
Fixes: cb9f1b783850 ("ip: validate header length on virtual device xmit")
CC: Willem de Bruijn <willemb@google.com>
CC: Maxim Mikityanskiy <maximmi@mellanox.com>
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Acked-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/packet/af_packet.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index b6ea0fadb34fa..c76c21604ffd9 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2887,7 +2887,8 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 			goto out_free;
 	} else if (reserve) {
 		skb_reserve(skb, -reserve);
-		if (len < reserve)
+		if (len < reserve + sizeof(struct ipv6hdr) &&
+		    dev->min_header_len != dev->hard_header_len)
 			skb_reset_network_header(skb);
 	}
 
-- 
2.19.1




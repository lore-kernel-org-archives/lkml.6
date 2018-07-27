Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F904C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D5BB20895
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D5BB20895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388889AbeG0LKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:10:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52794 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731277AbeG0LKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:10:25 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DC057AF8;
        Fri, 27 Jul 2018 09:49:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 34/66] net/ipv6: Fix linklocal to global address with VRF
Date:   Fri, 27 Jul 2018 11:45:27 +0200
Message-Id: <20180727093812.960566568@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727093809.043856530@linuxfoundation.org>
References: <20180727093809.043856530@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Ahern <dsahern@gmail.com>

[ Upstream commit 24b711edfc34bc45777a3f068812b7d1ed004a5d ]

Example setup:
    host: ip -6 addr add dev eth1 2001:db8:104::4
           where eth1 is enslaved to a VRF

    switch: ip -6 ro add 2001:db8:104::4/128 dev br1
            where br1 only has an LLA

           ping6 2001:db8:104::4
           ssh   2001:db8:104::4

(NOTE: UDP works fine if the PKTINFO has the address set to the global
address and ifindex is set to the index of eth1 with a destination an
LLA).

For ICMP, icmp6_iif needs to be updated to check if skb->dev is an
L3 master. If it is then return the ifindex from rt6i_idev similar
to what is done for loopback.

For TCP, restore the original tcp_v6_iif definition which is needed in
most places and add a new tcp_v6_iif_l3_slave that considers the
l3_slave variability. This latter check is only needed for socket
lookups.

Fixes: 9ff74384600a ("net: vrf: Handle ipv6 multicast and link-local addresses")
Signed-off-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/tcp.h   |    5 +++++
 net/ipv6/icmp.c     |    5 +++--
 net/ipv6/tcp_ipv6.c |    6 ++++--
 3 files changed, 12 insertions(+), 4 deletions(-)

--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -829,6 +829,11 @@ struct tcp_skb_cb {
  */
 static inline int tcp_v6_iif(const struct sk_buff *skb)
 {
+	return TCP_SKB_CB(skb)->header.h6.iif;
+}
+
+static inline int tcp_v6_iif_l3_slave(const struct sk_buff *skb)
+{
 	bool l3_slave = ipv6_l3mdev_skb(TCP_SKB_CB(skb)->header.h6.flags);
 
 	return l3_slave ? skb->skb_iif : TCP_SKB_CB(skb)->header.h6.iif;
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -402,9 +402,10 @@ static int icmp6_iif(const struct sk_buf
 
 	/* for local traffic to local address, skb dev is the loopback
 	 * device. Check if there is a dst attached to the skb and if so
-	 * get the real device index.
+	 * get the real device index. Same is needed for replies to a link
+	 * local address on a device enslaved to an L3 master device
 	 */
-	if (unlikely(iif == LOOPBACK_IFINDEX)) {
+	if (unlikely(iif == LOOPBACK_IFINDEX || netif_is_l3_master(skb->dev))) {
 		const struct rt6_info *rt6 = skb_rt6_info(skb);
 
 		if (rt6)
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -934,7 +934,8 @@ static void tcp_v6_send_reset(const stru
 					   &tcp_hashinfo, NULL, 0,
 					   &ipv6h->saddr,
 					   th->source, &ipv6h->daddr,
-					   ntohs(th->source), tcp_v6_iif(skb),
+					   ntohs(th->source),
+					   tcp_v6_iif_l3_slave(skb),
 					   tcp_v6_sdif(skb));
 		if (!sk1)
 			goto out;
@@ -1605,7 +1606,8 @@ do_time_wait:
 					    skb, __tcp_hdrlen(th),
 					    &ipv6_hdr(skb)->saddr, th->source,
 					    &ipv6_hdr(skb)->daddr,
-					    ntohs(th->dest), tcp_v6_iif(skb),
+					    ntohs(th->dest),
+					    tcp_v6_iif_l3_slave(skb),
 					    sdif);
 		if (sk2) {
 			struct inet_timewait_sock *tw = inet_twsk(sk);



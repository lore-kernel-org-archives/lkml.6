Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759834AbeD1KSh (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 06:18:37 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41343 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759745AbeD1KSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 06:18:35 -0400
X-Google-Smtp-Source: AB8JxZqAw/XqjPonfAhDXw/kyoC/BrYE+FO02hqehUl1kl6ueC5WGy/5SvaxEkwhFqA4zCylFsNerg==
From: Ahmed Abdelsalam <amsalam20@gmail.com>
To: davem@davemloft.net, dav.lebrun@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Ahmed Abdelsalam <amsalam20@gmail.com>
Subject: [net-next v2] ipv6: sr: extract the right key values for "seg6_make_flowlabel"
Date: Sat, 28 Apr 2018 12:18:35 +0200
Message-Id: <1524910715-12097-1-git-send-email-amsalam20@gmail.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The seg6_make_flowlabel() is used by seg6_do_srh_encap() to compute the
flowlabel from a given skb. It relies on skb_get_hash() which eventually
calls __skb_flow_dissect() to extract the flow_keys struct values from
the skb.

In case of IPv4 traffic, calling seg6_make_flowlabel() after skb_push(),
skb_reset_network_header(), and skb_mac_header_rebuild() will results in
flow_keys struct of all key values set to zero.

This patch calls seg6_make_flowlabel() before resetting the headers of skb
to get the right key values.

Extracted Key values are based on the type inner packet as follows:
1) IPv6 traffic: src_IP, dst_IP, L4 proto, and flowlabel of inner packet.
2) IPv4 traffic: src_IP, dst_IP, L4 proto, src_port, and dst_port
3) L2 traffic: depends on what kind of traffic carried into the L2
frame. IPv6 and IPv4 traffic works as discussed 1) and 2)

Here a hex_dump of struct flow_keys for IPv4 and IPv6 traffic
10.100.1.100: 47302 > 30.0.0.2: 5001
00000000: 14 00 02 00 00 00 00 00 08 00 11 00 00 00 00 00
00000010: 00 00 00 00 00 00 00 00 13 89 b8 c6 1e 00 00 02
00000020: 0a 64 01 64

fc00:a1:a > b2::2
00000000: 28 00 03 00 00 00 00 00 86 dd 11 00 99 f9 02 00
00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 b2 00 00
00000020: 00 00 00 00 00 00 00 00 00 00 00 02 fc 00 00 a1
00000030: 00 00 00 00 00 00 00 00 00 00 00 0a

Signed-off-by: Ahmed Abdelsalam <amsalam20@gmail.com>
---
 net/ipv6/seg6_iptunnel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 9898926..eab39bd 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -127,6 +127,7 @@ int seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh, int proto)
 		return err;
 
 	inner_hdr = ipv6_hdr(skb);
+	flowlabel = seg6_make_flowlabel(net, skb, inner_hdr);
 
 	skb_push(skb, tot_len);
 	skb_reset_network_header(skb);
@@ -138,7 +139,6 @@ int seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh, int proto)
 	 * decapsulation will overwrite inner hlim with outer hlim
 	 */
 
-	flowlabel = seg6_make_flowlabel(net, skb, inner_hdr);
 	if (skb->protocol == htons(ETH_P_IPV6)) {
 		ip6_flow_hdr(hdr, ip6_tclass(ip6_flowinfo(inner_hdr)),
 			     flowlabel);
-- 
2.1.4

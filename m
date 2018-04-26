Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756549AbeDZOLV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 10:11:21 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38466 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755384AbeDZOLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 10:11:17 -0400
X-Google-Smtp-Source: AIpwx4+1DMbRTN4Ze75dkToHEH/X2ulXmlGw/z4L5X2GvHpXxTn8m08XiWi3Vyz8cR2s0YeaZIT1Mw==
From: Ahmed Abdelsalam <amsalam20@gmail.com>
To: davem@davemloft.net, dav.lebrun@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Ahmed Abdelsalam <amsalam20@gmail.com>
Subject: [net-next] ipv6: sr: Extract the right key values for "seg6_make_flowlabel"
Date: Thu, 26 Apr 2018 16:11:11 +0200
Message-Id: <1524751871-1353-1-git-send-email-amsalam20@gmail.com>
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

Signed-off-by: Ahmed Abdelsalam <amsalam20@gmail.com>
---
 net/ipv6/seg6_iptunnel.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 9898926..0df83c0 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -119,6 +119,9 @@ int seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh, int proto)
 	int hdrlen, tot_len, err;
 	__be32 flowlabel;
 
+	inner_hdr = ipv6_hdr(skb);
+	flowlabel = seg6_make_flowlabel(net, skb, inner_hdr);
+
 	hdrlen = (osrh->hdrlen + 1) << 3;
 	tot_len = hdrlen + sizeof(*hdr);
 
@@ -126,8 +129,6 @@ int seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh, int proto)
 	if (unlikely(err))
 		return err;
 
-	inner_hdr = ipv6_hdr(skb);
-
 	skb_push(skb, tot_len);
 	skb_reset_network_header(skb);
 	skb_mac_header_rebuild(skb);
@@ -138,7 +139,6 @@ int seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh, int proto)
 	 * decapsulation will overwrite inner hlim with outer hlim
 	 */
 
-	flowlabel = seg6_make_flowlabel(net, skb, inner_hdr);
 	if (skb->protocol == htons(ETH_P_IPV6)) {
 		ip6_flow_hdr(hdr, ip6_tclass(ip6_flowinfo(inner_hdr)),
 			     flowlabel);
-- 
2.1.4

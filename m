Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30F8ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7EB620652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7EB620652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389936AbeGTN3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:29:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51272 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389077AbeGTN3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:29:17 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CEDD4CD2;
        Fri, 20 Jul 2018 12:37:37 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pieter Jansen van Vuuren 
        <pieter.jansenvanvuuren@netronome.com>,
        Simon Horman <simon.horman@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 047/101] nfp: flower: fix mpls ether type detection
Date:   Fri, 20 Jul 2018 14:13:53 +0200
Message-Id: <20180720121425.018481590@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121422.837870592@linuxfoundation.org>
References: <20180720121422.837870592@linuxfoundation.org>
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

From: Pieter Jansen van Vuuren <pieter.jansenvanvuuren@netronome.com>

[ Upstream commit a64119415ff248efa61301783bc26551df5dabf6 ]

Previously it was not possible to distinguish between mpls ether types and
other ether types. This leads to incorrect classification of offloaded
filters that match on mpls ether type. For example the following two
filters overlap:

 # tc filter add dev eth0 parent ffff: \
    protocol 0x8847 flower \
    action mirred egress redirect dev eth1

 # tc filter add dev eth0 parent ffff: \
    protocol 0x0800 flower \
    action mirred egress redirect dev eth2

The driver now correctly includes the mac_mpls layer where HW stores mpls
fields, when it detects an mpls ether type. It also sets the MPLS_Q bit to
indicate that the filter should match mpls packets.

Fixes: bb055c198d9b ("nfp: add mpls match offloading support")
Signed-off-by: Pieter Jansen van Vuuren <pieter.jansenvanvuuren@netronome.com>
Reviewed-by: Simon Horman <simon.horman@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/netronome/nfp/flower/match.c   |   14 ++++++++++++++
 drivers/net/ethernet/netronome/nfp/flower/offload.c |    8 ++++++++
 2 files changed, 22 insertions(+)

--- a/drivers/net/ethernet/netronome/nfp/flower/match.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/match.c
@@ -123,6 +123,20 @@ nfp_flower_compile_mac(struct nfp_flower
 			 NFP_FLOWER_MASK_MPLS_Q;
 
 		frame->mpls_lse = cpu_to_be32(t_mpls);
+	} else if (dissector_uses_key(flow->dissector,
+				      FLOW_DISSECTOR_KEY_BASIC)) {
+		/* Check for mpls ether type and set NFP_FLOWER_MASK_MPLS_Q
+		 * bit, which indicates an mpls ether type but without any
+		 * mpls fields.
+		 */
+		struct flow_dissector_key_basic *key_basic;
+
+		key_basic = skb_flow_dissector_target(flow->dissector,
+						      FLOW_DISSECTOR_KEY_BASIC,
+						      flow->key);
+		if (key_basic->n_proto == cpu_to_be16(ETH_P_MPLS_UC) ||
+		    key_basic->n_proto == cpu_to_be16(ETH_P_MPLS_MC))
+			frame->mpls_lse = cpu_to_be32(NFP_FLOWER_MASK_MPLS_Q);
 	}
 }
 
--- a/drivers/net/ethernet/netronome/nfp/flower/offload.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/offload.c
@@ -264,6 +264,14 @@ nfp_flower_calculate_key_layers(struct n
 		case cpu_to_be16(ETH_P_ARP):
 			return -EOPNOTSUPP;
 
+		case cpu_to_be16(ETH_P_MPLS_UC):
+		case cpu_to_be16(ETH_P_MPLS_MC):
+			if (!(key_layer & NFP_FLOWER_LAYER_MAC)) {
+				key_layer |= NFP_FLOWER_LAYER_MAC;
+				key_size += sizeof(struct nfp_flower_mac_mpls);
+			}
+			break;
+
 		/* Will be included in layer 2. */
 		case cpu_to_be16(ETH_P_8021Q):
 			break;



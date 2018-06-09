Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id EL+RI/H1G1vMcwAAmS7hNA
	; Sat, 09 Jun 2018 15:45:22 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D451F608C8; Sat,  9 Jun 2018 15:45:21 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTEt1e7L"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 36763605A5;
	Sat,  9 Jun 2018 15:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 36763605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753707AbeFIPd7 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:33:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:36284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753683AbeFIPdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:33:55 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88681208A3;
        Sat,  9 Jun 2018 15:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558435;
        bh=Yc3MpjgpYJOpKZg/YWNUzJneAZVVJ3GcUalYI/chsow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OTEt1e7LCbyL3d61IQ35on2PH426aTYGK0iyLalrX0+y0PBqeXN/K9j/C5XhRGo8j
         DkOjc4+sen3CDJiImGUMTlAXs6/NpWQSyi4yAuVF0aOhwulJxczx2G5sXRYRvBxNBD
         uZn9FOFfoelWdnC58CD2Y1HCZb/ddnU8U4q7K8UY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eran Ben Elisha <eranbe@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.16 39/48] net/mlx5e: When RXFCS is set, add FCS data into checksum calculation
Date: Sat,  9 Jun 2018 17:29:51 +0200
Message-Id: <20180609145950.504510492@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180609145947.679103414@linuxfoundation.org>
References: <20180609145947.679103414@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eran Ben Elisha <eranbe@mellanox.com>

[ Upstream commit 902a545904c71d719ed144234d67df75f31db63b ]

When RXFCS feature is enabled, the HW do not strip the FCS data,
however it is not present in the checksum calculated by the HW.

Fix that by manually calculating the FCS checksum and adding it to the SKB
checksum field.

Add helper function to find the FCS data for all SKB forms (linear,
one fragment or more).

Fixes: 102722fc6832 ("net/mlx5e: Add support for RXFCS feature flag")
Signed-off-by: Eran Ben Elisha <eranbe@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c |   42 ++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -635,6 +635,45 @@ static inline bool is_last_ethertype_ip(
 	return (ethertype == htons(ETH_P_IP) || ethertype == htons(ETH_P_IPV6));
 }
 
+static __be32 mlx5e_get_fcs(struct sk_buff *skb)
+{
+	int last_frag_sz, bytes_in_prev, nr_frags;
+	u8 *fcs_p1, *fcs_p2;
+	skb_frag_t *last_frag;
+	__be32 fcs_bytes;
+
+	if (!skb_is_nonlinear(skb))
+		return *(__be32 *)(skb->data + skb->len - ETH_FCS_LEN);
+
+	nr_frags = skb_shinfo(skb)->nr_frags;
+	last_frag = &skb_shinfo(skb)->frags[nr_frags - 1];
+	last_frag_sz = skb_frag_size(last_frag);
+
+	/* If all FCS data is in last frag */
+	if (last_frag_sz >= ETH_FCS_LEN)
+		return *(__be32 *)(skb_frag_address(last_frag) +
+				   last_frag_sz - ETH_FCS_LEN);
+
+	fcs_p2 = (u8 *)skb_frag_address(last_frag);
+	bytes_in_prev = ETH_FCS_LEN - last_frag_sz;
+
+	/* Find where the other part of the FCS is - Linear or another frag */
+	if (nr_frags == 1) {
+		fcs_p1 = skb_tail_pointer(skb);
+	} else {
+		skb_frag_t *prev_frag = &skb_shinfo(skb)->frags[nr_frags - 2];
+
+		fcs_p1 = skb_frag_address(prev_frag) +
+			    skb_frag_size(prev_frag);
+	}
+	fcs_p1 -= bytes_in_prev;
+
+	memcpy(&fcs_bytes, fcs_p1, bytes_in_prev);
+	memcpy(((u8 *)&fcs_bytes) + bytes_in_prev, fcs_p2, last_frag_sz);
+
+	return fcs_bytes;
+}
+
 static inline void mlx5e_handle_csum(struct net_device *netdev,
 				     struct mlx5_cqe64 *cqe,
 				     struct mlx5e_rq *rq,
@@ -663,6 +702,9 @@ static inline void mlx5e_handle_csum(str
 			skb->csum = csum_partial(skb->data + ETH_HLEN,
 						 network_depth - ETH_HLEN,
 						 skb->csum);
+		if (unlikely(netdev->features & NETIF_F_RXFCS))
+			skb->csum = csum_add(skb->csum,
+					     (__force __wsum)mlx5e_get_fcs(skb));
 		rq->stats.csum_complete++;
 		return;
 	}

Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D74C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C0F20831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMh1lgkY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8C0F20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbeKCDol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:44:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727966AbeKCDol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:44:41 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCD822082E;
        Fri,  2 Nov 2018 18:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541183790;
        bh=9NeDDrb3Z/D7lTncAbeOS3a4qsi/QZZx6wyvZYjmqOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KMh1lgkYRSnMgk+Qs0f+G4rtsBcLTA2N2pkn6T6KEupLtJbj3pzXcyVj9rg94oNLD
         Vxfz1xD+CbdYax1rxg1XdAoTc+IRUnFECS/6LhxDgl0PUDZXcnPeX8bWP50X5p8nNy
         W2Z3Syunyc9ygpCDUPEcMf1WPqQ3MuLDDteLRjzI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Staszewski?= <pstaszewski@itcare.pl>,
        Eric Dumazet <edumazet@google.com>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Dimitris Michailidis <dmichail@google.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Maria Pasechnik <mariap@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 03/24] net/mlx5e: fix csum adjustments caused by RXFCS
Date:   Fri,  2 Nov 2018 19:34:36 +0100
Message-Id: <20181102182840.222712871@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182839.725385066@linuxfoundation.org>
References: <20181102182839.725385066@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit d48051c5b8376038c2b287c3b1bd55b8d391d567 ]

As shown by Dmitris, we need to use csum_block_add() instead of csum_add()
when adding the FCS contribution to skb csum.

Before 4.18 (more exactly commit 88078d98d1bb "net: pskb_trim_rcsum()
and CHECKSUM_COMPLETE are friends"), the whole skb csum was thrown away,
so RXFCS changes were ignored.

Then before commit d55bef5059dd ("net: fix pskb_trim_rcsum_slow() with
odd trim offset") both mlx5 and pskb_trim_rcsum_slow() bugs were canceling
each other.

Now we fixed pskb_trim_rcsum_slow() we need to fix mlx5.

Note that this patch also rewrites mlx5e_get_fcs() to :

- Use skb_header_pointer() instead of reinventing it.
- Use __get_unaligned_cpu32() to avoid possible non aligned accesses
  as Dmitris pointed out.

Fixes: 902a545904c7 ("net/mlx5e: When RXFCS is set, add FCS data into checksum calculation")
Reported-by: Paweł Staszewski <pstaszewski@itcare.pl>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Eran Ben Elisha <eranbe@mellanox.com>
Cc: Saeed Mahameed <saeedm@mellanox.com>
Cc: Dimitris Michailidis <dmichail@google.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Paweł Staszewski <pstaszewski@itcare.pl>
Reviewed-by: Eran Ben Elisha <eranbe@mellanox.com>
Tested-By: Maria Pasechnik <mariap@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c |   45 ++++--------------------
 1 file changed, 9 insertions(+), 36 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -696,43 +696,15 @@ static inline bool is_last_ethertype_ip(
 	return (ethertype == htons(ETH_P_IP) || ethertype == htons(ETH_P_IPV6));
 }
 
-static __be32 mlx5e_get_fcs(struct sk_buff *skb)
+static u32 mlx5e_get_fcs(const struct sk_buff *skb)
 {
-	int last_frag_sz, bytes_in_prev, nr_frags;
-	u8 *fcs_p1, *fcs_p2;
-	skb_frag_t *last_frag;
-	__be32 fcs_bytes;
-
-	if (!skb_is_nonlinear(skb))
-		return *(__be32 *)(skb->data + skb->len - ETH_FCS_LEN);
-
-	nr_frags = skb_shinfo(skb)->nr_frags;
-	last_frag = &skb_shinfo(skb)->frags[nr_frags - 1];
-	last_frag_sz = skb_frag_size(last_frag);
-
-	/* If all FCS data is in last frag */
-	if (last_frag_sz >= ETH_FCS_LEN)
-		return *(__be32 *)(skb_frag_address(last_frag) +
-				   last_frag_sz - ETH_FCS_LEN);
-
-	fcs_p2 = (u8 *)skb_frag_address(last_frag);
-	bytes_in_prev = ETH_FCS_LEN - last_frag_sz;
-
-	/* Find where the other part of the FCS is - Linear or another frag */
-	if (nr_frags == 1) {
-		fcs_p1 = skb_tail_pointer(skb);
-	} else {
-		skb_frag_t *prev_frag = &skb_shinfo(skb)->frags[nr_frags - 2];
+	const void *fcs_bytes;
+	u32 _fcs_bytes;
 
-		fcs_p1 = skb_frag_address(prev_frag) +
-			    skb_frag_size(prev_frag);
-	}
-	fcs_p1 -= bytes_in_prev;
-
-	memcpy(&fcs_bytes, fcs_p1, bytes_in_prev);
-	memcpy(((u8 *)&fcs_bytes) + bytes_in_prev, fcs_p2, last_frag_sz);
+	fcs_bytes = skb_header_pointer(skb, skb->len - ETH_FCS_LEN,
+				       ETH_FCS_LEN, &_fcs_bytes);
 
-	return fcs_bytes;
+	return __get_unaligned_cpu32(fcs_bytes);
 }
 
 static inline void mlx5e_handle_csum(struct net_device *netdev,
@@ -765,8 +737,9 @@ static inline void mlx5e_handle_csum(str
 						 network_depth - ETH_HLEN,
 						 skb->csum);
 		if (unlikely(netdev->features & NETIF_F_RXFCS))
-			skb->csum = csum_add(skb->csum,
-					     (__force __wsum)mlx5e_get_fcs(skb));
+			skb->csum = csum_block_add(skb->csum,
+						   (__force __wsum)mlx5e_get_fcs(skb),
+						   skb->len - ETH_FCS_LEN);
 		stats->csum_complete++;
 		return;
 	}



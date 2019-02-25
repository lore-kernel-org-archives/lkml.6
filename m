Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD260C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A5332146F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129988;
	bh=rM8r4f3VctJDa38S0HInviuenkMdAuBiLowA+6OlBzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kuQlO/EHwZC3G6gOH4Vs0vXNFY9ZV8dyKf60HT7t1NiuJRU0qufOmYSnDMxLXdgIH
	 2ZH9jwD7kSReN94UiuE8Glq9cnMviTxWlDTBR/YQHZfRWoG+i3hJBE9G6zEkJbqk/W
	 jB36BC9a1VfNIFktIb5ityoSMocxeoYuFGNJKsHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731560AbfBYV01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:26:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:60790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730192AbfBYV0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:26:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 730F120C01;
        Mon, 25 Feb 2019 21:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129981;
        bh=rM8r4f3VctJDa38S0HInviuenkMdAuBiLowA+6OlBzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AKfx8eq94X8cq7aWwbZubfpKhtdepkyRjwrPHqfEyZCyq4vukyx1ipT7tjgHW6x2f
         TM1llIrhbvNUO+lF5upeWugrPS1rn1PJoJsB488KWJ16A4Shu+gGzKn0hmEzDliiwf
         kEPtOx/Bf5nokJ5vWhIAOjmgFBJt4qcdlWGNqInE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 102/152] net/mlx4_en: Force CHECKSUM_NONE for short ethernet frames
Date:   Mon, 25 Feb 2019 22:11:34 +0100
Message-Id: <20190225195049.974410941@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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

From: Saeed Mahameed <saeedm@mellanox.com>

[ Upstream commit 29dded89e80e3fff61efb34f07a8a3fba3ea146d ]

When an ethernet frame is padded to meet the minimum ethernet frame
size, the padding octets are not covered by the hardware checksum.
Fortunately the padding octets are usually zero's, which don't affect
checksum. However, it is not guaranteed. For example, switches might
choose to make other use of these octets.
This repeatedly causes kernel hardware checksum fault.

Prior to the cited commit below, skb checksum was forced to be
CHECKSUM_NONE when padding is detected. After it, we need to keep
skb->csum updated. However, fixing up CHECKSUM_COMPLETE requires to
verify and parse IP headers, it does not worth the effort as the packets
are so small that CHECKSUM_COMPLETE has no significant advantage.

Future work: when reporting checksum complete is not an option for
IP non-TCP/UDP packets, we can actually fallback to report checksum
unnecessary, by looking at cqe IPOK bit.

Fixes: 88078d98d1bb ("net: pskb_trim_rcsum() and CHECKSUM_COMPLETE are friends")
Cc: Eric Dumazet <edumazet@google.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx4/en_rx.c |   20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -620,6 +620,8 @@ static int get_fixed_ipv6_csum(__wsum hw
 }
 #endif
 
+#define short_frame(size) ((size) <= ETH_ZLEN + ETH_FCS_LEN)
+
 /* We reach this function only after checking that any of
  * the (IPv4 | IPv6) bits are set in cqe->status.
  */
@@ -627,9 +629,20 @@ static int check_csum(struct mlx4_cqe *c
 		      netdev_features_t dev_features)
 {
 	__wsum hw_checksum = 0;
+	void *hdr;
 
-	void *hdr = (u8 *)va + sizeof(struct ethhdr);
+	/* CQE csum doesn't cover padding octets in short ethernet
+	 * frames. And the pad field is appended prior to calculating
+	 * and appending the FCS field.
+	 *
+	 * Detecting these padded frames requires to verify and parse
+	 * IP headers, so we simply force all those small frames to skip
+	 * checksum complete.
+	 */
+	if (short_frame(skb->len))
+		return -EINVAL;
 
+	hdr = (u8 *)va + sizeof(struct ethhdr);
 	hw_checksum = csum_unfold((__force __sum16)cqe->checksum);
 
 	if (cqe->vlan_my_qpn & cpu_to_be32(MLX4_CQE_CVLAN_PRESENT_MASK) &&
@@ -822,6 +835,11 @@ xdp_drop_no_cnt:
 		skb_record_rx_queue(skb, cq_ring);
 
 		if (likely(dev->features & NETIF_F_RXCSUM)) {
+			/* TODO: For IP non TCP/UDP packets when csum complete is
+			 * not an option (not supported or any other reason) we can
+			 * actually check cqe IPOK status bit and report
+			 * CHECKSUM_UNNECESSARY rather than CHECKSUM_NONE
+			 */
 			if ((cqe->status & cpu_to_be16(MLX4_CQE_STATUS_TCP |
 						       MLX4_CQE_STATUS_UDP)) &&
 			    (cqe->status & cpu_to_be16(MLX4_CQE_STATUS_IPOK)) &&



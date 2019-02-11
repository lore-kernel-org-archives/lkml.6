Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676C0C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3441020700
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895856;
	bh=jRUwISIauTvwSHxdK4s5y0CaoC8URZ5leSdqrQACeh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sDRIW6rQLmm1Rm9eHyM7O7N+n8W7IUGNdzNQoTcW3pTNvq50horSNv/r0dnaVrPI7
	 p/wywrqyFB7mTl+0V3w6Y+ZVD1Fw7GKQw3tx9LeO6rR02N302cy3ZgqtJ+yQhjrIQQ
	 bTGaMFPntP9IpzyLfCXc5GOzAe+3IMCRAQyxdPFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731478AbfBKOhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:37:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:46838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731455AbfBKOh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:37:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73CFB2081B;
        Mon, 11 Feb 2019 14:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895848;
        bh=jRUwISIauTvwSHxdK4s5y0CaoC8URZ5leSdqrQACeh8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YlTHtwMs8WDHWmqeW2v98qoF+IaP60uKCIv8caspV/sJWTzbtIXtGdc+DFjv8E5L3
         XG1vIKQLYhuhCTO4tZohhpUfMFjaz1jvi/MdpsS2g+gZkpGKK5WHnwIzmLpeocIihM
         y+NbkO6jYmhgOzoTk1mcZ0zrBiO/NvjjFkLrqVXo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Nikola Ciprich <nikola.ciprich@linuxbox.cz>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.20 312/352] net/mlx5e: Force CHECKSUM_UNNECESSARY for short ethernet frames
Date:   Mon, 11 Feb 2019 15:18:59 +0100
Message-Id: <20190211141906.684824003@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit e8c8b53ccaff568fef4c13a6ccaf08bf241aa01a ]

When an ethernet frame is padded to meet the minimum ethernet frame
size, the padding octets are not covered by the hardware checksum.
Fortunately the padding octets are usually zero's, which don't affect
checksum. However, we have a switch which pads non-zero octets, this
causes kernel hardware checksum fault repeatedly.

Prior to:
commit '88078d98d1bb ("net: pskb_trim_rcsum() and CHECKSUM_COMPLETE ...")'
skb checksum was forced to be CHECKSUM_NONE when padding is detected.
After it, we need to keep skb->csum updated, like what we do for RXFCS.
However, fixing up CHECKSUM_COMPLETE requires to verify and parse IP
headers, it is not worthy the effort as the packets are so small that
CHECKSUM_COMPLETE can't save anything.

Fixes: 88078d98d1bb ("net: pskb_trim_rcsum() and CHECKSUM_COMPLETE are friends"),
Cc: Eric Dumazet <edumazet@google.com>
Cc: Tariq Toukan <tariqt@mellanox.com>
Cc: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -732,6 +732,8 @@ static u8 get_ip_proto(struct sk_buff *s
 					    ((struct ipv6hdr *)ip_p)->nexthdr;
 }
 
+#define short_frame(size) ((size) <= ETH_ZLEN + ETH_FCS_LEN)
+
 static inline void mlx5e_handle_csum(struct net_device *netdev,
 				     struct mlx5_cqe64 *cqe,
 				     struct mlx5e_rq *rq,
@@ -754,6 +756,17 @@ static inline void mlx5e_handle_csum(str
 	if (unlikely(test_bit(MLX5E_RQ_STATE_NO_CSUM_COMPLETE, &rq->state)))
 		goto csum_unnecessary;
 
+	/* CQE csum doesn't cover padding octets in short ethernet
+	 * frames. And the pad field is appended prior to calculating
+	 * and appending the FCS field.
+	 *
+	 * Detecting these padded frames requires to verify and parse
+	 * IP headers, so we simply force all those small frames to be
+	 * CHECKSUM_UNNECESSARY even if they are not padded.
+	 */
+	if (short_frame(skb->len))
+		goto csum_unnecessary;
+
 	if (likely(is_last_ethertype_ip(skb, &network_depth, &proto))) {
 		if (unlikely(get_ip_proto(skb, network_depth, proto) == IPPROTO_SCTP))
 			goto csum_unnecessary;



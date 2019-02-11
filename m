Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F65C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1BF8222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549898000;
	bh=Nmj+huXAygHGzCY8h5mh8MoXj/PG074oDNC9PaChpsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jeZidfb9CsPU295Ogt7+84FYovAFWbptF/2heuQGE//svSRwmPXy8xb5x+MuprPMU
	 NNbRc8aKPduR9h/yrfyNE0fCxrrnukezf5SJ+1ChPKZsNOC/K6IpXtAfdTk0c42JVq
	 aV1aMF8AjQ22d93aVSBMx7WbsfyrBD38CW/Fmt/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391824AbfBKPNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:13:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:59620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391682AbfBKPJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:09:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69071222B0;
        Mon, 11 Feb 2019 15:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897778;
        bh=Nmj+huXAygHGzCY8h5mh8MoXj/PG074oDNC9PaChpsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FKq6OIqZyJxNqtT3G1xBUr7ouJ1tECq13QtBCzcup5p3Fm6+JZKaFJ8cZ0VSfXUwN
         UpHKNyL2MSSr0lDmcYbvsAnf4E4U5h4cqiF1FNyGE2uMzazlaBH/4sDWDQRbVcpfQX
         roXnpzK+r2kWSxgL7zpNEF9A5MGW9ENBSqAzbwCw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Nikola Ciprich <nikola.ciprich@linuxbox.cz>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.9 111/137] net/mlx5e: Force CHECKSUM_UNNECESSARY for short ethernet frames
Date:   Mon, 11 Feb 2019 15:19:52 +0100
Message-Id: <20190211141822.479103474@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141811.964925535@linuxfoundation.org>
References: <20190211141811.964925535@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -553,6 +553,8 @@ static inline bool is_first_ethertype_ip
 	return (ethertype == htons(ETH_P_IP) || ethertype == htons(ETH_P_IPV6));
 }
 
+#define short_frame(size) ((size) <= ETH_ZLEN + ETH_FCS_LEN)
+
 static inline void mlx5e_handle_csum(struct net_device *netdev,
 				     struct mlx5_cqe64 *cqe,
 				     struct mlx5e_rq *rq,
@@ -567,6 +569,17 @@ static inline void mlx5e_handle_csum(str
 		return;
 	}
 
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
 	if (is_first_ethertype_ip(skb)) {
 		skb->ip_summed = CHECKSUM_COMPLETE;
 		skb->csum = csum_unfold((__force __sum16)cqe->check_sum);
@@ -574,6 +587,7 @@ static inline void mlx5e_handle_csum(str
 		return;
 	}
 
+csum_unnecessary:
 	if (likely((cqe->hds_ip_ext & CQE_L3_OK) &&
 		   (cqe->hds_ip_ext & CQE_L4_OK))) {
 		skb->ip_summed = CHECKSUM_UNNECESSARY;



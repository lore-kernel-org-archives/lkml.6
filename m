Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A4BC282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F81222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025421;
	bh=xPTT5hnF9PObV4uq0Z5mjLxXX39gVrRnO3X5WKL/u8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uV4A/h9seLB0e7gt5Qr9GVFcKBriL/ifrE61MxYonyBCnG39QNQ48rM1SWErVEd/6
	 XXguffikURRSTeDQsPacs1Cnp1Ik1qgaogn7aDHoJbU33cFdCR3uU8fpCEdFhWoVlc
	 aORAtg2+6H9AaS5INH8PSkHVj3wBdYNIWfHu+/E8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388209AbfBMCg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:36:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:40506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730755AbfBMCg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:36:56 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91BA6222C2;
        Wed, 13 Feb 2019 02:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025415;
        bh=xPTT5hnF9PObV4uq0Z5mjLxXX39gVrRnO3X5WKL/u8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pm6yNl5bYX/EtLul9HcBR8CZ6M905b8rFsKRHov7YSXIZLcTdmRWbxvTLkt6UPcJ8
         nMYtjDCTkeQjn/qKBfOrGS/9//GOV7TC9aU5Qb3OMQ85U1KBLooXOjziZEvnDYclUF
         C0CyL/ymTaA7/svHnOlezoMkPDRSQI4Hk7CUTJQ0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Nikola Ciprich <nikola.ciprich@linuxbox.cz>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 103/105] net/mlx5e: Force CHECKSUM_UNNECESSARY for short ethernet frames
Date:   Tue, 12 Feb 2019 21:33:34 -0500
Message-Id: <20190213023336.19019-103-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 0b5ef6d4e815..7185f0dd58eb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -732,6 +732,8 @@ static u8 get_ip_proto(struct sk_buff *skb, int network_depth, __be16 proto)
 					    ((struct ipv6hdr *)ip_p)->nexthdr;
 }
 
+#define short_frame(size) ((size) <= ETH_ZLEN + ETH_FCS_LEN)
+
 static inline void mlx5e_handle_csum(struct net_device *netdev,
 				     struct mlx5_cqe64 *cqe,
 				     struct mlx5e_rq *rq,
@@ -754,6 +756,17 @@ static inline void mlx5e_handle_csum(struct net_device *netdev,
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
-- 
2.19.1


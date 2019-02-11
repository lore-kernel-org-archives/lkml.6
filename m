Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB6DC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B987720855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896717;
	bh=mlcYRMXuiJoY6vaj7gwKg1gD+DSyigFnTvB1g91QWt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sFotrMSwvv42NCJ9YCXyGjtP7gpWX3W90IAt6HF7bSV9CaVxqSH2P9hvjXhAC61Qt
	 ws9OzdxdAZ4uX6I7f7odX5/qGhAVbGQ58gXjMwEOYY96waZzjk61ckBknEYpLsABYX
	 5/8J6FPfLp2a9/xpxrcBCmOF3gRg+o7e0KkHKCuM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388353AbfBKOv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:51:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:38058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731856AbfBKOvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:51:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52F7020855;
        Mon, 11 Feb 2019 14:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896713;
        bh=mlcYRMXuiJoY6vaj7gwKg1gD+DSyigFnTvB1g91QWt0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f/YOjtx3+TD5bZUdO/Xhovqp5RGowSiv3hTFcz1ZeuZjWifQee/MQj6B2vv/e9V9j
         /jSdpXV/SPyVvDItPmr995QPjc9iTkqEWujgF0ySlmBGwb7+WqLgcjArVgPLuBJIb4
         oE85/f7acw+2at3Yx/X9/HSTm1eJ+5lmcJryEvLg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Raed Salem <raeds@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.19 276/313] net/mlx5e: FPGA, fix Innova IPsec TX offload data path performance
Date:   Mon, 11 Feb 2019 15:19:16 +0100
Message-Id: <20190211141911.714086665@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

From: Raed Salem <raeds@mellanox.com>

[ Upstream commit 82eaa1fa0448da1852d7b80832e67e80a08dcc27 ]

At Innova IPsec TX offload data path a special software parser metadata
is used to pass some packet attributes to the hardware, this metadata
is passed using the Ethernet control segment of a WQE (a HW descriptor)
header.

The cited commit might nullify this header, hence the metadata is lost,
this caused a significant performance drop during hw offloading
operation.

Fix by restoring the metadata at the Ethernet control segment in case
it was nullified.

Fixes: 37fdffb217a4 ("net/mlx5: WQ, fixes for fragmented WQ buffers API")
Signed-off-by: Raed Salem <raeds@mellanox.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -387,8 +387,14 @@ netdev_tx_t mlx5e_sq_xmit(struct mlx5e_t
 	num_wqebbs = DIV_ROUND_UP(ds_cnt, MLX5_SEND_WQEBB_NUM_DS);
 	contig_wqebbs_room = mlx5_wq_cyc_get_contig_wqebbs(wq, pi);
 	if (unlikely(contig_wqebbs_room < num_wqebbs)) {
+#ifdef CONFIG_MLX5_EN_IPSEC
+		struct mlx5_wqe_eth_seg cur_eth = wqe->eth;
+#endif
 		mlx5e_fill_sq_frag_edge(sq, wq, pi, contig_wqebbs_room);
 		mlx5e_sq_fetch_wqe(sq, &wqe, &pi);
+#ifdef CONFIG_MLX5_EN_IPSEC
+		wqe->eth = cur_eth;
+#endif
 	}
 
 	/* fill wqe */



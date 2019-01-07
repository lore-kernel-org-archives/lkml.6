Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03F4C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B158F20651
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865313;
	bh=1oUSqP54/O86Evnw7TveITlI+S1qUT3/Y1qtftsXeJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xHMiwXwppV5Shc2J3A8Oh9EWxEl4+H2mScNuScberRiHCHKs1JbHWLaYdpnSI0tyz
	 zOZ7jPojqmHxwNQqVrKZH730cHmyNxQFudr0EKLEhmzgxM7vLFf5h23TYduwzwCZfb
	 dyS/iVDx39Hz23Wr5bUTxDyPAZiB1Px4v9xqSc+g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbfAGMsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:48:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:39142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729170AbfAGMs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:48:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B895120651;
        Mon,  7 Jan 2019 12:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865309;
        bh=1oUSqP54/O86Evnw7TveITlI+S1qUT3/Y1qtftsXeJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JCe6n+OWbcLU+Ji5iitqUT/lwcqnfgtnjLpH09+AIeyRa4vgv9AlvNOvpBwErrxuc
         5sEGvfsGTv4+GKDXdH1lXHAWHLGFgNGrdJyHEhaNbju45uiVbPgvirBtKSQIS5sVBS
         hbSuV+v4Kmow7oB4WHX7AW30P15q5pGAZfEABb/k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Moshe Shemesh <moshe@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.19 050/170] net/mlx5e: RX, Verify MPWQE stride size is in range
Date:   Mon,  7 Jan 2019 13:31:17 +0100
Message-Id: <20190107104459.042865756@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

From: Moshe Shemesh <moshe@mellanox.com>

[ Upstream commit e1c15b62b7015119d3e5915cd2ae3b89d59c2576 ]

Add check of MPWQE stride size is within range supported by HW. In case
calculated MPWQE stride size exceed range, linear SKB can't be used and
we should use non linear MPWQE instead.

Fixes: 619a8f2a42f1 ("net/mlx5e: Use linear SKB in Striding RQ")
Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -128,6 +128,8 @@ static bool mlx5e_rx_is_linear_skb(struc
 	return !params->lro_en && frag_sz <= PAGE_SIZE;
 }
 
+#define MLX5_MAX_MPWQE_LOG_WQE_STRIDE_SZ ((BIT(__mlx5_bit_sz(wq, log_wqe_stride_size)) - 1) + \
+					  MLX5_MPWQE_LOG_STRIDE_SZ_BASE)
 static bool mlx5e_rx_mpwqe_is_linear_skb(struct mlx5_core_dev *mdev,
 					 struct mlx5e_params *params)
 {
@@ -138,6 +140,9 @@ static bool mlx5e_rx_mpwqe_is_linear_skb
 	if (!mlx5e_rx_is_linear_skb(mdev, params))
 		return false;
 
+	if (order_base_2(frag_sz) > MLX5_MAX_MPWQE_LOG_WQE_STRIDE_SZ)
+		return false;
+
 	if (MLX5_CAP_GEN(mdev, ext_stride_num_range))
 		return true;
 



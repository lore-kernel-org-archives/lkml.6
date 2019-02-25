Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82727C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B7521841
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130628;
	bh=/QF1Hm9IS59sxj5Q5pwzBOTye1WXbRCw4/zO4+vQDrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fc0xpvxUgxxlJOhtMWzuaVACOKRqt1JDEHyu4J4HYX7hHV3EPIRUHFO1A1yNSnafV
	 y8K5JRzuSa6GbbY3n0j0KYv+pRtrvr5/pKiVBw9fbLL/31d5J7yxC2sCTtC7LhRnBZ
	 DV2AxbnrbSPM8iqyQXfWAWSNkX3by9ICz8VTgghA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387402AbfBYVhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:37:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:44234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732428AbfBYVhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:37:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F288420578;
        Mon, 25 Feb 2019 21:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130624;
        bh=/QF1Hm9IS59sxj5Q5pwzBOTye1WXbRCw4/zO4+vQDrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=abUjYOD7RomJxQjBVihxfDudWPgRnFicrVzKcfqcGAFtJOggBbVu0Xf9fLt245lvj
         JMPSd5amAbK8FlUV7fZLMz5IsUgLkbuwnjdwzEp1HKZE1yqSyaEQCui7vR9vVCMZHN
         CmxxCtDOSVdxkvLzPQGU5vO5OFCFzSQYEcJH8M4g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Raed Salem <raeds@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.20 143/183] net/mlx5e: FPGA, fix Innova IPsec TX offload data path performance
Date:   Mon, 25 Feb 2019 22:11:56 +0100
Message-Id: <20190225195118.975094325@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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



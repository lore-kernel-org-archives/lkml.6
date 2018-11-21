Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA6BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2644214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zl2UmUQv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2644214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387679AbeKVFmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:42:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:37062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387605AbeKVFmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:42:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80E12214DB;
        Wed, 21 Nov 2018 19:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827222;
        bh=W8RkR4PrPenyd9GxX33ijPMJuZcUQL2QEtgIoY/d6Zw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zl2UmUQvlVaB2gDHhrONTTK+6o3b1fYwl9TB0x+ztDWksqoXd/a85WvVAkIURQcgd
         XLniR5UHrK7WlDMdse3D3SmhKjiaLR7RcVixj3+f4hbC1F9Z82c3LB4dMQXl4C3pTw
         CVWdVy/lRo0QycEgO7OcuUPgvKYpyL7oa2Enu6Kc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yuval Avnery <yuvalav@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.19 20/42] net/mlx5e: Adjust to max number of channles when re-attaching
Date:   Wed, 21 Nov 2018 20:05:56 +0100
Message-Id: <20181121183148.899274407@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183147.869199006@linuxfoundation.org>
References: <20181121183147.869199006@linuxfoundation.org>
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

From: Yuval Avnery <yuvalav@mellanox.com>

[ Upstream commit a1f240f1801721f76bee734c50df2d9529da86e0 ]

When core driver enters deattach/attach flow after pci reset,
Number of logical CPUs may have changed.
As a result we need to update the cpu affiliated resource tables.
	1. indirect rqt list
	2. eq table

Reproduction (PowerPC):
	echo 1000 > /sys/kernel/debug/powerpc/eeh_max_freezes
	ppc64_cpu --smt=on
	# Restart driver
	modprobe -r ... ; modprobe ...
	# Link up
	ifconfig ...
	# Only physical CPUs
	ppc64_cpu --smt=off
	# Inject PCI errors so PCI will reset - calling the pci error handler
	echo 0x8000000000000000 > /sys/kernel/debug/powerpc/<PCI BUS>/err_injct_inboundA

Call trace when trying to add non-existing rqs to an indirect rqt:
	mlx5e_redirect_rqt+0x84/0x260 [mlx5_core] (unreliable)
	mlx5e_redirect_rqts+0x188/0x190 [mlx5_core]
	mlx5e_activate_priv_channels+0x488/0x570 [mlx5_core]
	mlx5e_open_locked+0xbc/0x140 [mlx5_core]
	mlx5e_open+0x50/0x130 [mlx5_core]
	mlx5e_nic_enable+0x174/0x1b0 [mlx5_core]
	mlx5e_attach_netdev+0x154/0x290 [mlx5_core]
	mlx5e_attach+0x88/0xd0 [mlx5_core]
	mlx5_attach_device+0x168/0x1e0 [mlx5_core]
	mlx5_load_one+0x1140/0x1210 [mlx5_core]
	mlx5_pci_resume+0x6c/0xf0 [mlx5_core]

Create cq will fail when trying to use non-existing EQ.

Fixes: 89d44f0a6c73 ("net/mlx5_core: Add pci error handlers to mlx5_core driver")
Signed-off-by: Yuval Avnery <yuvalav@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c |   27 +++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1610,13 +1610,15 @@ static int mlx5e_alloc_cq_common(struct
 	int err;
 	u32 i;
 
+	err = mlx5_vector2eqn(mdev, param->eq_ix, &eqn_not_used, &irqn);
+	if (err)
+		return err;
+
 	err = mlx5_cqwq_create(mdev, &param->wq, param->cqc, &cq->wq,
 			       &cq->wq_ctrl);
 	if (err)
 		return err;
 
-	mlx5_vector2eqn(mdev, param->eq_ix, &eqn_not_used, &irqn);
-
 	mcq->cqe_sz     = 64;
 	mcq->set_ci_db  = cq->wq_ctrl.db.db;
 	mcq->arm_db     = cq->wq_ctrl.db.db + 1;
@@ -1674,6 +1676,10 @@ static int mlx5e_create_cq(struct mlx5e_
 	int eqn;
 	int err;
 
+	err = mlx5_vector2eqn(mdev, param->eq_ix, &eqn, &irqn_not_used);
+	if (err)
+		return err;
+
 	inlen = MLX5_ST_SZ_BYTES(create_cq_in) +
 		sizeof(u64) * cq->wq_ctrl.buf.npages;
 	in = kvzalloc(inlen, GFP_KERNEL);
@@ -1687,8 +1693,6 @@ static int mlx5e_create_cq(struct mlx5e_
 	mlx5_fill_page_frag_array(&cq->wq_ctrl.buf,
 				  (__be64 *)MLX5_ADDR_OF(create_cq_in, in, pas));
 
-	mlx5_vector2eqn(mdev, param->eq_ix, &eqn, &irqn_not_used);
-
 	MLX5_SET(cqc,   cqc, cq_period_mode, param->cq_period_mode);
 	MLX5_SET(cqc,   cqc, c_eqn,         eqn);
 	MLX5_SET(cqc,   cqc, uar_page,      mdev->priv.uar->index);
@@ -1908,6 +1912,10 @@ static int mlx5e_open_channel(struct mlx
 	int err;
 	int eqn;
 
+	err = mlx5_vector2eqn(priv->mdev, ix, &eqn, &irq);
+	if (err)
+		return err;
+
 	c = kvzalloc_node(sizeof(*c), GFP_KERNEL, cpu_to_node(cpu));
 	if (!c)
 		return -ENOMEM;
@@ -1924,7 +1932,6 @@ static int mlx5e_open_channel(struct mlx
 	c->xdp      = !!params->xdp_prog;
 	c->stats    = &priv->channel_stats[ix].ch;
 
-	mlx5_vector2eqn(priv->mdev, ix, &eqn, &irq);
 	c->irq_desc = irq_to_desc(irq);
 
 	netif_napi_add(netdev, &c->napi, mlx5e_napi_poll, 64);
@@ -4964,11 +4971,21 @@ int mlx5e_attach_netdev(struct mlx5e_pri
 {
 	struct mlx5_core_dev *mdev = priv->mdev;
 	const struct mlx5e_profile *profile;
+	int max_nch;
 	int err;
 
 	profile = priv->profile;
 	clear_bit(MLX5E_STATE_DESTROYING, &priv->state);
 
+	/* max number of channels may have changed */
+	max_nch = mlx5e_get_max_num_channels(priv->mdev);
+	if (priv->channels.params.num_channels > max_nch) {
+		mlx5_core_warn(priv->mdev, "MLX5E: Reducing number of channels to %d\n", max_nch);
+		priv->channels.params.num_channels = max_nch;
+		mlx5e_build_default_indir_rqt(priv->channels.params.indirection_rqt,
+					      MLX5E_INDIR_RQT_SIZE, max_nch);
+	}
+
 	err = profile->init_tx(priv);
 	if (err)
 		goto out;



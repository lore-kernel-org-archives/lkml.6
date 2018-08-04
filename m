Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2EDC46470
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C97217BF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70C97217BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbeHDLCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:02:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48052 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbeHDLCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:02:05 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 80458BBF;
        Sat,  4 Aug 2018 09:02:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Feras Daoud <ferasda@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.17 10/31] net/mlx5e: IPoIB, Set the netdevice sw mtu in ipoib enhanced flow
Date:   Sat,  4 Aug 2018 11:00:45 +0200
Message-Id: <20180804082632.916339076@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804082632.304529527@linuxfoundation.org>
References: <20180804082632.304529527@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Feras Daoud <ferasda@mellanox.com>

[ Upstream commit 8e1d162d8e81838119de18b4ca1e302ce906f2a6 ]

After introduction of the cited commit, mlx5e_build_nic_params
receives the netdevice mtu in order to set the sw_mtu of mlx5e_params.
For enhanced IPoIB, the netdevice mtu is not set in this stage,
therefore, the initial sw_mtu equals zero. As a result, the hw_mtu
of the receive queue will be calculated incorrectly causing traffic
issues.

To fix this issue, query for port mtu before building the nic params.

Fixes: 472a1e44b349 ("net/mlx5e: Save MTU in channels params")
Signed-off-by: Feras Daoud <ferasda@mellanox.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
@@ -76,6 +76,7 @@ void mlx5i_init(struct mlx5_core_dev *md
 		void *ppriv)
 {
 	struct mlx5e_priv *priv  = mlx5i_epriv(netdev);
+	u16 max_mtu;
 
 	/* priv init */
 	priv->mdev        = mdev;
@@ -84,6 +85,9 @@ void mlx5i_init(struct mlx5_core_dev *md
 	priv->ppriv       = ppriv;
 	mutex_init(&priv->state_lock);
 
+	mlx5_query_port_max_mtu(mdev, &max_mtu, 1);
+	netdev->mtu = max_mtu;
+
 	mlx5e_build_nic_params(mdev, &priv->channels.params,
 			       profile->max_nch(mdev), netdev->mtu);
 	mlx5i_build_nic_params(mdev, &priv->channels.params);



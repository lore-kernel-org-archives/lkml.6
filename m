Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF22C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E83214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktl1MXlI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E83214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387663AbeKVFmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:42:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:37000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387605AbeKVFmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:42:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22AEE2151B;
        Wed, 21 Nov 2018 19:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827219;
        bh=RpLPohFC/JG/zuFe8aIw6NsafC9NbH2jutwsRuyUJwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ktl1MXlIXpFCi7i+PqvSIKOCRJTiT/5hDizHQIg087UtPbmPIYLF95Sy6lcVXb/ak
         P+0prV+N0EfX9bagoPJ7uJVBup87xYL3nkfeQARH0bGcSL5H9d8jMw8hIyKd6BoXnO
         GEKPJUc/eM+2h4SX7NN5eX+A4BHHSttOsWOuPi0U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Or Gerlitz <ogerlitz@mellanox.com>,
        Roi Dayan <roid@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.19 19/42] net/mlx5e: Claim TC hw offloads support only under a proper build config
Date:   Wed, 21 Nov 2018 20:05:55 +0100
Message-Id: <20181121183148.862371599@linuxfoundation.org>
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

From: Or Gerlitz <ogerlitz@mellanox.com>

[ Upstream commit 077ecd785d90c6cbba08d719faa4be8561aa0a1e ]

Currently, we are only supporting tc hw offloads when the eswitch
support is compiled in, but we are not gating the adevertizment
of the NETIF_F_HW_TC feature on this config being set.

Fix it, and while doing that, also avoid dealing with the feature
on ethtool when the config is not set.

Fixes: e8f887ac6a45 ('net/mlx5e: Introduce tc offload support')
Signed-off-by: Or Gerlitz <ogerlitz@mellanox.com>
Reviewed-by: Roi Dayan <roid@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3566,6 +3566,7 @@ static int set_feature_cvlan_filter(stru
 	return 0;
 }
 
+#ifdef CONFIG_MLX5_ESWITCH
 static int set_feature_tc_num_filters(struct net_device *netdev, bool enable)
 {
 	struct mlx5e_priv *priv = netdev_priv(netdev);
@@ -3578,6 +3579,7 @@ static int set_feature_tc_num_filters(st
 
 	return 0;
 }
+#endif
 
 static int set_feature_rx_all(struct net_device *netdev, bool enable)
 {
@@ -3676,7 +3678,9 @@ static int mlx5e_set_features(struct net
 	err |= MLX5E_HANDLE_FEATURE(NETIF_F_LRO, set_feature_lro);
 	err |= MLX5E_HANDLE_FEATURE(NETIF_F_HW_VLAN_CTAG_FILTER,
 				    set_feature_cvlan_filter);
+#ifdef CONFIG_MLX5_ESWITCH
 	err |= MLX5E_HANDLE_FEATURE(NETIF_F_HW_TC, set_feature_tc_num_filters);
+#endif
 	err |= MLX5E_HANDLE_FEATURE(NETIF_F_RXALL, set_feature_rx_all);
 	err |= MLX5E_HANDLE_FEATURE(NETIF_F_RXFCS, set_feature_rx_fcs);
 	err |= MLX5E_HANDLE_FEATURE(NETIF_F_HW_VLAN_CTAG_RX, set_feature_rx_vlan);
@@ -4685,7 +4689,9 @@ static void mlx5e_build_nic_netdev(struc
 	    FT_CAP(modify_root) &&
 	    FT_CAP(identified_miss_table_mode) &&
 	    FT_CAP(flow_table_modify)) {
+#ifdef CONFIG_MLX5_ESWITCH
 		netdev->hw_features      |= NETIF_F_HW_TC;
+#endif
 #ifdef CONFIG_MLX5_EN_ARFS
 		netdev->hw_features	 |= NETIF_F_NTUPLE;
 #endif



Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1EBC070C3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A0D72098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdsgSmyq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A0D72098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbeJPMCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:02:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:49788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727259AbeJPMCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:02:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E032521479;
        Tue, 16 Oct 2018 04:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663226;
        bh=1FrgQJRZO5COeVxZm7+ytZ2+5L5jYpkte9zPbO57hwg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GdsgSmyqejCTPAyrV2uQwCiydz3cmALQawYdy+o/yjCvFxa1yv+V0nuC81tZkyMeq
         UOThdW3Ja37EwxATvt9lptz9QiDQGYGduuXZy+8FMYfTP4BJmfEBIkNeZ3ruoZOKno
         oxiSY+RQ2Fjk6Accs86lB7tNpt0tztAYvTpZoyKQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Davide Caratti <dcaratti@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 089/100] be2net: don't flip hw_features when VXLANs are added/deleted
Date:   Tue, 16 Oct 2018 00:12:10 -0400
Message-Id: <20181016041221.135528-89-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davide Caratti <dcaratti@redhat.com>

[ Upstream commit 2d52527e80c2dc0c5f43f50adf183781262ec565 ]

the be2net implementation of .ndo_tunnel_{add,del}() changes the value of
NETIF_F_GSO_UDP_TUNNEL bit in 'features' and 'hw_features', but it forgets
to call netdev_features_change(). Moreover, ethtool setting for that bit
can potentially be reverted after a tunnel is added or removed.

GSO already does software segmentation when 'hw_enc_features' is 0, even
if VXLAN offload is turned on. In addition, commit 096de2f83ebc ("benet:
stricter vxlan offloading check in be_features_check") avoids hardware
segmentation of non-VXLAN tunneled packets, or VXLAN packets having wrong
destination port. So, it's safe to avoid flipping the above feature on
addition/deletion of VXLAN tunnels.

Fixes: 630f4b70567f ("be2net: Export tunnel offloads only when a VxLAN tunnel is created")
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/emulex/benet/be_main.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index 8f755009ff38..c8445a4135a9 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -3915,8 +3915,6 @@ static int be_enable_vxlan_offloads(struct be_adapter *adapter)
 	netdev->hw_enc_features |= NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
 				   NETIF_F_TSO | NETIF_F_TSO6 |
 				   NETIF_F_GSO_UDP_TUNNEL;
-	netdev->hw_features |= NETIF_F_GSO_UDP_TUNNEL;
-	netdev->features |= NETIF_F_GSO_UDP_TUNNEL;
 
 	dev_info(dev, "Enabled VxLAN offloads for UDP port %d\n",
 		 be16_to_cpu(port));
@@ -3938,8 +3936,6 @@ static void be_disable_vxlan_offloads(struct be_adapter *adapter)
 	adapter->vxlan_port = 0;
 
 	netdev->hw_enc_features = 0;
-	netdev->hw_features &= ~(NETIF_F_GSO_UDP_TUNNEL);
-	netdev->features &= ~(NETIF_F_GSO_UDP_TUNNEL);
 }
 
 static void be_calculate_vf_res(struct be_adapter *adapter, u16 num_vfs,
@@ -5232,6 +5228,7 @@ static void be_netdev_init(struct net_device *netdev)
 	struct be_adapter *adapter = netdev_priv(netdev);
 
 	netdev->hw_features |= NETIF_F_SG | NETIF_F_TSO | NETIF_F_TSO6 |
+		NETIF_F_GSO_UDP_TUNNEL |
 		NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM |
 		NETIF_F_HW_VLAN_CTAG_TX;
 	if ((be_if_cap_flags(adapter) & BE_IF_FLAGS_RSS))
-- 
2.17.1


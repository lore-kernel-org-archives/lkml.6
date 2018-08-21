Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256B4C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEAC021774
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEAC021774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbeHUJnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:43:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54990 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbeHUJnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:43:03 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3DDB69D7;
        Tue, 21 Aug 2018 06:24:17 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Or Gerlitz <ogerlitz@mellanox.com>,
        Alaa Hleihel <alaa@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 14/42] net/mlx5e: Properly check if hairpin is possible between two functions
Date:   Tue, 21 Aug 2018 08:20:46 +0200
Message-Id: <20180821055018.336144727@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821055017.596264829@linuxfoundation.org>
References: <20180821055017.596264829@linuxfoundation.org>
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

From: Or Gerlitz <ogerlitz@mellanox.com>

[ Upstream commit 816f670623692b5da2787f278cbfdb331ed29b8a ]

The current check relies on function BDF addresses and can get
us wrong e.g when two VFs are assigned into a VM and the PCI
v-address is set by the hypervisor.

Fixes: 5c65c564c962 ('net/mlx5e: Support offloading TC NIC hairpin flows')
Signed-off-by: Or Gerlitz <ogerlitz@mellanox.com>
Reported-by: Alaa Hleihel <alaa@mellanox.com>
Tested-by: Alaa Hleihel <alaa@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -1907,15 +1907,15 @@ static bool actions_match_supported(stru
 static bool same_hw_devs(struct mlx5e_priv *priv, struct mlx5e_priv *peer_priv)
 {
 	struct mlx5_core_dev *fmdev, *pmdev;
-	u16 func_id, peer_id;
+	u64 fsystem_guid, psystem_guid;
 
 	fmdev = priv->mdev;
 	pmdev = peer_priv->mdev;
 
-	func_id = (u16)((fmdev->pdev->bus->number << 8) | PCI_SLOT(fmdev->pdev->devfn));
-	peer_id = (u16)((pmdev->pdev->bus->number << 8) | PCI_SLOT(pmdev->pdev->devfn));
+	mlx5_query_nic_vport_system_image_guid(fmdev, &fsystem_guid);
+	mlx5_query_nic_vport_system_image_guid(pmdev, &psystem_guid);
 
-	return (func_id == peer_id);
+	return (fsystem_guid == psystem_guid);
 }
 
 static int parse_tc_nic_actions(struct mlx5e_priv *priv, struct tcf_exts *exts,



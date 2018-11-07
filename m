Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8C6C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 04:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE8A20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 04:07:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE8A20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730691AbeKGNeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 08:34:50 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:14603 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726558AbeKGNeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 08:34:50 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AEB02FD9849FC;
        Wed,  7 Nov 2018 12:06:11 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.408.0; Wed, 7 Nov 2018 12:06:05 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>
Subject: [Patch net-next 01/12] net: hns3: use HNS3_NIC_STATE_INITED to indicate the initialization state of enet
Date:   Wed, 7 Nov 2018 12:06:07 +0800
Message-ID: <1541563578-28973-2-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541563578-28973-1-git-send-email-tanhuazhong@huawei.com>
References: <1541563578-28973-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Besides of module_init and module_exit, the process of reset will
also uninitialize and initialize the enet client. When reset process
fails with enet client uninitialized, the module_exit does not need
to uninitialize the enet client, otherwise it may cause double
uninitialization problem.

So we need the HNS3_NIC_STATE_INITED flag to indicate whether
the enet client is initialized.

Also HNS3_NIC_STATE_REINITING is previously unused, so change it to
HNS3_NIC_STATE_INITED.

Fixes: bb6b94a896d4 ("net: hns3: Add reset interface implementation in client")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 17 +++++++++++++++++
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h |  2 +-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 3f96aa3..d51469c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3397,6 +3397,8 @@ static int hns3_client_init(struct hnae3_handle *handle)
 	/* MTU range: (ETH_MIN_MTU(kernel default) - 9706) */
 	netdev->max_mtu = HNS3_MAX_MTU - (ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN);
 
+	set_bit(HNS3_NIC_STATE_INITED, &priv->state);
+
 	return ret;
 
 out_reg_netdev_fail:
@@ -3423,6 +3425,11 @@ static void hns3_client_uninit(struct hnae3_handle *handle, bool reset)
 	if (netdev->reg_state != NETREG_UNINITIALIZED)
 		unregister_netdev(netdev);
 
+	if (!test_and_clear_bit(HNS3_NIC_STATE_INITED, &priv->state)) {
+		netdev_warn(netdev, "already uninitialized\n");
+		goto out_netdev_free;
+	}
+
 	hns3_del_all_fd_rules(netdev, true);
 
 	hns3_force_clear_all_rx_ring(handle);
@@ -3443,6 +3450,7 @@ static void hns3_client_uninit(struct hnae3_handle *handle, bool reset)
 
 	priv->ring_data = NULL;
 
+out_netdev_free:
 	free_netdev(netdev);
 }
 
@@ -3782,6 +3790,8 @@ static int hns3_reset_notify_init_enet(struct hnae3_handle *handle)
 		priv->ring_data = NULL;
 	}
 
+	set_bit(HNS3_NIC_STATE_INITED, &priv->state);
+
 	return ret;
 }
 
@@ -3792,6 +3802,11 @@ static int hns3_reset_notify_uninit_enet(struct hnae3_handle *handle)
 	struct hns3_nic_priv *priv = netdev_priv(netdev);
 	int ret;
 
+	if (!test_bit(HNS3_NIC_STATE_INITED, &priv->state)) {
+		netdev_warn(netdev, "already uninitialized\n");
+		return 0;
+	}
+
 	hns3_force_clear_all_rx_ring(handle);
 
 	ret = hns3_nic_uninit_vector_data(priv);
@@ -3815,6 +3830,8 @@ static int hns3_reset_notify_uninit_enet(struct hnae3_handle *handle)
 		hns3_del_all_fd_rules(netdev, false);
 	}
 
+	clear_bit(HNS3_NIC_STATE_INITED, &priv->state);
+
 	return ret;
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index d3636d0..7b759e4 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -15,7 +15,7 @@ extern const char hns3_driver_version[];
 enum hns3_nic_state {
 	HNS3_NIC_STATE_TESTING,
 	HNS3_NIC_STATE_RESETTING,
-	HNS3_NIC_STATE_REINITING,
+	HNS3_NIC_STATE_INITED,
 	HNS3_NIC_STATE_DOWN,
 	HNS3_NIC_STATE_DISABLED,
 	HNS3_NIC_STATE_REMOVING,
-- 
2.7.4


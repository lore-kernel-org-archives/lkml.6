Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4812C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF2F2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CF2F2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbeJLWHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:07:35 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13629 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728708AbeJLWHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 18:07:34 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4EE3079FD7407;
        Fri, 12 Oct 2018 22:34:43 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.399.0; Fri, 12 Oct 2018 22:34:35 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>
Subject: [PATCH net-next 1/3] net: hns3: Enable promisc mode when mac vlan table is full
Date:   Fri, 12 Oct 2018 15:34:04 +0100
Message-ID: <20181012143406.22600-2-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20181012143406.22600-1-salil.mehta@huawei.com>
References: <20181012143406.22600-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

Currently, the driver does nothing when mac vlan table is full.
In this case, the packet with new mac address will be dropped
by hardware. This patch adds check for the result of sync mac
address, and enable promisc mode when mac vlan table is full.
Furtherly, disable vlan filter when enable promisc by user
command.

Fixes: 46a3df9f9718 ("net: hns3: Add HNS3 Acceleration Engine & Compatibility Layer Support")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        | 11 +++
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 78 +++++++++++++++++++---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |  3 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  9 ++-
 4 files changed, 89 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 3df62a5..c3bd2a1 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -503,6 +503,15 @@ struct hnae3_unic_private_info {
 #define HNAE3_SUPPORT_VF	      BIT(3)
 #define HNAE3_SUPPORT_SERDES_PARALLEL_LOOPBACK	BIT(4)
 
+#define HNAE3_USER_UPE		BIT(0)	/* unicast promisc enabled by user */
+#define HNAE3_USER_MPE		BIT(1)	/* mulitcast promisc enabled by user */
+#define HNAE3_BPE		BIT(2)	/* broadcast promisc enable */
+#define HNAE3_OVERFLOW_UPE	BIT(3)	/* unicast mac vlan overflow */
+#define HNAE3_OVERFLOW_MPE	BIT(4)	/* multicast mac vlan overflow */
+#define HNAE3_VLAN_FLTR		BIT(5)	/* enable vlan filter */
+#define HNAE3_UPE		(HNAE3_USER_UPE | HNAE3_OVERFLOW_UPE)
+#define HNAE3_MPE		(HNAE3_USER_MPE | HNAE3_OVERFLOW_MPE)
+
 struct hnae3_handle {
 	struct hnae3_client *client;
 	struct pci_dev *pdev;
@@ -521,6 +530,8 @@ struct hnae3_handle {
 	};
 
 	u32 numa_node_mask;	/* for multi-chip support */
+
+	u8 netdev_flags;
 };
 
 #define hnae3_set_field(origin, mask, shift, val) \
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 9bbb53c..bbd6197 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -459,23 +459,81 @@ static int hns3_nic_mc_unsync(struct net_device *netdev,
 	return 0;
 }
 
+static u8 hns3_get_netdev_flags(struct net_device *netdev)
+{
+	u8 flags = 0;
+
+	if (netdev->flags & IFF_PROMISC) {
+		flags = HNAE3_USER_UPE | HNAE3_USER_MPE;
+	} else {
+		flags |= HNAE3_VLAN_FLTR;
+		if (netdev->flags & IFF_ALLMULTI)
+			flags |= HNAE3_USER_MPE;
+	}
+
+	return flags;
+}
+
 static void hns3_nic_set_rx_mode(struct net_device *netdev)
 {
 	struct hnae3_handle *h = hns3_get_handle(netdev);
+	u8 new_flags;
+	int ret;
 
-	if (h->ae_algo->ops->set_promisc_mode) {
-		if (netdev->flags & IFF_PROMISC)
-			h->ae_algo->ops->set_promisc_mode(h, true, true);
-		else if (netdev->flags & IFF_ALLMULTI)
-			h->ae_algo->ops->set_promisc_mode(h, false, true);
-		else
-			h->ae_algo->ops->set_promisc_mode(h, false, false);
-	}
-	if (__dev_uc_sync(netdev, hns3_nic_uc_sync, hns3_nic_uc_unsync))
+	new_flags = hns3_get_netdev_flags(netdev);
+
+	ret = __dev_uc_sync(netdev, hns3_nic_uc_sync, hns3_nic_uc_unsync);
+	if (ret) {
 		netdev_err(netdev, "sync uc address fail\n");
+		if (ret == -ENOSPC)
+			new_flags |= HNAE3_OVERFLOW_UPE;
+	}
+
 	if (netdev->flags & IFF_MULTICAST) {
-		if (__dev_mc_sync(netdev, hns3_nic_mc_sync, hns3_nic_mc_unsync))
+		ret = __dev_mc_sync(netdev, hns3_nic_mc_sync,
+				    hns3_nic_mc_unsync);
+		if (ret) {
 			netdev_err(netdev, "sync mc address fail\n");
+			if (ret == -ENOSPC)
+				new_flags |= HNAE3_OVERFLOW_MPE;
+		}
+	}
+
+	hns3_update_promisc_mode(netdev, new_flags);
+	/* User mode Promisc mode enable and vlan filtering is disabled to
+	 * let all packets in. MAC-VLAN Table overflow Promisc enabled and
+	 * vlan fitering is enabled
+	 */
+	hns3_enable_vlan_filter(netdev, new_flags & HNAE3_VLAN_FLTR);
+	h->netdev_flags = new_flags;
+}
+
+void hns3_update_promisc_mode(struct net_device *netdev, u8 promisc_flags)
+{
+	struct hns3_nic_priv *priv = netdev_priv(netdev);
+	struct hnae3_handle *h = priv->ae_handle;
+
+	if (h->ae_algo->ops->set_promisc_mode) {
+		h->ae_algo->ops->set_promisc_mode(h,
+						  promisc_flags & HNAE3_UPE,
+						  promisc_flags & HNAE3_MPE);
+	}
+}
+
+void hns3_enable_vlan_filter(struct net_device *netdev, bool enable)
+{
+	struct hns3_nic_priv *priv = netdev_priv(netdev);
+	struct hnae3_handle *h = priv->ae_handle;
+	bool last_state;
+
+	if (h->pdev->revision >= 0x21 && h->ae_algo->ops->enable_vlan_filter) {
+		last_state = h->netdev_flags & HNAE3_VLAN_FLTR ? true : false;
+		if (enable != last_state) {
+			netdev_info(netdev,
+				    "%s vlan filter\n",
+				    enable ? "enable" : "disable");
+			h->ae_algo->ops->enable_vlan_filter(h, enable);
+		}
 	}
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index ac881e8..f25b281 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -640,6 +640,9 @@ void hns3_set_vector_coalesce_tx_gl(struct hns3_enet_tqp_vector *tqp_vector,
 void hns3_set_vector_coalesce_rl(struct hns3_enet_tqp_vector *tqp_vector,
 				 u32 rl_value);
 
+void hns3_enable_vlan_filter(struct net_device *netdev, bool enable);
+void hns3_update_promisc_mode(struct net_device *netdev, u8 promisc_flags);
+
 #ifdef CONFIG_HNS3_DCB
 void hns3_dcbnl_setup(struct hnae3_handle *handle);
 #else
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index db97f6a..1bd83e8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -5606,6 +5606,10 @@ static void hclge_enable_vlan_filter(struct hnae3_handle *handle, bool enable)
 		hclge_set_vlan_filter_ctrl(hdev, HCLGE_FILTER_TYPE_VF,
 					   HCLGE_FILTER_FE_EGRESS_V1_B, enable);
 	}
+	if (enable)
+		handle->netdev_flags |= HNAE3_VLAN_FLTR;
+	else
+		handle->netdev_flags &= ~HNAE3_VLAN_FLTR;
 }
 
 static int hclge_set_vf_vlan_common(struct hclge_dev *hdev, int vfid,
@@ -5902,7 +5906,7 @@ static int hclge_init_vlan_config(struct hclge_dev *hdev)
 {
 #define HCLGE_DEF_VLAN_TYPE		0x8100
 
-	struct hnae3_handle *handle;
+	struct hnae3_handle *handle = &hdev->vport[0].nic;
 	struct hclge_vport *vport;
 	int ret;
 	int i;
@@ -5925,6 +5929,8 @@ static int hclge_init_vlan_config(struct hclge_dev *hdev)
 			return ret;
 	}
 
+	handle->netdev_flags |= HNAE3_VLAN_FLTR;
+
 	hdev->vlan_type_cfg.rx_in_fst_vlan_type = HCLGE_DEF_VLAN_TYPE;
 	hdev->vlan_type_cfg.rx_in_sec_vlan_type = HCLGE_DEF_VLAN_TYPE;
 	hdev->vlan_type_cfg.rx_ot_fst_vlan_type = HCLGE_DEF_VLAN_TYPE;
@@ -5969,7 +5975,6 @@ static int hclge_init_vlan_config(struct hclge_dev *hdev)
 			return ret;
 	}
 
-	handle = &hdev->vport[0].nic;
 	return hclge_set_vlan_filter(handle, htons(ETH_P_8021Q), 0, false);
 }
 
-- 
2.7.4



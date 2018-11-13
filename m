Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BC0C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79BB220811
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79BB220811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732202AbeKMUL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 15:11:58 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:14651 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732162AbeKMUL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 15:11:58 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DE779214BA0DC;
        Tue, 13 Nov 2018 18:14:29 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.47.86.21) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.408.0; Tue, 13 Nov 2018 18:14:22 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH net-next 3/5] net: hns3: Add support for ethtool -K to enable/disable HW GRO
Date:   Tue, 13 Nov 2018 10:13:05 +0000
Message-ID: <20181113101307.6020-4-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20181113101307.6020-1-salil.mehta@huawei.com>
References: <20181113101307.6020-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.86.21]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Li <lipeng321@huawei.com>

This patch adds support of ethtool -K to enable/disable
hardware GRO in HNS3 PF/VF driver.

Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h         |  3 +++
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c     | 13 ++++++++++++-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c |  9 +++++++++
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c   |  8 ++++++++
 4 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 21d934b7a2a3..1746172ffbf7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -305,6 +305,8 @@ struct hnae3_ae_dev {
  *   Set vlan filter config of vf
  * enable_hw_strip_rxvtag()
  *   Enable/disable hardware strip vlan tag of packets received
+ * set_gro_en
+ *   Enable/disable HW GRO
  */
 struct hnae3_ae_ops {
 	int (*init_ae_dev)(struct hnae3_ae_dev *ae_dev);
@@ -449,6 +451,7 @@ struct hnae3_ae_ops {
 	bool (*get_hw_reset_stat)(struct hnae3_handle *handle);
 	bool (*ae_dev_resetting)(struct hnae3_handle *handle);
 	unsigned long (*ae_dev_reset_cnt)(struct hnae3_handle *handle);
+	int (*set_gro_en)(struct hnae3_handle *handle, int enable);
 };
 
 struct hnae3_dcb_ops {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index d8c5e1198670..860067898471 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1345,6 +1345,15 @@ static int hns3_nic_set_features(struct net_device *netdev,
 			priv->ops.maybe_stop_tx = hns3_nic_maybe_stop_tx;
 	}
 
+	if (changed & (NETIF_F_GRO_HW) && h->ae_algo->ops->set_gro_en) {
+		if (features & NETIF_F_GRO_HW)
+			ret = h->ae_algo->ops->set_gro_en(h, true);
+		else
+			ret = h->ae_algo->ops->set_gro_en(h, false);
+		if (ret)
+			return ret;
+	}
+
 	if ((changed & NETIF_F_HW_VLAN_CTAG_FILTER) &&
 	    h->ae_algo->ops->enable_vlan_filter) {
 		if (features & NETIF_F_HW_VLAN_CTAG_FILTER)
@@ -1929,7 +1938,9 @@ static void hns3_set_default_feature(struct net_device *netdev)
 		NETIF_F_GSO_UDP_TUNNEL_CSUM | NETIF_F_SCTP_CRC;
 
 	if (pdev->revision >= 0x21) {
-		netdev->hw_features |= NETIF_F_HW_VLAN_CTAG_FILTER;
+		netdev->hw_features |= NETIF_F_HW_VLAN_CTAG_FILTER |
+			NETIF_F_GRO_HW;
+		netdev->features |= NETIF_F_GRO_HW;
 
 		if (!(h->flags & HNAE3_SUPPORT_VF)) {
 			netdev->hw_features |= NETIF_F_NTUPLE;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index d02712446d50..ed25d262064a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -7673,6 +7673,14 @@ static void hclge_get_link_mode(struct hnae3_handle *handle,
 	}
 }
 
+static int hclge_gro_en(struct hnae3_handle *handle, int enable)
+{
+	struct hclge_vport *vport = hclge_get_vport(handle);
+	struct hclge_dev *hdev = vport->back;
+
+	return hclge_config_gro(hdev, enable);
+}
+
 static const struct hnae3_ae_ops hclge_ops = {
 	.init_ae_dev = hclge_init_ae_dev,
 	.uninit_ae_dev = hclge_uninit_ae_dev,
@@ -7744,6 +7752,7 @@ static const struct hnae3_ae_ops hclge_ops = {
 	.get_hw_reset_stat = hclge_get_hw_reset_stat,
 	.ae_dev_resetting = hclge_ae_dev_resetting,
 	.ae_dev_reset_cnt = hclge_ae_dev_reset_cnt,
+	.set_gro_en = hclge_gro_en,
 };
 
 static struct hnae3_ae_algo ae_algo = {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 3f256414fbe4..e51f8f7d52f1 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -2374,6 +2374,13 @@ void hclgevf_update_speed_duplex(struct hclgevf_dev *hdev, u32 speed,
 	hdev->hw.mac.duplex = duplex;
 }
 
+static int hclgevf_gro_en(struct hnae3_handle *handle, int enable)
+{
+	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
+
+	return hclgevf_config_gro(hdev, enable);
+}
+
 static void hclgevf_get_media_type(struct hnae3_handle *handle,
 				  u8 *media_type)
 {
@@ -2448,6 +2455,7 @@ static const struct hnae3_ae_ops hclgevf_ops = {
 	.get_hw_reset_stat = hclgevf_get_hw_reset_stat,
 	.ae_dev_resetting = hclgevf_ae_dev_resetting,
 	.ae_dev_reset_cnt = hclgevf_ae_dev_reset_cnt,
+	.set_gro_en = hclgevf_gro_en,
 };
 
 static struct hnae3_ae_algo ae_algovf = {
-- 
2.17.1



Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825E3C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 03:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F05F20659
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 03:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F05F20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbeKRNjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 08:39:33 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:44065 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725831AbeKRNjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 08:39:32 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6D187285F323D;
        Sun, 18 Nov 2018 11:20:38 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.47.88.178) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Sun, 18 Nov 2018 11:20:30 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>,
        Jian Shen <shenjian15@huawei.com>
Subject: [PATCH net-next 2/5] net: hns3: Refactor mac mtu setting related functions
Date:   Sun, 18 Nov 2018 03:19:11 +0000
Message-ID: <20181118031914.23892-3-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20181118031914.23892-1-salil.mehta@huawei.com>
References: <20181118031914.23892-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.88.178]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

This patch refactors mac mtu setting related functions,
normalizes the use of mps and mtu.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |  3 +-
 .../net/ethernet/hisilicon/hns3/hns3_enet.h   |  5 +-
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 52 ++++++++-----------
 3 files changed, 27 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index c944090d3adf..d58d3c193ab7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3610,8 +3610,7 @@ static int hns3_client_init(struct hnae3_handle *handle)
 	hns3_dcbnl_setup(handle);
 
 	/* MTU range: (ETH_MIN_MTU(kernel default) - 9702) */
-	netdev->max_mtu =
-		HNS3_MAX_MTU - (ETH_HLEN + ETH_FCS_LEN + 2 * VLAN_HLEN);
+	netdev->max_mtu = HNS3_MAX_MTU;
 
 	set_bit(HNS3_NIC_STATE_INITED, &priv->state);
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index 3365c9596983..bbf227ba30f8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -76,7 +76,10 @@ enum hns3_nic_state {
 #define HNS3_RING_MAX_PENDING			32768
 #define HNS3_RING_MIN_PENDING			8
 #define HNS3_RING_BD_MULTIPLE			8
-#define HNS3_MAX_MTU				9728
+/* max frame size of mac */
+#define HNS3_MAC_MAX_FRAME			9728
+#define HNS3_MAX_MTU \
+	(HNS3_MAC_MAX_FRAME - (ETH_HLEN + ETH_FCS_LEN + 2 * VLAN_HLEN))
 
 #define HNS3_BD_SIZE_512_TYPE			0
 #define HNS3_BD_SIZE_1024_TYPE			1
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 019f747e486a..0a8297f67b06 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -26,7 +26,7 @@
 #define HCLGE_STATS_READ(p, offset) (*((u64 *)((u8 *)(p) + (offset))))
 #define HCLGE_MAC_STATS_FIELD_OFF(f) (offsetof(struct hclge_mac_stats, f))
 
-static int hclge_set_mtu(struct hnae3_handle *handle, int new_mtu);
+static int hclge_set_mac_mtu(struct hclge_dev *hdev, int new_mps);
 static int hclge_init_vlan_config(struct hclge_dev *hdev);
 static int hclge_reset_ae_dev(struct hnae3_ae_dev *ae_dev);
 static int hclge_set_umv_space(struct hclge_dev *hdev, u16 space_size,
@@ -1969,10 +1969,7 @@ static int hclge_get_autoneg(struct hnae3_handle *handle)
 
 static int hclge_mac_init(struct hclge_dev *hdev)
 {
-	struct hnae3_handle *handle = &hdev->vport[0].nic;
-	struct net_device *netdev = handle->kinfo.netdev;
 	struct hclge_mac *mac = &hdev->hw.mac;
-	int mtu;
 	int ret;
 
 	hdev->hw.mac.duplex = HCLGE_MAC_FULL;
@@ -1986,15 +1983,16 @@ static int hclge_mac_init(struct hclge_dev *hdev)
 
 	mac->link = 0;
 
-	if (netdev)
-		mtu = netdev->mtu;
-	else
-		mtu = ETH_DATA_LEN;
+	ret = hclge_set_mac_mtu(hdev, hdev->mps);
+	if (ret) {
+		dev_err(&hdev->pdev->dev, "set mtu failed ret=%d\n", ret);
+		return ret;
+	}
 
-	ret = hclge_set_mtu(handle, mtu);
+	ret = hclge_buffer_alloc(hdev);
 	if (ret)
 		dev_err(&hdev->pdev->dev,
-			"set mtu failed ret=%d\n", ret);
+			"allocate buffer fail, ret=%d\n", ret);
 
 	return ret;
 }
@@ -6357,49 +6355,42 @@ int hclge_en_hw_strip_rxvtag(struct hnae3_handle *handle, bool enable)
 	return hclge_set_vlan_rx_offload_cfg(vport);
 }
 
-static int hclge_set_mac_mtu(struct hclge_dev *hdev, int new_mtu)
+static int hclge_set_mac_mtu(struct hclge_dev *hdev, int new_mps)
 {
 	struct hclge_config_max_frm_size_cmd *req;
 	struct hclge_desc desc;
-	int max_frm_size;
-	int ret;
-
-	max_frm_size = new_mtu + ETH_HLEN + ETH_FCS_LEN + 2 * VLAN_HLEN;
-
-	if (max_frm_size < HCLGE_MAC_MIN_FRAME ||
-	    max_frm_size > HCLGE_MAC_MAX_FRAME)
-		return -EINVAL;
 
-	max_frm_size = max(max_frm_size, HCLGE_MAC_DEFAULT_FRAME);
+	new_mps = max(new_mps, HCLGE_MAC_DEFAULT_FRAME);
 
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_CONFIG_MAX_FRM_SIZE, false);
 
 	req = (struct hclge_config_max_frm_size_cmd *)desc.data;
-	req->max_frm_size = cpu_to_le16(max_frm_size);
+	req->max_frm_size = cpu_to_le16(new_mps);
 	req->min_frm_size = HCLGE_MAC_MIN_FRAME;
 
-	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
-	if (ret)
-		dev_err(&hdev->pdev->dev, "set mtu fail, ret =%d.\n", ret);
-	else
-		hdev->mps = max_frm_size;
-
-	return ret;
+	return hclge_cmd_send(&hdev->hw, &desc, 1);
 }
 
 static int hclge_set_mtu(struct hnae3_handle *handle, int new_mtu)
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
-	int ret;
+	int max_frm_size, ret;
 
-	ret = hclge_set_mac_mtu(hdev, new_mtu);
+	max_frm_size = new_mtu + ETH_HLEN + ETH_FCS_LEN + 2 * VLAN_HLEN;
+	if (max_frm_size < HCLGE_MAC_MIN_FRAME ||
+	    max_frm_size > HCLGE_MAC_MAX_FRAME)
+		return -EINVAL;
+
+	ret = hclge_set_mac_mtu(hdev, max_frm_size);
 	if (ret) {
 		dev_err(&hdev->pdev->dev,
 			"Change mtu fail, ret =%d\n", ret);
 		return ret;
 	}
 
+	hdev->mps = max_frm_size;
+
 	ret = hclge_buffer_alloc(hdev);
 	if (ret)
 		dev_err(&hdev->pdev->dev,
@@ -7021,6 +7012,7 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 	hdev->reset_type = HNAE3_NONE_RESET;
 	hdev->reset_level = HNAE3_FUNC_RESET;
 	ae_dev->priv = hdev;
+	hdev->mps = ETH_FRAME_LEN + ETH_FCS_LEN + 2 * VLAN_HLEN;
 
 	ret = hclge_pci_init(hdev);
 	if (ret) {
-- 
2.17.1



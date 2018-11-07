Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53BBC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 04:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860F720827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 04:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 860F720827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388866AbeKGNgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 08:36:15 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:14599 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726312AbeKGNeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 08:34:50 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9F888E75BC665;
        Wed,  7 Nov 2018 12:06:11 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.408.0; Wed, 7 Nov 2018 12:06:06 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>
Subject: [Patch net-next 06/12] net: hns3: use HNS3_NIC_STATE_RESETTING to indicate resetting
Date:   Wed, 7 Nov 2018 12:06:12 +0800
Message-ID: <1541563578-28973-7-git-send-email-tanhuazhong@huawei.com>
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

While hclge is going to reset, it will notify its client with
HNAE3_DOWN_CLIENT, so this client should get into a resetting
status from this moment, other operations from the stack need to
be blocked as well. And when the reset is finished, the client
will be notified with HNAE3_UP_CLIENT, so this is the end of
the resetting status.

This patch uses HNS3_NIC_STATE_RESETTING flag to implement that,
and adds hns3_nic_resetting() to indicate which operation is not
allowed.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_dcbnl.c   | 12 ++++++++++++
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 10 ++++++++++
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |  7 +++++++
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 19 +++++++++++++++++++
 4 files changed, 48 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_dcbnl.c b/drivers/net/ethernet/hisilicon/hns3/hns3_dcbnl.c
index ea5f8a8..b6fabbb 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_dcbnl.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_dcbnl.c
@@ -9,6 +9,9 @@ int hns3_dcbnl_ieee_getets(struct net_device *ndev, struct ieee_ets *ets)
 {
 	struct hnae3_handle *h = hns3_get_handle(ndev);
 
+	if (hns3_nic_resetting(ndev))
+		return -EBUSY;
+
 	if (h->kinfo.dcb_ops->ieee_getets)
 		return h->kinfo.dcb_ops->ieee_getets(h, ets);
 
@@ -20,6 +23,9 @@ int hns3_dcbnl_ieee_setets(struct net_device *ndev, struct ieee_ets *ets)
 {
 	struct hnae3_handle *h = hns3_get_handle(ndev);
 
+	if (hns3_nic_resetting(ndev))
+		return -EBUSY;
+
 	if (h->kinfo.dcb_ops->ieee_setets)
 		return h->kinfo.dcb_ops->ieee_setets(h, ets);
 
@@ -31,6 +37,9 @@ int hns3_dcbnl_ieee_getpfc(struct net_device *ndev, struct ieee_pfc *pfc)
 {
 	struct hnae3_handle *h = hns3_get_handle(ndev);
 
+	if (hns3_nic_resetting(ndev))
+		return -EBUSY;
+
 	if (h->kinfo.dcb_ops->ieee_getpfc)
 		return h->kinfo.dcb_ops->ieee_getpfc(h, pfc);
 
@@ -42,6 +51,9 @@ int hns3_dcbnl_ieee_setpfc(struct net_device *ndev, struct ieee_pfc *pfc)
 {
 	struct hnae3_handle *h = hns3_get_handle(ndev);
 
+	if (hns3_nic_resetting(ndev))
+		return -EBUSY;
+
 	if (h->kinfo.dcb_ops->ieee_setpfc)
 		return h->kinfo.dcb_ops->ieee_setpfc(h, pfc);
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index e4cf3247..d573f5f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -384,6 +384,9 @@ static int hns3_nic_net_open(struct net_device *netdev)
 	struct hnae3_knic_private_info *kinfo;
 	int i, ret;
 
+	if (hns3_nic_resetting(netdev))
+		return -EBUSY;
+
 	netif_carrier_off(netdev);
 
 	ret = hns3_nic_set_real_num_queue(netdev);
@@ -3749,6 +3752,10 @@ static int hns3_reset_notify_down_enet(struct hnae3_handle *handle)
 	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(handle->pdev);
 	struct hnae3_knic_private_info *kinfo = &handle->kinfo;
 	struct net_device *ndev = kinfo->netdev;
+	struct hns3_nic_priv *priv = netdev_priv(ndev);
+
+	if (test_and_set_bit(HNS3_NIC_STATE_RESETTING, &priv->state))
+		return 0;
 
 	/* it is cumbersome for hardware to pick-and-choose entries for deletion
 	 * from table space. Hence, for function reset software intervention is
@@ -3768,6 +3775,7 @@ static int hns3_reset_notify_down_enet(struct hnae3_handle *handle)
 static int hns3_reset_notify_up_enet(struct hnae3_handle *handle)
 {
 	struct hnae3_knic_private_info *kinfo = &handle->kinfo;
+	struct hns3_nic_priv *priv = netdev_priv(kinfo->netdev);
 	int ret = 0;
 
 	if (netif_running(kinfo->netdev)) {
@@ -3780,6 +3788,8 @@ static int hns3_reset_notify_up_enet(struct hnae3_handle *handle)
 		handle->last_reset_time = jiffies;
 	}
 
+	clear_bit(HNS3_NIC_STATE_RESETTING, &priv->state);
+
 	return ret;
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index 3e9db73..cfd6a71 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -599,6 +599,13 @@ static inline bool hns3_dev_ongoing_func_reset(struct hnae3_ae_dev *ae_dev)
 #define hns3_read_dev(a, reg) \
 	hns3_read_reg((a)->io_base, (reg))
 
+static inline bool hns3_nic_resetting(struct net_device *netdev)
+{
+	struct hns3_nic_priv *priv = netdev_priv(netdev);
+
+	return test_bit(HNS3_NIC_STATE_RESETTING, &priv->state);
+}
+
 #define hns3_write_dev(a, reg, value) \
 	hns3_write_reg((a)->io_base, (reg), (value))
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index a4762c2..4563638 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -291,6 +291,11 @@ static void hns3_self_test(struct net_device *ndev,
 	int test_index = 0;
 	u32 i;
 
+	if (hns3_nic_resetting(ndev)) {
+		netdev_err(ndev, "dev resetting!");
+		return;
+	}
+
 	/* Only do offline selftest, or pass by default */
 	if (eth_test->flags != ETH_TEST_FL_OFFLINE)
 		return;
@@ -530,6 +535,11 @@ static void hns3_get_ringparam(struct net_device *netdev,
 	struct hnae3_handle *h = priv->ae_handle;
 	int queue_num = h->kinfo.num_tqps;
 
+	if (hns3_nic_resetting(netdev)) {
+		netdev_err(netdev, "dev resetting!");
+		return;
+	}
+
 	param->tx_max_pending = HNS3_RING_MAX_PENDING;
 	param->rx_max_pending = HNS3_RING_MAX_PENDING;
 
@@ -760,6 +770,9 @@ static int hns3_set_ringparam(struct net_device *ndev,
 	u32 old_desc_num, new_desc_num;
 	int ret;
 
+	if (hns3_nic_resetting(ndev))
+		return -EBUSY;
+
 	if (param->rx_mini_pending || param->rx_jumbo_pending)
 		return -EINVAL;
 
@@ -872,6 +885,9 @@ static int hns3_get_coalesce_per_queue(struct net_device *netdev, u32 queue,
 	struct hnae3_handle *h = priv->ae_handle;
 	u16 queue_num = h->kinfo.num_tqps;
 
+	if (hns3_nic_resetting(netdev))
+		return -EBUSY;
+
 	if (queue >= queue_num) {
 		netdev_err(netdev,
 			   "Invalid queue value %d! Queue max id=%d\n",
@@ -1033,6 +1049,9 @@ static int hns3_set_coalesce(struct net_device *netdev,
 	int ret;
 	int i;
 
+	if (hns3_nic_resetting(netdev))
+		return -EBUSY;
+
 	ret = hns3_check_coalesce_para(netdev, cmd);
 	if (ret)
 		return ret;
-- 
2.7.4


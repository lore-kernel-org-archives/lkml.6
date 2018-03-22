Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755552AbeCVOch (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 10:32:37 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6258 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754358AbeCVOaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 10:30:07 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <mehta.salil.lnk@gmail.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH net-next 1/9] net: hns3: Changes to make enet watchdog timeout func common for PF/VF
Date: Thu, 22 Mar 2018 14:28:52 +0000
Message-ID: <20180322142900.22860-2-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180322142900.22860-1-salil.mehta@huawei.com>
References: <20180322142900.22860-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.47]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HNS3 drivers enet layer, used for the ring management and stack
interaction, is common to both VF and PF. PF already supports reset
functionality to handle the network stack watchdog timeout trigger
but the existing code is not generic enough to be used to support VF
reset as well.
This patch does following:
1. Makes the existing watchdog timeout handler in enet layer generic
   i.e. suitable for both VF and PF and
2. Introduces the new reset event handler for the VF code.
3. Changes existing reset event handler of PF code to initialize the
   reset level

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |  7 +++--
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 30 +++++-------------
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |  2 --
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 36 ++++++++++++----------
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 14 +++++++++
 5 files changed, 46 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 9daa88d..56f9e650 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -118,6 +118,7 @@ enum hnae3_reset_notify_type {
 };
 
 enum hnae3_reset_type {
+	HNAE3_VF_RESET,
 	HNAE3_FUNC_RESET,
 	HNAE3_CORE_RESET,
 	HNAE3_GLOBAL_RESET,
@@ -400,8 +401,7 @@ struct hnae3_ae_ops {
 	int (*set_vf_vlan_filter)(struct hnae3_handle *handle, int vfid,
 				  u16 vlan, u8 qos, __be16 proto);
 	int (*enable_hw_strip_rxvtag)(struct hnae3_handle *handle, bool enable);
-	void (*reset_event)(struct hnae3_handle *handle,
-			    enum hnae3_reset_type reset);
+	void (*reset_event)(struct hnae3_handle *handle);
 	void (*get_channels)(struct hnae3_handle *handle,
 			     struct ethtool_channels *ch);
 	void (*get_tqps_and_rss_info)(struct hnae3_handle *h,
@@ -495,6 +495,9 @@ struct hnae3_handle {
 	struct hnae3_ae_algo *ae_algo;  /* the class who provides this handle */
 	u64 flags; /* Indicate the capabilities for this handle*/
 
+	unsigned long last_reset_time;
+	enum hnae3_reset_type reset_level;
+
 	union {
 		struct net_device *netdev; /* first member */
 		struct hnae3_knic_private_info kinfo;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 0b4a676..40a3eb7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -320,7 +320,7 @@ static int hns3_nic_net_open(struct net_device *netdev)
 		return ret;
 	}
 
-	priv->last_reset_time = jiffies;
+	priv->ae_handle->last_reset_time = jiffies;
 	return 0;
 }
 
@@ -1543,7 +1543,6 @@ static bool hns3_get_tx_timeo_queue_info(struct net_device *ndev)
 static void hns3_nic_net_timeout(struct net_device *ndev)
 {
 	struct hns3_nic_priv *priv = netdev_priv(ndev);
-	unsigned long last_reset_time = priv->last_reset_time;
 	struct hnae3_handle *h = priv->ae_handle;
 
 	if (!hns3_get_tx_timeo_queue_info(ndev))
@@ -1551,24 +1550,12 @@ static void hns3_nic_net_timeout(struct net_device *ndev)
 
 	priv->tx_timeout_count++;
 
-	/* This timeout is far away enough from last timeout,
-	 * if timeout again,set the reset type to PF reset
-	 */
-	if (time_after(jiffies, (last_reset_time + 20 * HZ)))
-		priv->reset_level = HNAE3_FUNC_RESET;
-
-	/* Don't do any new action before the next timeout */
-	else if (time_before(jiffies, (last_reset_time + ndev->watchdog_timeo)))
+	if (time_before(jiffies, (h->last_reset_time + ndev->watchdog_timeo)))
 		return;
 
-	priv->last_reset_time = jiffies;
-
+	/* request the reset */
 	if (h->ae_algo->ops->reset_event)
-		h->ae_algo->ops->reset_event(h, priv->reset_level);
-
-	priv->reset_level++;
-	if (priv->reset_level > HNAE3_GLOBAL_RESET)
-		priv->reset_level = HNAE3_GLOBAL_RESET;
+		h->ae_algo->ops->reset_event(h);
 }
 
 static const struct net_device_ops hns3_nic_netdev_ops = {
@@ -3122,8 +3109,8 @@ static int hns3_client_init(struct hnae3_handle *handle)
 	priv->dev = &pdev->dev;
 	priv->netdev = netdev;
 	priv->ae_handle = handle;
-	priv->last_reset_time = jiffies;
-	priv->reset_level = HNAE3_FUNC_RESET;
+	priv->ae_handle->reset_level = HNAE3_NONE_RESET;
+	priv->ae_handle->last_reset_time = jiffies;
 	priv->tx_timeout_count = 0;
 
 	handle->kinfo.netdev = netdev;
@@ -3355,7 +3342,6 @@ static int hns3_reset_notify_down_enet(struct hnae3_handle *handle)
 static int hns3_reset_notify_up_enet(struct hnae3_handle *handle)
 {
 	struct hnae3_knic_private_info *kinfo = &handle->kinfo;
-	struct hns3_nic_priv *priv = netdev_priv(kinfo->netdev);
 	int ret = 0;
 
 	if (netif_running(kinfo->netdev)) {
@@ -3365,8 +3351,7 @@ static int hns3_reset_notify_up_enet(struct hnae3_handle *handle)
 				   "hns net up fail, ret=%d!\n", ret);
 			return ret;
 		}
-
-		priv->last_reset_time = jiffies;
+		handle->last_reset_time = jiffies;
 	}
 
 	return ret;
@@ -3378,7 +3363,6 @@ static int hns3_reset_notify_init_enet(struct hnae3_handle *handle)
 	struct hns3_nic_priv *priv = netdev_priv(netdev);
 	int ret;
 
-	priv->reset_level = 1;
 	hns3_init_mac_addr(netdev);
 	hns3_nic_set_rx_mode(netdev);
 	hns3_recover_hw_addr(netdev);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index 39daa01..9e4cfbb 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -532,8 +532,6 @@ struct hns3_nic_priv {
 	/* The most recently read link state */
 	int link;
 	u64 tx_timeout_count;
-	enum hnae3_reset_type reset_level;
-	unsigned long last_reset_time;
 
 	unsigned long state;
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 31e90b5..a3e00da 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2845,27 +2845,31 @@ static void hclge_reset(struct hclge_dev *hdev)
 	hclge_notify_client(hdev, HNAE3_UP_CLIENT);
 }
 
-static void hclge_reset_event(struct hnae3_handle *handle,
-			      enum hnae3_reset_type reset)
+static void hclge_reset_event(struct hnae3_handle *handle)
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
 
-	dev_info(&hdev->pdev->dev,
-		 "Receive reset event , reset_type is %d", reset);
+	/* check if this is a new reset request and we are not here just because
+	 * last reset attempt did not succeed and watchdog hit us again. We will
+	 * know this if last reset request did not occur very recently (watchdog
+	 * timer = 5*HZ, let us check after sufficiently large time, say 4*5*Hz)
+	 * In case of new request we reset the "reset level" to PF reset.
+	 */
+	if (time_after(jiffies, (handle->last_reset_time + 4 * 5 * HZ)))
+		handle->reset_level = HNAE3_FUNC_RESET;
 
-	switch (reset) {
-	case HNAE3_FUNC_RESET:
-	case HNAE3_CORE_RESET:
-	case HNAE3_GLOBAL_RESET:
-		/* request reset & schedule reset task */
-		set_bit(reset, &hdev->reset_request);
-		hclge_reset_task_schedule(hdev);
-		break;
-	default:
-		dev_warn(&hdev->pdev->dev, "Unsupported reset event:%d", reset);
-		break;
-	}
+	dev_info(&hdev->pdev->dev, "received reset event , reset type is %d",
+		 handle->reset_level);
+
+	/* request reset & schedule reset task */
+	set_bit(handle->reset_level, &hdev->reset_request);
+	hclge_reset_task_schedule(hdev);
+
+	if (handle->reset_level < HNAE3_GLOBAL_RESET)
+		handle->reset_level++;
+
+	handle->last_reset_time = jiffies;
 }
 
 static void hclge_reset_subtask(struct hclge_dev *hdev)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 906dfa3..6c3881d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -832,6 +832,19 @@ static void hclgevf_reset_tqp(struct hnae3_handle *handle, u16 queue_id)
 			     2, true, NULL, 0);
 }
 
+static void hclgevf_reset_event(struct hnae3_handle *handle)
+{
+	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
+
+	dev_info(&hdev->pdev->dev, "received reset request from VF enet\n");
+
+	handle->reset_level = HNAE3_VF_RESET;
+
+	/* request VF reset here. Code added later */
+
+	handle->last_reset_time = jiffies;
+}
+
 static u32 hclgevf_get_fw_version(struct hnae3_handle *handle)
 {
 	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
@@ -1526,6 +1539,7 @@ static const struct hnae3_ae_ops hclgevf_ops = {
 	.get_tc_size = hclgevf_get_tc_size,
 	.get_fw_version = hclgevf_get_fw_version,
 	.set_vlan_filter = hclgevf_set_vlan_filter,
+	.reset_event = hclgevf_reset_event,
 	.get_channels = hclgevf_get_channels,
 	.get_tqps_and_rss_info = hclgevf_get_tqps_and_rss_info,
 	.get_status = hclgevf_get_status,
-- 
2.7.4

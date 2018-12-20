Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67706C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 03:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3475A21741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 03:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730182AbeLTDRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 22:17:13 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:59715 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729537AbeLTDQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 22:16:26 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F21EE43DB2EE2;
        Thu, 20 Dec 2018 11:16:19 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.408.0; Thu, 20 Dec 2018 11:16:14 +0800
From:   Peng Li <lipeng321@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
Subject: [PATCH net-next 1/9] net: hns3: refine the handle for hns3_nic_net_open/stop()
Date:   Thu, 20 Dec 2018 11:51:58 +0800
Message-ID: <1545277926-66432-2-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1545277926-66432-1-git-send-email-lipeng321@huawei.com>
References: <1545277926-66432-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

When triggering nic down, there is a time window between bringing down
the protocol stack and stopping the work task. If the net is up in the
time window, it may bring up the protocol stack again.

This patch fixes it by stop the work task at the beginning of
hns3_nic_net_stop(). To keep symmetrical, start the work task at the
end of hns3_nic_net_open().

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |  1 +
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  8 ++++++++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 22 +++++++++++++++-------
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 18 ++++++++++++++----
 4 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 845d43d..36eab37 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -461,6 +461,7 @@ struct hnae3_ae_ops {
 	unsigned long (*ae_dev_reset_cnt)(struct hnae3_handle *handle);
 	int (*set_gro_en)(struct hnae3_handle *handle, int enable);
 	u16 (*get_global_queue_id)(struct hnae3_handle *handle, u16 queue_id);
+	void (*set_timer_task)(struct hnae3_handle *handle, bool enable);
 };
 
 struct hnae3_dcb_ops {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index d060029..becbf86 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -379,6 +379,7 @@ static int hns3_nic_net_up(struct net_device *netdev)
 
 static int hns3_nic_net_open(struct net_device *netdev)
 {
+	struct hns3_nic_priv *priv = netdev_priv(netdev);
 	struct hnae3_handle *h = hns3_get_handle(netdev);
 	struct hnae3_knic_private_info *kinfo;
 	int i, ret;
@@ -405,6 +406,9 @@ static int hns3_nic_net_open(struct net_device *netdev)
 				       kinfo->prio_tc[i]);
 	}
 
+	if (h->ae_algo->ops->set_timer_task)
+		h->ae_algo->ops->set_timer_task(priv->ae_handle, true);
+
 	return 0;
 }
 
@@ -437,10 +441,14 @@ static void hns3_nic_net_down(struct net_device *netdev)
 static int hns3_nic_net_stop(struct net_device *netdev)
 {
 	struct hns3_nic_priv *priv = netdev_priv(netdev);
+	struct hnae3_handle *h = hns3_get_handle(netdev);
 
 	if (test_and_set_bit(HNS3_NIC_STATE_DOWN, &priv->state))
 		return 0;
 
+	if (h->ae_algo->ops->set_timer_task)
+		h->ae_algo->ops->set_timer_task(priv->ae_handle, false);
+
 	netif_tx_stop_all_queues(netdev);
 	netif_carrier_off(netdev);
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index d0e84de..a12cb14 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -5295,6 +5295,20 @@ static void hclge_reset_tqp_stats(struct hnae3_handle *handle)
 	}
 }
 
+static void hclge_set_timer_task(struct hnae3_handle *handle, bool enable)
+{
+	struct hclge_vport *vport = hclge_get_vport(handle);
+	struct hclge_dev *hdev = vport->back;
+
+	if (enable) {
+		mod_timer(&hdev->service_timer, jiffies + HZ);
+	} else {
+		del_timer_sync(&hdev->service_timer);
+		cancel_work_sync(&hdev->service_task);
+		clear_bit(HCLGE_STATE_SERVICE_SCHED, &hdev->state);
+	}
+}
+
 static int hclge_ae_start(struct hnae3_handle *handle)
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
@@ -5303,7 +5317,6 @@ static int hclge_ae_start(struct hnae3_handle *handle)
 	/* mac enable */
 	hclge_cfg_mac_mode(hdev, true);
 	clear_bit(HCLGE_STATE_DOWN, &hdev->state);
-	mod_timer(&hdev->service_timer, jiffies + HZ);
 	hdev->hw.mac.link = 0;
 
 	/* reset tqp stats */
@@ -5321,10 +5334,6 @@ static void hclge_ae_stop(struct hnae3_handle *handle)
 
 	set_bit(HCLGE_STATE_DOWN, &hdev->state);
 
-	del_timer_sync(&hdev->service_timer);
-	cancel_work_sync(&hdev->service_task);
-	clear_bit(HCLGE_STATE_SERVICE_SCHED, &hdev->state);
-
 	/* If it is not PF reset, the firmware will disable the MAC,
 	 * so it only need to stop phy here.
 	 */
@@ -5341,8 +5350,6 @@ static void hclge_ae_stop(struct hnae3_handle *handle)
 
 	/* reset tqp stats */
 	hclge_reset_tqp_stats(handle);
-	del_timer_sync(&hdev->service_timer);
-	cancel_work_sync(&hdev->service_task);
 	hclge_update_link_status(hdev);
 }
 
@@ -7996,6 +8003,7 @@ static int hclge_gro_en(struct hnae3_handle *handle, int enable)
 	.ae_dev_reset_cnt = hclge_ae_dev_reset_cnt,
 	.set_gro_en = hclge_gro_en,
 	.get_global_queue_id = hclge_covert_handle_qid_global,
+	.set_timer_task = hclge_set_timer_task,
 };
 
 static struct hnae3_ae_algo ae_algo = {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 54ba93a..919c3aa 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1840,6 +1840,19 @@ static int hclgevf_init_vlan_config(struct hclgevf_dev *hdev)
 				       false);
 }
 
+static void hclgevf_set_timer_task(struct hnae3_handle *handle, bool enable)
+{
+	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
+
+	if (enable) {
+		mod_timer(&hdev->service_timer, jiffies + HZ);
+	} else {
+		del_timer_sync(&hdev->service_timer);
+		cancel_work_sync(&hdev->service_task);
+		clear_bit(HCLGEVF_STATE_SERVICE_SCHED, &hdev->state);
+	}
+}
+
 static int hclgevf_ae_start(struct hnae3_handle *handle)
 {
 	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
@@ -1850,7 +1863,6 @@ static int hclgevf_ae_start(struct hnae3_handle *handle)
 	hclgevf_request_link_info(hdev);
 
 	clear_bit(HCLGEVF_STATE_DOWN, &hdev->state);
-	mod_timer(&hdev->service_timer, jiffies + HZ);
 
 	return 0;
 }
@@ -1863,9 +1875,6 @@ static void hclgevf_ae_stop(struct hnae3_handle *handle)
 
 	/* reset tqp stats */
 	hclgevf_reset_tqp_stats(handle);
-	del_timer_sync(&hdev->service_timer);
-	cancel_work_sync(&hdev->service_task);
-	clear_bit(HCLGEVF_STATE_SERVICE_SCHED, &hdev->state);
 	hclgevf_update_link_status(hdev, 0);
 }
 
@@ -2663,6 +2672,7 @@ static void hclgevf_get_regs(struct hnae3_handle *handle, u32 *version,
 	.set_gro_en = hclgevf_gro_en,
 	.set_mtu = hclgevf_set_mtu,
 	.get_global_queue_id = hclgevf_get_qid_global,
+	.set_timer_task = hclgevf_set_timer_task,
 };
 
 static struct hnae3_ae_algo ae_algovf = {
-- 
1.9.1


Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14393C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D14AF21473
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:04:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D14AF21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbeJFAEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 20:04:14 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53819 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728021AbeJFAEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 20:04:13 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1F04CD57AB9FD;
        Sat,  6 Oct 2018 01:04:34 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.399.0; Sat, 6 Oct 2018 01:04:28 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>
Subject: [PATCH net-next 2/6] net: hns3: Clear mac vlan table entries when unload driver or function reset
Date:   Fri, 5 Oct 2018 18:03:25 +0100
Message-ID: <20181005170329.6512-3-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20181005170329.6512-1-salil.mehta@huawei.com>
References: <20181005170329.6512-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

In original codes, the mac vlan table entries are not cleared when
unload hns3 driver. The dirty mac vlan table entries will make the
result of looking up mac vlan table being unexpected.

When doing core reset or global reset, the firmware will clear all
the tables for driver, and driver shouldn't send any commands to
firmware during reset. But when doing function reset, the driver
needs to clear the tables itself.

This patch clears the mac vlan table entries for each client when
unload driver or reset.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 45 +++++++++++++++----------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index c269256..d8b8ccf 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -21,6 +21,7 @@
 
 static void hns3_clear_all_ring(struct hnae3_handle *h);
 static void hns3_force_clear_all_rx_ring(struct hnae3_handle *h);
+static void hns3_remove_hw_addr(struct net_device *netdev);
 
 static const char hns3_driver_name[] = "hns3";
 const char hns3_driver_version[] = VERMAGIC_STRING;
@@ -3155,15 +3156,6 @@ static void hns3_init_mac_addr(struct net_device *netdev, bool init)
 
 }
 
-static void hns3_uninit_mac_addr(struct net_device *netdev)
-{
-	struct hns3_nic_priv *priv = netdev_priv(netdev);
-	struct hnae3_handle *h = priv->ae_handle;
-
-	if (h->ae_algo->ops->rm_uc_addr)
-		h->ae_algo->ops->rm_uc_addr(h, netdev->dev_addr);
-}
-
 static int hns3_restore_fd_rules(struct net_device *netdev)
 {
 	struct hnae3_handle *h = hns3_get_handle(netdev);
@@ -3296,6 +3288,8 @@ static void hns3_client_uninit(struct hnae3_handle *handle, bool reset)
 	struct hns3_nic_priv *priv = netdev_priv(netdev);
 	int ret;
 
+	hns3_remove_hw_addr(netdev);
+
 	if (netdev->reg_state != NETREG_UNINITIALIZED)
 		unregister_netdev(netdev);
 
@@ -3319,8 +3313,6 @@ static void hns3_client_uninit(struct hnae3_handle *handle, bool reset)
 
 	priv->ring_data = NULL;
 
-	hns3_uninit_mac_addr(netdev);
-
 	free_netdev(netdev);
 }
 
@@ -3392,6 +3384,25 @@ static void hns3_recover_hw_addr(struct net_device *ndev)
 		hns3_nic_mc_sync(ndev, ha->addr);
 }
 
+static void hns3_remove_hw_addr(struct net_device *netdev)
+{
+	struct netdev_hw_addr_list *list;
+	struct netdev_hw_addr *ha, *tmp;
+
+	hns3_nic_uc_unsync(netdev, netdev->dev_addr);
+
+	/* go through and unsync uc_addr entries to the device */
+	list = &netdev->uc;
+	list_for_each_entry_safe(ha, tmp, &list->list, list)
+		hns3_nic_uc_unsync(netdev, ha->addr);
+
+	/* go through and unsync mc_addr entries to the device */
+	list = &netdev->mc;
+	list_for_each_entry_safe(ha, tmp, &list->list, list)
+		if (ha->refcount > 1)
+			hns3_nic_mc_unsync(netdev, ha->addr);
+}
+
 static void hns3_clear_tx_ring(struct hns3_enet_ring *ring)
 {
 	while (ring->next_to_clean != ring->next_to_use) {
@@ -3637,14 +3648,14 @@ static int hns3_reset_notify_uninit_enet(struct hnae3_handle *handle)
 	if (ret)
 		netdev_err(netdev, "uninit ring error\n");
 
-	hns3_uninit_mac_addr(netdev);
-
-	/* it is cumbersome for hardware to pick-and-choose rules for deletion
-	 * from TCAM. Hence, for function reset software intervention is
-	 * required to delete the rules
+	/* it is cumbersome for hardware to pick-and-choose entries for deletion
+	 * from table space. Hence, for function reset software intervention is
+	 * required to delete the entries
 	 */
-	if (hns3_dev_ongoing_func_reset(ae_dev))
+	if (hns3_dev_ongoing_func_reset(ae_dev)) {
+		hns3_remove_hw_addr(netdev);
 		hns3_del_all_fd_rules(netdev, false);
+	}
 
 	return ret;
 }
-- 
2.7.4



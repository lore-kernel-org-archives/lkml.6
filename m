Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEB9ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 19:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF8821486
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 19:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF8821486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbeJTDYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 23:24:35 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43084 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727680AbeJTDYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 23:24:34 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A6D4073E6F0;
        Sat, 20 Oct 2018 03:17:07 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.399.0; Sat, 20 Oct 2018 03:17:00 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH net-next 2/7] net: hns3: Add PCIe AER error recovery
Date:   Fri, 19 Oct 2018 20:15:27 +0100
Message-ID: <20181019191532.10088-3-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20181019191532.10088-1-salil.mehta@huawei.com>
References: <20181019191532.10088-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shiju Jose <shiju.jose@huawei.com>

This patch adds the error recovery for the HNS hw errors.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h          |  2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c      | 20 +++++++++++++++++++-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c  | 17 +++++++++++++----
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c    |  3 ++-
 4 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 2af3a2d..e82e4ca 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -402,7 +402,7 @@ struct hnae3_ae_ops {
 	int (*set_vf_vlan_filter)(struct hnae3_handle *handle, int vfid,
 				  u16 vlan, u8 qos, __be16 proto);
 	int (*enable_hw_strip_rxvtag)(struct hnae3_handle *handle, bool enable);
-	void (*reset_event)(struct hnae3_handle *handle);
+	void (*reset_event)(struct pci_dev *pdev, struct hnae3_handle *handle);
 	void (*get_channels)(struct hnae3_handle *handle,
 			     struct ethtool_channels *ch);
 	void (*get_tqps_and_rss_info)(struct hnae3_handle *h,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 3c6fa39..32f3aca8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -9,6 +9,7 @@
 #include <linux/ipv6.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/aer.h>
 #include <linux/skbuff.h>
 #include <linux/sctp.h>
 #include <linux/vermagic.h>
@@ -1613,7 +1614,7 @@ static void hns3_nic_net_timeout(struct net_device *ndev)
 
 	/* request the reset */
 	if (h->ae_algo->ops->reset_event)
-		h->ae_algo->ops->reset_event(h);
+		h->ae_algo->ops->reset_event(h->pdev, h);
 }
 
 static const struct net_device_ops hns3_nic_netdev_ops = {
@@ -1796,8 +1797,25 @@ static pci_ers_result_t hns3_error_detected(struct pci_dev *pdev,
 	return ret;
 }
 
+static pci_ers_result_t hns3_slot_reset(struct pci_dev *pdev)
+{
+	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+
+	dev_info(dev, "requesting reset due to PCI error\n");
+
+	/* request the reset */
+	if (ae_dev->ops->reset_event) {
+		ae_dev->ops->reset_event(pdev, NULL);
+		return PCI_ERS_RESULT_RECOVERED;
+	}
+
+	return PCI_ERS_RESULT_DISCONNECT;
+}
+
 static const struct pci_error_handlers hns3_err_handler = {
 	.error_detected = hns3_error_detected,
+	.slot_reset     = hns3_slot_reset,
 };
 
 static struct pci_driver hns3_driver = {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 94d3678..5075365 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2489,12 +2489,18 @@ static void hclge_reset(struct hclge_dev *hdev)
 	ae_dev->reset_type = HNAE3_NONE_RESET;
 }
 
-static void hclge_reset_event(struct hnae3_handle *handle)
+static void hclge_reset_event(struct pci_dev *pdev, struct hnae3_handle *handle)
 {
-	struct hclge_vport *vport = hclge_get_vport(handle);
-	struct hclge_dev *hdev = vport->back;
+	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(pdev);
+	struct hclge_dev *hdev = ae_dev->priv;
 
-	/* check if this is a new reset request and we are not here just because
+	/* We might end up getting called broadly because of 2 below cases:
+	 * 1. Recoverable error was conveyed through APEI and only way to bring
+	 *    normalcy is to reset.
+	 * 2. A new reset request from the stack due to timeout
+	 *
+	 * For the first case,error event might not have ae handle available.
+	 * check if this is a new reset request and we are not here just because
 	 * last reset attempt did not succeed and watchdog hit us again. We will
 	 * know this if last reset request did not occur very recently (watchdog
 	 * timer = 5*HZ, let us check after sufficiently large time, say 4*5*Hz)
@@ -2503,6 +2509,9 @@ static void hclge_reset_event(struct hnae3_handle *handle)
 	 * want to make sure we throttle the reset request. Therefore, we will
 	 * not allow it again before 3*HZ times.
 	 */
+	if (!handle)
+		handle = &hdev->vport[0].nic;
+
 	if (time_before(jiffies, (handle->last_reset_time + 3 * HZ)))
 		return;
 	else if (time_after(jiffies, (handle->last_reset_time + 4 * 5 * HZ)))
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index ac67fec..e0a86a5 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1214,7 +1214,8 @@ static int hclgevf_do_reset(struct hclgevf_dev *hdev)
 	return status;
 }
 
-static void hclgevf_reset_event(struct hnae3_handle *handle)
+static void hclgevf_reset_event(struct pci_dev *pdev,
+				struct hnae3_handle *handle)
 {
 	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
 
-- 
2.7.4



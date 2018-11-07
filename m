Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA74CC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 04:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C48208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 04:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C48208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388334AbeKGNex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 08:34:53 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:14607 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727289AbeKGNew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 08:34:52 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C3675BD520392;
        Wed,  7 Nov 2018 12:06:11 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.408.0; Wed, 7 Nov 2018 12:06:05 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>
Subject: [Patch net-next 02/12] net: hns3: add set_default_reset_request in the hnae3_ae_ops
Date:   Wed, 7 Nov 2018 12:06:08 +0800
Message-ID: <1541563578-28973-3-git-send-email-tanhuazhong@huawei.com>
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

Currently, when reset_event is called because of tx timeout, it will
upgrade the reset level (For PF, HNAE3_FUNC_RESET -> HNAE3_CORE_RESET
-> HNAE3_GLOBAL_RESET) if the time between the new reset and last reset
is within 20 secs, or restore the reset level to HNAE3_FUNC_RESET if
the time between the new reset and last reset is over 20 secs.

There is requirement that the caller needs to decide the reset level
when triggering a reset, for example, RAS recovery. So this patch
adds the set_default_reset_request to meet this requirement.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |  2 ++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 13 ++++++++++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  1 +
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 29 +++++++++++++++++++++-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |  1 +
 5 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 055b406..7deab92 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -403,6 +403,8 @@ struct hnae3_ae_ops {
 				  u16 vlan, u8 qos, __be16 proto);
 	int (*enable_hw_strip_rxvtag)(struct hnae3_handle *handle, bool enable);
 	void (*reset_event)(struct pci_dev *pdev, struct hnae3_handle *handle);
+	void (*set_default_reset_request)(struct hnae3_ae_dev *ae_dev,
+					  enum hnae3_reset_type rst_type);
 	void (*get_channels)(struct hnae3_handle *handle,
 			     struct ethtool_channels *ch);
 	void (*get_tqps_and_rss_info)(struct hnae3_handle *h,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index ffdd960..5e6006b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2517,6 +2517,10 @@ static void hclge_reset_event(struct pci_dev *pdev, struct hnae3_handle *handle)
 
 	if (time_before(jiffies, (handle->last_reset_time + 3 * HZ)))
 		return;
+	else if (hdev->default_reset_request)
+		handle->reset_level =
+			hclge_get_reset_level(hdev,
+					      &hdev->default_reset_request);
 	else if (time_after(jiffies, (handle->last_reset_time + 4 * 5 * HZ)))
 		handle->reset_level = HNAE3_FUNC_RESET;
 
@@ -2531,6 +2535,14 @@ static void hclge_reset_event(struct pci_dev *pdev, struct hnae3_handle *handle)
 		handle->reset_level++;
 }
 
+static void hclge_set_def_reset_request(struct hnae3_ae_dev *ae_dev,
+					enum hnae3_reset_type rst_type)
+{
+	struct hclge_dev *hdev = ae_dev->priv;
+
+	set_bit(rst_type, &hdev->default_reset_request);
+}
+
 static void hclge_reset_subtask(struct hclge_dev *hdev)
 {
 	/* check if there is any ongoing reset in the hardware. This status can
@@ -7321,6 +7333,7 @@ static const struct hnae3_ae_ops hclge_ops = {
 	.set_vf_vlan_filter = hclge_set_vf_vlan_filter,
 	.enable_hw_strip_rxvtag = hclge_en_hw_strip_rxvtag,
 	.reset_event = hclge_reset_event,
+	.set_default_reset_request = hclge_set_def_reset_request,
 	.get_tqps_and_rss_info = hclge_get_tqps_and_rss_info,
 	.set_channels = hclge_set_channels,
 	.get_channels = hclge_get_channels,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 0d92154..7cfb61e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -595,6 +595,7 @@ struct hclge_dev {
 	unsigned long state;
 
 	enum hnae3_reset_type reset_type;
+	unsigned long default_reset_request;
 	unsigned long reset_request;	/* reset has been requested */
 	unsigned long reset_pending;	/* client rst is pending to be served */
 	u32 fw_version;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 085edb9..42982fc 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1219,6 +1219,19 @@ static int hclgevf_do_reset(struct hclgevf_dev *hdev)
 	return status;
 }
 
+static enum hnae3_reset_type hclgevf_get_reset_level(struct hclgevf_dev *hdev,
+						     unsigned long *addr)
+{
+	enum hnae3_reset_type rst_level = HNAE3_NONE_RESET;
+
+	if (test_bit(HNAE3_VF_RESET, addr)) {
+		rst_level = HNAE3_VF_RESET;
+		clear_bit(HNAE3_VF_RESET, addr);
+	}
+
+	return rst_level;
+}
+
 static void hclgevf_reset_event(struct pci_dev *pdev,
 				struct hnae3_handle *handle)
 {
@@ -1226,7 +1239,12 @@ static void hclgevf_reset_event(struct pci_dev *pdev,
 
 	dev_info(&hdev->pdev->dev, "received reset request from VF enet\n");
 
-	handle->reset_level = HNAE3_VF_RESET;
+	if (!hdev->default_reset_request)
+		handle->reset_level =
+			hclgevf_get_reset_level(hdev,
+						&hdev->default_reset_request);
+	else
+		handle->reset_level = HNAE3_VF_RESET;
 
 	/* reset of this VF requested */
 	set_bit(HCLGEVF_RESET_REQUESTED, &hdev->reset_state);
@@ -1235,6 +1253,14 @@ static void hclgevf_reset_event(struct pci_dev *pdev,
 	handle->last_reset_time = jiffies;
 }
 
+static void hclgevf_set_def_reset_request(struct hnae3_ae_dev *ae_dev,
+					  enum hnae3_reset_type rst_type)
+{
+	struct hclgevf_dev *hdev = ae_dev->priv;
+
+	set_bit(rst_type, &hdev->default_reset_request);
+}
+
 static u32 hclgevf_get_fw_version(struct hnae3_handle *handle)
 {
 	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
@@ -2193,6 +2219,7 @@ static const struct hnae3_ae_ops hclgevf_ops = {
 	.set_vlan_filter = hclgevf_set_vlan_filter,
 	.enable_hw_strip_rxvtag = hclgevf_en_hw_strip_rxvtag,
 	.reset_event = hclgevf_reset_event,
+	.set_default_reset_request = hclgevf_set_def_reset_request,
 	.get_channels = hclgevf_get_channels,
 	.get_tqps_and_rss_info = hclgevf_get_tqps_and_rss_info,
 	.get_status = hclgevf_get_status,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
index aed241e..6b2fd5a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
@@ -145,6 +145,7 @@ struct hclgevf_dev {
 	struct hclgevf_misc_vector misc_vector;
 	struct hclgevf_rss_cfg rss_cfg;
 	unsigned long state;
+	unsigned long default_reset_request;
 
 #define HCLGEVF_RESET_REQUESTED		0
 #define HCLGEVF_RESET_PENDING		1
-- 
2.7.4


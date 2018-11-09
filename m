Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9874CC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4662080D
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4662080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbeKIXsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 18:48:46 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:48892 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728420AbeKIXsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 18:48:45 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E94E3FBEC884;
        Fri,  9 Nov 2018 22:07:55 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Fri, 9 Nov 2018 22:07:47 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>
Subject: [Patch net-next 11/11] net: hns3: add PCIe FLR support for VF
Date:   Fri, 9 Nov 2018 22:07:56 +0800
Message-ID: <1541772476-41478-12-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541772476-41478-1-git-send-email-tanhuazhong@huawei.com>
References: <1541772476-41478-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements the .reset_prepare and .reset_done
ops from pci framework to support the VF FLR.

This patch uses hclgevf_set_def_reset_request() and
hclgevf_reset_event() to handle FLR, so when
hdev->default_reset_request is non zero, it means there is
some reset requseted by hclgevf_set_def_reset_request() need
to be processed. Also get the hdev from the ae_dev because
hclgevf_reset_event is called with handle being NULL.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 65 +++++++++++++++++++++-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |  1 +
 2 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 8f1c681..6b4d147 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1099,6 +1099,32 @@ static int hclgevf_notify_client(struct hclgevf_dev *hdev,
 	return ret;
 }
 
+static void hclgevf_flr_done(struct hnae3_ae_dev *ae_dev)
+{
+	struct hclgevf_dev *hdev = ae_dev->priv;
+
+	set_bit(HNAE3_FLR_DONE, &hdev->flr_state);
+}
+
+static int hclgevf_flr_poll_timeout(struct hclgevf_dev *hdev,
+				    unsigned long delay_us,
+				    unsigned long wait_cnt)
+{
+	unsigned long cnt = 0;
+
+	while (!test_bit(HNAE3_FLR_DONE, &hdev->flr_state) &&
+	       cnt++ < wait_cnt)
+		usleep_range(delay_us, delay_us * 2);
+
+	if (!test_bit(HNAE3_FLR_DONE, &hdev->flr_state)) {
+		dev_err(&hdev->pdev->dev,
+			"flr wait timeout\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
 static int hclgevf_reset_wait(struct hclgevf_dev *hdev)
 {
 #define HCLGEVF_RESET_WAIT_US	20000
@@ -1113,6 +1139,11 @@ static int hclgevf_reset_wait(struct hclgevf_dev *hdev)
 	val = hclgevf_read_dev(&hdev->hw, HCLGEVF_RST_ING);
 	dev_info(&hdev->pdev->dev, "checking vf resetting status: %x\n", val);
 
+	if (hdev->reset_type == HNAE3_FLR_RESET)
+		return hclgevf_flr_poll_timeout(hdev,
+						HCLGEVF_RESET_WAIT_US,
+						HCLGEVF_RESET_WAIT_CNT);
+
 	ret = readl_poll_timeout(hdev->hw.io_base + HCLGEVF_RST_ING, val,
 				 !(val & HCLGEVF_RST_ING_BITS),
 				 HCLGEVF_RESET_WAIT_US,
@@ -1168,6 +1199,9 @@ static int hclgevf_reset_prepare_wait(struct hclgevf_dev *hdev)
 		ret = hclgevf_send_mbx_msg(hdev, HCLGE_MBX_RESET, 0, NULL,
 					   0, true, NULL, sizeof(u8));
 		break;
+	case HNAE3_FLR_RESET:
+		set_bit(HNAE3_FLR_DOWN, &hdev->flr_state);
+		break;
 	default:
 		break;
 	}
@@ -1267,6 +1301,9 @@ static enum hnae3_reset_type hclgevf_get_reset_level(struct hclgevf_dev *hdev,
 	} else if (test_bit(HNAE3_VF_FUNC_RESET, addr)) {
 		rst_level = HNAE3_VF_FUNC_RESET;
 		clear_bit(HNAE3_VF_FUNC_RESET, addr);
+	} else if (test_bit(HNAE3_FLR_RESET, addr)) {
+		rst_level = HNAE3_FLR_RESET;
+		clear_bit(HNAE3_FLR_RESET, addr);
 	}
 
 	return rst_level;
@@ -1275,11 +1312,12 @@ static enum hnae3_reset_type hclgevf_get_reset_level(struct hclgevf_dev *hdev,
 static void hclgevf_reset_event(struct pci_dev *pdev,
 				struct hnae3_handle *handle)
 {
-	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
+	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(pdev);
+	struct hclgevf_dev *hdev = ae_dev->priv;
 
 	dev_info(&hdev->pdev->dev, "received reset request from VF enet\n");
 
-	if (!hdev->default_reset_request)
+	if (hdev->default_reset_request)
 		hdev->reset_level =
 			hclgevf_get_reset_level(hdev,
 						&hdev->default_reset_request);
@@ -1301,6 +1339,27 @@ static void hclgevf_set_def_reset_request(struct hnae3_ae_dev *ae_dev,
 	set_bit(rst_type, &hdev->default_reset_request);
 }
 
+static void hclgevf_flr_prepare(struct hnae3_ae_dev *ae_dev)
+{
+#define HCLGEVF_FLR_WAIT_MS	100
+#define HCLGEVF_FLR_WAIT_CNT	50
+	struct hclgevf_dev *hdev = ae_dev->priv;
+	int cnt = 0;
+
+	clear_bit(HNAE3_FLR_DOWN, &hdev->flr_state);
+	clear_bit(HNAE3_FLR_DONE, &hdev->flr_state);
+	set_bit(HNAE3_FLR_RESET, &hdev->default_reset_request);
+	hclgevf_reset_event(hdev->pdev, NULL);
+
+	while (!test_bit(HNAE3_FLR_DOWN, &hdev->flr_state) &&
+	       cnt++ < HCLGEVF_FLR_WAIT_CNT)
+		msleep(HCLGEVF_FLR_WAIT_MS);
+
+	if (!test_bit(HNAE3_FLR_DOWN, &hdev->flr_state))
+		dev_err(&hdev->pdev->dev,
+			"flr wait down timeout: %d\n", cnt);
+}
+
 static u32 hclgevf_get_fw_version(struct hnae3_handle *handle)
 {
 	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
@@ -2310,6 +2369,8 @@ static unsigned long hclgevf_ae_dev_reset_cnt(struct hnae3_handle *handle)
 static const struct hnae3_ae_ops hclgevf_ops = {
 	.init_ae_dev = hclgevf_init_ae_dev,
 	.uninit_ae_dev = hclgevf_uninit_ae_dev,
+	.flr_prepare = hclgevf_flr_prepare,
+	.flr_done = hclgevf_flr_done,
 	.init_client_instance = hclgevf_init_client_instance,
 	.uninit_client_instance = hclgevf_uninit_client_instance,
 	.start = hclgevf_ae_start,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
index 028c52e..4c5ea7e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
@@ -161,6 +161,7 @@ struct hclgevf_dev {
 	struct hclgevf_misc_vector misc_vector;
 	struct hclgevf_rss_cfg rss_cfg;
 	unsigned long state;
+	unsigned long flr_state;
 	unsigned long default_reset_request;
 	unsigned long last_reset_time;
 	enum hnae3_reset_type reset_level;
-- 
2.7.4


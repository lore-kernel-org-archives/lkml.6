Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97738C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6817220825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:08:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6817220825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbeKIXsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 18:48:43 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:15068 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727793AbeKIXsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 18:48:42 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id ED41E5C3FCBBF;
        Fri,  9 Nov 2018 22:07:49 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Fri, 9 Nov 2018 22:07:43 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>
Subject: [Patch net-next 01/11] net: hns3: add reset_hdev to reinit the hdev in VF's reset process
Date:   Fri, 9 Nov 2018 22:07:46 +0800
Message-ID: <1541772476-41478-2-git-send-email-tanhuazhong@huawei.com>
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

When doing reset, the reset handling function only need to
reinitialize hardware, it makes sense to add a function to
do that job. Also the error handling of hclgevf_init_hdev is
different when it is used in reset process.

This patch adds reset_hdev to reinitialize hardware when resetting.
Also, this patch removes the hclgevf_dev_ongoing_full_reset because
it is unused now.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 71 ++++++++++------------
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  | 14 -----
 2 files changed, 31 insertions(+), 54 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 29da480..cdeb231 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -10,8 +10,7 @@
 
 #define HCLGEVF_NAME	"hclgevf"
 
-static int hclgevf_init_hdev(struct hclgevf_dev *hdev);
-static void hclgevf_uninit_hdev(struct hclgevf_dev *hdev);
+static int hclgevf_reset_hdev(struct hclgevf_dev *hdev);
 static struct hnae3_ae_algo ae_algovf;
 
 static const struct pci_device_id ae_algovf_pci_tbl[] = {
@@ -209,12 +208,6 @@ static int hclgevf_alloc_tqps(struct hclgevf_dev *hdev)
 	struct hclgevf_tqp *tqp;
 	int i;
 
-	/* if this is on going reset then we need to re-allocate the TPQs
-	 * since we cannot assume we would get same number of TPQs back from PF
-	 */
-	if (hclgevf_dev_ongoing_reset(hdev))
-		devm_kfree(&hdev->pdev->dev, hdev->htqp);
-
 	hdev->htqp = devm_kcalloc(&hdev->pdev->dev, hdev->num_tqps,
 				  sizeof(struct hclgevf_tqp), GFP_KERNEL);
 	if (!hdev->htqp)
@@ -258,12 +251,6 @@ static int hclgevf_knic_setup(struct hclgevf_dev *hdev)
 	new_tqps = kinfo->rss_size * kinfo->num_tc;
 	kinfo->num_tqps = min(new_tqps, hdev->num_tqps);
 
-	/* if this is on going reset then we need to re-allocate the hnae queues
-	 * as well since number of TPQs from PF might have changed.
-	 */
-	if (hclgevf_dev_ongoing_reset(hdev))
-		devm_kfree(&hdev->pdev->dev, kinfo->tqp);
-
 	kinfo->tqp = devm_kcalloc(&hdev->pdev->dev, kinfo->num_tqps,
 				  sizeof(struct hnae3_queue *), GFP_KERNEL);
 	if (!kinfo->tqp)
@@ -1141,7 +1128,7 @@ static int hclgevf_reset_stack(struct hclgevf_dev *hdev)
 	hclgevf_notify_client(hdev, HNAE3_UNINIT_CLIENT);
 
 	/* re-initialize the hclge device */
-	ret = hclgevf_init_hdev(hdev);
+	ret = hclgevf_reset_hdev(hdev);
 	if (ret) {
 		dev_err(&hdev->pdev->dev,
 			"hclge device re-init failed, VF is disabled!\n");
@@ -1615,10 +1602,6 @@ static void hclgevf_ae_stop(struct hnae3_handle *handle)
 
 static void hclgevf_state_init(struct hclgevf_dev *hdev)
 {
-	/* if this is on going reset then skip this initialization */
-	if (hclgevf_dev_ongoing_reset(hdev))
-		return;
-
 	/* setup tasks for the MBX */
 	INIT_WORK(&hdev->mbx_service_task, hclgevf_mailbox_service_task);
 	clear_bit(HCLGEVF_STATE_MBX_SERVICE_SCHED, &hdev->state);
@@ -1660,10 +1643,6 @@ static int hclgevf_init_msi(struct hclgevf_dev *hdev)
 	int vectors;
 	int i;
 
-	/* if this is on going reset then skip this initialization */
-	if (hclgevf_dev_ongoing_reset(hdev))
-		return 0;
-
 	if (hnae3_get_bit(hdev->ae_dev->flag, HNAE3_DEV_SUPPORT_ROCE_B))
 		vectors = pci_alloc_irq_vectors(pdev,
 						hdev->roce_base_msix_offset + 1,
@@ -1720,10 +1699,6 @@ static int hclgevf_misc_irq_init(struct hclgevf_dev *hdev)
 {
 	int ret = 0;
 
-	/* if this is on going reset then skip this initialization */
-	if (hclgevf_dev_ongoing_reset(hdev))
-		return 0;
-
 	hclgevf_get_misc_vector(hdev);
 
 	ret = request_irq(hdev->misc_vector.vector_irq, hclgevf_misc_irq_handle,
@@ -1853,14 +1828,6 @@ static int hclgevf_pci_init(struct hclgevf_dev *hdev)
 	struct hclgevf_hw *hw;
 	int ret;
 
-	/* check if we need to skip initialization of pci. This will happen if
-	 * device is undergoing VF reset. Otherwise, we would need to
-	 * re-initialize pci interface again i.e. when device is not going
-	 * through *any* reset or actually undergoing full reset.
-	 */
-	if (hclgevf_dev_ongoing_reset(hdev))
-		return 0;
-
 	ret = pci_enable_device(pdev);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to enable PCI device\n");
@@ -1949,17 +1916,41 @@ static int hclgevf_query_vf_resource(struct hclgevf_dev *hdev)
 	return 0;
 }
 
-static int hclgevf_init_hdev(struct hclgevf_dev *hdev)
+static int hclgevf_reset_hdev(struct hclgevf_dev *hdev)
 {
 	struct pci_dev *pdev = hdev->pdev;
 	int ret;
 
-	/* check if device is on-going full reset(i.e. pcie as well) */
-	if (hclgevf_dev_ongoing_full_reset(hdev)) {
-		dev_warn(&pdev->dev, "device is going full reset\n");
-		hclgevf_uninit_hdev(hdev);
+	ret = hclgevf_cmd_init(hdev);
+	if (ret) {
+		dev_err(&pdev->dev, "cmd failed %d\n", ret);
+		return ret;
+	}
+
+	ret = hclgevf_rss_init_hw(hdev);
+	if (ret) {
+		dev_err(&hdev->pdev->dev,
+			"failed(%d) to initialize RSS\n", ret);
+		return ret;
+	}
+
+	ret = hclgevf_init_vlan_config(hdev);
+	if (ret) {
+		dev_err(&hdev->pdev->dev,
+			"failed(%d) to initialize VLAN config\n", ret);
+		return ret;
 	}
 
+	dev_info(&hdev->pdev->dev, "Reset done\n");
+
+	return 0;
+}
+
+static int hclgevf_init_hdev(struct hclgevf_dev *hdev)
+{
+	struct pci_dev *pdev = hdev->pdev;
+	int ret;
+
 	ret = hclgevf_pci_init(hdev);
 	if (ret) {
 		dev_err(&pdev->dev, "PCI initialization failed\n");
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
index 0ea4c9b..29ae4b6 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
@@ -196,20 +196,6 @@ struct hclgevf_dev {
 	u32 flag;
 };
 
-static inline bool hclgevf_dev_ongoing_reset(struct hclgevf_dev *hdev)
-{
-	return (hdev &&
-		(test_bit(HCLGEVF_STATE_RST_HANDLING, &hdev->state)) &&
-		(hdev->reset_level == HNAE3_VF_RESET));
-}
-
-static inline bool hclgevf_dev_ongoing_full_reset(struct hclgevf_dev *hdev)
-{
-	return (hdev &&
-		(test_bit(HCLGEVF_STATE_RST_HANDLING, &hdev->state)) &&
-		(hdev->reset_level == HNAE3_VF_FULL_RESET));
-}
-
 int hclgevf_send_mbx_msg(struct hclgevf_dev *hdev, u16 code, u16 subcode,
 			 const u8 *msg_data, u8 msg_len, bool need_resp,
 			 u8 *resp_data, u16 resp_len);
-- 
2.7.4


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754873AbeCVOcd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 10:32:33 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45606 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754640AbeCVOaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 10:30:07 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <mehta.salil.lnk@gmail.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH net-next 6/9] net: hns3: Add support to re-initialize the hclge device
Date: Thu, 22 Mar 2018 14:28:57 +0000
Message-ID: <20180322142900.22860-7-salil.mehta@huawei.com>
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

After the hardware reset we should re-fetch the configuration from
PF like queue info and tc info. This might have impact on allocations
made like that of TQPs. Hence, we should release all such allocations
and re-allocate fresh according to new fetched configuration after
reset.

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 106 ++++++++++++++++++---
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |  14 +++
 2 files changed, 106 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index bd45b11..6dd7561 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -10,6 +10,8 @@
 
 #define HCLGEVF_NAME	"hclgevf"
 
+static int hclgevf_init_hdev(struct hclgevf_dev *hdev);
+static void hclgevf_uninit_hdev(struct hclgevf_dev *hdev);
 static struct hnae3_ae_algo ae_algovf;
 
 static const struct pci_device_id ae_algovf_pci_tbl[] = {
@@ -209,6 +211,12 @@ static int hclgevf_alloc_tqps(struct hclgevf_dev *hdev)
 	struct hclgevf_tqp *tqp;
 	int i;
 
+	/* if this is on going reset then we need to re-allocate the TPQs
+	 * since we cannot assume we would get same number of TPQs back from PF
+	 */
+	if (hclgevf_dev_ongoing_reset(hdev))
+		devm_kfree(&hdev->pdev->dev, hdev->htqp);
+
 	hdev->htqp = devm_kcalloc(&hdev->pdev->dev, hdev->num_tqps,
 				  sizeof(struct hclgevf_tqp), GFP_KERNEL);
 	if (!hdev->htqp)
@@ -252,6 +260,12 @@ static int hclgevf_knic_setup(struct hclgevf_dev *hdev)
 	new_tqps = kinfo->rss_size * kinfo->num_tc;
 	kinfo->num_tqps = min(new_tqps, hdev->num_tqps);
 
+	/* if this is on going reset then we need to re-allocate the hnae queues
+	 * as well since number of TPQs from PF might have changed.
+	 */
+	if (hclgevf_dev_ongoing_reset(hdev))
+		devm_kfree(&hdev->pdev->dev, kinfo->tqp);
+
 	kinfo->tqp = devm_kcalloc(&hdev->pdev->dev, kinfo->num_tqps,
 				  sizeof(struct hnae3_queue *), GFP_KERNEL);
 	if (!kinfo->tqp)
@@ -878,10 +892,18 @@ static int hclgevf_reset_wait(struct hclgevf_dev *hdev)
 
 static int hclgevf_reset_stack(struct hclgevf_dev *hdev)
 {
+	int ret;
+
 	/* uninitialize the nic client */
 	hclgevf_notify_client(hdev, HNAE3_UNINIT_CLIENT);
 
-	/* re-initialize the hclge device - add code here */
+	/* re-initialize the hclge device */
+	ret = hclgevf_init_hdev(hdev);
+	if (ret) {
+		dev_err(&hdev->pdev->dev,
+			"hclge device re-init failed, VF is disabled!\n");
+		return ret;
+	}
 
 	/* bring up the nic client again */
 	hclgevf_notify_client(hdev, HNAE3_INIT_CLIENT);
@@ -1179,6 +1201,22 @@ static int hclgevf_configure(struct hclgevf_dev *hdev)
 	return hclgevf_get_tc_info(hdev);
 }
 
+static int hclgevf_alloc_hdev(struct hnae3_ae_dev *ae_dev)
+{
+	struct pci_dev *pdev = ae_dev->pdev;
+	struct hclgevf_dev *hdev = ae_dev->priv;
+
+	hdev = devm_kzalloc(&pdev->dev, sizeof(*hdev), GFP_KERNEL);
+	if (!hdev)
+		return -ENOMEM;
+
+	hdev->pdev = pdev;
+	hdev->ae_dev = ae_dev;
+	ae_dev->priv = hdev;
+
+	return 0;
+}
+
 static int hclgevf_init_roce_base_info(struct hclgevf_dev *hdev)
 {
 	struct hnae3_handle *roce = &hdev->roce;
@@ -1284,6 +1322,10 @@ static void hclgevf_ae_stop(struct hnae3_handle *handle)
 
 static void hclgevf_state_init(struct hclgevf_dev *hdev)
 {
+	/* if this is on going reset then skip this initialization */
+	if (hclgevf_dev_ongoing_reset(hdev))
+		return;
+
 	/* setup tasks for the MBX */
 	INIT_WORK(&hdev->mbx_service_task, hclgevf_mailbox_service_task);
 	clear_bit(HCLGEVF_STATE_MBX_SERVICE_SCHED, &hdev->state);
@@ -1325,6 +1367,10 @@ static int hclgevf_init_msi(struct hclgevf_dev *hdev)
 	int vectors;
 	int i;
 
+	/* if this is on going reset then skip this initialization */
+	if (hclgevf_dev_ongoing_reset(hdev))
+		return 0;
+
 	hdev->num_msi = HCLGEVF_MAX_VF_VECTOR_NUM;
 
 	vectors = pci_alloc_irq_vectors(pdev, 1, hdev->num_msi,
@@ -1375,6 +1421,10 @@ static int hclgevf_misc_irq_init(struct hclgevf_dev *hdev)
 {
 	int ret = 0;
 
+	/* if this is on going reset then skip this initialization */
+	if (hclgevf_dev_ongoing_reset(hdev))
+		return 0;
+
 	hclgevf_get_misc_vector(hdev);
 
 	ret = request_irq(hdev->misc_vector.vector_irq, hclgevf_misc_irq_handle,
@@ -1485,6 +1535,14 @@ static int hclgevf_pci_init(struct hclgevf_dev *hdev)
 	struct hclgevf_hw *hw;
 	int ret;
 
+	/* check if we need to skip initialization of pci. This will happen if
+	 * device is undergoing VF reset. Otherwise, we would need to
+	 * re-initialize pci interface again i.e. when device is not going
+	 * through *any* reset or actually undergoing full reset.
+	 */
+	if (hclgevf_dev_ongoing_reset(hdev))
+		return 0;
+
 	ret = pci_enable_device(pdev);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to enable PCI device\n");
@@ -1536,19 +1594,16 @@ static void hclgevf_pci_uninit(struct hclgevf_dev *hdev)
 	pci_set_drvdata(pdev, NULL);
 }
 
-static int hclgevf_init_ae_dev(struct hnae3_ae_dev *ae_dev)
+static int hclgevf_init_hdev(struct hclgevf_dev *hdev)
 {
-	struct pci_dev *pdev = ae_dev->pdev;
-	struct hclgevf_dev *hdev;
+	struct pci_dev *pdev = hdev->pdev;
 	int ret;
 
-	hdev = devm_kzalloc(&pdev->dev, sizeof(*hdev), GFP_KERNEL);
-	if (!hdev)
-		return -ENOMEM;
-
-	hdev->pdev = pdev;
-	hdev->ae_dev = ae_dev;
-	ae_dev->priv = hdev;
+	/* check if device is on-going full reset(i.e. pcie as well) */
+	if (hclgevf_dev_ongoing_full_reset(hdev)) {
+		dev_warn(&pdev->dev, "device is going full reset\n");
+		hclgevf_uninit_hdev(hdev);
+	}
 
 	ret = hclgevf_pci_init(hdev);
 	if (ret) {
@@ -1633,15 +1688,38 @@ static int hclgevf_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 	return ret;
 }
 
-static void hclgevf_uninit_ae_dev(struct hnae3_ae_dev *ae_dev)
+static void hclgevf_uninit_hdev(struct hclgevf_dev *hdev)
 {
-	struct hclgevf_dev *hdev = ae_dev->priv;
-
 	hclgevf_cmd_uninit(hdev);
 	hclgevf_misc_irq_uninit(hdev);
 	hclgevf_state_uninit(hdev);
 	hclgevf_uninit_msi(hdev);
 	hclgevf_pci_uninit(hdev);
+}
+
+static int hclgevf_init_ae_dev(struct hnae3_ae_dev *ae_dev)
+{
+	struct pci_dev *pdev = ae_dev->pdev;
+	int ret;
+
+	ret = hclgevf_alloc_hdev(ae_dev);
+	if (ret) {
+		dev_err(&pdev->dev, "hclge device allocation failed\n");
+		return ret;
+	}
+
+	ret = hclgevf_init_hdev(ae_dev->priv);
+	if (ret)
+		dev_err(&pdev->dev, "hclge device initialization failed\n");
+
+	return ret;
+}
+
+static void hclgevf_uninit_ae_dev(struct hnae3_ae_dev *ae_dev)
+{
+	struct hclgevf_dev *hdev = ae_dev->priv;
+
+	hclgevf_uninit_hdev(hdev);
 	ae_dev->priv = NULL;
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
index afdb15d..8cdc602 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
@@ -169,6 +169,20 @@ struct hclgevf_dev {
 	u32 flag;
 };
 
+static inline bool hclgevf_dev_ongoing_reset(struct hclgevf_dev *hdev)
+{
+	return (hdev &&
+		(test_bit(HCLGEVF_STATE_RST_HANDLING, &hdev->state)) &&
+		(hdev->nic.reset_level == HNAE3_VF_RESET));
+}
+
+static inline bool hclgevf_dev_ongoing_full_reset(struct hclgevf_dev *hdev)
+{
+	return (hdev &&
+		(test_bit(HCLGEVF_STATE_RST_HANDLING, &hdev->state)) &&
+		(hdev->nic.reset_level == HNAE3_VF_FULL_RESET));
+}
+
 int hclgevf_send_mbx_msg(struct hclgevf_dev *hdev, u16 code, u16 subcode,
 			 const u8 *msg_data, u8 msg_len, bool need_resp,
 			 u8 *resp_data, u16 resp_len);
-- 
2.7.4

Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1997AC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933232174B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 933232174B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732531AbeHCLwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 07:52:34 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40155 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728450AbeHCLwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 07:52:33 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B1816E787290D;
        Fri,  3 Aug 2018 17:56:56 +0800 (CST)
Received: from S00293818-DELL1.huawei.com (10.202.226.54) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.399.0; Fri, 3 Aug 2018 17:56:50 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>
Subject: [PATCH net-next 1/2] net: hns3: Fix MSIX allocation issue for VF
Date:   Fri, 3 Aug 2018 10:56:30 +0100
Message-ID: <20180803095631.798-2-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180803095631.798-1-salil.mehta@huawei.com>
References: <20180803095631.798-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

The msix number for vf is different, depends on the max vf number.
Futherly if the vf supports roce, the offset of msix is not fixed.
It's incorrect to fix the msix number to 33. This patch fixes it by
querying the msix number from firmware, and adjusting it with roce
support.

Fixes: e2cb1dec9779 ("net: hns3: Add HNS3 VF HCL(Hardware Compatibility Layer) Support")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  3 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.h   | 14 ++++
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 80 ++++++++++++++++++----
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |  4 +-
 4 files changed, 85 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 6c9e5d6..bd031af 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -50,7 +50,8 @@ static const struct pci_device_id hns3_pci_tbl[] = {
 	{PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_100G_RDMA_MACSEC),
 	 HNAE3_DEV_SUPPORT_ROCE_DCB_BITS},
 	{PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_100G_VF), 0},
-	{PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_100G_RDMA_DCB_PFC_VF), 0},
+	{PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_100G_RDMA_DCB_PFC_VF),
+	 HNAE3_DEV_SUPPORT_ROCE_DCB_BITS},
 	/* required last entry */
 	{0, }
 };
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.h
index 621c6cb..19b3286 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.h
@@ -82,6 +82,7 @@ struct hclgevf_cmq {
 enum hclgevf_opcode_type {
 	/* Generic command */
 	HCLGEVF_OPC_QUERY_FW_VER	= 0x0001,
+	HCLGEVF_OPC_QUERY_VF_RSRC	= 0x0024,
 	/* TQP command */
 	HCLGEVF_OPC_QUERY_TX_STATUS	= 0x0B03,
 	HCLGEVF_OPC_QUERY_RX_STATUS	= 0x0B13,
@@ -134,6 +135,19 @@ struct hclgevf_query_version_cmd {
 	__le32 firmware_rsv[5];
 };
 
+#define HCLGEVF_MSIX_OFT_ROCEE_S       0
+#define HCLGEVF_MSIX_OFT_ROCEE_M       (0xffff << HCLGEVF_MSIX_OFT_ROCEE_S)
+#define HCLGEVF_VEC_NUM_S              0
+#define HCLGEVF_VEC_NUM_M              (0xff << HCLGEVF_VEC_NUM_S)
+struct hclgevf_query_res_cmd {
+	__le16 tqp_num;
+	__le16 reserved;
+	__le16 msixcap_localid_ba_nic;
+	__le16 msixcap_localid_ba_rocee;
+	__le16 vf_intr_vector_number;
+	__le16 rsv[7];
+};
+
 #define HCLGEVF_RSS_HASH_KEY_OFFSET	4
 #define HCLGEVF_RSS_HASH_KEY_NUM	16
 struct hclgevf_rss_config_cmd {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index d1f16f0..9c0091f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1370,14 +1370,13 @@ static int hclgevf_init_roce_base_info(struct hclgevf_dev *hdev)
 	struct hnae3_handle *roce = &hdev->roce;
 	struct hnae3_handle *nic = &hdev->nic;
 
-	roce->rinfo.num_vectors = HCLGEVF_ROCEE_VECTOR_NUM;
+	roce->rinfo.num_vectors = hdev->num_roce_msix;
 
 	if (hdev->num_msi_left < roce->rinfo.num_vectors ||
 	    hdev->num_msi_left == 0)
 		return -EINVAL;
 
-	roce->rinfo.base_vector =
-		hdev->vector_status[hdev->num_msi_used];
+	roce->rinfo.base_vector = hdev->roce_base_vector;
 
 	roce->rinfo.netdev = nic->kinfo.netdev;
 	roce->rinfo.roce_io_base = hdev->hw.io_base;
@@ -1520,10 +1519,15 @@ static int hclgevf_init_msi(struct hclgevf_dev *hdev)
 	if (hclgevf_dev_ongoing_reset(hdev))
 		return 0;
 
-	hdev->num_msi = HCLGEVF_MAX_VF_VECTOR_NUM;
+	if (hnae3_get_bit(hdev->ae_dev->flag, HNAE3_DEV_SUPPORT_ROCE_B))
+		vectors = pci_alloc_irq_vectors(pdev,
+						hdev->roce_base_msix_offset + 1,
+						hdev->num_msi,
+						PCI_IRQ_MSIX);
+	else
+		vectors = pci_alloc_irq_vectors(pdev, 1, hdev->num_msi,
+						PCI_IRQ_MSI | PCI_IRQ_MSIX);
 
-	vectors = pci_alloc_irq_vectors(pdev, 1, hdev->num_msi,
-					PCI_IRQ_MSI | PCI_IRQ_MSIX);
 	if (vectors < 0) {
 		dev_err(&pdev->dev,
 			"failed(%d) to allocate MSI/MSI-X vectors\n",
@@ -1538,6 +1542,7 @@ static int hclgevf_init_msi(struct hclgevf_dev *hdev)
 	hdev->num_msi = vectors;
 	hdev->num_msi_left = vectors;
 	hdev->base_msi_vector = pdev->irq;
+	hdev->roce_base_vector = pdev->irq + hdev->roce_base_msix_offset;
 
 	hdev->vector_status = devm_kcalloc(&pdev->dev, hdev->num_msi,
 					   sizeof(u16), GFP_KERNEL);
@@ -1733,6 +1738,45 @@ static void hclgevf_pci_uninit(struct hclgevf_dev *hdev)
 	pci_disable_device(pdev);
 }
 
+static int hclgevf_query_vf_resource(struct hclgevf_dev *hdev)
+{
+	struct hclgevf_query_res_cmd *req;
+	struct hclgevf_desc desc;
+	int ret;
+
+	hclgevf_cmd_setup_basic_desc(&desc, HCLGEVF_OPC_QUERY_VF_RSRC, true);
+	ret = hclgevf_cmd_send(&hdev->hw, &desc, 1);
+	if (ret) {
+		dev_err(&hdev->pdev->dev,
+			"query vf resource failed, ret = %d.\n", ret);
+		return ret;
+	}
+
+	req = (struct hclgevf_query_res_cmd *)desc.data;
+
+	if (hnae3_get_bit(hdev->ae_dev->flag, HNAE3_DEV_SUPPORT_ROCE_B)) {
+		hdev->roce_base_msix_offset =
+		hnae3_get_field(__le16_to_cpu(req->msixcap_localid_ba_rocee),
+				HCLGEVF_MSIX_OFT_ROCEE_M,
+				HCLGEVF_MSIX_OFT_ROCEE_S);
+		hdev->num_roce_msix =
+		hnae3_get_field(__le16_to_cpu(req->vf_intr_vector_number),
+				HCLGEVF_VEC_NUM_M, HCLGEVF_VEC_NUM_S);
+
+		/* VF should have NIC vectors and Roce vectors, NIC vectors
+		 * are queued before Roce vectors. The offset is fixed to 64.
+		 */
+		hdev->num_msi = hdev->num_roce_msix +
+				hdev->roce_base_msix_offset;
+	} else {
+		hdev->num_msi =
+		hnae3_get_field(__le16_to_cpu(req->vf_intr_vector_number),
+				HCLGEVF_VEC_NUM_M, HCLGEVF_VEC_NUM_S);
+	}
+
+	return 0;
+}
+
 static int hclgevf_init_hdev(struct hclgevf_dev *hdev)
 {
 	struct pci_dev *pdev = hdev->pdev;
@@ -1750,18 +1794,26 @@ static int hclgevf_init_hdev(struct hclgevf_dev *hdev)
 		return ret;
 	}
 
+	ret = hclgevf_cmd_init(hdev);
+	if (ret)
+		goto err_cmd_init;
+
+	/* Get vf resource */
+	ret = hclgevf_query_vf_resource(hdev);
+	if (ret) {
+		dev_err(&hdev->pdev->dev,
+			"Query vf status error, ret = %d.\n", ret);
+		goto err_query_vf;
+	}
+
 	ret = hclgevf_init_msi(hdev);
 	if (ret) {
 		dev_err(&pdev->dev, "failed(%d) to init MSI/MSI-X\n", ret);
-		goto err_irq_init;
+		goto err_query_vf;
 	}
 
 	hclgevf_state_init(hdev);
 
-	ret = hclgevf_cmd_init(hdev);
-	if (ret)
-		goto err_cmd_init;
-
 	ret = hclgevf_misc_irq_init(hdev);
 	if (ret) {
 		dev_err(&pdev->dev, "failed(%d) to init Misc IRQ(vector0)\n",
@@ -1817,11 +1869,11 @@ static int hclgevf_init_hdev(struct hclgevf_dev *hdev)
 err_config:
 	hclgevf_misc_irq_uninit(hdev);
 err_misc_irq_init:
-	hclgevf_cmd_uninit(hdev);
-err_cmd_init:
 	hclgevf_state_uninit(hdev);
 	hclgevf_uninit_msi(hdev);
-err_irq_init:
+err_query_vf:
+	hclgevf_cmd_uninit(hdev);
+err_cmd_init:
 	hclgevf_pci_uninit(hdev);
 	return ret;
 }
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
index 0656e8e..b23ba17 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
@@ -12,7 +12,6 @@
 #define HCLGEVF_MOD_VERSION "1.0"
 #define HCLGEVF_DRIVER_NAME "hclgevf"
 
-#define HCLGEVF_ROCEE_VECTOR_NUM	0
 #define HCLGEVF_MISC_VECTOR_NUM		0
 
 #define HCLGEVF_INVALID_VPORT		0xffff
@@ -150,6 +149,9 @@ struct hclgevf_dev {
 	u16 num_msi;
 	u16 num_msi_left;
 	u16 num_msi_used;
+	u16 num_roce_msix;	/* Num of roce vectors for this VF */
+	u16 roce_base_msix_offset;
+	int roce_base_vector;
 	u32 base_msi_vector;
 	u16 *vector_status;
 	int *vector_irq;
-- 
2.7.4



Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DC6ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 19:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7039E2148E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 19:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7039E2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbeJTDYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 23:24:54 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13676 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727680AbeJTDYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 23:24:54 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2A339F7A56E94;
        Sat, 20 Oct 2018 03:17:23 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.399.0; Sat, 20 Oct 2018 03:17:14 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH net-next 7/7] net: hns3: Add enable and process hw errors of TM scheduler
Date:   Fri, 19 Oct 2018 20:15:32 +0100
Message-ID: <20181019191532.10088-8-salil.mehta@huawei.com>
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

This patch enables and process hw errors of TM scheduler and
QCN(Quantized Congestion Control).

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |   8 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c | 286 +++++++++++++++++++++
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h |   3 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |   6 +
 4 files changed, 303 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index f23cf78..872cd4b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -211,6 +211,12 @@ enum hclge_opcode_type {
 	HCLGE_OPC_LED_STATUS_CFG	= 0xB000,
 
 	/* Error INT commands */
+	HCLGE_TM_SCH_ECC_INT_EN		= 0x0829,
+	HCLGE_TM_SCH_ECC_ERR_RINT_CMD	= 0x082d,
+	HCLGE_TM_SCH_ECC_ERR_RINT_CE	= 0x082f,
+	HCLGE_TM_SCH_ECC_ERR_RINT_NFE	= 0x0830,
+	HCLGE_TM_SCH_ECC_ERR_RINT_FE	= 0x0831,
+	HCLGE_TM_SCH_MBIT_ECC_INFO_CMD	= 0x0833,
 	HCLGE_COMMON_ECC_INT_CFG	= 0x1505,
 	HCLGE_IGU_EGU_TNL_INT_QUERY	= 0x1802,
 	HCLGE_IGU_EGU_TNL_INT_EN	= 0x1803,
@@ -218,6 +224,8 @@ enum hclge_opcode_type {
 	HCLGE_IGU_COMMON_INT_QUERY	= 0x1805,
 	HCLGE_IGU_COMMON_INT_EN		= 0x1806,
 	HCLGE_IGU_COMMON_INT_CLR	= 0x1807,
+	HCLGE_TM_QCN_MEM_INT_CFG	= 0x1A14,
+	HCLGE_TM_QCN_MEM_INT_INFO_CMD	= 0x1A17,
 	HCLGE_PPP_CMD0_INT_CMD		= 0x2100,
 	HCLGE_PPP_CMD1_INT_CMD		= 0x2101,
 	HCLGE_NCSI_INT_QUERY		= 0x2400,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
index ea73def..f7e363b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
@@ -213,6 +213,129 @@ static const struct hclge_hw_error hclge_ppp_mpf_int3[] = {
 	{ /* sentinel */ }
 };
 
+struct hclge_tm_sch_ecc_info {
+	const char *name;
+};
+
+static const struct hclge_tm_sch_ecc_info hclge_tm_sch_ecc_err[7][15] = {
+	{
+		{ .name = "QSET_QUEUE_CTRL:PRI_LEN TAB" },
+		{ .name = "QSET_QUEUE_CTRL:SPA_LEN TAB" },
+		{ .name = "QSET_QUEUE_CTRL:SPB_LEN TAB" },
+		{ .name = "QSET_QUEUE_CTRL:WRRA_LEN TAB" },
+		{ .name = "QSET_QUEUE_CTRL:WRRB_LEN TAB" },
+		{ .name = "QSET_QUEUE_CTRL:SPA_HPTR TAB" },
+		{ .name = "QSET_QUEUE_CTRL:SPB_HPTR TAB" },
+		{ .name = "QSET_QUEUE_CTRL:WRRA_HPTR TAB" },
+		{ .name = "QSET_QUEUE_CTRL:WRRB_HPTR TAB" },
+		{ .name = "QSET_QUEUE_CTRL:QS_LINKLIST TAB" },
+		{ .name = "QSET_QUEUE_CTRL:SPA_TPTR TAB" },
+		{ .name = "QSET_QUEUE_CTRL:SPB_TPTR TAB" },
+		{ .name = "QSET_QUEUE_CTRL:WRRA_TPTR TAB" },
+		{ .name = "QSET_QUEUE_CTRL:WRRB_TPTR TAB" },
+		{ .name = "QSET_QUEUE_CTRL:QS_DEFICITCNT TAB" },
+	},
+	{
+		{ .name = "ROCE_QUEUE_CTRL:QS_LEN TAB" },
+		{ .name = "ROCE_QUEUE_CTRL:QS_TPTR TAB" },
+		{ .name = "ROCE_QUEUE_CTRL:QS_HPTR TAB" },
+		{ .name = "ROCE_QUEUE_CTRL:QLINKLIST TAB" },
+		{ .name = "ROCE_QUEUE_CTRL:QCLEN TAB" },
+	},
+	{
+		{ .name = "NIC_QUEUE_CTRL:QS_LEN TAB" },
+		{ .name = "NIC_QUEUE_CTRL:QS_TPTR TAB" },
+		{ .name = "NIC_QUEUE_CTRL:QS_HPTR TAB" },
+		{ .name = "NIC_QUEUE_CTRL:QLINKLIST TAB" },
+		{ .name = "NIC_QUEUE_CTRL:QCLEN TAB" },
+	},
+	{
+		{ .name = "RAM_CFG_CTRL:CSHAP TAB" },
+		{ .name = "RAM_CFG_CTRL:PSHAP TAB" },
+	},
+	{
+		{ .name = "SHAPER_CTRL:PSHAP TAB" },
+	},
+	{
+		{ .name = "MSCH_CTRL" },
+	},
+	{
+		{ .name = "TOP_CTRL" },
+	},
+};
+
+static const struct hclge_hw_error hclge_tm_sch_err_int[] = {
+	{ .int_msk = BIT(0), .msg = "tm_sch_ecc_1bit_err" },
+	{ .int_msk = BIT(1), .msg = "tm_sch_ecc_mbit_err" },
+	{ .int_msk = BIT(2), .msg = "tm_sch_port_shap_sub_fifo_wr_full_err" },
+	{ .int_msk = BIT(3), .msg = "tm_sch_port_shap_sub_fifo_rd_empty_err" },
+	{ .int_msk = BIT(4), .msg = "tm_sch_pg_pshap_sub_fifo_wr_full_err" },
+	{ .int_msk = BIT(5), .msg = "tm_sch_pg_pshap_sub_fifo_rd_empty_err" },
+	{ .int_msk = BIT(6), .msg = "tm_sch_pg_cshap_sub_fifo_wr_full_err" },
+	{ .int_msk = BIT(7), .msg = "tm_sch_pg_cshap_sub_fifo_rd_empty_err" },
+	{ .int_msk = BIT(8), .msg = "tm_sch_pri_pshap_sub_fifo_wr_full_err" },
+	{ .int_msk = BIT(9), .msg = "tm_sch_pri_pshap_sub_fifo_rd_empty_err" },
+	{ .int_msk = BIT(10), .msg = "tm_sch_pri_cshap_sub_fifo_wr_full_err" },
+	{ .int_msk = BIT(11), .msg = "tm_sch_pri_cshap_sub_fifo_rd_empty_err" },
+	{ .int_msk = BIT(12),
+	  .msg = "tm_sch_port_shap_offset_fifo_wr_full_err" },
+	{ .int_msk = BIT(13),
+	  .msg = "tm_sch_port_shap_offset_fifo_rd_empty_err" },
+	{ .int_msk = BIT(14),
+	  .msg = "tm_sch_pg_pshap_offset_fifo_wr_full_err" },
+	{ .int_msk = BIT(15),
+	  .msg = "tm_sch_pg_pshap_offset_fifo_rd_empty_err" },
+	{ .int_msk = BIT(16),
+	  .msg = "tm_sch_pg_cshap_offset_fifo_wr_full_err" },
+	{ .int_msk = BIT(17),
+	  .msg = "tm_sch_pg_cshap_offset_fifo_rd_empty_err" },
+	{ .int_msk = BIT(18),
+	  .msg = "tm_sch_pri_pshap_offset_fifo_wr_full_err" },
+	{ .int_msk = BIT(19),
+	  .msg = "tm_sch_pri_pshap_offset_fifo_rd_empty_err" },
+	{ .int_msk = BIT(20),
+	  .msg = "tm_sch_pri_cshap_offset_fifo_wr_full_err" },
+	{ .int_msk = BIT(21),
+	  .msg = "tm_sch_pri_cshap_offset_fifo_rd_empty_err" },
+	{ .int_msk = BIT(22), .msg = "tm_sch_rq_fifo_wr_full_err" },
+	{ .int_msk = BIT(23), .msg = "tm_sch_rq_fifo_rd_empty_err" },
+	{ .int_msk = BIT(24), .msg = "tm_sch_nq_fifo_wr_full_err" },
+	{ .int_msk = BIT(25), .msg = "tm_sch_nq_fifo_rd_empty_err" },
+	{ .int_msk = BIT(26), .msg = "tm_sch_roce_up_fifo_wr_full_err" },
+	{ .int_msk = BIT(27), .msg = "tm_sch_roce_up_fifo_rd_empty_err" },
+	{ .int_msk = BIT(28), .msg = "tm_sch_rcb_byte_fifo_wr_full_err" },
+	{ .int_msk = BIT(29), .msg = "tm_sch_rcb_byte_fifo_rd_empty_err" },
+	{ .int_msk = BIT(30), .msg = "tm_sch_ssu_byte_fifo_wr_full_err" },
+	{ .int_msk = BIT(31), .msg = "tm_sch_ssu_byte_fifo_rd_empty_err" },
+	{ /* sentinel */ }
+};
+
+static const struct hclge_hw_error hclge_qcn_ecc_err_int[] = {
+	{ .int_msk = BIT(0), .msg = "qcn_byte_mem_ecc_1bit_err" },
+	{ .int_msk = BIT(1), .msg = "qcn_byte_mem_ecc_mbit_err" },
+	{ .int_msk = BIT(2), .msg = "qcn_time_mem_ecc_1bit_err" },
+	{ .int_msk = BIT(3), .msg = "qcn_time_mem_ecc_mbit_err" },
+	{ .int_msk = BIT(4), .msg = "qcn_fb_mem_ecc_1bit_err" },
+	{ .int_msk = BIT(5), .msg = "qcn_fb_mem_ecc_mbit_err" },
+	{ .int_msk = BIT(6), .msg = "qcn_link_mem_ecc_1bit_err" },
+	{ .int_msk = BIT(7), .msg = "qcn_link_mem_ecc_mbit_err" },
+	{ .int_msk = BIT(8), .msg = "qcn_rate_mem_ecc_1bit_err" },
+	{ .int_msk = BIT(9), .msg = "qcn_rate_mem_ecc_mbit_err" },
+	{ .int_msk = BIT(10), .msg = "qcn_tmplt_mem_ecc_1bit_err" },
+	{ .int_msk = BIT(11), .msg = "qcn_tmplt_mem_ecc_mbit_err" },
+	{ .int_msk = BIT(12), .msg = "qcn_shap_cfg_mem_ecc_1bit_err" },
+	{ .int_msk = BIT(13), .msg = "qcn_shap_cfg_mem_ecc_mbit_err" },
+	{ .int_msk = BIT(14), .msg = "qcn_gp0_barrel_mem_ecc_1bit_err" },
+	{ .int_msk = BIT(15), .msg = "qcn_gp0_barrel_mem_ecc_mbit_err" },
+	{ .int_msk = BIT(16), .msg = "qcn_gp1_barrel_mem_ecc_1bit_err" },
+	{ .int_msk = BIT(17), .msg = "qcn_gp1_barrel_mem_ecc_mbit_err" },
+	{ .int_msk = BIT(18), .msg = "qcn_gp2_barrel_mem_ecc_1bit_err" },
+	{ .int_msk = BIT(19), .msg = "qcn_gp2_barrel_mem_ecc_mbit_err" },
+	{ .int_msk = BIT(20), .msg = "qcn_gp3_barral_mem_ecc_1bit_err" },
+	{ .int_msk = BIT(21), .msg = "qcn_gp3_barral_mem_ecc_mbit_err" },
+	{ /* sentinel */ }
+};
+
 static void hclge_log_error(struct device *dev,
 			    const struct hclge_hw_error *err_list,
 			    u32 err_sts)
@@ -501,6 +624,47 @@ static int hclge_enable_ppp_error(struct hclge_dev *hdev, bool en)
 	return ret;
 }
 
+int hclge_enable_tm_hw_error(struct hclge_dev *hdev, bool en)
+{
+	struct device *dev = &hdev->pdev->dev;
+	struct hclge_desc desc;
+	int ret;
+
+	/* enable TM SCH hw errors */
+	hclge_cmd_setup_basic_desc(&desc, HCLGE_TM_SCH_ECC_INT_EN, false);
+	if (en)
+		desc.data[0] = cpu_to_le32(HCLGE_TM_SCH_ECC_ERR_INT_EN);
+	else
+		desc.data[0] = 0;
+
+	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
+	if (ret) {
+		dev_err(dev, "failed(%d) to configure TM SCH errors\n", ret);
+		return ret;
+	}
+
+	/* enable TM QCN hw errors */
+	ret = hclge_cmd_query_error(hdev, &desc, HCLGE_TM_QCN_MEM_INT_CFG,
+				    0, 0, 0);
+	if (ret) {
+		dev_err(dev, "failed(%d) to read TM QCN CFG status\n", ret);
+		return ret;
+	}
+
+	hclge_cmd_reuse_desc(&desc, false);
+	if (en)
+		desc.data[1] = cpu_to_le32(HCLGE_TM_QCN_MEM_ERR_INT_EN);
+	else
+		desc.data[1] = 0;
+
+	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
+	if (ret)
+		dev_err(dev,
+			"failed(%d) to configure TM QCN mem errors\n", ret);
+
+	return ret;
+}
+
 static void hclge_process_common_error(struct hclge_dev *hdev,
 				       enum hclge_err_int_type type)
 {
@@ -736,6 +900,125 @@ static void hclge_process_ppp_error(struct hclge_dev *hdev,
 			ret);
 }
 
+static void hclge_process_tm_sch_error(struct hclge_dev *hdev)
+{
+	struct device *dev = &hdev->pdev->dev;
+	const struct hclge_tm_sch_ecc_info *tm_sch_ecc_info;
+	struct hclge_desc desc;
+	u32 ecc_info;
+	u8 module_no;
+	u8 ram_no;
+	int ret;
+
+	/* read TM scheduler errors */
+	ret = hclge_cmd_query_error(hdev, &desc,
+				    HCLGE_TM_SCH_MBIT_ECC_INFO_CMD, 0, 0, 0);
+	if (ret) {
+		dev_err(dev, "failed(%d) to read SCH mbit ECC err info\n", ret);
+		return;
+	}
+	ecc_info = le32_to_cpu(desc.data[0]);
+
+	ret = hclge_cmd_query_error(hdev, &desc,
+				    HCLGE_TM_SCH_ECC_ERR_RINT_CMD, 0, 0, 0);
+	if (ret) {
+		dev_err(dev, "failed(%d) to read SCH ECC err status\n", ret);
+		return;
+	}
+
+	/* log TM scheduler errors */
+	if (le32_to_cpu(desc.data[0])) {
+		hclge_log_error(dev, &hclge_tm_sch_err_int[0],
+				le32_to_cpu(desc.data[0]));
+		if (le32_to_cpu(desc.data[0]) & 0x2) {
+			module_no = (ecc_info >> 20) & 0xF;
+			ram_no = (ecc_info >> 16) & 0xF;
+			tm_sch_ecc_info =
+				&hclge_tm_sch_ecc_err[module_no][ram_no];
+			dev_warn(dev, "ecc err module:ram=%s\n",
+				 tm_sch_ecc_info->name);
+			dev_warn(dev, "ecc memory address = 0x%x\n",
+				 ecc_info & 0xFFFF);
+		}
+	}
+
+	/* clear TM scheduler errors */
+	ret = hclge_cmd_clear_error(hdev, &desc, NULL, 0, 0);
+	if (ret) {
+		dev_err(dev, "failed(%d) to clear TM SCH error status\n", ret);
+		return;
+	}
+
+	ret = hclge_cmd_query_error(hdev, &desc,
+				    HCLGE_TM_SCH_ECC_ERR_RINT_CE, 0, 0, 0);
+	if (ret) {
+		dev_err(dev, "failed(%d) to read SCH CE status\n", ret);
+		return;
+	}
+
+	ret = hclge_cmd_clear_error(hdev, &desc, NULL, 0, 0);
+	if (ret) {
+		dev_err(dev, "failed(%d) to clear TM SCH CE status\n", ret);
+		return;
+	}
+
+	ret = hclge_cmd_query_error(hdev, &desc,
+				    HCLGE_TM_SCH_ECC_ERR_RINT_NFE, 0, 0, 0);
+	if (ret) {
+		dev_err(dev, "failed(%d) to read SCH NFE status\n", ret);
+		return;
+	}
+
+	ret = hclge_cmd_clear_error(hdev, &desc, NULL, 0, 0);
+	if (ret) {
+		dev_err(dev, "failed(%d) to clear TM SCH NFE status\n", ret);
+		return;
+	}
+
+	ret = hclge_cmd_query_error(hdev, &desc,
+				    HCLGE_TM_SCH_ECC_ERR_RINT_FE, 0, 0, 0);
+	if (ret) {
+		dev_err(dev, "failed(%d) to read SCH FE status\n", ret);
+		return;
+	}
+
+	ret = hclge_cmd_clear_error(hdev, &desc, NULL, 0, 0);
+	if (ret)
+		dev_err(dev, "failed(%d) to clear TM SCH FE status\n", ret);
+}
+
+static void hclge_process_tm_qcn_error(struct hclge_dev *hdev)
+{
+	struct device *dev = &hdev->pdev->dev;
+	struct hclge_desc desc;
+	int ret;
+
+	/* read QCN errors */
+	ret = hclge_cmd_query_error(hdev, &desc,
+				    HCLGE_TM_QCN_MEM_INT_INFO_CMD, 0, 0, 0);
+	if (ret) {
+		dev_err(dev, "failed(%d) to read QCN ECC err status\n", ret);
+		return;
+	}
+
+	/* log QCN errors */
+	if (le32_to_cpu(desc.data[0]))
+		hclge_log_error(dev, &hclge_qcn_ecc_err_int[0],
+				le32_to_cpu(desc.data[0]));
+
+	/* clear QCN errors */
+	ret = hclge_cmd_clear_error(hdev, &desc, NULL, 0, 0);
+	if (ret)
+		dev_err(dev, "failed(%d) to clear QCN error status\n", ret);
+}
+
+static void hclge_process_tm_error(struct hclge_dev *hdev,
+				   enum hclge_err_int_type type)
+{
+	hclge_process_tm_sch_error(hdev);
+	hclge_process_tm_qcn_error(hdev);
+}
+
 static const struct hclge_hw_blk hw_blk[] = {
 	{ .msk = BIT(0), .name = "IGU_EGU",
 	  .enable_error = hclge_enable_igu_egu_error,
@@ -743,6 +1026,9 @@ static const struct hclge_hw_blk hw_blk[] = {
 	{ .msk = BIT(5), .name = "COMMON",
 	  .enable_error = hclge_enable_common_error,
 	  .process_error = hclge_process_common_error, },
+	{ .msk = BIT(4), .name = "TM",
+	  .enable_error = hclge_enable_tm_hw_error,
+	  .process_error = hclge_process_tm_error, },
 	{ .msk = BIT(1), .name = "PPP",
 	  .enable_error = hclge_enable_ppp_error,
 	  .process_error = hclge_process_ppp_error, },
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h
index c6d3739..e0e3b58 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h
@@ -37,6 +37,8 @@
 #define HCLGE_PPP_MPF_ECC_ERR_INT2_EN_MASK	0x003F
 #define HCLGE_PPP_MPF_ECC_ERR_INT3_EN	0x003F
 #define HCLGE_PPP_MPF_ECC_ERR_INT3_EN_MASK	0x003F
+#define HCLGE_TM_SCH_ECC_ERR_INT_EN	0x3
+#define HCLGE_TM_QCN_MEM_ERR_INT_EN	0xFFFFFF
 #define HCLGE_NCSI_ERR_INT_EN	0x3
 #define HCLGE_NCSI_ERR_INT_TYPE	0x9
 
@@ -76,5 +78,6 @@ struct hclge_hw_error {
 };
 
 int hclge_hw_error_set_state(struct hclge_dev *hdev, bool state);
+int hclge_enable_tm_hw_error(struct hclge_dev *hdev, bool en);
 pci_ers_result_t hclge_process_ras_hw_error(struct hnae3_ae_dev *ae_dev);
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 082ea97..5234b53 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -6881,6 +6881,12 @@ static int hclge_reset_ae_dev(struct hnae3_ae_dev *ae_dev)
 		return ret;
 	}
 
+	/* Re-enable the TM hw error interrupts because
+	 * they get disabled on core/global reset.
+	 */
+	if (hclge_enable_tm_hw_error(hdev, true))
+		dev_err(&pdev->dev, "failed to enable TM hw error interrupts\n");
+
 	dev_info(&pdev->dev, "Reset done, %s driver initialization finished.\n",
 		 HCLGE_DRIVER_NAME);
 
-- 
2.7.4



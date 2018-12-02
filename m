Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E543C64EB4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311F020834
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:11:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 311F020834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbeLBXLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 18:11:54 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:52186 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725825AbeLBXLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 18:11:38 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5DC2A6850E91B;
        Mon,  3 Dec 2018 07:11:33 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.47.90.156) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.408.0; Mon, 3 Dec 2018 07:11:24 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, liuzhongzhu <liuzhongzhu@huawei.com>
Subject: [RFC net-next 7/9] net: hns3: Add "dcb register" status information query function
Date:   Sun, 2 Dec 2018 23:09:31 +0000
Message-ID: <20181202230933.15560-8-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20181202230933.15560-1-salil.mehta@huawei.com>
References: <20181202230933.15560-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.90.156]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: liuzhongzhu <liuzhongzhu@huawei.com>

This patch prints dcb register status  information by module.

debugfs command:
root@(none)# echo dump reg dcb > cmd
 roce_qset_mask: 0x0
 nic_qs_mask: 0x0
 qs_shaping_pass: 0x0
 qs_bp_sts: 0x0
 pri_mask: 0x0
 pri_cshaping_pass: 0x0
 pri_pshaping_pass: 0x0
root@(none)#

Signed-off-by: liuzhongzhu <liuzhongzhu@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c |   7 ++
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |   9 ++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c | 102 +++++++++++++++++++++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h |  16 ++++
 4 files changed, 134 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 4e9d306fc3ff..4fb2bff66614 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -229,6 +229,13 @@ static void hns3_dbg_help(struct hnae3_handle *h)
 		" [rtc] [ppp] [rcb] [tqp <q_num>]]\n",
 		HNS3_DBG_BUF_LEN - strlen(printf_buf));
 	dev_info(&h->pdev->dev, "%s", printf_buf);
+
+	memset(printf_buf, 0, HNS3_DBG_BUF_LEN);
+	strncat(printf_buf, "dump reg dcb [port_id] [pri_id] [pg_id]",
+		HNS3_DBG_BUF_LEN);
+	strncat(printf_buf + strlen(printf_buf), " [rq_id] [nq_id] [qset_id]\n",
+		HNS3_DBG_BUF_LEN - strlen(printf_buf));
+	dev_info(&h->pdev->dev, "%s", printf_buf);
 }
 
 static ssize_t hns3_dbg_cmd_read(struct file *filp, char __user *buffer,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index df18b1708f39..a425b6d68f55 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -140,6 +140,15 @@ enum hclge_opcode_type {
 	HCLGE_OPC_TM_QS_SCH_MODE_CFG    = 0x0814,
 	HCLGE_OPC_TM_BP_TO_QSET_MAPPING = 0x0815,
 	HCLGE_OPC_ETS_TC_WEIGHT		= 0x0843,
+	HCLGE_OPC_QSET_DFX_STS		= 0x0844,
+	HCLGE_OPC_PRI_DFX_STS		= 0x0845,
+	HCLGE_OPC_PG_DFX_STS		= 0x0846,
+	HCLGE_OPC_PORT_DFX_STS		= 0x0847,
+	HCLGE_OPC_SCH_NQ_CNT		= 0x0848,
+	HCLGE_OPC_SCH_RQ_CNT		= 0x0849,
+	HCLGE_OPC_TM_INTERNAL_STS	= 0x0850,
+	HCLGE_OPC_TM_INTERNAL_CNT	= 0x0851,
+	HCLGE_OPC_TM_INTERNAL_STS_1	= 0x0852,
 
 	/* Packet buffer allocate commands */
 	HCLGE_OPC_TX_BUFF_ALLOC		= 0x0901,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
index 716af6491f1d..76a7ab6ea24d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
@@ -107,6 +107,106 @@ static void hclge_dbg_dump_reg_common(struct hclge_dev *hdev,
 	kfree(desc_src);
 }
 
+static void hclge_dbg_dump_dcb(struct hclge_dev *hdev, char *cmd_buf)
+{
+	struct device *dev = &hdev->pdev->dev;
+	struct hclge_dbg_bitmap_cmd *bitmap;
+	int rq_id, pri_id, qset_id;
+	int port_id, nq_id, pg_id;
+	struct hclge_desc desc[2];
+
+	int cnt, ret;
+
+	cnt = sscanf(cmd_buf, "%i %i %i %i %i %i",
+		     &port_id, &pri_id, &pg_id, &rq_id, &nq_id, &qset_id);
+	if (cnt != 6) {
+		dev_err(&hdev->pdev->dev,
+			"dump dcb: bad command parameter, cnt=%d\n", cnt);
+		return;
+	}
+
+	ret = hclge_dbg_cmd_send(hdev, desc, qset_id, 1,
+				 HCLGE_OPC_QSET_DFX_STS);
+	if (ret)
+		return;
+
+	bitmap = (struct hclge_dbg_bitmap_cmd *)&desc[0].data[1];
+	dev_info(dev, "roce_qset_mask: 0x%x\n", bitmap->bit0);
+	dev_info(dev, "nic_qs_mask: 0x%x\n", bitmap->bit1);
+	dev_info(dev, "qs_shaping_pass: 0x%x\n", bitmap->bit2);
+	dev_info(dev, "qs_bp_sts: 0x%x\n", bitmap->bit3);
+
+	ret = hclge_dbg_cmd_send(hdev, desc, pri_id, 1, HCLGE_OPC_PRI_DFX_STS);
+	if (ret)
+		return;
+
+	bitmap = (struct hclge_dbg_bitmap_cmd *)&desc[0].data[1];
+	dev_info(dev, "pri_mask: 0x%x\n", bitmap->bit0);
+	dev_info(dev, "pri_cshaping_pass: 0x%x\n", bitmap->bit1);
+	dev_info(dev, "pri_pshaping_pass: 0x%x\n", bitmap->bit2);
+
+	ret = hclge_dbg_cmd_send(hdev, desc, pg_id, 1, HCLGE_OPC_PG_DFX_STS);
+	if (ret)
+		return;
+
+	bitmap = (struct hclge_dbg_bitmap_cmd *)&desc[0].data[1];
+	dev_info(dev, "pg_mask: 0x%x\n", bitmap->bit0);
+	dev_info(dev, "pg_cshaping_pass: 0x%x\n", bitmap->bit1);
+	dev_info(dev, "pg_pshaping_pass: 0x%x\n", bitmap->bit2);
+
+	ret = hclge_dbg_cmd_send(hdev, desc, port_id, 1,
+				 HCLGE_OPC_PORT_DFX_STS);
+	if (ret)
+		return;
+
+	bitmap = (struct hclge_dbg_bitmap_cmd *)&desc[0].data[1];
+	dev_info(dev, "port_mask: 0x%x\n", bitmap->bit0);
+	dev_info(dev, "port_shaping_pass: 0x%x\n", bitmap->bit1);
+
+	ret = hclge_dbg_cmd_send(hdev, desc, nq_id, 1, HCLGE_OPC_SCH_NQ_CNT);
+	if (ret)
+		return;
+
+	dev_info(dev, "sch_nq_cnt: 0x%x\n", desc[0].data[1]);
+
+	ret = hclge_dbg_cmd_send(hdev, desc, nq_id, 1, HCLGE_OPC_SCH_RQ_CNT);
+	if (ret)
+		return;
+
+	dev_info(dev, "sch_rq_cnt: 0x%x\n", desc[0].data[1]);
+
+	ret = hclge_dbg_cmd_send(hdev, desc, 0, 2, HCLGE_OPC_TM_INTERNAL_STS);
+	if (ret)
+		return;
+
+	dev_info(dev, "pri_bp: 0x%x\n", desc[0].data[1]);
+	dev_info(dev, "fifo_dfx_info: 0x%x\n", desc[0].data[2]);
+	dev_info(dev, "sch_roce_fifo_aful_gap: 0x%x\n", desc[0].data[3]);
+	dev_info(dev, "tx_private_waterline: 0x%x\n", desc[0].data[4]);
+	dev_info(dev, "tm_bypass_en: 0x%x\n", desc[0].data[5]);
+	dev_info(dev, "SSU_TM_BYPASS_EN: 0x%x\n", desc[1].data[0]);
+	dev_info(dev, "SSU_RESERVE_CFG: 0x%x\n", desc[1].data[1]);
+
+	ret = hclge_dbg_cmd_send(hdev, desc, port_id, 1,
+				 HCLGE_OPC_TM_INTERNAL_CNT);
+	if (ret)
+		return;
+
+	dev_info(dev, "SCH_NIC_NUM: 0x%x\n", desc[0].data[1]);
+	dev_info(dev, "SCH_ROCE_NUM: 0x%x\n", desc[0].data[2]);
+
+	ret = hclge_dbg_cmd_send(hdev, desc, port_id, 1,
+				 HCLGE_OPC_TM_INTERNAL_STS_1);
+	if (ret)
+		return;
+
+	dev_info(dev, "TC_MAP_SEL: 0x%x\n", desc[0].data[1]);
+	dev_info(dev, "IGU_PFC_PRI_EN: 0x%x\n", desc[0].data[2]);
+	dev_info(dev, "MAC_PFC_PRI_EN: 0x%x\n", desc[0].data[3]);
+	dev_info(dev, "IGU_PRI_MAP_TC_CFG: 0x%x\n", desc[0].data[4]);
+	dev_info(dev, "IGU_TX_PRI_MAP_TC_CFG: 0x%x\n", desc[0].data[5]);
+}
+
 static void hclge_dbg_dump_reg_cmd(struct hclge_dev *hdev, char *cmd_buf)
 {
 	int msg_num;
@@ -195,6 +295,8 @@ static void hclge_dbg_dump_reg_cmd(struct hclge_dev *hdev, char *cmd_buf)
 					  &cmd_buf[13], msg_num,
 					  HCLGE_DBG_DFX_TQP_OFFSET,
 					  HCLGE_OPC_DFX_TQP_REG);
+	} else if (strncmp(&cmd_buf[9], "dcb", 3) == 0) {
+		hclge_dbg_dump_dcb(hdev, &cmd_buf[13]);
 	} else {
 		dev_info(&hdev->pdev->dev, "unknown command\n");
 		return;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h
index de75252b2f2b..d85cd74f7f2c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h
@@ -57,6 +57,22 @@ struct hclge_qos_pri_map_cmd {
 	   rev	    : 4;
 };
 
+struct hclge_dbg_bitmap_cmd {
+	union {
+		u8 bitmap;
+		struct {
+			u8 bit0 : 1,
+			   bit1 : 1,
+			   bit2 : 1,
+			   bit3 : 1,
+			   bit4 : 1,
+			   bit5 : 1,
+			   bit6 : 1,
+			   bit7 : 1;
+		};
+	};
+};
+
 struct hclge_mac_vlan_idx_rd_mc {
 	u32 index;
 	u8  mac_add[8];
-- 
2.11.0



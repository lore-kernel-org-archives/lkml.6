Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B9CC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D432081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:14:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87D432081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbeLKROW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:14:22 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:16112 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726772AbeLKROT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:14:19 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 58DB4FF8243B0;
        Wed, 12 Dec 2018 01:14:11 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.408.0; Wed, 12 Dec 2018 01:14:03 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, liuzhongzhu <liuzhongzhu@huawei.com>
Subject: [PATCH net-next 2/6] net: hns3: Add "manager table" information query function
Date:   Tue, 11 Dec 2018 17:13:26 +0000
Message-ID: <20181211171330.20592-3-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20181211171330.20592-1-salil.mehta@huawei.com>
References: <20181211171330.20592-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: liuzhongzhu <liuzhongzhu@huawei.com>

This patch prints manager table information.

debugfs command:
echo dump mng tbl > cmd

Sample Command:
root@(none)# echo dump mng tbl > cmd
 entry|mac_addr         |mask|ether|mask|vlan|mask|i_map|i_dir|e_type
 00   |01:00:5e:00:00:01|0   |00000|0   |0000|0   |00   |00   |0
 01   |c2:f1:c5:82:68:17|0   |00000|0   |0000|0   |00   |00   |0
root@(none)#

Signed-off-by: liuzhongzhu <liuzhongzhu@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c |  1 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h | 19 +++++++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c | 66 ++++++++++++++++++++++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h | 12 ++++
 4 files changed, 98 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 9a02655..5067ee3 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -210,6 +210,7 @@ static void hns3_dbg_help(struct hnae3_handle *h)
 	dev_info(&h->pdev->dev, "dump qos pause cfg\n");
 	dev_info(&h->pdev->dev, "dump qos pri map\n");
 	dev_info(&h->pdev->dev, "dump qos buf cfg\n");
+	dev_info(&h->pdev->dev, "dump mng tbl\n");
 }
 
 static ssize_t hns3_dbg_cmd_read(struct file *filp, char __user *buffer,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index b1ee6fe..61b617c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -237,6 +237,7 @@ enum hclge_opcode_type {
 	HCLGE_TM_QCN_MEM_INT_CFG	= 0x1A14,
 	HCLGE_PPP_CMD0_INT_CMD		= 0x2100,
 	HCLGE_PPP_CMD1_INT_CMD		= 0x2101,
+	HCLGE_MAC_ETHERTYPE_IDX_RD	= 0x2105,
 	HCLGE_NCSI_INT_EN		= 0x2401,
 };
 
@@ -744,6 +745,24 @@ struct hclge_cfg_tx_queue_pointer_cmd {
 	u8 rsv[14];
 };
 
+#pragma pack(1)
+struct hclge_mac_ethertype_idx_rd_cmd {
+	u8	flags;
+	u8	resp_code;
+	__le16  vlan_tag;
+	u8      mac_add[6];
+	__le16  index;
+	__le16	ethter_type;
+	__le16  egress_port;
+	__le16  egress_queue;
+	__le16  rev0;
+	u8	i_port_bitmap;
+	u8	i_port_direction;
+	u8	rev1[2];
+};
+
+#pragma pack()
+
 #define HCLGE_TSO_MSS_MIN_S	0
 #define HCLGE_TSO_MSS_MIN_M	GENMASK(13, 0)
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
index 14577bb..832c7f4 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
@@ -407,6 +407,70 @@ static void hclge_dbg_dump_qos_buf_cfg(struct hclge_dev *hdev)
 		"dump qos buf cfg fail(0x%x), status is %d\n", cmd, ret);
 }
 
+static void hclge_dbg_dump_mng_table(struct hclge_dev *hdev)
+{
+	struct hclge_mac_ethertype_idx_rd_cmd *req0;
+	char printf_buf[HCLGE_DBG_BUF_LEN];
+	struct hclge_desc desc;
+	int ret, i;
+
+	dev_info(&hdev->pdev->dev, "mng tab:\n");
+	memset(printf_buf, 0, HCLGE_DBG_BUF_LEN);
+	strncat(printf_buf,
+		"entry|mac_addr         |mask|ether|mask|vlan|mask",
+		HCLGE_DBG_BUF_LEN);
+	strncat(printf_buf + strlen(printf_buf),
+		"|i_map|i_dir|e_type|pf_id|vf_id|q_id|drop\n",
+		HCLGE_DBG_BUF_LEN - strlen(printf_buf));
+
+	dev_info(&hdev->pdev->dev, "%s", printf_buf);
+
+	for (i = 0; i < HCLGE_DBG_MNG_TBL_MAX; i++) {
+		hclge_cmd_setup_basic_desc(&desc, HCLGE_MAC_ETHERTYPE_IDX_RD,
+					   true);
+		req0 = (struct hclge_mac_ethertype_idx_rd_cmd *)&desc.data;
+		req0->index = cpu_to_le16(i);
+
+		ret = hclge_cmd_send(&hdev->hw, &desc, 1);
+		if (ret) {
+			dev_err(&hdev->pdev->dev,
+				"call hclge_cmd_send fail, ret = %d\n", ret);
+			return;
+		}
+
+		if (!req0->resp_code)
+			continue;
+
+		memset(printf_buf, 0, HCLGE_DBG_BUF_LEN);
+		snprintf(printf_buf, HCLGE_DBG_BUF_LEN,
+			 "%02u   |%02x:%02x:%02x:%02x:%02x:%02x|",
+			 req0->index, req0->mac_add[0], req0->mac_add[1],
+			 req0->mac_add[2], req0->mac_add[3], req0->mac_add[4],
+			 req0->mac_add[5]);
+
+		snprintf(printf_buf + strlen(printf_buf),
+			 HCLGE_DBG_BUF_LEN - strlen(printf_buf),
+			 "%x   |%04x |%x   |%04x|%x   |%02x   |%02x   |",
+			 !!(req0->flags & HCLGE_DBG_MNG_MAC_MASK_B),
+			 req0->ethter_type,
+			 !!(req0->flags & HCLGE_DBG_MNG_ETHER_MASK_B),
+			 req0->vlan_tag & HCLGE_DBG_MNG_VLAN_TAG,
+			 !!(req0->flags & HCLGE_DBG_MNG_VLAN_MASK_B),
+			 req0->i_port_bitmap, req0->i_port_direction);
+
+		snprintf(printf_buf + strlen(printf_buf),
+			 HCLGE_DBG_BUF_LEN - strlen(printf_buf),
+			 "%d     |%d    |%02d   |%04d|%x\n",
+			 !!(req0->egress_port & HCLGE_DBG_MNG_E_TYPE_B),
+			 req0->egress_port & HCLGE_DBG_MNG_PF_ID,
+			 (req0->egress_port >> 3) & HCLGE_DBG_MNG_VF_ID,
+			 req0->egress_queue,
+			 !!(req0->egress_port & HCLGE_DBG_MNG_DROP_B));
+
+		dev_info(&hdev->pdev->dev, "%s", printf_buf);
+	}
+}
+
 static void hclge_dbg_fd_tcam_read(struct hclge_dev *hdev, u8 stage,
 				   bool sel_x, u32 loc)
 {
@@ -478,6 +542,8 @@ int hclge_dbg_run_cmd(struct hnae3_handle *handle, char *cmd_buf)
 		hclge_dbg_dump_qos_pri_map(hdev);
 	} else if (strncmp(cmd_buf, "dump qos buf cfg", 16) == 0) {
 		hclge_dbg_dump_qos_buf_cfg(hdev);
+	} else if (strncmp(cmd_buf, "dump mng tbl", 12) == 0) {
+		hclge_dbg_dump_mng_table(hdev);
 	} else {
 		dev_info(&hdev->pdev->dev, "unknown command\n");
 		return -EINVAL;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h
index 50fd0b1..6097cd8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h
@@ -4,6 +4,18 @@
 #ifndef __HCLGE_DEBUGFS_H
 #define __HCLGE_DEBUGFS_H
 
+#define HCLGE_DBG_BUF_LEN	   256
+#define HCLGE_DBG_MNG_TBL_MAX	   64
+
+#define HCLGE_DBG_MNG_VLAN_MASK_B  BIT(0)
+#define HCLGE_DBG_MNG_MAC_MASK_B   BIT(1)
+#define HCLGE_DBG_MNG_ETHER_MASK_B BIT(2)
+#define HCLGE_DBG_MNG_E_TYPE_B	   BIT(11)
+#define HCLGE_DBG_MNG_DROP_B	   BIT(13)
+#define HCLGE_DBG_MNG_VLAN_TAG	   0x0FFF
+#define HCLGE_DBG_MNG_PF_ID	   0x0007
+#define HCLGE_DBG_MNG_VF_ID	   0x00FF
+
 #pragma pack(1)
 
 struct hclge_qos_pri_map_cmd {
-- 
2.7.4



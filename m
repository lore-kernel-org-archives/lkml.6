Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB43AC64EB4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A850A20834
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A850A20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbeLBXLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 18:11:23 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:52072 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725825AbeLBXLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 18:11:22 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2C24E1FFDE532;
        Mon,  3 Dec 2018 07:11:18 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.47.90.156) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.408.0; Mon, 3 Dec 2018 07:11:11 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, liuzhongzhu <liuzhongzhu@huawei.com>
Subject: [RFC net-next 3/9] net: hns3: Add "port vlan table" information query function
Date:   Sun, 2 Dec 2018 23:09:27 +0000
Message-ID: <20181202230933.15560-4-salil.mehta@huawei.com>
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

This patch prints port vlan table information.

debugfs command:
echo dump port vlan tbl > cmd

Sample Command:
root@(none)# echo dump port vlan tbl > cmd
 vlan | port filter bitMap:
 0000 | 00000000:00000000:00000000:00000000:00000000:00000001
root@(none)#

Signed-off-by: liuzhongzhu <liuzhongzhu@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c |  1 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c | 80 ++++++++++++++++++++++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h |  3 +
 3 files changed, 84 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index e59591b1258b..51af55f34e55 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -211,6 +211,7 @@ static void hns3_dbg_help(struct hnae3_handle *h)
 	dev_info(&h->pdev->dev, "dump qos pri map\n");
 	dev_info(&h->pdev->dev, "dump qos buf cfg\n");
 	dev_info(&h->pdev->dev, "dump mac tbl\n");
+	dev_info(&h->pdev->dev, "dump port vlan tbl\n");
 }
 
 static ssize_t hns3_dbg_cmd_read(struct file *filp, char __user *buffer,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
index 19b76f5e93d7..4a034a59fcb2 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
@@ -530,6 +530,84 @@ static void hclge_dbg_dump_mac_table(struct hclge_dev *hdev)
 	kfree(mc_mac_tbl);
 }
 
+static void hclge_dbg_dump_port_vlan_table(struct hclge_dev *hdev)
+{
+	struct hclge_vlan_filter_pf_cfg_cmd *req;
+	char printf_buf[HCLGE_DBG_BUF_LEN];
+	struct hclge_desc desc;
+	u32 *vlan_bitmap;
+	u8 vlan_byte_val;
+	u8 vlan_offset;
+	u8 vlan_byte;
+	int vlan_len;
+	u32 vlan_id;
+	int ret, i;
+	bool flag;
+
+	vlan_len = HCLGE_DBG_VLAN_ID_MAX / 8;
+	vlan_bitmap = kzalloc(vlan_len, GFP_KERNEL);
+	if (!vlan_bitmap) {
+		dev_err(&hdev->pdev->dev,
+			"port vlan table alloc memory failed\n");
+		return;
+	}
+
+	for (vlan_id = 0; vlan_id < HCLGE_DBG_VLAN_ID_MAX; vlan_id++) {
+		/* Prevent long-term occupation of the command channel. */
+		if ((vlan_id % 100) == 0)
+			msleep(100);
+
+		hclge_cmd_setup_basic_desc(&desc,
+					   HCLGE_OPC_VLAN_FILTER_PF_CFG, true);
+
+		vlan_offset = vlan_id / 160;
+		vlan_byte = (vlan_id % 160) / 8;
+		vlan_byte_val = 1 << (vlan_id % 8);
+
+		req = (struct hclge_vlan_filter_pf_cfg_cmd *)desc.data;
+		req->vlan_offset = vlan_offset;
+		req->vlan_offset_bitmap[vlan_byte] = vlan_byte_val;
+
+		ret = hclge_cmd_send(&hdev->hw, &desc, 1);
+		if (ret) {
+			dev_err(&hdev->pdev->dev,
+				"call hclge_cmd_send fail, ret = %d\n", ret);
+			kfree(vlan_bitmap);
+			return;
+		}
+
+		if (req->vlan_cfg != 0)
+			continue;
+
+		vlan_bitmap[(u32)(vlan_id / 32)] |= 1 << (vlan_id % 32);
+	}
+
+	dev_info(&hdev->pdev->dev, "vlan | port filter bitMap:\n");
+
+	for (vlan_id = 0; vlan_id < HCLGE_DBG_VLAN_ID_MAX / 32;
+	     vlan_id += 8) {
+		memset(printf_buf, 0, HCLGE_DBG_BUF_LEN);
+		snprintf(printf_buf, HCLGE_DBG_BUF_LEN,
+			 "%04d | ", vlan_id * 32);
+		flag = false;
+
+		for (i = 7; i >= 0; i--) {
+			snprintf(printf_buf + strlen(printf_buf),
+				 HCLGE_DBG_BUF_LEN - strlen(printf_buf),
+				 "%08x:", vlan_bitmap[(u32)(vlan_id + i)]);
+
+			if (vlan_bitmap[(u32)(vlan_id + i)] > 0)
+				flag = true;
+		}
+
+		printf_buf[strlen(printf_buf) - 1] = '\n';
+		if (flag)
+			dev_info(&hdev->pdev->dev, "%s", printf_buf);
+	}
+
+	kfree(vlan_bitmap);
+}
+
 static void hclge_dbg_fd_tcam_read(struct hclge_dev *hdev, u8 stage,
 				   bool sel_x, u32 loc)
 {
@@ -603,6 +681,8 @@ int hclge_dbg_run_cmd(struct hnae3_handle *handle, char *cmd_buf)
 		hclge_dbg_dump_qos_buf_cfg(hdev);
 	} else if (strncmp(cmd_buf, "dump mac tbl", 12) == 0) {
 		hclge_dbg_dump_mac_table(hdev);
+	} else if (strncmp(cmd_buf, "dump port vlan tbl", 18) == 0) {
+		hclge_dbg_dump_port_vlan_table(hdev);
 	} else {
 		dev_info(&hdev->pdev->dev, "unknown command\n");
 		return -EINVAL;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h
index b5a784506b9a..f0c7ad535fcc 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h
@@ -14,6 +14,9 @@
 #define HCLGE_DBG_MAC_TBL_E_PORT   0x3FF
 #define HCLGE_DBG_MAC_TBL_E_PORT_B BIT(11)
 
+#define HCLGE_DBG_VLAN_ID_MAX 4096
+#define HCLGE_DBG_MNG_TBL_MAX 64
+
 #pragma pack(1)
 
 struct hclge_qos_pri_map_cmd {
-- 
2.11.0



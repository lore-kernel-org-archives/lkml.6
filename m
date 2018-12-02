Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3241C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97CBC20834
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:12:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97CBC20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbeLBXL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 18:11:29 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:15187 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725913AbeLBXL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 18:11:27 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 45B1FF51A21DE;
        Mon,  3 Dec 2018 07:11:23 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.47.90.156) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.408.0; Mon, 3 Dec 2018 07:11:14 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, liuzhongzhu <liuzhongzhu@huawei.com>
Subject: [RFC net-next 4/9] net: hns3: Add "vf vlan table" information query function
Date:   Sun, 2 Dec 2018 23:09:28 +0000
Message-ID: <20181202230933.15560-5-salil.mehta@huawei.com>
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

This patch prints vf vlan table information.

debugfs command:
echo dump port vlan tbl 0 > cmd

Sample Command:
root@(none)# echo dump vf vlan tbl 0 > cmd
vlan | vf filter bitMap:
0000 | 00000000:00000000:00000000:00000000:00000000:00000000:00000000:00000001
root@(none)#

Signed-off-by: liuzhongzhu <liuzhongzhu@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c |  1 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c | 93 ++++++++++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 51af55f34e55..80a081e87b96 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -212,6 +212,7 @@ static void hns3_dbg_help(struct hnae3_handle *h)
 	dev_info(&h->pdev->dev, "dump qos buf cfg\n");
 	dev_info(&h->pdev->dev, "dump mac tbl\n");
 	dev_info(&h->pdev->dev, "dump port vlan tbl\n");
+	dev_info(&h->pdev->dev, "dump vf vlan tbl [vf id]\n");
 }
 
 static ssize_t hns3_dbg_cmd_read(struct file *filp, char __user *buffer,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
index 4a034a59fcb2..20e64abe7c5a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
@@ -608,6 +608,97 @@ static void hclge_dbg_dump_port_vlan_table(struct hclge_dev *hdev)
 	kfree(vlan_bitmap);
 }
 
+static void hclge_dbg_dump_vf_vlan_table(struct hclge_dev *hdev, char *cmd_buf)
+{
+	struct hclge_vlan_filter_vf_cfg_cmd *req0;
+	struct hclge_vlan_filter_vf_cfg_cmd *req1;
+	char printf_buf[HCLGE_DBG_BUF_LEN];
+	struct hclge_desc desc[2];
+	u32 *vlan_bitmap;
+	u8 vf_byte_val;
+	u8 vf_bitmap;
+	int vlan_len;
+	u32 vlan_id;
+	int ret, i;
+	bool flag;
+	u16 vf_id;
+
+	ret = kstrtou16(&cmd_buf[17], 10, &vf_id);
+	if (ret) {
+		dev_err(&hdev->pdev->dev,
+			"vf id failed. vf id max: %d\n", hdev->num_alloc_vfs);
+		return;
+	}
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
+		hclge_cmd_setup_basic_desc(&desc[0],
+					   HCLGE_OPC_VLAN_FILTER_VF_CFG, true);
+		desc[0].flag |= cpu_to_le16(HCLGE_CMD_FLAG_NEXT);
+		hclge_cmd_setup_basic_desc(&desc[1],
+					   HCLGE_OPC_VLAN_FILTER_VF_CFG, true);
+
+		req0 = (struct hclge_vlan_filter_vf_cfg_cmd *)desc[0].data;
+		req1 = (struct hclge_vlan_filter_vf_cfg_cmd *)desc[1].data;
+		req0->vlan_id = cpu_to_le16(vlan_id);
+
+		ret = hclge_cmd_send(&hdev->hw, desc, 2);
+		if (ret) {
+			dev_err(&hdev->pdev->dev,
+				"call hclge_cmd_send fail, ret = %d\n", ret);
+			kfree(vlan_bitmap);
+			return;
+		}
+
+		if (vf_id < 128)
+			vf_bitmap = req0->vf_bitmap[vf_id / 8];
+		else
+			vf_bitmap = req1->vf_bitmap[(vf_id - 128) / 8];
+
+		vf_byte_val = 1 << (vf_id % 8);
+
+		if (vf_bitmap & vf_byte_val)
+			vlan_bitmap[(u32)(vlan_id / 32)] |= 1 << (vlan_id % 32);
+	}
+
+	dev_info(&hdev->pdev->dev, "vlan | vf filter bitMap:\n");
+
+	for (vlan_id = 0; vlan_id < HCLGE_DBG_VLAN_ID_MAX / 32; vlan_id += 8) {
+		memset(printf_buf, 0, HCLGE_DBG_BUF_LEN);
+		snprintf(printf_buf, HCLGE_DBG_BUF_LEN,
+			 "%04d | ", vlan_id * 32);
+
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
+
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
@@ -683,6 +774,8 @@ int hclge_dbg_run_cmd(struct hnae3_handle *handle, char *cmd_buf)
 		hclge_dbg_dump_mac_table(hdev);
 	} else if (strncmp(cmd_buf, "dump port vlan tbl", 18) == 0) {
 		hclge_dbg_dump_port_vlan_table(hdev);
+	} else if (strncmp(cmd_buf, "dump vf vlan tbl", 16) == 0) {
+		hclge_dbg_dump_vf_vlan_table(hdev, cmd_buf);
 	} else {
 		dev_info(&hdev->pdev->dev, "unknown command\n");
 		return -EINVAL;
-- 
2.11.0



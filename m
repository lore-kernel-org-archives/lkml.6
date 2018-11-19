Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B992BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F0142086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:20:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F0142086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731053AbeKTHqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 02:46:18 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:14685 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730790AbeKTHqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 02:46:18 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E40BC4CB6F111;
        Tue, 20 Nov 2018 05:20:43 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.47.88.214) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.408.0; Tue, 20 Nov 2018 05:20:33 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, liuzhongzhu <liuzhongzhu@huawei.com>
Subject: [PATCH net-next 2/8] net: hns3: Add "queue info" query function
Date:   Mon, 19 Nov 2018 21:18:39 +0000
Message-ID: <20181119211845.23168-3-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20181119211845.23168-1-salil.mehta@huawei.com>
References: <20181119211845.23168-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.88.214]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: liuzhongzhu <liuzhongzhu@huawei.com>

Query the queue information of the current NIC
such as BD size, queue header and tail pointer.

This  patch adds support for debugfs command:
echo queue info 1 > cmd

it can  print queue config information...

root@(none)# echo queue info 1 > cmd
hns3 0000:7d:00.0: queue info
hns3 0000:7d:00.0: RX(1) BASE ADD: 0x00000000ffb58000
hns3 0000:7d:00.0: RX(1) RING BD NUM: 127
hns3 0000:7d:00.0: RX(1) RING BD LEN: 2
hns3 0000:7d:00.0: RX(1) RING TAIL: 120
hns3 0000:7d:00.0: RX(1) RING HEAD: 0
hns3 0000:7d:00.0: RX(1) RING FBDNUM: 0
hns3 0000:7d:00.0: RX(1) RING PKTNUM: 0
hns3 0000:7d:00.0: TX(1) BASE ADD: 0x00000000fffd8000
hns3 0000:7d:00.0: TX(1) RING BD NUM: 127
hns3 0000:7d:00.0: TX(1) RING TC: 0
hns3 0000:7d:00.0: TX(1) RING TAIL: 2
hns3 0000:7d:00.0: TX(1) RING HEAD: 2
hns3 0000:7d:00.0: TX(1) RING FBDNUM: 0
hns3 0000:7d:00.0: TX(1) RING OFFSET: 0
hns3 0000:7d:00.0: TX(1) RING PKTNUM: 0
root@(none)#

Signed-off-by: liuzhongzhu <liuzhongzhu@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    | 122 ++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 9bc6ceb6fbc1..04b0789d439d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -11,6 +11,120 @@
 
 static struct dentry *hns3_dbgfs_root;
 
+static int hns3_dbg_queue_info(struct hnae3_handle *h, char *cmd_buf)
+{
+	struct hns3_nic_priv *priv = h->priv;
+	struct hns3_nic_ring_data *ring_data;
+	struct hns3_enet_ring *ring;
+	u32 base_add_l, base_add_h;
+	u32 queue_num, queue_max;
+	u32 value, i = 0;
+	int cnt;
+
+	if (!priv->ring_data) {
+		dev_err(&h->pdev->dev, "ring_data is NULL\n");
+		return -EFAULT;
+	}
+
+	queue_max = h->kinfo.num_tqps;
+	cnt = kstrtouint(&cmd_buf[11], 0, &queue_num);
+	if (cnt)
+		queue_num = 0;
+	else
+		queue_max = queue_num + 1;
+
+	dev_info(&h->pdev->dev, "queue info\n");
+
+	if (queue_num >= h->kinfo.num_tqps) {
+		dev_err(&h->pdev->dev,
+			"Queue number(%u) is out of range(%u)\n", queue_num,
+			h->kinfo.num_tqps - 1);
+		return -EINVAL;
+	}
+
+	ring_data = priv->ring_data;
+	for (i = queue_num; i < queue_max; i++) {
+		/* Each cycle needs to determine whether the instance is reset,
+		 * to prevent reference to invalid memory. And need to ensure
+		 * that the following code is executed within 100ms.
+		 */
+		if (test_bit(HNS3_NIC_STATE_INITED, &priv->state) ||
+		    test_bit(HNS3_NIC_STATE_RESETTING, &priv->state))
+			return -EPERM;
+
+		ring = ring_data[i + h->kinfo.num_tqps].ring;
+		base_add_h = readl_relaxed(ring->tqp->io_base +
+					   HNS3_RING_RX_RING_BASEADDR_H_REG);
+		base_add_l = readl_relaxed(ring->tqp->io_base +
+					   HNS3_RING_RX_RING_BASEADDR_L_REG);
+		dev_info(&h->pdev->dev, "RX(%d) BASE ADD: 0x%08x%08x\n", i,
+			 base_add_h, base_add_l);
+
+		value = readl_relaxed(ring->tqp->io_base +
+				      HNS3_RING_RX_RING_BD_NUM_REG);
+		dev_info(&h->pdev->dev, "RX(%d) RING BD NUM: %u\n", i, value);
+
+		value = readl_relaxed(ring->tqp->io_base +
+				      HNS3_RING_RX_RING_BD_LEN_REG);
+		dev_info(&h->pdev->dev, "RX(%d) RING BD LEN: %u\n", i, value);
+
+		value = readl_relaxed(ring->tqp->io_base +
+				      HNS3_RING_RX_RING_TAIL_REG);
+		dev_info(&h->pdev->dev, "RX(%d) RING TAIL: %u\n", i, value);
+
+		value = readl_relaxed(ring->tqp->io_base +
+				      HNS3_RING_RX_RING_HEAD_REG);
+		dev_info(&h->pdev->dev, "RX(%d) RING HEAD: %u\n", i, value);
+
+		value = readl_relaxed(ring->tqp->io_base +
+				      HNS3_RING_RX_RING_FBDNUM_REG);
+		dev_info(&h->pdev->dev, "RX(%d) RING FBDNUM: %u\n", i, value);
+
+		value = readl_relaxed(ring->tqp->io_base +
+				      HNS3_RING_RX_RING_PKTNUM_RECORD_REG);
+		dev_info(&h->pdev->dev, "RX(%d) RING PKTNUM: %u\n", i, value);
+
+		ring = ring_data[i].ring;
+		base_add_h = readl_relaxed(ring->tqp->io_base +
+					   HNS3_RING_TX_RING_BASEADDR_H_REG);
+		base_add_l = readl_relaxed(ring->tqp->io_base +
+					   HNS3_RING_TX_RING_BASEADDR_L_REG);
+		dev_info(&h->pdev->dev, "TX(%d) BASE ADD: 0x%08x%08x\n", i,
+			 base_add_h, base_add_l);
+
+		value = readl_relaxed(ring->tqp->io_base +
+				      HNS3_RING_TX_RING_BD_NUM_REG);
+		dev_info(&h->pdev->dev, "TX(%d) RING BD NUM: %u\n", i, value);
+
+		value = readl_relaxed(ring->tqp->io_base +
+				      HNS3_RING_TX_RING_TC_REG);
+		dev_info(&h->pdev->dev, "TX(%d) RING TC: %u\n", i, value);
+
+		value = readl_relaxed(ring->tqp->io_base +
+				      HNS3_RING_TX_RING_TAIL_REG);
+		dev_info(&h->pdev->dev, "TX(%d) RING TAIL: %u\n", i, value);
+
+		value = readl_relaxed(ring->tqp->io_base +
+				      HNS3_RING_TX_RING_HEAD_REG);
+		dev_info(&h->pdev->dev, "TX(%d) RING HEAD: %u\n", i, value);
+
+		value = readl_relaxed(ring->tqp->io_base +
+				      HNS3_RING_TX_RING_FBDNUM_REG);
+		dev_info(&h->pdev->dev, "TX(%d) RING FBDNUM: %u\n", i, value);
+
+		value = readl_relaxed(ring->tqp->io_base +
+				      HNS3_RING_TX_RING_OFFSET_REG);
+		dev_info(&h->pdev->dev, "TX(%d) RING OFFSET: %u\n", i, value);
+
+		value = readl_relaxed(ring->tqp->io_base +
+				      HNS3_RING_TX_RING_PKTNUM_RECORD_REG);
+		dev_info(&h->pdev->dev, "TX(%d) RING PKTNUM: %u\n\n", i,
+			 value);
+	}
+
+	return 0;
+}
+
 static void hns3_dbg_help(struct hnae3_handle *h)
 {
 	dev_info(&h->pdev->dev, "available commands\n");
@@ -51,6 +165,7 @@ static ssize_t hns3_dbg_cmd_write(struct file *filp, const char __user *buffer,
 				  size_t count, loff_t *ppos)
 {
 	struct hnae3_handle *handle = filp->private_data;
+	struct hns3_nic_priv *priv  = handle->priv;
 	char *cmd_buf, *cmd_buf_tmp;
 	int uncopied_bytes;
 	int ret = 0;
@@ -58,6 +173,11 @@ static ssize_t hns3_dbg_cmd_write(struct file *filp, const char __user *buffer,
 	if (*ppos != 0)
 		return 0;
 
+	/* Judge if the instance is being reset. */
+	if (test_bit(HNS3_NIC_STATE_INITED, &priv->state) ||
+	    test_bit(HNS3_NIC_STATE_RESETTING, &priv->state))
+		return 0;
+
 	cmd_buf = kzalloc(count + 1, GFP_KERNEL);
 	if (!cmd_buf)
 		return count;
@@ -78,6 +198,8 @@ static ssize_t hns3_dbg_cmd_write(struct file *filp, const char __user *buffer,
 
 	if (strncmp(cmd_buf, "help", 4) == 0)
 		hns3_dbg_help(handle);
+	else if (strncmp(cmd_buf, "queue info", 10) == 0)
+		ret = hns3_dbg_queue_info(handle, cmd_buf);
 
 	if (ret)
 		hns3_dbg_help(handle);
-- 
2.17.1



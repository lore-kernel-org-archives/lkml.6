Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756644AbeEAS6I (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 14:58:08 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54948 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756398AbeEAS6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 14:58:05 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil.lnk@gmail.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 7/9] net: hns3: fix a dead loop in hclge_cmd_csq_clean
Date: Tue, 1 May 2018 19:56:03 +0100
Message-ID: <20180501185605.9584-8-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180501185605.9584-1-salil.mehta@huawei.com>
References: <20180501185605.9584-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.46]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>

If head has invlid value then a dead loop can be triggered in
hclge_cmd_csq_clean. This patch adds sanity check for this case.

Fixes: 68c0a5c70614 ("net: hns3: Add HNS3 IMP(Integrated Mgmt Proc) Cmd
Interface Support")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c    | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
index ff13d18..fab7068 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
@@ -31,6 +31,17 @@ static int hclge_ring_space(struct hclge_cmq_ring *ring)
 	return ring->desc_num - used - 1;
 }
 
+static int is_valid_csq_clean_head(struct hclge_cmq_ring *ring, int h)
+{
+	int u = ring->next_to_use;
+	int c = ring->next_to_clean;
+
+	if (unlikely(h >= ring->desc_num))
+		return 0;
+
+	return u > c ? (h > c && h <= u) : (h > c || h <= u);
+}
+
 static int hclge_alloc_cmd_desc(struct hclge_cmq_ring *ring)
 {
 	int size  = ring->desc_num * sizeof(struct hclge_desc);
@@ -141,6 +152,7 @@ static void hclge_cmd_init_regs(struct hclge_hw *hw)
 
 static int hclge_cmd_csq_clean(struct hclge_hw *hw)
 {
+	struct hclge_dev *hdev = (struct hclge_dev *)hw->back;
 	struct hclge_cmq_ring *csq = &hw->cmq.csq;
 	u16 ntc = csq->next_to_clean;
 	struct hclge_desc *desc;
@@ -149,6 +161,13 @@ static int hclge_cmd_csq_clean(struct hclge_hw *hw)
 
 	desc = &csq->desc[ntc];
 	head = hclge_read_dev(hw, HCLGE_NIC_CSQ_HEAD_REG);
+	rmb(); /* Make sure head is ready before touch any data */
+
+	if (!is_valid_csq_clean_head(csq, head)) {
+		dev_warn(&hdev->pdev->dev, "wrong head (%d, %d-%d)\n", head,
+			   csq->next_to_use, csq->next_to_clean);
+		return 0;
+	}
 
 	while (head != ntc) {
 		memset(desc, 0, sizeof(*desc));
-- 
2.7.4

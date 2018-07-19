Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44ADECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E2520673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9E2520673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732004AbeGSPbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:31:51 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54326 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730521AbeGSPbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:31:50 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7E4D2A1DF6FE;
        Thu, 19 Jul 2018 22:48:15 +0800 (CST)
Received: from S00293818-DELL1.huawei.com (10.202.226.54) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.382.0; Thu, 19 Jul 2018 22:48:06 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>
Subject: [PATCH net-next 7/9] net: hns3: Fix misleading parameter name
Date:   Thu, 19 Jul 2018 15:47:04 +0100
Message-ID: <20180719144706.644-8-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180719144706.644-1-salil.mehta@huawei.com>
References: <20180719144706.644-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

The input parameter "dev" of hns3_irq_handle() is indeed
used as a tqp vector, it is misleadin.

The struct member "flag" is used to indicate ring type,
so rename it.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c        | 4 ++--
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c | 4 ++--
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 29be96e..ba2797e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -62,9 +62,9 @@ static const struct pci_device_id hns3_pci_tbl[] = {
 };
 MODULE_DEVICE_TABLE(pci, hns3_pci_tbl);
 
-static irqreturn_t hns3_irq_handle(int irq, void *dev)
+static irqreturn_t hns3_irq_handle(int irq, void *vector)
 {
-	struct hns3_enet_tqp_vector *tqp_vector = dev;
+	struct hns3_enet_tqp_vector *tqp_vector = vector;
 
 	napi_schedule(&tqp_vector->napi);
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
index cf40afc..68356da 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
@@ -72,7 +72,7 @@ static int hclge_alloc_cmd_queue(struct hclge_dev *hdev, int ring_type)
 		(ring_type == HCLGE_TYPE_CSQ) ? &hw->cmq.csq : &hw->cmq.crq;
 	int ret;
 
-	ring->flag = ring_type;
+	ring->ring_type = ring_type;
 	ring->dev = hdev;
 
 	ret = hclge_alloc_cmd_desc(ring);
@@ -111,7 +111,7 @@ static void hclge_cmd_config_regs(struct hclge_cmq_ring *ring)
 	struct hclge_dev *hdev = ring->dev;
 	struct hclge_hw *hw = &hdev->hw;
 
-	if (ring->flag == HCLGE_TYPE_CSQ) {
+	if (ring->ring_type == HCLGE_TYPE_CSQ) {
 		hclge_write_dev(hw, HCLGE_NIC_CSQ_BASEADDR_L_REG,
 				lower_32_bits(dma));
 		hclge_write_dev(hw, HCLGE_NIC_CSQ_BASEADDR_H_REG,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index ec7b8d7..54e199d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -45,7 +45,7 @@ struct hclge_cmq_ring {
 	u16 desc_num;
 	int next_to_use;
 	int next_to_clean;
-	u8 flag;
+	u8 ring_type; /* cmq ring type */
 	spinlock_t lock; /* Command queue lock */
 };
 
-- 
2.7.4



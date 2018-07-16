Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FBBECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99408208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:38:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99408208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbeGPQFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:05:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9626 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727715AbeGPQFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:05:22 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 128E92D81D973;
        Mon, 16 Jul 2018 23:37:09 +0800 (CST)
Received: from S00293818-DELL1.huawei.com (10.202.226.54) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.382.0; Mon, 16 Jul 2018 23:37:04 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 1/9] net: hns3: Modify the order of initializing command queue register
Date:   Mon, 16 Jul 2018 16:36:19 +0100
Message-ID: <20180716153627.476-2-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180716153627.476-1-salil.mehta@huawei.com>
References: <20180716153627.476-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>

According to hardware's description, the head pointer register should
be written before the tail pointer register while doing command queue
initialization.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
index eca4b23..cf40afc 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
@@ -119,8 +119,8 @@ static void hclge_cmd_config_regs(struct hclge_cmq_ring *ring)
 		hclge_write_dev(hw, HCLGE_NIC_CSQ_DEPTH_REG,
 				(ring->desc_num >> HCLGE_NIC_CMQ_DESC_NUM_S) |
 				HCLGE_NIC_CMQ_ENABLE);
-		hclge_write_dev(hw, HCLGE_NIC_CSQ_TAIL_REG, 0);
 		hclge_write_dev(hw, HCLGE_NIC_CSQ_HEAD_REG, 0);
+		hclge_write_dev(hw, HCLGE_NIC_CSQ_TAIL_REG, 0);
 	} else {
 		hclge_write_dev(hw, HCLGE_NIC_CRQ_BASEADDR_L_REG,
 				lower_32_bits(dma));
@@ -129,8 +129,8 @@ static void hclge_cmd_config_regs(struct hclge_cmq_ring *ring)
 		hclge_write_dev(hw, HCLGE_NIC_CRQ_DEPTH_REG,
 				(ring->desc_num >> HCLGE_NIC_CMQ_DESC_NUM_S) |
 				HCLGE_NIC_CMQ_ENABLE);
-		hclge_write_dev(hw, HCLGE_NIC_CRQ_TAIL_REG, 0);
 		hclge_write_dev(hw, HCLGE_NIC_CRQ_HEAD_REG, 0);
+		hclge_write_dev(hw, HCLGE_NIC_CRQ_TAIL_REG, 0);
 	}
 }
 
-- 
2.7.4



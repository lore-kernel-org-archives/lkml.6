Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033D8C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 03:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC1825E2D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 03:42:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FC1825E2D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752358AbeF1DmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 23:42:20 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9181 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751107AbeF1DlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 23:41:17 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6978BAB89F740;
        Thu, 28 Jun 2018 11:41:03 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.382.0; Thu, 28 Jun 2018 11:40:54 +0800
From:   Peng Li <lipeng321@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
Subject: [PATCH net-next 11/11] net: hns3: use lower_32_bits and upper_32_bits
Date:   Thu, 28 Jun 2018 12:12:29 +0800
Message-ID: <1530159149-122284-12-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1530159149-122284-1-git-send-email-lipeng321@huawei.com>
References: <1530159149-122284-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>

MACRO lower_32_bits and upper_32_bits can help to get bits 0-31
and bits 32-63 of a number, so just use it.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
index 7049d0b..383ecf0 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
@@ -123,9 +123,9 @@ static void hclge_cmd_config_regs(struct hclge_cmq_ring *ring)
 
 	if (ring->flag == HCLGE_TYPE_CSQ) {
 		hclge_write_dev(hw, HCLGE_NIC_CSQ_BASEADDR_L_REG,
-				(u32)dma);
+				lower_32_bits(dma));
 		hclge_write_dev(hw, HCLGE_NIC_CSQ_BASEADDR_H_REG,
-				(u32)((dma >> 31) >> 1));
+				upper_32_bits(dma));
 		hclge_write_dev(hw, HCLGE_NIC_CSQ_DEPTH_REG,
 				(ring->desc_num >> HCLGE_NIC_CMQ_DESC_NUM_S) |
 				HCLGE_NIC_CMQ_ENABLE);
@@ -133,9 +133,9 @@ static void hclge_cmd_config_regs(struct hclge_cmq_ring *ring)
 		hclge_write_dev(hw, HCLGE_NIC_CSQ_HEAD_REG, 0);
 	} else {
 		hclge_write_dev(hw, HCLGE_NIC_CRQ_BASEADDR_L_REG,
-				(u32)dma);
+				lower_32_bits(dma));
 		hclge_write_dev(hw, HCLGE_NIC_CRQ_BASEADDR_H_REG,
-				(u32)((dma >> 31) >> 1));
+				upper_32_bits(dma));
 		hclge_write_dev(hw, HCLGE_NIC_CRQ_DEPTH_REG,
 				(ring->desc_num >> HCLGE_NIC_CMQ_DESC_NUM_S) |
 				HCLGE_NIC_CMQ_ENABLE);
-- 
2.9.3


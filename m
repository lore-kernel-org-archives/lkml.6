Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBFCECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2453B21522
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:31:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2453B21522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733256AbeISXKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 19:10:24 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12210 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733238AbeISXKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 19:10:23 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 55B66F5954B78;
        Thu, 20 Sep 2018 01:31:23 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.399.0; Thu, 20 Sep 2018 01:31:17 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>
Subject: [PATCH net-next 09/12] net: hns3: Fix cmdq registers initialization issue for vf
Date:   Wed, 19 Sep 2018 18:29:55 +0100
Message-ID: <20180919172958.12992-10-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180919172958.12992-1-salil.mehta@huawei.com>
References: <20180919172958.12992-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

According to hardware's description, the head pointer register should
be written before the tail pointer register while initializing the vf
command queue. Otherwise, it may trigger an interrupt even though there
is no command received.

Fixes: fedd0c15d288 ("net: hns3: Add HNS3 VF IMP(Integrated Management Proc) cmd interface")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c
index fb471fe..d8c0cc8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c
@@ -132,8 +132,8 @@ static int hclgevf_init_cmd_queue(struct hclgevf_dev *hdev,
 		reg_val |= HCLGEVF_NIC_CMQ_ENABLE;
 		hclgevf_write_dev(hw, HCLGEVF_NIC_CSQ_DEPTH_REG, reg_val);
 
-		hclgevf_write_dev(hw, HCLGEVF_NIC_CSQ_TAIL_REG, 0);
 		hclgevf_write_dev(hw, HCLGEVF_NIC_CSQ_HEAD_REG, 0);
+		hclgevf_write_dev(hw, HCLGEVF_NIC_CSQ_TAIL_REG, 0);
 		break;
 	case HCLGEVF_TYPE_CRQ:
 		reg_val = (u32)ring->desc_dma_addr;
@@ -145,8 +145,8 @@ static int hclgevf_init_cmd_queue(struct hclgevf_dev *hdev,
 		reg_val |= HCLGEVF_NIC_CMQ_ENABLE;
 		hclgevf_write_dev(hw, HCLGEVF_NIC_CRQ_DEPTH_REG, reg_val);
 
-		hclgevf_write_dev(hw, HCLGEVF_NIC_CRQ_TAIL_REG, 0);
 		hclgevf_write_dev(hw, HCLGEVF_NIC_CRQ_HEAD_REG, 0);
+		hclgevf_write_dev(hw, HCLGEVF_NIC_CRQ_TAIL_REG, 0);
 		break;
 	}
 
-- 
2.7.4



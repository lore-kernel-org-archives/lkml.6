Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD662ECE560
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C222154B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:29:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C222154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbeI0Anv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:43:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13152 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728498AbeI0Anu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 20:43:50 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9F320FD698320;
        Thu, 27 Sep 2018 02:29:33 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.399.0; Thu, 27 Sep 2018 02:29:26 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Fuyun Liang <liangfuyun1@huawei.com>
Subject: [PATCH net-next 02/10] net: hns3: Set extra mac address of pause param for HW
Date:   Wed, 26 Sep 2018 19:28:32 +0100
Message-ID: <20180926182840.28392-3-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180926182840.28392-1-salil.mehta@huawei.com>
References: <20180926182840.28392-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fuyun Liang <liangfuyun1@huawei.com>

The extra mac address of pause param is used to do double check
for pause frame. This patch set it to HW. If we do not do that,
pfc pause frame will be transferred protocol stack when normal
flow control mode is enabled.

Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c | 1 +
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
index 00bb394..ab7280d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
@@ -193,6 +193,7 @@ static int hclge_pause_param_cfg(struct hclge_dev *hdev, const u8 *addr,
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_CFG_MAC_PARA, false);
 
 	ether_addr_copy(pause_param->mac_addr, addr);
+	ether_addr_copy(pause_param->mac_addr_extra, addr);
 	pause_param->pause_trans_gap = pause_trans_gap;
 	pause_param->pause_trans_time = cpu_to_le16(pause_trans_time);
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
index dd4c194..e1568b8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
@@ -106,6 +106,10 @@ struct hclge_cfg_pause_param_cmd {
 	u8 pause_trans_gap;
 	u8 rsvd;
 	__le16 pause_trans_time;
+	u8 rsvd1[6];
+	/* extra mac address to do double check for pause frame */
+	u8 mac_addr_extra[ETH_ALEN];
+	u16 rsvd2;
 };
 
 struct hclge_pfc_stats_cmd {
-- 
2.7.4



Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDF1C64E93
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 14:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8972F2073F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 14:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8972F2073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbeI2V10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 17:27:26 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57434 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728365AbeI2V10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 17:27:26 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C108A916C7DA3;
        Sat, 29 Sep 2018 22:58:37 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.47.85.66) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.399.0; Sat, 29 Sep 2018 22:58:32 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Fuyun Liang <liangfuyun1@huawei.com>
Subject: [PATCH V2 net-next 02/10] net: hns3: Set extra mac address of pause param for HW
Date:   Sat, 29 Sep 2018 15:56:14 +0100
Message-ID: <20180929145622.5448-3-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180929145622.5448-1-salil.mehta@huawei.com>
References: <20180929145622.5448-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.85.66]
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
index 00bb39451bc5..ab7280d7f79c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
@@ -193,6 +193,7 @@ static int hclge_pause_param_cfg(struct hclge_dev *hdev, const u8 *addr,
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_CFG_MAC_PARA, false);
 
 	ether_addr_copy(pause_param->mac_addr, addr);
+	ether_addr_copy(pause_param->mac_addr_extra, addr);
 	pause_param->pause_trans_gap = pause_trans_gap;
 	pause_param->pause_trans_time = cpu_to_le16(pause_trans_time);
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
index dd4c194747c1..e1568b826aac 100644
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
2.11.0



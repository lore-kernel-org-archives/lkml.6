Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECEDECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89CF2159F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D89CF2159F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390829AbeIUVcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 17:32:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13101 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390678AbeIUVcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 17:32:54 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5045A904337F8;
        Fri, 21 Sep 2018 23:43:23 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.399.0; Fri, 21 Sep 2018 23:43:15 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Fuyun Liang <liangfuyun1@huawei.com>
Subject: [PATCH net-next 12/12] net: hns3: Remove redundant hclge_get_port_type()
Date:   Fri, 21 Sep 2018 16:41:48 +0100
Message-ID: <20180921154148.26756-13-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180921154148.26756-1-salil.mehta@huawei.com>
References: <20180921154148.26756-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Li <lipeng321@huawei.com>

This patch removes hclge_get_port_type which is redundant.

Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |  1 -
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 22 ----------------------
 2 files changed, 23 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index fc87e1b..564afd4 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -411,7 +411,6 @@ struct hnae3_ae_ops {
 	void (*get_link_mode)(struct hnae3_handle *handle,
 			      unsigned long *supported,
 			      unsigned long *advertising);
-	void (*get_port_type)(struct hnae3_handle *handle, u8 *port_type);
 };
 
 struct hnae3_dcb_ops {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 73d9d0d..2de5a00 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -5970,27 +5970,6 @@ static void hclge_get_link_mode(struct hnae3_handle *handle,
 	}
 }
 
-static void hclge_get_port_type(struct hnae3_handle *handle,
-				u8 *port_type)
-{
-	struct hclge_vport *vport = hclge_get_vport(handle);
-	struct hclge_dev *hdev = vport->back;
-	u8 media_type = hdev->hw.mac.media_type;
-
-	switch (media_type) {
-	case HNAE3_MEDIA_TYPE_FIBER:
-		*port_type = PORT_FIBRE;
-		break;
-	case HNAE3_MEDIA_TYPE_COPPER:
-		*port_type = PORT_TP;
-		break;
-	case HNAE3_MEDIA_TYPE_UNKNOWN:
-	default:
-		*port_type = PORT_OTHER;
-		break;
-	}
-}
-
 static const struct hnae3_ae_ops hclge_ops = {
 	.init_ae_dev = hclge_init_ae_dev,
 	.uninit_ae_dev = hclge_uninit_ae_dev,
@@ -6048,7 +6027,6 @@ static const struct hnae3_ae_ops hclge_ops = {
 	.get_regs = hclge_get_regs,
 	.set_led_id = hclge_set_led_id,
 	.get_link_mode = hclge_get_link_mode,
-	.get_port_type = hclge_get_port_type,
 };
 
 static struct hnae3_ae_algo ae_algo = {
-- 
2.7.4



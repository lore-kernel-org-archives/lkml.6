Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36247C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF1C52159F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF1C52159F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390804AbeIUVcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 17:32:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13099 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390757AbeIUVcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 17:32:52 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3CEDD5135832C;
        Fri, 21 Sep 2018 23:43:18 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.399.0; Fri, 21 Sep 2018 23:43:09 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Fuyun Liang <liangfuyun1@huawei.com>
Subject: [PATCH net-next 10/12] net: hns3: Add get_media_type ops support for VF
Date:   Fri, 21 Sep 2018 16:41:46 +0100
Message-ID: <20180921154148.26756-11-salil.mehta@huawei.com>
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

This patch adds the ops of get_media_type support for VF.

Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h               |  1 +
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 11 +++++++++++
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h |  1 +
 3 files changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 17db631..fc87e1b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -107,6 +107,7 @@ enum hnae3_media_type {
 	HNAE3_MEDIA_TYPE_FIBER,
 	HNAE3_MEDIA_TYPE_COPPER,
 	HNAE3_MEDIA_TYPE_BACKPLANE,
+	HNAE3_MEDIA_TYPE_NONE,
 };
 
 enum hnae3_reset_notify_type {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index b644187..9781931 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1340,6 +1340,8 @@ static int hclgevf_configure(struct hclgevf_dev *hdev)
 {
 	int ret;
 
+	hdev->hw.mac.media_type = HNAE3_MEDIA_TYPE_NONE;
+
 	/* get queue configuration from PF */
 	ret = hclgevf_get_queue_info(hdev);
 	if (ret)
@@ -2009,6 +2011,14 @@ void hclgevf_update_speed_duplex(struct hclgevf_dev *hdev, u32 speed,
 	hdev->hw.mac.duplex = duplex;
 }
 
+static void hclgevf_get_media_type(struct hnae3_handle *handle,
+				  u8 *media_type)
+{
+	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
+	if (media_type)
+		*media_type = hdev->hw.mac.media_type;
+}
+
 static const struct hnae3_ae_ops hclgevf_ops = {
 	.init_ae_dev = hclgevf_init_ae_dev,
 	.uninit_ae_dev = hclgevf_uninit_ae_dev,
@@ -2046,6 +2056,7 @@ static const struct hnae3_ae_ops hclgevf_ops = {
 	.get_tqps_and_rss_info = hclgevf_get_tqps_and_rss_info,
 	.get_status = hclgevf_get_status,
 	.get_ksettings_an_result = hclgevf_get_ksettings_an_result,
+	.get_media_type = hclgevf_get_media_type,
 };
 
 static struct hnae3_ae_algo ae_algovf = {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
index b23ba17..2af01f1 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
@@ -66,6 +66,7 @@ enum hclgevf_states {
 #define HCLGEVF_MPF_ENBALE 1
 
 struct hclgevf_mac {
+	u8 media_type;
 	u8 mac_addr[ETH_ALEN];
 	int link;
 	u8 duplex;
-- 
2.7.4



Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7AEC43444
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 561D6217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbeLRLCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:02:17 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:38224 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726691AbeLRLCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:02:08 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D98A3B6677BC2;
        Tue, 18 Dec 2018 19:02:03 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Tue, 18 Dec 2018 19:01:57 +0800
From:   Peng Li <lipeng321@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
Subject: [PATCH net-next 07/12] net: hns3: update coalesce param per second
Date:   Tue, 18 Dec 2018 19:37:54 +0800
Message-ID: <1545133079-79605-8-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1545133079-79605-1-git-send-email-lipeng321@huawei.com>
References: <1545133079-79605-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

coalesce param updates every 100 napi times, it may update a little
late if ping test after a high rate flow, may over napi poll is called
100 times as ping test sends packets every second.

This patch updates coalesce param every second, instead with every
100 napi times. It can not update the param 100% in time, but the
lag time is very short.

Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 8 +++-----
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h | 4 ----
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 354eca8..d060029 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -240,7 +240,6 @@ static void hns3_vector_gl_rl_init(struct hns3_enet_tqp_vector *tqp_vector,
 	tqp_vector->tx_group.coal.int_gl = HNS3_INT_GL_50K;
 	tqp_vector->rx_group.coal.int_gl = HNS3_INT_GL_50K;
 
-	tqp_vector->int_adapt_down = HNS3_INT_ADAPT_DOWN_START;
 	tqp_vector->rx_group.coal.flow_level = HNS3_FLOW_LOW;
 	tqp_vector->tx_group.coal.flow_level = HNS3_FLOW_LOW;
 }
@@ -2846,10 +2845,10 @@ static void hns3_update_new_int_gl(struct hns3_enet_tqp_vector *tqp_vector)
 	struct hns3_enet_ring_group *tx_group = &tqp_vector->tx_group;
 	bool rx_update, tx_update;
 
-	if (tqp_vector->int_adapt_down > 0) {
-		tqp_vector->int_adapt_down--;
+	/* update param every 1000ms */
+	if (time_before(jiffies,
+			tqp_vector->last_jiffies + msecs_to_jiffies(1000)))
 		return;
-	}
 
 	if (rx_group->coal.gl_adapt_enable) {
 		rx_update = hns3_get_new_int_gl(rx_group);
@@ -2866,7 +2865,6 @@ static void hns3_update_new_int_gl(struct hns3_enet_tqp_vector *tqp_vector)
 	}
 
 	tqp_vector->last_jiffies = jiffies;
-	tqp_vector->int_adapt_down = HNS3_INT_ADAPT_DOWN_START;
 }
 
 static int hns3_nic_common_poll(struct napi_struct *napi, int budget)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index 4e4b48b..e55995e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -476,8 +476,6 @@ enum hns3_link_mode_bits {
 #define HNS3_INT_RL_MAX			0x00EC
 #define HNS3_INT_RL_ENABLE_MASK		0x40
 
-#define HNS3_INT_ADAPT_DOWN_START	100
-
 struct hns3_enet_coalesce {
 	u16 int_gl;
 	u8 gl_adapt_enable;
@@ -512,8 +510,6 @@ struct hns3_enet_tqp_vector {
 
 	char name[HNAE3_INT_NAME_LEN];
 
-	/* when 0 should adjust interrupt coalesce parameter */
-	u8 int_adapt_down;
 	unsigned long last_jiffies;
 } ____cacheline_internodealigned_in_smp;
 
-- 
1.9.1


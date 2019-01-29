Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F3FC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696232177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfA2HcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 02:32:20 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:37991 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725554AbfA2HcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 02:32:19 -0500
X-UUID: 277929175f9a4aaeb2d69712145d7728-20190129
X-UUID: 277929175f9a4aaeb2d69712145d7728-20190129
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2091969577; Tue, 29 Jan 2019 15:32:13 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 29 Jan 2019 15:32:11 +0800
Received: from mtkslt302.mediatek.inc (10.21.14.115) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 29 Jan 2019 15:32:11 +0800
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, CK HU <ck.hu@mediatek.com>
CC:     Daniel Kurtz <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Daoyuan Huang <daoyuan.huang@mediatek.com>,
        Jiaguang Zhang <jiaguang.zhang@mediatek.com>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <ginny.chen@mediatek.com>, <kendrick.hsu@mediatek.com>,
        Frederic Chen <Frederic.Chen@mediatek.com>
Subject: [PATCH 05/10] soc: mediatek: add subsys-base address transform function
Date:   Tue, 29 Jan 2019 15:32:02 +0800
Message-ID: <1548747128-60136-6-git-send-email-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548747128-60136-1-git-send-email-bibby.hsieh@mediatek.com>
References: <1548747128-60136-1-git-send-email-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 19ACBC06876FCEEF30577642EE995CD9FCE41EDC8D719EB9AE758A76189D21352000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCE cannot know the register base address, we store the subsys-base address
relationship in the device node, and store the relationship by
cmdq_register_device function.

When the client pass the base address and offset into GCE API,
we will get the subsys ID by this API.

Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
---
 drivers/soc/mediatek/mtk-cmdq-helper.c | 17 +++++++++++++++++
 include/linux/soc/mediatek/mtk-cmdq.h  | 12 ++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index ff9fef5..6e4b85e 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -15,6 +15,23 @@
 #define CMDQ_EOC_CMD		((u64)((CMDQ_CODE_EOC << CMDQ_OP_CODE_SHIFT)) \
 				<< 32 | CMDQ_EOC_IRQ_EN)
 
+u8 cmdq_subsys_base_to_id(struct cmdq_base *clt_base, u32 base)
+{
+	u8 i;
+
+	if (!clt_base)
+		return -EINVAL;
+
+	base = base & 0xFFFF0000;
+	for (i = 0; i < clt_base->count; i++) {
+		if (clt_base->subsys[i].base == base)
+			return clt_base->subsys[i].id;
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(cmdq_subsys_base_to_id);
+
 static void cmdq_client_timeout(struct timer_list *t)
 {
 	struct cmdq_client *client = from_timer(client, t, timer);
diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
index 4e88999..0c7a6ee 100644
--- a/include/linux/soc/mediatek/mtk-cmdq.h
+++ b/include/linux/soc/mediatek/mtk-cmdq.h
@@ -15,6 +15,16 @@
 
 struct cmdq_pkt;
 
+struct cmdq_subsys {
+	u32 base;
+	u8 id;
+};
+
+struct cmdq_base {
+	struct cmdq_subsys subsys[32];
+	u8 count;
+};
+
 struct cmdq_client {
 	spinlock_t lock;
 	u32 pkt_cnt;
@@ -127,4 +137,6 @@ int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb cb,
  */
 int cmdq_pkt_flush(struct cmdq_pkt *pkt);
 
+u8 cmdq_subsys_base_to_id(struct cmdq_base *clt_base, u32 base);
+
 #endif	/* __MTK_CMDQ_H__ */
-- 
1.9.1


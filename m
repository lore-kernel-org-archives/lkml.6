Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132EDC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6852183F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfA2HcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 02:32:25 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:20119 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725786AbfA2HcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 02:32:22 -0500
X-UUID: 0588ae895bbf41be959d4b0382ef8911-20190129
X-UUID: 0588ae895bbf41be959d4b0382ef8911-20190129
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 464381186; Tue, 29 Jan 2019 15:32:12 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 29 Jan 2019 15:32:12 +0800
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
Subject: [PATCH 06/10] soc: mediatek: add register device function
Date:   Tue, 29 Jan 2019 15:32:03 +0800
Message-ID: <1548747128-60136-7-git-send-email-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548747128-60136-1-git-send-email-bibby.hsieh@mediatek.com>
References: <1548747128-60136-1-git-send-email-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCE cannot know the register base address, we store the subsys-base address
relationship in the device node, and store the relationship by
cmdq_register_device function.

Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
---
 drivers/soc/mediatek/mtk-cmdq-helper.c | 24 ++++++++++++++++++++++++
 include/linux/soc/mediatek/mtk-cmdq.h  |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index 6e4b85e..6ad997f 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -32,6 +32,30 @@ u8 cmdq_subsys_base_to_id(struct cmdq_base *clt_base, u32 base)
 }
 EXPORT_SYMBOL(cmdq_subsys_base_to_id);
 
+struct cmdq_base *cmdq_register_device(struct device *dev)
+{
+	struct cmdq_base *clt_base;
+	struct of_phandle_args spec;
+	u32 idx;
+
+	clt_base = devm_kzalloc(dev, sizeof(*clt_base), GFP_KERNEL);
+	if (!clt_base)
+		return NULL;
+
+	/* parse subsys */
+	for (idx = 0; idx < ARRAY_SIZE(clt_base->subsys); idx++) {
+		if (of_parse_phandle_with_args(dev->of_node, "gce-subsys",
+		    "#gce-subsys-cells", idx, &spec))
+			break;
+		clt_base->subsys[idx].base = spec.args[0];
+		clt_base->subsys[idx].id = spec.args[1];
+	}
+	clt_base->count = idx;
+
+	return clt_base;
+}
+EXPORT_SYMBOL(cmdq_register_device);
+
 static void cmdq_client_timeout(struct timer_list *t)
 {
 	struct cmdq_client *client = from_timer(client, t, timer);
diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
index 0c7a6ee..a1f5eb6 100644
--- a/include/linux/soc/mediatek/mtk-cmdq.h
+++ b/include/linux/soc/mediatek/mtk-cmdq.h
@@ -138,5 +138,6 @@ int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb cb,
 int cmdq_pkt_flush(struct cmdq_pkt *pkt);
 
 u8 cmdq_subsys_base_to_id(struct cmdq_base *clt_base, u32 base);
+struct cmdq_base *cmdq_register_device(struct device *dev);
 
 #endif	/* __MTK_CMDQ_H__ */
-- 
1.9.1


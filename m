Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53BEC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA7862175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfA2Hcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 02:32:55 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:5051 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725730AbfA2HcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 02:32:24 -0500
X-UUID: 56c795c76bef427687a5aa4530569ff0-20190129
X-UUID: 56c795c76bef427687a5aa4530569ff0-20190129
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1057086815; Tue, 29 Jan 2019 15:32:16 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 29 Jan 2019 15:32:12 +0800
Received: from mtkslt302.mediatek.inc (10.21.14.115) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 29 Jan 2019 15:32:12 +0800
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
Subject: [PATCH 07/10] soc: mediatek: add cmdq_dev_get_event function
Date:   Tue, 29 Jan 2019 15:32:04 +0800
Message-ID: <1548747128-60136-8-git-send-email-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548747128-60136-1-git-send-email-bibby.hsieh@mediatek.com>
References: <1548747128-60136-1-git-send-email-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 4CE45F2FC5B550B8AC8860B88ABAAB76010FFFB65353564D761C9F06C5D9EEAB2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When client ask gce to clear or wait for event,
client need to pass event number to the API.
We suggest client store the event information in device node,
so we provide an API for client parse the event property.

Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
---
 drivers/soc/mediatek/mtk-cmdq-helper.c | 29 +++++++++++++++++++++++++++++
 include/linux/soc/mediatek/mtk-cmdq.h  |  1 +
 2 files changed, 30 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index 6ad997f..16c0393 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -56,6 +56,35 @@ struct cmdq_base *cmdq_register_device(struct device *dev)
 }
 EXPORT_SYMBOL(cmdq_register_device);
 
+s32 cmdq_dev_get_event(struct device *dev, const char *name)
+{
+	s32 index = 0;
+	struct of_phandle_args spec;
+	s32 result;
+
+	if (!dev)
+		return -EINVAL;
+
+	index = of_property_match_string(dev->of_node, "gce-event-names", name);
+	if (index < 0) {
+		dev_err(dev, "no gce-event-names property or no such event:%s",
+			name);
+		return index;
+	}
+
+	if (of_parse_phandle_with_args(dev->of_node, "gce-events",
+	    "#gce-event-cells", index, &spec)) {
+		dev_err(dev, "can't parse gce-events property");
+		return -ENODEV;
+	}
+
+	result = spec.args[0];
+	of_node_put(spec.np);
+
+	return result;
+}
+EXPORT_SYMBOL(cmdq_dev_get_event);
+
 static void cmdq_client_timeout(struct timer_list *t)
 {
 	struct cmdq_client *client = from_timer(client, t, timer);
diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
index a1f5eb6..e5b0a98 100644
--- a/include/linux/soc/mediatek/mtk-cmdq.h
+++ b/include/linux/soc/mediatek/mtk-cmdq.h
@@ -139,5 +139,6 @@ int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb cb,
 
 u8 cmdq_subsys_base_to_id(struct cmdq_base *clt_base, u32 base);
 struct cmdq_base *cmdq_register_device(struct device *dev);
+s32 cmdq_dev_get_event(struct device *dev, const char *name);
 
 #endif	/* __MTK_CMDQ_H__ */
-- 
1.9.1


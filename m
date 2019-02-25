Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B33C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 02:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB263213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 02:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbfBYCJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 21:09:50 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:35792 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727537AbfBYCJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 21:09:50 -0500
X-UUID: f2de0da55d91489f9118de8205985c87-20190225
X-UUID: f2de0da55d91489f9118de8205985c87-20190225
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <wangyan.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1757952975; Mon, 25 Feb 2019 10:09:36 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 25 Feb
 2019 10:09:35 +0800
Received: from mszsdaap41.mediatek.inc (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 25 Feb 2019 10:09:34 +0800
From:   wangyan wang <wangyan.wang@mediatek.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, CK Hu <ck.hu@mediatek.com>
CC:     wangyan wang <wangyan.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        chunhui dai <chunhui.dai@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <dri-devel@lists.freedesktop.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH V6 5/8] clk: mediatek: add MUX_GATE_FLAGS_2
Date:   Mon, 25 Feb 2019 10:09:09 +0800
Message-ID: <20190225020912.29120-6-wangyan.wang@mediatek.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190225020912.29120-1-wangyan.wang@mediatek.com>
References: <20190225020912.29120-1-wangyan.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chunhui dai <chunhui.dai@mediatek.com>

Add MUX_GATE_FLAGS_2 for the clock which needs to set two falgs.
Such as some mux need to set the flags of "CLK_MUX_ROUND_CLOSEST".

Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
Signed-off-by: wangyan wang <wangyan.wang@mediatek.com>
---
 drivers/clk/mediatek/clk-mtk.c |  2 +-
 drivers/clk/mediatek/clk-mtk.h | 20 ++++++++++++++------
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 9c0ae4278a94..2ed996404804 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -167,7 +167,7 @@ struct clk *mtk_clk_register_composite(const struct mtk_composite *mc,
 		mux->mask = BIT(mc->mux_width) - 1;
 		mux->shift = mc->mux_shift;
 		mux->lock = lock;
-
+		mux->flags = mc->mux_flags;
 		mux_hw = &mux->hw;
 		mux_ops = &clk_mux_ops;
 
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index f83c2bbb677e..4b88d196d52f 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -81,15 +81,13 @@ struct mtk_composite {
 	signed char divider_shift;
 	signed char divider_width;
 
+	u8 mux_flags;
+
 	signed char num_parents;
 };
 
-/*
- * In case the rate change propagation to parent clocks is undesirable,
- * this macro allows to specify the clock flags manually.
- */
-#define MUX_GATE_FLAGS(_id, _name, _parents, _reg, _shift, _width,	\
-			_gate, _flags) {				\
+#define MUX_GATE_FLAGS_2(_id, _name, _parents, _reg, _shift,		\
+				_width, _gate, _flags, _muxflags) {	\
 		.id = _id,						\
 		.name = _name,						\
 		.mux_reg = _reg,					\
@@ -101,8 +99,18 @@ struct mtk_composite {
 		.parent_names = _parents,				\
 		.num_parents = ARRAY_SIZE(_parents),			\
 		.flags = _flags,					\
+		.mux_flags = _muxflags,					\
 	}
 
+/*
+ * In case the rate change propagation to parent clocks is undesirable,
+ * this macro allows to specify the clock flags manually.
+ */
+#define MUX_GATE_FLAGS(_id, _name, _parents, _reg, _shift, _width,	\
+			_gate, _flags)					\
+		MUX_GATE_FLAGS_2(_id, _name, _parents, _reg,		\
+					_shift, _width, _gate, _flags, 0)
+
 /*
  * Unless necessary, all MUX_GATE clocks propagate rate changes to their
  * parent clock by default.
-- 
2.14.1


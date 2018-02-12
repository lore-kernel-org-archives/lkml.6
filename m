Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934169AbeBLLb1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 06:31:27 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:54341 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S934034AbeBLL3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 06:29:45 -0500
X-UUID: da4fc280d12a4ba0a0b57216fe22e00f-20180212
From: Ryder Lee <ryder.lee@mediatek.com>
To: Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>
CC: Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, Garlic Tseng <garlic.tseng@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v3 2/5] clk: mediatek: modify MT7622 audsys to adapt MFD device
Date: Mon, 12 Feb 2018 19:28:48 +0800
Message-ID: <f8e87179bd7700130e294393592719fac8590c59.1518424204.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1518424204.git.ryder.lee@mediatek.com>
References: <cover.1518424204.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the new MFD device is in place, switch probing method to adapt it.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/clk/mediatek/clk-mt7622-aud.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt7622-aud.c b/drivers/clk/mediatek/clk-mt7622-aud.c
index 13f752d..68c52a9 100644
--- a/drivers/clk/mediatek/clk-mt7622-aud.c
+++ b/drivers/clk/mediatek/clk-mt7622-aud.c
@@ -142,11 +142,16 @@ static int clk_mt7622_audiosys_init(struct platform_device *pdev)
 {
 	struct clk_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
+	struct device_node *pnode = pdev->dev.parent->of_node;
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_AUDIO_NR_CLK);
 
-	mtk_clk_register_gates(node, audio_clks, ARRAY_SIZE(audio_clks),
+	/* Check if called from MFD */
+	if (!pnode)
+		pnode = node;
+
+	mtk_clk_register_gates(pnode, audio_clks, ARRAY_SIZE(audio_clks),
 			       clk_data);
 
 	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
-- 
1.9.1

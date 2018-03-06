Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753311AbeCFJKD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 04:10:03 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:21185 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753237AbeCFJKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 04:10:01 -0500
X-UUID: c5ac2fea6cb546e7afea50c77dc41592-20180306
From: Ryder Lee <ryder.lee@mediatek.com>
To: Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>
CC: Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, Garlic Tseng <garlic.tseng@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v4 2/6] clk: mediatek: add devm_of_platform_populate() for MT7622 audsys
Date: Tue, 6 Mar 2018 17:09:27 +0800
Message-ID: <3a3c198707a69297abc05d2a7fef97857e7fab5a.1520327262.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1520327262.git.ryder.lee@mediatek.com>
References: <cover.1520327262.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devm_of_platform_populate() to populate devices which are children
of the root node.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/clk/mediatek/clk-mt7622-aud.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622-aud.c b/drivers/clk/mediatek/clk-mt7622-aud.c
index 13f752d..0a1109f 100644
--- a/drivers/clk/mediatek/clk-mt7622-aud.c
+++ b/drivers/clk/mediatek/clk-mt7622-aud.c
@@ -142,6 +142,7 @@ static int clk_mt7622_audiosys_init(struct platform_device *pdev)
 {
 	struct clk_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
+
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_AUDIO_NR_CLK);
@@ -150,12 +151,15 @@ static int clk_mt7622_audiosys_init(struct platform_device *pdev)
 			       clk_data);
 
 	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
-	if (r)
+	if (r) {
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	return r;
+		return r;
+	}
+
+	return devm_of_platform_populate(&pdev->dev);
 }
 
 static const struct of_device_id of_match_clk_mt7622_aud[] = {
-- 
1.9.1

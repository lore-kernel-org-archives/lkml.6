Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751909AbeCTDRW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 23:17:22 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:11616 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751531AbeCTDRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 23:17:17 -0400
X-UUID: e913793e7aae49efb1c3693b39ffcdd5-20180320
From: Ryder Lee <ryder.lee@mediatek.com>
To: Stephen Boyd <sboyd@codeaurora.org>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        "Garlic Tseng" <garlic.tseng@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 1/2] clk: mediatek: add devm_of_platform_populate() for MT7622 audsys
Date: Tue, 20 Mar 2018 11:16:51 +0800
Message-ID: <004f07aef08148321c320ea09f8169982f73dd2b.1521514928.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23730.000
X-TM-AS-Result: No-1.558400-8.000000-10
X-TMASE-MatchedRID: LS8Ewxiu6UdYXTxImR5ZvLCvlllU7Dl1cx5k3wffojNcU0dNErOD+vlY
        oV6p/cSxwX0f1lPumDhPaUktJ/9D+gzyMxeMEX6wFEUknJ/kEl7dB/CxWTRRu+rAZ8KTspSz1xb
        LpYhisWb7RSSklMGgRFUMLsel7LEZwLTUp9XMgjaqyJlLmwvDaJklDFIDEmydacc1Uwk2T+nCpq
        Uiw84oCHIhCr7FuKoLD1y8R38S3l1URzkirO0Q1F5h9KQWrq4BvuMTr7CQJJ5+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.558400-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23730.000
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devm_of_platform_populate() to populate devices which are children
of the root node.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/clk/mediatek/clk-mt7622-aud.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt7622-aud.c b/drivers/clk/mediatek/clk-mt7622-aud.c
index 13f752d..4f3d47b 100644
--- a/drivers/clk/mediatek/clk-mt7622-aud.c
+++ b/drivers/clk/mediatek/clk-mt7622-aud.c
@@ -150,11 +150,23 @@ static int clk_mt7622_audiosys_init(struct platform_device *pdev)
 			       clk_data);
 
 	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
-	if (r)
+	if (r) {
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
+		goto err_clk_provider;
+	}
+
+	r = devm_of_platform_populate(&pdev->dev);
+	if (r)
+		goto err_plat_populate;
+
+	return 0;
+
+err_plat_populate:
+	of_clk_del_provider(node);
+err_clk_provider:
 	return r;
 }
 
-- 
1.9.1

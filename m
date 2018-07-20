Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4566BECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F6020673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="e5WChk9W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7F6020673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbeGTJZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 05:25:53 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:18155 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbeGTJZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 05:25:52 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id w6K8bg68025961;
        Fri, 20 Jul 2018 17:37:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w6K8bg68025961
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1532075862;
        bh=1jcGpU9CwWqFk1Trc2BUTC9THTTE/v15NMng7PlMzsQ=;
        h=From:To:Cc:Subject:Date:From;
        b=e5WChk9W3RbqnxcmeD5Qo/ZjeOV5Izf2pzBRs34D/TL5iH+D5BsluqzSCkJCwTqXw
         f0P1dF84r88/WsKm5qhWfDWJvdzVF7iPesIIDr+O8kG/7DRgGHpQFixYywVc7YtM3b
         G90wxFX9QYUOyyNxzJm6l7s7EzM5BLI56nAmVil6AxvplMaPs9g7MTCRykqAdzA/YA
         l1JaqhocsWPVCK70WQVC1zrAkOxf8Bs4sQqPOlHi+k8hRov86XhwAQmL+ZC02yxHFZ
         KWNZfH5hXelAk/SrdS1bxXA+a7gs2ZVxq6nBgFV2skx7tG10hAiqEUI7jfBqpBPu0r
         yA4yqxvWmWJVw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-clk@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] clk: uniphier: add NAND 200MHz clock
Date:   Fri, 20 Jul 2018 17:37:35 +0900
Message-Id: <1532075856-1723-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Denali NAND controller IP needs three clocks:

 - clk: controller core clock

 - clk_x: bus interface clock

 - ecc_clk: clock at which ECC circuitry is run

Currently, only the first one (50MHz) is provided.  The rest of the
two clock ports must be connected to the 200MHz clock line.  Add this.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/clk/uniphier/clk-uniphier-sys.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/uniphier/clk-uniphier-sys.c b/drivers/clk/uniphier/clk-uniphier-sys.c
index 4f5ff9f..a582446 100644
--- a/drivers/clk/uniphier/clk-uniphier-sys.c
+++ b/drivers/clk/uniphier/clk-uniphier-sys.c
@@ -29,18 +29,20 @@
 	UNIPHIER_CLK_FACTOR("sd-200m", -1, "spll", 1, 10),		\
 	UNIPHIER_CLK_FACTOR("sd-133m", -1, "spll", 1, 15)
 
-/* Denali driver requires clk_x rate (clk: 50MHz, clk_x & ecc_clk: 200MHz) */
 #define UNIPHIER_LD4_SYS_CLK_NAND(idx)					\
-	UNIPHIER_CLK_FACTOR("nand-200m", -1, "spll", 1, 8),		\
-	UNIPHIER_CLK_GATE("nand", (idx), "nand-200m", 0x2104, 2)
+	UNIPHIER_CLK_FACTOR("nand-50m", -1, "spll", 1, 32),		\
+	UNIPHIER_CLK_GATE("nand", (idx), "nand-50m", 0x2104, 2)
 
 #define UNIPHIER_PRO5_SYS_CLK_NAND(idx)					\
-	UNIPHIER_CLK_FACTOR("nand-200m", -1, "spll", 1, 12),		\
-	UNIPHIER_CLK_GATE("nand", (idx), "nand-200m", 0x2104, 2)
+	UNIPHIER_CLK_FACTOR("nand-50m", -1, "spll", 1, 48),		\
+	UNIPHIER_CLK_GATE("nand", (idx), "nand-50m", 0x2104, 2)
 
 #define UNIPHIER_LD11_SYS_CLK_NAND(idx)					\
-	UNIPHIER_CLK_FACTOR("nand-200m", -1, "spll", 1, 10),		\
-	UNIPHIER_CLK_GATE("nand", (idx), "nand-200m", 0x210c, 0)
+	UNIPHIER_CLK_FACTOR("nand-50m", -1, "spll", 1, 40),		\
+	UNIPHIER_CLK_GATE("nand", (idx), "nand-50m", 0x210c, 0)
+
+#define UNIPHIER_SYS_CLK_NAND_4X(idx)					\
+	UNIPHIER_CLK_FACTOR("nand-4x", (idx), "nand", 4, 1)
 
 #define UNIPHIER_LD11_SYS_CLK_EMMC(idx)					\
 	UNIPHIER_CLK_GATE("emmc", (idx), NULL, 0x210c, 2)
@@ -94,6 +96,7 @@ const struct uniphier_clk_data uniphier_ld4_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("uart", 0, "a2pll", 1, 16),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 16),
 	UNIPHIER_LD4_SYS_CLK_NAND(2),
+	UNIPHIER_SYS_CLK_NAND_4X(3),
 	UNIPHIER_LD4_SYS_CLK_SD,
 	UNIPHIER_CLK_FACTOR("usb2", -1, "upll", 1, 12),
 	UNIPHIER_LD4_SYS_CLK_STDMAC(8),			/* Ether, HSC, MIO */
@@ -109,6 +112,7 @@ const struct uniphier_clk_data uniphier_pro4_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("uart", 0, "a2pll", 1, 8),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 32),
 	UNIPHIER_LD4_SYS_CLK_NAND(2),
+	UNIPHIER_SYS_CLK_NAND_4X(3),
 	UNIPHIER_LD4_SYS_CLK_SD,
 	UNIPHIER_CLK_FACTOR("usb2", -1, "upll", 1, 12),
 	UNIPHIER_PRO4_SYS_CLK_ETHER(6),
@@ -131,6 +135,7 @@ const struct uniphier_clk_data uniphier_sld8_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("uart", 0, "spll", 1, 20),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 16),
 	UNIPHIER_LD4_SYS_CLK_NAND(2),
+	UNIPHIER_SYS_CLK_NAND_4X(3),
 	UNIPHIER_LD4_SYS_CLK_SD,
 	UNIPHIER_CLK_FACTOR("usb2", -1, "upll", 1, 12),
 	UNIPHIER_LD4_SYS_CLK_STDMAC(8),			/* Ether, HSC, MIO */
@@ -144,6 +149,7 @@ const struct uniphier_clk_data uniphier_pro5_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("uart", 0, "dapll2", 1, 40),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 48),
 	UNIPHIER_PRO5_SYS_CLK_NAND(2),
+	UNIPHIER_SYS_CLK_NAND_4X(3),
 	UNIPHIER_PRO5_SYS_CLK_SD,
 	UNIPHIER_LD4_SYS_CLK_STDMAC(8),				/* HSC */
 	UNIPHIER_PRO4_SYS_CLK_GIO(12),				/* PCIe, USB3 */
@@ -159,6 +165,7 @@ const struct uniphier_clk_data uniphier_pxs2_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("uart", 0, "spll", 1, 27),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 48),
 	UNIPHIER_PRO5_SYS_CLK_NAND(2),
+	UNIPHIER_SYS_CLK_NAND_4X(3),
 	UNIPHIER_PRO5_SYS_CLK_SD,
 	UNIPHIER_PRO4_SYS_CLK_ETHER(6),
 	UNIPHIER_LD4_SYS_CLK_STDMAC(8),				/* HSC, RLE */
@@ -181,6 +188,7 @@ const struct uniphier_clk_data uniphier_ld11_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("uart", 0, "spll", 1, 34),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 40),
 	UNIPHIER_LD11_SYS_CLK_NAND(2),
+	UNIPHIER_SYS_CLK_NAND_4X(3),
 	UNIPHIER_LD11_SYS_CLK_EMMC(4),
 	/* Index 5 reserved for eMMC PHY */
 	UNIPHIER_LD11_SYS_CLK_ETHER(6),
@@ -214,6 +222,7 @@ const struct uniphier_clk_data uniphier_ld20_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("uart", 0, "spll", 1, 34),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 40),
 	UNIPHIER_LD11_SYS_CLK_NAND(2),
+	UNIPHIER_SYS_CLK_NAND_4X(3),
 	UNIPHIER_LD11_SYS_CLK_EMMC(4),
 	/* Index 5 reserved for eMMC PHY */
 	UNIPHIER_LD20_SYS_CLK_SD,
@@ -256,6 +265,7 @@ const struct uniphier_clk_data uniphier_pxs3_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 40),
 	UNIPHIER_LD20_SYS_CLK_SD,
 	UNIPHIER_LD11_SYS_CLK_NAND(2),
+	UNIPHIER_SYS_CLK_NAND_4X(3),
 	UNIPHIER_LD11_SYS_CLK_EMMC(4),
 	UNIPHIER_CLK_GATE("ether0", 6, NULL, 0x210c, 9),
 	UNIPHIER_CLK_GATE("ether1", 7, NULL, 0x210c, 10),
-- 
2.7.4


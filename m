Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE42DC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F182083A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bdm5Awht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99F182083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbeH3VTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 17:19:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:55004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbeH3VTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 17:19:31 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67D2F20838;
        Thu, 30 Aug 2018 17:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535649383;
        bh=OV1qyjanQYsQN++8ifF4j+w1X66MYRMfhYNwp0RBeQU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Bdm5Awhtz37Tjs6lu4ERSAegSvkzIiw5K9RqbJ8T/RgfydOe5KtSaR14oWhDHIQO7
         39yWMXnTgmE6IhC0PBTfkLdGDev8+LcYRTmLbSVGhjNKei3FDS2kdgT2QqrDqLg8DI
         esn9scKpaubafXmoKAK7WQEPXO92iobGNerAtTbk=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH 2/6] clk: imx: vf610: Add CRC clock
Date:   Thu, 30 Aug 2018 19:15:35 +0200
Message-Id: <20180830171539.20008-3-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180830171539.20008-1-krzk@kernel.org>
References: <20180830171539.20008-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the clock for CRC block allowing it to be enabled by HW CRC driver.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/clk/imx/clk-vf610.c             | 1 +
 include/dt-bindings/clock/vf610-clock.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-vf610.c b/drivers/clk/imx/clk-vf610.c
index 6dae54325a91..78f2602c81ad 100644
--- a/drivers/clk/imx/clk-vf610.c
+++ b/drivers/clk/imx/clk-vf610.c
@@ -332,6 +332,7 @@ static void __init vf610_clocks_init(struct device_node *ccm_node)
 	clk[VF610_CLK_DSPI2] = imx_clk_gate2("dspi2", "ipg_bus", CCM_CCGR6, CCM_CCGRx_CGn(12));
 	clk[VF610_CLK_DSPI3] = imx_clk_gate2("dspi3", "ipg_bus", CCM_CCGR6, CCM_CCGRx_CGn(13));
 
+	clk[VF610_CLK_CRC] = imx_clk_gate2("crc", "ipg_bus", CCM_CCGR1, CCM_CCGRx_CGn(3));
 	clk[VF610_CLK_WDT] = imx_clk_gate2("wdt", "ipg_bus", CCM_CCGR1, CCM_CCGRx_CGn(14));
 
 	clk[VF610_CLK_ESDHC0_SEL] = imx_clk_mux("esdhc0_sel", CCM_CSCMR1, 16, 2, esdhc_sels, 4);
diff --git a/include/dt-bindings/clock/vf610-clock.h b/include/dt-bindings/clock/vf610-clock.h
index 45997750c8a0..03f0731c5a69 100644
--- a/include/dt-bindings/clock/vf610-clock.h
+++ b/include/dt-bindings/clock/vf610-clock.h
@@ -199,6 +199,7 @@
 #define VF610_CLK_WKPU			186
 #define VF610_CLK_TCON0			187
 #define VF610_CLK_TCON1			188
-#define VF610_CLK_END			189
+#define VF610_CLK_CRC			189
+#define VF610_CLK_END			190
 
 #endif /* __DT_BINDINGS_CLOCK_VF610_H */
-- 
2.14.1


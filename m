Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754141AbeCFWC4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 17:02:56 -0500
Received: from botnar.kaiser.cx ([176.28.20.183]:40896 "EHLO botnar.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753805AbeCFWCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 17:02:55 -0500
From: Martin Kaiser <martin@kaiser.cx>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] clk: imx25: set correct parents for ssi ipg clocks
Date: Tue,  6 Mar 2018 23:02:15 +0100
Message-Id: <1520373735-13699-1-git-send-email-martin@kaiser.cx>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ssi1_ipg clock depends on ssi1_ipg_per. Set ssi1_ipg_per as parent
clock of ssi1_ipg. Without this link, the fsl_ssi driver does not
activate the ssi1_ipg clock correctly and ssi1 is unable to transfer
audio data.

Fix the parent clock of ssi2 as well, it shows the same behaviour.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
Dear all,

could you have a look at this patch? This makes SSI1 and 2 work for me.
With the default "ipg" parent clocks, I get no ipg clocks on the SSIs.
However, I was wondering why we don't need anything similar e.g. for the
UARTs...

Best regards,
Martin

 drivers/clk/imx/clk-imx25.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx25.c b/drivers/clk/imx/clk-imx25.c
index 23686f7..ee2852f 100644
--- a/drivers/clk/imx/clk-imx25.c
+++ b/drivers/clk/imx/clk-imx25.c
@@ -217,8 +217,8 @@ static int __init __mx25_clocks_init(void __iomem *ccm_base)
 	clk[sim2_ipg] = imx_clk_gate("sim2_ipg", "ipg", ccm(CCM_CGCR2),  8);
 	clk[slcdc_ipg] = imx_clk_gate("slcdc_ipg", "ipg", ccm(CCM_CGCR2),  9);
 	clk[spba_ipg] = imx_clk_gate("spba_ipg", "ipg", ccm(CCM_CGCR2),  10);
-	clk[ssi1_ipg] = imx_clk_gate("ssi1_ipg", "ipg", ccm(CCM_CGCR2), 11);
-	clk[ssi2_ipg] = imx_clk_gate("ssi2_ipg", "ipg", ccm(CCM_CGCR2), 12);
+	clk[ssi1_ipg] = imx_clk_gate("ssi1_ipg", "ssi1_ipg_per", ccm(CCM_CGCR2), 11);
+	clk[ssi2_ipg] = imx_clk_gate("ssi2_ipg", "ssi2_ipg_per", ccm(CCM_CGCR2), 12);
 	clk[tsc_ipg] = imx_clk_gate("tsc_ipg", "ipg", ccm(CCM_CGCR2), 13);
 	clk[uart1_ipg] = imx_clk_gate("uart1_ipg", "ipg", ccm(CCM_CGCR2), 14);
 	clk[uart2_ipg] = imx_clk_gate("uart2_ipg", "ipg", ccm(CCM_CGCR2), 15);
-- 
2.1.4

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939450AbeE1OyF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:54:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:47506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937107AbeE1K2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:28:07 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 042/329] net: stmmac: dwmac-meson8b: propagate rate changes to the parent clock
Date: Mon, 28 May 2018 11:59:31 +0200
Message-Id: <20180528100245.948719589@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit fb7d38a70e1d8ffd54f7a7464dcc4889d7e490ad ]

On Meson8b the only valid input clock is MPLL2. The bootloader
configures that to run at 500002394Hz which cannot be divided evenly
down to 125MHz using the m250_div clock. Currently the common clock
framework chooses a m250_div of 2 - with the internal fixed
"divide by 10" this results in a RGMII TX clock of 125001197Hz (120Hz
above the requested 125MHz).

Letting the common clock framework propagate the rate changes up to the
parent of m250_mux allows us to get the best possible clock rate. With
this patch the common clock framework calculates a rate of
very-close-to-250MHz (249999701Hz to be exact) for the MPLL2 clock
(which is the mux input). Dividing that by 2 (which is an internal,
fixed divider for the RGMII TX clock) gives us an RGMII TX clock of
124999850Hz (which is only 150Hz off the requested 125MHz, compared to
1197Hz based on the MPLL2 rate set by u-boot and the Amlogic GPL kernel
sources).

SoCs from the Meson GX series are not affected by this change because
the input clock is FCLK_DIV2 whose rate cannot be changed (which is fine
since it's running at 1GHz, so it's already a multiple of 250MHz and
125MHz).

Fixes: 566e8251625304 ("net: stmmac: add a glue driver for the Amlogic Meson 8b / GXBB DWMAC")
Suggested-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
Tested-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
@@ -118,7 +118,7 @@ static int meson8b_init_clk(struct meson
 	snprintf(clk_name, sizeof(clk_name), "%s#m250_sel", dev_name(dev));
 	init.name = clk_name;
 	init.ops = &clk_mux_ops;
-	init.flags = 0;
+	init.flags = CLK_SET_RATE_PARENT;
 	init.parent_names = mux_parent_names;
 	init.num_parents = MUX_CLK_NUM_PARENTS;
 

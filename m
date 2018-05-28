Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424233AbeE1LNL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:13:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423518AbeE1LND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:13:03 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
        Ziyuan Xu <xzy.xu@rock-chips.com>, Caesar Wang <wxt@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 199/272] phy: rockchip-emmc: retry calpad busy trimming
Date: Mon, 28 May 2018 12:03:52 +0200
Message-Id: <20180528100257.302712775@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shawn Lin <shawn.lin@rock-chips.com>

[ Upstream commit a4781c2a74b249cad814ceea7272997bbd20051e ]

It turns out that 5us isn't enough for all cases, so let's
retry some more times to wait for caldone.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Tested-by: Ziyuan Xu <xzy.xu@rock-chips.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/phy/rockchip/phy-rockchip-emmc.c |   27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

--- a/drivers/phy/rockchip/phy-rockchip-emmc.c
+++ b/drivers/phy/rockchip/phy-rockchip-emmc.c
@@ -76,6 +76,10 @@
 #define PHYCTRL_OTAPDLYSEL_MASK		0xf
 #define PHYCTRL_OTAPDLYSEL_SHIFT	0x7
 
+#define PHYCTRL_IS_CALDONE(x) \
+	((((x) >> PHYCTRL_CALDONE_SHIFT) & \
+	  PHYCTRL_CALDONE_MASK) == PHYCTRL_CALDONE_DONE)
+
 struct rockchip_emmc_phy {
 	unsigned int	reg_offset;
 	struct regmap	*reg_base;
@@ -90,6 +94,7 @@ static int rockchip_emmc_phy_power(struc
 	unsigned int freqsel = PHYCTRL_FREQSEL_200M;
 	unsigned long rate;
 	unsigned long timeout;
+	int ret;
 
 	/*
 	 * Keep phyctrl_pdb and phyctrl_endll low to allow
@@ -160,17 +165,19 @@ static int rockchip_emmc_phy_power(struc
 				   PHYCTRL_PDB_SHIFT));
 
 	/*
-	 * According to the user manual, it asks driver to
-	 * wait 5us for calpad busy trimming
+	 * According to the user manual, it asks driver to wait 5us for
+	 * calpad busy trimming. However it is documented that this value is
+	 * PVT(A.K.A process,voltage and temperature) relevant, so some
+	 * failure cases are found which indicates we should be more tolerant
+	 * to calpad busy trimming.
 	 */
-	udelay(5);
-	regmap_read(rk_phy->reg_base,
-		    rk_phy->reg_offset + GRF_EMMCPHY_STATUS,
-		    &caldone);
-	caldone = (caldone >> PHYCTRL_CALDONE_SHIFT) & PHYCTRL_CALDONE_MASK;
-	if (caldone != PHYCTRL_CALDONE_DONE) {
-		pr_err("rockchip_emmc_phy_power: caldone timeout.\n");
-		return -ETIMEDOUT;
+	ret = regmap_read_poll_timeout(rk_phy->reg_base,
+				       rk_phy->reg_offset + GRF_EMMCPHY_STATUS,
+				       caldone, PHYCTRL_IS_CALDONE(caldone),
+				       0, 50);
+	if (ret) {
+		pr_err("%s: caldone failed, ret=%d\n", __func__, ret);
+		return ret;
 	}
 
 	/* Set the frequency of the DLL operation */

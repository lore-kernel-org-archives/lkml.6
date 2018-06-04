Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753027AbeFDHYR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:24:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752536AbeFDHBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:01:55 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mathias Kresin <dev@kresin.me>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>, John Crispin <john@phrozen.org>,
        linux-mips@linux-mips.org, James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.14 36/52] MIPS: lantiq: gphy: Drop reboot/remove reset asserts
Date: Mon,  4 Jun 2018 08:58:31 +0200
Message-Id: <20180604065608.017672204@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180604065606.532044490@linuxfoundation.org>
References: <20180604065606.532044490@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Kresin <dev@kresin.me>

commit 32795631e67e16141aa5e065c28ba03bf17abb90 upstream.

While doing a global software reset, these bits are not cleared and let
some bootloader fail to initialise the GPHYs. The bootloader don't
expect the GPHYs in reset, as they aren't during power on.

The asserts were a workaround for a wrong syscon-reboot mask. With a
mask set which includes the GPHY resets, these resets aren't required
any more.

Fixes: 126534141b45 ("MIPS: lantiq: Add a GPHY driver which uses the RCU syscon-mfd")
Signed-off-by: Mathias Kresin <dev@kresin.me>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
Cc: John Crispin <john@phrozen.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.14+
Patchwork: https://patchwork.linux-mips.org/patch/19003/
[jhogan@kernel.org: Fix build warnings]
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/soc/lantiq/gphy.c |   36 ------------------------------------
 1 file changed, 36 deletions(-)

--- a/drivers/soc/lantiq/gphy.c
+++ b/drivers/soc/lantiq/gphy.c
@@ -30,7 +30,6 @@ struct xway_gphy_priv {
 	struct clk *gphy_clk_gate;
 	struct reset_control *gphy_reset;
 	struct reset_control *gphy_reset2;
-	struct notifier_block gphy_reboot_nb;
 	void __iomem *membase;
 	char *fw_name;
 };
@@ -64,24 +63,6 @@ static const struct of_device_id xway_gp
 };
 MODULE_DEVICE_TABLE(of, xway_gphy_match);
 
-static struct xway_gphy_priv *to_xway_gphy_priv(struct notifier_block *nb)
-{
-	return container_of(nb, struct xway_gphy_priv, gphy_reboot_nb);
-}
-
-static int xway_gphy_reboot_notify(struct notifier_block *reboot_nb,
-				   unsigned long code, void *unused)
-{
-	struct xway_gphy_priv *priv = to_xway_gphy_priv(reboot_nb);
-
-	if (priv) {
-		reset_control_assert(priv->gphy_reset);
-		reset_control_assert(priv->gphy_reset2);
-	}
-
-	return NOTIFY_DONE;
-}
-
 static int xway_gphy_load(struct device *dev, struct xway_gphy_priv *priv,
 			  dma_addr_t *dev_addr)
 {
@@ -205,14 +186,6 @@ static int xway_gphy_probe(struct platfo
 	reset_control_deassert(priv->gphy_reset);
 	reset_control_deassert(priv->gphy_reset2);
 
-	/* assert the gphy reset because it can hang after a reboot: */
-	priv->gphy_reboot_nb.notifier_call = xway_gphy_reboot_notify;
-	priv->gphy_reboot_nb.priority = -1;
-
-	ret = register_reboot_notifier(&priv->gphy_reboot_nb);
-	if (ret)
-		dev_warn(dev, "Failed to register reboot notifier\n");
-
 	platform_set_drvdata(pdev, priv);
 
 	return ret;
@@ -220,21 +193,12 @@ static int xway_gphy_probe(struct platfo
 
 static int xway_gphy_remove(struct platform_device *pdev)
 {
-	struct device *dev = &pdev->dev;
 	struct xway_gphy_priv *priv = platform_get_drvdata(pdev);
-	int ret;
-
-	reset_control_assert(priv->gphy_reset);
-	reset_control_assert(priv->gphy_reset2);
 
 	iowrite32be(0, priv->membase);
 
 	clk_disable_unprepare(priv->gphy_clk_gate);
 
-	ret = unregister_reboot_notifier(&priv->gphy_reboot_nb);
-	if (ret)
-		dev_warn(dev, "Failed to unregister reboot notifier\n");
-
 	return 0;
 }
 

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752339AbeFERDM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:03:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752275AbeFERDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:03:08 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>
Subject: [PATCH 4.4 15/37] i2c: rcar: make sure clocks are on when doing clock calculation
Date: Tue,  5 Jun 2018 19:01:20 +0200
Message-Id: <20180605170109.802214595@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180605170108.884872354@linuxfoundation.org>
References: <20180605170108.884872354@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit e43e0df13f8528ca55ed79f469c4b2af897fa796 upstream.

When calculating the bus speed, the clock should be on, of course. Most
bootloaders left them on, so this went unnoticed so far.

Move the ioremapping out of this clock-enabled-block and prepare for
adding hw initialization there, too.

Reported-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/busses/i2c-rcar.c |   26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -650,19 +650,23 @@ static int rcar_i2c_probe(struct platfor
 		return PTR_ERR(priv->clk);
 	}
 
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->io = devm_ioremap_resource(dev, res);
+	if (IS_ERR(priv->io))
+		return PTR_ERR(priv->io);
+
 	bus_speed = 100000; /* default 100 kHz */
 	of_property_read_u32(dev->of_node, "clock-frequency", &bus_speed);
 
 	priv->devtype = (enum rcar_i2c_type)of_match_device(rcar_i2c_dt_ids, dev)->data;
 
+	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
 	ret = rcar_i2c_clock_calculate(priv, bus_speed, dev);
 	if (ret < 0)
-		return ret;
+		goto out_pm_put;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->io = devm_ioremap_resource(dev, res);
-	if (IS_ERR(priv->io))
-		return PTR_ERR(priv->io);
+	pm_runtime_put(dev);
 
 	irq = platform_get_irq(pdev, 0);
 	init_waitqueue_head(&priv->wait);
@@ -682,22 +686,26 @@ static int rcar_i2c_probe(struct platfor
 			       dev_name(dev), priv);
 	if (ret < 0) {
 		dev_err(dev, "cannot get irq %d\n", irq);
-		return ret;
+		goto out_pm_disable;
 	}
 
-	pm_runtime_enable(dev);
 	platform_set_drvdata(pdev, priv);
 
 	ret = i2c_add_numbered_adapter(adap);
 	if (ret < 0) {
 		dev_err(dev, "reg adap failed: %d\n", ret);
-		pm_runtime_disable(dev);
-		return ret;
+		goto out_pm_disable;
 	}
 
 	dev_info(dev, "probed\n");
 
 	return 0;
+
+ out_pm_put:
+	pm_runtime_put(dev);
+ out_pm_disable:
+	pm_runtime_disable(dev);
+	return ret;
 }
 
 static int rcar_i2c_remove(struct platform_device *pdev)

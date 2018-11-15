Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BB0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208BE2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 208BE2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388407AbeKOToT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 14:44:19 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:46468 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388012AbeKOTnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 14:43:12 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id CF6DF5FD87; Thu, 15 Nov 2018 17:36:04 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Loic Poulain <loic.poulain@gmail.com>,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/15] Bluetooth: hci_bcm: Use "txco" and "extclk" to get clock reference
Date:   Thu, 15 Nov 2018 17:35:55 +0800
Message-Id: <20181115093603.26729-8-wens@csie.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181115093603.26729-1-wens@csie.org>
References: <20181115093603.26729-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Originally the device tree binding only specified one clock reference,
with the name "extclk". The driver simply retrieves the clock without
bothering to specify a name.

Since we added a second clock to the binding, we need to fetch the
clocks by name now. First we try the new name "txco", then fall back
to the old name "extclk", and finally try retrieving a clock without
using any name, to cover any instances where a bad device tree or
firmware worked by accident.

In the last case, we should take care that we don't get the same
clock twice when we add support for the "lpo" clock.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/bluetooth/hci_bcm.c | 41 +++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index ff73ecb8215f..1584c95c9c34 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -71,8 +71,8 @@
  * @btlp: Apple ACPI method to toggle BT_WAKE pin ("Bluetooth Low Power")
  * @btpu: Apple ACPI method to drive BT_REG_ON pin high ("Bluetooth Power Up")
  * @btpd: Apple ACPI method to drive BT_REG_ON pin low ("Bluetooth Power Down")
- * @clk: clock used by Bluetooth device
- * @clk_enabled: whether @clk is prepared and enabled
+ * @txco_clk: external reference frequency clock used by Bluetooth device
+ * @clk_enabled: whether @txco_clk is prepared and enabled
  * @init_speed: default baudrate of Bluetooth device;
  *	the host UART is initially set to this baudrate so that
  *	it can configure the Bluetooth device for @oper_speed
@@ -102,7 +102,7 @@ struct bcm_device {
 	int			gpio_int_idx;
 #endif
 
-	struct clk		*clk;
+	struct clk		*txco_clk;
 	bool			clk_enabled;
 
 	u32			init_speed;
@@ -215,7 +215,7 @@ static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 	int err;
 
 	if (powered && !dev->clk_enabled) {
-		err = clk_prepare_enable(dev->clk);
+		err = clk_prepare_enable(dev->txco_clk);
 		if (err)
 			return err;
 	}
@@ -229,7 +229,7 @@ static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 		goto err_revert_shutdown;
 
 	if (!powered && dev->clk_enabled)
-		clk_disable_unprepare(dev->clk);
+		clk_disable_unprepare(dev->txco_clk);
 
 	dev->clk_enabled = powered;
 
@@ -239,7 +239,7 @@ static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 	dev->set_shutdown(dev, !powered);
 err_clk_disable:
 	if (powered && !dev->clk_enabled)
-		clk_disable_unprepare(dev->clk);
+		clk_disable_unprepare(dev->txco_clk);
 	return err;
 }
 
@@ -896,6 +896,25 @@ static int bcm_gpio_set_shutdown(struct bcm_device *dev, bool powered)
 	return 0;
 }
 
+/* Try a bunch of names for TXCO */
+static struct clk *bcm_get_txco(struct device *dev)
+{
+	struct clk *clk;
+
+	/* New explicit name */
+	clk = devm_clk_get(dev, "txco");
+	if (!IS_ERR(clk) || PTR_ERR(clk) == -EPROBE_DEFER)
+		return clk;
+
+	/* Deprecated name */
+	clk = devm_clk_get(dev, "extclk");
+	if (!IS_ERR(clk) || PTR_ERR(clk) == -EPROBE_DEFER)
+		return clk;
+
+	/* Original code used no name at all */
+	return devm_clk_get(dev, NULL);
+}
+
 static int bcm_get_resources(struct bcm_device *dev)
 {
 	const struct dmi_system_id *dmi_id;
@@ -905,15 +924,15 @@ static int bcm_get_resources(struct bcm_device *dev)
 	if (x86_apple_machine && !bcm_apple_get_resources(dev))
 		return 0;
 
-	dev->clk = devm_clk_get(dev->dev, NULL);
+	dev->txco_clk = bcm_get_txco(dev->dev);
 
 	/* Handle deferred probing */
-	if (dev->clk == ERR_PTR(-EPROBE_DEFER))
-		return PTR_ERR(dev->clk);
+	if (dev->txco_clk == ERR_PTR(-EPROBE_DEFER))
+		return PTR_ERR(dev->txco_clk);
 
 	/* Ignore all other errors as before */
-	if (IS_ERR(dev->clk))
-		dev->clk = NULL;
+	if (IS_ERR(dev->txco_clk))
+		dev->txco_clk = NULL;
 
 	dev->device_wakeup = devm_gpiod_get_optional(dev->dev, "device-wakeup",
 						     GPIOD_OUT_LOW);
-- 
2.19.1


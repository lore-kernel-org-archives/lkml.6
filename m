Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90B2C43612
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 04:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0474217FB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 04:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731467AbeLQEFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 23:05:13 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:53254 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731373AbeLQEFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 23:05:12 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 7619C5FDA6; Mon, 17 Dec 2018 12:05:03 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Loic Poulain <loic.poulain@gmail.com>,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ondrej Jirman <megous@megous.com>
Subject: [PATCH v3 08/15] Bluetooth: hci_bcm: Add support for LPO clock
Date:   Mon, 17 Dec 2018 12:04:42 +0800
Message-Id: <20181217040449.31437-9-wens@csie.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181217040449.31437-1-wens@csie.org>
References: <20181217040449.31437-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Broadcom Bluetooth controllers support a secondary LPO clock at
32.768 kHz. This external clock provides low power timing, and also
a way to detect the frequency of the main reference clock. On many
designs without NVRAM and a non-default reference clock, this must
be used or the controller will not function correctly.

Tested-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/bluetooth/hci_bcm.c | 41 ++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 1584c95c9c34..345d728a5434 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -72,7 +72,8 @@
  * @btpu: Apple ACPI method to drive BT_REG_ON pin high ("Bluetooth Power Up")
  * @btpd: Apple ACPI method to drive BT_REG_ON pin low ("Bluetooth Power Down")
  * @txco_clk: external reference frequency clock used by Bluetooth device
- * @clk_enabled: whether @txco_clk is prepared and enabled
+ * @lpo_clk: external LPO clock used by Bluetooth device
+ * @clk_enabled: whether clocks are prepared and enabled
  * @init_speed: default baudrate of Bluetooth device;
  *	the host UART is initially set to this baudrate so that
  *	it can configure the Bluetooth device for @oper_speed
@@ -103,6 +104,7 @@ struct bcm_device {
 #endif
 
 	struct clk		*txco_clk;
+	struct clk		*lpo_clk;
 	bool			clk_enabled;
 
 	u32			init_speed;
@@ -215,21 +217,34 @@ static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 	int err;
 
 	if (powered && !dev->clk_enabled) {
-		err = clk_prepare_enable(dev->txco_clk);
+		/* LPO clock needs to be 32.768 kHz */
+		err = clk_set_rate(dev->lpo_clk, 32768);
+		if (err) {
+			dev_err(dev->dev, "Could not set LPO clock rate\n");
+			return err;
+		}
+
+		err = clk_prepare_enable(dev->lpo_clk);
 		if (err)
 			return err;
+
+		err = clk_prepare_enable(dev->txco_clk);
+		if (err)
+			goto err_lpo_clk_disable;
 	}
 
 	err = dev->set_shutdown(dev, powered);
 	if (err)
-		goto err_clk_disable;
+		goto err_txco_clk_disable;
 
 	err = dev->set_device_wakeup(dev, powered);
 	if (err)
 		goto err_revert_shutdown;
 
-	if (!powered && dev->clk_enabled)
+	if (!powered && dev->clk_enabled) {
 		clk_disable_unprepare(dev->txco_clk);
+		clk_disable_unprepare(dev->lpo_clk);
+	}
 
 	dev->clk_enabled = powered;
 
@@ -237,9 +252,12 @@ static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 
 err_revert_shutdown:
 	dev->set_shutdown(dev, !powered);
-err_clk_disable:
+err_txco_clk_disable:
 	if (powered && !dev->clk_enabled)
 		clk_disable_unprepare(dev->txco_clk);
+err_lpo_clk_disable:
+	if (powered && !dev->clk_enabled)
+		clk_disable_unprepare(dev->lpo_clk);
 	return err;
 }
 
@@ -934,6 +952,19 @@ static int bcm_get_resources(struct bcm_device *dev)
 	if (IS_ERR(dev->txco_clk))
 		dev->txco_clk = NULL;
 
+	dev->lpo_clk = devm_clk_get(dev->dev, "lpo");
+	if (dev->lpo_clk == ERR_PTR(-EPROBE_DEFER))
+		return PTR_ERR(dev->lpo_clk);
+
+	if (IS_ERR(dev->lpo_clk))
+		dev->lpo_clk = NULL;
+
+	/* Check if we accidentally fetched the lpo clock twice */
+	if (dev->lpo_clk && clk_is_match(dev->lpo_clk, dev->txco_clk)) {
+		devm_clk_put(dev->dev, dev->txco_clk);
+		dev->txco_clk = NULL;
+	}
+
 	dev->device_wakeup = devm_gpiod_get_optional(dev->dev, "device-wakeup",
 						     GPIOD_OUT_LOW);
 	if (IS_ERR(dev->device_wakeup))
-- 
2.20.0


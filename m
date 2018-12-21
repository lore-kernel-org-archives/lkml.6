Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF37FC43444
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B855221917
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390394AbeLURd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 12:33:28 -0500
Received: from mail.bootlin.com ([62.4.15.54]:36164 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730341AbeLURdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 12:33:19 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E5BE520717; Fri, 21 Dec 2018 18:33:15 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id AD89020734;
        Fri, 21 Dec 2018 18:33:05 +0100 (CET)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Marcin Wojtas <mw@semihalf.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH 1/3] pinctrl: armada-37xx: Correct mpp definitions
Date:   Fri, 21 Dec 2018 18:32:57 +0100
Message-Id: <20181221173259.8372-2-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181221173259.8372-1-gregory.clement@bootlin.com>
References: <20181221173259.8372-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Behún <marek.behun@nic.cz>

This is a cleanup and fix of the patch by Ken Ma <make@marvell.com>.

Fix the mpp definitions according to newest revision of the
specification:
  - northbridge:
    fix pmic1 gpio number to 7
    fix pmic0 gpio number to 6
  - southbridge
    split pcie1 group bit mask to BIT(5) and  BIT(9)
    fix ptp group bit mask to BIT(11) | BIT(12) | BIT(13)
    add smi group with bit mask BIT(4)

[gregory: split the pcie group in 2, as at hardware level they can be
configured separately]
Signed-off-by: Marek Behún <marek.behun@nic.cz>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 .../pinctrl/marvell,armada-37xx-pinctrl.txt    | 18 +++++++++++++-----
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c    | 10 ++++++----
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-37xx-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-37xx-pinctrl.txt
index c7c088d2dd50..f69f82741cae 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-37xx-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-37xx-pinctrl.txt
@@ -58,11 +58,11 @@ group pwm3
  - functions pwm, gpio
 
 group pmic1
- - pin 17
+ - pin 7
  - functions pmic, gpio
 
 group pmic0
- - pin 16
+ - pin 6
  - functions pmic, gpio
 
 group i2c2
@@ -112,17 +112,25 @@ group usb2_drvvbus1
  - functions drvbus, gpio
 
 group sdio_sb
- - pins 60-64
+ - pins 60-65
  - functions sdio, gpio
 
 group rgmii
- - pins 42-55
+ - pins 42-53
  - functions mii, gpio
 
 group pcie1
- - pins 39-40
+ - pins 39
+ - functions pcie, gpio
+
+group pcie1_clkreq
+ - pins 40
  - functions pcie, gpio
 
+group smi
+ - pins 54-55
+ - functions smi, gpio
+
 group ptp
  - pins 56-58
  - functions ptp, gpio
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
index aa48b3f23c7f..267dfc530985 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
@@ -170,8 +170,8 @@ static struct armada_37xx_pin_group armada_37xx_nb_groups[] = {
 	PIN_GRP_GPIO("pwm1", 12, 1, BIT(4), "pwm"),
 	PIN_GRP_GPIO("pwm2", 13, 1, BIT(5), "pwm"),
 	PIN_GRP_GPIO("pwm3", 14, 1, BIT(6), "pwm"),
-	PIN_GRP_GPIO("pmic1", 17, 1, BIT(7), "pmic"),
-	PIN_GRP_GPIO("pmic0", 16, 1, BIT(8), "pmic"),
+	PIN_GRP_GPIO("pmic1", 7, 1, BIT(7), "pmic"),
+	PIN_GRP_GPIO("pmic0", 6, 1, BIT(8), "pmic"),
 	PIN_GRP_GPIO("i2c2", 2, 2, BIT(9), "i2c"),
 	PIN_GRP_GPIO("i2c1", 0, 2, BIT(10), "i2c"),
 	PIN_GRP_GPIO("spi_cs1", 17, 1, BIT(12), "spi"),
@@ -195,8 +195,10 @@ static struct armada_37xx_pin_group armada_37xx_sb_groups[] = {
 	PIN_GRP_GPIO("usb2_drvvbus1", 1, 1, BIT(1), "drvbus"),
 	PIN_GRP_GPIO("sdio_sb", 24, 6, BIT(2), "sdio"),
 	PIN_GRP_GPIO("rgmii", 6, 12, BIT(3), "mii"),
-	PIN_GRP_GPIO("pcie1", 3, 2, BIT(4), "pcie"),
-	PIN_GRP_GPIO("ptp", 20, 3, BIT(5), "ptp"),
+	PIN_GRP_GPIO("smi", 18, 2, BIT(4), "smi"),
+	PIN_GRP_GPIO("pcie1", 3, 1, BIT(5), "pcie"),
+	PIN_GRP_GPIO("pcie1_clkreq", 4, 1, BIT(9), "pcie"),
+	PIN_GRP_GPIO("ptp", 20, 3, BIT(11) | BIT(12) | BIT(13), "ptp"),
 	PIN_GRP("ptp_clk", 21, 1, BIT(6), "ptp", "mii"),
 	PIN_GRP("ptp_trig", 22, 1, BIT(7), "ptp", "mii"),
 	PIN_GRP_GPIO_3("mii_col", 23, 1, BIT(8) | BIT(14), 0, BIT(8), BIT(14),
-- 
2.19.2


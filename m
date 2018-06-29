Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BF6C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C63727BD0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C63727BD0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934883AbeF2IUD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 04:20:03 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:17336 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933159AbeF2ITw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 04:19:52 -0400
X-IronPort-AV: E=Sophos;i="5.51,285,1526367600"; 
   d="scan'208";a="15474314"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 29 Jun 2018 01:19:51 -0700
Received: from ibiza.rfo.atmel.com (10.10.76.4) by CHN-SV-EXCH01.mchp-main.com
 (10.10.76.37) with Microsoft SMTP Server id 14.3.352.0; Fri, 29 Jun 2018
 01:19:48 -0700
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linus.walleij@linaro.org>,
        <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH v2] pinctrl: at91-pio4: add support for drive strength
Date:   Fri, 29 Jun 2018 10:15:33 +0200
Message-ID: <20180629081533.31885-1-ludovic.desroches@microchip.com>
X-Mailer: git-send-email 2.12.2
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the drive strength configuration. Usually, this value is
expressed in mA. Since the numeric value depends on VDDIOP voltage, a
value we can't retrieve at runtime, the controller uses low, medium and
high to define the drive strength.

The PIO controller accepts two values for the low drive configuration: 0
and 1. Most of the time, we don't care about the drive strength. So we
keep the default value which is 0. The drive strength is advertised
through the sysfs only when it has been explicitly set in the device
tree i.e. if its value is different from 0.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---

Changes:
- v2: use atmel,drive-strength property instead of drive-strengh one
since it is not expressend in mA and there is no way to retrieve this
value at runtime.
- v1: https://www.spinics.net/lists/linux-gpio/msg27789.html

 .../bindings/pinctrl/atmel,at91-pio4-pinctrl.txt   |  3 ++
 drivers/pinctrl/pinctrl-at91-pio4.c                | 42 ++++++++++++++++++++++
 include/dt-bindings/pinctrl/at91.h                 |  4 +++
 3 files changed, 49 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt
index 61ac75706cc9..04d16fb69eb7 100644
--- a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt
@@ -36,6 +36,8 @@ Optional properties:
 - GENERIC_PINCONFIG: generic pinconfig options to use, bias-disable,
 bias-pull-down, bias-pull-up, drive-open-drain, input-schmitt-enable,
 input-debounce, output-low, output-high.
+- atmel,drive-strength: 0 or 1 for low drive, 2 for medium drive and 3 for
+high drive. The default value is low drive.
 
 Example:
 
@@ -66,6 +68,7 @@ Example:
 			pinmux = <PIN_PB0>,
 				 <PIN_PB5>;
 			bias-pull-up;
+			atmel,drive-strength = <ATMEL_PIO_DRVSTR_ME>;
 		};
 
 		pinctrl_sdmmc1_default: sdmmc1_default {
diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
index 67e4d9ffa6b1..8f061971a7d1 100644
--- a/drivers/pinctrl/pinctrl-at91-pio4.c
+++ b/drivers/pinctrl/pinctrl-at91-pio4.c
@@ -14,6 +14,7 @@
  * GNU General Public License for more details.
  */
 
+#include <dt-bindings/pinctrl/at91.h>
 #include <linux/clk.h>
 #include <linux/gpio/driver.h>
 /* FIXME: needed for gpio_to_irq(), get rid of this */
@@ -49,6 +50,8 @@
 #define		ATMEL_PIO_IFSCEN_MASK		BIT(13)
 #define		ATMEL_PIO_OPD_MASK		BIT(14)
 #define		ATMEL_PIO_SCHMITT_MASK		BIT(15)
+#define		ATMEL_PIO_DRVSTR_MASK		GENMASK(17, 16)
+#define		ATMEL_PIO_DRVSTR_OFFSET		16
 #define		ATMEL_PIO_CFGR_EVTSEL_MASK	GENMASK(26, 24)
 #define		ATMEL_PIO_CFGR_EVTSEL_FALLING	(0 << 24)
 #define		ATMEL_PIO_CFGR_EVTSEL_RISING	(1 << 24)
@@ -75,6 +78,9 @@
 #define ATMEL_GET_PIN_FUNC(pinfunc)	((pinfunc >> 16) & 0xf)
 #define ATMEL_GET_PIN_IOSET(pinfunc)	((pinfunc >> 20) & 0xf)
 
+/* Custom pinconf parameters */
+#define ATMEL_PIN_CONFIG_DRIVE_STRENGTH	(PIN_CONFIG_END + 1)
+
 struct atmel_pioctrl_data {
 	unsigned nbanks;
 };
@@ -139,6 +145,10 @@ static const char * const atmel_functions[] = {
 	"GPIO", "A", "B", "C", "D", "E", "F", "G"
 };
 
+static const struct pinconf_generic_params atmel_custom_bindings[] = {
+	{"atmel,drive-strength", ATMEL_PIN_CONFIG_DRIVE_STRENGTH, 0},
+};
+
 /* --- GPIO --- */
 static unsigned int atmel_gpio_read(struct atmel_pioctrl *atmel_pioctrl,
 				    unsigned int bank, unsigned int reg)
@@ -692,6 +702,11 @@ static int atmel_conf_pin_config_group_get(struct pinctrl_dev *pctldev,
 			return -EINVAL;
 		arg = 1;
 		break;
+	case ATMEL_PIN_CONFIG_DRIVE_STRENGTH:
+		if (!(res & ATMEL_PIO_DRVSTR_MASK))
+			return -EINVAL;
+		arg = (res & ATMEL_PIO_DRVSTR_MASK) >> ATMEL_PIO_DRVSTR_OFFSET;
+		break;
 	default:
 		return -ENOTSUPP;
 	}
@@ -777,6 +792,18 @@ static int atmel_conf_pin_config_group_set(struct pinctrl_dev *pctldev,
 					ATMEL_PIO_SODR);
 			}
 			break;
+		case ATMEL_PIN_CONFIG_DRIVE_STRENGTH:
+			switch (arg) {
+			case ATMEL_PIO_DRVSTR_LO:
+			case ATMEL_PIO_DRVSTR_ME:
+			case ATMEL_PIO_DRVSTR_HI:
+				conf &= (~ATMEL_PIO_DRVSTR_MASK);
+				conf |= arg << ATMEL_PIO_DRVSTR_OFFSET;
+				break;
+			default:
+				dev_warn(pctldev->dev, "drive strength not updated (incorrect value)\n");
+			}
+			break;
 		default:
 			dev_warn(pctldev->dev,
 				 "unsupported configuration parameter: %u\n",
@@ -816,6 +843,19 @@ static void atmel_conf_pin_config_dbg_show(struct pinctrl_dev *pctldev,
 		seq_printf(s, "%s ", "open-drain");
 	if (conf & ATMEL_PIO_SCHMITT_MASK)
 		seq_printf(s, "%s ", "schmitt");
+	if (conf & ATMEL_PIO_DRVSTR_MASK) {
+		switch ((conf & ATMEL_PIO_DRVSTR_MASK) >> ATMEL_PIO_DRVSTR_OFFSET) {
+		case ATMEL_PIO_DRVSTR_ME:
+			seq_printf(s, "%s ", "medium-drive");
+			break;
+		case ATMEL_PIO_DRVSTR_HI:
+			seq_printf(s, "%s ", "high-drive");
+			break;
+		/* ATMEL_PIO_DRVSTR_LO and 0 which is the default value at reset */
+		default:
+			seq_printf(s, "%s ", "low-drive");
+		}
+	}
 }
 
 static const struct pinconf_ops atmel_confops = {
@@ -958,6 +998,8 @@ static int atmel_pinctrl_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	atmel_pinctrl_desc.pins = pin_desc;
 	atmel_pinctrl_desc.npins = atmel_pioctrl->npins;
+	atmel_pinctrl_desc.num_custom_params = ARRAY_SIZE(atmel_custom_bindings);
+	atmel_pinctrl_desc.custom_params = atmel_custom_bindings;
 
 	/* One pin is one group since a pin can achieve all functions. */
 	group_names = devm_kcalloc(dev,
diff --git a/include/dt-bindings/pinctrl/at91.h b/include/dt-bindings/pinctrl/at91.h
index 2732d6c0fb39..eb81867eac77 100644
--- a/include/dt-bindings/pinctrl/at91.h
+++ b/include/dt-bindings/pinctrl/at91.h
@@ -39,4 +39,8 @@
 #define AT91_PERIPH_C		3
 #define AT91_PERIPH_D		4
 
+#define ATMEL_PIO_DRVSTR_LO	1
+#define ATMEL_PIO_DRVSTR_ME	2
+#define ATMEL_PIO_DRVSTR_HI	3
+
 #endif /* __DT_BINDINGS_AT91_PINCTRL_H__ */
-- 
2.12.2


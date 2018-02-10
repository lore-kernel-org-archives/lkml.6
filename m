Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752178AbeBJJTo (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 04:19:44 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43783 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751859AbeBJJTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 04:19:39 -0500
X-Google-Smtp-Source: AH8x224RWx+vYbVby3K45khiWAgqcCF/6fv9UhqQvPB50vRjSOaNLZiefOAisN0e+7aVHgKIU1SJDg==
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Barry Song <baohua@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH v2 5/7] watchdog: mtk: allow setting timeout in devicetree
Date: Sat, 10 Feb 2018 10:19:09 +0100
Message-Id: <20180210091911.3644-5-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180210091911.3644-1-marcus.folkesson@gmail.com>
References: <20180210091911.3644-1-marcus.folkesson@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

watchdog_init_timeout() will allways pick timeout_param since it
defaults to a valid timeout.

By following best practice described in
Documentation/watchdog/watchdog-kernel-api.txt, it also
let us to set timout-sec property in devicetree.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 4 ++++
 drivers/watchdog/mtk_wdt.c                             | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
index 5b38a30e608c..859dee167b91 100644
--- a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
@@ -11,9 +11,13 @@ Required properties:
 
 - reg : Specifies base physical address and size of the registers.
 
+Optional properties:
+- timeout-sec: contains the watchdog timeout in seconds.
+
 Example:
 
 wdt: watchdog@10000000 {
 	compatible = "mediatek,mt6589-wdt";
 	reg = <0x10000000 0x18>;
+	timeout-sec = <10>;
 };
diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index 7ed417a765c7..fcdc10ec28a3 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -57,7 +57,7 @@
 #define DRV_VERSION		"1.0"
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
-static unsigned int timeout = WDT_MAX_TIMEOUT;
+static unsigned int timeout;
 
 struct mtk_wdt_dev {
 	struct watchdog_device wdt_dev;
-- 
2.15.1

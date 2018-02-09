Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752753AbeBITbW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 14:31:22 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:39913 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752583AbeBIT2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 14:28:08 -0500
X-Google-Smtp-Source: AH8x226W+z0MOJLXVEIKLF23UeJafRiYsG6jJzA68WgYTrvEInQUns4aEzrZT6caaDkICWz4oKbLxg==
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
Subject: [PATCH 3/7] watchdog: sirfsoc: allow setting timeout in devicetree
Date: Fri,  9 Feb 2018 20:27:20 +0100
Message-Id: <20180209192724.1227-4-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180209192724.1227-1-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180209192724.1227-1-marcus.folkesson@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

watchdog_init_timeout() will allways pick timeout_param since it
defaults to a valid timeout.

By following best practice described in
Documentation/watchdog/watchdog-kernel-api.txt, it also
let us to set timout-sec property in devicetree.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 Documentation/devicetree/bindings/watchdog/sirfsoc_wdt.txt | 4 ++++
 drivers/watchdog/sirfsoc_wdt.c                             | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/watchdog/sirfsoc_wdt.txt b/Documentation/devicetree/bindings/watchdog/sirfsoc_wdt.txt
index 9cbc76c89b2b..0dce5e3100b4 100644
--- a/Documentation/devicetree/bindings/watchdog/sirfsoc_wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/sirfsoc_wdt.txt
@@ -5,10 +5,14 @@ Required properties:
 - reg: Address range of tick timer/WDT register set
 - interrupts: interrupt number to the cpu
 
+Optional properties:
+- timeout-sec : Contains the watchdog timeout in seconds
+
 Example:
 
 timer@b0020000 {
 	compatible = "sirf,prima2-tick";
 	reg = <0xb0020000 0x1000>;
 	interrupts = <0>;
+	timeout-sec = <30>;
 };
diff --git a/drivers/watchdog/sirfsoc_wdt.c b/drivers/watchdog/sirfsoc_wdt.c
index 4eea351e09b0..ac0c9d2c4aee 100644
--- a/drivers/watchdog/sirfsoc_wdt.c
+++ b/drivers/watchdog/sirfsoc_wdt.c
@@ -29,7 +29,7 @@
 #define SIRFSOC_WDT_MAX_TIMEOUT		(10 * 60)	/* 10 mins */
 #define SIRFSOC_WDT_DEFAULT_TIMEOUT	30		/* 30 secs */
 
-static unsigned int timeout = SIRFSOC_WDT_DEFAULT_TIMEOUT;
+static unsigned int timeout;
 static bool nowayout = WATCHDOG_NOWAYOUT;
 
 module_param(timeout, uint, 0);
-- 
2.15.1

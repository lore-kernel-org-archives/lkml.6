Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CD9C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D31752173B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfBGQ3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:29:14 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:40233 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfBGQ3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 11:29:12 -0500
X-Originating-IP: 90.88.22.177
Received: from localhost (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id B4ED81BF217;
        Thu,  7 Feb 2019 16:29:08 +0000 (UTC)
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 1/5] dt-bindings: gpio: document the new pull-up/pull-down flags
Date:   Thu,  7 Feb 2019 17:28:55 +0100
Message-Id: <20190207162859.26252-2-thomas.petazzoni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207162859.26252-1-thomas.petazzoni@bootlin.com>
References: <20190207162859.26252-1-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit extends the flags that can be used in GPIO specifiers to
indicate if a pull-up resistor or pull-down resistor should be
enabled.

While some pinctrl DT bindings already offer the capability of
configuring pull-up/pull-down resistors at the pin level, a number of
simple GPIO controllers don't have any pinmuxing capability, and
therefore do not rely on the pinctrl DT bindings.

Such simple GPIO controllers however sometimes allow to configure
pull-up and pull-down resistors on a per-pin basis, and whether such
resistors should be enabled or not is a highly board-specific HW
characteristic.

By using two additional bits of the GPIO flag specifier, we can easily
allow the Device Tree to describe which GPIOs should have their
pull-up or pull-down resistors enabled. Even though the two options
are mutually exclusive, we still need two bits to encode at least
three states: no pull-up/pull-down, pull-up, pull-down.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 Documentation/devicetree/bindings/gpio/gpio.txt | 12 ++++++++++++
 include/dt-bindings/gpio/gpio.h                 |  6 ++++++
 2 files changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/gpio.txt b/Documentation/devicetree/bindings/gpio/gpio.txt
index f0ba154b5723..a8895d339bfe 100644
--- a/Documentation/devicetree/bindings/gpio/gpio.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio.txt
@@ -67,6 +67,18 @@ Optional standard bitfield specifiers for the last cell:
            https://en.wikipedia.org/wiki/Open_collector
 - Bit 3: 0 means the output should be maintained during sleep/low-power mode
          1 means the output state can be lost during sleep/low-power mode
+- Bit 4: 0 means no pull-up resistor should be enabled
+         1 means a pull-up resistor should be enabled
+         This setting only applies to hardware with a simple on/off
+         control for pull-up configuration. If the hardware has more
+         elaborate pull-up configuration, it should be represented
+         using a pin control binding.
+- Bit 5: 0 means no pull-down resistor should be enabled
+         1 means a pull-down resistor should be enabled
+         This setting only applies to hardware with a simple on/off
+         control for pull-down configuration. If the hardware has more
+         elaborate pull-down configuration, it should be represented
+         using a pin control binding.
 
 1.1) GPIO specifier best practices
 ----------------------------------
diff --git a/include/dt-bindings/gpio/gpio.h b/include/dt-bindings/gpio/gpio.h
index 2cc10ae4bbb7..c029467e828b 100644
--- a/include/dt-bindings/gpio/gpio.h
+++ b/include/dt-bindings/gpio/gpio.h
@@ -33,4 +33,10 @@
 #define GPIO_PERSISTENT 0
 #define GPIO_TRANSITORY 8
 
+/* Bit 4 express pull up */
+#define GPIO_PULL_UP 16
+
+/* Bit 5 express pull down */
+#define GPIO_PULL_DOWN 32
+
 #endif
-- 
2.20.1


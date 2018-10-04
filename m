Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D515AC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96DB62084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="bJZ/t93a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96DB62084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbeJECfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 22:35:41 -0400
Received: from mail1.kuutio.org ([92.222.216.83]:47758 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727545AbeJECf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 22:35:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id 204101FBEE;
        Thu,  4 Oct 2018 21:34:43 +0200 (CEST)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=dkim; t=1538681682; x=
        1541273683; bh=aui2goVtbIMuvSKHLmP97Y1M6t8ncr2/0qbHdtYYsxU=; b=b
        JZ/t93aC4E9vh9QKMsgVQcKPz2QYqMqnyfh9BbjW9tdhhVfOBAY4gzQdMLU4evh6
        K2cCdvBnmGG8Z7g/bFdOcWClaAlZRib2ykC5EzbfqeeptI2rbuHTdW2HuuoWzhe9
        LraiwI9B6rEII+0dUy2dFkQoCykq7+fwGN9AwUKVEOlS4ofAPwhvhJiU6LspfOR+
        t9MUdD9h/ENY3g8YAF0IjYWj1NVapOYUUyL4QoTWxPqYR00JZ8YawuFJtnnOBuq2
        gIwg6wpivWeHd9JbjyeD3RNhTuKAbipjAN8UQ9ECEIHFOGnemKIsL0qXqAEgfT5k
        gpG6dbOEkyQ0Lch/eBqJlJftNEHD1gnHZrINi6AYQ7QGQerd6S5KLWTSgy7OxXpp
        kdLxAmdNnZdYOW3GrUklvFyXJz2VDJTAUdgiaVQXduEvwJlKu7/pLQ29glaXIKgW
        ICwhbcLM9LmkpBFIV+VnWKp5YJm5oA16vR4bwdM4DqAurQWilfQMIFt3/PP2qL4y
        ITljYbkX/UpNCwiLKIxs5fj1h3XjGypmw2c7cZ4HUW64TrKtGCva2GZQyKEiMElu
        z5fMoDCcFinAp5GXoo0oIn5A6lODG3y4lJoz+oENkx9iddZk2bCEyqAWyrCZEPBP
        h8cw99zHh0/w9jZ23l2hmKHNOqoDITPzfPCM13UR98=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id y3vb2HUn1Ozs; Thu,  4 Oct 2018 21:34:42 +0200 (CEST)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id 989431FBA4;
        Thu,  4 Oct 2018 21:34:41 +0200 (CEST)
From:   Oskari Lemmela <oskari@lemmela.net>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lee Jones <lee.jones@linaro.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Oskari Lemmela <oskari@lemmela.net>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/4] dt-bindings: add compatibles for AXP803 AC and battery power supplies
Date:   Thu,  4 Oct 2018 22:34:07 +0300
Message-Id: <20181004193410.7265-2-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181004193410.7265-1-oskari@lemmela.net>
References: <20181004193410.7265-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AXP803 PMIC is register compatible with AXP813.

AXP803/AXP813 are capable to limit input current and supply voltage.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
---
 Documentation/devicetree/bindings/gpio/gpio-axp209.txt        | 3 ++-
 Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt      | 3 ++-
 .../devicetree/bindings/power/supply/axp20x_ac_power.txt      | 4 ++++
 .../devicetree/bindings/power/supply/axp20x_battery.txt       | 1 +
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-axp209.txt b/Documentation/devicetree/bindings/gpio/gpio-axp209.txt
index fc42b2caa06d..da3c0efb5e76 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-axp209.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-axp209.txt
@@ -11,6 +11,7 @@ This driver employs the per-pin muxing pattern.
 Required properties:
 - compatible: Should be one of:
 	- "x-powers,axp209-gpio"
+	- "x-powers,axp803-gpio"
 	- "x-powers,axp813-gpio"
 - #gpio-cells: Should be two. The first cell is the pin number and the
   second is the GPIO flags.
@@ -67,7 +68,7 @@ GPIO0	|	gpio_in, gpio_out, ldo, adc
 GPIO1	|	gpio_in, gpio_out, ldo, adc
 GPIO2	|	gpio_in, gpio_out
 
-axp813
+axp8x3
 ------
 GPIO	|	Functions
 ------------------------
diff --git a/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt b/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
index 7a6313913923..247616099171 100644
--- a/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
@@ -4,6 +4,7 @@ Required properties:
   - compatible: should be one of:
     - "x-powers,axp209-adc",
     - "x-powers,axp221-adc",
+    - "x-powers,axp803-adc",
     - "x-powers,axp813-adc",
   - #io-channel-cells: should be 1,
 
@@ -39,7 +40,7 @@ AXP22x
  2 | batt_chrg_i
  3 | batt_dischrg_i
 
-AXP813
+AXP8x3
 ------
  0 | pmic_temp
  1 | gpio0_v
diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt b/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
index 826e8a879121..97276a71e961 100644
--- a/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
+++ b/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
@@ -4,6 +4,8 @@ Required Properties:
  - compatible: One of:
 			"x-powers,axp202-ac-power-supply"
 			"x-powers,axp221-ac-power-supply"
+			"x-powers,axp803-ac-power-supply"
+			"x-powers,axp813-ac-power-supply"
 
 This node is a subnode of the axp20x PMIC.
 
@@ -13,6 +15,8 @@ reading ADC channels from the AXP20X ADC.
 The AXP22X is only able to tell if an AC power supply is present and
 usable.
 
+The AXP8X3 is able to limit current and supply voltage
+
 Example:
 
 &axp209 {
diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
index 41916f69902c..780ebd7e3b84 100644
--- a/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
@@ -4,6 +4,7 @@ Required Properties:
  - compatible, one of:
 			"x-powers,axp209-battery-power-supply"
 			"x-powers,axp221-battery-power-supply"
+			"x-powers,axp803-battery-power-supply"
 			"x-powers,axp813-battery-power-supply"
 
 This node is a subnode of its respective PMIC DT node.
-- 
2.17.1


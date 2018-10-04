Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA945C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F0821477
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gDnJUGkJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76F0821477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbeJDP7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:59:23 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43065 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbeJDP7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:59:22 -0400
Received: by mail-lj1-f195.google.com with SMTP id r8-v6so7643640ljc.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 02:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=H/Kp78sd2+saCthpS30T8q1sq16alrR47c9IyCHdoi8=;
        b=gDnJUGkJLqvoqTk4gpo6pSkKCDWvUKZwCro3F/VkeY9tuPVFV71VFIsJbXMrrfEd6p
         tPqA7i1CxKhVqECIWuA6edrlczropnT858U0BiP6IToyFij2RSaQUNff4DsSQt2CUhVc
         Sr1Kjp7CoaZhcCjop429pibFweeX3C9NCe4qA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=H/Kp78sd2+saCthpS30T8q1sq16alrR47c9IyCHdoi8=;
        b=CV/7RLIW9wALXGYBOIwH1zS9FE3xmNcDeFuDhVzckQXfeR/qJ8oEVocl/KkbRM0CEg
         lAN7Vdxb6b4l7OK0OWmFBd6jhdLwA6rhVZdYdoSdAAbu9xr1ZDHi37yIWI3BEkOePTAZ
         y5RuaPu42JBFxM8+pYwfGa1eMG/JRqyhrRbsJME3on/6tPzG5NX1n8UV/FmsLhoiOx8E
         Ryg1Iy67AHYRmG8XwGXRK9y7pNbB6MTl+TsDGXCBYSahoXEphptWZIaneljjNGHpcb9o
         9RMAKP2PurGCyhil3lAZbWJlW8WKveOhrqkSL7Gciug9INynkNC6+Hq0TP6Zuxdh/JKq
         3dxg==
X-Gm-Message-State: ABuFfojaW+G6psnBViUw9wDhU5/Nw/5Evrgltp2sf0bQo+yRsHtOQLD0
        av5Hbbx/BqjUuBAvJYaHtsJd2w==
X-Google-Smtp-Source: ACcGV62paG5o3AA1o2P/1bGa+BYBPSxy9yrNdbHgdyqsUbXliPo7ycYZcCNTuRL0+dJCx/Twp+ysTw==
X-Received: by 2002:a2e:7d10:: with SMTP id y16-v6mr3432476ljc.37.1538644022985;
        Thu, 04 Oct 2018 02:07:02 -0700 (PDT)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id n16-v6sm902218lji.28.2018.10.04.02.07.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 02:07:01 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH] regulator: fixed: Use more standard GPIO binding
Date:   Thu,  4 Oct 2018 11:06:54 +0200
Message-Id: <20181004090654.32233-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fixed regulator uses "gpio" (singularis) for the GPIO line
but the standard GPIO bindings recommend "gpios" (pluralis).

We have augmented the Linux kernel to handle both, so recommend
the best practice and deprecate the singularis variant.

Cc: devicetree@vger.kernel.org
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Suggested-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../devicetree/bindings/regulator/fixed-regulator.txt     | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/fixed-regulator.txt b/Documentation/devicetree/bindings/regulator/fixed-regulator.txt
index 0c2a6c8a1536..a0d7f15ef5ca 100644
--- a/Documentation/devicetree/bindings/regulator/fixed-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/fixed-regulator.txt
@@ -5,7 +5,7 @@ Required properties:
 - regulator-name: Defined in regulator.txt as optional, but required here.
 
 Optional properties:
-- gpio: gpio to use for enable control
+- gpios: gpio to use for enable control
 - startup-delay-us: startup time in microseconds
 - enable-active-high: Polarity of GPIO is Active high
 If this property is missing, the default assumed is Active low.
@@ -13,6 +13,10 @@ If this property is missing, the default assumed is Active low.
   If this property is missing then default assumption is false.
 -vin-supply: Input supply name.
 
+Deprecated properties:
+- gpio: singularis variant of "gpios" is allowed in accordance with the
+  GPIO bindings specification, but not recommended.
+
 Any property defined as part of the core regulator
 binding, defined in regulator.txt, can also be used.
 However a fixed voltage regulator is expected to have the
@@ -26,7 +30,7 @@ Example:
 		regulator-name = "fixed-supply";
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
-		gpio = <&gpio1 16 0>;
+		gpios = <&gpio1 16 0>;
 		startup-delay-us = <70000>;
 		enable-active-high;
 		regulator-boot-on;
-- 
2.17.1


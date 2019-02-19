Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C180C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40FF2217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u4YyDVaO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbfBSCaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 21:30:24 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46251 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfBSCaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 21:30:23 -0500
Received: by mail-pl1-f195.google.com with SMTP id o6so9620739pls.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 18:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ihbF7QRogU5+yeX0yRQ1NOfmWOfBwTY79iXAbc9U8D0=;
        b=u4YyDVaOhONV86cNazpEFuAYL61G3LkxSiwGqTSsRYNIGlA1nNGLzAsumTHrM6xyvR
         LkEKa1y4Zev57nJd5g90jUqyPWCqBMA2COrWsGyFP0kLPIx983D6QCUbqGxYNF2bDFC5
         Jx4pRSHwQ5KsKxvjh/0tzd+dbj1Ky0Z0ozbVwuA/kwbtgemoTrDFjFWk9Emzqje5YNpx
         zKdNn7gDG3JDc+QtdUTRG50hzbiIawtbOdHuXoXrOIRa7Z9HSCukSUKSYJRpZwjVQosL
         E1XHQSF/LI/ImPPz0fTwRRhaf7X82RQAQEJxc1xr9YeKctFmgnGEafkrR0XqfRqAgGTi
         1nsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ihbF7QRogU5+yeX0yRQ1NOfmWOfBwTY79iXAbc9U8D0=;
        b=AEYB9q8lz8zkNdK6WbAwXDwgjpS91T5NEXt/wMkFetr8pGT73qjmH0flpSUOs998xo
         +ap9czGwC0x+WkXI4a97h4YeRQ4H7sPET4Ot6a5ONyLgAJGM2RkbjfgB4CYD38ZvNnos
         QAdcoBZ3FsV13DADVAljvoaN1xCSrxXaR9wiXBitcQdiATfHKQ5FD2BUvVm4dQh+F9tX
         NwR7ijjDPbVlfMUu3vYqWS4XNg1VZn8pG8a+X1LjOpZG0XoOiPeZottt9by+gOWO8wjY
         Fi4BbXga8EJI41CB1HqiFTwBkjZWGCNjJlz6K4oy9jXlgG1elHN70YAPSBLuPBEz0mqi
         jo7g==
X-Gm-Message-State: AHQUAubiszUCAhtkZ+riswdP5GCzunMSf8xI+bWhB6D4LoIt7yfPKCUa
        +5WTe7FT02U21VcVq7eDfLM9WQ==
X-Google-Smtp-Source: AHgI3IYcvdRfqYe40QP9+/hE+615vF2z00tubRl12wu1K/fYpQK+i5cqb59C9JKU+4ex+x68QVIHMg==
X-Received: by 2002:a17:902:45:: with SMTP id 63mr20966959pla.281.1550543422545;
        Mon, 18 Feb 2019 18:30:22 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e19sm18552336pfn.145.2019.02.18.18.30.18
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Feb 2019 18:30:21 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     robh+dt@kernel.org, mark.rutland@arm.com, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang@linaro.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: gpio: sprd: Use SoC compatible string instead of wildcard string
Date:   Tue, 19 Feb 2019 10:29:57 +0800
Message-Id: <70f5476004b2f4e4b444bf8425f21a3c993edf47.1550543288.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use SoC compatible string instead of wildcard string.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes from v2:
 - Add reviewed tag from Rob.

Changes from v1:
 - Add 'sprd' to indicate the module in subject line.
---
 .../devicetree/bindings/gpio/gpio-eic-sprd.txt     |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt b/Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt
index 93d98d0..54040a2 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt
@@ -33,7 +33,7 @@ Required properties:
   "sprd,sc9860-eic-latch",
   "sprd,sc9860-eic-async",
   "sprd,sc9860-eic-sync",
-  "sprd,sc27xx-eic".
+  "sprd,sc2731-eic".
 - reg: Define the base and range of the I/O address space containing
   the GPIO controller registers.
 - gpio-controller: Marks the device node as a GPIO controller.
@@ -86,7 +86,7 @@ Example:
 	};
 
 	pmic_eic: gpio@300 {
-		compatible = "sprd,sc27xx-eic";
+		compatible = "sprd,sc2731-eic";
 		reg = <0x300>;
 		interrupt-parent = <&sc2731_pmic>;
 		interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
-- 
1.7.9.5


Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CE4C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6421222BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wbQEaLQG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731167AbfBMMta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:49:30 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41975 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730888AbfBMMta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 07:49:30 -0500
Received: by mail-pg1-f194.google.com with SMTP id m1so1086071pgq.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 04:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=im03o+PcjHnaLXJnGoH93tlWt7Svp1ISPnCzxSL6w80=;
        b=wbQEaLQG2ogiLSjnoErQeVexWnBXM7PRZ0c4af0QouE8y0DgbjH+XX0mk1ZEPaBX9Z
         T7ndyVkhzzNHIFU8kfD16c+jxOjmx5ztZ9bx26TlvQ3Qtw51GxYAcJS04iWKoVExi6Lf
         km97t/AQV2DCv+Q+7XjcjgnaH32RYzTbBm4iV75p9Ro1NKAf/gqw9t0fZ76IiWwL69Gi
         Sy1988Y3QS53af9wH08TelDeL21JvYXnPQ84HL9nRMTA9GV8U2gKPQ9xNoh9LKlgLOb1
         BK6mCnjDrucAPdCaZWU3CE47UICz5fGE330ztEO4sT2LdnB23fZoCUl3O8oeAplGbAvy
         NCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=im03o+PcjHnaLXJnGoH93tlWt7Svp1ISPnCzxSL6w80=;
        b=kdLUj9B9c81FCb8RWHMp52AFPi5XEdfQB4uxMRQ0A8HnivONIwqulUj9ZAV5nMUHkl
         1Wzv4QU8tmVzosC7lgMPF88k6fF/24ZPp/5abZaPo7cTYMA+1/Bh6FhUhLTjQNG/YiZp
         kESF1kgqUMugUbcKubBfENeZ1vTH4PfJ5px3Lre32bngCX3/tPEBpEhDCKnfMDFIPb0B
         cMzShJ/AGrKYwxxIlIpDIsvjm0nW9viouZ1kWC0Kjn/k57JsIn2J4TXgKrle32faAHSV
         P9mv4k6SOryRnNQAdwwaMACIwz6JMv/SlStTgGH4+aDfnq1eokXfVD2Odpx7dmWLEkSd
         gFcQ==
X-Gm-Message-State: AHQUAubMglRxXbbWHmhuEABz62yUVQRiY3xaSBDKxDnQIR2RCnGokrOY
        icSCmHAv1iFoNDcmAKezFveymw==
X-Google-Smtp-Source: AHgI3IZyzR4msd8avPt/uW6kb7einy3WW86xGOwLrZygDozD+J2p2/boVQPdgZk5UOce3CPS815o3Q==
X-Received: by 2002:a63:e051:: with SMTP id n17mr341490pgj.258.1550062169658;
        Wed, 13 Feb 2019 04:49:29 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id z62sm28530243pfi.4.2019.02.13.04.49.25
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Feb 2019 04:49:28 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     robh+dt@kernel.org, mark.rutland@arm.com, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang@linaro.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: gpio: Use SoC compatible string instead of wildcard string
Date:   Wed, 13 Feb 2019 20:48:13 +0800
Message-Id: <b8101fd6d303c1993ee294eeee8bce4d24b9547f.1550061925.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use SoC compatible string instead of wildcard string.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
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


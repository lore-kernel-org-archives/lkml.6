Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47547C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A7CC20675
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uYBY1+0V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbfBWNIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 08:08:20 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36733 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbfBWNIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 08:08:18 -0500
Received: by mail-wm1-f65.google.com with SMTP id j125so4275959wmj.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Feb 2019 05:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XjmpIkemHWcDi0hPr+0l9SdJ/Rn9t0FUVqCSEcUng6w=;
        b=uYBY1+0V597dSQpz4WniThVRvTyvwxNQmN2z2gvRJ1xnclarOUNPhKCpdyUVVB6T3w
         vZzUa8/PxdtNDZTw+KW7AmPT626XXWC7pvvCGFdhm6DnPFqwSQsehc1yl3nSBazHTST3
         HUtxs51TGrTzMIGwnw9eqgCO/6MdHlq8HNX9uZk1A3UPVe5+z5Gu4BVSdF2o2D7mj1Wt
         v2NDLHt2vTYa+4BKdxZyZcBAdRoSW95o60NgSOZ5rq0yfoZ2FxbPuJMkLp3i3okRrELt
         Imr7zabLmErsTIyF8V4BUim8q9PkPJT8rX33ykMJPWkhpUbK4yF1knxvr8W1YLyqAdCe
         SxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XjmpIkemHWcDi0hPr+0l9SdJ/Rn9t0FUVqCSEcUng6w=;
        b=AB6JN8mD0MofHgJLZjo+zVVgYTkGITwxUVFvX3an6fFdN9m1Mxa7+1AAax4KSlwsu8
         YZwF8/YzJdGodqMnI8WXHk7ninoAlYVpw3mgidNoC9Yr+0ypo+NriR2qqIQSKA5lbkKz
         EvYxNfDDtB37uzXKf6k9JYUhaw/dffhEHPN1z7LCKmJ3fzvHiMJhKAaMcGt7YoBymYys
         clsFTsSAt185z2MROgn7mhvIHLdRX7zrgve0j587vCj7CV7SP3oLT6c2uhMiL56Ezw9o
         5/N06EPWPR8O5IRlTA7BcjAx1A/I7rWCzeYGREdc3x7W+9SRFtyov8QZ/3ic9ud2LQw7
         hjLQ==
X-Gm-Message-State: AHQUAublT3tkiGAR6YZowK4OOyzYnGnGgZx10K7opBLAt4Y1PR47XSIX
        Bi7jxlLSUMqMDE5ErqafYFOChg==
X-Google-Smtp-Source: AHgI3IYTCQVGcR59VhLZAsJQZb6faAvoUNzpOW9RHEUIsFqkIZYIOm+PEelo3UNqkWE6RuGcIe8Uqw==
X-Received: by 2002:a1c:6a18:: with SMTP id f24mr439569wmc.115.1550927296130;
        Sat, 23 Feb 2019 05:08:16 -0800 (PST)
Received: from clegane.local (189.126.130.77.rev.sfr.net. [77.130.126.189])
        by smtp.gmail.com with ESMTPSA id i12sm7830746wrq.21.2019.02.23.05.08.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 05:08:15 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Anson Huang <anson.huang@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH 12/18] dt-bindings: timer: gpt: update binding doc
Date:   Sat, 23 Feb 2019 14:07:00 +0100
Message-Id: <20190223130707.16704-12-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190223130707.16704-1-daniel.lezcano@linaro.org>
References: <b5d75b05-b78c-535c-2b35-9a1f5a3a853f@linaro.org>
 <20190223130707.16704-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <anson.huang@nxp.com>

The i.MX GPT timer driver binding doc is out of date,
update it according to current GPT timer driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 .../devicetree/bindings/timer/fsl,imxgpt.txt  | 39 ++++++++++++++++---
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt b/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
index 9809b11f7180..5d8fd5b52598 100644
--- a/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
+++ b/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
@@ -2,17 +2,44 @@ Freescale i.MX General Purpose Timer (GPT)
 
 Required properties:
 
-- compatible : should be "fsl,<soc>-gpt"
-- reg : Specifies base physical address and size of the registers.
-- interrupts : A list of 4 interrupts; one per timer channel.
-- clocks : The clocks provided by the SoC to drive the timer.
+- compatible : should be one of following:
+  for i.MX1:
+  - "fsl,imx1-gpt";
+  for i.MX21:
+  - "fsl,imx21-gpt";
+  for i.MX27:
+  - "fsl,imx27-gpt", "fsl,imx21-gpt";
+  for i.MX31:
+  - "fsl,imx31-gpt";
+  for i.MX25:
+  - "fsl,imx25-gpt", "fsl,imx31-gpt";
+  for i.MX50:
+  - "fsl,imx50-gpt", "fsl,imx31-gpt";
+  for i.MX51:
+  - "fsl,imx51-gpt", "fsl,imx31-gpt";
+  for i.MX53:
+  - "fsl,imx53-gpt", "fsl,imx31-gpt";
+  for i.MX6Q:
+  - "fsl,imx6q-gpt", "fsl,imx31-gpt";
+  for i.MX6DL:
+  - "fsl,imx6dl-gpt";
+  for i.MX6SL:
+  - "fsl,imx6sl-gpt", "fsl,imx6dl-gpt";
+  for i.MX6SX:
+  - "fsl,imx6sx-gpt", "fsl,imx6dl-gpt";
+- reg : specifies base physical address and size of the registers.
+- interrupts : should be the gpt interrupt.
+- clocks : the clocks provided by the SoC to drive the timer, must contain
+           an entry for each entry in clock-names.
+- clock-names : must include "ipg" entry first, then "per" entry.
 
 Example:
 
 gpt1: timer@10003000 {
-	compatible = "fsl,imx27-gpt", "fsl,imx1-gpt";
+	compatible = "fsl,imx27-gpt", "fsl,imx21-gpt";
 	reg = <0x10003000 0x1000>;
 	interrupts = <26>;
-	clocks = <&clks 46>, <&clks 61>;
+	clocks = <&clks IMX27_CLK_GPT1_IPG_GATE>,
+		 <&clks IMX27_CLK_PER1_GATE>;
 	clock-names = "ipg", "per";
 };
-- 
2.17.1


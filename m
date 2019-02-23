Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B65C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B104A20850
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xXkMle++"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbfBWNIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 08:08:31 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44528 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbfBWNI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 08:08:28 -0500
Received: by mail-wr1-f67.google.com with SMTP id w2so5166290wrt.11
        for <linux-kernel@vger.kernel.org>; Sat, 23 Feb 2019 05:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W2dxKE8aR3SbsBUnOM8VJ3TaIyns8oX/QNEJc6UdJd4=;
        b=xXkMle++srbgR6rDFndB/M/frNLCtDQ/O8ZZlGKk53o80qYsHfjw8Cw25Lr9R4Ny/q
         X49i3aGtr1veA2cfKvdYPGkx3JyeXAceQrVpiEAWUlbUTMMvtv7CeolsWYbGlqcrjIGb
         5Yh6xOB1zk6eQPJMc4vT3PGFDMS6areYrrXTjryEMyNRR4jzQDBoGYV2fYVkkQHorL/b
         odtLcPndmMko74Q9/IS4LKWEhUATgA3kb8Fzg5e2leCSpoRjzpXtLoJCbYnMQ7RreyVd
         3zUU0EqCDAkMQA3nOj1NPsMecrPWQFm/6fxMz/1mz1EwNR1TlDZc7RhKoSYNdCHhLX9I
         EvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W2dxKE8aR3SbsBUnOM8VJ3TaIyns8oX/QNEJc6UdJd4=;
        b=ePeypxPHUaFP4g4UmI0TMXHl2kuTm2SugQc6JQaITMN9wGXpk6DqaoosgbiOBMWWYJ
         EGk9Hv7tEFfVfJ0H0q0uSUSbdZPVtG8XTq8TTmYolstXoOcz+L6X28z9XgN1BGlCMBo/
         0zKotQtXpSvX8z31AL800+DJO2WH4gU3SoyMSw4g7L3Wenl21dFXCnrloOUvbrxJc+UR
         ZYy7Afhd0m6rv1HkivJ516ZZxLtyzXMbwq6bclDKEMA12aceQPPnHQJMxWYysCndHM0w
         AM1bhzTkwyywJSR1AlmDT0bCmZRNQQIeZZOIYgqTS2nOP3IXEjXlahdhD1b3OyuL5RAT
         NAnQ==
X-Gm-Message-State: AHQUAuZ2K7ldyqLe/sVJ98v7a2fl+0KoYzWOOETFElJlTTFSAwkH9L01
        C4zOmA698S318Bbq6rqGqHbp/A==
X-Google-Smtp-Source: AHgI3IZsCdtvtPISsSQGT/JOdp6hMDEbuDGCqxhkyNQ6MmLVq6Tkwr9Jc2rUZksa2rrJz9O5MLKCQA==
X-Received: by 2002:adf:9d85:: with SMTP id p5mr6427328wre.215.1550927306073;
        Sat, 23 Feb 2019 05:08:26 -0800 (PST)
Received: from clegane.local (189.126.130.77.rev.sfr.net. [77.130.126.189])
        by smtp.gmail.com with ESMTPSA id i12sm7830746wrq.21.2019.02.23.05.08.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 05:08:25 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Joseph Lo <josephl@nvidia.com>,
        devicetree@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT)
Subject: [PATCH 16/18] dt-bindings: timer: add Tegra210 timer
Date:   Sat, 23 Feb 2019 14:07:04 +0100
Message-Id: <20190223130707.16704-16-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190223130707.16704-1-daniel.lezcano@linaro.org>
References: <b5d75b05-b78c-535c-2b35-9a1f5a3a853f@linaro.org>
 <20190223130707.16704-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joseph Lo <josephl@nvidia.com>

The Tegra210 timer provides fourteen 29-bit timer counters and one 32-bit
timestamp counter. The TMRs run at either a fixed 1 MHz clock rate derived
from the oscillator clock (TMR0-TMR9) or directly at the oscillator clock
(TMR10-TMR13). Each TMR can be programmed to generate one-shot periodic,
or watchdog interrupts.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Joseph Lo <josephl@nvidia.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 .../bindings/timer/nvidia,tegra210-timer.txt  | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt b/Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt
new file mode 100644
index 000000000000..032cda96fe0d
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt
@@ -0,0 +1,36 @@
+NVIDIA Tegra210 timer
+
+The Tegra210 timer provides fourteen 29-bit timer counters and one 32-bit
+timestamp counter. The TMRs run at either a fixed 1 MHz clock rate derived
+from the oscillator clock (TMR0-TMR9) or directly at the oscillator clock
+(TMR10-TMR13). Each TMR can be programmed to generate one-shot, periodic,
+or watchdog interrupts.
+
+Required properties:
+- compatible : "nvidia,tegra210-timer".
+- reg : Specifies base physical address and size of the registers.
+- interrupts : A list of 14 interrupts; one per each timer channels 0 through
+  13.
+- clocks : Must contain one entry, for the module clock.
+  See ../clocks/clock-bindings.txt for details.
+
+timer@60005000 {
+	compatible = "nvidia,tegra210-timer";
+	reg = <0x0 0x60005000 0x0 0x400>;
+	interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&tegra_car TEGRA210_CLK_TIMER>;
+	clock-names = "timer";
+};
-- 
2.17.1


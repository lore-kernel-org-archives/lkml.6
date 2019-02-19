Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE5BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A42EB21904
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DVr2VlEc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfBSHcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 02:32:07 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34124 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfBSHcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 02:32:04 -0500
Received: by mail-pl1-f195.google.com with SMTP id d15so2858044plr.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 23:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=KgTwt+mvKpgOELot+xmj2f5gFMFsgIKRQfOaJRZIYrA=;
        b=DVr2VlEcqP9TalSPwKET4j+4t+LjROY6ji28p3LRmQWMGQol/DOnIyax8XEx/onC6p
         Huh06/j19ri9l7fvjszirst/FehKh9KtJvyJg07adQOCl1s8L1DKEK5HlJXtFaORDuBo
         dYDi5kDTLnkvGgpbgkWe7A100TZTVgS9CT3k6Yv2bmyQDL7NWQepdHQJIiP+DewWY6Kg
         /J/X8/uzBwegFxN9QPWGNYqV7UJ0NhTPkeBmEHh5rLBw59tqTQYFC6gAOSP3lFA3Evxg
         zvm5b/w/+y29T8aQv1exlTy/T666CiVuBUoiQZOEytclfFKc4HxQazYop8bRaQDwPmez
         cKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=KgTwt+mvKpgOELot+xmj2f5gFMFsgIKRQfOaJRZIYrA=;
        b=JrftA6rZDnEC26lOD4nVUqvGUt59pi3MhRZqdZ1Y0vNzsTYjzkKlNCHGxnl0llhEl9
         5RlbQThcKxB85g3BkdmjmP+cL424VTcqf9tCuBoIYKA8Qa1TjZTgt2MkLrEtMtj2G3fx
         n8xGQpsMwRGbMRuIUsJ5jaR82nD/jtLpQmzl+AKKbCRzhB7JRrqKHzCIiXz5suS4qQZq
         03n63l0vjlqNU0z+J+H8jBzRLh0UP6AEpxNESwvEr8CrGr819Jz/R0oFqsq9mLbs1ksq
         iy75CIbE0pVw9YrUxOOn4tJZW5k3MySjcl0xAN9tCAxTTUFKzS1Agr7MTXJUNHS2aPq+
         NSUA==
X-Gm-Message-State: AHQUAubOuvn3TNy/eEYrnu5LYTKJ+3TcLG120SwgPEK0uH2BBqIGZEmH
        jTnukMkdbcTF/SlvNrT3bjn2UA==
X-Google-Smtp-Source: AHgI3IaheJpy+QogjPpSrdBCfBzWdPJciIZb2kVnqlrrnMUvSnx582ynugP0tI7Iy8iF6n00TqlkcA==
X-Received: by 2002:a17:902:8304:: with SMTP id bd4mr28506732plb.329.1550561524227;
        Mon, 18 Feb 2019 23:32:04 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id n27sm31556569pfb.8.2019.02.18.23.32.00
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Feb 2019 23:32:03 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     gregkh@linuxfoundation.org, jslaby@suse.com, robh+dt@kernel.org,
        mark.rutland@arm.com, orsonzhai@gmail.com, zhang.lyra@gmail.com
Cc:     baolin.wang@linaro.org, broonie@kernel.org, lanqing.liu@unisoc.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 4/5] dt-bindings: serial: sprd: Add dma properties to support DMA mode
Date:   Tue, 19 Feb 2019 15:31:14 +0800
Message-Id: <8f0a032f9bcce28bb0d147f9646950f64fc22a74.1550560916.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1550560916.git.baolin.wang@linaro.org>
References: <cover.1550560916.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1550560916.git.baolin.wang@linaro.org>
References: <cover.1550560916.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lanqing Liu <lanqing.liu@unisoc.com>

This patch adds dmas and dma-names properties for the UART DMA mode.

Signed-off-by: Lanqing Liu <lanqing.liu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 .../devicetree/bindings/serial/sprd-uart.txt       |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/sprd-uart.txt b/Documentation/devicetree/bindings/serial/sprd-uart.txt
index 6eb5863..9ac28f6 100644
--- a/Documentation/devicetree/bindings/serial/sprd-uart.txt
+++ b/Documentation/devicetree/bindings/serial/sprd-uart.txt
@@ -15,12 +15,18 @@ Required properties:
   UART clock and source clock are optional properties, but enable clock
   is required.
 
+Optional properties:
+- dma-names: Should contain "tx" for transmit and "rx" for receive channels.
+- dmas: A list of dma specifiers, one for each entry in dma-names.
+
 Example:
 	uart0: serial@0 {
 		compatible = "sprd,sc9860-uart",
 			     "sprd,sc9836-uart";
 		reg = <0x0 0x100>;
 		interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+		dma-names = "rx", "tx";
+		dmas = <&ap_dma 19 19>, <&ap_dma 20 20>;
 		clock-names = "enable", "uart", "source";
 		clocks = <&clk_ap_apb_gates 9>, <&clk_uart0>, <&ext_26m>;
 	};
-- 
1.7.9.5


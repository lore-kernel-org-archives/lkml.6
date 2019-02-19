Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE25C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC8A21904
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R/T95oDK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfBSHb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 02:31:58 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37231 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfBSHb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 02:31:56 -0500
Received: by mail-pl1-f195.google.com with SMTP id q3so2627330pll.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 23:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=yyLHgf/fg0UKT/vKQ5XRuE7/YcLw7WJlhicYn1jLCNw=;
        b=R/T95oDKjrZuBgj/s9/l0Ok04YZ1LfuEY+5bc/RCjr/FhhohsJVD7Wdi8/TCiKOjzp
         dLB9L19bqz43sU+M1WUOHrDm6CYgFLgQOMWW8te5c/1X+dlsnzdunOlbWsejqGotKoEj
         nbbnueQzHAGvhBLG5YCIOH6CU0R2O+lp+KjBXfMZR5pv+sTk6P1eSqe9A7oo1Bvhj0YW
         9rfgWGnnRym0pdOig+pwXpgfb8mdc7RBQzbSHwavE4vMIXT0oWf8PBdZk6OycdLG4h2P
         +Das0nfAupMhubdzLC9rB4b9QQx8BWA5QL5Xh33UOL99UdFxJyjiJ1RWzi/GVdec9kob
         Sx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=yyLHgf/fg0UKT/vKQ5XRuE7/YcLw7WJlhicYn1jLCNw=;
        b=mMGxqU4XMaSus0snkVOOkfxRGDUEKA7ZNzB6CUuF5MqaE5GIQvt3lUTk4nATXyCppz
         B/Cz8lKjEZChsRKuqa5Ski+/xiBXXP5P+P8VJRWbHNpxo8oB7a7Md8dbGCUnz07XD39G
         cxR0d1UA76u85/VtYy44Z2VURzuln1nOHf3DNF/ywCIgENNKnrK2L0DzYWCBHn/acPHY
         RZ3Vb+FgMabE6Q/c1sEE1xU8AWu5ijzOxYrvGixHsl9efgQNx0r2QSVa5EGih/4o1RpZ
         xLTO6aeMVtERVdpF/DB1C0CnnbVZNCUSJvhT7bmqVEWz5Piauj0AzydvPte5KEVYRF0o
         3Mrg==
X-Gm-Message-State: AHQUAuajBm7tDIvIaquQ2Oc59Wn0P57SNSksjmdTUYygHl3bWjrqsdhk
        Ersgham1y60zpiWVXnNABeFYBw==
X-Google-Smtp-Source: AHgI3IbVxvKZUFuwubn1vEkX+UQWGACwzbAhhuvdyEG6xIW1xJs82ZSCcJmC1B6tV0/tuzgluIsN4w==
X-Received: by 2002:a17:902:7c98:: with SMTP id y24mr11632179pll.191.1550561515473;
        Mon, 18 Feb 2019 23:31:55 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id n27sm31556569pfb.8.2019.02.18.23.31.51
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Feb 2019 23:31:54 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     gregkh@linuxfoundation.org, jslaby@suse.com, robh+dt@kernel.org,
        mark.rutland@arm.com, orsonzhai@gmail.com, zhang.lyra@gmail.com
Cc:     baolin.wang@linaro.org, broonie@kernel.org, lanqing.liu@unisoc.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 2/5] dt-bindings: serial: sprd: Add clocks and clocks-names properties
Date:   Tue, 19 Feb 2019 15:31:12 +0800
Message-Id: <c2b4db380c044bebe9fdf546b8a9f3aa351c6867.1550560916.git.baolin.wang@linaro.org>
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

This patch adds clocks and clocks-names properties, which are used to do
power management for our UART driver.

Signed-off-by: Lanqing Liu <lanqing.liu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 .../devicetree/bindings/serial/sprd-uart.txt       |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/sprd-uart.txt b/Documentation/devicetree/bindings/serial/sprd-uart.txt
index cab40f0..6eb5863 100644
--- a/Documentation/devicetree/bindings/serial/sprd-uart.txt
+++ b/Documentation/devicetree/bindings/serial/sprd-uart.txt
@@ -7,7 +7,13 @@ Required properties:
 
 - reg: offset and length of the register set for the device
 - interrupts: exactly one interrupt specifier
-- clocks: phandles to input clocks.
+- clock-names: Should contain following entries:
+  "enable" for UART module enable clock,
+  "uart" for UART clock,
+  "source" for UART source (parent) clock.
+- clocks: Should contain a clock specifier for each entry in clock-names.
+  UART clock and source clock are optional properties, but enable clock
+  is required.
 
 Example:
 	uart0: serial@0 {
@@ -15,5 +21,6 @@ Example:
 			     "sprd,sc9836-uart";
 		reg = <0x0 0x100>;
 		interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&ext_26m>;
+		clock-names = "enable", "uart", "source";
+		clocks = <&clk_ap_apb_gates 9>, <&clk_uart0>, <&ext_26m>;
 	};
-- 
1.7.9.5


Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3C7C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 03:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D854F20840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 03:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="R5+DXHo8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D854F20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731689AbeHAFXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 01:23:20 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35704 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731051AbeHAFXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 01:23:20 -0400
Received: by mail-pl0-f66.google.com with SMTP id w3-v6so8099097plq.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 20:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y2Xim6wZcJhjsafQ7hCOBFR4DJdA4YrNANwR9AoDSRg=;
        b=R5+DXHo8bfJAG+6yqGLz4bsROhYHFYVXz78bAOjEscpMxI2J91pWNCSwF7WE3HCUZo
         b2IymvEjrr9wKZiL9MnT2smndkkxaOUF1vstW2Bcd127nxnclKiqqXDbl6MTuyOXbilc
         l9lli/NM292mNTBoePfbc2S27whW1+ur9odyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y2Xim6wZcJhjsafQ7hCOBFR4DJdA4YrNANwR9AoDSRg=;
        b=OpRL/OH2K5bjvRLsgeZBCQ+irezpqegCJ7hyV218+MuZQDa7jiPKbWs7qoKv7l2Wjd
         xP5PX07IGeSTVmeF4Tt1/7FiyZvXnY5SR4rTfqQRQyzdFgPY9Y/hqHVA+8zBs8ZB3bWf
         5muU1rd4GxNKIunCbZFpRw/620/IBremqIcuULX3hDBScmt3ruU2V+RxScz3MWkYWb8e
         KmHFMzcd/YlWX4Kq2n0JE1B6NZEe2MbGFxoO6MpbvX2Q+kmkVNvgluAA67VwBEFyYmu5
         73G+dKuAP4vz2SlMs3jUOsQAnfXQsNIOvl4JXH/A1/9MmoFO5P67bMjRR24U/MalI000
         WpoQ==
X-Gm-Message-State: AOUpUlFqcSXnMbB+UVXlYuFA98DgSCTr0UoN9n6F+QsTfnlUciD/1z/E
        zrmItlWr4amUIJVM7sJDn8Ku
X-Google-Smtp-Source: AAOMgpdYuZofxzIbTJKcjFwtHVsIFvd4euDs3Cr+yhDr1ADxEN6M3QYls4nmF+fIzkcVWKozVsFxpQ==
X-Received: by 2002:a17:902:760d:: with SMTP id k13-v6mr22703733pll.56.1533094793555;
        Tue, 31 Jul 2018 20:39:53 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:730e:f0ae:ac4e:9cdd:28a2:4bf9])
        by smtp.gmail.com with ESMTPSA id d19-v6sm34879545pgi.50.2018.07.31.20.39.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 20:39:52 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        afaerber@suse.de, robh+dt@kernel.org, lee.jones@linaro.org,
        arnd@arndb.de
Cc:     linux-clk@vger.kernel.org, liuwei@actions-semi.com,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com,
        thomas.liau@actions-semi.com, jeff.chen@actions-semi.com,
        pn@denx.de, edgar.righi@lsitec.org.br, sravanhome@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 01/10] dt-bindings: clock: Add syscon support to Actions Semi Owl SoCs
Date:   Wed,  1 Aug 2018 09:09:06 +0530
Message-Id: <20180801033915.15880-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180801033915.15880-1-manivannan.sadhasivam@linaro.org>
References: <20180801033915.15880-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the clock and reset management units are sharing the same memory
map, document the clock bindings to support System Controller.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../bindings/clock/actions,owl-cmu.txt        | 21 +++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/actions,owl-cmu.txt b/Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
index d1e60d297387..649c95fc4582 100644
--- a/Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
+++ b/Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
@@ -9,8 +9,6 @@ Required Properties:
 - compatible: should be one of the following,
 	"actions,s900-cmu"
 	"actions,s700-cmu"
-- reg: physical base address of the controller and length of memory mapped
-  region.
 - clocks: Reference to the parent clocks ("hosc", "losc")
 - #clock-cells: should be 1.
 
@@ -21,6 +19,13 @@ All available clocks are defined as preprocessor macros in corresponding
 dt-bindings/clock/actions,s900-cmu.h or actions,s700-cmu.h header and can be
 used in device tree sources.
 
+The CMU registers are part of the system-controller block on Owl SoCs.
+
+Parent node should have the following properties :
+- compatible: "syscon", "simple-mfd"
+- reg: physical base address of the controller and length of memory mapped
+  region.
+
 External clocks:
 
 The hosc clock used as input for the plls is generated outside the SoC. It is
@@ -31,11 +36,15 @@ Actions Semi S900 CMU also requires one more clock:
 
 Example: Clock Management Unit node:
 
-        cmu: clock-controller@e0160000 {
-                compatible = "actions,s900-cmu";
+        sysctrl: system-controller@e0160000 {
+                compatible = "syscon", "simple-mfd";
                 reg = <0x0 0xe0160000 0x0 0x1000>;
-                clocks = <&hosc>, <&losc>;
-                #clock-cells = <1>;
+
+                cmu: clock-controller {
+                        compatible = "actions,s900-cmu";
+                        clocks = <&hosc>, <&losc>;
+                        #clock-cells = <1>;
+                };
         };
 
 Example: UART controller node that consumes clock generated by the clock
-- 
2.17.1


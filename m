Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84822ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 20:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D82120882
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 20:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDAHIoZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D82120882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbeGOU7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 16:59:45 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54752 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbeGOU7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 16:59:44 -0400
Received: by mail-wm0-f67.google.com with SMTP id c14-v6so2847586wmb.4;
        Sun, 15 Jul 2018 13:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YRj6yLCAtwa4d5ow6tddlLv3TA5jF/PNAMI5Oag6lBI=;
        b=HDAHIoZKxecphGncVKxJ+5UCrLL/ArU3Cyn/TWI3rg6O++fEWjZGkrZAmX8ODai68I
         qAvg2xiFbJd4Ou1d5HlR+wXclnOOeBWMMzTo7XMszV8fUMotMNt454KP4UsPt6YsnM0d
         G+d+vyBoTNhk4p3WlSPHRYVd0ButHGvd8aONTFLUwvqcT70rO9B/KMkgvTFqVrubDIHk
         p4U5x4Skrb0eocpi5LHQvraHZoNusoIfy5p5yJaD+3B+SfXC5HQRmeGMFC3WQIvIEB/A
         26mGRQhYILKP5suBgsjs4IjTkxfdcUKQUWyyvy8/bhWPZFe4zaJlMHWOadLqZD8TTo4/
         SZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YRj6yLCAtwa4d5ow6tddlLv3TA5jF/PNAMI5Oag6lBI=;
        b=t3mFlbZ/AlKcQcGOmce8RF+XI1PxEBEri7ueX38ee42x/awD1JuXbKzmkbQ4d0qCAB
         j8ajXxw/0VkfKdHyiP4EsDgkzy2fuD/6U1G6W7EqwqhjwkXgg8nD9wjo34/8y7R8D8us
         MIuzD22E7g86KjZEFZVf5QMTopLMXl5osFyKUcyc1b9hLDOzVB2E00dWuR7178FRqwnb
         ySOlCu0H1sBPQbGLZItHEEeBX5WzOHDRJYQqwTJOgYwfelpfo4GqR+DUsZbxIfwGtjOF
         dGxpIFLJmKr36X3u592V6kFmioZJaCK1kRCfQJ+SJpdLwIZDvyZ8kcyayfg5qFkvqwCh
         LYew==
X-Gm-Message-State: AOUpUlHI20W9eEmWTKOOsQTpklbuBiK6W1Rw5Q+8AjpnG5M9gTUkx1zB
        lerGFvxVzPF7JRBVp9bDKkc=
X-Google-Smtp-Source: AAOMgpfyoXrdNeW72hzA2lK+DPAodoxH2Xn2+mLwf22y222cGgbx/QkUL+cRN1/YtpAWdElefhkAOg==
X-Received: by 2002:a1c:98a:: with SMTP id 132-v6mr8438649wmj.86.1531686935273;
        Sun, 15 Jul 2018 13:35:35 -0700 (PDT)
Received: from parthiban.fritz.box ([62.91.12.240])
        by smtp.gmail.com with ESMTPSA id u25-v6sm11768387wrd.61.2018.07.15.13.35.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jul 2018 13:35:34 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     afaerber@suse.de, manivannan.sadhasivam@linaro.org,
        sboyd@kernel.org
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux@cubietech.com, sravanhome@gmail.com, support@cubietech.com,
        catalin.marinas@arm.com, mturquette@baylibre.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        thomas.liau@actions-semi.com, darren@cubietech.com,
        robh+dt@kernel.org, jeff.chen@actions-semi.com, pn@denx.de,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mp-cs@actions-semi.com
Subject: [PATCH v6 4/5] arm64: dts: actions: Add Clock Management Unit for S700
Date:   Sun, 15 Jul 2018 22:35:23 +0200
Message-Id: <20180715203524.11948-5-sravanhome@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180715203524.11948-1-sravanhome@gmail.com>
References: <20180715203524.11948-1-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Clock Management Unit for Actions Semi S700 SoC.

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 arch/arm64/boot/dts/actions/s700.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
index 66dd5309f0a2..4497741d48b2 100644
--- a/arch/arm64/boot/dts/actions/s700.dtsi
+++ b/arch/arm64/boot/dts/actions/s700.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/actions,s700-cmu.h>
 
 / {
 	compatible = "actions,s700";
@@ -44,6 +45,13 @@
 		};
 	};
 
+	cmu: clock-controller@e0168000 {
+		compatible = "actions,s700-cmu";
+		reg = <0x0 0xe0168000 0x0 0x1000>;
+		clocks = <&hosc>, <&losc>;
+		#clock-cells = <1>;
+	};
+
 	reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -87,6 +95,12 @@
 		#clock-cells = <0>;
 	};
 
+	losc: losc {
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
+		#clock-cells = <0>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
-- 
2.18.0


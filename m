Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0DCC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D96213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AAs4YApw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4D96213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbeKUOL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 09:11:59 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34119 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbeKUOL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 09:11:59 -0500
Received: by mail-pl1-f195.google.com with SMTP id f12-v6so3397675plo.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 19:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2J9GuMrRuN9jrVYEvL+pORK4zBer4omKoAIBCCYCOE4=;
        b=AAs4YApwX9+ZPH6P3/s9x5/DBqtabP3DyOtp+gU7sGHSnXH533BPNSeExFPqGcMD4m
         GpQT5mLpQF9zFwrPJElBmJ1rT/IpoxHqaklAWPWt6wNR2UIy5CIA1ZhHy7EV1NwiO6Yj
         F/erEqEhuU5gvob2HkPwxAjKRszvNn6U0LgV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2J9GuMrRuN9jrVYEvL+pORK4zBer4omKoAIBCCYCOE4=;
        b=BnzqSVGWEwu0A6GlXAIf99nhsHEFLRaUFn1fC79+WZ2UE40wwHPr/IN0TbUmbLYvGv
         7fvGwuE+JNE4eNCedkBi4be+Jkl3hkvsJ0Vh5erN7wzzTtYFHAUEzG1Zz3xbzJVctMWi
         +CjxXcqxQNAiHwW3cOemmENq5vV+Xwk3btAp02fs4w4PPQA9DaA5GBBYvcm0aU/f6o4z
         Y2UyPa6+T000B7q2QxbybcEOYZTpcYv8nRgX/JZSaZdG2AvIcHZmJ4hMREg7fmLCSZMf
         MJ5FEZe1lN9Aql0Bhcolz8huAEGdN/qWdV/hgk8Zd+Rw9I88RkgIR2WK9PS5mfgABYDT
         I1RQ==
X-Gm-Message-State: AGRZ1gIfbBxK0dxBUKv2V2hnHarCG3KAMm3zmgJr6UuVAGTElSiotqbc
        PcA4Y96oyB9JNiU0eCJAvP0D
X-Google-Smtp-Source: AJdET5eLgH2kBTZkR+AudUMygO6LUFNXonO8fQ8wsyKQsTSdXolC/QRN/fK8TPFKxqULRsMsyan7jQ==
X-Received: by 2002:a62:db41:: with SMTP id f62mr5125126pfg.123.1542771564579;
        Tue, 20 Nov 2018 19:39:24 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:98b:9501:106a:f751:df0d:9e68])
        by smtp.gmail.com with ESMTPSA id z8sm72025095pgz.53.2018.11.20.19.39.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 19:39:24 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        daniel.lezcano@linaro.org, gregkh@linuxfoundation.org,
        jslaby@suse.com
Cc:     afaerber@suse.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, zhao_steven@263.net,
        overseas.sales@unisoc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 13/15] arm: dts: rda8810pl: Add interrupt support for UART
Date:   Wed, 21 Nov 2018 09:06:50 +0530
Message-Id: <20181121033652.12247-14-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181121033652.12247-1-manivannan.sadhasivam@linaro.org>
References: <20181121033652.12247-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interrupt support for UART in RDA Micro RDA8810PL SoC.

Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/rda8810pl.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/rda8810pl.dtsi b/arch/arm/boot/dts/rda8810pl.dtsi
index 17ae93410769..d5df53ba9109 100644
--- a/arch/arm/boot/dts/rda8810pl.dtsi
+++ b/arch/arm/boot/dts/rda8810pl.dtsi
@@ -71,18 +71,21 @@
 		uart0: serial@0 {
 			compatible = "rda,8810pl-uart";
 			reg = <0x0 0x1000>;
+			interrupts = <9 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
 
 		uart1: serial@10000 {
 			compatible = "rda,8810pl-uart";
 			reg = <0x10000 0x1000>;
+			interrupts = <10 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
 
 		uart2: serial@90000 {
 			compatible = "rda,8810pl-uart";
 			reg = <0x90000 0x1000>;
+			interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
 	};
-- 
2.17.1


Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA66C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161E82146D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IUGJhNSu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 161E82146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbeKUOL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 09:11:29 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40810 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbeKUOL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 09:11:29 -0500
Received: by mail-pl1-f196.google.com with SMTP id b22-v6so3377355pls.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 19:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6hBNoi0h5IHP2+NkcplzBdBChhhJL4ZE2oiXpP9Xdkw=;
        b=IUGJhNSuauZoFeQJpwHR04CtAQulPFEhFdnBxIhGa0eb8uHAJ5XarOoZKdeBq1zToi
         QpjxrKpTH4oflYagh+IJLLb71Jse41LgF0C9zmokErj+ZQ69FHEVjknoW5GO3kVuI6xm
         MajlShsrXKUx0opkt0XVoP2XKWwEbNi2k/va8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6hBNoi0h5IHP2+NkcplzBdBChhhJL4ZE2oiXpP9Xdkw=;
        b=Os87JqJEn+Pk3NhpBJYVNlWhjINlyC5vqJqKL5M6LD6TyaQ1H9sZNo7lplvCjGpwdR
         HzxjRSuBKb0VbyWy0SuqsQkLqvbM0Tor0UxtbVomc6Vy0VYPJ34/vrGFIHXnLQvUNr+z
         f/zNsCI9C9N0PFlk/6of90XMWS+gFlfI4InxlWGFgyJ2IBfKnY0M5HAKZpPLALzgwx5o
         +dibU7FzWrkKq76do1SQXcYrsD+DioXAw+8t3X4VzH7+P5CxMvNBpRp3TubnfrkjLRHm
         cqgNyezt58ZBUMIjx4xURqGd/bFPPk7XaOQT4X40xBb37G8wOx3Muktl+tfVh5c084sV
         sq8Q==
X-Gm-Message-State: AA+aEWafsondtipOjoeCwxk3ZGEEoW2JPhRY6HCVbK9gIK/uOYVoVgsN
        aLF8pOuXdYWBvlEX3ZDXHPRw
X-Google-Smtp-Source: AFSGD/WuFP8L9nTIC7oejdJh6/JA448uc75dtWeAwUes97lvMOiKt1vMeEBlMDGsDpTvApSv/TNd3A==
X-Received: by 2002:a63:26c1:: with SMTP id m184mr4156370pgm.367.1542771534603;
        Tue, 20 Nov 2018 19:38:54 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:98b:9501:106a:f751:df0d:9e68])
        by smtp.gmail.com with ESMTPSA id z8sm72025095pgz.53.2018.11.20.19.38.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 19:38:54 -0800 (PST)
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
Subject: [PATCH v2 10/15] arm: dts: rda8810pl: Add timer support
Date:   Wed, 21 Nov 2018 09:06:47 +0530
Message-Id: <20181121033652.12247-11-manivannan.sadhasivam@linaro.org>
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

Add timer support for RDA Micro RDA8810PL SoC.

Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/rda8810pl.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/rda8810pl.dtsi b/arch/arm/boot/dts/rda8810pl.dtsi
index ab85ee06d84f..17ae93410769 100644
--- a/arch/arm/boot/dts/rda8810pl.dtsi
+++ b/arch/arm/boot/dts/rda8810pl.dtsi
@@ -6,6 +6,8 @@
  * Copyright (c) 2018 Manivannan Sadhasivam
  */
 
+#include <dt-bindings/interrupt-controller/irq.h>
+
 / {
 	compatible = "rda,8810pl";
 	interrupt-parent = <&intc>;
@@ -50,6 +52,14 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x0 0x20900000 0x100000>;
+	
+		timer@10000 {
+			compatible = "rda,8810pl-timer";
+			reg = <0x10000 0x1000>;
+			interrupts = <16 IRQ_TYPE_LEVEL_HIGH>,
+				     <17 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hwtimer", "ostimer";
+		};
 	};
 
 	apb@20a00000 {
-- 
2.17.1


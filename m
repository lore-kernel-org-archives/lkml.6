Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CE9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED6C206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FLGisDnb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED6C206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407207AbeKTDgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:36:14 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36408 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406379AbeKTDgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:36:13 -0500
Received: by mail-pf1-f193.google.com with SMTP id b85so8324630pfc.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 09:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bGZyJjOaTxTFzcNQ/EVwhaHRgLJ1bzedaBRxPCPwLjo=;
        b=FLGisDnbl+TVkfwvcgO+pgufMr42SkK10LtW1XejdpN09vbT9L2xCOSBjZN1sOGJS3
         MujKlI1XuDRvd7uqhPQelsSXGG0lDhsEaMYOME/zIWO70/wDmXUjZ9TvNmHg5c7TwZub
         AhFS4vpiwpJWz98pDZiY8jiy2CpcVVI8Lqbf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bGZyJjOaTxTFzcNQ/EVwhaHRgLJ1bzedaBRxPCPwLjo=;
        b=TFfXuYwnWxn7+pXtckRfBvi5HLt647rbrCVPWTL+7d4cjYxwnA6sfeSzUGV4fHlPaX
         n1eO1lPA4InaVbDAWUp8E5LDL0hJpgCrn8F15d3hHngAfaLU2XpFIea2RKw/XGE+SfTJ
         uWxdxyPEb/xL0r3B3xDPyqXZAoV5yN4RBMkCCRrrJ3bCM+p8vv60/jOaJkN0JkMiu95z
         cH7xDYi2hMA80wHTUjkaYOPmJevWaDTiPR/0G9vJg7oeL56pfeU2eiUyqcbwILI7X9hN
         y4QnHjUhBVFA8iyBra2WJxWbttzeFzSCP6gioPd8GO1e+daJ2cqfwrHddx6dn79UA0QB
         es3g==
X-Gm-Message-State: AGRZ1gLY5wwD8YcDz6ydlSB+k8abiZGP0u6kDWBxDpz3eK9vy+K7vRTi
        FQxHwKZWud4T/WuUimbuyO5c
X-Google-Smtp-Source: AJdET5dARD/sRl7GTdHEV0hOh7lNaCTQP6bJE9XztpMrOFD66xCndUIM9BK04OzIjMNNaUfGYIUJPw==
X-Received: by 2002:a63:eb52:: with SMTP id b18mr20316120pgk.213.1542647513201;
        Mon, 19 Nov 2018 09:11:53 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:631b:44eb:3905:6402:e2fb:2d7])
        by smtp.gmail.com with ESMTPSA id 186-v6sm46175458pfe.39.2018.11.19.09.11.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 09:11:52 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        daniel.lezcano@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, zhao_steven@263.net,
        service@rdamicro.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH 08/16] arm: dts: rda8810pl: Add interrupt controller support
Date:   Mon, 19 Nov 2018 22:39:31 +0530
Message-Id: <20181119170939.19153-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org>
References: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interrupt controller support for RDA Micro RDA8810PL SoC.

Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/rda8810pl.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/rda8810pl.dtsi b/arch/arm/boot/dts/rda8810pl.dtsi
index 7f1ff2021eff..093d6980bfbd 100644
--- a/arch/arm/boot/dts/rda8810pl.dtsi
+++ b/arch/arm/boot/dts/rda8810pl.dtsi
@@ -9,6 +9,7 @@
 
 / {
 	compatible = "rda,8810pl";
+	interrupt-parent = <&intc>;
 	#address-cells = <1>;
 	#size-cells = <1>;
 
@@ -49,6 +50,13 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x20800000 0x100000>;
+
+			intc: interrupt-controller {
+				compatible = "rda,8810pl-intc";
+				reg = <0x0 0x1000>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
 		};
 
 		apb@20900000 {
-- 
2.17.1


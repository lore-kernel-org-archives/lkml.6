Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C923ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 20:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518B720882
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 20:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsSlD+Z9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 518B720882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbeGOU7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 16:59:46 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40167 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbeGOU7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 16:59:45 -0400
Received: by mail-wm0-f66.google.com with SMTP id z13-v6so13798939wma.5;
        Sun, 15 Jul 2018 13:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y56U9Qy5luv40h9ja9fLysGeD/BwAI8wDVI6U0Xt3oU=;
        b=TsSlD+Z9xLHhSaBrsHbc1FaRqkn0KH2zkI3CoupQOEYU5IPq/zaCVW0Bcicd/7e774
         NQ3q6wDuAwZn2zqV6J8vMmmBej+OKuVCbxVXJmKhRAU3pSoIiOTqxDOduy3r6NjtlgTB
         atceVZDHE9UszSbAY2pmFWSMc1IMumo77gg2C7UTjJfPsSdsc9EUK/3CPcVnUIZMn6Xj
         ste+dfTbTf383V7s8IpsmV7qGnyHtiSfChplrQFYxZLLHez/RVS2CuMoPTH0AkqjsHMp
         4TDLDX/EYfQ8innn/XbVZev1OTX57an0R0F0ZsAenHfwVJJj61P1qFndejsiCIrM2cH5
         s3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y56U9Qy5luv40h9ja9fLysGeD/BwAI8wDVI6U0Xt3oU=;
        b=LZIB5IlyDtIXyUR0rNfg0+M8kvnqAoey/IXFflLJR5BcYMs5hO2DO/WH/3U5HDprFe
         f/DaRgkk6idkG4cz0XkxhyQTdBQ9KC4Zl+l0wVyb4Uo01fwiW5ysuhLXZuNEWHbuvN3e
         LbfT3zN89Kcfp3zF6x3FIjnVehSf2Fi9pELn1XeJNYktE0l1V96Y+d1klEEYOj4UNJ9B
         JYPB8FZ18asm28qnriWZgQ8tSiOkiUCVjno8ZwcHUppgIOeAdfq1fZquHKY3mvI5KPs6
         okl8PBkclaoLtdB1izP2UEk6UmEWJxBvT29l4LXQ30VHiOTWnrqTpkaD+6oANAV0YDqU
         +tMA==
X-Gm-Message-State: AOUpUlHjLVfArM85YBnkBFCszZwIaAGTnr3BdkWJRTV40Ha4EcwWeJyl
        WOyjodDMvP5qPJbFAdJRSL4=
X-Google-Smtp-Source: AAOMgpcwJqNcr4IOCR1bWE95nIOPUHuCeLVNMuDHndGsaaBm58wF1lcYp4jawz/eFd4cW3jXVX3L6Q==
X-Received: by 2002:a1c:815:: with SMTP id 21-v6mr7891310wmi.151.1531686937052;
        Sun, 15 Jul 2018 13:35:37 -0700 (PDT)
Received: from parthiban.fritz.box ([62.91.12.240])
        by smtp.gmail.com with ESMTPSA id u25-v6sm11768387wrd.61.2018.07.15.13.35.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jul 2018 13:35:36 -0700 (PDT)
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
Subject: [PATCH v6 5/5] arm64: dts: actions: Set UART clock reference from CMU
Date:   Sun, 15 Jul 2018 22:35:24 +0200
Message-Id: <20180715203524.11948-6-sravanhome@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180715203524.11948-1-sravanhome@gmail.com>
References: <20180715203524.11948-1-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 arch/arm64/boot/dts/actions/s700-cubieboard7.dts | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
index ef79d7905f44..c08808ca3346 100644
--- a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
+++ b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
@@ -28,12 +28,6 @@
 		device_type = "memory";
 		reg = <0x1 0xe0000000 0x0 0x0>;
 	};
-
-	uart3_clk: uart3-clk {
-		compatible = "fixed-clock";
-		clock-frequency = <921600>;
-		#clock-cells = <0>;
-	};
 };
 
 &timer {
@@ -42,5 +36,5 @@
 
 &uart3 {
 	status = "okay";
-	clocks = <&uart3_clk>;
+	clocks = <&cmu CLK_UART3>;
 };
-- 
2.18.0


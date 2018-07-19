Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5331DC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09EA1206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FP8BuBsW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09EA1206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731283AbeGSJtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:49:33 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52338 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730687AbeGSJta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:49:30 -0400
Received: by mail-wm0-f65.google.com with SMTP id o11-v6so5394181wmh.2;
        Thu, 19 Jul 2018 02:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e0gYsJDnoD1gULaaLGDJXSJgfMYbHTTnwiaEtLTcNBU=;
        b=FP8BuBsW8pIRJQj1fMNkRqAlq5Imn+GlD3B1Sz2OLGvmYK6Wty1bhwXwATKGpn39Op
         NBBuf2G5ymGNadebiExHNhm6j6Yb5mpCDy0zvNNGBh0cu/4FGCa1Q6zkxZ0qxhrA0q1O
         fo8Q2xIC9j2uH49GrMjNMQrF8zwLVZZur9OM3G6v6vCwVpIow4eLk0m6n+jeuxqmkP0H
         jHfKeV/RueXnsHRjMMDDgQotfkMuFSmuoBVeLRlkYPNIfg2uPvm5ZE8VQmDkoSl0x42d
         StIXmOcwrlZu8q3PjhCWvB2sn0ETvMwI9xC+Q/Jqv7epDn6L3+qf7uZve8Y9YzRUZ7Sz
         jiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e0gYsJDnoD1gULaaLGDJXSJgfMYbHTTnwiaEtLTcNBU=;
        b=STK+shzyiQ5+z1o//66ZNyu7bwN6lDRXRI+9RQrK0Cxqr8ApLDE8P6JET6RiybgIln
         2FFd1IoYPRhBIyCLWDPDMaXHA9XhAc05FiN2Oru8dLdITSZXrnM63sXm7aVpmWhkqczE
         vO+8cR2LiMzORjT+8ZKkGcW9lecnDd7nYrfV+DwpdpfibmDPPtPd3DCx91jRqxi8up7k
         ia2z8ESRPglfJEPI59z8hAVePmFxgfdh5hNe4F+Mtt7B9BgAyO2SfQ/xrILYfEvHa17P
         fmSBx7itkjZ8nB2mCGH1FhwtPfk0XT9l30N7YDD+mLs62jeXwmtB8BwREJRqTutnidSK
         6NBg==
X-Gm-Message-State: AOUpUlEHF+ai8CH3THW+j2PNbu/3sy99+N8529Locohd8oC2XyeqbHPL
        WUYMLEMHeXkgnnlec7DUmz8=
X-Google-Smtp-Source: AAOMgpcaxM5lcm1oOaJjm+BF/jBRx0YQXRor6Rwbga2TvLisL9e7EWxAjFZTcGQNA+k8/emEi9kmKw==
X-Received: by 2002:a1c:9e89:: with SMTP id h131-v6mr3504211wme.13.1531991237757;
        Thu, 19 Jul 2018 02:07:17 -0700 (PDT)
Received: from xpert.denx.de ([62.91.23.180])
        by smtp.gmail.com with ESMTPSA id j11-v6sm8162160wrr.37.2018.07.19.02.07.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 02:07:17 -0700 (PDT)
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
Subject: [PATCH v7 5/5] arm64: dts: actions: Set UART clock reference from CMU
Date:   Thu, 19 Jul 2018 11:06:49 +0200
Message-Id: <20180719090649.12460-6-sravanhome@gmail.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180719090649.12460-1-sravanhome@gmail.com>
References: <20180719090649.12460-1-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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
2.14.4


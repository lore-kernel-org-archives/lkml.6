Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228CAC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97D420870
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoPyvnue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B97D420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732501AbeGaVaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:30:22 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50714 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732423AbeGaVaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:30:21 -0400
Received: by mail-wm0-f68.google.com with SMTP id s12-v6so4386497wmc.0;
        Tue, 31 Jul 2018 12:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5q8ZsxnkIcjG24bayD/hd6obgovpIitTr4J4IfbOI7U=;
        b=JoPyvnueFoCBkcvqrx0Gq2aX5TUSowKODGFE9qRs3B9dH1x8C1U64+cQzSzbskkJBL
         5tUDzLr2l5CkpzJP5Qt7mkn4QFeUOlC7n22bHNfYsbLXdFazSvot595+U6AiGloFxCa7
         NKTRFTMd3S5PBBdZA2XVnGe2SblvdnTS0AWgKikw4l09zre6mkqfjTZmRM+LY1p7M6YZ
         1yY7UY4s84yLLY2l+0P9QKRqfjC/q6XzHRGXwsCNIbXO9v+9rX35fv/WR3q1Gh7v1QMJ
         qhTNW2rX1KqFhAxMiheiE8ttRJhqvhl9rte7m4x5nYMi3grRKQGnyBOa/1TVpTaA9oOj
         o0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5q8ZsxnkIcjG24bayD/hd6obgovpIitTr4J4IfbOI7U=;
        b=lhmJ6/4HaPDysWWxAFfdrH/aNDzUdP8R9KdqY+py6xY6t/9ZsymRvP5FMab+5B1uOY
         wiDN0JCi6uKuzLuY0zK3gQ2ICQN3FVjZPxEM6vYYHjR76+12UQTUYfmiVQTJ4xi1YOxv
         0+Kz124lXPtirnTabr6fPdFOomYyjW1R+lKKPn2q70ANfm+6jHF/0EzkG5Iefsgc94J6
         giwF+erett+nqe+qRPlZmga9XsWdaN6kNKLHFU5giFkEHGy6osTQwohbHrykgxqHEDxk
         qeTVfbQEE9S5iL0pWaO/9/GaL3v5bGUh2m+BtfylRqlQWWbkU8yQx1lwvd5yfNkNmG9m
         QoJA==
X-Gm-Message-State: AOUpUlERKhj0XfbZ4A3bk6RMOrFt5ilwrAUXRClc5/YtoV5EZJNXIJu0
        1z3rYAR1tlP9z3B71YFX7Po=
X-Google-Smtp-Source: AAOMgpc1xxmswcopeHumTS4jcG72tH3kQ9r88jRV60ULbO5EHjujVYgdLiY9wzNwfVoW2/Ua62dZZA==
X-Received: by 2002:a1c:5f82:: with SMTP id t124-v6mr718887wmb.14.1533066508844;
        Tue, 31 Jul 2018 12:48:28 -0700 (PDT)
Received: from localhost.localdomain (p5B3F73FD.dip0.t-ipconnect.de. [91.63.115.253])
        by smtp.gmail.com with ESMTPSA id z1-v6sm2444829wmf.5.2018.07.31.12.48.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 12:48:27 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     manivannan.sadhasivam@linaro.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, afaerber@suse.de,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        pn@denx.de, mp-cs@actions-semi.com, jeff.chen@actions-semi.com,
        thomas.liau@actions-semi.com, linux@cubietech.com,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v4 5/5] arm64: dts: actions: Add pinctrl node for Actions Semi S700
Date:   Tue, 31 Jul 2018 21:47:43 +0200
Message-Id: <20180731194743.13678-6-sravanhome@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731194743.13678-1-sravanhome@gmail.com>
References: <0180729200038.11795-1-sravanhome@gmail.com>
 <20180731194743.13678-1-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl nodes for Actions Semi S700 SoC

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 arch/arm64/boot/dts/actions/s700.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
index 59d29e4ca404..9a2c617703e5 100644
--- a/arch/arm64/boot/dts/actions/s700.dtsi
+++ b/arch/arm64/boot/dts/actions/s700.dtsi
@@ -179,5 +179,21 @@
 			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "timer1";
 		};
+
+		pinctrl: pinctrl@e01b0000 {
+			compatible = "actions,s700-pinctrl";
+			reg = <0x0 0xe01b0000 0x0 0x1000>;
+			clocks = <&cmu CLK_GPIO>;
+			gpio-controller;
+			gpio-ranges = <&pinctrl 0 0 136>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
 };
-- 
2.18.0


Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8A8C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 16:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B674E2086B
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 16:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfftdrzL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B674E2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbeKZDLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 22:11:13 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37850 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbeKZDLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 22:11:13 -0500
Received: by mail-pf1-f195.google.com with SMTP id u3-v6so5376242pfm.4;
        Sun, 25 Nov 2018 08:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=D2ubccsUc+lruYN/6q8Va1yZPf6jxpt0taqqepYfPvk=;
        b=KfftdrzLWD4q9F2i7Hk2IX05icitsDSW6T3mBQwFXi4jcwWe2Cc3e4n4iNjSuY6W2b
         l2JXe9at78XnNL1ZaU3no2z3VGFd4BzVoVotiDRfJwSdU8rXevm6QnmcUc/aj2cVr0m0
         psC6wT+a7kA6lv+68kYL1gaNQ1mAng7Apf6IycuHYJEcsP84KlFOiQSXhjOyV23OOxsy
         obweFVj1UxMRY94sJtSC5PferxwglbdLF3QM1Gjt3PMULJpyYtQp/JC8l3xuNxBZ/HdU
         JQ6bQj++JTIiweam4Tpe97MoBwjbH03MpfBQ7vX6cSR7chn7Li8+EDF7noT6TImKz+PC
         9+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=D2ubccsUc+lruYN/6q8Va1yZPf6jxpt0taqqepYfPvk=;
        b=HcFUjz48xxKSNxKldwX0dk+fPd7P4ZACp0JJS37oS/cLG2wIiCxQBFJMiCAKZcOv29
         96+PdytSeARaqf2V81S5Vf4uOuiNKopdaadOriE2bUHok49c3hJ+34Ed61UoFZcW0cZa
         r1TVBZ411hUgc819AiyR2KjMvsk04Kei8kP8feQGOc8fNVGha05rCE7AiS5j53JqWDuc
         rKzFgzm7xvvCRJITqxjPX7pw7LjTZaqfP33ZDBKFCFv9gO5WjVtrjBPLSWyrDQSuhHrQ
         grm9FHTkCpO9lN1+ao7qj4ht2EJrmk1LpCgBLJwRdDPqL3CDbY8aqYbfdzbOtl65hLDh
         24Kg==
X-Gm-Message-State: AGRZ1gLPNFsV5Q7tR9LMB1rq/iEYSMaC8dPmBUSxl6DOLfe9ozmQVDvb
        qKEfGrEGgQmqkfay3sK5Y6U=
X-Google-Smtp-Source: AJdET5dYwZffezPCRiD0XjloYZtx4Cz6x8UEPuro4rzPC/+ZokmYOOqugNQLfpe4mJe5pr8S7i5s9w==
X-Received: by 2002:a62:6001:: with SMTP id u1-v6mr24506297pfb.130.1543162788802;
        Sun, 25 Nov 2018 08:19:48 -0800 (PST)
Received: from arx-s1 ([116.238.148.251])
        by smtp.gmail.com with ESMTPSA id g123-v6sm98190883pfc.155.2018.11.25.08.19.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 08:19:48 -0800 (PST)
Date:   Mon, 26 Nov 2018 00:19:41 +0800
From:   Hao Zhang <hao5781286@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, mturquette@baylibre.com,
        sboyd@kernel.org, thierry.reding@gmail.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-sunxi@googlegroups.com,
        hao5781286@gmail.com
Subject: [PATCH v3 2/6] ARM: dtsi: add pwm node for sun8i R40.
Message-ID: <20181125161941.GA5305@arx-s1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds pwm node for sun8i R40.

Signed-off-by: Hao Zhang <hao5781286@gmail.com>
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index 6f4c9ca..cc05b2c 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -317,6 +317,7 @@
 			clock-names = "hosc", "losc";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
+
 		};
 
 		pio: pinctrl@1c20800 {
@@ -373,6 +374,11 @@
 				bias-pull-up;
 			};
 
+			pwm_ch0_pin: pwm-ch0-pin {
+				pins = "PB2";
+				function = "pwm";
+			};
+
 			uart0_pb_pins: uart0-pb-pins {
 				pins = "PB22", "PB23";
 				function = "uart0";
@@ -384,6 +390,17 @@
 			reg = <0x01c20c90 0x10>;
 		};
 
+		pwm: pwm@1c23400 {
+			compatible = "allwinner,sun8i-r40-pwm";
+			reg = <0x01c23400 0x400>;
+			interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc24M>, <&ccu CLK_APB1>;
+			clock-names = "mux-0", "mux-1";
+			pwm-channels = <8>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		uart0: serial@1c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
-- 
2.7.4


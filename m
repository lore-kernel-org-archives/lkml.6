Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1200CC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7DBE20989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nvnCTxky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbfA2UJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:09:16 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39800 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbfA2UJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 15:09:15 -0500
Received: by mail-wm1-f67.google.com with SMTP id y8so19143158wmi.4;
        Tue, 29 Jan 2019 12:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=P7uVknH6a2Lm+ESxiJyN8q2dm02UOXfATTairwfK400=;
        b=nvnCTxkyC8qHHud/LHMJZcH7o5qtNZfushQ0ji7K5vDUOBEq7lR3UY8DdLwjdzWa3B
         1sm4PNCqgWa6UW+8otsQCRoJqrlnjCan34yEkHEJi1AkQ87lWgjKnN9kH0HmozJw2HhB
         C4zl83U7rLyI1oUogUSnFxb3hx+ayEYbgIeCCDPdj90TO1rq9zrpmxBm2NJE6ajiBIUf
         lo0TVis7hFLwvm3jpcBU7MtqIqibdNGKzCwzC498GLfmVa2OrPrUY3/Zu3kn2xpPe8+X
         yE3RUB3JAhM7m9R58rZa7DGJLRCRxnc+JaDjqKGE8b5qfn/wasrT1Hrqv1wYyGywBMBi
         yc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P7uVknH6a2Lm+ESxiJyN8q2dm02UOXfATTairwfK400=;
        b=jTyVaThuzzaPLSBrW66i0KYz7l1NLlJuj7Nx55rl3KtbwcBuUSLQTjQ7aPVfFZDf31
         bQ4tWkcZaf0fGLzcdiRl/ZLw6xTZEC5iHxiYQWoyxZwwAMJSvojkl0jZCq0TUYNaBfzp
         DT4dDuvubIO3Tom2Ae/+hDFyg9VmtbN85UpSVEmm+lwTSUkqeny/gb4BtND3icSYk7Im
         QAjrCI0LGKyD3gf49xP+sjVLQmHvAfTTQez8ZmXpqeONjlT2Zu63K9zEi48pi3SqaN6+
         OQ2UY4zpVi4alQN4txlIYSUfU+b8AESDz3MOknw7+Isak4IchH3Ns8VbYUs43/quNyqQ
         EK/g==
X-Gm-Message-State: AJcUukdhyF03ilfIDfBRLisVyLD23lvteFcbuF4tuCHIsfAHmGnBAS8o
        hszV+97xnH/q6xjph4EhPW0KMncY
X-Google-Smtp-Source: ALg8bN5DuFtprYmvcsaJ7ebhyaOqIHffPOA+BEFzkHnf4qwnam+Hcb21/mFU85z/wTkdBjSqVD2iwA==
X-Received: by 2002:a1c:96ce:: with SMTP id y197mr23364527wmd.36.1548792554022;
        Tue, 29 Jan 2019 12:09:14 -0800 (PST)
Received: from ubuntu.home ([2a02:8071:6a3:700:8c22:ee0c:efc8:ed86])
        by smtp.gmail.com with ESMTPSA id w10sm4279020wmb.1.2019.01.29.12.09.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 12:09:13 -0800 (PST)
From:   Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
X-Google-Original-From: Simon Goldschmidt <goldsimon@gmx.de>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alan Tull <atull@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: socfpga: fix base address of SDR controller
Date:   Tue, 29 Jan 2019 21:08:58 +0100
Message-Id: <20190129200858.19773-1-goldsimon@gmx.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>

The documentation for socfpga gen5 says the base address of the sdram
controller is 0xffc20000, while the current devicetree says it is at
0xffc25000.

While this is not a problem for Linux, as it only accesses the registers
above 0xffc25000, it *is* a problem for U-Boot because the lower registers
are used during DDR calibration (up to now, the U-Boot driver does not use
the dts address, but that should change).

To keep Linux and U-Boot devicetrees in sync, this patch changes the base
address to 0xffc20000 and adapts the 2 files where it is currently used.

This patch changes the dts and 2 drivers with one commit to prevent
breaking the code if dts change and driver change would be split.

Signed-off-by: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
---

 arch/arm/boot/dts/socfpga.dtsi       | 4 ++--
 arch/arm/mach-socfpga/self-refresh.S | 4 ++--
 drivers/fpga/altera-fpga2sdram.c     | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index f365003f0..8f6c1a5d6 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -788,9 +788,9 @@
 			reg = <0xfffec000 0x100>;
 		};
 
-		sdr: sdr@ffc25000 {
+		sdr: sdr@ffc20000 {
 			compatible = "altr,sdr-ctl", "syscon";
-			reg = <0xffc25000 0x1000>;
+			reg = <0xffc20000 0x6000>;
 		};
 
 		sdramedac {
diff --git a/arch/arm/mach-socfpga/self-refresh.S b/arch/arm/mach-socfpga/self-refresh.S
index f2d7f883e..bd7759357 100644
--- a/arch/arm/mach-socfpga/self-refresh.S
+++ b/arch/arm/mach-socfpga/self-refresh.S
@@ -19,8 +19,8 @@
 #define MAX_LOOP_COUNT		1000
 
 /* Register offset */
-#define SDR_CTRLGRP_LOWPWREQ_ADDR       0x54
-#define SDR_CTRLGRP_LOWPWRACK_ADDR      0x58
+#define SDR_CTRLGRP_LOWPWREQ_ADDR       0x5054
+#define SDR_CTRLGRP_LOWPWRACK_ADDR      0x5058
 
 /* Bitfield positions */
 #define SELFRSHREQ_POS                  3
diff --git a/drivers/fpga/altera-fpga2sdram.c b/drivers/fpga/altera-fpga2sdram.c
index a78e49c63..30767c254 100644
--- a/drivers/fpga/altera-fpga2sdram.c
+++ b/drivers/fpga/altera-fpga2sdram.c
@@ -30,7 +30,7 @@
 #include <linux/of_platform.h>
 #include <linux/regmap.h>
 
-#define ALT_SDR_CTL_FPGAPORTRST_OFST		0x80
+#define ALT_SDR_CTL_FPGAPORTRST_OFST		0x5080
 #define ALT_SDR_CTL_FPGAPORTRST_PORTRSTN_MSK	0x00003fff
 #define ALT_SDR_CTL_FPGAPORTRST_RD_SHIFT	0
 #define ALT_SDR_CTL_FPGAPORTRST_WR_SHIFT	4
-- 
2.17.1


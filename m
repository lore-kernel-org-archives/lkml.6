Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0232C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B50120895
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJIqxlbf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B50120895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730631AbeG0KmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 06:42:19 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40084 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729504AbeG0KmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 06:42:19 -0400
Received: by mail-pf1-f194.google.com with SMTP id e13-v6so1541067pff.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 02:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EzWT32oUzFCrUC6kHnH6vBPs/h0PNWyst2Tp/jemnr0=;
        b=mJIqxlbfgJbtQ0GP3T6UFdK40EPuO77qfm305sBoV8uI1EzBnSSENUDoqVgcj1Zchk
         iFlLe9TM+0m72Dfmf1sVnL2NVriqPX658scFZxAiodj3dhvnVKQ+8VOYTsUHsyezrQL8
         n0dL+nAHvUiRJVUzGS2/5KnLOrd3M3HsPs+igl6/Ydo6DBBrl4JyxA0/5R87FKAalfft
         S+tCzZcgar4mzHDTr3/S0O9oDp4odun4uB+Hl4LoAuloKajSrxoYlE6eSNPX7H5vkcZV
         bxEKuBOVGYC1A+lvB9Pz05vv4/6qv8TKmq0u2kFozeSS08TjFeDPlD1sHtlkSLzW1F7/
         SuTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EzWT32oUzFCrUC6kHnH6vBPs/h0PNWyst2Tp/jemnr0=;
        b=jCfdpfsByiGmO70XR82qd3tnd5KpRP1i0Fe2eveUH1TWoTfUHcKJD/eyg/k5P1sDWZ
         VP1RRszE66W6XSA9I/1YdS3lRMidJRcwOY4tcu48iD9nCraTV5klUcicLVH/5t41ZcdH
         V6GXncmeWGCvseSSkyprT7VDwe/+rkAERfUirlyTcXRwd0dFbPjpfKEf2Os0YbWWHvBB
         WsZRA+pRkz2OaUPqL1hpo07Txyp9yYU4FZbZWWEHtBtRYHm0JBbADdWoOYsZ1vfTuQgO
         zYJ5oA8GmQpTyTLIBtRXp5jD0vDRLxSbn94bIfWV3XJcNiO2IiJ3WD8d/6qz9/BNjEZh
         1gnQ==
X-Gm-Message-State: AOUpUlG5lWr+9LU46JAqOzdyyonJjHSU6B1KCk0Pu4qezk8wHkcEsJwp
        RFrnibLaa9tAnBGovrQAvKbjTj+pgB4=
X-Google-Smtp-Source: AAOMgpdLybl/C3k/q5IkxHIAH8hCmMk2BayDwwqif+h2rf9zugXbK2/EH/d6Y1Cq1VYl3p4JqQj3/Q==
X-Received: by 2002:a63:e318:: with SMTP id f24-v6mr5212293pgh.175.1532683278992;
        Fri, 27 Jul 2018 02:21:18 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:8ca7:1cde:b1e6:2647])
        by smtp.gmail.com with ESMTPSA id f5-v6sm4992018pga.58.2018.07.27.02.21.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 02:21:18 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     thomas.petazzoni@free-electrons.com, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] staging: fbtft: Replace mdelay() with msleep() and usleep_range()
Date:   Fri, 27 Jul 2018 17:21:11 +0800
Message-Id: <20180727092111.7218-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

reset() and init_display() are never called in atomic context.
They call mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/staging/fbtft/fb_agm1264k-fl.c |  2 +-
 drivers/staging/fbtft/fb_bd663474.c    |  6 +++---
 drivers/staging/fbtft/fb_hx8340bn.c    |  8 ++++----
 drivers/staging/fbtft/fb_hx8347d.c     | 10 +++++-----
 drivers/staging/fbtft/fb_hx8353d.c     |  4 ++--
 drivers/staging/fbtft/fb_ili9163.c     |  4 ++--
 drivers/staging/fbtft/fb_ili9320.c     |  8 ++++----
 drivers/staging/fbtft/fb_ili9325.c     |  8 ++++----
 drivers/staging/fbtft/fb_ili9340.c     |  2 +-
 drivers/staging/fbtft/fb_ili9341.c     |  6 +++---
 drivers/staging/fbtft/fb_st7789v.c     |  2 +-
 drivers/staging/fbtft/fb_watterott.c   |  4 ++--
 12 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/staging/fbtft/fb_agm1264k-fl.c b/drivers/staging/fbtft/fb_agm1264k-fl.c
index f6f30f5bf15a..8cead859e688 100644
--- a/drivers/staging/fbtft/fb_agm1264k-fl.c
+++ b/drivers/staging/fbtft/fb_agm1264k-fl.c
@@ -87,7 +87,7 @@ static void reset(struct fbtft_par *par)
 	gpio_set_value(par->gpio.reset, 0);
 	udelay(20);
 	gpio_set_value(par->gpio.reset, 1);
-	mdelay(120);
+	msleep(120);
 }
 
 /* Check if all necessary GPIOS defined */
diff --git a/drivers/staging/fbtft/fb_bd663474.c b/drivers/staging/fbtft/fb_bd663474.c
index a58c514f4721..59eb28fa0dc8 100644
--- a/drivers/staging/fbtft/fb_bd663474.c
+++ b/drivers/staging/fbtft/fb_bd663474.c
@@ -33,7 +33,7 @@ static int init_display(struct fbtft_par *par)
 
 	/* oscillator start */
 	write_reg(par, 0x000, 0x0001);	/*oscillator 0: stop, 1: operation */
-	mdelay(10);
+	usleep_range(10000, 11000);
 
 	/* Power settings */
 	write_reg(par, 0x100, 0x0000); /* power supply setup */
@@ -43,10 +43,10 @@ static int init_display(struct fbtft_par *par)
 	write_reg(par, 0x110, 0x009d);
 	write_reg(par, 0x111, 0x0022);
 	write_reg(par, 0x100, 0x0120);
-	mdelay(20);
+	msleep(20);
 
 	write_reg(par, 0x100, 0x3120);
-	mdelay(80);
+	msleep(80);
 	/* Display control */
 	write_reg(par, 0x001, 0x0100);
 	write_reg(par, 0x002, 0x0000);
diff --git a/drivers/staging/fbtft/fb_hx8340bn.c b/drivers/staging/fbtft/fb_hx8340bn.c
index d47dcf31fffb..0460597af95e 100644
--- a/drivers/staging/fbtft/fb_hx8340bn.c
+++ b/drivers/staging/fbtft/fb_hx8340bn.c
@@ -51,7 +51,7 @@ static int init_display(struct fbtft_par *par)
 	 * is started, and panel scanning is started.
 	 */
 	write_reg(par, 0x11);
-	mdelay(150);
+	msleep(150);
 
 	/* Undoc'd register? */
 	write_reg(par, 0xCA, 0x70, 0x00, 0xD9);
@@ -66,7 +66,7 @@ static int init_display(struct fbtft_par *par)
 
 	/* Drive ability setting */
 	write_reg(par, 0xC9, 0x90, 0x49, 0x10, 0x28, 0x28, 0x10, 0x00, 0x06);
-	mdelay(20);
+	msleep(20);
 
 	/*
 	 * SETPWCTR5: Set Power Control 5(B5h)
@@ -85,7 +85,7 @@ static int init_display(struct fbtft_par *par)
 	 *			for VGH and VGL voltage generation.
 	 */
 	write_reg(par, 0xB4, 0x33, 0x25, 0x4C);
-	mdelay(10);
+	usleep_range(10000, 11000);
 
 	/*
 	 * Interface Pixel Format (3Ah)
@@ -101,7 +101,7 @@ static int init_display(struct fbtft_par *par)
 	 * Output from the Frame Memory is enabled.
 	 */
 	write_reg(par, MIPI_DCS_SET_DISPLAY_ON);
-	mdelay(10);
+	usleep_range(10000, 11000);
 
 	return 0;
 }
diff --git a/drivers/staging/fbtft/fb_hx8347d.c b/drivers/staging/fbtft/fb_hx8347d.c
index 0b605303813e..1d79190e5326 100644
--- a/drivers/staging/fbtft/fb_hx8347d.c
+++ b/drivers/staging/fbtft/fb_hx8347d.c
@@ -49,13 +49,13 @@ static int init_display(struct fbtft_par *par)
 	write_reg(par, 0x19, 0x01); /* start osc */
 	write_reg(par, 0x01, 0x00); /* wakeup */
 	write_reg(par, 0x1F, 0x88);
-	mdelay(5);
+	usleep_range(5000, 6000);
 	write_reg(par, 0x1F, 0x80);
-	mdelay(5);
+	usleep_range(5000, 6000);
 	write_reg(par, 0x1F, 0x90);
-	mdelay(5);
+	usleep_range(5000, 6000);
 	write_reg(par, 0x1F, 0xD0);
-	mdelay(5);
+	usleep_range(5000, 6000);
 
 	/* color selection */
 	write_reg(par, 0x17, 0x05); /* 65k */
@@ -65,7 +65,7 @@ static int init_display(struct fbtft_par *par)
 
 	/*display on */
 	write_reg(par, 0x28, 0x38);
-	mdelay(40);
+	msleep(40);
 	write_reg(par, 0x28, 0x3C);
 
 	/* orientation */
diff --git a/drivers/staging/fbtft/fb_hx8353d.c b/drivers/staging/fbtft/fb_hx8353d.c
index 3e73b69b6a27..1ba63db42b83 100644
--- a/drivers/staging/fbtft/fb_hx8353d.c
+++ b/drivers/staging/fbtft/fb_hx8353d.c
@@ -20,7 +20,7 @@
 static int init_display(struct fbtft_par *par)
 {
 	par->fbtftops.reset(par);
-	mdelay(150);
+	msleep(150);
 
 	/* SETEXTC */
 	write_reg(par, 0xB9, 0xFF, 0x83, 0x53);
@@ -42,7 +42,7 @@ static int init_display(struct fbtft_par *par)
 
 	/* SLPOUT - Sleep out & booster on */
 	write_reg(par, MIPI_DCS_EXIT_SLEEP_MODE);
-	mdelay(150);
+	msleep(150);
 
 	/* DISPON - Display On */
 	write_reg(par, MIPI_DCS_SET_DISPLAY_ON);
diff --git a/drivers/staging/fbtft/fb_ili9163.c b/drivers/staging/fbtft/fb_ili9163.c
index fd3dd671509f..ea7f7261f74f 100644
--- a/drivers/staging/fbtft/fb_ili9163.c
+++ b/drivers/staging/fbtft/fb_ili9163.c
@@ -81,9 +81,9 @@ static int init_display(struct fbtft_par *par)
 		gpio_set_value(par->gpio.cs, 0);  /* Activate chip */
 
 	write_reg(par, MIPI_DCS_SOFT_RESET); /* software reset */
-	mdelay(500);
+	msleep(500);
 	write_reg(par, MIPI_DCS_EXIT_SLEEP_MODE); /* exit sleep */
-	mdelay(5);
+	usleep_range(5000, 6000);
 	write_reg(par, MIPI_DCS_SET_PIXEL_FORMAT, MIPI_DCS_PIXEL_FMT_16BIT);
 	/* default gamma curve 3 */
 	write_reg(par, MIPI_DCS_SET_GAMMA_CURVE, 0x02);
diff --git a/drivers/staging/fbtft/fb_ili9320.c b/drivers/staging/fbtft/fb_ili9320.c
index 501eee7dce4c..d89158e7a9df 100644
--- a/drivers/staging/fbtft/fb_ili9320.c
+++ b/drivers/staging/fbtft/fb_ili9320.c
@@ -94,25 +94,25 @@ static int init_display(struct fbtft_par *par)
 	write_reg(par, 0x0013, 0x0000);
 
 	/* Dis-charge capacitor power voltage */
-	mdelay(200);
+	msleep(200);
 
 	/* SAP, BT[3:0], AP, DSTB, SLP, STB */
 	write_reg(par, 0x0010, 0x17B0);
 
 	/* R11h=0x0031 at VCI=3.3V DC1[2:0], DC0[2:0], VC[2:0] */
 	write_reg(par, 0x0011, 0x0031);
-	mdelay(50);
+	msleep(50);
 
 	/* R12h=0x0138 at VCI=3.3V VREG1OUT voltage */
 	write_reg(par, 0x0012, 0x0138);
-	mdelay(50);
+	msleep(50);
 
 	/* R13h=0x1800 at VCI=3.3V VDV[4:0] for VCOM amplitude */
 	write_reg(par, 0x0013, 0x1800);
 
 	/* R29h=0x0008 at VCI=3.3V VCM[4:0] for VCOMH */
 	write_reg(par, 0x0029, 0x0008);
-	mdelay(50);
+	msleep(50);
 
 	/* GRAM horizontal Address */
 	write_reg(par, 0x0020, 0x0000);
diff --git a/drivers/staging/fbtft/fb_ili9325.c b/drivers/staging/fbtft/fb_ili9325.c
index d6b1d4be9ff4..50eeeb7afbc8 100644
--- a/drivers/staging/fbtft/fb_ili9325.c
+++ b/drivers/staging/fbtft/fb_ili9325.c
@@ -115,17 +115,17 @@ static int init_display(struct fbtft_par *par)
 	write_reg(par, 0x0011, 0x0007); /* DC1[2:0], DC0[2:0], VC[2:0] */
 	write_reg(par, 0x0012, 0x0000); /* VREG1OUT voltage */
 	write_reg(par, 0x0013, 0x0000); /* VDV[4:0] for VCOM amplitude */
-	mdelay(200); /* Dis-charge capacitor power voltage */
+	msleep(200); /* Dis-charge capacitor power voltage */
 	write_reg(par, 0x0010, /* SAP, BT[3:0], AP, DSTB, SLP, STB */
 		BIT(12) | (bt << 8) | BIT(7) | BIT(4));
 	write_reg(par, 0x0011, 0x220 | vc); /* DC1[2:0], DC0[2:0], VC[2:0] */
-	mdelay(50); /* Delay 50ms */
+	msleep(50); /* Delay 50ms */
 	write_reg(par, 0x0012, vrh); /* Internal reference voltage= Vci; */
-	mdelay(50); /* Delay 50ms */
+	msleep(50); /* Delay 50ms */
 	write_reg(par, 0x0013, vdv << 8); /* Set VDV[4:0] for VCOM amplitude */
 	write_reg(par, 0x0029, vcm); /* Set VCM[5:0] for VCOMH */
 	write_reg(par, 0x002B, 0x000C); /* Set Frame Rate */
-	mdelay(50); /* Delay 50ms */
+	msleep(50); /* Delay 50ms */
 	write_reg(par, 0x0020, 0x0000); /* GRAM horizontal Address */
 	write_reg(par, 0x0021, 0x0000); /* GRAM Vertical Address */
 
diff --git a/drivers/staging/fbtft/fb_ili9340.c b/drivers/staging/fbtft/fb_ili9340.c
index 430f21e50f4d..979f825930c3 100644
--- a/drivers/staging/fbtft/fb_ili9340.c
+++ b/drivers/staging/fbtft/fb_ili9340.c
@@ -72,7 +72,7 @@ static int init_display(struct fbtft_par *par)
 
 	write_reg(par, MIPI_DCS_EXIT_SLEEP_MODE);
 
-	mdelay(120);
+	msleep(120);
 
 	write_reg(par, MIPI_DCS_SET_DISPLAY_ON);
 
diff --git a/drivers/staging/fbtft/fb_ili9341.c b/drivers/staging/fbtft/fb_ili9341.c
index a10e8c9de438..c384f96659ef 100644
--- a/drivers/staging/fbtft/fb_ili9341.c
+++ b/drivers/staging/fbtft/fb_ili9341.c
@@ -32,7 +32,7 @@ static int init_display(struct fbtft_par *par)
 
 	/* startup sequence for MI0283QT-9A */
 	write_reg(par, MIPI_DCS_SOFT_RESET);
-	mdelay(5);
+	usleep_range(5000, 6000);
 	write_reg(par, MIPI_DCS_SET_DISPLAY_OFF);
 	/* --------------------------------------------------------- */
 	write_reg(par, 0xCF, 0x00, 0x83, 0x30);
@@ -58,9 +58,9 @@ static int init_display(struct fbtft_par *par)
 	write_reg(par, 0xB7, 0x07); /* entry mode set */
 	write_reg(par, 0xB6, 0x0A, 0x82, 0x27, 0x00);
 	write_reg(par, MIPI_DCS_EXIT_SLEEP_MODE);
-	mdelay(100);
+	msleep(100);
 	write_reg(par, MIPI_DCS_SET_DISPLAY_ON);
-	mdelay(20);
+	msleep(20);
 
 	return 0;
 }
diff --git a/drivers/staging/fbtft/fb_st7789v.c b/drivers/staging/fbtft/fb_st7789v.c
index 7d7573a7b615..7033b82f2087 100644
--- a/drivers/staging/fbtft/fb_st7789v.c
+++ b/drivers/staging/fbtft/fb_st7789v.c
@@ -78,7 +78,7 @@ static int init_display(struct fbtft_par *par)
 {
 	/* turn off sleep mode */
 	write_reg(par, MIPI_DCS_EXIT_SLEEP_MODE);
-	mdelay(120);
+	msleep(120);
 
 	/* set pixel format to RGB-565 */
 	write_reg(par, MIPI_DCS_SET_PIXEL_FORMAT, MIPI_DCS_PIXEL_FMT_16BIT);
diff --git a/drivers/staging/fbtft/fb_watterott.c b/drivers/staging/fbtft/fb_watterott.c
index bfd1527f20f7..6994db5d9d36 100644
--- a/drivers/staging/fbtft/fb_watterott.c
+++ b/drivers/staging/fbtft/fb_watterott.c
@@ -156,9 +156,9 @@ static int init_display(struct fbtft_par *par)
 	}
 	write_reg(par, 0x00); /* make sure mode is set */
 
-	mdelay(50);
+	msleep(50);
 	par->fbtftops.reset(par);
-	mdelay(1000);
+	msleep(1000);
 	par->spi->mode = save_mode;
 	ret = spi_setup(par->spi);
 	if (ret) {
-- 
2.17.0


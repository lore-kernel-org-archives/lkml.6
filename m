Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEACFC282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A33FC218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="o4FtxtKV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387636AbfAaNjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:39:53 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39923 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387607AbfAaNjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:39:51 -0500
Received: by mail-wr1-f67.google.com with SMTP id t27so3326072wra.6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 05:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9/cz8Dplt148narhGDwcsNPC9FgaTJHEYozu5GdxH00=;
        b=o4FtxtKVns7Ab4eM3l8n3yJXPCWhqqQPxcZicRIxBPsTm1CgFyIHY4CLlItjb/Carz
         E0Izn9pqd/q0NN+HKL+N7l747K4WMIJ5CP/N//vQVAanNvE8nGXJc60r8zs2+Tamexwg
         2MwupL4B332jRXVOuGd5bndJYGfInDa8RFHiT+1sIwjWXIg9+ZkNbdIlxrMHa97BwQap
         g9T1BvzD4YdosydT0asI1ldbWHGOfLD2uZvf0JBhV2GbO5lcknWXW7W1ue3bTTW2kve0
         cckzmzvjZKSYdwyy2ambrEjlJPrOiVQHnzzxjmLuId7sQHSK0h18NbUEngWBiDbCZ5Vv
         jxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9/cz8Dplt148narhGDwcsNPC9FgaTJHEYozu5GdxH00=;
        b=MH5xKUv9RpNm1BI8BiudC273RZPFcf0dsyGJFvjeYWjm9m2IR7Y56ur5KH1EvdkQE3
         cUi+tfh1mgWtmk63XzlseqX35pJnbgLeYehBEy2MJNPUcfEHm+Ood2nolfCGS6/WK8si
         04z3HSIJ/o+8r54Mc/h1sN7XekP9qIG+Vea0dwfIZDiTZuxvoI8m0tOysRdWjYo2PdM2
         +b1hWfJOJCDTlHn1vi1FlhlqCuC7rZoknxtUo61I0o5W4r/gkMjluxjkypjc34hTTPuh
         cHbRNV//FNyaJwagHPoAIAPSmdm3Y+DNEOw8yhKAROLM99P/h9O62rtXMpjO7XVUEyvd
         ejgA==
X-Gm-Message-State: AHQUAuY6+azq1IdaJuQjnA7FnjAs8E9u0El4Lmaq0RQ8/cepQwQ30kDt
        I5neg8SEKSzs3MCt2HGNxQjdrw==
X-Google-Smtp-Source: AHgI3IZGQJCeQU7MY9EV7hCTQ8T2fk20aSczwKXyyQjrYmS30/bzzlL+eXKztIp5rM3JEWeDDLyOXA==
X-Received: by 2002:a5d:4d87:: with SMTP id b7mr10593083wru.316.1548941987491;
        Thu, 31 Jan 2019 05:39:47 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.39.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 05:39:46 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 05/35] ARM: davinci: drop irq defines from default_priorites
Date:   Thu, 31 Jan 2019 14:38:58 +0100
Message-Id: <20190131133928.17985-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131133928.17985-1-brgl@bgdev.pl>
References: <20190131133928.17985-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

In order to select SPARSE_IRQ we need to make the interrupt numbers
dynamic (at least at build-time for the top-level controller). The
interrupt numbers are used as array indexes for irq priorities.

Drop the defines and just initialize the arrays in a linear manner.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/da830.c  | 107 ++++--------------------------
 arch/arm/mach-davinci/da850.c  | 118 +++++----------------------------
 arch/arm/mach-davinci/dm355.c  |  74 +++------------------
 arch/arm/mach-davinci/dm365.c  |  76 +++------------------
 arch/arm/mach-davinci/dm644x.c |  76 +++------------------
 arch/arm/mach-davinci/dm646x.c |  76 +++------------------
 6 files changed, 69 insertions(+), 458 deletions(-)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 9e18b245266b..f1e7b6c644e5 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -624,98 +624,19 @@ const short da830_eqep1_pins[] __initconst = {
 };
 
 /* FIQ are pri 0-1; otherwise 2-7, with 7 lowest priority */
-static u8 da830_default_priorities[DA830_N_CP_INTC_IRQ] = {
-	[IRQ_DA8XX_COMMTX]		= 7,
-	[IRQ_DA8XX_COMMRX]		= 7,
-	[IRQ_DA8XX_NINT]		= 7,
-	[IRQ_DA8XX_EVTOUT0]		= 7,
-	[IRQ_DA8XX_EVTOUT1]		= 7,
-	[IRQ_DA8XX_EVTOUT2]		= 7,
-	[IRQ_DA8XX_EVTOUT3]		= 7,
-	[IRQ_DA8XX_EVTOUT4]		= 7,
-	[IRQ_DA8XX_EVTOUT5]		= 7,
-	[IRQ_DA8XX_EVTOUT6]		= 7,
-	[IRQ_DA8XX_EVTOUT7]		= 7,
-	[IRQ_DA8XX_CCINT0]		= 7,
-	[IRQ_DA8XX_CCERRINT]		= 7,
-	[IRQ_DA8XX_TCERRINT0]		= 7,
-	[IRQ_DA8XX_AEMIFINT]		= 7,
-	[IRQ_DA8XX_I2CINT0]		= 7,
-	[IRQ_DA8XX_MMCSDINT0]		= 7,
-	[IRQ_DA8XX_MMCSDINT1]		= 7,
-	[IRQ_DA8XX_ALLINT0]		= 7,
-	[IRQ_DA8XX_RTC]			= 7,
-	[IRQ_DA8XX_SPINT0]		= 7,
-	[IRQ_DA8XX_TINT12_0]		= 7,
-	[IRQ_DA8XX_TINT34_0]		= 7,
-	[IRQ_DA8XX_TINT12_1]		= 7,
-	[IRQ_DA8XX_TINT34_1]		= 7,
-	[IRQ_DA8XX_UARTINT0]		= 7,
-	[IRQ_DA8XX_KEYMGRINT]		= 7,
-	[IRQ_DA830_MPUERR]		= 7,
-	[IRQ_DA8XX_CHIPINT0]		= 7,
-	[IRQ_DA8XX_CHIPINT1]		= 7,
-	[IRQ_DA8XX_CHIPINT2]		= 7,
-	[IRQ_DA8XX_CHIPINT3]		= 7,
-	[IRQ_DA8XX_TCERRINT1]		= 7,
-	[IRQ_DA8XX_C0_RX_THRESH_PULSE]	= 7,
-	[IRQ_DA8XX_C0_RX_PULSE]		= 7,
-	[IRQ_DA8XX_C0_TX_PULSE]		= 7,
-	[IRQ_DA8XX_C0_MISC_PULSE]	= 7,
-	[IRQ_DA8XX_C1_RX_THRESH_PULSE]	= 7,
-	[IRQ_DA8XX_C1_RX_PULSE]		= 7,
-	[IRQ_DA8XX_C1_TX_PULSE]		= 7,
-	[IRQ_DA8XX_C1_MISC_PULSE]	= 7,
-	[IRQ_DA8XX_MEMERR]		= 7,
-	[IRQ_DA8XX_GPIO0]		= 7,
-	[IRQ_DA8XX_GPIO1]		= 7,
-	[IRQ_DA8XX_GPIO2]		= 7,
-	[IRQ_DA8XX_GPIO3]		= 7,
-	[IRQ_DA8XX_GPIO4]		= 7,
-	[IRQ_DA8XX_GPIO5]		= 7,
-	[IRQ_DA8XX_GPIO6]		= 7,
-	[IRQ_DA8XX_GPIO7]		= 7,
-	[IRQ_DA8XX_GPIO8]		= 7,
-	[IRQ_DA8XX_I2CINT1]		= 7,
-	[IRQ_DA8XX_LCDINT]		= 7,
-	[IRQ_DA8XX_UARTINT1]		= 7,
-	[IRQ_DA8XX_MCASPINT]		= 7,
-	[IRQ_DA8XX_ALLINT1]		= 7,
-	[IRQ_DA8XX_SPINT1]		= 7,
-	[IRQ_DA8XX_UHPI_INT1]		= 7,
-	[IRQ_DA8XX_USB_INT]		= 7,
-	[IRQ_DA8XX_IRQN]		= 7,
-	[IRQ_DA8XX_RWAKEUP]		= 7,
-	[IRQ_DA8XX_UARTINT2]		= 7,
-	[IRQ_DA8XX_DFTSSINT]		= 7,
-	[IRQ_DA8XX_EHRPWM0]		= 7,
-	[IRQ_DA8XX_EHRPWM0TZ]		= 7,
-	[IRQ_DA8XX_EHRPWM1]		= 7,
-	[IRQ_DA8XX_EHRPWM1TZ]		= 7,
-	[IRQ_DA830_EHRPWM2]		= 7,
-	[IRQ_DA830_EHRPWM2TZ]		= 7,
-	[IRQ_DA8XX_ECAP0]		= 7,
-	[IRQ_DA8XX_ECAP1]		= 7,
-	[IRQ_DA8XX_ECAP2]		= 7,
-	[IRQ_DA830_EQEP0]		= 7,
-	[IRQ_DA830_EQEP1]		= 7,
-	[IRQ_DA830_T12CMPINT0_0]	= 7,
-	[IRQ_DA830_T12CMPINT1_0]	= 7,
-	[IRQ_DA830_T12CMPINT2_0]	= 7,
-	[IRQ_DA830_T12CMPINT3_0]	= 7,
-	[IRQ_DA830_T12CMPINT4_0]	= 7,
-	[IRQ_DA830_T12CMPINT5_0]	= 7,
-	[IRQ_DA830_T12CMPINT6_0]	= 7,
-	[IRQ_DA830_T12CMPINT7_0]	= 7,
-	[IRQ_DA830_T12CMPINT0_1]	= 7,
-	[IRQ_DA830_T12CMPINT1_1]	= 7,
-	[IRQ_DA830_T12CMPINT2_1]	= 7,
-	[IRQ_DA830_T12CMPINT3_1]	= 7,
-	[IRQ_DA830_T12CMPINT4_1]	= 7,
-	[IRQ_DA830_T12CMPINT5_1]	= 7,
-	[IRQ_DA830_T12CMPINT6_1]	= 7,
-	[IRQ_DA830_T12CMPINT7_1]	= 7,
-	[IRQ_DA8XX_ARMCLKSTOPREQ]	= 7,
+static u8 da830_cp_intc_prios[] = {
+	7, 7, 7, 7, 7, 7, 7, 7,
+	7, 7, 7, 7, 7, 7, 7, 7,
+	7, 7, 7, 7, 7, 7, 7, 7,
+	7, 7, 7, 7, 7, 7, 7, 7,
+	7, 7, 7, 7, 7, 7, 7, 7,
+	7, 7, 7, 7, 7, 7, 7, 7,
+	7, 7, 7, 7, 7, 7, 7, 7,
+	7, 7, 7, 7, 7, 7, 7, 7,
+	7, 7, 7, 7, 7, 7, 7, 7,
+	7, 7, 7, 7, 7, 7, 7, 7,
+	7, 7, 7, 7, 7, 7, 7, 7,
+	7, 7, 7, 7, 7, 7, 7, 7,
 };
 
 static struct map_desc da830_io_desc[] = {
@@ -807,7 +728,7 @@ static const struct davinci_soc_info davinci_soc_info_da830 = {
 	.pinmux_pins		= da830_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(da830_pins),
 	.intc_base		= DA8XX_CP_INTC_BASE,
-	.intc_irq_prios		= da830_default_priorities,
+	.intc_irq_prios		= da830_cp_intc_prios,
 	.intc_irq_num		= DA830_N_CP_INTC_IRQ,
 	.timer_info		= &da830_timer_info,
 	.emac_pdata		= &da8xx_emac_pdata,
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index e823b89e2b7a..40b90730e847 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -299,108 +299,20 @@ const short da850_vpif_display_pins[] __initconst = {
 };
 
 /* FIQ are pri 0-1; otherwise 2-7, with 7 lowest priority */
-static u8 da850_default_priorities[DA850_N_CP_INTC_IRQ] = {
-	[IRQ_DA8XX_COMMTX]		= 7,
-	[IRQ_DA8XX_COMMRX]		= 7,
-	[IRQ_DA8XX_NINT]		= 7,
-	[IRQ_DA8XX_EVTOUT0]		= 7,
-	[IRQ_DA8XX_EVTOUT1]		= 7,
-	[IRQ_DA8XX_EVTOUT2]		= 7,
-	[IRQ_DA8XX_EVTOUT3]		= 7,
-	[IRQ_DA8XX_EVTOUT4]		= 7,
-	[IRQ_DA8XX_EVTOUT5]		= 7,
-	[IRQ_DA8XX_EVTOUT6]		= 7,
-	[IRQ_DA8XX_EVTOUT7]		= 7,
-	[IRQ_DA8XX_CCINT0]		= 7,
-	[IRQ_DA8XX_CCERRINT]		= 7,
-	[IRQ_DA8XX_TCERRINT0]		= 7,
-	[IRQ_DA8XX_AEMIFINT]		= 7,
-	[IRQ_DA8XX_I2CINT0]		= 7,
-	[IRQ_DA8XX_MMCSDINT0]		= 7,
-	[IRQ_DA8XX_MMCSDINT1]		= 7,
-	[IRQ_DA8XX_ALLINT0]		= 7,
-	[IRQ_DA8XX_RTC]			= 7,
-	[IRQ_DA8XX_SPINT0]		= 7,
-	[IRQ_DA8XX_TINT12_0]		= 7,
-	[IRQ_DA8XX_TINT34_0]		= 7,
-	[IRQ_DA8XX_TINT12_1]		= 7,
-	[IRQ_DA8XX_TINT34_1]		= 7,
-	[IRQ_DA8XX_UARTINT0]		= 7,
-	[IRQ_DA8XX_KEYMGRINT]		= 7,
-	[IRQ_DA850_MPUADDRERR0]		= 7,
-	[IRQ_DA8XX_CHIPINT0]		= 7,
-	[IRQ_DA8XX_CHIPINT1]		= 7,
-	[IRQ_DA8XX_CHIPINT2]		= 7,
-	[IRQ_DA8XX_CHIPINT3]		= 7,
-	[IRQ_DA8XX_TCERRINT1]		= 7,
-	[IRQ_DA8XX_C0_RX_THRESH_PULSE]	= 7,
-	[IRQ_DA8XX_C0_RX_PULSE]		= 7,
-	[IRQ_DA8XX_C0_TX_PULSE]		= 7,
-	[IRQ_DA8XX_C0_MISC_PULSE]	= 7,
-	[IRQ_DA8XX_C1_RX_THRESH_PULSE]	= 7,
-	[IRQ_DA8XX_C1_RX_PULSE]		= 7,
-	[IRQ_DA8XX_C1_TX_PULSE]		= 7,
-	[IRQ_DA8XX_C1_MISC_PULSE]	= 7,
-	[IRQ_DA8XX_MEMERR]		= 7,
-	[IRQ_DA8XX_GPIO0]		= 7,
-	[IRQ_DA8XX_GPIO1]		= 7,
-	[IRQ_DA8XX_GPIO2]		= 7,
-	[IRQ_DA8XX_GPIO3]		= 7,
-	[IRQ_DA8XX_GPIO4]		= 7,
-	[IRQ_DA8XX_GPIO5]		= 7,
-	[IRQ_DA8XX_GPIO6]		= 7,
-	[IRQ_DA8XX_GPIO7]		= 7,
-	[IRQ_DA8XX_GPIO8]		= 7,
-	[IRQ_DA8XX_I2CINT1]		= 7,
-	[IRQ_DA8XX_LCDINT]		= 7,
-	[IRQ_DA8XX_UARTINT1]		= 7,
-	[IRQ_DA8XX_MCASPINT]		= 7,
-	[IRQ_DA8XX_ALLINT1]		= 7,
-	[IRQ_DA8XX_SPINT1]		= 7,
-	[IRQ_DA8XX_UHPI_INT1]		= 7,
-	[IRQ_DA8XX_USB_INT]		= 7,
-	[IRQ_DA8XX_IRQN]		= 7,
-	[IRQ_DA8XX_RWAKEUP]		= 7,
-	[IRQ_DA8XX_UARTINT2]		= 7,
-	[IRQ_DA8XX_DFTSSINT]		= 7,
-	[IRQ_DA8XX_EHRPWM0]		= 7,
-	[IRQ_DA8XX_EHRPWM0TZ]		= 7,
-	[IRQ_DA8XX_EHRPWM1]		= 7,
-	[IRQ_DA8XX_EHRPWM1TZ]		= 7,
-	[IRQ_DA850_SATAINT]		= 7,
-	[IRQ_DA850_TINTALL_2]		= 7,
-	[IRQ_DA8XX_ECAP0]		= 7,
-	[IRQ_DA8XX_ECAP1]		= 7,
-	[IRQ_DA8XX_ECAP2]		= 7,
-	[IRQ_DA850_MMCSDINT0_1]		= 7,
-	[IRQ_DA850_MMCSDINT1_1]		= 7,
-	[IRQ_DA850_T12CMPINT0_2]	= 7,
-	[IRQ_DA850_T12CMPINT1_2]	= 7,
-	[IRQ_DA850_T12CMPINT2_2]	= 7,
-	[IRQ_DA850_T12CMPINT3_2]	= 7,
-	[IRQ_DA850_T12CMPINT4_2]	= 7,
-	[IRQ_DA850_T12CMPINT5_2]	= 7,
-	[IRQ_DA850_T12CMPINT6_2]	= 7,
-	[IRQ_DA850_T12CMPINT7_2]	= 7,
-	[IRQ_DA850_T12CMPINT0_3]	= 7,
-	[IRQ_DA850_T12CMPINT1_3]	= 7,
-	[IRQ_DA850_T12CMPINT2_3]	= 7,
-	[IRQ_DA850_T12CMPINT3_3]	= 7,
-	[IRQ_DA850_T12CMPINT4_3]	= 7,
-	[IRQ_DA850_T12CMPINT5_3]	= 7,
-	[IRQ_DA850_T12CMPINT6_3]	= 7,
-	[IRQ_DA850_T12CMPINT7_3]	= 7,
-	[IRQ_DA850_RPIINT]		= 7,
-	[IRQ_DA850_VPIFINT]		= 7,
-	[IRQ_DA850_CCINT1]		= 7,
-	[IRQ_DA850_CCERRINT1]		= 7,
-	[IRQ_DA850_TCERRINT2]		= 7,
-	[IRQ_DA850_TINTALL_3]		= 7,
-	[IRQ_DA850_MCBSP0RINT]		= 7,
-	[IRQ_DA850_MCBSP0XINT]		= 7,
-	[IRQ_DA850_MCBSP1RINT]		= 7,
-	[IRQ_DA850_MCBSP1XINT]		= 7,
-	[IRQ_DA8XX_ARMCLKSTOPREQ]	= 7,
+static u8 da850_cp_intc_prios[] = {
+	7, 7, 7, 7, 7, 7, 7, 7,
+	7, 7, 7, 7, 7, 7, 7, 7,
+	7, 7, 7, 7, 7, 7, 7, 7,
+	7, 7, 7, 7, 7, 7, 7, 7,
+	7, 7, 7, 7, 7, 7, 7, 7,
+	7, 7, 7, 7, 7, 7, 7, 7,
+	7, 7, 7, 7, 7, 7, 7, 7,
+	7, 7, 7, 7, 7, 7, 7, 7,
+	7, 7, 7, 7, 7, 7, 7, 7,
+	7, 7, 7, 7, 7, 7, 7, 7,
+	7, 7, 7, 7, 7, 7, 7, 7,
+	7, 7, 7, 7, 7, 7, 7, 7,
+	7, 7, 7, 7,
 };
 
 static struct map_desc da850_io_desc[] = {
@@ -739,7 +651,7 @@ static const struct davinci_soc_info davinci_soc_info_da850 = {
 	.pinmux_pins		= da850_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(da850_pins),
 	.intc_base		= DA8XX_CP_INTC_BASE,
-	.intc_irq_prios		= da850_default_priorities,
+	.intc_irq_prios		= da850_cp_intc_prios,
 	.intc_irq_num		= DA850_N_CP_INTC_IRQ,
 	.timer_info		= &da850_timer_info,
 	.emac_pdata		= &da8xx_emac_pdata,
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 03ce5df28d87..a31f56c70d1d 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -154,69 +154,15 @@ MUX_CFG(DM355,	VIN_CINH_EN,	0,   8,     3,    3,	 false)
 #endif
 };
 
-static u8 dm355_default_priorities[DAVINCI_N_AINTC_IRQ] = {
-	[IRQ_DM355_CCDC_VDINT0]		= 2,
-	[IRQ_DM355_CCDC_VDINT1]		= 6,
-	[IRQ_DM355_CCDC_VDINT2]		= 6,
-	[IRQ_DM355_IPIPE_HST]		= 6,
-	[IRQ_DM355_H3AINT]		= 6,
-	[IRQ_DM355_IPIPE_SDR]		= 6,
-	[IRQ_DM355_IPIPEIFINT]		= 6,
-	[IRQ_DM355_OSDINT]		= 7,
-	[IRQ_DM355_VENCINT]		= 6,
-	[IRQ_ASQINT]			= 6,
-	[IRQ_IMXINT]			= 6,
-	[IRQ_USBINT]			= 4,
-	[IRQ_DM355_RTOINT]		= 4,
-	[IRQ_DM355_UARTINT2]		= 7,
-	[IRQ_DM355_TINT6]		= 7,
-	[IRQ_CCINT0]			= 5,	/* dma */
-	[IRQ_CCERRINT]			= 5,	/* dma */
-	[IRQ_TCERRINT0]			= 5,	/* dma */
-	[IRQ_TCERRINT]			= 5,	/* dma */
-	[IRQ_DM355_SPINT2_1]		= 7,
-	[IRQ_DM355_TINT7]		= 4,
-	[IRQ_DM355_SDIOINT0]		= 7,
-	[IRQ_MBXINT]			= 7,
-	[IRQ_MBRINT]			= 7,
-	[IRQ_MMCINT]			= 7,
-	[IRQ_DM355_MMCINT1]		= 7,
-	[IRQ_DM355_PWMINT3]		= 7,
-	[IRQ_DDRINT]			= 7,
-	[IRQ_AEMIFINT]			= 7,
-	[IRQ_DM355_SDIOINT1]		= 4,
-	[IRQ_TINT0_TINT12]		= 2,	/* clockevent */
-	[IRQ_TINT0_TINT34]		= 2,	/* clocksource */
-	[IRQ_TINT1_TINT12]		= 7,	/* DSP timer */
-	[IRQ_TINT1_TINT34]		= 7,	/* system tick */
-	[IRQ_PWMINT0]			= 7,
-	[IRQ_PWMINT1]			= 7,
-	[IRQ_PWMINT2]			= 7,
-	[IRQ_I2C]			= 3,
-	[IRQ_UARTINT0]			= 3,
-	[IRQ_UARTINT1]			= 3,
-	[IRQ_DM355_SPINT0_0]		= 3,
-	[IRQ_DM355_SPINT0_1]		= 3,
-	[IRQ_DM355_GPIO0]		= 3,
-	[IRQ_DM355_GPIO1]		= 7,
-	[IRQ_DM355_GPIO2]		= 4,
-	[IRQ_DM355_GPIO3]		= 4,
-	[IRQ_DM355_GPIO4]		= 7,
-	[IRQ_DM355_GPIO5]		= 7,
-	[IRQ_DM355_GPIO6]		= 7,
-	[IRQ_DM355_GPIO7]		= 7,
-	[IRQ_DM355_GPIO8]		= 7,
-	[IRQ_DM355_GPIO9]		= 7,
-	[IRQ_DM355_GPIOBNK0]		= 7,
-	[IRQ_DM355_GPIOBNK1]		= 7,
-	[IRQ_DM355_GPIOBNK2]		= 7,
-	[IRQ_DM355_GPIOBNK3]		= 7,
-	[IRQ_DM355_GPIOBNK4]		= 7,
-	[IRQ_DM355_GPIOBNK5]		= 7,
-	[IRQ_DM355_GPIOBNK6]		= 7,
-	[IRQ_COMMTX]			= 7,
-	[IRQ_COMMRX]			= 7,
-	[IRQ_EMUINT]			= 7,
+static u8 dm355_aintc_prios[] = {
+	2, 6, 6, 6, 6, 6, 6, 7,
+	6, 6, 6, 4, 4, 7, 7, 5,
+	5, 5, 5, 7, 4, 7, 7, 7,
+	7, 7, 7, 7, 7, 4, 2, 2,
+	7, 7, 7, 7, 7, 3, 3, 3,
+	3, 3, 3, 7, 4, 4, 7, 7,
+	7, 7, 7, 7, 7, 7, 7, 7,
+	7, 7, 7, 7, 7, 7, 0, 0,
 };
 
 /*----------------------------------------------------------------------*/
@@ -705,7 +651,7 @@ static const struct davinci_soc_info davinci_soc_info_dm355 = {
 	.pinmux_pins		= dm355_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(dm355_pins),
 	.intc_base		= DAVINCI_ARM_INTC_BASE,
-	.intc_irq_prios		= dm355_default_priorities,
+	.intc_irq_prios		= dm355_aintc_prios,
 	.intc_irq_num		= DAVINCI_N_AINTC_IRQ,
 	.timer_info		= &dm355_timer_info,
 	.sram_dma		= 0x00010000,
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 3e034f0478d2..42b2012d25cc 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -382,71 +382,15 @@ static struct platform_device dm365_mdio_device = {
 	.resource	= dm365_mdio_resources,
 };
 
-static u8 dm365_default_priorities[DAVINCI_N_AINTC_IRQ] = {
-	[IRQ_VDINT0]			= 2,
-	[IRQ_VDINT1]			= 6,
-	[IRQ_VDINT2]			= 6,
-	[IRQ_HISTINT]			= 6,
-	[IRQ_H3AINT]			= 6,
-	[IRQ_PRVUINT]			= 6,
-	[IRQ_RSZINT]			= 6,
-	[IRQ_DM365_INSFINT]		= 7,
-	[IRQ_VENCINT]			= 6,
-	[IRQ_ASQINT]			= 6,
-	[IRQ_IMXINT]			= 6,
-	[IRQ_DM365_IMCOPINT]		= 4,
-	[IRQ_USBINT]			= 4,
-	[IRQ_DM365_RTOINT]		= 7,
-	[IRQ_DM365_TINT5]		= 7,
-	[IRQ_DM365_TINT6]		= 5,
-	[IRQ_CCINT0]			= 5,
-	[IRQ_CCERRINT]			= 5,
-	[IRQ_TCERRINT0]			= 5,
-	[IRQ_TCERRINT]			= 7,
-	[IRQ_PSCIN]			= 4,
-	[IRQ_DM365_SPINT2_1]		= 7,
-	[IRQ_DM365_TINT7]		= 7,
-	[IRQ_DM365_SDIOINT0]		= 7,
-	[IRQ_MBXINT]			= 7,
-	[IRQ_MBRINT]			= 7,
-	[IRQ_MMCINT]			= 7,
-	[IRQ_DM365_MMCINT1]		= 7,
-	[IRQ_DM365_PWMINT3]		= 7,
-	[IRQ_AEMIFINT]			= 2,
-	[IRQ_DM365_SDIOINT1]		= 2,
-	[IRQ_TINT0_TINT12]		= 7,
-	[IRQ_TINT0_TINT34]		= 7,
-	[IRQ_TINT1_TINT12]		= 7,
-	[IRQ_TINT1_TINT34]		= 7,
-	[IRQ_PWMINT0]			= 7,
-	[IRQ_PWMINT1]			= 3,
-	[IRQ_PWMINT2]			= 3,
-	[IRQ_I2C]			= 3,
-	[IRQ_UARTINT0]			= 3,
-	[IRQ_UARTINT1]			= 3,
-	[IRQ_DM365_RTCINT]		= 3,
-	[IRQ_DM365_SPIINT0_0]		= 3,
-	[IRQ_DM365_SPIINT3_0]		= 3,
-	[IRQ_DM365_GPIO0]		= 3,
-	[IRQ_DM365_GPIO1]		= 7,
-	[IRQ_DM365_GPIO2]		= 4,
-	[IRQ_DM365_GPIO3]		= 4,
-	[IRQ_DM365_GPIO4]		= 7,
-	[IRQ_DM365_GPIO5]		= 7,
-	[IRQ_DM365_GPIO6]		= 7,
-	[IRQ_DM365_GPIO7]		= 7,
-	[IRQ_DM365_EMAC_RXTHRESH]	= 7,
-	[IRQ_DM365_EMAC_RXPULSE]	= 7,
-	[IRQ_DM365_EMAC_TXPULSE]	= 7,
-	[IRQ_DM365_EMAC_MISCPULSE]	= 7,
-	[IRQ_DM365_GPIO12]		= 7,
-	[IRQ_DM365_GPIO13]		= 7,
-	[IRQ_DM365_GPIO14]		= 7,
-	[IRQ_DM365_GPIO15]		= 7,
-	[IRQ_DM365_KEYINT]		= 7,
-	[IRQ_DM365_TCERRINT2]		= 7,
-	[IRQ_DM365_TCERRINT3]		= 7,
-	[IRQ_DM365_EMUINT]		= 7,
+static u8 dm365_aintc_prios[] = {
+	2, 6, 6, 6, 6, 6, 6, 7,
+	6, 6, 6, 4, 4, 7, 7, 5,
+	5, 5, 5, 7, 4, 7, 7, 7,
+	7, 7, 7, 7, 7, 2, 2, 7,
+	7, 7, 7, 7, 3, 3, 3, 3,
+	3, 3, 3, 3, 3, 7, 4, 4,
+	7, 7, 7, 7, 7, 7, 7, 7,
+	7, 7, 7, 7, 7, 7, 7, 7,
 };
 
 /* Four Transfer Controllers on DM365 */
@@ -722,7 +666,7 @@ static const struct davinci_soc_info davinci_soc_info_dm365 = {
 	.pinmux_pins		= dm365_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(dm365_pins),
 	.intc_base		= DAVINCI_ARM_INTC_BASE,
-	.intc_irq_prios		= dm365_default_priorities,
+	.intc_irq_prios		= dm365_aintc_prios,
 	.intc_irq_num		= DAVINCI_N_AINTC_IRQ,
 	.timer_info		= &dm365_timer_info,
 	.emac_pdata		= &dm365_emac_pdata,
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 66bab4782c62..bf7ebdcf6c18 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -147,71 +147,15 @@ MUX_CFG(DM644X, LFLDEN,		0,   25,    1,	  1,	 false)
 };
 
 /* FIQ are pri 0-1; otherwise 2-7, with 7 lowest priority */
-static u8 dm644x_default_priorities[DAVINCI_N_AINTC_IRQ] = {
-	[IRQ_VDINT0]		= 2,
-	[IRQ_VDINT1]		= 6,
-	[IRQ_VDINT2]		= 6,
-	[IRQ_HISTINT]		= 6,
-	[IRQ_H3AINT]		= 6,
-	[IRQ_PRVUINT]		= 6,
-	[IRQ_RSZINT]		= 6,
-	[7]			= 7,
-	[IRQ_VENCINT]		= 6,
-	[IRQ_ASQINT]		= 6,
-	[IRQ_IMXINT]		= 6,
-	[IRQ_VLCDINT]		= 6,
-	[IRQ_USBINT]		= 4,
-	[IRQ_EMACINT]		= 4,
-	[14]			= 7,
-	[15]			= 7,
-	[IRQ_CCINT0]		= 5,	/* dma */
-	[IRQ_CCERRINT]		= 5,	/* dma */
-	[IRQ_TCERRINT0]		= 5,	/* dma */
-	[IRQ_TCERRINT]		= 5,	/* dma */
-	[IRQ_PSCIN]		= 7,
-	[21]			= 7,
-	[IRQ_IDE]		= 4,
-	[23]			= 7,
-	[IRQ_MBXINT]		= 7,
-	[IRQ_MBRINT]		= 7,
-	[IRQ_MMCINT]		= 7,
-	[IRQ_SDIOINT]		= 7,
-	[28]			= 7,
-	[IRQ_DDRINT]		= 7,
-	[IRQ_AEMIFINT]		= 7,
-	[IRQ_VLQINT]		= 4,
-	[IRQ_TINT0_TINT12]	= 2,	/* clockevent */
-	[IRQ_TINT0_TINT34]	= 2,	/* clocksource */
-	[IRQ_TINT1_TINT12]	= 7,	/* DSP timer */
-	[IRQ_TINT1_TINT34]	= 7,	/* system tick */
-	[IRQ_PWMINT0]		= 7,
-	[IRQ_PWMINT1]		= 7,
-	[IRQ_PWMINT2]		= 7,
-	[IRQ_I2C]		= 3,
-	[IRQ_UARTINT0]		= 3,
-	[IRQ_UARTINT1]		= 3,
-	[IRQ_UARTINT2]		= 3,
-	[IRQ_SPINT0]		= 3,
-	[IRQ_SPINT1]		= 3,
-	[45]			= 7,
-	[IRQ_DSP2ARM0]		= 4,
-	[IRQ_DSP2ARM1]		= 4,
-	[IRQ_GPIO0]		= 7,
-	[IRQ_GPIO1]		= 7,
-	[IRQ_GPIO2]		= 7,
-	[IRQ_GPIO3]		= 7,
-	[IRQ_GPIO4]		= 7,
-	[IRQ_GPIO5]		= 7,
-	[IRQ_GPIO6]		= 7,
-	[IRQ_GPIO7]		= 7,
-	[IRQ_GPIOBNK0]		= 7,
-	[IRQ_GPIOBNK1]		= 7,
-	[IRQ_GPIOBNK2]		= 7,
-	[IRQ_GPIOBNK3]		= 7,
-	[IRQ_GPIOBNK4]		= 7,
-	[IRQ_COMMTX]		= 7,
-	[IRQ_COMMRX]		= 7,
-	[IRQ_EMUINT]		= 7,
+static u8 dm644x_aintc_prios[] = {
+	2, 6, 6, 6, 6, 6, 6, 7,
+	6, 6, 6, 6, 4, 4, 7, 7,
+	5, 5, 5, 5, 7, 7, 4, 7,
+	7, 7, 7, 7, 7, 7, 7, 4,
+	2, 2, 7, 7, 7, 7, 7, 3,
+	3, 3, 3, 3, 3, 7, 4, 4,
+	7, 7, 7, 7, 7, 7, 7, 7,
+	7, 7, 7, 7, 7, 7, 7, 7,
 };
 
 /*----------------------------------------------------------------------*/
@@ -646,7 +590,7 @@ static const struct davinci_soc_info davinci_soc_info_dm644x = {
 	.pinmux_pins		= dm644x_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(dm644x_pins),
 	.intc_base		= DAVINCI_ARM_INTC_BASE,
-	.intc_irq_prios 	= dm644x_default_priorities,
+	.intc_irq_prios		= dm644x_aintc_prios,
 	.intc_irq_num		= DAVINCI_N_AINTC_IRQ,
 	.timer_info		= &dm644x_timer_info,
 	.emac_pdata		= &dm644x_emac_pdata,
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 45efa715a2c1..64b4ae5a4202 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -146,71 +146,15 @@ MUX_CFG(DM646X, PTSIMUX_SERIAL,		0,   16,    3,    3,	 true)
 #endif
 };
 
-static u8 dm646x_default_priorities[DAVINCI_N_AINTC_IRQ] = {
-	[IRQ_DM646X_VP_VERTINT0]        = 7,
-	[IRQ_DM646X_VP_VERTINT1]        = 7,
-	[IRQ_DM646X_VP_VERTINT2]        = 7,
-	[IRQ_DM646X_VP_VERTINT3]        = 7,
-	[IRQ_DM646X_VP_ERRINT]          = 7,
-	[IRQ_DM646X_RESERVED_1]         = 7,
-	[IRQ_DM646X_RESERVED_2]         = 7,
-	[IRQ_DM646X_WDINT]              = 7,
-	[IRQ_DM646X_CRGENINT0]          = 7,
-	[IRQ_DM646X_CRGENINT1]          = 7,
-	[IRQ_DM646X_TSIFINT0]           = 7,
-	[IRQ_DM646X_TSIFINT1]           = 7,
-	[IRQ_DM646X_VDCEINT]            = 7,
-	[IRQ_DM646X_USBINT]             = 7,
-	[IRQ_DM646X_USBDMAINT]          = 7,
-	[IRQ_DM646X_PCIINT]             = 7,
-	[IRQ_CCINT0]                    = 7,    /* dma */
-	[IRQ_CCERRINT]                  = 7,    /* dma */
-	[IRQ_TCERRINT0]                 = 7,    /* dma */
-	[IRQ_TCERRINT]                  = 7,    /* dma */
-	[IRQ_DM646X_TCERRINT2]          = 7,
-	[IRQ_DM646X_TCERRINT3]          = 7,
-	[IRQ_DM646X_IDE]                = 7,
-	[IRQ_DM646X_HPIINT]             = 7,
-	[IRQ_DM646X_EMACRXTHINT]        = 7,
-	[IRQ_DM646X_EMACRXINT]          = 7,
-	[IRQ_DM646X_EMACTXINT]          = 7,
-	[IRQ_DM646X_EMACMISCINT]        = 7,
-	[IRQ_DM646X_MCASP0TXINT]        = 7,
-	[IRQ_DM646X_MCASP0RXINT]        = 7,
-	[IRQ_DM646X_RESERVED_3]         = 7,
-	[IRQ_DM646X_MCASP1TXINT]        = 7,
-	[IRQ_TINT0_TINT12]              = 7,    /* clockevent */
-	[IRQ_TINT0_TINT34]              = 7,    /* clocksource */
-	[IRQ_TINT1_TINT12]              = 7,    /* DSP timer */
-	[IRQ_TINT1_TINT34]              = 7,    /* system tick */
-	[IRQ_PWMINT0]                   = 7,
-	[IRQ_PWMINT1]                   = 7,
-	[IRQ_DM646X_VLQINT]             = 7,
-	[IRQ_I2C]                       = 7,
-	[IRQ_UARTINT0]                  = 7,
-	[IRQ_UARTINT1]                  = 7,
-	[IRQ_DM646X_UARTINT2]           = 7,
-	[IRQ_DM646X_SPINT0]             = 7,
-	[IRQ_DM646X_SPINT1]             = 7,
-	[IRQ_DM646X_DSP2ARMINT]         = 7,
-	[IRQ_DM646X_RESERVED_4]         = 7,
-	[IRQ_DM646X_PSCINT]             = 7,
-	[IRQ_DM646X_GPIO0]              = 7,
-	[IRQ_DM646X_GPIO1]              = 7,
-	[IRQ_DM646X_GPIO2]              = 7,
-	[IRQ_DM646X_GPIO3]              = 7,
-	[IRQ_DM646X_GPIO4]              = 7,
-	[IRQ_DM646X_GPIO5]              = 7,
-	[IRQ_DM646X_GPIO6]              = 7,
-	[IRQ_DM646X_GPIO7]              = 7,
-	[IRQ_DM646X_GPIOBNK0]           = 7,
-	[IRQ_DM646X_GPIOBNK1]           = 7,
-	[IRQ_DM646X_GPIOBNK2]           = 7,
-	[IRQ_DM646X_DDRINT]             = 7,
-	[IRQ_DM646X_AEMIFINT]           = 7,
-	[IRQ_COMMTX]                    = 7,
-	[IRQ_COMMRX]                    = 7,
-	[IRQ_EMUINT]                    = 7,
+static u8 dm646x_aintc_prios[] = {
+	7, 7, 7, 7, 7, 7, 7, 7,
+	7, 7, 7, 7, 7, 7, 7, 7,
+	7, 7, 7, 7, 7, 7, 7, 7,
+	7, 7, 7, 7, 7, 7, 7, 7,
+	7, 7, 7, 7, 7, 7, 7, 7,
+	7, 7, 7, 7, 7, 7, 7, 7,
+	7, 7, 7, 7, 7, 7, 7, 7,
+	7, 7, 7, 7, 7, 7, 7, 7,
 };
 
 /*----------------------------------------------------------------------*/
@@ -586,7 +530,7 @@ static const struct davinci_soc_info davinci_soc_info_dm646x = {
 	.pinmux_pins		= dm646x_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(dm646x_pins),
 	.intc_base		= DAVINCI_ARM_INTC_BASE,
-	.intc_irq_prios		= dm646x_default_priorities,
+	.intc_irq_prios		= dm646x_aintc_prios,
 	.intc_irq_num		= DAVINCI_N_AINTC_IRQ,
 	.timer_info		= &dm646x_timer_info,
 	.emac_pdata		= &dm646x_emac_pdata,
-- 
2.20.1


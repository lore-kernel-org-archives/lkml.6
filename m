Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D47C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD43120658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZFuR7Fa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD43120658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbeH3WIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:08:51 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35673 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbeH3WIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:08:49 -0400
Received: by mail-lj1-f194.google.com with SMTP id p10-v6so8033335ljg.2;
        Thu, 30 Aug 2018 11:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wxnbvPyqV9MwtYpRFTERECdapTydYiOKIVc11OZOZ1g=;
        b=TZFuR7FaQcOV/na0BmDQRYbWwKbmhq2PMpeO/OOVSdvqtVCtgCI7HGUS8wGgOTqpTG
         xiGoecj/+SEZStzrteI9Bta2afXRe6dGC2MD9xhLudDe11c7cDHrWWAjtaVWDvsMlJF0
         DUDsw+28zG4rV0Bzb2sJoHf1jvRHZLoK33fRGaOBjyLIUDVglPEyAbamk9rhaysNoZus
         q+9iBg/lQlcBiBKWtPXBpV4eJag3PwraT56iHNxKakPB2/H4WJ84l6woLPyGke/+bnug
         r0/ZH/RW9wNmktfjI6AKeoCeDnPrJLnHdo/0GJkVCgkUPCZGkxJKuQJ8EMIeSncS/TP4
         lQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wxnbvPyqV9MwtYpRFTERECdapTydYiOKIVc11OZOZ1g=;
        b=nU1eO6HrjMQrV6iGfJ92kh5j8ZbKZSSvayigmCRdmZmpyuVCmSksNNl9l9kNSDEUUk
         mtIm8PeWPyuYGFEn7LU5O8LNx2XfBuly+S/HV6hfgaOaPvJ6WqK4/N89pTbJSRtBG7VW
         bO4HqcjTnYHa3TIsCD0LB+SbjuYQmRCVh3dkHmiEIfyBZ/fYRAg3iic7CgNWotz7tjln
         0GnSEcb7PfN7VGmRAmLG2AKFeCqFQf15olTAI+UGL9+K8PNydCptv+xDz3uZmAAmjrXZ
         en8buKHQ/Y3wTYBmjbGnKm8iDD+kEyCvb22C5YqFeQ/8eTc4hjeUlPtuQLaTiYGawSHE
         Ojwg==
X-Gm-Message-State: APzg51Bz8jDGjUf1O1RkDf5Q3MmLT5F0aJaLVkP/OwhhIoN5MmUKfl2u
        Ib+WCzuypJLOGiyqfteI2Qk=
X-Google-Smtp-Source: ANB0Vdb8b97qS7fwtXan4rU2YGPlpcWmk56YL4hQGawOliBBQp1+rozAC8yfsFKESFnQ/P953m2M1A==
X-Received: by 2002:a2e:6a04:: with SMTP id f4-v6mr8472532ljc.109.1535652326528;
        Thu, 30 Aug 2018 11:05:26 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id 13-v6sm1420789lfy.87.2018.08.30.11.05.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 11:05:26 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/8] ARM: tegra: Don't apply CPU erratas in insecure mode
Date:   Thu, 30 Aug 2018 21:04:18 +0300
Message-Id: <20180830180421.6415-6-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180830180421.6415-1-digetx@gmail.com>
References: <20180830180421.6415-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU isn't allowed to touch secure registers while running under secure
monitor. Hence skip applying of CPU erratas in the reset handler if
Trusted Foundations firmware presents.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/reset-handler.S | 24 ++++++++++++------------
 arch/arm/mach-tegra/reset.c         |  3 +++
 arch/arm/mach-tegra/reset.h         |  9 +++++++--
 arch/arm/mach-tegra/sleep-tegra20.S |  4 ++++
 4 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index 805f306fa6f7..a9f13230da2f 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -29,8 +29,6 @@
 
 #define PMC_SCRATCH41	0x140
 
-#define RESET_DATA(x)	((TEGRA_RESET_##x)*4)
-
 #ifdef CONFIG_PM_SLEEP
 /*
  *	tegra_resume
@@ -121,6 +119,12 @@ ENTRY(__tegra_cpu_reset_handler)
 	cpsid	aif, 0x13			@ SVC mode, interrupts disabled
 
 	tegra_get_soc_id TEGRA_APB_MISC_BASE, r6
+
+	adr	r12, __tegra_cpu_reset_handler_data
+	ldr	r5, [r12, #RESET_DATA(TF_PRESENT)]
+	cmp	r5, #0
+	bne	after_errata
+
 #ifdef CONFIG_ARCH_TEGRA_2x_SOC
 t20_check:
 	cmp	r6, #TEGRA20
@@ -155,7 +159,6 @@ after_errata:
 	and	r10, r10, #0x3			@ R10 = CPU number
 	mov	r11, #1
 	mov	r11, r11, lsl r10  		@ R11 = CPU mask
-	adr	r12, __tegra_cpu_reset_handler_data
 
 #ifdef CONFIG_SMP
 	/* Does the OS know about this CPU? */
@@ -169,10 +172,9 @@ after_errata:
 	cmp	r6, #TEGRA20
 	bne	1f
 	/* If not CPU0, don't let CPU0 reset CPU1 now that CPU1 is coming up. */
-	mov32	r5, TEGRA_IRAM_BASE + TEGRA_IRAM_RESET_HANDLER_OFFSET
 	mov	r0, #CPU_NOT_RESETTABLE
 	cmp	r10, #0
-	strneb	r0, [r5, #__tegra20_cpu1_resettable_status_offset]
+	strneb	r0, [r12, #RESET_DATA(RESETTABLE_STATUS)]
 1:
 #endif
 
@@ -277,14 +279,12 @@ ENDPROC(__tegra_cpu_reset_handler)
 	.align L1_CACHE_SHIFT
 	.type	__tegra_cpu_reset_handler_data, %object
 	.globl	__tegra_cpu_reset_handler_data
+	.globl	__tegra_cpu_reset_handler_data_offset
+	.equ	__tegra_cpu_reset_handler_data_offset, \
+					. - __tegra_cpu_reset_handler_start
 __tegra_cpu_reset_handler_data:
-	.rept	TEGRA_RESET_DATA_SIZE
-	.long	0
+	.rept   TEGRA_RESET_DATA_SIZE
+	.long   0
 	.endr
-	.globl	__tegra20_cpu1_resettable_status_offset
-	.equ	__tegra20_cpu1_resettable_status_offset, \
-					. - __tegra_cpu_reset_handler_start
-	.byte	0
 	.align L1_CACHE_SHIFT
-
 ENTRY(__tegra_cpu_reset_handler_end)
diff --git a/arch/arm/mach-tegra/reset.c b/arch/arm/mach-tegra/reset.c
index dc558892753c..b02ae7699842 100644
--- a/arch/arm/mach-tegra/reset.c
+++ b/arch/arm/mach-tegra/reset.c
@@ -24,6 +24,7 @@
 #include <asm/cacheflush.h>
 #include <asm/firmware.h>
 #include <asm/hardware/cache-l2x0.h>
+#include <asm/trusted_foundations.h>
 
 #include "iomap.h"
 #include "irammap.h"
@@ -89,6 +90,8 @@ static void __init tegra_cpu_reset_handler_enable(void)
 
 void __init tegra_cpu_reset_handler_init(void)
 {
+	__tegra_cpu_reset_handler_data[TEGRA_RESET_TF_PRESENT] =
+		trusted_foundations_registered();
 
 #ifdef CONFIG_SMP
 	__tegra_cpu_reset_handler_data[TEGRA_RESET_MASK_PRESENT] =
diff --git a/arch/arm/mach-tegra/reset.h b/arch/arm/mach-tegra/reset.h
index 9c479c7925b8..db0e6b3097ab 100644
--- a/arch/arm/mach-tegra/reset.h
+++ b/arch/arm/mach-tegra/reset.h
@@ -25,7 +25,11 @@
 #define TEGRA_RESET_STARTUP_SECONDARY	3
 #define TEGRA_RESET_STARTUP_LP2		4
 #define TEGRA_RESET_STARTUP_LP1		5
-#define TEGRA_RESET_DATA_SIZE		6
+#define TEGRA_RESET_RESETTABLE_STATUS	6
+#define TEGRA_RESET_TF_PRESENT		7
+#define TEGRA_RESET_DATA_SIZE		8
+
+#define RESET_DATA(x)	((TEGRA_RESET_##x)*4)
 
 #ifndef __ASSEMBLY__
 
@@ -49,7 +53,8 @@ void __tegra_cpu_reset_handler_end(void);
 	 (u32)__tegra_cpu_reset_handler_start)))
 #define tegra20_cpu1_resettable_status \
 	(IO_ADDRESS(TEGRA_IRAM_BASE + TEGRA_IRAM_RESET_HANDLER_OFFSET + \
-	 (u32)__tegra20_cpu1_resettable_status_offset))
+	((u32)&__tegra_cpu_reset_handler_data[TEGRA_RESET_RESETTABLE_STATUS] - \
+	 (u32)__tegra_cpu_reset_handler_start)))
 #endif
 
 #define tegra_cpu_reset_handler_offset \
diff --git a/arch/arm/mach-tegra/sleep-tegra20.S b/arch/arm/mach-tegra/sleep-tegra20.S
index 5c8e638ee51a..11f423e4a263 100644
--- a/arch/arm/mach-tegra/sleep-tegra20.S
+++ b/arch/arm/mach-tegra/sleep-tegra20.S
@@ -28,6 +28,7 @@
 #include <asm/cache.h>
 
 #include "irammap.h"
+#include "reset.h"
 #include "sleep.h"
 
 #define EMC_CFG				0xc
@@ -54,6 +55,9 @@
 #define APB_MISC_XM2CFGCPADCTRL2	0x8e4
 #define APB_MISC_XM2CFGDPADCTRL2	0x8e8
 
+#define __tegra20_cpu1_resettable_status_offset \
+	(__tegra_cpu_reset_handler_data_offset + RESET_DATA(RESETTABLE_STATUS))
+
 .macro pll_enable, rd, r_car_base, pll_base
 	ldr	\rd, [\r_car_base, #\pll_base]
 	tst	\rd, #(1 << 30)
-- 
2.18.0


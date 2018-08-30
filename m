Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E75C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FE0C2082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjAnS42t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE0C2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbeH3W7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:59:12 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40680 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbeH3W7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:59:11 -0400
Received: by mail-lj1-f193.google.com with SMTP id j19-v6so8122608ljc.7;
        Thu, 30 Aug 2018 11:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kLu2KmUTdB/E0+/k5FBpbwoCSyX3TeCDbGTo+U0oelw=;
        b=FjAnS42tQAE9FnIlDP7HH0Bs99cv4ua/88+/x37PSNjRJT6vRB/zYmHK/oF16xaPQw
         jEEOTEtDRbqzWuJ0TDWo5+yZ7gmM3V3ZOBB5P7VwEEUFxfJFEe1wk+I+hft4CUAaayHk
         XKY0iClWwEkRi3XWryt4FqBvB8FcQ0SCuXwRVB54vJQ+yn1LwixS2gn8+t9P1JWUX3SO
         XTqNlXpeNhDDA2t35FgS0Q4FR7gAXhv1auhdOMC/uD+l4M/OhtuQjzDKLPxXtiNCn4Y6
         5SBcAJMNZ44SSDX8LRqJpp2Bb0NXZ79aFWp/DyIomhglqyECxnP0fzpxsZ/1WMYABl3o
         ljiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kLu2KmUTdB/E0+/k5FBpbwoCSyX3TeCDbGTo+U0oelw=;
        b=cni71jWDXAxtlzPcfgUQxsN6YVFIOBu5fPlQIXXZBr2hN0o7zXGg7NqYkcH34YDfs/
         pwkRCF4h04crXekymUe08gaban27RIZ5AA+RAYUxYXzKRgePzF8cWBw40/xFORwwD7TB
         u4v/02ggWHhwYq38cN7LQmPeRGT/Ro1Lq21trrwITrY6dUIgYCmmM4CCTJyFC6W3L2xh
         x4EEdIPLmzt4e/moA5aX3mEElzI3nscIJ1Jwt71/89vxGORdb46Kj9uJH5Zq90NkcxYY
         53vIflVNSFBudYFHtwyBH8DXITovwMzxPSEKBUwHprSxVI2C4Y4EqKWphKNcknAI8/0A
         U66Q==
X-Gm-Message-State: APzg51CX/zM/YmTwHRNtsq5HqCszKZ+cQSF7gdgRp2CnXger9zhjJI1L
        Sb+FR8ZXV0O9MoIBHqrrKro=
X-Google-Smtp-Source: ANB0VdY+/o1eARxHKakajvILv9AJXK6kvWVDmocUunKBswLGnuN0cEH9Yhd1pf5NrRGWmI+Y4gArWg==
X-Received: by 2002:a2e:44c6:: with SMTP id b67-v6mr8034789ljf.102.1535655335690;
        Thu, 30 Aug 2018 11:55:35 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id u28-v6sm1373087ljd.61.2018.08.30.11.55.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 11:55:35 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/4] ARM: tegra: Restore memory arbitration on resume from LP1 on Tegra30+
Date:   Thu, 30 Aug 2018 21:54:03 +0300
Message-Id: <20180830185404.7224-4-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180830185404.7224-1-digetx@gmail.com>
References: <20180830185404.7224-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The external memory arbitration configuration is getting reset after
memory entering into self-refresh mode, it shall be restored on the
exit. Note that MC_EMEM_ARB_CFG register is shadowed and latching
happens on the EMC timing update. This fixes 2x GPU performance
degradation after resuming from LP1 on Tegra30.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/iomap.h         |  9 +++++++++
 arch/arm/mach-tegra/sleep-tegra30.S | 21 +++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm/mach-tegra/iomap.h b/arch/arm/mach-tegra/iomap.h
index 9e5b2f869fc8..9bc291e76887 100644
--- a/arch/arm/mach-tegra/iomap.h
+++ b/arch/arm/mach-tegra/iomap.h
@@ -79,15 +79,24 @@
 #define TEGRA_PMC_BASE			0x7000E400
 #define TEGRA_PMC_SIZE			SZ_256
 
+#define TEGRA_MC_BASE			0x7000F000
+#define TEGRA_MC_SIZE			SZ_1K
+
 #define TEGRA_EMC_BASE			0x7000F400
 #define TEGRA_EMC_SIZE			SZ_1K
 
+#define TEGRA114_MC_BASE		0x70019000
+#define TEGRA114_MC_SIZE		SZ_4K
+
 #define TEGRA_EMC0_BASE			0x7001A000
 #define TEGRA_EMC0_SIZE			SZ_2K
 
 #define TEGRA_EMC1_BASE			0x7001A800
 #define TEGRA_EMC1_SIZE			SZ_2K
 
+#define TEGRA124_MC_BASE		0x70019000
+#define TEGRA124_MC_SIZE		SZ_4K
+
 #define TEGRA124_EMC_BASE		0x7001B000
 #define TEGRA124_EMC_SIZE		SZ_2K
 
diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
index 99ac9c6dcf7c..828f6c37afde 100644
--- a/arch/arm/mach-tegra/sleep-tegra30.S
+++ b/arch/arm/mach-tegra/sleep-tegra30.S
@@ -44,6 +44,8 @@
 #define EMC_XM2VTTGENPADCTRL		0x310
 #define EMC_XM2VTTGENPADCTRL2		0x314
 
+#define MC_EMEM_ARB_CFG			0x90
+
 #define PMC_CTRL			0x0
 #define PMC_CTRL_SIDE_EFFECT_LP0 (1 << 14) /* enter LP0 when CPU pwr gated */
 
@@ -418,6 +420,22 @@ _pll_m_c_x_done:
 	movweq	r0, #:lower16:TEGRA124_EMC_BASE
 	movteq	r0, #:upper16:TEGRA124_EMC_BASE
 
+	cmp	r10, #TEGRA30
+	moveq	r2, #0x20
+	movweq	r4, #:lower16:TEGRA_MC_BASE
+	movteq	r4, #:upper16:TEGRA_MC_BASE
+	cmp	r10, #TEGRA114
+	moveq	r2, #0x34
+	movweq	r4, #:lower16:TEGRA114_MC_BASE
+	movteq	r4, #:upper16:TEGRA114_MC_BASE
+	cmp	r10, #TEGRA124
+	moveq	r2, #0x20
+	movweq	r4, #:lower16:TEGRA124_MC_BASE
+	movteq	r4, #:upper16:TEGRA124_MC_BASE
+
+	ldr	r1, [r5, r2]		@ restore MC_EMEM_ARB_CFG
+	str	r1, [r4, #MC_EMEM_ARB_CFG]
+
 exit_self_refresh:
 	ldr	r1, [r5, #0xC]		@ restore EMC_XM2VTTGENPADCTRL
 	str	r1, [r0, #EMC_XM2VTTGENPADCTRL]
@@ -546,6 +564,7 @@ tegra30_sdram_pad_address:
 	.word	TEGRA_PMC_BASE + PMC_IO_DPD_STATUS			@0x14
 	.word	TEGRA_CLK_RESET_BASE + CLK_RESET_CLK_SOURCE_MSELECT	@0x18
 	.word	TEGRA_CLK_RESET_BASE + CLK_RESET_SCLK_BURST		@0x1c
+	.word	TEGRA_MC_BASE + MC_EMEM_ARB_CFG				@0x20
 tegra30_sdram_pad_address_end:
 
 tegra114_sdram_pad_address:
@@ -562,6 +581,7 @@ tegra114_sdram_pad_address:
 	.word	TEGRA_EMC1_BASE + EMC_AUTO_CAL_INTERVAL			@0x28
 	.word	TEGRA_EMC1_BASE + EMC_XM2VTTGENPADCTRL			@0x2c
 	.word	TEGRA_EMC1_BASE + EMC_XM2VTTGENPADCTRL2			@0x30
+	.word	TEGRA114_MC_BASE + MC_EMEM_ARB_CFG			@0x34
 tegra114_sdram_pad_adress_end:
 
 tegra124_sdram_pad_address:
@@ -573,6 +593,7 @@ tegra124_sdram_pad_address:
 	.word	TEGRA_PMC_BASE + PMC_IO_DPD_STATUS			@0x14
 	.word	TEGRA_CLK_RESET_BASE + CLK_RESET_CLK_SOURCE_MSELECT	@0x18
 	.word	TEGRA_CLK_RESET_BASE + CLK_RESET_SCLK_BURST		@0x1c
+	.word	TEGRA124_MC_BASE + MC_EMEM_ARB_CFG			@0x20
 tegra124_sdram_pad_address_end:
 
 tegra30_sdram_pad_size:
-- 
2.18.0


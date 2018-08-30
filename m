Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86332C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF9A20658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsABhjJl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF9A20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbeH3WIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:08:51 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45926 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbeH3WIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:08:50 -0400
Received: by mail-lf1-f67.google.com with SMTP id r4-v6so7913180lff.12;
        Thu, 30 Aug 2018 11:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gzoUL224jX0LdcQuHl3QNpfOd2p4daBp/oJP6u+IJQI=;
        b=jsABhjJl5ipsNtvgdx0BajWqOKPpYsM/a6XaMVYu+7hd6M3jsaVqy7ZIXZHzBJUW4j
         UgafmTy9YBHe9eP0jGlnOhnnqVc2ywZi3zuKZNlpqaf8dxsowZF5gNuC7C5SmNQwmEvh
         5qY7iGDflaLNk+iyj2zf/jy4XetQnQf5oSqtU3DLQ6ChjQ29Nm20TpyWUlTWJWNYapAi
         fMh4Oz80TULiArj+jbk6Skzsrb16OL0W93RGHgRQRZbPxw7TBcgtx0CD7TZjR7XxtnZC
         mQnjE1mUZY7M+JgDVC/sHwMHIbTKYPfgo6viLYf9A/niX3bcYbz9QnShnSdx6gDWLD+B
         OOrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gzoUL224jX0LdcQuHl3QNpfOd2p4daBp/oJP6u+IJQI=;
        b=Axs8p5FZrCldWxh/2ZDDRXZQg6KDNQYi16AtybUed1ucjUI3hJ4IQ8uOHUSq5HcJDg
         GF23YHJd+638hDf1T+1xRpUyYuf5W5zoeZ5zbDbrydiOROqQZDNHL8gUliARFWHSwZ+r
         yBo/JGtXglgjSnr/FB/47prir16FSp6vqCHjgElNBVt/x2aInP6tUwlf0bvaVmU6aCvJ
         TlJ/ZV7MbLCEUo51Xjq4gEfqfB9mhxLIkA811VSuKZbYQHXqXpXIwy3XcRuBAqGX3FPb
         qEUkoCoBDL4rqsFO6BVOdHYLR42B028PFcgxRwAjSr+6QVKBM1QCZNofFNNR9cgNMpwP
         xnIQ==
X-Gm-Message-State: APzg51CGnD+4bLITguJdNzy+yPTLdp/HXoyCIfs+u+q3590/QvuXzAl4
        NE8HrmwbSaCnLg3JeyCQe2Q=
X-Google-Smtp-Source: ANB0VdaNiDWWi1NIzkr9GyFQ71be5Vr5ImkYyEJcF4crdGGp3fnfunSq3K9kNy8Z4NZ3PIX0jhQT4g==
X-Received: by 2002:a19:a345:: with SMTP id m66-v6mr2280499lfe.23.1535652328614;
        Thu, 30 Aug 2018 11:05:28 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id 13-v6sm1420789lfy.87.2018.08.30.11.05.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 11:05:28 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/8] ARM: tegra: Support L2 cache maintenance done via firmware
Date:   Thu, 30 Aug 2018 21:04:20 +0300
Message-Id: <20180830180421.6415-8-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180830180421.6415-1-digetx@gmail.com>
References: <20180830180421.6415-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trusted Foundations firmware require MMU to be enabled for L2 cache
maintenance on Tegra30, hence perform the maintenance early-late on
suspend-resume respectively.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/pm.c            | 36 +++++++++++++++++++++++++++++
 arch/arm/mach-tegra/reset-handler.S |  8 ++-----
 arch/arm/mach-tegra/sleep.S         |  4 ++++
 3 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 1ad5719779b0..66c8cd63dd86 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -38,6 +38,7 @@
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
 #include <asm/tlbflush.h>
+#include <asm/trusted_foundations.h>
 
 #include "iomap.h"
 #include "pm.h"
@@ -195,8 +196,27 @@ void tegra_idle_lp2_last(void)
 	cpu_cluster_pm_enter();
 	suspend_cpu_complex();
 
+	/*
+	 * L2 cache disabling using kernel API only allowed when all
+	 * secondary CPU's are offline. Cache have to be disabled early
+	 * if cache maintenance is done via Trusted Foundations firmware.
+	 * Note that CPUIDLE won't ever enter powergate on Tegra30 if any
+	 * of secondary CPU's is online and this is the LP2 codepath only
+	 * for Tegra20/30.
+	 */
+	if (trusted_foundations_registered())
+		outer_disable();
+
 	cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, &tegra_sleep_cpu);
 
+	/*
+	 * Resume L2 cache if it wasn't re-enabled early during resume,
+	 * which is the case for Tegra30 that has to re-enable the cache
+	 * via firmware call. In other cases cache is already enabled and
+	 * hence re-enabling is a no-op.
+	 */
+	outer_resume();
+
 	restore_cpu_complex();
 	cpu_cluster_pm_exit();
 }
@@ -340,8 +360,24 @@ static int tegra_suspend_enter(suspend_state_t state)
 		break;
 	}
 
+	/*
+	 * Cache have to be disabled early if cache maintenance is done
+	 * via Trusted Foundations firmware. Otherwise this is a no-op,
+	 * like on Tegra114+.
+	 */
+	if (trusted_foundations_registered())
+		outer_disable();
+
 	cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, tegra_sleep_func);
 
+	/*
+	 * Resume L2 cache if it wasn't re-enabled early during resume,
+	 * which is the case for Tegra30 that has to re-enable the cache
+	 * via firmware call. In other cases cache is already enabled and
+	 * hence re-enabling is a no-op.
+	 */
+	outer_resume();
+
 	switch (mode) {
 	case TEGRA_SUSPEND_LP1:
 		tegra_suspend_exit_lp1();
diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index 555c652f5a07..4973ea053bd7 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -69,7 +69,7 @@ ENTRY(tegra_resume)
 
 	mov32	r9, 0xc09
 	cmp	r8, r9
-	bne	end_ca9_scu_l2_resume
+	bne	end_ca9_scu_resume
 #ifdef CONFIG_HAVE_ARM_SCU
 	/* enable SCU */
 	mov32	r0, TEGRA_ARM_PERIF_BASE
@@ -78,11 +78,7 @@ ENTRY(tegra_resume)
 	str	r1, [r0]
 #endif
 
-#ifdef CONFIG_CACHE_L2X0
-	/* L2 cache resume & re-enable */
-	bl	l2c310_early_resume
-#endif
-end_ca9_scu_l2_resume:
+end_ca9_scu_resume:
 	mov32	r9, 0xc0f
 	cmp	r8, r9
 	bleq	tegra_init_l2_for_a15
diff --git a/arch/arm/mach-tegra/sleep.S b/arch/arm/mach-tegra/sleep.S
index 5e3496753df1..b96126fe5dc5 100644
--- a/arch/arm/mach-tegra/sleep.S
+++ b/arch/arm/mach-tegra/sleep.S
@@ -132,8 +132,12 @@ ENTRY(tegra_shut_off_mmu)
 #ifdef CONFIG_CACHE_L2X0
 	/* Disable L2 cache */
 	check_cpu_part_num 0xc09, r9, r10
+	retne	r0
+
 	movweq	r2, #:lower16:(TEGRA_ARM_PERIF_BASE + 0x3000)
 	movteq	r2, #:upper16:(TEGRA_ARM_PERIF_BASE + 0x3000)
+	ldr	r3, [r2, #L2X0_CTRL]
+	cmp	r3, #1
 	moveq	r3, #0
 	streq	r3, [r2, #L2X0_CTRL]
 #endif
-- 
2.18.0


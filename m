Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2982CC10F0B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F04842077B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="St7gh9wV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfBVSEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:04:42 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40899 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfBVSEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:04:39 -0500
Received: by mail-lf1-f65.google.com with SMTP id t14so2392911lfk.7;
        Fri, 22 Feb 2019 10:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9FtVEGiGy9Eakv2EeSbS97SgOgiiipvDTd5Smr8Hxk8=;
        b=St7gh9wVoFl5nVNEF7XevYlsh7CWBGCtaLEdD7i618b9+qT6ZKYKH1aF3ZNoluWh1/
         HqioaI3mtCa+LBdAGYg+Y6ki2uXGGJjnmvc7JjxBdYKK1JOb2m07Ex5Z7sdD4jBhk7Ty
         1wfRxkwATD0m0c1o6MsUCmwtCVIKuD0AkPszps7GRmTS020bzF9a4NhZoMqNrsu31ajq
         oEm/W1gcTortcteSaPulYUyovUzBm6LQKp5Lb5O04TJOvESBcfFJNCYWi+O4Ej8hU/rG
         RlWGG31HlM3sirj078bL5p+Z925LkH8EoVjdJHe2KZPXwwQpSL5f9nLB/WiabKELwMIO
         PNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9FtVEGiGy9Eakv2EeSbS97SgOgiiipvDTd5Smr8Hxk8=;
        b=PZhQeLgzPqKOFWXiaddpfUtWkfGgQs8/j5MGGzIr5ThIkxBkj6xNizfDnIiSuIUUFL
         0ALFfAeFXCbiK4DGqg2a52Efhb18PLGbQOefsUhdEyHgK0TBNxeguKJhAWmJNSWEoy+o
         Mzc+DycaQfX3YdITWLllhs1hzqFqKyouG5RMzLZM+fkwTh0oS8DVZ/Uq0VG2tSBcfBXL
         oUYFWzaTmg2yise8rkbn8MuxyIPUkdTfxxt0qUDQViP+12/RXgh7EaqzLaYGDEyIPZ26
         w8Mf0TGejMMsYHy/sPur7z8NlYNz5Vq0ezuq4kuTGDyqJ7UyN3vsWYkM5Ja65mRkLp8D
         xM3w==
X-Gm-Message-State: AHQUAuZyRD2F+xARgsTa4lrrHxIStY8fyRDu1kf/Ry7n3eY3z0pNwGXY
        HTkS+03hm1VI3mvqZ/xbIrwibfcY
X-Google-Smtp-Source: AHgI3IbY8A/8QovN6qa3sHWXJ+thDxhwQ85F6eCMCyU2yj8xr8inGqSF7SAVgFFwCFHHXISKtNlDGA==
X-Received: by 2002:a19:5611:: with SMTP id k17mr3144398lfb.168.1550858677334;
        Fri, 22 Feb 2019 10:04:37 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id j12sm721202lfg.47.2019.02.22.10.04.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 10:04:36 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 7/8] ARM: tegra: Support L2 cache maintenance done via firmware
Date:   Fri, 22 Feb 2019 20:59:25 +0300
Message-Id: <20190222175926.23366-8-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222175926.23366-1-digetx@gmail.com>
References: <20190222175926.23366-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trusted Foundations firmware require MMU to be enabled for L2 cache
maintenance on Tegra30, hence perform the maintenance early/late on
suspend-resume respectively.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/pm.c    | 36 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/sleep.S | 11 +++++++----
 2 files changed, 43 insertions(+), 4 deletions(-)

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
diff --git a/arch/arm/mach-tegra/sleep.S b/arch/arm/mach-tegra/sleep.S
index 5e3496753df1..0a8086d5a47a 100644
--- a/arch/arm/mach-tegra/sleep.S
+++ b/arch/arm/mach-tegra/sleep.S
@@ -132,10 +132,13 @@ ENTRY(tegra_shut_off_mmu)
 #ifdef CONFIG_CACHE_L2X0
 	/* Disable L2 cache */
 	check_cpu_part_num 0xc09, r9, r10
-	movweq	r2, #:lower16:(TEGRA_ARM_PERIF_BASE + 0x3000)
-	movteq	r2, #:upper16:(TEGRA_ARM_PERIF_BASE + 0x3000)
-	moveq	r3, #0
-	streq	r3, [r2, #L2X0_CTRL]
+	retne	r0
+
+	mov32	r2, TEGRA_ARM_PERIF_BASE + 0x3000
+	ldr	r3, [r2, #L2X0_CTRL]
+	mov	r9, #0
+	tst	r3, #1
+	strne	r9, [r2, #L2X0_CTRL]
 #endif
 	ret	r0
 ENDPROC(tegra_shut_off_mmu)
-- 
2.20.1


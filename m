Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D01C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 06:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845BD2146E
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 06:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="myxFxPMm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfBBGBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 01:01:34 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:47502 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfBBGBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 01:01:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mjnVo9RxzXKkHISKFxWB5mdXJD6N2moKgDMpsvDssZk=; b=myxFxPMmQ3nxx11aOg4IlahlmL
        EcUIV4PBesDYjiyMQcvg65h6prAwGZKmgjDdBOVo4KIyt9G7iWYVfVkRNTsDiO+dcEjNBLZPDtpMk
        LIBVEIj+y3GngxMmeOcuYcIJQdYyG1/sdPtqrHRioMVnlrZeFPwlS6vHXKKxwfMUaIKg=;
Received: from x2f7f150.dyn.telefonica.de ([2.247.241.80] helo=localhost)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gpoMh-0004F3-GR; Sat, 02 Feb 2019 07:01:19 +0100
Received: from andi by localhost with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gpoJy-0003Nx-2a; Sat, 02 Feb 2019 06:58:30 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     tony@atomide.com, linux@armlinux.org.uk, khilman@kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] omap3: give off mode enable a more prominent place
Date:   Sat,  2 Feb 2019 06:58:27 +0100
Message-Id: <20190202055827.12956-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling off mode was only reachable deeply hidden
in the debugfs. As powersaving is an important feature,
move the option out of its shady place.
The debugfs file can still be used to override the default.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/mach-omap2/Kconfig    | 8 ++++++++
 arch/arm/mach-omap2/pm-debug.c | 4 ++++
 arch/arm/mach-omap2/pm.h       | 4 ++++
 arch/arm/mach-omap2/pm34xx.c   | 7 ++++++-
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 5e33d1a90664..8305b94c0e57 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -231,6 +231,14 @@ config OMAP3_SDRC_AC_TIMING
 	  wish to say no.  Selecting yes without understanding what is
 	  going on could result in system crashes;
 
+config OMAP3_PM_OFFMODE
+	bool "Enable Off-Mode"
+	depends on ARCH_OMAP3
+	help
+	  Enables deeper power-saving states of the SOC, so that hwmods
+	  do not only go to RET state but to OFF state. This option
+	  is overridable via debugfs.
+
 endmenu
 
 endif
diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 5a8839203958..3474027112c2 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -37,7 +37,11 @@
 #include "prm2xxx_3xxx.h"
 #include "pm.h"
 
+#ifdef CONFIG_OMAP3_PM_OFFMODE
+u32 enable_off_mode = 1;
+#else
 u32 enable_off_mode;
+#endif
 
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index c73776b82348..cd5f98f4d28b 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -55,8 +55,12 @@ extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
 #ifdef CONFIG_PM_DEBUG
 extern u32 enable_off_mode;
 #else
+#ifdef CONFIG_OMAP3_PM_OFFMODE
+#define enable_off_mode 1
+#else
 #define enable_off_mode 0
 #endif
+#endif
 
 #if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
 extern void pm_dbg_update_time(struct powerdomain *pwrdm, int prev);
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 1a90050361f1..d7d83a09013f 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -416,7 +416,12 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 	if (!pwrst)
 		return -ENOMEM;
 	pwrst->pwrdm = pwrdm;
-	pwrst->next_state = PWRDM_POWER_RET;
+
+	if (IS_ENABLED(CONFIG_OMAP3_PM_OFFMODE))
+		pwrst->next_state = PWRDM_POWER_OFF;
+	else
+		pwrst->next_state = PWRDM_POWER_RET;
+
 	list_add(&pwrst->node, &pwrst_list);
 
 	if (pwrdm_has_hdwr_sar(pwrdm))
-- 
2.11.0


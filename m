Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753552AbeB0OgX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 09:36:23 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38023 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753154AbeB0OgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 09:36:22 -0500
X-Google-Smtp-Source: AG47ELuKIjsF8zHK3eWAoUWiKRo/6pPp49TecxjQHniISddwJb6B9xAGB+q8j3qFJ/8WnSbi+qUEvQ==
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
X-Google-Original-From: Benjamin Gaignard <benjamin.gaignard@st.com>
To: linux@armlinux.org.uk, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH] ARM: mach-stm32: restore reboot capabilities
Date: Tue, 27 Feb 2018 15:36:07 +0100
Message-Id: <20180227143607.5583-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be able to reboot the platform we need to use armv7m_restart for STM32
SoCs using ARMv7 cores.

Fixes: e0644101bd2f ("ARM: mach-stm32: prepare stm32 family to welcome armv7 architecture)

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
NOTE: This patch should be applied only on
git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git stm32-next
until this patch: https://lkml.org/lkml/2018/2/26/386
find it way to mainline KBuild will complain about it.

 arch/arm/mach-stm32/board-dt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-stm32/board-dt.c b/arch/arm/mach-stm32/board-dt.c
index 06911ad60cea..011d57b488c2 100644
--- a/arch/arm/mach-stm32/board-dt.c
+++ b/arch/arm/mach-stm32/board-dt.c
@@ -7,6 +7,9 @@
 
 #include <linux/kernel.h>
 #include <asm/mach/arch.h>
+#ifdef CONFIG_ARM_SINGLE_ARMV7M
+#include <asm/v7m.h>
+#endif
 
 static const char *const stm32_compat[] __initconst = {
 	"st,stm32f429",
@@ -20,4 +23,7 @@ static const char *const stm32_compat[] __initconst = {
 
 DT_MACHINE_START(STM32DT, "STM32 (Device Tree Support)")
 	.dt_compat = stm32_compat,
+#ifdef CONFIG_ARM_SINGLE_ARMV7M
+	.restart = armv7m_restart,
+#endif
 MACHINE_END
-- 
2.15.0

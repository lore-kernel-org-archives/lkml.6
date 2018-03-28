Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753998AbeC1PiY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 11:38:24 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:48634 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753408AbeC1PiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 11:38:23 -0400
From: Paul Cercueil <paul@crapouillou.net>
To: Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2] MIPS: Fix build with DEBUG_ZBOOT and MACH_JZ4770
Date: Wed, 28 Mar 2018 17:38:12 +0200
Message-Id: <20180328153812.2592-1-paul@crapouillou.net>
In-Reply-To: <20180305170704.17073-1-paul@crapouillou.net>
References: <20180305170704.17073-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The debug definitions were missing for MACH_JZ4770, resulting in a build
failure when DEBUG_ZBOOT was set.

Since the UART addresses are the same across all Ingenic SoCs, we just
use a #ifdef CONFIG_MACH_INGENIC instead of checking for individual
Ingenic SoCs.

Additionally, I added a #define for the UART0 address in-code and dropped
the <asm/mach-jz4740/base.h> include, for the reason that this include
file is slowly being phased out as the whole platform is being moved to
devicetree.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/boot/compressed/uart-16550.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/boot/compressed/uart-16550.c b/arch/mips/boot/compressed/uart-16550.c
index b3043c08f769..aee8d7b8f091 100644
--- a/arch/mips/boot/compressed/uart-16550.c
+++ b/arch/mips/boot/compressed/uart-16550.c
@@ -18,9 +18,9 @@
 #define PORT(offset) (CKSEG1ADDR(AR7_REGS_UART0) + (4 * offset))
 #endif
 
-#if defined(CONFIG_MACH_JZ4740) || defined(CONFIG_MACH_JZ4780)
-#include <asm/mach-jz4740/base.h>
-#define PORT(offset) (CKSEG1ADDR(JZ4740_UART0_BASE_ADDR) + (4 * offset))
+#ifdef CONFIG_MACH_INGENIC
+#define INGENIC_UART0_BASE_ADDR	0x10030000
+#define PORT(offset) (CKSEG1ADDR(INGENIC_UART0_BASE_ADDR) + (4 * offset))
 #endif
 
 #ifdef CONFIG_CPU_XLR
-- 
2.11.0

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938626AbeE1MLh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:11:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423030AbeE1LEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:04:24 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.16 004/272] MIPS: Fix build with DEBUG_ZBOOT and MACH_JZ4770
Date: Mon, 28 May 2018 12:00:37 +0200
Message-Id: <20180528100240.574018305@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Cercueil <paul@crapouillou.net>

commit c60128ce97674fd05adb8b5ae79eb6745a03192e upstream.

The debug definitions were missing for MACH_JZ4770, resulting in a build
failure when DEBUG_ZBOOT was set.

Since the UART addresses are the same across all Ingenic SoCs, we just
use a #ifdef CONFIG_MACH_INGENIC instead of checking for individual
Ingenic SoCs.

Additionally, I added a #define for the UART0 address in-code and
dropped the <asm/mach-jz4740/base.h> include, for the reason that this
include file is slowly being phased out as the whole platform is being
moved to devicetree.

Fixes: 9be5f3e92ed5 ("MIPS: ingenic: Initial JZ4770 support")
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.16
Patchwork: https://patchwork.linux-mips.org/patch/18957/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/boot/compressed/uart-16550.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

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

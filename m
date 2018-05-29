Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933068AbeE2KYN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 06:24:13 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:36465 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932795AbeE2KYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 06:24:08 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM; fix cpu_v7_bugs_init reference
Date: Tue, 29 May 2018 12:22:06 +0200
Message-Id: <20180529102301.1145470-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:sQ05aA8uDa34ftydlMSGCCMSG40chUwIG64WaMY3WiQs+aUesIl
 UjwZ9kvUg3t1NMjlPM2882p+lFYZZt1wIkn8yI12Nbjw6XMf0MW4DwG8NNzM+aws/ru+0JM
 pDVvdWKAeE6aJ1b0b9WxNcaF4Hjtj+IolgkRXx9barA6sZZiQURrtoeFm1PA0CsOY7nZv+Q
 h1Ar4p4v+fEtZzPKCtwmw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:L+CRUun6P2Y=:g0jRetSJrAXsosd35fu/nK
 dGeK1Z8hY6d7J+ES9I3JcCeIbr+J7TrtdVKoSNByKFC01sNq1JGLf8KxiLW47fPiZ1o9DRhh4
 3/RCHohlvVLDYKeU0VJxMOPIQ58cM6sBAZH75UvQ0+SunUGIsR6+Zp9YUCAZ3mnCLAA1o4yZU
 6VbqayrbysB/lxEQhruJR9aYu3pLRpLssGGuRakMtabirC18z6z4RNzoxJnwdq9p54gzDEIGX
 olQNgYws5p5j/A+8mzrjDB2D9Lb7yp7OoBJu1xFyoj3KV9hmEx/eM3E8DSxV3b8XnmVmeeO+u
 jh8yw3qTK0okUC2dGwF4/NDgRNHGWAoZsd9FDoiqGi+adeaH++DImWKWNozQFwJ3TfQ7Rjumw
 W5LSGCCqsash1LlsL1hqtH55qBn22Jo9/4KfTXYlPHRlt+mf8zHs6YbDr6tQP2/v29Y16wyNC
 k7i4QKT5o47Uf1fwJmydFQJZ9Tmj0l+7X1RsbA/w9YwV6GTzvUV1ab98zI4fVL8Z49+W9QYFq
 08Rf07xcb6fKb4xcwV0IxzF0SIGwLGSrj8MTH1bUJeqdWZFZ0uxH9EErAiSZoWqNpj1bu7LwO
 azG/WW/ZhSIE1rUWN2C0bEjbQzJU5DdthBfGSEK26dsvHqto5kdF3Y5jk9MfKXsIk2nYfPj67
 gwQ4kb1bYEP5LH8wBAjEL2nEZHV68fNCfF/XWo7s6c8JhAN4GD0j0x7FNURGLsB8enuI=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpu_v7_bugs_init() function is referenced by the ARMv7 processor
implementation, but is defined conditionally, leading to a link error when
CONFIG_HARDEN_BRANCH_PREDICTOR is disabled:

arch/arm/mm/proc-v7.o:(.init.data+0xc): undefined reference to `cpu_v7_bugs_init'
arch/arm/mm/proc-v7.o:(.init.data+0x74): undefined reference to `cpu_v7_bugs_init'
arch/arm/mm/proc-v7-bugs.o: In function `cpu_v7_ca8_ibe':
proc-v7-bugs.c:(.text+0x14): undefined reference to `cpu_v7_bugs_init'
arch/arm/mm/proc-v7-bugs.o: In function `cpu_v7_ca15_ibe':
proc-v7-bugs.c:(.text+0x30): undefined reference to `cpu_v7_bugs_init'

There is a '.weak' directive for this symbol, which was apparently
intended to avoid the problem, but the file is lacking an actual global
definition for the function, so it has no effect.

This adds an empty function definition for it, which can now get used
as the fallback.

Fixes: 8d9267cedb9e ("ARM: spectre-v2: harden user aborts in kernel space")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mm/proc-v7.S | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 6fe52819e014..8f980e8b0867 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -547,6 +547,11 @@ __v7_setup_stack_ptr:
 	.word	PHYS_RELATIVE(__v7_setup_stack, .)
 ENDPROC(__v7_setup)
 
+	.weak cpu_v7_bugs_init
+ENTRY(cpu_v7_bugs_init)
+	ret	lr
+ENDPROC(cpu_v7_bugs_init)
+
 	.bss
 	.align	2
 __v7_setup_stack:
@@ -554,8 +559,6 @@ __v7_setup_stack:
 
 	__INITDATA
 
-	.weak cpu_v7_bugs_init
-
 	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
 	define_processor_functions v7, dabort=v7_early_abort, pabort=v7_pabort, suspend=1, bugs=cpu_v7_bugs_init
 
-- 
2.9.0

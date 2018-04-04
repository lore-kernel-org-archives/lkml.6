Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751419AbeDDK0P (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 06:26:15 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:40965 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbeDDK0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 06:26:14 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>,
        Dave Gerlach <d-gerlach@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: omap2: fix am43xx build without L2X0
Date: Wed,  4 Apr 2018 12:25:36 +0200
Message-Id: <20180404102550.3692501-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:Ia1MykmtMbvZP/wLs6Sd9ssdYZ3pxiscxZCngPaW2B3CFH5mq4/
 1olEehJcr9WJUVh3qXv134HL6FabtqV8FOerujJfexAfUxjL/plRCR9fDmRz8tNUrDrVPnC
 DdsNovIRvtDSxGG6S9lC8GljRSHp/atM9dSh0OH9OlfpTLfxLXAqD0kbQIFUTeHEXIOl/3X
 BoKyvZmzAGEN3s0A/IBfg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nwIa0BFn0Zo=:CEB20a2BYcfAxV4NN2egUM
 5qdyozyvf4P8pBFiCji+jnxIYfn3puYCoXKPadrZ9URSEbnDCxUF0jFV1JsbyL0KlOVHwZycL
 MVpzaUe5mZpm9ZUnDvILLWKak8X8c/nWRKPBdPEVeuYGwrrYIR2QkexrEwT2zE9ITEJd2T7Yi
 5kSTavUuQCVtIzvfmYY/ixSnpCKYucwqQJfoWHEcsKGK0b+bx8d1BuewAIE0sGjruxNGW/gw3
 qE4crYSZOouQ7lN2fQl8NOXpRvwLdtVuvTydo29XZk2mQLx90+VVPOzdZqZXJ9nARkHrJPvuP
 9xOCCe6bnjm45eHGVQN7SuirVQZzLJHJ1LaVO+sC3TzUjl6Vz+JBVzgQW8moJoKs6LtvWc6eN
 jctkb3tUDF2RdgSySQYL7mCjznvcHZnPy/Sv1GdeOkqfsLgOG6uiBwtgPZ6qxvmDgO8p/n5kH
 p1VfHYzaj9GzWvV0evEh/4MnnJNYPQXjU4PMc/KJnpsuvArtyRCzhUy/DtH48BIs9BE7vCOMR
 cnE4IkqPHZtQ7GGyCJZlZE8YosW6g8xakMy7xTDnKPjPYiRKBmlCTyhCQHExAgIrfHAKmGmE1
 yv30uuX4T7O/ZU0WmmnIoAqqfvW9vi/mFdfl/I8jYVSOiNsvzr06UyXTOGkR31blsed4+qc3k
 bDSJ+VbmwN0jf0dp0CWLdvggKKaDhEPWm4zmVtYscCKeMVldTE/Plu75dTLzn3dbtsNb8fojJ
 65KbpaAfnol6xRmFmbBzUU8E+OW3Gwx/JkrIzg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_CACHE_L2X0 is disabled, the am43xx specific suspend
implemnentation fails to link:

arch/arm/mach-omap2/sleep43xx.o: In function `get_l2cache_base':
(.text+0x180): undefined reference to `omap4_get_l2cache_base'

This adds an #ifdef protection around the code, like we do for am44xx.

Fixes: 41d37e61372f ("ARM: OMAP2+: Introduce low-level suspend code for AM43XX")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap2/sleep43xx.S | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/sleep43xx.S b/arch/arm/mach-omap2/sleep43xx.S
index 59770a69396b..b24be624e8b9 100644
--- a/arch/arm/mach-omap2/sleep43xx.S
+++ b/arch/arm/mach-omap2/sleep43xx.S
@@ -52,10 +52,12 @@
 ENTRY(am43xx_do_wfi)
 	stmfd	sp!, {r4 - r11, lr}	@ save registers on stack
 
+#ifdef CONFIG_CACHE_L2X0
 	/* Retrieve l2 cache virt address BEFORE we shut off EMIF */
 	ldr	r1, get_l2cache_base
 	blx	r1
 	mov	r8, r0
+#endif
 
 	/*
 	 * Flush all data from the L1 and L2 data cache before disabling
@@ -334,8 +336,6 @@ ENDPROC(am43xx_resume_from_deep_sleep)
 	.align
 resume_addr:
 	.word	cpu_resume - PAGE_OFFSET + 0x80000000
-get_l2cache_base:
-	.word	omap4_get_l2cache_base
 kernel_flush:
 	.word   v7_flush_dcache_all
 ddr_start:
@@ -354,7 +354,10 @@ am43xx_phys_emif_clkctrl:
 	.word	(AM43XX_CM_BASE + AM43XX_CM_PER_INST + \
 		 AM43XX_CM_PER_EMIF_CLKCTRL_OFFSET)
 
+#ifdef CONFIG_CACHE_L2X0
 /* L2 cache related defines for AM437x */
+get_l2cache_base:
+	.word	omap4_get_l2cache_base
 l2_cache_base:
 	.word	OMAP44XX_L2CACHE_BASE
 l2_smc1:
@@ -365,6 +368,7 @@ l2_smc3:
 	.word	OMAP4_MON_L2X0_CTRL_INDEX
 l2_val:
 	.word	0xffff
+#endif
 
 .align 3
 /* DDR related defines */
-- 
2.9.0

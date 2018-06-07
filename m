Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id rfrfEjUEGVuWLAAAmS7hNA
	; Thu, 07 Jun 2018 10:10:24 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 986E6607DC; Thu,  7 Jun 2018 10:10:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C642360452;
	Thu,  7 Jun 2018 10:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C642360452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753679AbeFGKKV (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 06:10:21 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:17188 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753165AbeFGKKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 06:10:20 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 411hB227mzz9txc6;
        Thu,  7 Jun 2018 12:10:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id GTZAyzIrZTWU; Thu,  7 Jun 2018 12:10:18 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 411hB21SJHz9txbq;
        Thu,  7 Jun 2018 12:10:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DA11A8B951;
        Thu,  7 Jun 2018 12:10:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id oICFxeBLmRvP; Thu,  7 Jun 2018 12:10:18 +0200 (CEST)
Received: from po14934vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 923BC8B94D;
        Thu,  7 Jun 2018 12:10:18 +0200 (CEST)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 56E9D6F83C; Thu,  7 Jun 2018 10:10:18 +0000 (UTC)
Message-Id: <273f8ed3e980b9385c6e1b31e17f890ea08ce33c.1528365638.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 1/3] powerpc: make CPU selection logic generic in Makefile
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Thu,  7 Jun 2018 10:10:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the time being, when adding a new CPU for selection, both
Kconfig.cputype and Makefile have to be modified.

This patch moves into Kconfig.cputype the name of the CPU to me
passed to the -mcpu= argument.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Makefile                  |  8 +-------
 arch/powerpc/platforms/Kconfig.cputype | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 9704ab360d39..9a5642552abc 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -175,13 +175,7 @@ ifdef CONFIG_MPROFILE_KERNEL
     endif
 endif
 
-CFLAGS-$(CONFIG_CELL_CPU) += $(call cc-option,-mcpu=cell)
-CFLAGS-$(CONFIG_POWER5_CPU) += $(call cc-option,-mcpu=power5)
-CFLAGS-$(CONFIG_POWER6_CPU) += $(call cc-option,-mcpu=power6)
-CFLAGS-$(CONFIG_POWER7_CPU) += $(call cc-option,-mcpu=power7)
-CFLAGS-$(CONFIG_POWER8_CPU) += $(call cc-option,-mcpu=power8)
-CFLAGS-$(CONFIG_POWER9_CPU) += $(call cc-option,-mcpu=power9)
-CFLAGS-$(CONFIG_PPC_8xx) += $(call cc-option,-mcpu=860)
+CFLAGS-$(CONFIG_SPECIAL_CPU_BOOL) += $(call cc-option,-mcpu=$(CONFIG_SPECIAL_CPU))
 
 # Altivec option not allowed with e500mc64 in GCC.
 ifeq ($(CONFIG_ALTIVEC),y)
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index cc892dcfa114..71ef559cc474 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -140,6 +140,21 @@ config E6500_CPU
 
 endchoice
 
+config SPECIAL_CPU_BOOL
+	bool
+	default !GENERIC_CPU
+
+config SPECIAL_CPU
+	string
+	depends on SPECIAL_CPU_BOOL
+	default "cell" if CELL_CPU
+	default "power5" if POWER5_CPU
+	default "power6" if POWER6_CPU
+	default "power7" if POWER7_CPU
+	default "power8" if POWER8_CPU
+	default "power9" if POWER9_CPU
+	default "860" if PPC_8xx
+
 config PPC_BOOK3S
 	def_bool y
 	depends on PPC_BOOK3S_32 || PPC_BOOK3S_64
-- 
2.13.3

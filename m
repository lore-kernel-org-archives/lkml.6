Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C807C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD0520660
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:27:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDD0520660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbeK1U2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:28:13 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:57584 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727676AbeK1U2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:28:12 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 434Zzz6jcpz9vBKF;
        Wed, 28 Nov 2018 10:27:11 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 0TzUtfh15KXA; Wed, 28 Nov 2018 10:27:11 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 434Zzz6CCmz9vBK9;
        Wed, 28 Nov 2018 10:27:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C1FFB8B85D;
        Wed, 28 Nov 2018 10:27:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id VbHt3Dw9gysn; Wed, 28 Nov 2018 10:27:12 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AB9318B853;
        Wed, 28 Nov 2018 10:27:12 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 992DE69AFA; Wed, 28 Nov 2018 09:27:12 +0000 (UTC)
Message-Id: <de304421c38858ddbf3162433e0a6ca326719a52.1543356926.git.christophe.leroy@c-s.fr>
In-Reply-To: <76d777b36e54e7b8d4c196405decc712fc5eaf45.1543356926.git.christophe.leroy@c-s.fr>
References: <76d777b36e54e7b8d4c196405decc712fc5eaf45.1543356926.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v2 05/11] powerpc/8xx: Add Kernel Userspace Execution
 Prevention
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, ruscur@russell.cc
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 28 Nov 2018 09:27:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds Kernel Userspace Execution Prevention on the 8xx.

When a page is Executable, it is set Executable for Key 0 and NX
for Key 1.

Up to now, the User group is defined with Key 0 for both User and
Supervisor.

By changing the group to Key 0 for User and Key 1 for Supervisor,
this patch prevents the Kernel from being able to execute user code.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/mmu-8xx.h     |  6 ++++++
 arch/powerpc/mm/8xx_mmu.c              | 12 ++++++++++++
 arch/powerpc/platforms/Kconfig.cputype |  1 +
 3 files changed, 19 insertions(+)

diff --git a/arch/powerpc/include/asm/mmu-8xx.h b/arch/powerpc/include/asm/mmu-8xx.h
index fa05aa566ece..53dbf0788fce 100644
--- a/arch/powerpc/include/asm/mmu-8xx.h
+++ b/arch/powerpc/include/asm/mmu-8xx.h
@@ -41,6 +41,12 @@
  */
 #define MI_APG_INIT	0x44444444
 
+/*
+ * 0 => No user => 01 (all accesses performed according to page definition)
+ * 1 => User => 10 (all accesses performed according to swaped page definition)
+ */
+#define MI_APG_KUEP	0x66666666
+
 /* The effective page number register.  When read, contains the information
  * about the last instruction TLB miss.  When MI_RPN is written, bits in
  * this register are used to create the TLB entry.
diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
index 01b7f5107c3a..f14ceb507d98 100644
--- a/arch/powerpc/mm/8xx_mmu.c
+++ b/arch/powerpc/mm/8xx_mmu.c
@@ -194,3 +194,15 @@ void flush_instruction_cache(void)
 	mtspr(SPRN_IC_CST, IDC_INVALL);
 	isync();
 }
+
+#ifdef CONFIG_PPC_KUEP
+void __init setup_kuep(bool disabled)
+{
+	if (disabled)
+		return;
+
+	pr_info("Activating Kernel Userspace Execution Prevention\n");
+
+	mtspr(SPRN_MI_AP, MI_APG_KUEP);
+}
+#endif
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 68eaafd54aca..d1757cedf60b 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -33,6 +33,7 @@ config PPC_8xx
 	bool "Freescale 8xx"
 	select FSL_SOC
 	select SYS_SUPPORTS_HUGETLBFS
+	select PPC_HAVE_KUEP
 
 config 40x
 	bool "AMCC 40x"
-- 
2.13.3


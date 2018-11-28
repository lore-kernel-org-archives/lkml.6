Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1378DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D746220660
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D746220660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbeK1U2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:28:16 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:10077 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727623AbeK1U2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:28:15 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 434b020XP0z9vBKG;
        Wed, 28 Nov 2018 10:27:14 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Uu_bzGuIJC6X; Wed, 28 Nov 2018 10:27:14 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 434b02017rz9vBK9;
        Wed, 28 Nov 2018 10:27:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E06318B85D;
        Wed, 28 Nov 2018 10:27:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id RMa5M3jVsKcj; Wed, 28 Nov 2018 10:27:14 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B377C8B853;
        Wed, 28 Nov 2018 10:27:14 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 9EAA569AFA; Wed, 28 Nov 2018 09:27:14 +0000 (UTC)
Message-Id: <9a7dc3917c7c865c0eef66a671439afe92165bba.1543356926.git.christophe.leroy@c-s.fr>
In-Reply-To: <76d777b36e54e7b8d4c196405decc712fc5eaf45.1543356926.git.christophe.leroy@c-s.fr>
References: <76d777b36e54e7b8d4c196405decc712fc5eaf45.1543356926.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v2 06/11] powerpc/8xx: Add Kernel Userspace Access
 Protection
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, ruscur@russell.cc
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 28 Nov 2018 09:27:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds Kernel Userspace Access Protection on the 8xx.

When a page is RO or RW, it is set RO or RW for Key 0 and NA
for Key 1.

Up to now, the User group is defined with Key 0 for both User and
Supervisor.

By changing the group to Key 0 for User and Key 1 for Supervisor,
this patch prevents the Kernel from being able to access user data.

At exception entry, the kernel saves SPRN_MD_AP in the regs struct,
and reapply the protection. At exception exit it restore SPRN_MD_AP
with the value it had on exception entry.

For the time being, the unused mq field of pt_regs struct is used for
that.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/kup.h               |  4 ++++
 arch/powerpc/include/asm/mmu-8xx.h           |  6 +++++
 arch/powerpc/include/asm/nohash/32/kup-8xx.h | 34 ++++++++++++++++++++++++++++
 arch/powerpc/mm/8xx_mmu.c                    | 12 ++++++++++
 arch/powerpc/platforms/Kconfig.cputype       |  1 +
 5 files changed, 57 insertions(+)
 create mode 100644 arch/powerpc/include/asm/nohash/32/kup-8xx.h

diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/kup.h
index 2ac540fb488f..f7262f4c427e 100644
--- a/arch/powerpc/include/asm/kup.h
+++ b/arch/powerpc/include/asm/kup.h
@@ -2,6 +2,10 @@
 #ifndef _ASM_POWERPC_KUP_H_
 #define _ASM_POWERPC_KUP_H_
 
+#ifdef CONFIG_PPC_8xx
+#include <asm/nohash/32/kup-8xx.h>
+#endif
+
 #ifndef __ASSEMBLY__
 
 #include <asm/pgtable.h>
diff --git a/arch/powerpc/include/asm/mmu-8xx.h b/arch/powerpc/include/asm/mmu-8xx.h
index 53dbf0788fce..01a0a1694ebd 100644
--- a/arch/powerpc/include/asm/mmu-8xx.h
+++ b/arch/powerpc/include/asm/mmu-8xx.h
@@ -120,6 +120,12 @@
  */
 #define MD_APG_INIT	0x44444444
 
+/*
+ * 0 => No user => 01 (all accesses performed according to page definition)
+ * 1 => User => 10 (all accesses performed according to swaped page definition)
+ */
+#define MD_APG_KUAP	0x66666666
+
 /* The effective page number register.  When read, contains the information
  * about the last instruction TLB miss.  When MD_RPN is written, bits in
  * this register are used to create the TLB entry.
diff --git a/arch/powerpc/include/asm/nohash/32/kup-8xx.h b/arch/powerpc/include/asm/nohash/32/kup-8xx.h
new file mode 100644
index 000000000000..8f4975c0de22
--- /dev/null
+++ b/arch/powerpc/include/asm/nohash/32/kup-8xx.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_KUP_8XX_H_
+#define _ASM_POWERPC_KUP_8XX_H_
+
+#ifdef CONFIG_PPC_KUAP
+#define LOCK_USER_ACCESS(val, sp, sr, srmax, current)	\
+	mfspr	val, SPRN_MD_AP;			\
+	stw	val, _KUAP(sp);				\
+	lis	val, MD_APG_KUAP@h;			\
+	ori	val, val, MD_APG_KUAP@l;		\
+	mtspr	SPRN_MD_AP, val
+
+#define REST_USER_ACCESS(val, sp, sr, srmax, current)	\
+	lwz	val, _KUAP(sp);				\
+	mtspr	SPRN_MD_AP, val
+
+#define KUAP_START			MD_APG_KUAP
+
+#ifndef __ASSEMBLY__
+static inline void lock_user_access(void __user *to, const void __user *from,
+				    unsigned long size)
+{
+	mtspr(SPRN_MD_AP, MD_APG_KUAP);
+}
+
+static inline void unlock_user_access(void __user *to, const void __user *from,
+				      unsigned long size)
+{
+	mtspr(SPRN_MD_AP, MD_APG_INIT);
+}
+#endif /* !__ASSEMBLY__ */
+#endif /* CONFIG_PPC_KUAP */
+
+#endif /* _ASM_POWERPC_KUP_8XX_H_ */
diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
index f14ceb507d98..2bba4fd2eed7 100644
--- a/arch/powerpc/mm/8xx_mmu.c
+++ b/arch/powerpc/mm/8xx_mmu.c
@@ -206,3 +206,15 @@ void __init setup_kuep(bool disabled)
 	mtspr(SPRN_MI_AP, MI_APG_KUEP);
 }
 #endif
+
+#ifdef CONFIG_PPC_KUAP
+void __init setup_kuap(bool disabled)
+{
+	pr_info("Activating Kernel Userspace Access Protection\n");
+
+	if (disabled)
+		pr_warn("KUAP cannot be disabled yet on 8xx when compiled in\n");
+
+	mtspr(SPRN_MD_AP, MD_APG_KUAP);
+}
+#endif
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index d1757cedf60b..a20669a9ec13 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -34,6 +34,7 @@ config PPC_8xx
 	select FSL_SOC
 	select SYS_SUPPORTS_HUGETLBFS
 	select PPC_HAVE_KUEP
+	select PPC_HAVE_KUAP
 
 config 40x
 	bool "AMCC 40x"
-- 
2.13.3


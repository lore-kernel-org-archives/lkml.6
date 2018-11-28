Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F212C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E524D20660
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:27:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E524D20660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbeK1U2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:28:08 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:34655 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727616AbeK1U2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:28:06 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 434Zzs6JDdz9vBKG;
        Wed, 28 Nov 2018 10:27:05 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id eioCN6G33gbZ; Wed, 28 Nov 2018 10:27:05 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 434Zzs5gVqz9vBK9;
        Wed, 28 Nov 2018 10:27:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AB8878B85D;
        Wed, 28 Nov 2018 10:27:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id uIV2XMwDv7Ca; Wed, 28 Nov 2018 10:27:06 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 907658B853;
        Wed, 28 Nov 2018 10:27:06 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 8851469AFA; Wed, 28 Nov 2018 09:27:06 +0000 (UTC)
Message-Id: <7260e8d9a642c60d4f4db0e8b66ec485a1f474d5.1543356926.git.christophe.leroy@c-s.fr>
In-Reply-To: <76d777b36e54e7b8d4c196405decc712fc5eaf45.1543356926.git.christophe.leroy@c-s.fr>
References: <76d777b36e54e7b8d4c196405decc712fc5eaf45.1543356926.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v2 02/11] powerpc: Add framework for Kernel Userspace
 Protection
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, ruscur@russell.cc
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 28 Nov 2018 09:27:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a skeleton for Kernel Userspace Protection
functionnalities like Kernel Userspace Access Protection and
Kernel Userspace Execution Prevention

The subsequent implementation of KUAP for radix makes use of a MMU
feature in order to patch out assembly when KUAP is disabled or
unsupported.  This won't work unless there's an entry point for
KUP support before the feature magic happens, so for PPC64
setup_kup() is called early in setup.

On PPC32, feature_fixup is done too early to allow the same.

Suggested-by: Russell Currey <ruscur@russell.cc>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/kup.h | 11 +++++++++++
 arch/powerpc/kernel/setup_64.c |  7 +++++++
 arch/powerpc/mm/init-common.c  |  5 +++++
 arch/powerpc/mm/init_32.c      |  3 +++
 4 files changed, 26 insertions(+)
 create mode 100644 arch/powerpc/include/asm/kup.h

diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/kup.h
new file mode 100644
index 000000000000..7a88b8b9b54d
--- /dev/null
+++ b/arch/powerpc/include/asm/kup.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_KUP_H_
+#define _ASM_POWERPC_KUP_H_
+
+#ifndef __ASSEMBLY__
+
+void setup_kup(void);
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* _ASM_POWERPC_KUP_H_ */
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 236c1151a3a7..771f280a6bf6 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -68,6 +68,7 @@
 #include <asm/cputhreads.h>
 #include <asm/hw_irq.h>
 #include <asm/feature-fixups.h>
+#include <asm/kup.h>
 
 #include "setup.h"
 
@@ -331,6 +332,12 @@ void __init early_setup(unsigned long dt_ptr)
 	 */
 	configure_exceptions();
 
+	/*
+	 * Configure Kernel Userspace Protection. This needs to happen before
+	 * feature fixups for platforms that implement this using features.
+	 */
+	setup_kup();
+
 	/* Apply all the dynamic patching */
 	apply_feature_fixups();
 	setup_feature_keys();
diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
index 2b656e67f2ea..a72bbfc3add6 100644
--- a/arch/powerpc/mm/init-common.c
+++ b/arch/powerpc/mm/init-common.c
@@ -24,6 +24,11 @@
 #include <linux/string.h>
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
+#include <asm/kup.h>
+
+void __init setup_kup(void)
+{
+}
 
 static void pgd_ctor(void *addr)
 {
diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 3e59e5d64b01..93cfa8cf015d 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -45,6 +45,7 @@
 #include <asm/tlb.h>
 #include <asm/sections.h>
 #include <asm/hugetlb.h>
+#include <asm/kup.h>
 
 #include "mmu_decl.h"
 
@@ -182,6 +183,8 @@ void __init MMU_init(void)
 	btext_unmap();
 #endif
 
+	setup_kup();
+
 	/* Shortly after that, the entire linear mapping will be available */
 	memblock_set_current_limit(lowmem_end_addr);
 }
-- 
2.13.3


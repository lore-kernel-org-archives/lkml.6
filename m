Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BB1C43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05BF7206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbfAHNnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:43:18 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:57346 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728127AbfAHNnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 08:43:14 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43YtkQ5GHBz9tyN0;
        Tue,  8 Jan 2019 14:43:10 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id nEwckrwOrh6F; Tue,  8 Jan 2019 14:43:10 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43YtkQ4jP1z9tyMv;
        Tue,  8 Jan 2019 14:43:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 038058B833;
        Tue,  8 Jan 2019 14:43:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id wIWWpOvZ7m42; Tue,  8 Jan 2019 14:43:11 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B63948B7DF;
        Tue,  8 Jan 2019 14:43:11 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 9057E717F2; Tue,  8 Jan 2019 13:43:11 +0000 (UTC)
Message-Id: <022f5a29f8898963f38013065e996cc22168460c.1546954236.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1546954233.git.christophe.leroy@c-s.fr>
References: <cover.1546954233.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v12 02/10] book3s/64: avoid circular header inclusion in
 mmu-hash.h
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue,  8 Jan 2019 13:43:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When activating CONFIG_THREAD_INFO_IN_TASK, linux/sched.h
includes asm/current.h. This generates a circular dependency.
To avoid that, asm/processor.h shall not be included in mmu-hash.h

In order to do that, this patch moves into a new header called
asm/task_size_user64.h the information from asm/processor.h required
by mmu-hash.h

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |  2 +-
 arch/powerpc/include/asm/processor.h          | 34 +---------------------
 arch/powerpc/include/asm/task_size_user64.h   | 42 +++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_hv_hmi.c              |  1 +
 4 files changed, 45 insertions(+), 34 deletions(-)
 create mode 100644 arch/powerpc/include/asm/task_size_user64.h

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index 12e522807f9f..b2aba048301e 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -23,7 +23,7 @@
  */
 #include <asm/book3s/64/pgtable.h>
 #include <asm/bug.h>
-#include <asm/processor.h>
+#include <asm/task_size_user64.h>
 #include <asm/cpu_has_feature.h>
 
 /*
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index ee58526cb6c2..692f7383d461 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -95,40 +95,8 @@ void release_thread(struct task_struct *);
 #endif
 
 #ifdef CONFIG_PPC64
-/*
- * 64-bit user address space can have multiple limits
- * For now supported values are:
- */
-#define TASK_SIZE_64TB  (0x0000400000000000UL)
-#define TASK_SIZE_128TB (0x0000800000000000UL)
-#define TASK_SIZE_512TB (0x0002000000000000UL)
-#define TASK_SIZE_1PB   (0x0004000000000000UL)
-#define TASK_SIZE_2PB   (0x0008000000000000UL)
-/*
- * With 52 bits in the address we can support
- * upto 4PB of range.
- */
-#define TASK_SIZE_4PB   (0x0010000000000000UL)
 
-/*
- * For now 512TB is only supported with book3s and 64K linux page size.
- */
-#if defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_PPC_64K_PAGES)
-/*
- * Max value currently used:
- */
-#define TASK_SIZE_USER64		TASK_SIZE_4PB
-#define DEFAULT_MAP_WINDOW_USER64	TASK_SIZE_128TB
-#define TASK_CONTEXT_SIZE		TASK_SIZE_512TB
-#else
-#define TASK_SIZE_USER64		TASK_SIZE_64TB
-#define DEFAULT_MAP_WINDOW_USER64	TASK_SIZE_64TB
-/*
- * We don't need to allocate extended context ids for 4K page size, because
- * we limit the max effective address on this config to 64TB.
- */
-#define TASK_CONTEXT_SIZE		TASK_SIZE_64TB
-#endif
+#include <asm/task_size_user64.h>
 
 /*
  * 32-bit user address space is 4GB - 1 page
diff --git a/arch/powerpc/include/asm/task_size_user64.h b/arch/powerpc/include/asm/task_size_user64.h
new file mode 100644
index 000000000000..a4043075864b
--- /dev/null
+++ b/arch/powerpc/include/asm/task_size_user64.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_TASK_SIZE_USER64_H
+#define _ASM_POWERPC_TASK_SIZE_USER64_H
+
+#ifdef CONFIG_PPC64
+/*
+ * 64-bit user address space can have multiple limits
+ * For now supported values are:
+ */
+#define TASK_SIZE_64TB  (0x0000400000000000UL)
+#define TASK_SIZE_128TB (0x0000800000000000UL)
+#define TASK_SIZE_512TB (0x0002000000000000UL)
+#define TASK_SIZE_1PB   (0x0004000000000000UL)
+#define TASK_SIZE_2PB   (0x0008000000000000UL)
+/*
+ * With 52 bits in the address we can support
+ * upto 4PB of range.
+ */
+#define TASK_SIZE_4PB   (0x0010000000000000UL)
+
+/*
+ * For now 512TB is only supported with book3s and 64K linux page size.
+ */
+#if defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_PPC_64K_PAGES)
+/*
+ * Max value currently used:
+ */
+#define TASK_SIZE_USER64		TASK_SIZE_4PB
+#define DEFAULT_MAP_WINDOW_USER64	TASK_SIZE_128TB
+#define TASK_CONTEXT_SIZE		TASK_SIZE_512TB
+#else
+#define TASK_SIZE_USER64		TASK_SIZE_64TB
+#define DEFAULT_MAP_WINDOW_USER64	TASK_SIZE_64TB
+/*
+ * We don't need to allocate extended context ids for 4K page size, because
+ * we limit the max effective address on this config to 64TB.
+ */
+#define TASK_CONTEXT_SIZE		TASK_SIZE_64TB
+#endif
+
+#endif /* CONFIG_PPC64 */
+#endif /* _ASM_POWERPC_TASK_SIZE_USER64_H */
diff --git a/arch/powerpc/kvm/book3s_hv_hmi.c b/arch/powerpc/kvm/book3s_hv_hmi.c
index e3f738eb1cac..64b5011475c7 100644
--- a/arch/powerpc/kvm/book3s_hv_hmi.c
+++ b/arch/powerpc/kvm/book3s_hv_hmi.c
@@ -24,6 +24,7 @@
 #include <linux/compiler.h>
 #include <asm/paca.h>
 #include <asm/hmi.h>
+#include <asm/processor.h>
 
 void wait_for_subcore_guest_exit(void)
 {
-- 
2.13.3


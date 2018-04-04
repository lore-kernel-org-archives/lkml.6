Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752089AbeDDUKg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 16:10:36 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33100 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751516AbeDDUKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 16:10:34 -0400
X-Google-Smtp-Source: AIpwx49DR+uAlezVFla7aefZQkUd6WQIkEdaytPtDSKKob9uo3vckr0FCFRD6OXlqCuf7fvIk1G9wg==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
        Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 19/19] powerpc/tau: Synchronize function prototypes and body
Date: Wed,  4 Apr 2018 22:10:28 +0200
Message-Id: <20180404201028.27621-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180322202007.23088-20-malat@debian.org>
References: <20180322202007.23088-20-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some function prototypes and body for Thermal Assist Units were not in
sync. Update the function definition to match the existing function
declaration found in `setup-common.c`, changing an `int` return type to a
`u32` return type. Move the prototypes to a header file. Fix the following
warnings, treated as error with W=1:

  arch/powerpc/kernel/tau_6xx.c:257:5: error: no previous prototype for ‘cpu_temp_both’ [-Werror=missing-prototypes]
  arch/powerpc/kernel/tau_6xx.c:262:5: error: no previous prototype for ‘cpu_temp’ [-Werror=missing-prototypes]
  arch/powerpc/kernel/tau_6xx.c:267:5: error: no previous prototype for ‘tau_interrupts’ [-Werror=missing-prototypes]

Compile tested with CONFIG_TAU_INT.

Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v3: remove extern keyword
v2: no change
 arch/powerpc/kernel/irq.c          | 2 +-
 arch/powerpc/kernel/setup-common.c | 6 ------
 arch/powerpc/kernel/setup.h        | 6 ++++++
 arch/powerpc/kernel/tau_6xx.c      | 7 +++++--
 4 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 061aa0f47bb1..bbf7ec582d60 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -89,7 +89,7 @@ atomic_t ppc_n_lost_interrupts;
 
 #ifdef CONFIG_TAU_INT
 extern int tau_initialized;
-extern int tau_interrupts(int);
+u32 tau_interrupts(unsigned long cpu);
 #endif
 #endif /* CONFIG_PPC32 */
 
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index d73ec518ef80..bd3675c3984b 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -192,12 +192,6 @@ void machine_halt(void)
 	machine_hang();
 }
 
-
-#ifdef CONFIG_TAU
-extern u32 cpu_temp(unsigned long cpu);
-extern u32 cpu_temp_both(unsigned long cpu);
-#endif /* CONFIG_TAU */
-
 #ifdef CONFIG_SMP
 DEFINE_PER_CPU(unsigned int, cpu_pvr);
 #endif
diff --git a/arch/powerpc/kernel/setup.h b/arch/powerpc/kernel/setup.h
index d768023a04bd..76845c925bf5 100644
--- a/arch/powerpc/kernel/setup.h
+++ b/arch/powerpc/kernel/setup.h
@@ -70,4 +70,10 @@ void kvm_cma_reserve(void);
 static inline void kvm_cma_reserve(void) { };
 #endif
 
+#ifdef CONFIG_TAU
+u32 cpu_temp(unsigned long cpu);
+u32 cpu_temp_both(unsigned long cpu);
+u32 tau_interrupts(unsigned long cpu);
+#endif /* CONFIG_TAU */
+
 #endif /* __ARCH_POWERPC_KERNEL_SETUP_H */
diff --git a/arch/powerpc/kernel/tau_6xx.c b/arch/powerpc/kernel/tau_6xx.c
index 1fc6a89a978e..e2ab8a111b69 100644
--- a/arch/powerpc/kernel/tau_6xx.c
+++ b/arch/powerpc/kernel/tau_6xx.c
@@ -27,6 +27,9 @@
 #include <asm/cache.h>
 #include <asm/8xx_immap.h>
 #include <asm/machdep.h>
+#include <asm/asm-prototypes.h>
+
+#include "setup.h"
 
 static struct tau_temp
 {
@@ -259,12 +262,12 @@ u32 cpu_temp_both(unsigned long cpu)
 	return ((tau[cpu].high << 16) | tau[cpu].low);
 }
 
-int cpu_temp(unsigned long cpu)
+u32 cpu_temp(unsigned long cpu)
 {
 	return ((tau[cpu].high + tau[cpu].low) / 2);
 }
 
-int tau_interrupts(unsigned long cpu)
+u32 tau_interrupts(unsigned long cpu)
 {
 	return (tau[cpu].interrupts);
 }
-- 
2.11.0

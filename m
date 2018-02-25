Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752003AbeBYRXZ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 12:23:25 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35908 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751952AbeBYRXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 12:23:12 -0500
X-Google-Smtp-Source: AH8x227YuiEc4lOejwKZLnVJD8RLclgq9UXCLZbZAiiem5lLuilKtaDWpcw59Jj2o5fA879L/v2exA==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 21/21] powerpc: Add missing prototypes in setup_32.c
Date: Sun, 25 Feb 2018 18:22:36 +0100
Message-Id: <20180225172236.29650-22-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180225172236.29650-1-malat@debian.org>
References: <20180225172236.29650-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit add the prototypes for the following function:

- early_init
- machine_init
- ppc_setup_l2cr
- ppc_setup_l3cr
- ppc_init

the other missing ones were already added in setup.h previously. Fix the
following warnings (treated as error in W=1):

  AR      init/built-in.o
arch/powerpc/kernel/setup_32.c:68:30: error: no previous prototype for ‘early_init’ [-Werror=missing-prototypes]
 notrace unsigned long __init early_init(unsigned long dt_ptr)
                              ^~~~~~~~~~
arch/powerpc/kernel/setup_32.c:99:21: error: no previous prototype for ‘machine_init’ [-Werror=missing-prototypes]
 notrace void __init machine_init(u64 dt_ptr)
                     ^~~~~~~~~~~~
arch/powerpc/kernel/setup_32.c:124:12: error: no previous prototype for ‘ppc_setup_l2cr’ [-Werror=missing-prototypes]
 int __init ppc_setup_l2cr(char *str)
            ^~~~~~~~~~~~~~
arch/powerpc/kernel/setup_32.c:137:12: error: no previous prototype for ‘ppc_setup_l3cr’ [-Werror=missing-prototypes]
 int __init ppc_setup_l3cr(char *str)
            ^~~~~~~~~~~~~~
arch/powerpc/kernel/setup_32.c:183:12: error: no previous prototype for ‘ppc_init’ [-Werror=missing-prototypes]
 int __init ppc_init(void)
            ^~~~~~~~
arch/powerpc/kernel/setup_32.c:198:13: error: no previous prototype for ‘irqstack_early_init’ [-Werror=missing-prototypes]
 void __init irqstack_early_init(void)
             ^~~~~~~~~~~~~~~~~~~
arch/powerpc/kernel/setup_32.c:238:13: error: no previous prototype for ‘setup_power_save’ [-Werror=missing-prototypes]
 void __init setup_power_save(void)
             ^~~~~~~~~~~~~~~~
arch/powerpc/kernel/setup_32.c:253:13: error: no previous prototype for ‘initialize_cache_info’ [-Werror=missing-prototypes]
 __init void initialize_cache_info(void)
             ^~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/kernel/setup.h    | 5 +++++
 arch/powerpc/kernel/setup_32.c | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/arch/powerpc/kernel/setup.h b/arch/powerpc/kernel/setup.h
index 3fc11e30308f..d768023a04bd 100644
--- a/arch/powerpc/kernel/setup.h
+++ b/arch/powerpc/kernel/setup.h
@@ -17,6 +17,11 @@ void irqstack_early_init(void);
 
 #ifdef CONFIG_PPC32
 void setup_power_save(void);
+unsigned long __init early_init(unsigned long dt_ptr);
+void __init machine_init(u64 dt_ptr);
+int __init ppc_setup_l2cr(char *str);
+int __init ppc_setup_l3cr(char *str);
+int __init ppc_init(void);
 #else
 static inline void setup_power_save(void) { };
 #endif
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 51ebc01fff52..12bcab77a29f 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -40,6 +40,8 @@
 #include <asm/code-patching.h>
 #include <asm/cpu_has_feature.h>
 
+#include "setup.h"
+
 #define DBG(fmt...)
 
 extern void bootx_init(unsigned long r4, unsigned long phys);
-- 
2.11.0

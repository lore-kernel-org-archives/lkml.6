Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752976AbeC1SsJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 14:48:09 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36227 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751434AbeC1SsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 14:48:08 -0400
X-Google-Smtp-Source: AIpwx4+aei8mrQVg9nAav0FwYiicEACd0tFE6v1fVl4PklfxjaJzjL+H011EI5qif9oCxZpYKocpPA==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: LEROY Christophe <christophe.leroy@c-s.fr>,
        Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Matt Brown <matthew.brown.dev@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] powerpc/altivec: Add missing prototypes for altivec
Date: Wed, 28 Mar 2018 20:47:33 +0200
Message-Id: <20180328184744.10650-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180322202007.23088-15-malat@debian.org>
References: <20180322202007.23088-15-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some functions prototypes were missing for the non-altivec code. Add the
missing prototypes in a new header file, fix warnings treated as errors
with W=1:

  arch/powerpc/lib/xor_vmx_glue.c:18:6: error: no previous prototype for ‘xor_altivec_2’ [-Werror=missing-prototypes]
  arch/powerpc/lib/xor_vmx_glue.c:29:6: error: no previous prototype for ‘xor_altivec_3’ [-Werror=missing-prototypes]
  arch/powerpc/lib/xor_vmx_glue.c:40:6: error: no previous prototype for ‘xor_altivec_4’ [-Werror=missing-prototypes]
  arch/powerpc/lib/xor_vmx_glue.c:52:6: error: no previous prototype for ‘xor_altivec_5’ [-Werror=missing-prototypes]

The prototypes were already present in <asm/xor.h> but this header file is
meant to be included after <include/linux/raid/xor.h>. Trying to re-use
<asm/xor.h> directly would lead to warnings such as:

  arch/powerpc/include/asm/xor.h:39:15: error: variable ‘xor_block_altivec’ has initializer but incomplete type

Trying to re-use <asm/xor.h> after <include/linux/raid/xor.h> in
xor_vmx_glue.c would in turn trigger the following warnings:

  include/asm-generic/xor.h:688:34: error: ‘xor_block_32regs’ defined but not used [-Werror=unused-variable]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/include/asm/xor.h         | 12 +-----------
 arch/powerpc/include/asm/xor_altivec.h | 19 +++++++++++++++++++
 arch/powerpc/lib/xor_vmx_glue.c        |  1 +
 3 files changed, 21 insertions(+), 11 deletions(-)
 create mode 100644 arch/powerpc/include/asm/xor_altivec.h

diff --git a/arch/powerpc/include/asm/xor.h b/arch/powerpc/include/asm/xor.h
index a36c2069d8ed..7d6dc503349d 100644
--- a/arch/powerpc/include/asm/xor.h
+++ b/arch/powerpc/include/asm/xor.h
@@ -24,17 +24,7 @@
 
 #include <asm/cputable.h>
 #include <asm/cpu_has_feature.h>
-
-void xor_altivec_2(unsigned long bytes, unsigned long *v1_in,
-		   unsigned long *v2_in);
-void xor_altivec_3(unsigned long bytes, unsigned long *v1_in,
-		   unsigned long *v2_in, unsigned long *v3_in);
-void xor_altivec_4(unsigned long bytes, unsigned long *v1_in,
-		   unsigned long *v2_in, unsigned long *v3_in,
-		   unsigned long *v4_in);
-void xor_altivec_5(unsigned long bytes, unsigned long *v1_in,
-		   unsigned long *v2_in, unsigned long *v3_in,
-		   unsigned long *v4_in, unsigned long *v5_in);
+#include <asm/xor_altivec.h>
 
 static struct xor_block_template xor_block_altivec = {
 	.name = "altivec",
diff --git a/arch/powerpc/include/asm/xor_altivec.h b/arch/powerpc/include/asm/xor_altivec.h
new file mode 100644
index 000000000000..6ca923510b59
--- /dev/null
+++ b/arch/powerpc/include/asm/xor_altivec.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_XOR_ALTIVEC_H
+#define _ASM_POWERPC_XOR_ALTIVEC_H
+
+#ifdef CONFIG_ALTIVEC
+
+void xor_altivec_2(unsigned long bytes, unsigned long *v1_in,
+		   unsigned long *v2_in);
+void xor_altivec_3(unsigned long bytes, unsigned long *v1_in,
+		   unsigned long *v2_in, unsigned long *v3_in);
+void xor_altivec_4(unsigned long bytes, unsigned long *v1_in,
+		   unsigned long *v2_in, unsigned long *v3_in,
+		   unsigned long *v4_in);
+void xor_altivec_5(unsigned long bytes, unsigned long *v1_in,
+		   unsigned long *v2_in, unsigned long *v3_in,
+		   unsigned long *v4_in, unsigned long *v5_in);
+
+#endif
+#endif /* _ASM_POWERPC_XOR_ALTIVEC_H */
diff --git a/arch/powerpc/lib/xor_vmx_glue.c b/arch/powerpc/lib/xor_vmx_glue.c
index 6521fe5e8cef..dab2b6bfcf36 100644
--- a/arch/powerpc/lib/xor_vmx_glue.c
+++ b/arch/powerpc/lib/xor_vmx_glue.c
@@ -13,6 +13,7 @@
 #include <linux/export.h>
 #include <linux/sched.h>
 #include <asm/switch_to.h>
+#include <asm/xor_altivec.h>
 #include "xor_vmx.h"
 
 void xor_altivec_2(unsigned long bytes, unsigned long *v1_in,
-- 
2.11.0

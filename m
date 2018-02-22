Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932078AbeBVLTH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 06:19:07 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44849 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753746AbeBVLTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 06:19:03 -0500
X-Google-Smtp-Source: AH8x227aXT63o6J5JQ0qHH7Rf9XtPXrrXcn9glvHwWov2RE3jKUKLtOij9VY9rde5y9oUaf0glslPg==
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: catalin.marinas@arm.com, will.deacon@arm.com,
        bauerman@linux.vnet.ibm.com, dhowells@redhat.com, vgoyal@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        akpm@linux-foundation.org, mpe@ellerman.id.au, dyoung@redhat.com,
        bhe@redhat.com, arnd@arndb.de, ard.biesheuvel@linaro.org,
        julien.thierry@arm.com
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v8 02/13] kexec_file: make an use of purgatory optional
Date: Thu, 22 Feb 2018 20:17:21 +0900
Message-Id: <20180222111732.23051-3-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180222111732.23051-1-takahiro.akashi@linaro.org>
References: <20180222111732.23051-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On arm64, no trampline code between old kernel and new kernel will be
required in kexec_file implementation. This patch introduces a new
configuration, ARCH_HAS_KEXEC_PURGATORY, and allows related code to be
compiled in only if necessary.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
---
 arch/powerpc/Kconfig | 3 +++
 arch/x86/Kconfig     | 3 +++
 kernel/kexec_file.c  | 6 ++++++
 3 files changed, 12 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 73ce5dd07642..c32a181a7cbb 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -552,6 +552,9 @@ config KEXEC_FILE
 	  for kernel and initramfs as opposed to a list of segments as is the
 	  case for the older kexec call.
 
+config ARCH_HAS_KEXEC_PURGATORY
+	def_bool KEXEC_FILE
+
 config RELOCATABLE
 	bool "Build a relocatable kernel"
 	depends on PPC64 || (FLATMEM && (44x || FSL_BOOKE))
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c1236b187824..f031c3efe47e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2019,6 +2019,9 @@ config KEXEC_FILE
 	  for kernel and initramfs as opposed to list of segments as
 	  accepted by previous system call.
 
+config ARCH_HAS_KEXEC_PURGATORY
+	def_bool KEXEC_FILE
+
 config KEXEC_VERIFY_SIG
 	bool "Verify kernel signature during kexec_file_load() syscall"
 	depends on KEXEC_FILE
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index e5bcd94c1efb..990adae52151 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -26,7 +26,11 @@
 #include <linux/vmalloc.h>
 #include "kexec_internal.h"
 
+#ifdef CONFIG_ARCH_HAS_KEXEC_PURGATORY
 static int kexec_calculate_store_digests(struct kimage *image);
+#else
+static int kexec_calculate_store_digests(struct kimage *image) { return 0; };
+#endif
 
 /* Architectures can provide this probe function */
 int __weak arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
@@ -520,6 +524,7 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
 	return 0;
 }
 
+#ifdef CONFIG_ARCH_HAS_KEXEC_PURGATORY
 /* Calculate and store the digest of segments */
 static int kexec_calculate_store_digests(struct kimage *image)
 {
@@ -1022,3 +1027,4 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
 
 	return 0;
 }
+#endif /* CONFIG_ARCH_HAS_KEXEC_PURGATORY */
-- 
2.16.2

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753385AbeCFKXT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 05:23:19 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:53401 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753155AbeCFKXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 05:23:17 -0500
X-Google-Smtp-Source: AG47ELsze6aGTJePkJAavgrC3Azp3kSeVdhurEaFkzeFDq/mi8DXloJCZUtrAj4UEL8ZBnnqZ+n7AQ==
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: dyoung@redhat.com, vgoyal@redhat.com, bhe@redhat.com,
        mpe@ellerman.id.au, bauerman@linux.vnet.ibm.com,
        prudo@linux.vnet.ibm.com
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v2 1/7] kexec_file: make an use of purgatory optional
Date: Tue,  6 Mar 2018 19:22:57 +0900
Message-Id: <20180306102303.9063-2-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306102303.9063-1-takahiro.akashi@linaro.org>
References: <20180306102303.9063-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On arm64, crash dump kernel's usable memory is protected by
*unmapping* it from kernel virtual space unlike other architectures
where the region is just made read-only. It is highly unlikely that
the region is accidentally corrupted and this observation rationalizes
that digest check code can also be dropped from purgatory.
The resulting code is so simple as it doesn't require a bit ugly
re-linking/relocation stuff, i.e. arch_kexec_apply_relocations_add().

Please see:
   http://lists.infradead.org/pipermail/linux-arm-kernel/2017-December/545428.html
All that the purgatory does is to shuffle arguments and jump into a new
kernel, while we still need to have some space for a hash value
(purgatory_sha256_digest) which is never checked against.

As such, it doesn't make sense to have trampline code between old kernel
and new kernel on arm64.

This patch introduces a new configuration, ARCH_HAS_KEXEC_PURGATORY, and
allows related code to be compiled in only if necessary.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
---
 arch/powerpc/Kconfig | 3 +++
 arch/x86/Kconfig     | 3 +++
 kernel/kexec_file.c  | 5 +++++
 3 files changed, 11 insertions(+)

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
index e5bcd94c1efb..6dbbb89cbbac 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -532,6 +532,9 @@ static int kexec_calculate_store_digests(struct kimage *image)
 	struct kexec_sha_region *sha_regions;
 	struct purgatory_info *pi = &image->purgatory_info;
 
+	if (!IS_ENABLED(ARCH_HAS_KEXEC_PURGATORY))
+		return 0;
+
 	zero_buf = __va(page_to_pfn(ZERO_PAGE(0)) << PAGE_SHIFT);
 	zero_buf_sz = PAGE_SIZE;
 
@@ -633,6 +636,7 @@ static int kexec_calculate_store_digests(struct kimage *image)
 	return ret;
 }
 
+#ifdef CONFIG_ARCH_HAS_KEXEC_PURGATORY
 /* Actually load purgatory. Lot of code taken from kexec-tools */
 static int __kexec_load_purgatory(struct kimage *image, unsigned long min,
 				  unsigned long max, int top_down)
@@ -1022,3 +1026,4 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
 
 	return 0;
 }
+#endif /* CONFIG_ARCH_HAS_KEXEC_PURGATORY */
-- 
2.16.2

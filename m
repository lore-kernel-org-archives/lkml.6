Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753433AbeCFKXZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 05:23:25 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:39703 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753392AbeCFKXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 05:23:21 -0500
X-Google-Smtp-Source: AG47ELv8WG/ZZklQxamXO4s2HZ1jusTzPJ6qN5uLjTz3XvUM92+/dYKClfw58X307IbGorfTD/Tx6w==
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: dyoung@redhat.com, vgoyal@redhat.com, bhe@redhat.com,
        mpe@ellerman.id.au, bauerman@linux.vnet.ibm.com,
        prudo@linux.vnet.ibm.com
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v2 2/7] kexec_file,x86,powerpc: factor out kexec_file_ops functions
Date: Tue,  6 Mar 2018 19:22:58 +0900
Message-Id: <20180306102303.9063-3-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306102303.9063-1-takahiro.akashi@linaro.org>
References: <20180306102303.9063-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As arch_kexec_kernel_image_{probe,load}(),
arch_kimage_file_post_load_cleanup() and arch_kexec_kernel_verify_sig()
are almost duplicated among architectures, they can be commonalized with
an architecture-defined kexec_file_ops array. So let's factor them out.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kexec.h            |  2 +-
 arch/powerpc/kernel/kexec_elf_64.c          |  2 +-
 arch/powerpc/kernel/machine_kexec_file_64.c | 39 ++-----------------
 arch/x86/include/asm/kexec-bzimage64.h      |  2 +-
 arch/x86/kernel/kexec-bzimage64.c           |  2 +-
 arch/x86/kernel/machine_kexec_64.c          | 45 +---------------------
 include/linux/kexec.h                       | 13 +++----
 kernel/kexec_file.c                         | 60 +++++++++++++++++++++++++++--
 8 files changed, 71 insertions(+), 94 deletions(-)

diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index d8b1e8e7e035..4a585cba1787 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -95,7 +95,7 @@ static inline bool kdump_in_progress(void)
 }
 
 #ifdef CONFIG_KEXEC_FILE
-extern struct kexec_file_ops kexec_elf64_ops;
+extern const struct kexec_file_ops kexec_elf64_ops;
 
 #ifdef CONFIG_IMA_KEXEC
 #define ARCH_HAS_KIMAGE_ARCH
diff --git a/arch/powerpc/kernel/kexec_elf_64.c b/arch/powerpc/kernel/kexec_elf_64.c
index 9a42309b091a..6c78c11c7faf 100644
--- a/arch/powerpc/kernel/kexec_elf_64.c
+++ b/arch/powerpc/kernel/kexec_elf_64.c
@@ -657,7 +657,7 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
 	return ret ? ERR_PTR(ret) : fdt;
 }
 
-struct kexec_file_ops kexec_elf64_ops = {
+const struct kexec_file_ops kexec_elf64_ops = {
 	.probe = elf64_probe,
 	.load = elf64_load,
 };
diff --git a/arch/powerpc/kernel/machine_kexec_file_64.c b/arch/powerpc/kernel/machine_kexec_file_64.c
index e4395f937d63..3a962c87149a 100644
--- a/arch/powerpc/kernel/machine_kexec_file_64.c
+++ b/arch/powerpc/kernel/machine_kexec_file_64.c
@@ -31,52 +31,19 @@
 
 #define SLAVE_CODE_SIZE		256
 
-static struct kexec_file_ops *kexec_file_loaders[] = {
+const struct kexec_file_ops * const kexec_file_loaders[] = {
 	&kexec_elf64_ops,
+	NULL
 };
 
 int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
 				  unsigned long buf_len)
 {
-	int i, ret = -ENOEXEC;
-	struct kexec_file_ops *fops;
-
 	/* We don't support crash kernels yet. */
 	if (image->type == KEXEC_TYPE_CRASH)
 		return -ENOTSUPP;
 
-	for (i = 0; i < ARRAY_SIZE(kexec_file_loaders); i++) {
-		fops = kexec_file_loaders[i];
-		if (!fops || !fops->probe)
-			continue;
-
-		ret = fops->probe(buf, buf_len);
-		if (!ret) {
-			image->fops = fops;
-			return ret;
-		}
-	}
-
-	return ret;
-}
-
-void *arch_kexec_kernel_image_load(struct kimage *image)
-{
-	if (!image->fops || !image->fops->load)
-		return ERR_PTR(-ENOEXEC);
-
-	return image->fops->load(image, image->kernel_buf,
-				 image->kernel_buf_len, image->initrd_buf,
-				 image->initrd_buf_len, image->cmdline_buf,
-				 image->cmdline_buf_len);
-}
-
-int arch_kimage_file_post_load_cleanup(struct kimage *image)
-{
-	if (!image->fops || !image->fops->cleanup)
-		return 0;
-
-	return image->fops->cleanup(image->image_loader_data);
+	return kexec_image_probe_default(image, buf, buf_len);
 }
 
 /**
diff --git a/arch/x86/include/asm/kexec-bzimage64.h b/arch/x86/include/asm/kexec-bzimage64.h
index 9f07cff43705..df89ee7d3e9e 100644
--- a/arch/x86/include/asm/kexec-bzimage64.h
+++ b/arch/x86/include/asm/kexec-bzimage64.h
@@ -2,6 +2,6 @@
 #ifndef _ASM_KEXEC_BZIMAGE64_H
 #define _ASM_KEXEC_BZIMAGE64_H
 
-extern struct kexec_file_ops kexec_bzImage64_ops;
+extern const struct kexec_file_ops kexec_bzImage64_ops;
 
 #endif  /* _ASM_KEXE_BZIMAGE64_H */
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index fb095ba0c02f..705654776c0c 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -538,7 +538,7 @@ static int bzImage64_verify_sig(const char *kernel, unsigned long kernel_len)
 }
 #endif
 
-struct kexec_file_ops kexec_bzImage64_ops = {
+const struct kexec_file_ops kexec_bzImage64_ops = {
 	.probe = bzImage64_probe,
 	.load = bzImage64_load,
 	.cleanup = bzImage64_cleanup,
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 1f790cf9d38f..2cdd29d64181 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -30,8 +30,9 @@
 #include <asm/set_memory.h>
 
 #ifdef CONFIG_KEXEC_FILE
-static struct kexec_file_ops *kexec_file_loaders[] = {
+const struct kexec_file_ops * const kexec_file_loaders[] = {
 		&kexec_bzImage64_ops,
+		NULL
 };
 #endif
 
@@ -363,27 +364,6 @@ void arch_crash_save_vmcoreinfo(void)
 /* arch-dependent functionality related to kexec file-based syscall */
 
 #ifdef CONFIG_KEXEC_FILE
-int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
-				  unsigned long buf_len)
-{
-	int i, ret = -ENOEXEC;
-	struct kexec_file_ops *fops;
-
-	for (i = 0; i < ARRAY_SIZE(kexec_file_loaders); i++) {
-		fops = kexec_file_loaders[i];
-		if (!fops || !fops->probe)
-			continue;
-
-		ret = fops->probe(buf, buf_len);
-		if (!ret) {
-			image->fops = fops;
-			return ret;
-		}
-	}
-
-	return ret;
-}
-
 void *arch_kexec_kernel_image_load(struct kimage *image)
 {
 	vfree(image->arch.elf_headers);
@@ -398,27 +378,6 @@ void *arch_kexec_kernel_image_load(struct kimage *image)
 				 image->cmdline_buf_len);
 }
 
-int arch_kimage_file_post_load_cleanup(struct kimage *image)
-{
-	if (!image->fops || !image->fops->cleanup)
-		return 0;
-
-	return image->fops->cleanup(image->image_loader_data);
-}
-
-#ifdef CONFIG_KEXEC_VERIFY_SIG
-int arch_kexec_kernel_verify_sig(struct kimage *image, void *kernel,
-				 unsigned long kernel_len)
-{
-	if (!image->fops || !image->fops->verify_sig) {
-		pr_debug("kernel loader does not support signature verification.");
-		return -EKEYREJECTED;
-	}
-
-	return image->fops->verify_sig(kernel, kernel_len);
-}
-#endif
-
 /*
  * Apply purgatory relocations.
  *
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index f16f6ceb3875..4ed18cc718fc 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -135,6 +135,11 @@ struct kexec_file_ops {
 #endif
 };
 
+extern const struct kexec_file_ops * const kexec_file_loaders[];
+
+int kexec_image_probe_default(struct kimage *image, void *buf,
+			      unsigned long buf_len);
+
 /**
  * struct kexec_buf - parameters for finding a place for a buffer in memory
  * @image:	kexec image in which memory to search.
@@ -209,7 +214,7 @@ struct kimage {
 	unsigned long cmdline_buf_len;
 
 	/* File operations provided by image loader */
-	struct kexec_file_ops *fops;
+	const struct kexec_file_ops *fops;
 
 	/* Image loader handling the kernel can store a pointer here */
 	void *image_loader_data;
@@ -277,12 +282,6 @@ int crash_shrink_memory(unsigned long new_size);
 size_t crash_get_memory_size(void);
 void crash_free_reserved_phys_range(unsigned long begin, unsigned long end);
 
-int __weak arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
-					 unsigned long buf_len);
-void * __weak arch_kexec_kernel_image_load(struct kimage *image);
-int __weak arch_kimage_file_post_load_cleanup(struct kimage *image);
-int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
-					unsigned long buf_len);
 int __weak arch_kexec_apply_relocations_add(const Elf_Ehdr *ehdr,
 					Elf_Shdr *sechdrs, unsigned int relsec);
 int __weak arch_kexec_apply_relocations(const Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 6dbbb89cbbac..6a62c5ef8a07 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -28,28 +28,80 @@
 
 static int kexec_calculate_store_digests(struct kimage *image);
 
+/*
+ * Currently this is the only default function that is exported as some
+ * architectures need it to do additional handlings.
+ * In the future, other default functions may be exported too if required.
+ */
+int kexec_image_probe_default(struct kimage *image, void *buf,
+			      unsigned long buf_len)
+{
+	const struct kexec_file_ops * const *fops;
+	int ret = -ENOEXEC;
+
+	for (fops = &kexec_file_loaders[0]; *fops && (*fops)->probe; ++fops) {
+		ret = (*fops)->probe(buf, buf_len);
+		if (!ret) {
+			image->fops = *fops;
+			return ret;
+		}
+	}
+
+	return ret;
+}
+
 /* Architectures can provide this probe function */
 int __weak arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
 					 unsigned long buf_len)
 {
-	return -ENOEXEC;
+	return kexec_image_probe_default(image, buf, buf_len);
+}
+
+static void *kexec_image_load_default(struct kimage *image)
+{
+	if (!image->fops || !image->fops->load)
+		return ERR_PTR(-ENOEXEC);
+
+	return image->fops->load(image, image->kernel_buf,
+				 image->kernel_buf_len, image->initrd_buf,
+				 image->initrd_buf_len, image->cmdline_buf,
+				 image->cmdline_buf_len);
 }
 
 void * __weak arch_kexec_kernel_image_load(struct kimage *image)
 {
-	return ERR_PTR(-ENOEXEC);
+	return kexec_image_load_default(image);
+}
+
+static int kexec_image_post_load_cleanup_default(struct kimage *image)
+{
+	if (!image->fops || !image->fops->cleanup)
+		return 0;
+
+	return image->fops->cleanup(image->image_loader_data);
 }
 
 int __weak arch_kimage_file_post_load_cleanup(struct kimage *image)
 {
-	return -EINVAL;
+	return kexec_image_post_load_cleanup_default(image);
 }
 
 #ifdef CONFIG_KEXEC_VERIFY_SIG
+static int kexec_image_verify_sig_default(struct kimage *image, void *buf,
+					  unsigned long buf_len)
+{
+	if (!image->fops || !image->fops->verify_sig) {
+		pr_debug("kernel loader does not support signature verification.\n");
+		return -EKEYREJECTED;
+	}
+
+	return image->fops->verify_sig(buf, buf_len);
+}
+
 int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
 					unsigned long buf_len)
 {
-	return -EKEYREJECTED;
+	return kexec_image_verify_sig_default(image, buf, buf_len);
 }
 #endif
 
-- 
2.16.2

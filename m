Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932218AbeBVLTz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 06:19:55 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:39038 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753643AbeBVLTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 06:19:49 -0500
X-Google-Smtp-Source: AG47ELuqrzntbA0comRuXh1Bsg0JzZAM7NmXscXsxl7uRfoQJCdY5I8JjN21bK84iwpM2FJ0PAO0uw==
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
Subject: [PATCH v8 10/13] arm64: kexec_file: add Image format support
Date: Thu, 22 Feb 2018 20:17:29 +0900
Message-Id: <20180222111732.23051-11-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180222111732.23051-1-takahiro.akashi@linaro.org>
References: <20180222111732.23051-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides kexec_file_ops for "Image"-format kernel. Please note
that a binary is always loaded at an offset based on its text_offset field.

While this patch doesn't contains CONFIG_KEXEC_VERIFY_SIG support,
that is to be added in a later patch in this series, file-attribute-based
kernel verification can now be materialised by enabling IMA security
subsystem.
See more details about IMA here:
    https://sourceforge.net/p/linux-ima/wiki/Home/

You can sign(label) a kernel image on target filesystem to be kexec-ed
with:
    $ evmctl ima_sign --key /path/to/private_key.pem Image

On live system, you must have IMA enforced with, at least, the following
security policy:
    "appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig"

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/kexec.h         | 50 +++++++++++++++++++
 arch/arm64/kernel/Makefile             |  2 +-
 arch/arm64/kernel/kexec_image.c        | 90 ++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/machine_kexec_file.c |  1 +
 4 files changed, 142 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kernel/kexec_image.c

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index d7427d510e1b..592890085aae 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -105,6 +105,56 @@ struct kimage_arch {
 	unsigned long elf_load_addr;
 };
 
+/**
+ * struct arm64_image_header - arm64 kernel image header
+ *
+ * @pe_sig: Optional PE format 'MZ' signature
+ * @branch_code: Instruction to branch to stext
+ * @text_offset: Image load offset, little endian
+ * @image_size: Effective image size, little endian
+ * @flags:
+ *	Bit 0: Kernel endianness. 0=little endian, 1=big endian
+ * @reserved: Reserved
+ * @magic: Magic number, "ARM\x64"
+ * @pe_header: Optional offset to a PE format header
+ **/
+
+struct arm64_image_header {
+	u8 pe_sig[2];
+	u8 pad[2];
+	u32 branch_code;
+	u64 text_offset;
+	u64 image_size;
+	u64 flags;
+	u64 reserved[3];
+	u8 magic[4];
+	u32 pe_header;
+};
+
+static const u8 arm64_image_magic[4] = {'A', 'R', 'M', 0x64U};
+
+/**
+ * arm64_header_check_magic - Helper to check the arm64 image header.
+ *
+ * Returns non-zero if header is OK.
+ */
+
+static inline int arm64_header_check_magic(const struct arm64_image_header *h)
+{
+	if (!h)
+		return 0;
+
+	if (!h->text_offset)
+		return 0;
+
+	return (h->magic[0] == arm64_image_magic[0]
+		&& h->magic[1] == arm64_image_magic[1]
+		&& h->magic[2] == arm64_image_magic[2]
+		&& h->magic[3] == arm64_image_magic[3]);
+}
+
+extern const struct kexec_file_ops kexec_image_ops;
+
 struct kimage;
 
 #define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cleanup
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 151dc890737c..454b2735603a 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -49,7 +49,7 @@ arm64-obj-$(CONFIG_RANDOMIZE_BASE)	+= kaslr.o
 arm64-obj-$(CONFIG_HIBERNATION)		+= hibernate.o hibernate-asm.o
 arm64-obj-$(CONFIG_KEXEC_CORE)		+= machine_kexec.o relocate_kernel.o	\
 					   cpu-reset.o
-arm64-obj-$(CONFIG_KEXEC_FILE)		+= machine_kexec_file.o
+arm64-obj-$(CONFIG_KEXEC_FILE)		+= machine_kexec_file.o kexec_image.o
 arm64-obj-$(CONFIG_ARM64_RELOC_TEST)	+= arm64-reloc-test.o
 arm64-reloc-test-y := reloc_test_core.o reloc_test_syms.o
 arm64-obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o
diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
new file mode 100644
index 000000000000..de62def63dd6
--- /dev/null
+++ b/arch/arm64/kernel/kexec_image.c
@@ -0,0 +1,90 @@
+/*
+ * Kexec image loader
+
+ * Copyright (C) 2018 Linaro Limited
+ * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#define pr_fmt(fmt)	"kexec_file(Image): " fmt
+
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/kexec.h>
+#include <asm/byteorder.h>
+#include <asm/memory.h>
+
+static int image_probe(const char *kernel_buf, unsigned long kernel_len)
+{
+	const struct arm64_image_header *h;
+
+	h = (const struct arm64_image_header *)(kernel_buf);
+
+	if ((kernel_len < sizeof(*h)) || !arm64_header_check_magic(h))
+		return -EINVAL;
+
+	return 0;
+}
+
+static void *image_load(struct kimage *image, char *kernel,
+			    unsigned long kernel_len, char *initrd,
+			    unsigned long initrd_len, char *cmdline,
+			    unsigned long cmdline_len)
+{
+	struct kexec_buf kbuf;
+	struct arm64_image_header *h = (struct arm64_image_header *)kernel;
+	unsigned long text_offset;
+	int ret;
+
+	/* Create elf core header segment */
+	ret = load_crashdump_segments(image);
+	if (ret)
+		goto out;
+
+	/* Load the kernel */
+	kbuf.image = image;
+	if (image->type == KEXEC_TYPE_CRASH) {
+		kbuf.buf_min = crashk_res.start;
+		kbuf.buf_max = crashk_res.end + 1;
+	} else {
+		kbuf.buf_min = 0;
+		kbuf.buf_max = ULONG_MAX;
+	}
+	kbuf.top_down = 0;
+
+	kbuf.buffer = kernel;
+	kbuf.bufsz = kernel_len;
+	kbuf.memsz = le64_to_cpu(h->image_size);
+	text_offset = le64_to_cpu(h->text_offset);
+	kbuf.buf_align = SZ_2M;
+
+	/* Adjust kernel segment with TEXT_OFFSET */
+	kbuf.memsz += text_offset;
+
+	ret = kexec_add_buffer(&kbuf);
+	if (ret)
+		goto out;
+
+	image->segment[image->nr_segments - 1].mem += text_offset;
+	image->segment[image->nr_segments - 1].memsz -= text_offset;
+	image->start = kbuf.mem + text_offset;
+
+	pr_debug("Loaded kernel at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+		 image->start, kbuf.bufsz, kbuf.memsz);
+
+	/* Load additional data */
+	ret = load_other_segments(image, image->start,
+			    initrd, initrd_len, cmdline, cmdline_len);
+
+out:
+	return ERR_PTR(ret);
+}
+
+const struct kexec_file_ops kexec_image_ops = {
+	.probe = image_probe,
+	.load = image_load,
+};
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index fc132047c8cd..384146583f8d 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -25,6 +25,7 @@ static int __dt_root_addr_cells;
 static int __dt_root_size_cells;
 
 const struct kexec_file_ops * const kexec_file_loaders[] = {
+	&kexec_image_ops,
 	NULL
 };
 
-- 
2.16.2

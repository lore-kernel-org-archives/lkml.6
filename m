Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751907AbeDYG2b (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 02:28:31 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36262 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751497AbeDYG1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 02:27:16 -0400
X-Google-Smtp-Source: AIpwx49v2gFy19e33kEDFsOqhWN9Vpqg5VlFTidMmFVcjZk6OG51s5xbzEU4qOfhQUsu5eW74E+Y+A==
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net,
        dyoung@redhat.com, bhe@redhat.com, arnd@arndb.de
Cc: ard.biesheuvel@linaro.org, james.morse@arm.com, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v9 06/11] arm64: kexec_file: allow for loading Image-format kernel
Date: Wed, 25 Apr 2018 15:26:24 +0900
Message-Id: <20180425062629.29404-7-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425062629.29404-1-takahiro.akashi@linaro.org>
References: <20180425062629.29404-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides kexec_file_ops for "Image"-format kernel. In this
implementation, a binary is always loaded with a fixed offset identified
in text_offset field of its header.

Regarding signature verification for trusted boot, this patch doesn't
contains CONFIG_KEXEC_VERIFY_SIG support, which is to be added later
in this series, but file-attribute-based verification is still a viable
option by enabling IMA security subsystem.

You can sign(label) a to-be-kexec'ed kernel image on target file system
with:
    $ evmctl ima_sign --key /path/to/private_key.pem Image

On live system, you must have IMA enforced with, at least, the following
security policy:
    "appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig"

See more details about IMA here:
    https://sourceforge.net/p/linux-ima/wiki/Home/

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/kexec.h         | 50 ++++++++++++++++
 arch/arm64/kernel/Makefile             |  2 +-
 arch/arm64/kernel/kexec_image.c        | 79 ++++++++++++++++++++++++++
 arch/arm64/kernel/machine_kexec_file.c |  1 +
 4 files changed, 131 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kernel/kexec_image.c

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index e4de1223715f..3cba4161818a 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -102,6 +102,56 @@ struct kimage_arch {
 	void *dtb_buf;
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
 
 extern int load_other_segments(struct kimage *image,
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 2f2b2757ae7a..1e110aa571dd 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -50,7 +50,7 @@ arm64-obj-$(CONFIG_RANDOMIZE_BASE)	+= kaslr.o
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
index 000000000000..4dd524ad6611
--- /dev/null
+++ b/arch/arm64/kernel/kexec_image.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Kexec image loader
+
+ * Copyright (C) 2018 Linaro Limited
+ * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
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
+static void *image_load(struct kimage *image,
+				char *kernel, unsigned long kernel_len,
+				char *initrd, unsigned long initrd_len,
+				char *cmdline, unsigned long cmdline_len)
+{
+	struct kexec_buf kbuf;
+	struct arm64_image_header *h = (struct arm64_image_header *)kernel;
+	unsigned long text_offset;
+	int ret;
+
+	/* Load the kernel */
+	kbuf.image = image;
+	kbuf.buf_min = 0;
+	kbuf.buf_max = ULONG_MAX;
+	kbuf.top_down = false;
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
+	image->arch.kern_segment = image->nr_segments - 1;
+	image->segment[image->arch.kern_segment].mem += text_offset;
+	image->segment[image->arch.kern_segment].memsz -= text_offset;
+	image->start = image->segment[image->arch.kern_segment].mem;
+
+	pr_debug("Loaded kernel at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+				image->segment[image->arch.kern_segment].mem,
+				kbuf.bufsz, kbuf.memsz);
+
+	/* Load additional data */
+	ret = load_other_segments(image, initrd, initrd_len,
+				cmdline, cmdline_len);
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
index b3b9b1725d8a..37c0a9dc2e47 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -23,6 +23,7 @@ static int __dt_root_addr_cells;
 static int __dt_root_size_cells;
 
 const struct kexec_file_ops * const kexec_file_loaders[] = {
+	&kexec_image_ops,
 	NULL
 };
 
-- 
2.17.0

Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0389C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 982BF2172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LiLd3clS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 982BF2172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbeI1NLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:11:19 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33028 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeI1NLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:11:19 -0400
Received: by mail-pf1-f193.google.com with SMTP id d4-v6so3655172pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 23:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gw6DpdgEdV2DBE7O7Gc03v3qbMo6bneJnE0aBac4sK8=;
        b=LiLd3clShYknPkFbvlOw8zSiZ3fVRzVFhqMxFPLPEts1PMk8QuaFZqU8O3HyH/9Rod
         Ksbo+V45gS2bLDf8tUJyhQOA4opizyZcKnmLmCfU67W0Dn8bc0K2z9IlJPcCDQX/ssVl
         NgtfhxevCcg11R3NebgBwz79MUanvpbTJfcOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gw6DpdgEdV2DBE7O7Gc03v3qbMo6bneJnE0aBac4sK8=;
        b=klawPis60XXirjrNxCTOuVxLKADdE3ZI0VHJ0FjTU5+oafQX97LiQA5V4nmmT8bnOZ
         nglIngzuGrmtPpjeNY1R9nTQNanXEud+Zxy/kSuyonN/aOhpoBqy7iK3eEY7M4UP4ux/
         9fuXyuTmpuZRlyQs+tz/duhVsbzH+8ELYadXYc8vJzOijdPCxwEZcmTm1KA1ChgUo0Ya
         JePl8u3WSzOv+kmsdxqxncgjgb2QCyGd4yTH6n3RpRfulFH7IUOenkLOlFPLOK+pH1Re
         85Ga9B6fQZqipkF2ShcJ43hXPHjSBfL1RZiGPVcM9Lo58yl8kQsojNLdp6VvdAQHWAP4
         3hww==
X-Gm-Message-State: ABuFfogpVd1Mw6hHBg+uOUpLAQ6vxzOydiFF4s66mENCvs/6Cx5PGvJG
        YVO9CQK4rcc6rgq929qe17FzLQ==
X-Google-Smtp-Source: ACcGV61gl+PfCsua2qPDoJAAFHJtEOy0AbNcNcUNrdRqHoFbsOiDx5EX3+ZN/iNiULu0vZxXkchpSQ==
X-Received: by 2002:a17:902:784a:: with SMTP id e10-v6mr14612572pln.197.1538117343963;
        Thu, 27 Sep 2018 23:49:03 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id j27-v6sm7623704pfj.91.2018.09.27.23.49.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 23:49:02 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc:     prudo@linux.ibm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v15 11/16] arm64: kexec_file: allow for loading Image-format kernel
Date:   Fri, 28 Sep 2018 15:48:36 +0900
Message-Id: <20180928064841.14117-12-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180928064841.14117-1-takahiro.akashi@linaro.org>
References: <20180928064841.14117-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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
Reviewed-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/kexec.h         |  28 +++++++
 arch/arm64/kernel/Makefile             |   2 +-
 arch/arm64/kernel/kexec_image.c        | 108 +++++++++++++++++++++++++
 arch/arm64/kernel/machine_kexec_file.c |   1 +
 4 files changed, 138 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kernel/kexec_image.c

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 157b2897d911..5e673481b3a3 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -101,6 +101,34 @@ struct kimage_arch {
 	unsigned long dtb_mem;
 };
 
+/**
+ * struct arm64_image_header - arm64 kernel image header
+ * See Documentation/arm64/booting.txt for details
+ *
+ * @mz_magic: DOS header magic number ('MZ', optional)
+ * @code1: Instruction (branch to stext)
+ * @text_offset: Image load offset
+ * @image_size: Effective image size
+ * @flags: Bit-field flags
+ * @reserved: Reserved
+ * @magic: Magic number
+ * @pe_header: Offset to PE COFF header (optional)
+ **/
+
+struct arm64_image_header {
+	__le16 mz_magic; /* also code0 */
+	__le16 pad;
+	__le32 code1;
+	__le64 text_offset;
+	__le64 image_size;
+	__le64 flags;
+	__le64 reserved[3];
+	__le32 magic;
+	__le32 pe_header;
+};
+
+extern const struct kexec_file_ops kexec_image_ops;
+
 struct kimage;
 
 extern int arch_kimage_file_post_load_cleanup(struct kimage *image);
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 030a39bff117..48868255f09c 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -51,7 +51,7 @@ arm64-obj-$(CONFIG_RANDOMIZE_BASE)	+= kaslr.o
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
index 000000000000..d64f5e9f9d22
--- /dev/null
+++ b/arch/arm64/kernel/kexec_image.c
@@ -0,0 +1,108 @@
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
+#include <linux/string.h>
+#include <asm/boot.h>
+#include <asm/byteorder.h>
+#include <asm/cpufeature.h>
+#include <asm/memory.h>
+
+static int image_probe(const char *kernel_buf, unsigned long kernel_len)
+{
+	const struct arm64_image_header *h;
+
+	h = (const struct arm64_image_header *)(kernel_buf);
+
+	if (!h || (kernel_len < sizeof(*h)) ||
+			memcmp(&h->magic, ARM64_MAGIC, sizeof(h->magic)))
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
+	struct arm64_image_header *h;
+	u64 flags, value;
+	struct kexec_buf kbuf;
+	unsigned long text_offset;
+	struct kexec_segment *kernel_segment;
+	int ret;
+
+	/* Don't support old kernel */
+	h = (struct arm64_image_header *)kernel;
+	if (!h->text_offset)
+		return ERR_PTR(-EINVAL);
+
+	/* Check cpu features */
+	flags = le64_to_cpu(h->flags);
+	value = head_flag_field(flags, HEAD_FLAG_BE);
+	if (((value == HEAD_FLAG_BE) && !IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)) ||
+	    ((value != HEAD_FLAG_BE) && IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)))
+		if (!system_supports_mixed_endian())
+			return ERR_PTR(-EINVAL);
+
+	value = head_flag_field(flags, HEAD_FLAG_PAGE_SIZE);
+	if (((value == HEAD_FLAG_PAGE_SIZE_4K) &&
+			!system_supports_4kb_granule()) ||
+	    ((value == HEAD_FLAG_PAGE_SIZE_64K) &&
+			!system_supports_64kb_granule()) ||
+	    ((value == HEAD_FLAG_PAGE_SIZE_16K) &&
+			!system_supports_16kb_granule()))
+		return ERR_PTR(-EINVAL);
+
+	/* Load the kernel */
+	kbuf.image = image;
+	kbuf.buf_min = 0;
+	kbuf.buf_max = ULONG_MAX;
+	kbuf.top_down = false;
+
+	kbuf.buffer = kernel;
+	kbuf.bufsz = kernel_len;
+	kbuf.mem = 0;
+	kbuf.memsz = le64_to_cpu(h->image_size);
+	text_offset = le64_to_cpu(h->text_offset);
+	kbuf.buf_align = MIN_KIMG_ALIGN;
+
+	/* Adjust kernel segment with TEXT_OFFSET */
+	kbuf.memsz += text_offset;
+
+	ret = kexec_add_buffer(&kbuf);
+	if (ret)
+		return ERR_PTR(ret);
+
+	kernel_segment = &image->segment[image->nr_segments - 1];
+	kernel_segment->mem += text_offset;
+	kernel_segment->memsz -= text_offset;
+	image->start = kernel_segment->mem;
+
+	pr_debug("Loaded kernel at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+				kernel_segment->mem, kbuf.bufsz,
+				kernel_segment->memsz);
+
+	/* Load additional data */
+	ret = load_other_segments(image,
+				kernel_segment->mem, kernel_segment->memsz,
+				initrd, initrd_len, cmdline, cmdline_len);
+
+	return ERR_PTR(ret);
+}
+
+const struct kexec_file_ops kexec_image_ops = {
+	.probe = image_probe,
+	.load = image_load,
+};
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index f53f14bd1700..05fb2d4e6fef 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -25,6 +25,7 @@
 #define FDT_PSTR_BOOTARGS	"bootargs"
 
 const struct kexec_file_ops * const kexec_file_loaders[] = {
+	&kexec_image_ops,
 	NULL
 };
 
-- 
2.19.0


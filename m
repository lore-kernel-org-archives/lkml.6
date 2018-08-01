Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF539C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B86F20841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NwmscwYW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B86F20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388517AbeHAJp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 05:45:27 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33673 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387665AbeHAJp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 05:45:27 -0400
Received: by mail-pl0-f65.google.com with SMTP id 6-v6so8408247plb.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 01:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KyUS6TzJ7Jh2ZgQG+yZL9wQAPjkM+l82AYNmWJn5tsA=;
        b=NwmscwYWhqZON8CZseKhpgwawplUbNJN7/b2gDIO+S3brOWLLrCVuT0HsDWjOI5tAf
         i/izdBfGKLCi7iukZUaomqzIUFXKMYv9aNs+WSxYU3bvXXU8fxmyb1YXeafnCHhd8oFw
         StriFjJ5JMjSHdVXfWvZ79jYjFP4OXFHYXgB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KyUS6TzJ7Jh2ZgQG+yZL9wQAPjkM+l82AYNmWJn5tsA=;
        b=YWaN4D64E506aweLbUDxlnmfGH51sOof7UBdrUJLZ3hPZ+FPiW9VlcUW7nzBpS/iEZ
         JX2QOQ3WMNFUttuKBpu1lRLFCCsC1OX5S9PFTjv+mZiZAJV8/3cwl7JrkV1RSZca5+2K
         g/KSNk1WeLbTJcwRprMrKPPD2TEz14TMP/TXguKeBmAD+W0ilAeDnlJxzlU9XKr7WdDU
         AUxbDo3pvMmexRJUnrumhqXxAlNOliD4oUVhIsaQKewfbPyfJ4H8yggumiE7y/q141QH
         q1GiytA2V5O2gL+3EWfmemR/JzesHcd8lUukOl6iAemCE+Sd53YglqRZ4FA26nhzL0Sj
         g3JA==
X-Gm-Message-State: AOUpUlEee5kEC1fZrEKZCiX+vmQjTqbAqZNN8YxWqsF016Khf2KS8YQr
        vc8jdad9FXrba95c7MZ4INv1BQ==
X-Google-Smtp-Source: AAOMgpf2ju1RI4PpxT/qDFHLf+d/1AsAffsW46/HN6hBAHfVD6jPpBKGAI9XmbeFoMY+HC8cMCa/bA==
X-Received: by 2002:a17:902:b08d:: with SMTP id p13-v6mr24237716plr.0.1533110460349;
        Wed, 01 Aug 2018 01:01:00 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id w16-v6sm40801764pfi.101.2018.08.01.01.00.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 01:00:59 -0700 (PDT)
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
Subject: [PATCH v13 11/16] arm64: kexec_file: allow for loading Image-format kernel
Date:   Wed,  1 Aug 2018 16:58:15 +0900
Message-Id: <20180801075820.3753-12-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801075820.3753-1-takahiro.akashi@linaro.org>
References: <20180801075820.3753-1-takahiro.akashi@linaro.org>
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
index 8f1326b2d327..8cd514855eec 100644
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
2.18.0


Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227A7C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 05:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D49D92087E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 05:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ePmGRPD/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D49D92087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbeKOP7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 10:59:52 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:35769 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbeKOP7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 10:59:51 -0500
Received: by mail-yb1-f196.google.com with SMTP id z2-v6so7936833ybj.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 21:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b/qBGuWcB3AvKhVU7KrMVZKitcb+1TETY1zXig3nkL8=;
        b=ePmGRPD/oeb9REqt++JiB70heutg065ySKrqGdSWOo6V5eqn8wiA24QgJuenmDeyFk
         1iU6Hqv7BMepvqiJQeneS65cQHkI+MvsNKWOLaIzc5Rn/YNWtV7FDNzLRHsuHFQLiB1e
         534e/vv7LkINcd7EBeWsoB8UJ1v2seIiyR5ME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b/qBGuWcB3AvKhVU7KrMVZKitcb+1TETY1zXig3nkL8=;
        b=MvqT6jSt6K5QIH42kQjmYQUREoSf3EAR+OcJmvvUSOvxrHMZbc21QHQ0lcBVMyTl8f
         7buCb19xeLlec6GJ67W/9kNp0m0wg2CvV2BpWO5cHsLIFPLJTvsrbHpS0QDHVFe+fBK2
         4ZdriMNZOX4Z3QTmq31Wq32hsl+QsW9WMuW0p8yb1SRYw+7XumH/jE9zfil+0pJyAzR7
         v+s4OcpWNN64M9PyxsYaPmBbyK4OEhTUBVM60KmIJyDN4XPZa9+ChAv+XqaK38K8rERM
         ngAwYFI8B9SpoHXLuchtCpOIPOra4SpkY6g/t9vggtSuTkNB5kJ3i6tB5jdxkKyStaB6
         KXBQ==
X-Gm-Message-State: AGRZ1gL5FtDBc5Dcc9RR+ZTBXG9qcpd8V815NGG/wAzdV81scJtbvv8j
        HhNeQeyDebMZd/uOxLqRYl3L2A==
X-Google-Smtp-Source: AJdET5dH4rEzZh8i+E6gSIZ0HFdqA3dZXkUlcaFjdz653JDznaf97xCNXQk2EwE2lSQ7wdDFWLbBgQ==
X-Received: by 2002:a25:84c7:: with SMTP id x7-v6mr4494386ybm.230.1542261205259;
        Wed, 14 Nov 2018 21:53:25 -0800 (PST)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id g21-v6sm7549135ywk.5.2018.11.14.21.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 21:53:24 -0800 (PST)
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
Subject: [PATCH v16 11/16] arm64: kexec_file: allow for loading Image-format kernel
Date:   Thu, 15 Nov 2018 14:52:50 +0900
Message-Id: <20181115055254.2812-12-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181115055254.2812-1-takahiro.akashi@linaro.org>
References: <20181115055254.2812-1-takahiro.akashi@linaro.org>
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
 arch/arm64/include/asm/kexec.h         |   2 +
 arch/arm64/kernel/Makefile             |   2 +-
 arch/arm64/kernel/kexec_image.c        | 113 +++++++++++++++++++++++++
 arch/arm64/kernel/machine_kexec_file.c |   1 +
 4 files changed, 117 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kernel/kexec_image.c

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index bbb5f505b0ba..67e4cb75d1fd 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -101,6 +101,8 @@ struct kimage_arch {
 	unsigned long dtb_mem;
 };
 
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
index 000000000000..9f0d8b5d62d3
--- /dev/null
+++ b/arch/arm64/kernel/kexec_image.c
@@ -0,0 +1,113 @@
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
+#include <asm/byteorder.h>
+#include <asm/cpufeature.h>
+#include <asm/image.h>
+#include <asm/memory.h>
+
+static int image_probe(const char *kernel_buf, unsigned long kernel_len)
+{
+	const struct arm64_image_header *h;
+
+	h = (const struct arm64_image_header *)(kernel_buf);
+
+	if (!h || (kernel_len < sizeof(*h)) ||
+			memcmp(&h->magic, ARM64_IMAGE_MAGIC,
+				sizeof(h->magic)))
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
+	bool be_image, be_kernel;
+	struct kexec_buf kbuf;
+	unsigned long text_offset;
+	struct kexec_segment *kernel_segment;
+	int ret;
+
+	/*
+	 * We require a kernel with an unambiguous Image header. Per
+	 * Documentation/booting.txt, this is the case when image_size
+	 * is non-zero (practically speaking, since v3.17).
+	 */
+	h = (struct arm64_image_header *)kernel;
+	if (!h->image_size)
+		return ERR_PTR(-EINVAL);
+
+	/* Check cpu features */
+	flags = le64_to_cpu(h->flags);
+	be_image = arm64_image_flag_field(flags, ARM64_IMAGE_FLAG_BE);
+	be_kernel = IS_ENABLED(CONFIG_CPU_BIG_ENDIAN);
+	if ((be_image != be_kernel) && !system_supports_mixed_endian())
+		return ERR_PTR(-EINVAL);
+
+	value = arm64_image_flag_field(flags, ARM64_IMAGE_FLAG_PAGE_SIZE);
+	if (((value == ARM64_IMAGE_FLAG_PAGE_SIZE_4K) &&
+			!system_supports_4kb_granule()) ||
+	    ((value == ARM64_IMAGE_FLAG_PAGE_SIZE_64K) &&
+			!system_supports_64kb_granule()) ||
+	    ((value == ARM64_IMAGE_FLAG_PAGE_SIZE_16K) &&
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
+				initrd, initrd_len, cmdline);
+
+	return ERR_PTR(ret);
+}
+
+const struct kexec_file_ops kexec_image_ops = {
+	.probe = image_probe,
+	.load = image_load,
+};
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index b433d947d486..7e9d5ed3e238 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -26,6 +26,7 @@
 #define FDT_PSTR_BOOTARGS	"bootargs"
 
 const struct kexec_file_ops * const kexec_file_loaders[] = {
+	&kexec_image_ops,
 	NULL
 };
 
-- 
2.19.0


Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451CDC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC1C82172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NmzOBt9S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC1C82172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbeI1NLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:11:12 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39033 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeI1NLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:11:11 -0400
Received: by mail-pg1-f193.google.com with SMTP id 85-v6so3729080pge.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 23:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vzr4R2Cq+6LI3NmBny8qeM6kKSI6IrCINci/4DwDurI=;
        b=NmzOBt9SYJiINTopNWJxES3Ii8Ip9h3YBRbfaMCfqDxr+8HgduY2+snZV3WvaKyjno
         jDgQ16BL5b0xBDer5t1T3srjxKkpSzcni4ev0szNZIZPI4/jnkEEoULsl0tM6bfFznQ9
         0JtluZuWp7YbRG6fdx4+uCgn1rGy1WS7XfLGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vzr4R2Cq+6LI3NmBny8qeM6kKSI6IrCINci/4DwDurI=;
        b=XdBPkLxfXj9Kf74eHxkzHVyU80eeY1WIsWmPni2K0a5tYf855BtiYPH0qwPq5z2aXw
         j0gEQXf7GppYAXXriBhz7xOXoC4+ufmkAdHttPHEEPZWw/5G3sKo+T1/JpeLo7AXNbhP
         zGUjTolCo1Yla4OV7MZ+5DI53CeEUxOosA06ySMAFXe7fTS2uxC55i34SQ/aZ5jgIEs+
         SyzXX83w1liyzy+EeFOrvg9pPPwMeMM2Fagf8Yh9gEMXvT0L9xp0lpjm4HOjIduBiP9g
         3CcYLMV6Lj+I8Fa8jDSOU/ABJQ4pR3s9AI4tN2uVXUkmDcKHLQ1BuYXpsBZDc1viS8ZL
         9Yzw==
X-Gm-Message-State: ABuFfoj3/oP91/fDtw7XHHed6Bb8I++62K1Ll0UPrc4QjXbXJ30V+l6o
        rAOMF5L8qOtyNLd/7uiOIzLrrg==
X-Google-Smtp-Source: ACcGV60RgPyS9f47l+aARxAWCcz+1AQ7BKGkss9wGAbsBBA/sz9LziQDQSp3FK7759bsa9TsuqflMQ==
X-Received: by 2002:a62:2646:: with SMTP id m67-v6mr15207110pfm.254.1538117336614;
        Thu, 27 Sep 2018 23:48:56 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id f6-v6sm5316468pgf.52.2018.09.27.23.48.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 23:48:55 -0700 (PDT)
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
Subject: [PATCH v15 10/16] arm64: kexec_file: load initrd and device-tree
Date:   Fri, 28 Sep 2018 15:48:35 +0900
Message-Id: <20180928064841.14117-11-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180928064841.14117-1-takahiro.akashi@linaro.org>
References: <20180928064841.14117-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

load_other_segments() is expected to allocate and place all the necessary
memory segments other than kernel, including initrd and device-tree
blob (and elf core header for crash).
While most of the code was borrowed from kexec-tools' counterpart,
users may not be allowed to specify dtb explicitly, instead, the dtb
presented by the original boot loader is reused.

arch_kimage_kernel_post_load_cleanup() is responsible for freeing arm64-
specific data allocated in load_other_segments().

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Reviewed-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/kexec.h         |  17 +++
 arch/arm64/kernel/machine_kexec_file.c | 188 +++++++++++++++++++++++++
 2 files changed, 205 insertions(+)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index e17f0529a882..157b2897d911 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -93,6 +93,23 @@ static inline void crash_prepare_suspend(void) {}
 static inline void crash_post_resume(void) {}
 #endif
 
+#ifdef CONFIG_KEXEC_FILE
+#define ARCH_HAS_KIMAGE_ARCH
+
+struct kimage_arch {
+	void *dtb;
+	unsigned long dtb_mem;
+};
+
+struct kimage;
+
+extern int arch_kimage_file_post_load_cleanup(struct kimage *image);
+extern int load_other_segments(struct kimage *image,
+		unsigned long kernel_load_addr, unsigned long kernel_size,
+		char *initrd, unsigned long initrd_len,
+		char *cmdline, unsigned long cmdline_len);
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index c38a8048ed00..f53f14bd1700 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -5,12 +5,200 @@
  * Copyright (C) 2018 Linaro Limited
  * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
  *
+ * Most code is derived from arm64 port of kexec-tools
  */
 
 #define pr_fmt(fmt) "kexec_file: " fmt
 
+#include <linux/ioport.h>
+#include <linux/kernel.h>
 #include <linux/kexec.h>
+#include <linux/libfdt.h>
+#include <linux/memblock.h>
+#include <linux/of_fdt.h>
+#include <linux/types.h>
+#include <asm/byteorder.h>
+
+/* relevant device tree properties */
+#define FDT_PSTR_INITRD_STA	"linux,initrd-start"
+#define FDT_PSTR_INITRD_END	"linux,initrd-end"
+#define FDT_PSTR_BOOTARGS	"bootargs"
 
 const struct kexec_file_ops * const kexec_file_loaders[] = {
 	NULL
 };
+
+int arch_kimage_file_post_load_cleanup(struct kimage *image)
+{
+	vfree(image->arch.dtb);
+	image->arch.dtb = NULL;
+
+	return kexec_image_post_load_cleanup_default(image);
+}
+
+static int setup_dtb(struct kimage *image,
+		unsigned long initrd_load_addr, unsigned long initrd_len,
+		char *cmdline, unsigned long cmdline_len,
+		void **dtb_buf, unsigned long *dtb_buf_len)
+{
+	void *buf = NULL;
+	size_t buf_size;
+	int nodeoffset;
+	int ret;
+
+	/* duplicate dt blob */
+	buf_size = fdt_totalsize(initial_boot_params);
+
+	if (initrd_load_addr) {
+		/* can be redundant, but trimmed at the end */
+		buf_size += fdt_prop_len(FDT_PSTR_INITRD_STA, sizeof(u64));
+		buf_size += fdt_prop_len(FDT_PSTR_INITRD_END, sizeof(u64));
+	}
+
+	if (cmdline)
+		/* can be redundant, but trimmed at the end */
+		buf_size += fdt_prop_len(FDT_PSTR_BOOTARGS, cmdline_len);
+
+	buf = vmalloc(buf_size);
+	if (!buf) {
+		ret = -ENOMEM;
+		goto out_err;
+	}
+
+	ret = fdt_open_into(initial_boot_params, buf, buf_size);
+	if (ret) {
+		ret = -EINVAL;
+		goto out_err;
+	}
+
+	nodeoffset = fdt_path_offset(buf, "/chosen");
+	if (nodeoffset < 0) {
+		ret = -EINVAL;
+		goto out_err;
+	}
+
+	/* add bootargs */
+	if (cmdline) {
+		ret = fdt_setprop_string(buf, nodeoffset, FDT_PSTR_BOOTARGS,
+							cmdline);
+		if (ret) {
+			ret = -EINVAL;
+			goto out_err;
+		}
+	} else {
+		ret = fdt_delprop(buf, nodeoffset, FDT_PSTR_BOOTARGS);
+		if (ret && (ret != -FDT_ERR_NOTFOUND)) {
+			ret = -EINVAL;
+			goto out_err;
+		}
+	}
+
+	/* add initrd-* */
+	if (initrd_load_addr) {
+		ret = fdt_setprop_u64(buf, nodeoffset, FDT_PSTR_INITRD_STA,
+							initrd_load_addr);
+		if (ret) {
+			ret = -EINVAL;
+			goto out_err;
+		}
+
+		ret = fdt_setprop_u64(buf, nodeoffset, FDT_PSTR_INITRD_END,
+						initrd_load_addr + initrd_len);
+		if (ret) {
+			ret = -EINVAL;
+			goto out_err;
+		}
+	} else {
+		ret = fdt_delprop(buf, nodeoffset, FDT_PSTR_INITRD_STA);
+		if (ret && (ret != -FDT_ERR_NOTFOUND)) {
+			ret = -EINVAL;
+			goto out_err;
+		}
+
+		ret = fdt_delprop(buf, nodeoffset, FDT_PSTR_INITRD_END);
+		if (ret && (ret != -FDT_ERR_NOTFOUND)) {
+			ret = -EINVAL;
+			goto out_err;
+		}
+	}
+
+	/* trim a buffer */
+	fdt_pack(buf);
+	*dtb_buf = buf;
+	*dtb_buf_len = fdt_totalsize(buf);
+
+	return 0;
+
+out_err:
+	vfree(buf);
+	return ret;
+}
+
+int load_other_segments(struct kimage *image,
+			unsigned long kernel_load_addr,
+			unsigned long kernel_size,
+			char *initrd, unsigned long initrd_len,
+			char *cmdline, unsigned long cmdline_len)
+{
+	struct kexec_buf kbuf;
+	void *dtb = NULL;
+	unsigned long initrd_load_addr = 0, dtb_len;
+	int ret = 0;
+
+	kbuf.image = image;
+	/* not allocate anything below the kernel */
+	kbuf.buf_min = kernel_load_addr + kernel_size;
+
+	/* load initrd */
+	if (initrd) {
+		kbuf.buffer = initrd;
+		kbuf.bufsz = initrd_len;
+		kbuf.mem = 0;
+		kbuf.memsz = initrd_len;
+		kbuf.buf_align = 0;
+		/* within 1GB-aligned window of up to 32GB in size */
+		kbuf.buf_max = round_down(kernel_load_addr, SZ_1G)
+						+ (unsigned long)SZ_1G * 32;
+		kbuf.top_down = false;
+
+		ret = kexec_add_buffer(&kbuf);
+		if (ret)
+			goto out_err;
+		initrd_load_addr = kbuf.mem;
+
+		pr_debug("Loaded initrd at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+				initrd_load_addr, initrd_len, initrd_len);
+	}
+
+	/* load dtb blob */
+	ret = setup_dtb(image, initrd_load_addr, initrd_len,
+				cmdline, cmdline_len, &dtb, &dtb_len);
+	if (ret) {
+		pr_err("Preparing for new dtb failed\n");
+		goto out_err;
+	}
+
+	kbuf.buffer = dtb;
+	kbuf.bufsz = dtb_len;
+	kbuf.mem = 0;
+	kbuf.memsz = dtb_len;
+	/* not across 2MB boundary */
+	kbuf.buf_align = SZ_2M;
+	kbuf.buf_max = ULONG_MAX;
+	kbuf.top_down = true;
+
+	ret = kexec_add_buffer(&kbuf);
+	if (ret)
+		goto out_err;
+	image->arch.dtb = dtb;
+	image->arch.dtb_mem = kbuf.mem;
+
+	pr_debug("Loaded dtb at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+			kbuf.mem, dtb_len, dtb_len);
+
+	return 0;
+
+out_err:
+	vfree(dtb);
+	return ret;
+}
-- 
2.19.0


Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E85C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4404E20854
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fte2i7vO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4404E20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732310AbeGKHph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 03:45:37 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46023 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbeGKHph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 03:45:37 -0400
Received: by mail-pl0-f68.google.com with SMTP id a17-v6so2961100plm.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 00:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0PS6qjK3C7l7A2CIqkRFL2OjgXECavo5rLxY/13kKyg=;
        b=fte2i7vOo6y1qvB6gCpIOQEoM7stKeKyD896Gvfk0mpJPEe3JAvwdcIoODDdej7kuq
         shvasghY8A+/bec787iQKR/si1GwXNM2w8YuK/DRd60mLgGuMQhHoOQDidYxKZeRJm8a
         7olb/Fnbn47MVuk5O5qLGyhy0V0Ez6CadBO6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0PS6qjK3C7l7A2CIqkRFL2OjgXECavo5rLxY/13kKyg=;
        b=DHKOucAV5obm0Rf5/e+e8kP4Z7xowINCcJYd28+UM4+fwTYGHyYXPzHc1mM6rky747
         lpA+zOoXilr4J28fKA4zStJ+ez1utlgGoj+OJKbvycZJWZZ8IL367diP1kAgp6Iteov3
         Xzz9NXG3SG5sxl9H1vSHIw0ClQ3T4pEN6O8m2KpUfVTconZejY7lg4cVbm2eDxdM5ftv
         lHuRJh1aNINcsV4Q+eujUEiEafnbiNQESXGqMIcwXx6nv489A6OrL+U336H489gfP9Qu
         Oe9sJWHKpWK+JwabbuMCGf/TTvMfM8ThAojb5uCALOlzfjkaYFZMdj6L/vmVBKxRrbaW
         ofzA==
X-Gm-Message-State: APt69E0keuRX/YlL+prmwg0UrdS3EpY+fNJPwQgqNEeZJ999Nf2vOMP2
        ekjvVAl9dv/oZjIzq1Vuv8sArg==
X-Google-Smtp-Source: AAOMgpdjGNCM4bPEUE5ObkqA6fhStZeovPa1lFspn/11kqFaa5R9hHYj2WpZGbjV0FDzYHKUXNz6Bg==
X-Received: by 2002:a17:902:d24:: with SMTP id 33-v6mr28182750plu.22.1531294960284;
        Wed, 11 Jul 2018 00:42:40 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id 10-v6sm44333804pfs.111.2018.07.11.00.42.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 00:42:39 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de
Cc:     ard.biesheuvel@linaro.org, james.morse@arm.com,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v11 09/15] arm64: kexec_file: load initrd and device-tree
Date:   Wed, 11 Jul 2018 16:41:57 +0900
Message-Id: <20180711074203.3019-10-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180711074203.3019-1-takahiro.akashi@linaro.org>
References: <20180711074203.3019-1-takahiro.akashi@linaro.org>
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
---
 arch/arm64/include/asm/kexec.h         |  16 +++
 arch/arm64/kernel/machine_kexec_file.c | 184 +++++++++++++++++++++++++
 2 files changed, 200 insertions(+)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index e17f0529a882..01bbf6cebf12 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -93,6 +93,22 @@ static inline void crash_prepare_suspend(void) {}
 static inline void crash_post_resume(void) {}
 #endif
 
+#ifdef CONFIG_KEXEC_FILE
+#define ARCH_HAS_KIMAGE_ARCH
+
+struct kimage_arch {
+	phys_addr_t dtb_mem;
+	void *dtb_buf;
+};
+
+struct kimage;
+
+extern int load_other_segments(struct kimage *image,
+		unsigned long kernel_load_addr, unsigned long kernel_size,
+		char *initrd, unsigned long initrd_len,
+		char *cmdline, unsigned long cmdline_len);
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index c38a8048ed00..ca00681c25c6 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -5,12 +5,196 @@
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
 
 const struct kexec_file_ops * const kexec_file_loaders[] = {
 	NULL
 };
+
+int arch_kimage_file_post_load_cleanup(struct kimage *image)
+{
+	vfree(image->arch.dtb_buf);
+	image->arch.dtb_buf = NULL;
+
+	return kexec_image_post_load_cleanup_default(image);
+}
+
+static int setup_dtb(struct kimage *image,
+		unsigned long initrd_load_addr, unsigned long initrd_len,
+		char *cmdline, unsigned long cmdline_len,
+		char **dtb_buf, size_t *dtb_buf_len)
+{
+	char *buf = NULL;
+	size_t buf_size;
+	int nodeoffset;
+	u64 value;
+	int ret;
+
+	/* duplicate dt blob */
+	buf_size = fdt_totalsize(initial_boot_params);
+
+	if (initrd_load_addr) {
+		/* can be redundant, but trimmed at the end */
+		buf_size += fdt_prop_len("linux,initrd-start", sizeof(u64));
+		buf_size += fdt_prop_len("linux,initrd-end", sizeof(u64));
+	}
+
+	if (cmdline)
+		/* can be redundant, but trimmed at the end */
+		buf_size += fdt_prop_len("bootargs", cmdline_len + 1);
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
+		ret = fdt_setprop_string(buf, nodeoffset, "bootargs", cmdline);
+		if (ret) {
+			ret = -EINVAL;
+			goto out_err;
+		}
+	} else {
+		ret = fdt_delprop(buf, nodeoffset, "bootargs");
+		if (ret && (ret != -FDT_ERR_NOTFOUND)) {
+			ret = -EINVAL;
+			goto out_err;
+		}
+	}
+
+	/* add initrd-* */
+	if (initrd_load_addr) {
+		value = cpu_to_fdt64(initrd_load_addr);
+		ret = fdt_setprop_u64(buf, nodeoffset, "linux,initrd-start",
+							value);
+		if (ret) {
+			ret = -EINVAL;
+			goto out_err;
+		}
+
+		value = cpu_to_fdt64(initrd_load_addr + initrd_len);
+		ret = fdt_setprop_u64(buf, nodeoffset, "linux,initrd-end",
+							value);
+		if (ret) {
+			ret = -EINVAL;
+			goto out_err;
+		}
+	} else {
+		ret = fdt_delprop(buf, nodeoffset, "linux,initrd-start");
+		if (ret && (ret != -FDT_ERR_NOTFOUND)) {
+			ret = -EINVAL;
+			goto out_err;
+		}
+
+		ret = fdt_delprop(buf, nodeoffset, "linux,initrd-end");
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
+	unsigned long initrd_load_addr = 0;
+	char *dtb = NULL;
+	unsigned long dtb_len = 0;
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
+	kbuf.memsz = dtb_len;
+	/* not across 2MB boundary */
+	kbuf.buf_align = SZ_2M;
+	kbuf.buf_max = ULONG_MAX;
+	kbuf.top_down = true;
+
+	ret = kexec_add_buffer(&kbuf);
+	if (ret)
+		goto out_err;
+	image->arch.dtb_mem = kbuf.mem;
+	image->arch.dtb_buf = dtb;
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
2.17.0


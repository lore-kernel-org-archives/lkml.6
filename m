Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52E2C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5127920874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RQ5UcAXc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5127920874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388534AbeGXIDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 04:03:32 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42865 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388264AbeGXIDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 04:03:32 -0400
Received: by mail-pl0-f67.google.com with SMTP id z7-v6so1325545plo.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 23:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mz81qDhWmAiSNYpZZsOHlS2lDMScwrCRyCwmff186zc=;
        b=RQ5UcAXcbSjT7kEJqmhN965LpvOYV0Z3cRcGDGFFYVgWqyJibRLBHN7P/dzcX8Lig8
         H6hdnIASudmJfZSMpKKwT7IMQfPIIZKbiQXoPMPBaJbnMIB/Q7+L5wJHC+4dNRP9hiOT
         5KdDsi1ozfgrdztYwNUOZhOBlVcoBZcLDA/cA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mz81qDhWmAiSNYpZZsOHlS2lDMScwrCRyCwmff186zc=;
        b=uLm+u/Y6vL+43ckNquNYvmwOrjUZEjXyWsUwsXGMcurVuN5qCDmbDJsMaVl/mSsI+8
         O8IEbzoGXFamcmWRKJj0Rgw+9B2x0Psibztz8c/q2sjlqLlFG9m5/QE3AhRdnHTOy6AH
         RoD65gJjW9NCzgjagILa0+a95Gm+1RzovwZXORnsOisJaV+59iK9sg28JkkG0aERc9E4
         C7FYJxx5IDELopKxTNBwLGqiKmIfFFQpjXFmBkD9vVtfoWeq4L/uemcDgOSiTRhaXP8t
         mNoHcOPVBnwPcSlDYuP3cDmskqwHRlHJhscGc7EmlvPYtmXxJzweg3kd8iOK7vHXwE+N
         coYQ==
X-Gm-Message-State: AOUpUlEg1xKdIWHfkS9vvQx6fEaH/XuFCY2JbFuBfyxHdchReU6hfbmq
        YZMNef0Kv0vcllkAHMJ30fKQTA==
X-Google-Smtp-Source: AAOMgpeY6qMjDeti+aFQMQ0Lelief7UBB0CwC1tde/LJjK9Snmwgsw9zjfZlsFRSSWVFSbdvVPvrrg==
X-Received: by 2002:a17:902:7482:: with SMTP id h2-v6mr16071369pll.185.1532415513949;
        Mon, 23 Jul 2018 23:58:33 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id 75-v6sm18663643pfr.115.2018.07.23.23.58.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 23:58:33 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc:     ard.biesheuvel@linaro.org, james.morse@arm.com,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v12 10/16] arm64: kexec_file: load initrd and device-tree
Date:   Tue, 24 Jul 2018 15:57:53 +0900
Message-Id: <20180724065759.19186-11-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724065759.19186-1-takahiro.akashi@linaro.org>
References: <20180724065759.19186-1-takahiro.akashi@linaro.org>
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
 arch/arm64/kernel/machine_kexec_file.c | 182 +++++++++++++++++++++++++
 2 files changed, 199 insertions(+)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index e17f0529a882..026f7e408f0c 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -93,6 +93,23 @@ static inline void crash_prepare_suspend(void) {}
 static inline void crash_post_resume(void) {}
 #endif
 
+#ifdef CONFIG_KEXEC_FILE
+#define ARCH_HAS_KIMAGE_ARCH
+
+struct kimage_arch {
+	void *dtb_buf;
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
index c38a8048ed00..b28fbb0659c9 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -5,12 +5,194 @@
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
+		buf_size += fdt_prop_len("linux,initrd-start", sizeof(u64));
+		buf_size += fdt_prop_len("linux,initrd-end", sizeof(u64));
+	}
+
+	if (cmdline)
+		/* can be redundant, but trimmed at the end */
+		buf_size += fdt_prop_len("bootargs", cmdline_len);
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
+		ret = fdt_setprop_u64(buf, nodeoffset, "linux,initrd-start",
+							initrd_load_addr);
+		if (ret) {
+			ret = -EINVAL;
+			goto out_err;
+		}
+
+		ret = fdt_setprop_u64(buf, nodeoffset, "linux,initrd-end",
+						initrd_load_addr + initrd_len);
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
2.18.0


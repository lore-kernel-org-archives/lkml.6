Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C25C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 02:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE45F24AC2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 02:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VrmORSer"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE45F24AC2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934834AbeFWCVe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 22:21:34 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33563 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934528AbeFWCV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 22:21:28 -0400
Received: by mail-pl0-f68.google.com with SMTP id 6-v6so4277323plb.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 19:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VfttqaZsoSrrmx7AFVg3/dunQIF7uztuOLZXTTqCTMI=;
        b=VrmORSerBG4BumXSR9HHtrdrnwhBg4pfLIC1UdUTcbJQCLfcdvE4cc4qXl5VH3L79T
         9pTvFow7qVKTsch93Rovw3qR0LWtQbTCul4W6MGEGKwfoWSX3m37dMYKokMXPsbCOoCb
         NSGjdYhacr+/298VWtnu4woHt4PfdNP3tVVm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VfttqaZsoSrrmx7AFVg3/dunQIF7uztuOLZXTTqCTMI=;
        b=cHhsmKTmzGkVsNDiNHnS2AH0AX/rePngAD0unpwoWBlF4WxOiyg4RzP8sB4UBif7ME
         jLEXQCN7TZUQ+83ApSSXdSVPUwYhY8Hquy3WRi7+z0Ct6tY+ctIFzvJ/eBiRWjrJAPjx
         fEwQk3lIvLJLnYzxSk3Y+dY/ER+La2H0+nZQha6aQ4tbA0go95b6eQMdVSH2NXdFL/uG
         wBkLnzswAm82sXi9tOpV3swexE993GPLdNvfH53XcLaVuUbzXhyDuz/n0BSeILs0HjQD
         zu6LpPgWNsHvJ6Tq7ILZ03DiduN/jHe/ZtrXB86o8h3RsqSA9Qi0K1HsF5z9z6zAkpgc
         bbsg==
X-Gm-Message-State: APt69E33XhNqVOYE5laLVCFZjfBkt6IaHo+6F7c4h0BdFXzC2rbZohsr
        EJimeFELUFfx1/j7LCVO5xOEDg==
X-Google-Smtp-Source: ADUXVKKMjlsKHeOR7Zqr4NfphQd8zcxvTqVkcYCWpfYh1uIp5vYY/zbuTXCVdDXBruxiFPhbt2wyvQ==
X-Received: by 2002:a17:902:bd8f:: with SMTP id q15-v6mr3940532pls.161.1529720487745;
        Fri, 22 Jun 2018 19:21:27 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id z28-v6sm17894443pfl.169.2018.06.22.19.21.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 19:21:27 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de
Cc:     ard.biesheuvel@linaro.org, james.morse@arm.com,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v10 08/14] arm64: kexec_file: load initrd and device-tree
Date:   Sat, 23 Jun 2018 11:20:52 +0900
Message-Id: <20180623022058.10935-9-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180623022058.10935-1-takahiro.akashi@linaro.org>
References: <20180623022058.10935-1-takahiro.akashi@linaro.org>
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
 arch/arm64/kernel/machine_kexec_file.c | 155 +++++++++++++++++++++++++
 2 files changed, 171 insertions(+)

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
index c38a8048ed00..7115c4f915dc 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -5,12 +5,167 @@
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
+		buf_size += fdt_prop_len("linux,initrd-start", sizeof(u64));
+		buf_size += fdt_prop_len("linux,initrd-end", sizeof(u64));
+	}
+
+	if (cmdline)
+		buf_size += fdt_prop_len("bootargs", cmdline_len + 1);
+
+	buf = vmalloc(buf_size);
+	if (!buf) {
+		ret = -ENOMEM;
+		goto out_err;
+	}
+
+	ret = fdt_open_into(initial_boot_params, buf, buf_size);
+	if (ret)
+		goto out_err;
+
+	nodeoffset = fdt_path_offset(buf, "/chosen");
+	if (nodeoffset < 0)
+		goto out_err;
+
+	/* add bootargs */
+	if (cmdline) {
+		ret = fdt_setprop(buf, nodeoffset, "bootargs",
+						cmdline, cmdline_len + 1);
+		if (ret)
+			goto out_err;
+	}
+
+	/* add initrd-* */
+	if (initrd_load_addr) {
+		value = cpu_to_fdt64(initrd_load_addr);
+		ret = fdt_setprop_u64(buf, nodeoffset, "linux,initrd-start",
+							value);
+		if (ret)
+			goto out_err;
+
+		value = cpu_to_fdt64(initrd_load_addr + initrd_len);
+		ret = fdt_setprop_u64(buf, nodeoffset, "linux,initrd-end",
+							value);
+		if (ret)
+			goto out_err;
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


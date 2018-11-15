Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01110C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 05:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3FAE2087E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 05:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GsW9jmBC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3FAE2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbeKOP7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 10:59:47 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:43962 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbeKOP7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 10:59:46 -0500
Received: by mail-yb1-f196.google.com with SMTP id h187-v6so7903292ybg.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 21:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DVw/N+4o4xfdKNT3rQ+yr/g2LmbUltluLPP7xa2j7CY=;
        b=GsW9jmBCepRRuemOaWg1s/fdiX69XAbbte5iR4Y6/rfI01QRT7mbkPfb8OzkOfxK0w
         y/5MfoK7vDnE5RpI4HRZ9ID6g9bA1Nq0uZ9++cl0L+B8nOhsR79UAiYVRUMSsDy5qpQs
         XeUoRbfCBofNBT82JdJZ+vVT/FzlsAZxelXVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DVw/N+4o4xfdKNT3rQ+yr/g2LmbUltluLPP7xa2j7CY=;
        b=pTnr8F7w1GhJRAapXKSVOkwXEgPwN4DgbQqNPVS4p0gHwO4aPusOzqpcJbdAqhWHGC
         0J1THFWgh2AErDI4lwDxfZG6lOrMss8V5EecM7N20pQwrSJ6x5A5kJa0KRr7/6Umnt1P
         UaDrLS9jdUQRUAYO0ZmBSJ+OX61S65gLMLFQJFyRfEgpo0Gp+ibOcgKVcYJ60l6ef1LO
         TVG8xSjiK/4UwgmmJLshRUDkzmXDefQfcEQzOEQYNSw7Nxp8vQk2aJgHLyf4+rl62F9J
         6qdl0K3mJaACHF5THMHHLXJyJ/1Af0MmRfzHSdzEMVnA5Jek0IgF46IK0q3HVztKwcLi
         4ATA==
X-Gm-Message-State: AGRZ1gKK8mc3PQoCu/2su7t/BQqFPmhaS4FYblTre4A8oNDZIMTlTzyE
        DIn8hTDURa92Aku31Rm5yjolxg==
X-Google-Smtp-Source: AJdET5d+kFXnkqMko+jgItDYVJf5BJsTF/ydXwGF2z06T/UztCXt6/ObK6ZNRgHVMc/LFdtG3t65ow==
X-Received: by 2002:a25:6f86:: with SMTP id k128-v6mr4430682ybc.235.1542261201112;
        Wed, 14 Nov 2018 21:53:21 -0800 (PST)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id 207-v6sm7417441ywo.87.2018.11.14.21.53.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 21:53:20 -0800 (PST)
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
Subject: [PATCH v16 10/16] arm64: kexec_file: load initrd and device-tree
Date:   Thu, 15 Nov 2018 14:52:49 +0900
Message-Id: <20181115055254.2812-11-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181115055254.2812-1-takahiro.akashi@linaro.org>
References: <20181115055254.2812-1-takahiro.akashi@linaro.org>
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
 arch/arm64/kernel/machine_kexec_file.c | 185 +++++++++++++++++++++++++
 2 files changed, 202 insertions(+)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index e17f0529a882..bbb5f505b0ba 100644
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
+		char *cmdline);
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index c38a8048ed00..b433d947d486 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -5,12 +5,197 @@
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
+#include <linux/string.h>
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
+		     unsigned long initrd_load_addr, unsigned long initrd_len,
+		     char *cmdline, void *dtb)
+{
+	int nodeoffset;
+	int ret;
+
+	nodeoffset = fdt_path_offset(dtb, "/chosen");
+	if (nodeoffset < 0)
+		return -EINVAL;
+
+	/* add bootargs */
+	if (cmdline) {
+		ret = fdt_setprop_string(dtb, nodeoffset, FDT_PSTR_BOOTARGS,
+							cmdline);
+		if (ret)
+			return (ret == -FDT_ERR_NOSPACE ? -ENOMEM : -EINVAL);
+	} else {
+		ret = fdt_delprop(dtb, nodeoffset, FDT_PSTR_BOOTARGS);
+		if (ret && (ret != -FDT_ERR_NOTFOUND))
+			return -EINVAL;
+	}
+
+	/* add initrd-* */
+	if (initrd_load_addr) {
+		ret = fdt_setprop_u64(dtb, nodeoffset, FDT_PSTR_INITRD_STA,
+							initrd_load_addr);
+		if (ret)
+			return (ret == -FDT_ERR_NOSPACE ? -ENOMEM : -EINVAL);
+
+		ret = fdt_setprop_u64(dtb, nodeoffset, FDT_PSTR_INITRD_END,
+						initrd_load_addr + initrd_len);
+		if (ret)
+			return (ret == -FDT_ERR_NOSPACE ? -ENOMEM : -EINVAL);
+	} else {
+		ret = fdt_delprop(dtb, nodeoffset, FDT_PSTR_INITRD_STA);
+		if (ret && (ret != -FDT_ERR_NOTFOUND))
+			return -EINVAL;
+
+		ret = fdt_delprop(dtb, nodeoffset, FDT_PSTR_INITRD_END);
+		if (ret && (ret != -FDT_ERR_NOTFOUND))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * More space needed so that we can add initrd and bootargs.
+ */
+#define DTB_EXTRA_SPACE 0x1000
+
+static int create_dtb(struct kimage *image,
+		      unsigned long initrd_load_addr, unsigned long initrd_len,
+		      char *cmdline, void **dtb)
+{
+	void *buf;
+	size_t buf_size;
+	int ret;
+
+	buf_size = fdt_totalsize(initial_boot_params)
+			+ strlen(cmdline) + DTB_EXTRA_SPACE;
+
+	for (;;) {
+		buf = vmalloc(buf_size);
+		if (!buf)
+			return -ENOMEM;
+
+		/* duplicate a device tree blob */
+		ret = fdt_open_into(initial_boot_params, buf, buf_size);
+		if (ret)
+			return -EINVAL;
+
+		ret = setup_dtb(image, initrd_load_addr, initrd_len,
+				cmdline, buf);
+		if (ret) {
+			vfree(buf);
+			if (ret == -ENOMEM) {
+				/* unlikely, but just in case */
+				buf_size += DTB_EXTRA_SPACE;
+				continue;
+			} else {
+				return ret;
+			}
+		}
+
+		/* trim it */
+		fdt_pack(buf);
+		*dtb = buf;
+
+		return 0;
+	}
+}
+
+int load_other_segments(struct kimage *image,
+			unsigned long kernel_load_addr,
+			unsigned long kernel_size,
+			char *initrd, unsigned long initrd_len,
+			char *cmdline)
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
+	/* load dtb */
+	ret = create_dtb(image, initrd_load_addr, initrd_len, cmdline, &dtb);
+	if (ret) {
+		pr_err("Preparing for new dtb failed\n");
+		goto out_err;
+	}
+
+	dtb_len = fdt_totalsize(dtb);
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


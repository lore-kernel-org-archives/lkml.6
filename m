Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C49C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5790E20861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TfbOiWS9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5790E20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbeIGMlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:41:02 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:47058 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbeIGMlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:41:02 -0400
Received: by mail-pf1-f196.google.com with SMTP id u24-v6so6617695pfn.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 01:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=swjjpmgZOQ5RY/bW+WB2nT2kYZTPmzcU4gU1mJtC0o4=;
        b=TfbOiWS9heV3iy9bKjpBx5utWenk+HNyevEckxzOh1Da1c1e6NsmI/2Iv/5VrDEe1+
         +Ci63eYbIj4xmAgxJ2/HliOUTtKtoqLHvlz/pnkAEkO5/7WwJpj1MwTmT1Gqw7aZKqbH
         hMwcKiLnQU311Hir4ZdnMA3tU6k8KIHwEVk7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=swjjpmgZOQ5RY/bW+WB2nT2kYZTPmzcU4gU1mJtC0o4=;
        b=RgPEbOcooFtHhnDF59kUaxN2sWbjxS9H2Y4xQssbPOHyD0j+gqLFqyOJaiYo1UxfW9
         FKrFni7tZToEF3xfUnM6hSlySLJ+rmkRLDJH8j4WK6dBi6cF/js621pEJbIZec2943ph
         SRmK59gRW9DGhmvSmeskIy3YbYBdIzbci71HiYT7Ea2qFjF8Z3hh45hmeOwl/61PduCT
         RagMSmVZm02FzEaAg53b6F/+FA7LSFq7lOaCY+FwlZjXz5rQcsmt/mA16L7rVmDU2Rg4
         h/Wu1QQCTvvEj/sv01/mEIIfFVfUIybb7TM5T1iXrUk6HjnG2N09hymX7CfyCZZyAPcs
         /umw==
X-Gm-Message-State: APzg51AxoR7w5rEdR2h173dsD0fUT+JG7QSwS6jP7Zj2Zhd/MjMDTajE
        lLDWXQbDnTltORg7nzmjSSjGqw==
X-Google-Smtp-Source: ANB0VdZmf1cdv/t6ndoxWTTxsHgs99fRH2hZ8GKFrzahvLgcuRR9yUHntMc2k3iifsFFUsbBkQ5wvw==
X-Received: by 2002:a63:f44d:: with SMTP id p13-v6mr7072731pgk.257.1536307276719;
        Fri, 07 Sep 2018 01:01:16 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id c20-v6sm18010130pfh.143.2018.09.07.01.01.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 01:01:15 -0700 (PDT)
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
Subject: [PATCH v14 12/16] arm64: kexec_file: add crash dump support
Date:   Fri,  7 Sep 2018 17:00:36 +0900
Message-Id: <20180907080040.4967-7-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907080040.4967-1-takahiro.akashi@linaro.org>
References: <20180907080040.4967-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling crash dump (kdump) includes
* prepare contents of ELF header of a core dump file, /proc/vmcore,
  using crash_prepare_elf64_headers(), and
* add two device tree properties, "linux,usable-memory-range" and
  "linux,elfcorehdr", which represent respectively a memory range
  to be used by crash dump kernel and the header's location

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Reviewed-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/kexec.h         |   4 +
 arch/arm64/kernel/machine_kexec_file.c | 113 ++++++++++++++++++++++++-
 2 files changed, 114 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 5e673481b3a3..1b2c27026ae0 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -99,6 +99,10 @@ static inline void crash_post_resume(void) {}
 struct kimage_arch {
 	void *dtb;
 	unsigned long dtb_mem;
+	/* Core ELF header buffer */
+	void *elf_headers;
+	unsigned long elf_headers_mem;
+	unsigned long elf_headers_sz;
 };
 
 /**
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 05fb2d4e6fef..ecaecb122cad 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -16,10 +16,14 @@
 #include <linux/libfdt.h>
 #include <linux/memblock.h>
 #include <linux/of_fdt.h>
+#include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/vmalloc.h>
 #include <asm/byteorder.h>
 
 /* relevant device tree properties */
+#define FDT_PSTR_KEXEC_ELFHDR	"linux,elfcorehdr"
+#define FDT_PSTR_MEM_RANGE	"linux,usable-memory-range"
 #define FDT_PSTR_INITRD_STA	"linux,initrd-start"
 #define FDT_PSTR_INITRD_END	"linux,initrd-end"
 #define FDT_PSTR_BOOTARGS	"bootargs"
@@ -34,6 +38,10 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 	vfree(image->arch.dtb);
 	image->arch.dtb = NULL;
 
+	vfree(image->arch.elf_headers);
+	image->arch.elf_headers = NULL;
+	image->arch.elf_headers_sz = 0;
+
 	return kexec_image_post_load_cleanup_default(image);
 }
 
@@ -43,12 +51,29 @@ static int setup_dtb(struct kimage *image,
 		void **dtb_buf, unsigned long *dtb_buf_len)
 {
 	void *buf = NULL;
-	size_t buf_size;
+	size_t buf_size, range_size;
 	int nodeoffset;
 	int ret;
 
+	/* check ranges against root's #address-cells and #size-cells */
+	if (image->type == KEXEC_TYPE_CRASH &&
+		(!of_fdt_cells_size_fitted(image->arch.elf_headers_mem,
+				image->arch.elf_headers_sz) ||
+		 !of_fdt_cells_size_fitted(crashk_res.start,
+				crashk_res.end - crashk_res.start + 1))) {
+		pr_err("Crash memory region doesn't fit into DT's root cell sizes.\n");
+		ret = -EINVAL;
+		goto out_err;
+	}
+
 	/* duplicate dt blob */
 	buf_size = fdt_totalsize(initial_boot_params);
+	range_size = of_fdt_reg_cells_size();
+
+	if (image->type == KEXEC_TYPE_CRASH) {
+		buf_size += fdt_prop_len(FDT_PSTR_KEXEC_ELFHDR, range_size);
+		buf_size += fdt_prop_len(FDT_PSTR_MEM_RANGE, range_size);
+	}
 
 	if (initrd_load_addr) {
 		/* can be redundant, but trimmed at the end */
@@ -78,6 +103,22 @@ static int setup_dtb(struct kimage *image,
 		goto out_err;
 	}
 
+	if (image->type == KEXEC_TYPE_CRASH) {
+		/* add linux,elfcorehdr */
+		ret = fdt_setprop_reg(buf, nodeoffset, FDT_PSTR_KEXEC_ELFHDR,
+				image->arch.elf_headers_mem,
+				image->arch.elf_headers_sz);
+		if (ret)
+			goto out_err;
+
+		/* add linux,usable-memory-range */
+		ret = fdt_setprop_reg(buf, nodeoffset, FDT_PSTR_MEM_RANGE,
+				crashk_res.start,
+				crashk_res.end - crashk_res.start + 1);
+		if (ret)
+			goto out_err;
+	}
+
 	/* add bootargs */
 	if (cmdline) {
 		ret = fdt_setprop_string(buf, nodeoffset, FDT_PSTR_BOOTARGS,
@@ -135,6 +176,43 @@ static int setup_dtb(struct kimage *image,
 	return ret;
 }
 
+static int prepare_elf_headers(void **addr, unsigned long *sz)
+{
+	struct crash_mem *cmem;
+	unsigned int nr_ranges;
+	int ret;
+	u64 i;
+	phys_addr_t start, end;
+
+	nr_ranges = 1; /* for exclusion of crashkernel region */
+	for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,
+					MEMBLOCK_NONE, &start, &end, NULL)
+		nr_ranges++;
+
+	cmem = kmalloc(sizeof(struct crash_mem) +
+			sizeof(struct crash_mem_range) * nr_ranges, GFP_KERNEL);
+	if (!cmem)
+		return -ENOMEM;
+
+	cmem->max_nr_ranges = nr_ranges;
+	cmem->nr_ranges = 0;
+	for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,
+					MEMBLOCK_NONE, &start, &end, NULL) {
+		cmem->ranges[cmem->nr_ranges].start = start;
+		cmem->ranges[cmem->nr_ranges].end = end - 1;
+		cmem->nr_ranges++;
+	}
+
+	/* Exclude crashkernel region */
+	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
+
+	if (!ret)
+		ret =  crash_prepare_elf64_headers(cmem, true, addr, sz);
+
+	kfree(cmem);
+	return ret;
+}
+
 int load_other_segments(struct kimage *image,
 			unsigned long kernel_load_addr,
 			unsigned long kernel_size,
@@ -142,14 +220,43 @@ int load_other_segments(struct kimage *image,
 			char *cmdline, unsigned long cmdline_len)
 {
 	struct kexec_buf kbuf;
-	void *dtb = NULL;
-	unsigned long initrd_load_addr = 0, dtb_len;
+	void *headers, *dtb = NULL;
+	unsigned long headers_sz, initrd_load_addr = 0, dtb_len;
 	int ret = 0;
 
 	kbuf.image = image;
 	/* not allocate anything below the kernel */
 	kbuf.buf_min = kernel_load_addr + kernel_size;
 
+	/* load elf core header */
+	if (image->type == KEXEC_TYPE_CRASH) {
+		ret = prepare_elf_headers(&headers, &headers_sz);
+		if (ret) {
+			pr_err("Preparing elf core header failed\n");
+			goto out_err;
+		}
+
+		kbuf.buffer = headers;
+		kbuf.bufsz = headers_sz;
+		kbuf.mem = 0;
+		kbuf.memsz = headers_sz;
+		kbuf.buf_align = SZ_64K; /* largest supported page size */
+		kbuf.buf_max = ULONG_MAX;
+		kbuf.top_down = true;
+
+		ret = kexec_add_buffer(&kbuf);
+		if (ret) {
+			vfree(headers);
+			goto out_err;
+		}
+		image->arch.elf_headers = headers;
+		image->arch.elf_headers_mem = kbuf.mem;
+		image->arch.elf_headers_sz = headers_sz;
+
+		pr_debug("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+			 image->arch.elf_headers_mem, headers_sz, headers_sz);
+	}
+
 	/* load initrd */
 	if (initrd) {
 		kbuf.buffer = initrd;
-- 
2.18.0


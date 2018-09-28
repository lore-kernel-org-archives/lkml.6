Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DEFC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A8C2172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rmxl+pcS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12A8C2172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbeI1NLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:11:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42686 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728811AbeI1NLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:11:31 -0400
Received: by mail-pg1-f194.google.com with SMTP id i4-v6so3118498pgq.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 23:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J8Y1VWFVHEgu9P7oEU8UAY9BvikA0olKUy5ed/MNwaE=;
        b=Rmxl+pcSKewfJvUQc7aty+Zf7gx63A4Ld5udoGDuU7FFhO7eJlxEc9iNUEiKc43heF
         EgZKRCSS3ugC9djMQPDh2sHtMN1EIzmf5Q5rpYH/stfpyV5FmE6AOukoFrdX5UgzE8Ad
         eZJKR4RNYHB6yr6Y1/7gZvokPhw5eJd/k2YLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J8Y1VWFVHEgu9P7oEU8UAY9BvikA0olKUy5ed/MNwaE=;
        b=WnabK30EMyxK8R2xApu5DghVI3iLrTOflM8SGp5ZtqA74klP5lrUvTzhbHHpAlVib8
         OIMyP0lnaKAJjtyGbXMOL9pwvGpcoQDkkWYqngajbKIqjK7/om7vCQoF3JmD5GuBdUp0
         1rgVXiCkw4qiP3eMKuQKCEmUrDo0clSfiqkFcYrd5Ja+Oi1D4qbQe9YpKJsmQ3VNnlRK
         NHqzKKBrWJ5GdY3upCY1WJF8phLmoS2WvFWqkGHMjFQRgQAmJ0tOFD0gLV0yQTly+mST
         QEq9aAg6bnUO0vJPKP3RPUv6BYQS8cS/VNwyknGRagHg+1TerRzb3PMkflSNUSYrfiBN
         c1+A==
X-Gm-Message-State: ABuFfog8ya1waH/QIINFnvM0GqtDupNCmfPRLZCMoeo0kCu5j7x8y1fr
        SFl1TeSbvVzrc1MsP4Kubs4Cgw==
X-Google-Smtp-Source: ACcGV61b6zqMdz2WK8ofJJGx4t9sYegpLQ860OzQ33lDp5oa1QxE2BP2UTLYp95SjZOqT3AjvV7Q+Q==
X-Received: by 2002:a65:588e:: with SMTP id d14-v6mr8052898pgu.117.1538117356121;
        Thu, 27 Sep 2018 23:49:16 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id b7-v6sm4555243pgt.46.2018.09.27.23.49.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 23:49:15 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc:     prudo@linux.ibm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v15 12/16] arm64: kexec_file: add crash dump support
Date:   Fri, 28 Sep 2018 15:48:37 +0900
Message-Id: <20180928064841.14117-13-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180928064841.14117-1-takahiro.akashi@linaro.org>
References: <20180928064841.14117-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org
---
 arch/arm64/include/asm/kexec.h         |   4 +
 arch/arm64/kernel/machine_kexec_file.c | 109 ++++++++++++++++++++++++-
 2 files changed, 110 insertions(+), 3 deletions(-)

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
index 05fb2d4e6fef..4b5ea256c84c 100644
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
 
@@ -43,12 +51,25 @@ static int setup_dtb(struct kimage *image,
 		void **dtb_buf, unsigned long *dtb_buf_len)
 {
 	void *buf = NULL;
-	size_t buf_size;
+	int addr_cells, size_cells;
+	size_t buf_size, range_size;
 	int nodeoffset;
 	int ret;
 
 	/* duplicate dt blob */
 	buf_size = fdt_totalsize(initial_boot_params);
+	addr_cells = fdt_address_cells(initial_boot_params, 0);
+	if (addr_cells < 0)
+		return -EINVAL;
+	size_cells = fdt_size_cells(initial_boot_params, 0);
+	if (size_cells < 0)
+		return -EINVAL;
+	range_size = (addr_cells + size_cells) * sizeof(u32);
+
+	if (image->type == KEXEC_TYPE_CRASH) {
+		buf_size += fdt_prop_len(FDT_PSTR_KEXEC_ELFHDR, range_size);
+		buf_size += fdt_prop_len(FDT_PSTR_MEM_RANGE, range_size);
+	}
 
 	if (initrd_load_addr) {
 		/* can be redundant, but trimmed at the end */
@@ -78,6 +99,22 @@ static int setup_dtb(struct kimage *image,
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
@@ -135,6 +172,43 @@ static int setup_dtb(struct kimage *image,
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
@@ -142,14 +216,43 @@ int load_other_segments(struct kimage *image,
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
2.19.0


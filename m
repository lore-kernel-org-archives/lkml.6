Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96271ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4430C20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y+n40Cn0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4430C20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388552AbeGXIDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 04:03:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41939 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388264AbeGXIDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 04:03:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id y10-v6so622224pfn.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 23:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NrZw1260Snx5buwrLrr5fcvVbV6cTmqraLcLZQTZkLs=;
        b=Y+n40Cn0PUxEfrHIT/fGbjCmcUHa0Xn47ymffC+V87QKT+cNafSRa5tfjMDNQ2XTmU
         gA/8rCZYwmQc5ZETtw1o6TE3N59f1pjEOgIPXXNAN0FE3ykbdYs/aEOUcV8sYm1lLANC
         ATiFdhuXXARVZGjQwDm63+lpg0G1s6N5FFYks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NrZw1260Snx5buwrLrr5fcvVbV6cTmqraLcLZQTZkLs=;
        b=b9va/T64lTTfVpdJKqJyHxgXJZ0lUHfSso97iixxOGN0k3qjFHhKJHZhhVqq0YuofP
         yYU2vjustoppOEcHY/0zMZJ7joIgklTzuEhog/GpTipT/ibL8bqSDgtOGweBn4ZAeACB
         n30rM9/C1LWw7ZaA+OWPZ+haMqT5te/ujptrOkkSprkFFTjHAImo/ytQhdATgxiXiXU7
         jdEKya34uPHpgP9lRO5FNU2hSxzJKhn4SilizBE609o8HoVyn3F5xH3DwoBGe3Mxhsyg
         YVc2uvna4Y/XC501h7FHMe/47cTQkgKVlLKVQTGMonpaBDipwtBrE8VvPwbvxhV0EKQn
         eZzQ==
X-Gm-Message-State: AOUpUlH5hJD7z6UqrttAU5/+f6/06JTJQEYaV/ojpytVW/D0G7S/Cbg4
        t6TfZ4GRqo86Ci72QfIvL/cWcQ==
X-Google-Smtp-Source: AAOMgpe2E+msjm/gLvLjKZTckbG8bUtjug8td3OJN5Ihk/T1HjIzOuhOvGIdcXO/RXtSkHaic/LZxA==
X-Received: by 2002:a62:6746:: with SMTP id b67-v6mr16504274pfc.243.1532415529050;
        Mon, 23 Jul 2018 23:58:49 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id 87-v6sm22962394pfn.103.2018.07.23.23.58.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 23:58:48 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc:     ard.biesheuvel@linaro.org, james.morse@arm.com,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v12 12/16] arm64: kexec_file: add crash dump support
Date:   Tue, 24 Jul 2018 15:57:55 +0900
Message-Id: <20180724065759.19186-13-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724065759.19186-1-takahiro.akashi@linaro.org>
References: <20180724065759.19186-1-takahiro.akashi@linaro.org>
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
---
 arch/arm64/include/asm/kexec.h         |   6 +-
 arch/arm64/kernel/machine_kexec_file.c | 113 ++++++++++++++++++++++++-
 2 files changed, 115 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 5d102a1054b3..1b2c27026ae0 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -97,8 +97,12 @@ static inline void crash_post_resume(void) {}
 #define ARCH_HAS_KIMAGE_ARCH
 
 struct kimage_arch {
-	void *dtb_buf;
+	void *dtb;
 	unsigned long dtb_mem;
+	/* Core ELF header buffer */
+	void *elf_headers;
+	unsigned long elf_headers_mem;
+	unsigned long elf_headers_sz;
 };
 
 /**
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index b8297f10e2ef..7356da5a53d5 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -16,7 +16,9 @@
 #include <linux/libfdt.h>
 #include <linux/memblock.h>
 #include <linux/of_fdt.h>
+#include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/vmalloc.h>
 #include <asm/byteorder.h>
 
 const struct kexec_file_ops * const kexec_file_loaders[] = {
@@ -29,6 +31,10 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 	vfree(image->arch.dtb);
 	image->arch.dtb = NULL;
 
+	vfree(image->arch.elf_headers);
+	image->arch.elf_headers = NULL;
+	image->arch.elf_headers_sz = 0;
+
 	return kexec_image_post_load_cleanup_default(image);
 }
 
@@ -38,12 +44,30 @@ static int setup_dtb(struct kimage *image,
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
+		buf_size += fdt_prop_len("linux,elfcorehdr", range_size);
+		buf_size += fdt_prop_len("linux,usable-memory-range",
+								range_size);
+	}
 
 	if (initrd_load_addr) {
 		/* can be redundant, but trimmed at the end */
@@ -73,6 +97,23 @@ static int setup_dtb(struct kimage *image,
 		goto out_err;
 	}
 
+	if (image->type == KEXEC_TYPE_CRASH) {
+		/* add linux,elfcorehdr */
+		ret = fdt_setprop_reg(buf, nodeoffset, "linux,elfcorehdr",
+				image->arch.elf_headers_mem,
+				image->arch.elf_headers_sz);
+		if (ret)
+			goto out_err;
+
+		/* add linux,usable-memory-range */
+		ret = fdt_setprop_reg(buf, nodeoffset,
+				"linux,usable-memory-range",
+				crashk_res.start,
+				crashk_res.end - crashk_res.start + 1);
+		if (ret)
+			goto out_err;
+	}
+
 	/* add bootargs */
 	if (cmdline) {
 		ret = fdt_setprop_string(buf, nodeoffset, "bootargs", cmdline);
@@ -129,6 +170,43 @@ static int setup_dtb(struct kimage *image,
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
+	for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE, 0,
+							&start, &end, NULL)
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
@@ -136,14 +214,43 @@ int load_other_segments(struct kimage *image,
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


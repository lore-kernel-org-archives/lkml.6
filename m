Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751093AbeDYG10 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 02:27:26 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33683 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbeDYG1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 02:27:21 -0400
X-Google-Smtp-Source: AIpwx4/bq3PFGl9UsTdSUSyWTvkHby2TmVu+2yV+A269hwtL+joNBymk2GhV4r9bSs2b5jIGII+KOg==
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net,
        dyoung@redhat.com, bhe@redhat.com, arnd@arndb.de
Cc: ard.biesheuvel@linaro.org, james.morse@arm.com, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v9 07/11] arm64: kexec_file: add crash dump support
Date: Wed, 25 Apr 2018 15:26:25 +0900
Message-Id: <20180425062629.29404-8-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425062629.29404-1-takahiro.akashi@linaro.org>
References: <20180425062629.29404-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling crash dump (kdump) includes
* prepare contents of ELF header of a core dump file, /proc/vmcore,
  using crash_prepare_elf64_headers(), and
* add two device tree properties, "linux,usable-memory-range" and
  "linux,elfcorehdr", which represent repsectively a memory range
  to be used by crash dump kernel and the header's location

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/kexec.h         |   4 +
 arch/arm64/kernel/kexec_image.c        |   9 +-
 arch/arm64/kernel/machine_kexec_file.c | 202 +++++++++++++++++++++++++
 3 files changed, 213 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 3cba4161818a..77f05bcf6a42 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -100,6 +100,10 @@ struct kimage_arch {
 	int kern_segment;
 	phys_addr_t dtb_mem;
 	void *dtb_buf;
+	/* Core ELF header buffer */
+	void *elf_headers;
+	unsigned long elf_headers_sz;
+	unsigned long elf_load_addr;
 };
 
 /**
diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index 4dd524ad6611..2b3baf7285e0 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -39,8 +39,13 @@ static void *image_load(struct kimage *image,
 
 	/* Load the kernel */
 	kbuf.image = image;
-	kbuf.buf_min = 0;
-	kbuf.buf_max = ULONG_MAX;
+	if (image->type == KEXEC_TYPE_CRASH) {
+		kbuf.buf_min = crashk_res.start;
+		kbuf.buf_max = crashk_res.end + 1;
+	} else {
+		kbuf.buf_min = 0;
+		kbuf.buf_max = ULONG_MAX;
+	}
 	kbuf.top_down = false;
 
 	kbuf.buffer = kernel;
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 37c0a9dc2e47..ec674f4d267c 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -17,6 +17,7 @@
 #include <linux/memblock.h>
 #include <linux/of_fdt.h>
 #include <linux/types.h>
+#include <linux/vmalloc.h>
 #include <asm/byteorder.h>
 
 static int __dt_root_addr_cells;
@@ -32,6 +33,10 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 	vfree(image->arch.dtb_buf);
 	image->arch.dtb_buf = NULL;
 
+	vfree(image->arch.elf_headers);
+	image->arch.elf_headers = NULL;
+	image->arch.elf_headers_sz = 0;
+
 	return kexec_image_post_load_cleanup_default(image);
 }
 
@@ -76,6 +81,78 @@ int arch_kexec_walk_mem(struct kexec_buf *kbuf,
 	return ret;
 }
 
+static int __init arch_kexec_file_init(void)
+{
+	/* Those values are used later on loading the kernel */
+	__dt_root_addr_cells = dt_root_addr_cells;
+	__dt_root_size_cells = dt_root_size_cells;
+
+	return 0;
+}
+late_initcall(arch_kexec_file_init);
+
+#define FDT_ALIGN(x, a)	(((x) + (a) - 1) & ~((a) - 1))
+#define FDT_TAGALIGN(x)	(FDT_ALIGN((x), FDT_TAGSIZE))
+
+static int fdt_prop_len(const char *prop_name, int len)
+{
+	return (strlen(prop_name) + 1) +
+		sizeof(struct fdt_property) +
+		FDT_TAGALIGN(len);
+}
+
+static bool cells_size_fitted(unsigned long base, unsigned long size)
+{
+	/* if *_cells >= 2, cells can hold 64-bit values anyway */
+	if ((__dt_root_addr_cells == 1) && (base >= (1ULL << 32)))
+		return false;
+
+	if ((__dt_root_size_cells == 1) && (size >= (1ULL << 32)))
+		return false;
+
+	return true;
+}
+
+static void fill_property(void *buf, u64 val64, int cells)
+{
+	u32 val32;
+
+	if (cells == 1) {
+		val32 = cpu_to_fdt32((u32)val64);
+		memcpy(buf, &val32, sizeof(val32));
+	} else {
+		memset(buf, 0, cells * sizeof(u32) - sizeof(u64));
+		buf += cells * sizeof(u32) - sizeof(u64);
+
+		val64 = cpu_to_fdt64(val64);
+		memcpy(buf, &val64, sizeof(val64));
+	}
+}
+
+static int fdt_setprop_range(void *fdt, int nodeoffset, const char *name,
+				unsigned long addr, unsigned long size)
+{
+	void *buf, *prop;
+	size_t buf_size;
+	int result;
+
+	buf_size = (__dt_root_addr_cells + __dt_root_size_cells) * sizeof(u32);
+	prop = buf = vmalloc(buf_size);
+	if (!buf)
+		return -ENOMEM;
+
+	fill_property(prop, addr, __dt_root_addr_cells);
+	prop += __dt_root_addr_cells * sizeof(u32);
+
+	fill_property(prop, size, __dt_root_size_cells);
+
+	result = fdt_setprop(fdt, nodeoffset, name, buf, buf_size);
+
+	vfree(buf);
+
+	return result;
+}
+
 static int setup_dtb(struct kimage *image,
 		unsigned long initrd_load_addr, unsigned long initrd_len,
 		char *cmdline, unsigned long cmdline_len,
@@ -88,10 +165,26 @@ static int setup_dtb(struct kimage *image,
 	int range_len;
 	int ret;
 
+	/* check ranges against root's #address-cells and #size-cells */
+	if (image->type == KEXEC_TYPE_CRASH &&
+		(!cells_size_fitted(image->arch.elf_load_addr,
+				image->arch.elf_headers_sz) ||
+		 !cells_size_fitted(crashk_res.start,
+				crashk_res.end - crashk_res.start + 1))) {
+		pr_err("Crash memory region doesn't fit into DT's root cell sizes.\n");
+		ret = -EINVAL;
+		goto out_err;
+	}
+
 	/* duplicate dt blob */
 	buf_size = fdt_totalsize(initial_boot_params);
 	range_len = (__dt_root_addr_cells + __dt_root_size_cells) * sizeof(u32);
 
+	if (image->type == KEXEC_TYPE_CRASH)
+		buf_size += fdt_prop_len("linux,elfcorehdr", range_len)
+				+ fdt_prop_len("linux,usable-memory-range",
+								range_len);
+
 	if (initrd_load_addr)
 		buf_size += fdt_prop_len("linux,initrd-start", sizeof(u64))
 				+ fdt_prop_len("linux,initrd-end", sizeof(u64));
@@ -113,6 +206,23 @@ static int setup_dtb(struct kimage *image,
 	if (nodeoffset < 0)
 		goto out_err;
 
+	if (image->type == KEXEC_TYPE_CRASH) {
+		/* add linux,elfcorehdr */
+		ret = fdt_setprop_range(buf, nodeoffset, "linux,elfcorehdr",
+				image->arch.elf_load_addr,
+				image->arch.elf_headers_sz);
+		if (ret)
+			goto out_err;
+
+		/* add linux,usable-memory-range */
+		ret = fdt_setprop_range(buf, nodeoffset,
+				"linux,usable-memory-range",
+				crashk_res.start,
+				crashk_res.end - crashk_res.start + 1);
+		if (ret)
+			goto out_err;
+	}
+
 	/* add bootargs */
 	if (cmdline) {
 		ret = fdt_setprop(buf, nodeoffset, "bootargs",
@@ -148,17 +258,109 @@ static int setup_dtb(struct kimage *image,
 	return ret;
 }
 
+static int get_nr_ranges_callback(struct resource *res, void *arg)
+{
+	unsigned int *nr_ranges = arg;
+
+	(*nr_ranges)++;
+	return 0;
+}
+
+static int add_mem_range_callback(struct resource *res, void *arg)
+{
+	struct crash_mem *cmem = arg;
+
+	cmem->ranges[cmem->nr_ranges].start = res->start;
+	cmem->ranges[cmem->nr_ranges].end = res->end;
+	cmem->nr_ranges++;
+
+	return 0;
+}
+
+static struct crash_mem *get_crash_memory_ranges(void)
+{
+	unsigned int nr_ranges;
+	struct crash_mem *cmem;
+
+	nr_ranges = 1; /* for exclusion of crashkernel region */
+	walk_system_ram_res(0, -1, &nr_ranges, get_nr_ranges_callback);
+
+	cmem = vmalloc(sizeof(struct crash_mem) +
+			sizeof(struct crash_mem_range) * nr_ranges);
+	if (!cmem)
+		return NULL;
+
+	cmem->max_nr_ranges = nr_ranges;
+	cmem->nr_ranges = 0;
+	walk_system_ram_res(0, -1, cmem, add_mem_range_callback);
+
+	/* Exclude crashkernel region */
+	if (crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end)) {
+		vfree(cmem);
+		return NULL;
+	}
+
+	return cmem;
+}
+
+static int prepare_elf_headers(void **addr, unsigned long *sz)
+{
+	struct crash_mem *cmem;
+	int ret = 0;
+
+	cmem = get_crash_memory_ranges();
+	if (!cmem)
+		return -ENOMEM;
+
+	ret =  crash_prepare_elf64_headers(cmem, true, addr, sz);
+
+	vfree(cmem);
+	return ret;
+}
+
 int load_other_segments(struct kimage *image,
 			char *initrd, unsigned long initrd_len,
 			char *cmdline, unsigned long cmdline_len)
 {
 	struct kexec_segment *kern_seg;
 	struct kexec_buf kbuf;
+	void *hdrs_addr;
+	unsigned long hdrs_sz;
 	unsigned long initrd_load_addr = 0;
 	char *dtb = NULL;
 	unsigned long dtb_len = 0;
 	int ret = 0;
 
+	/* load elf core header */
+	if (image->type == KEXEC_TYPE_CRASH) {
+		ret = prepare_elf_headers(&hdrs_addr, &hdrs_sz);
+		if (ret) {
+			pr_err("Preparing elf core header failed\n");
+			goto out_err;
+		}
+
+		kbuf.image = image;
+		kbuf.buffer = hdrs_addr;
+		kbuf.bufsz = hdrs_sz;
+		kbuf.memsz = hdrs_sz;
+		kbuf.buf_align = PAGE_SIZE;
+		kbuf.buf_min = crashk_res.start;
+		kbuf.buf_max = crashk_res.end + 1;
+		kbuf.top_down = true;
+
+		ret = kexec_add_buffer(&kbuf);
+		if (ret) {
+			vfree(hdrs_addr);
+			goto out_err;
+		}
+		image->arch.elf_headers = hdrs_addr;
+		image->arch.elf_headers_sz = hdrs_sz;
+		image->arch.elf_load_addr = kbuf.mem;
+
+		pr_debug("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+				 image->arch.elf_load_addr, hdrs_sz, hdrs_sz);
+	}
+
 	kern_seg = &image->segment[image->arch.kern_segment];
 	kbuf.image = image;
 	/* not allocate anything below the kernel */
-- 
2.17.0

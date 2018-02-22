Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932206AbeBVLTq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 06:19:46 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:42035 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932080AbeBVLTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 06:19:42 -0500
X-Google-Smtp-Source: AG47ELvcnoD7SYc473DoFSz6PQn8wHvwpCD1FHDvuPHvy16MPV9l6Cq3pBtfnRHhh/STK521GTxvDg==
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: catalin.marinas@arm.com, will.deacon@arm.com,
        bauerman@linux.vnet.ibm.com, dhowells@redhat.com, vgoyal@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        akpm@linux-foundation.org, mpe@ellerman.id.au, dyoung@redhat.com,
        bhe@redhat.com, arnd@arndb.de, ard.biesheuvel@linaro.org,
        julien.thierry@arm.com
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v8 09/13] arm64: kexec_file: add crash dump support
Date: Thu, 22 Feb 2018 20:17:28 +0900
Message-Id: <20180222111732.23051-10-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180222111732.23051-1-takahiro.akashi@linaro.org>
References: <20180222111732.23051-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enable crash dump (kdump), we need to
* prepare the contents of ELF header of /proc/vmcore through
  load_crashdump_segments(), and
* set up two device tree properties, "linux,usable-memory-range" and
  "linux,elfcorehdr", which repsectively represent a memory range to be
  used on crash dump kernel and a region of ELF core header
  (The logic of this cod is also from kexec-tools.)

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/kexec.h         |   5 +
 arch/arm64/kernel/machine_kexec_file.c | 211 +++++++++++++++++++++++++++++++++
 2 files changed, 216 insertions(+)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index fc562db22d46..d7427d510e1b 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -99,6 +99,10 @@ static inline void crash_post_resume(void) {}
 struct kimage_arch {
 	phys_addr_t dtb_mem;
 	void *dtb_buf;
+	/* Core ELF header buffer */
+	void *elf_headers;
+	unsigned long elf_headers_sz;
+	unsigned long elf_load_addr;
 };
 
 struct kimage;
@@ -110,6 +114,7 @@ extern int load_other_segments(struct kimage *image,
 		unsigned long kernel_load_addr,
 		char *initrd, unsigned long initrd_len,
 		char *cmdline, unsigned long cmdline_len);
+extern int load_crashdump_segments(struct kimage *image);
 #endif
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 12012f247501..fc132047c8cd 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -19,6 +19,7 @@
 #include <linux/libfdt.h>
 #include <linux/memblock.h>
 #include <linux/of_fdt.h>
+#include <linux/vmalloc.h>
 
 static int __dt_root_addr_cells;
 static int __dt_root_size_cells;
@@ -32,6 +33,10 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 	vfree(image->arch.dtb_buf);
 	image->arch.dtb_buf = NULL;
 
+	vfree(image->arch.elf_headers);
+	image->arch.elf_headers = NULL;
+	image->arch.elf_headers_sz = 0;
+
 	return _kimage_file_post_load_cleanup(image);
 }
 
@@ -49,6 +54,78 @@ int arch_kexec_walk_mem(struct kexec_buf *kbuf,
 		return walk_system_ram_res(0, ULONG_MAX, kbuf, func);
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
@@ -61,10 +138,26 @@ static int setup_dtb(struct kimage *image,
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
 		buf_size += fdt_prop_len("initrd-start", sizeof(u64))
 				+ fdt_prop_len("initrd-end", sizeof(u64));
@@ -86,6 +179,23 @@ static int setup_dtb(struct kimage *image,
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
@@ -187,3 +297,104 @@ int load_other_segments(struct kimage *image, unsigned long kernel_load_addr,
 	image->arch.dtb_buf = NULL;
 	return ret;
 }
+
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
+static int prepare_elf_core_header(void **addr, unsigned long *sz)
+{
+	struct crash_mem *cmem;
+	int ret = 0;
+
+	cmem = get_crash_memory_ranges();
+	if (!cmem)
+		return -ENOMEM;
+
+	/* 1: add segment for kernel map */
+	ret =  crash_prepare_elf64_headers(cmem, 1, addr, sz);
+
+	vfree(cmem);
+	return ret;
+}
+
+int load_crashdump_segments(struct kimage *image)
+{
+	void *elf_addr;
+	unsigned long elf_sz;
+	struct kexec_buf kbuf;
+	int ret;
+
+	if (image->type != KEXEC_TYPE_CRASH)
+		return 0;
+
+	ret = prepare_elf_core_header(&elf_addr, &elf_sz);
+	if (ret) {
+		pr_err("Preparing elf core header failed\n");
+		return ret;
+	}
+
+	kbuf.image = image;
+	kbuf.buffer = elf_addr;
+	kbuf.bufsz = elf_sz;
+	kbuf.memsz = elf_sz;
+	kbuf.buf_align = PAGE_SIZE;
+	kbuf.buf_min = crashk_res.start;
+	kbuf.buf_max = crashk_res.end + 1;
+	kbuf.top_down = 1;
+
+	ret = kexec_add_buffer(&kbuf);
+	if (ret) {
+		vfree(elf_addr);
+		return ret;
+	}
+	image->arch.elf_headers = elf_addr;
+	image->arch.elf_headers_sz = elf_sz;
+	image->arch.elf_load_addr = kbuf.mem;
+
+	pr_debug("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+			 image->arch.elf_load_addr, elf_sz, elf_sz);
+
+	return ret;
+}
-- 
2.16.2

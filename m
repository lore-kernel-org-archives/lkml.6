Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751511AbeDYG1R (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 02:27:17 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:39379 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751323AbeDYG1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 02:27:12 -0400
X-Google-Smtp-Source: AIpwx4+7NcMDD/cPq6wrQ2VCVIzt643rzH9kIgkRILykpp4I+2tDIfdOPgxEGEH4/PhsYkReq9ESDg==
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net,
        dyoung@redhat.com, bhe@redhat.com, arnd@arndb.de
Cc: ard.biesheuvel@linaro.org, james.morse@arm.com, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v9 05/11] arm64: kexec_file: load initrd and device-tree
Date: Wed, 25 Apr 2018 15:26:23 +0900
Message-Id: <20180425062629.29404-6-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425062629.29404-1-takahiro.akashi@linaro.org>
References: <20180425062629.29404-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

load_other_segments() is expected to allocate and place all the necessary
memory segments other than kernel, including initrd and device-tree
blob (and elf core header for crash).
While most of the code was borrowed from kexec-tools' counterpart,
users may not be allowed to specify dtb explicitly, instead, the dtb
presented by a boot loader is reused.

arch_kimage_kernel_post_load_cleanup() is responsible for freeing arm64-
specific data allocated in load_other_segments().

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/kexec.h         |  16 +++
 arch/arm64/kernel/machine_kexec_file.c | 160 +++++++++++++++++++++++++
 2 files changed, 176 insertions(+)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index e17f0529a882..e4de1223715f 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -93,6 +93,22 @@ static inline void crash_prepare_suspend(void) {}
 static inline void crash_post_resume(void) {}
 #endif
 
+#ifdef CONFIG_KEXEC_FILE
+#define ARCH_HAS_KIMAGE_ARCH
+
+struct kimage_arch {
+	int kern_segment;
+	phys_addr_t dtb_mem;
+	void *dtb_buf;
+};
+
+struct kimage;
+
+extern int load_other_segments(struct kimage *image,
+		char *initrd, unsigned long initrd_len,
+		char *cmdline, unsigned long cmdline_len);
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index f9ebf54ca247..b3b9b1725d8a 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -13,7 +13,26 @@
 #include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/kexec.h>
+#include <linux/libfdt.h>
 #include <linux/memblock.h>
+#include <linux/of_fdt.h>
+#include <linux/types.h>
+#include <asm/byteorder.h>
+
+static int __dt_root_addr_cells;
+static int __dt_root_size_cells;
+
+const struct kexec_file_ops * const kexec_file_loaders[] = {
+	NULL
+};
+
+int arch_kimage_file_post_load_cleanup(struct kimage *image)
+{
+	vfree(image->arch.dtb_buf);
+	image->arch.dtb_buf = NULL;
+
+	return kexec_image_post_load_cleanup_default(image);
+}
 
 int arch_kexec_walk_mem(struct kexec_buf *kbuf,
 				int (*func)(struct resource *, void *))
@@ -55,3 +74,144 @@ int arch_kexec_walk_mem(struct kexec_buf *kbuf,
 
 	return ret;
 }
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
+	int range_len;
+	int ret;
+
+	/* duplicate dt blob */
+	buf_size = fdt_totalsize(initial_boot_params);
+	range_len = (__dt_root_addr_cells + __dt_root_size_cells) * sizeof(u32);
+
+	if (initrd_load_addr)
+		buf_size += fdt_prop_len("linux,initrd-start", sizeof(u64))
+				+ fdt_prop_len("linux,initrd-end", sizeof(u64));
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
+		ret = fdt_setprop(buf, nodeoffset, "linux,initrd-start",
+				&value, sizeof(value));
+		if (ret)
+			goto out_err;
+
+		value = cpu_to_fdt64(initrd_load_addr + initrd_len);
+		ret = fdt_setprop(buf, nodeoffset, "linux,initrd-end",
+				&value, sizeof(value));
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
+			char *initrd, unsigned long initrd_len,
+			char *cmdline, unsigned long cmdline_len)
+{
+	struct kexec_segment *kern_seg;
+	struct kexec_buf kbuf;
+	unsigned long initrd_load_addr = 0;
+	char *dtb = NULL;
+	unsigned long dtb_len = 0;
+	int ret = 0;
+
+	kern_seg = &image->segment[image->arch.kern_segment];
+	kbuf.image = image;
+	/* not allocate anything below the kernel */
+	kbuf.buf_min = kern_seg->mem + kern_seg->memsz;
+
+	/* load initrd */
+	if (initrd) {
+		kbuf.buffer = initrd;
+		kbuf.bufsz = initrd_len;
+		kbuf.memsz = initrd_len;
+		kbuf.buf_align = 0;
+		/* within 1GB-aligned window of up to 32GB in size */
+		kbuf.buf_max = round_down(kern_seg->mem, SZ_1G)
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
+	image->arch.dtb_buf = NULL;
+	return ret;
+}
-- 
2.17.0

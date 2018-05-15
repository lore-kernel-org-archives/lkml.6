Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752479AbeEOBvw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 21:51:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34664 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752378AbeEOBvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 21:51:47 -0400
From: Lianbo Jiang <lijiang@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org, thomas.lendacky@amd.com, dyoung@redhat.com
Subject: [PATCH 2/2] support kdump when AMD secure memory encryption is active
Date: Tue, 15 May 2018 09:51:33 +0800
Message-Id: <20180515015133.4363-3-lijiang@redhat.com>
In-Reply-To: <20180515015133.4363-1-lijiang@redhat.com>
References: <20180515015133.4363-1-lijiang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When sme enabled on AMD server, we also need to support kdump. Because
the memory is encrypted in the first kernel, we will remap the old memory
encrypted to the second kernel(crash kernel), and sme is also enabled in
the second kernel, otherwise the old memory encrypted can not be decrypted.
Because simply changing the value of a C-bit on a page will not
automatically encrypt the existing contents of a page, and any data in the
page prior to the C-bit modification will become unintelligible. A page of
memory that is marked encrypted will be automatically decrypted when read
from DRAM and will be automatically encrypted when written to DRAM.

For the kdump, it is necessary to distinguish whether the memory is
encrypted. Furthermore, we should also know which part of the memory is
encrypted or decrypted. We will appropriately remap the memory according
to the specific situation in order to tell cpu how to deal with the data(
encrypted or unencrypted). For example, when sme enabled, if the old memory
is encrypted, we will remap the old memory in encrypted way, which will
automatically decrypt the old memory encrypted when we read those data from
the remapping address.

 ----------------------------------------------
| first-kernel | second-kernel | kdump support |
|      (mem_encrypt=on|off)    |   (yes|no)    |
|--------------+---------------+---------------|
|     on       |     on        |     yes       |
|     off      |     off       |     yes       |
|     on       |     off       |     no        |
|     off      |     on        |     no        |
|______________|_______________|_______________|

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 arch/x86/include/asm/dmi.h      | 14 +++++++++++++-
 arch/x86/kernel/acpi/boot.c     |  8 ++++++++
 arch/x86/kernel/crash_dump_64.c | 27 +++++++++++++++++++++++++++
 drivers/acpi/tables.c           | 14 +++++++++++++-
 drivers/iommu/amd_iommu_init.c  |  9 ++++++++-
 fs/proc/vmcore.c                | 36 +++++++++++++++++++++++++++++++-----
 include/linux/crash_dump.h      |  4 ++++
 kernel/kexec_core.c             | 12 ++++++++++++
 8 files changed, 116 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/dmi.h b/arch/x86/include/asm/dmi.h
index 0ab2ab2..a5663b4 100644
--- a/arch/x86/include/asm/dmi.h
+++ b/arch/x86/include/asm/dmi.h
@@ -7,6 +7,10 @@
 
 #include <asm/io.h>
 #include <asm/setup.h>
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+#include <linux/crash_dump.h>
+#include <linux/mem_encrypt.h>
+#endif
 
 static __always_inline __init void *dmi_alloc(unsigned len)
 {
@@ -14,7 +18,15 @@ static __always_inline __init void *dmi_alloc(unsigned len)
 }
 
 /* Use early IO mappings for DMI because it's initialized early */
-#define dmi_early_remap		early_memremap
+static __always_inline __init void *dmi_early_remap(resource_size_t
+					phys_addr, unsigned long size)
+{
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	if (sme_active() && is_kdump_kernel())
+		return early_memremap_decrypted(phys_addr, size);
+#endif
+	return early_memremap(phys_addr, size);
+}
 #define dmi_early_unmap		early_memunmap
 #define dmi_remap(_x, _l)	memremap(_x, _l, MEMREMAP_WB)
 #define dmi_unmap(_x)		memunmap(_x)
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 3b20607..354ad66 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -48,6 +48,10 @@
 #include <asm/mpspec.h>
 #include <asm/smp.h>
 #include <asm/i8259.h>
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+#include <linux/crash_dump.h>
+#include <linux/mem_encrypt.h>
+#endif
 
 #include "sleep.h" /* To include x86_acpi_suspend_lowlevel */
 static int __initdata acpi_force = 0;
@@ -124,6 +128,10 @@ void __init __iomem *__acpi_map_table(unsigned long phys, unsigned long size)
 	if (!phys || !size)
 		return NULL;
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	if (sme_active() && is_kdump_kernel())
+		return early_memremap_decrypted(phys, size);
+#endif
 	return early_memremap(phys, size);
 }
 
diff --git a/arch/x86/kernel/crash_dump_64.c b/arch/x86/kernel/crash_dump_64.c
index 4f2e077..2ef67fc 100644
--- a/arch/x86/kernel/crash_dump_64.c
+++ b/arch/x86/kernel/crash_dump_64.c
@@ -48,3 +48,30 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
 	iounmap(vaddr);
 	return csize;
 }
+
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf,
+		size_t csize, unsigned long offset, int userbuf)
+{
+	void  *vaddr;
+
+	if (!csize)
+		return 0;
+
+	vaddr = ioremap_encrypted(pfn << PAGE_SHIFT, PAGE_SIZE);
+	if (!vaddr)
+		return -ENOMEM;
+
+	if (userbuf) {
+		if (copy_to_user(buf, vaddr + offset, csize)) {
+			iounmap(vaddr);
+			return -EFAULT;
+		}
+	} else
+		memcpy(buf, vaddr + offset, csize);
+
+	set_iounmap_nonlazy();
+	iounmap(vaddr);
+	return csize;
+}
+#endif
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 849c4fb..6da9b0c 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -36,6 +36,10 @@
 #include <linux/memblock.h>
 #include <linux/initrd.h>
 #include "internal.h"
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+#include <linux/crash_dump.h>
+#include <linux/mem_encrypt.h>
+#endif
 
 #ifdef CONFIG_ACPI_CUSTOM_DSDT
 #include CONFIG_ACPI_CUSTOM_DSDT_FILE
@@ -566,7 +570,15 @@ void __init acpi_table_upgrade(void)
 			clen = size;
 			if (clen > MAP_CHUNK_SIZE - slop)
 				clen = MAP_CHUNK_SIZE - slop;
-			dest_p = early_memremap(dest_addr & PAGE_MASK,
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+			if (sme_active() && is_kdump_kernel())
+				dest_p = early_memremap_decrypted(
+						dest_addr & PAGE_MASK,
+						clen + slop);
+			else
+#endif
+				dest_p = early_memremap(
+						dest_addr & PAGE_MASK,
 						clen + slop);
 			memcpy(dest_p + slop, src_p, clen);
 			early_memunmap(dest_p, clen + slop);
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 904c575..8ecbddb 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -889,11 +889,18 @@ static bool copy_device_table(void)
 	}
 
 	old_devtb_phys = entry & PAGE_MASK;
+	if (sme_active() && is_kdump_kernel())
+		old_devtb_phys = __sme_clr(old_devtb_phys);
 	if (old_devtb_phys >= 0x100000000ULL) {
 		pr_err("The address of old device table is above 4G, not trustworthy!\n");
 		return false;
 	}
-	old_devtb = memremap(old_devtb_phys, dev_table_size, MEMREMAP_WB);
+	if (sme_active() && is_kdump_kernel())
+		old_devtb = ioremap_encrypted(old_devtb_phys,
+					dev_table_size);
+	else
+		old_devtb = memremap(old_devtb_phys,
+					dev_table_size, MEMREMAP_WB);
 	if (!old_devtb)
 		return false;
 
diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index a45f0af..316e2b0 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -25,6 +25,10 @@
 #include <linux/uaccess.h>
 #include <asm/io.h>
 #include "internal.h"
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+#include <linux/mem_encrypt.h>
+#include <asm/pgtable.h>
+#endif
 
 /* List representing chunks of contiguous memory areas and their offsets in
  * vmcore file.
@@ -86,7 +90,8 @@ static int pfn_is_ram(unsigned long pfn)
 
 /* Reads a page from the oldmem device from given offset. */
 static ssize_t read_from_oldmem(char *buf, size_t count,
-				u64 *ppos, int userbuf)
+				u64 *ppos, int userbuf,
+				bool encrypted)
 {
 	unsigned long pfn, offset;
 	size_t nr_bytes;
@@ -108,8 +113,15 @@ static ssize_t read_from_oldmem(char *buf, size_t count,
 		if (pfn_is_ram(pfn) == 0)
 			memset(buf, 0, nr_bytes);
 		else {
-			tmp = copy_oldmem_page(pfn, buf, nr_bytes,
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+			if (encrypted)
+				tmp = copy_oldmem_page_encrypted(pfn, buf,
+					       nr_bytes, offset, userbuf);
+			else
+#endif
+				tmp = copy_oldmem_page(pfn, buf, nr_bytes,
 						offset, userbuf);
+
 			if (tmp < 0)
 				return tmp;
 		}
@@ -143,7 +155,7 @@ void __weak elfcorehdr_free(unsigned long long addr)
  */
 ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
 {
-	return read_from_oldmem(buf, count, ppos, 0);
+	return read_from_oldmem(buf, count, ppos, 0, false);
 }
 
 /*
@@ -151,7 +163,11 @@ ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
  */
 ssize_t __weak elfcorehdr_read_notes(char *buf, size_t count, u64 *ppos)
 {
-	return read_from_oldmem(buf, count, ppos, 0);
+	bool flag = false;
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	flag = sme_active();
+#endif
+	return read_from_oldmem(buf, count, ppos, 0, flag);
 }
 
 /*
@@ -161,6 +177,10 @@ int __weak remap_oldmem_pfn_range(struct vm_area_struct *vma,
 				  unsigned long from, unsigned long pfn,
 				  unsigned long size, pgprot_t prot)
 {
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	if (sme_active())
+		prot = __pgprot(pgprot_val(prot) | _PAGE_ENC);
+#endif
 	return remap_pfn_range(vma, from, pfn, size, prot);
 }
 
@@ -188,6 +208,11 @@ static ssize_t __read_vmcore(char *buffer, size_t buflen, loff_t *fpos,
 	size_t tsz;
 	u64 start;
 	struct vmcore *m = NULL;
+	bool sme_flag = false;
+
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	sme_flag = sme_active();
+#endif
 
 	if (buflen == 0 || *fpos >= vmcore_size)
 		return 0;
@@ -235,7 +260,8 @@ static ssize_t __read_vmcore(char *buffer, size_t buflen, loff_t *fpos,
 					    m->offset + m->size - *fpos,
 					    buflen);
 			start = m->paddr + *fpos - m->offset;
-			tmp = read_from_oldmem(buffer, tsz, &start, userbuf);
+			tmp = read_from_oldmem(buffer, tsz, &start,
+						userbuf, sme_flag);
 			if (tmp < 0)
 				return tmp;
 			buflen -= tsz;
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index f7ac2aa..024ae9e 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -25,6 +25,10 @@ extern int remap_oldmem_pfn_range(struct vm_area_struct *vma,
 
 extern ssize_t copy_oldmem_page(unsigned long, char *, size_t,
 						unsigned long, int);
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+extern ssize_t copy_oldmem_page_encrypted(unsigned long, char *, size_t,
+						unsigned long, int);
+#endif
 void vmcore_cleanup(void);
 
 /* Architecture code defines this if there are other possible ELF
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 20fef1a..3c22a9b 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -471,6 +471,16 @@ static struct page *kimage_alloc_crash_control_pages(struct kimage *image,
 		}
 	}
 
+	if (pages) {
+		unsigned int count, i;
+
+		pages->mapping = NULL;
+		set_page_private(pages, order);
+		count = 1 << order;
+		for (i = 0; i < count; i++)
+			SetPageReserved(pages + i);
+		arch_kexec_post_alloc_pages(page_address(pages), 1 << order, 0);
+	}
 	return pages;
 }
 
@@ -865,6 +875,7 @@ static int kimage_load_crash_segment(struct kimage *image,
 			result  = -ENOMEM;
 			goto out;
 		}
+		arch_kexec_post_alloc_pages(page_address(page), 1, 0);
 		ptr = kmap(page);
 		ptr += maddr & ~PAGE_MASK;
 		mchunk = min_t(size_t, mbytes,
@@ -882,6 +893,7 @@ static int kimage_load_crash_segment(struct kimage *image,
 			result = copy_from_user(ptr, buf, uchunk);
 		kexec_flush_icache_page(page);
 		kunmap(page);
+		arch_kexec_pre_free_pages(page_address(page), 1);
 		if (result) {
 			result = -EFAULT;
 			goto out;
-- 
2.9.5

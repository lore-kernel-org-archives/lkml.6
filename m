Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030D3C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B8423D30
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:59:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B8423D30
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933910AbeF1I66 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 04:58:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46312 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933153AbeF1I6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 04:58:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 76B3840776E9;
        Thu, 28 Jun 2018 08:58:50 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-163.pek2.redhat.com [10.72.12.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94F6F2026D69;
        Thu, 28 Jun 2018 08:58:44 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        ebiederm@xmission.com, joro@8bytes.org, thomas.lendacky@amd.com,
        dyoung@redhat.com, kexec@lists.infradead.org,
        iommu@lists.linux-foundation.org, bhe@redhat.com
Subject: [PATCH 5/5 V4] Help to dump the old memory encrypted into vmcore file
Date:   Thu, 28 Jun 2018 16:58:06 +0800
Message-Id: <20180628085806.9280-6-lijiang@redhat.com>
In-Reply-To: <20180628085806.9280-1-lijiang@redhat.com>
References: <20180628085806.9280-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 28 Jun 2018 08:58:50 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 28 Jun 2018 08:58:50 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lijiang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kdump mode, we need to dump the old memory into vmcore file,
if SME is enabled in the first kernel, we must remap the old
memory in encrypted manner, which will be automatically decrypted
when we read from DRAM. It helps to parse the vmcore for some tools.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
Some changes:
1. add a new file and modify Makefile.
2. revert some code about previously using sev_active().
3. modify elfcorehdr_read().

 arch/x86/kernel/Makefile             |  1 +
 arch/x86/kernel/crash_dump_encrypt.c | 53 ++++++++++++++++++++++++++++++++++++
 fs/proc/vmcore.c                     | 45 +++++++++++++++++++++++++-----
 include/linux/crash_dump.h           | 12 ++++++++
 4 files changed, 104 insertions(+), 7 deletions(-)
 create mode 100644 arch/x86/kernel/crash_dump_encrypt.c

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 02d6f5c..afb5bad 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -96,6 +96,7 @@ obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec_$(BITS).o
 obj-$(CONFIG_KEXEC_CORE)	+= relocate_kernel_$(BITS).o crash.o
 obj-$(CONFIG_KEXEC_FILE)	+= kexec-bzimage64.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump_$(BITS).o
+obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= crash_dump_encrypt.o
 obj-y				+= kprobes/
 obj-$(CONFIG_MODULES)		+= module.o
 obj-$(CONFIG_DOUBLEFAULT)	+= doublefault.o
diff --git a/arch/x86/kernel/crash_dump_encrypt.c b/arch/x86/kernel/crash_dump_encrypt.c
new file mode 100644
index 0000000..e1b1a57
--- /dev/null
+++ b/arch/x86/kernel/crash_dump_encrypt.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *	Memory preserving reboot related code.
+ *
+ *	Created by: Lianbo Jiang (lijiang@redhat.com)
+ *	Copyright (C) RedHat Corporation, 2018. All rights reserved
+ */
+
+#include <linux/errno.h>
+#include <linux/crash_dump.h>
+#include <linux/uaccess.h>
+#include <linux/io.h>
+
+/**
+ * copy_oldmem_page_encrypted - copy one page from "oldmem encrypted"
+ * @pfn: page frame number to be copied
+ * @buf: target memory address for the copy; this can be in kernel address
+ *	space or user address space (see @userbuf)
+ * @csize: number of bytes to copy
+ * @offset: offset in bytes into the page (based on pfn) to begin the copy
+ * @userbuf: if set, @buf is in user address space, use copy_to_user(),
+ *	otherwise @buf is in kernel address space, use memcpy().
+ *
+ * Copy a page from "oldmem encrypted". For this page, there is no pte
+ * mapped in the current kernel. We stitch up a pte, similar to
+ * kmap_atomic.
+ */
+
+ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf,
+		size_t csize, unsigned long offset, int userbuf)
+{
+	void  *vaddr;
+
+	if (!csize)
+		return 0;
+
+	vaddr = (__force void *)ioremap_encrypted(pfn << PAGE_SHIFT,
+						  PAGE_SIZE);
+	if (!vaddr)
+		return -ENOMEM;
+
+	if (userbuf) {
+		if (copy_to_user((void __user *)buf, vaddr + offset, csize)) {
+			iounmap((void __iomem *)vaddr);
+			return -EFAULT;
+		}
+	} else
+		memcpy(buf, vaddr + offset, csize);
+
+	set_iounmap_nonlazy();
+	iounmap((void __iomem *)vaddr);
+	return csize;
+}
diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index cfb6674..5fef489 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -26,6 +26,8 @@
 #include <linux/uaccess.h>
 #include <asm/io.h>
 #include "internal.h"
+#include <linux/mem_encrypt.h>
+#include <asm/pgtable.h>
 
 /* List representing chunks of contiguous memory areas and their offsets in
  * vmcore file.
@@ -98,7 +100,8 @@ static int pfn_is_ram(unsigned long pfn)
 
 /* Reads a page from the oldmem device from given offset. */
 static ssize_t read_from_oldmem(char *buf, size_t count,
-				u64 *ppos, int userbuf)
+				u64 *ppos, int userbuf,
+				bool encrypted)
 {
 	unsigned long pfn, offset;
 	size_t nr_bytes;
@@ -120,8 +123,11 @@ static ssize_t read_from_oldmem(char *buf, size_t count,
 		if (pfn_is_ram(pfn) == 0)
 			memset(buf, 0, nr_bytes);
 		else {
-			tmp = copy_oldmem_page(pfn, buf, nr_bytes,
-						offset, userbuf);
+			tmp = encrypted ? copy_oldmem_page_encrypted(pfn,
+					    buf, nr_bytes, offset, userbuf)
+					: copy_oldmem_page(pfn, buf, nr_bytes,
+							   offset, userbuf);
+
 			if (tmp < 0)
 				return tmp;
 		}
@@ -151,11 +157,34 @@ void __weak elfcorehdr_free(unsigned long long addr)
 {}
 
 /*
- * Architectures may override this function to read from ELF header
+ * Architectures may override this function to read from ELF header.
+ * The kexec-tools will allocated the memory and build the elf header
+ * in the first kernel, subsequently, we will copy the data in the
+ * memory to the reserved crash memory. In kdump mode, we will read the
+ * elf header from the reserved crash memory, from this point of view,
+ * which is not an old memory, the original function called may mislead
+ * and do unnecessary things.
+ * For SME, it copies the elf header from the memory encrypted(user space)
+ * to the memory unencrypted(kernel space) when SME is activated in the
+ * first kernel, this operation just leads to decryption.
  */
 ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
 {
-	return read_from_oldmem(buf, count, ppos, 0);
+	char *kbuf;
+	resource_size_t offset;
+
+	if (!count)
+		return 0;
+
+	offset = (resource_size_t)*ppos;
+	kbuf = memremap(offset, count, MEMREMAP_WB);
+	if (!kbuf)
+		return 0;
+
+	memcpy(buf, kbuf, count);
+	memunmap(kbuf);
+
+	return count;
 }
 
 /*
@@ -163,7 +192,7 @@ ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
  */
 ssize_t __weak elfcorehdr_read_notes(char *buf, size_t count, u64 *ppos)
 {
-	return read_from_oldmem(buf, count, ppos, 0);
+	return read_from_oldmem(buf, count, ppos, 0, sme_active());
 }
 
 /*
@@ -173,6 +202,7 @@ int __weak remap_oldmem_pfn_range(struct vm_area_struct *vma,
 				  unsigned long from, unsigned long pfn,
 				  unsigned long size, pgprot_t prot)
 {
+	prot = pgprot_encrypted(prot);
 	return remap_pfn_range(vma, from, pfn, size, prot);
 }
 
@@ -349,7 +379,8 @@ static ssize_t __read_vmcore(char *buffer, size_t buflen, loff_t *fpos,
 					    m->offset + m->size - *fpos,
 					    buflen);
 			start = m->paddr + *fpos - m->offset;
-			tmp = read_from_oldmem(buffer, tsz, &start, userbuf);
+			tmp = read_from_oldmem(buffer, tsz, &start, userbuf,
+						sme_active());
 			if (tmp < 0)
 				return tmp;
 			buflen -= tsz;
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index 3e4ba9d..a7e7be8 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -26,6 +26,18 @@ extern int remap_oldmem_pfn_range(struct vm_area_struct *vma,
 
 extern ssize_t copy_oldmem_page(unsigned long, char *, size_t,
 						unsigned long, int);
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+extern ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf,
+					   size_t csize, unsigned long offset,
+					   int userbuf);
+#else
+static inline
+ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf, size_t csize,
+				    unsigned long offset, int userbuf)
+{
+	return 0;
+}
+#endif
 void vmcore_cleanup(void);
 
 /* Architecture code defines this if there are other possible ELF
-- 
2.9.5


Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED65C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD5321570
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD5321570
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbeI0NiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 09:38:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48622 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbeI0NiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 09:38:04 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 390674E33A;
        Thu, 27 Sep 2018 07:21:15 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-101.pek2.redhat.com [10.72.12.101])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C3E2B600C7;
        Thu, 27 Sep 2018 07:20:59 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, thomas.lendacky@amd.com,
        bhelgaas@google.com, baiyaowei@cmss.chinamobile.com, tiwai@suse.de,
        bp@suse.de, brijesh.singh@amd.com, dyoung@redhat.com,
        bhe@redhat.com, jroedel@suse.de
Subject: [PATCH v7 RESEND 4/4] kdump/vmcore: support encrypted old memory with SME enabled
Date:   Thu, 27 Sep 2018 15:19:54 +0800
Message-Id: <20180927071954.29615-5-lijiang@redhat.com>
In-Reply-To: <20180927071954.29615-1-lijiang@redhat.com>
References: <20180927071954.29615-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 27 Sep 2018 07:21:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kdump kernel, we need to dump the old memory into vmcore file,if SME
is enabled in the first kernel, we have to remap the old memory with the
memory encryption mask, which will be automatically decrypted when we
read from DRAM.

For SME kdump, there are two cases that doesn't support:

 ----------------------------------------------
| first-kernel | second-kernel | kdump support |
|      (mem_encrypt=on|off)    |   (yes|no)    |
|--------------+---------------+---------------|
|     on       |     on        |     yes       |
|     off      |     off       |     yes       |
|     on       |     off       |     no        |
|     off      |     on        |     no        |
|______________|_______________|_______________|

1. SME is enabled in the first kernel, but SME is disabled in kdump kernel
In this case, because the old memory is encrypted, we can't decrypt the
old memory.

2. SME is disabled in the first kernel, but SME is enabled in kdump kernel
On the one hand, the old memory is unencrypted, the old memory can be dumped
as usual, we don't need to enable SME in kdump kernel; On the other hand, it
will increase the complexity of the code, we will have to consider how to
pass the SME flag from the first kernel to the kdump kernel, it is really
too expensive to do this.

This patches are only for SME kdump, the patches don't support SEV kdump.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/kernel/Makefile             |  1 +
 arch/x86/kernel/crash_dump_encrypt.c | 53 ++++++++++++++++++++++++++++
 fs/proc/vmcore.c                     | 21 +++++++----
 include/linux/crash_dump.h           | 12 +++++++
 4 files changed, 81 insertions(+), 6 deletions(-)
 create mode 100644 arch/x86/kernel/crash_dump_encrypt.c

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 8824d01c0c35..dfbeae0e35ce 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -97,6 +97,7 @@ obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec_$(BITS).o
 obj-$(CONFIG_KEXEC_CORE)	+= relocate_kernel_$(BITS).o crash.o
 obj-$(CONFIG_KEXEC_FILE)	+= kexec-bzimage64.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump_$(BITS).o
+obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= crash_dump_encrypt.o
 obj-y				+= kprobes/
 obj-$(CONFIG_MODULES)		+= module.o
 obj-$(CONFIG_DOUBLEFAULT)	+= doublefault.o
diff --git a/arch/x86/kernel/crash_dump_encrypt.c b/arch/x86/kernel/crash_dump_encrypt.c
new file mode 100644
index 000000000000..e1b1a577f197
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
index cbde728f8ac6..3065c8bada6a 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -25,6 +25,9 @@
 #include <linux/pagemap.h>
 #include <linux/uaccess.h>
 #include <asm/io.h>
+#include <linux/io.h>
+#include <linux/mem_encrypt.h>
+#include <asm/pgtable.h>
 #include "internal.h"
 
 /* List representing chunks of contiguous memory areas and their offsets in
@@ -98,7 +101,8 @@ static int pfn_is_ram(unsigned long pfn)
 
 /* Reads a page from the oldmem device from given offset. */
 static ssize_t read_from_oldmem(char *buf, size_t count,
-				u64 *ppos, int userbuf)
+				u64 *ppos, int userbuf,
+				bool encrypted)
 {
 	unsigned long pfn, offset;
 	size_t nr_bytes;
@@ -120,8 +124,11 @@ static ssize_t read_from_oldmem(char *buf, size_t count,
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
@@ -155,7 +162,7 @@ void __weak elfcorehdr_free(unsigned long long addr)
  */
 ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
 {
-	return read_from_oldmem(buf, count, ppos, 0);
+	return read_from_oldmem(buf, count, ppos, 0, false);
 }
 
 /*
@@ -163,7 +170,7 @@ ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
  */
 ssize_t __weak elfcorehdr_read_notes(char *buf, size_t count, u64 *ppos)
 {
-	return read_from_oldmem(buf, count, ppos, 0);
+	return read_from_oldmem(buf, count, ppos, 0, sme_active());
 }
 
 /*
@@ -173,6 +180,7 @@ int __weak remap_oldmem_pfn_range(struct vm_area_struct *vma,
 				  unsigned long from, unsigned long pfn,
 				  unsigned long size, pgprot_t prot)
 {
+	prot = pgprot_encrypted(prot);
 	return remap_pfn_range(vma, from, pfn, size, prot);
 }
 
@@ -351,7 +359,8 @@ static ssize_t __read_vmcore(char *buffer, size_t buflen, loff_t *fpos,
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
index 3e4ba9d753c8..a7e7be8b0502 100644
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
2.17.1


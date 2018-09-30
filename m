Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E9EC43143
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 03:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B2F820685
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 03:11:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B2F820685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbeI3Jmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 05:42:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54914 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728204AbeI3Jmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 05:42:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CB2E437E60;
        Sun, 30 Sep 2018 03:11:44 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-92.pek2.redhat.com [10.72.12.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C240B6B8ED;
        Sun, 30 Sep 2018 03:11:31 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, thomas.lendacky@amd.com,
        bhelgaas@google.com, baiyaowei@cmss.chinamobile.com, tiwai@suse.de,
        bp@suse.de, brijesh.singh@amd.com, dyoung@redhat.com,
        bhe@redhat.com, jroedel@suse.de
Subject: [PATCH v8 RESEND 4/4] kdump/vmcore: support encrypted old memory with SME enabled
Date:   Sun, 30 Sep 2018 11:10:33 +0800
Message-Id: <20180930031033.22110-5-lijiang@redhat.com>
In-Reply-To: <20180930031033.22110-1-lijiang@redhat.com>
References: <20180930031033.22110-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Sun, 30 Sep 2018 03:11:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kdump kernel, the old memory needs to be dumped into vmcore file.
If SME is enabled in the first kernel, the old memory has to be
remapped with the memory encryption mask, which will be automatically
decrypted when read from DRAM.

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
In this case, because the old memory is encrypted, it can't be decrypted.
The root cause is that the encryption key is not visible to any software
runnint on the CPU cores(AMD cpu with SME), and is randomly generated on
eache system reset. That is to say, kdump kernel won't have a chance to
get the encryption key. So the encrypted memory can not be decrypted
unless SME is active.

2. SME is disabled in the first kernel, but SME is enabled in kdump kernel
On the one hand, the old memory is decrypted, the old memory can be dumped
as usual, so SME doesn't need to be enabled in kdump kernel; On the other
hand, it will increase the complexity of the code, because that will have
to consider how to pass the SME flag from the first kernel to the kdump
kernel, it is really too expensive to do this.

This patches are only for SME kdump, the patches don't support SEV kdump.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
---
Changes since v7:
1. Delete a file arch/x86/kernel/crash_dump_encrypt.c, and move the
copy_oldmem_page_encrypted() to arch/x86/kernel/crash_dump_64.c, also
rewrite some functions.(Suggested by Borislav)
2. Modify all code style issue.(Suggested by Borislav)
3. Remove a reduntant header file.(Suggested by Borislav)
4. Improve patch log.(Suggested by Borislav)
5. Modify compile error "fs/proc/vmcore.c:115: undefined reference
   to `copy_oldmem_page_encrypted'" 

 arch/x86/kernel/crash_dump_64.c | 65 ++++++++++++++++++++++++++++-----
 fs/proc/vmcore.c                | 24 +++++++++---
 include/linux/crash_dump.h      | 13 +++++++
 3 files changed, 87 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/crash_dump_64.c b/arch/x86/kernel/crash_dump_64.c
index 4f2e0778feac..6adbde592c44 100644
--- a/arch/x86/kernel/crash_dump_64.c
+++ b/arch/x86/kernel/crash_dump_64.c
@@ -12,7 +12,7 @@
 #include <linux/io.h>
 
 /**
- * copy_oldmem_page - copy one page from "oldmem"
+ * __copy_oldmem_page - copy one page from "old memory encrypted or decrypted"
  * @pfn: page frame number to be copied
  * @buf: target memory address for the copy; this can be in kernel address
  *	space or user address space (see @userbuf)
@@ -20,31 +20,78 @@
  * @offset: offset in bytes into the page (based on pfn) to begin the copy
  * @userbuf: if set, @buf is in user address space, use copy_to_user(),
  *	otherwise @buf is in kernel address space, use memcpy().
+ * @encrypted: if true, the old memory is encrypted.
+ *             if false, the old memory is decrypted.
  *
- * Copy a page from "oldmem". For this page, there is no pte mapped
- * in the current kernel. We stitch up a pte, similar to kmap_atomic.
+ * Copy a page from "old memory encrypted or decrypted". For this page, there
+ * is no pte mapped in the current kernel. We stitch up a pte, similar to
+ * kmap_atomic.
  */
-ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
-		size_t csize, unsigned long offset, int userbuf)
+static ssize_t __copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
+				  unsigned long offset, int userbuf,
+				  bool encrypted)
 {
 	void  *vaddr;
 
 	if (!csize)
 		return 0;
 
-	vaddr = ioremap_cache(pfn << PAGE_SHIFT, PAGE_SIZE);
+	if (encrypted)
+		vaddr = (__force void *)ioremap_encrypted(pfn << PAGE_SHIFT, PAGE_SIZE);
+	else
+		vaddr = (__force void *)ioremap_cache(pfn << PAGE_SHIFT, PAGE_SIZE);
+
 	if (!vaddr)
 		return -ENOMEM;
 
 	if (userbuf) {
-		if (copy_to_user(buf, vaddr + offset, csize)) {
-			iounmap(vaddr);
+		if (copy_to_user((void __user *)buf, vaddr + offset, csize)) {
+			iounmap((void __iomem *)vaddr);
 			return -EFAULT;
 		}
 	} else
 		memcpy(buf, vaddr + offset, csize);
 
 	set_iounmap_nonlazy();
-	iounmap(vaddr);
+	iounmap((void __iomem *)vaddr);
 	return csize;
 }
+
+/**
+ * copy_oldmem_page - copy one page from "old memory decrypted"
+ * @pfn: page frame number to be copied
+ * @buf: target memory address for the copy; this can be in kernel address
+ *	space or user address space (see @userbuf)
+ * @csize: number of bytes to copy
+ * @offset: offset in bytes into the page (based on pfn) to begin the copy
+ * @userbuf: if set, @buf is in user address space, use copy_to_user(),
+ *	otherwise @buf is in kernel address space, use memcpy().
+ *
+ * Copy a page from "old memory decrypted". For this page, there is no pte
+ * mapped in the current kernel. We stitch up a pte, similar to kmap_atomic.
+ */
+ssize_t copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
+			 unsigned long offset, int userbuf)
+{
+	return __copy_oldmem_page(pfn, buf, csize, offset, userbuf, false);
+}
+
+/**
+ * copy_oldmem_page_encrypted - copy one page from "old memory encrypted"
+ * @pfn: page frame number to be copied
+ * @buf: target memory address for the copy; this can be in kernel address
+ *	space or user address space (see @userbuf)
+ * @csize: number of bytes to copy
+ * @offset: offset in bytes into the page (based on pfn) to begin the copy
+ * @userbuf: if set, @buf is in user address space, use copy_to_user(),
+ *	otherwise @buf is in kernel address space, use memcpy().
+ *
+ * Copy a page from "old memory encrypted". For this page, there is no pte
+ * mapped in the current kernel. We stitch up a pte, similar to
+ * kmap_atomic.
+ */
+ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf, size_t csize,
+				   unsigned long offset, int userbuf)
+{
+	return __copy_oldmem_page(pfn, buf, csize, offset, userbuf, true);
+}
diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index cbde728f8ac6..42c32d06f7da 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -24,6 +24,8 @@
 #include <linux/vmalloc.h>
 #include <linux/pagemap.h>
 #include <linux/uaccess.h>
+#include <linux/mem_encrypt.h>
+#include <asm/pgtable.h>
 #include <asm/io.h>
 #include "internal.h"
 
@@ -98,7 +100,8 @@ static int pfn_is_ram(unsigned long pfn)
 
 /* Reads a page from the oldmem device from given offset. */
 static ssize_t read_from_oldmem(char *buf, size_t count,
-				u64 *ppos, int userbuf)
+				u64 *ppos, int userbuf,
+				bool encrypted)
 {
 	unsigned long pfn, offset;
 	size_t nr_bytes;
@@ -120,8 +123,15 @@ static ssize_t read_from_oldmem(char *buf, size_t count,
 		if (pfn_is_ram(pfn) == 0)
 			memset(buf, 0, nr_bytes);
 		else {
-			tmp = copy_oldmem_page(pfn, buf, nr_bytes,
-						offset, userbuf);
+			if (encrypted)
+				tmp = copy_oldmem_page_encrypted(pfn, buf,
+								 nr_bytes,
+								 offset,
+								 userbuf);
+			else
+				tmp = copy_oldmem_page(pfn, buf, nr_bytes,
+						       offset, userbuf);
+
 			if (tmp < 0)
 				return tmp;
 		}
@@ -155,7 +165,7 @@ void __weak elfcorehdr_free(unsigned long long addr)
  */
 ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
 {
-	return read_from_oldmem(buf, count, ppos, 0);
+	return read_from_oldmem(buf, count, ppos, 0, false);
 }
 
 /*
@@ -163,7 +173,7 @@ ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
  */
 ssize_t __weak elfcorehdr_read_notes(char *buf, size_t count, u64 *ppos)
 {
-	return read_from_oldmem(buf, count, ppos, 0);
+	return read_from_oldmem(buf, count, ppos, 0, sme_active());
 }
 
 /*
@@ -173,6 +183,7 @@ int __weak remap_oldmem_pfn_range(struct vm_area_struct *vma,
 				  unsigned long from, unsigned long pfn,
 				  unsigned long size, pgprot_t prot)
 {
+	prot = pgprot_encrypted(prot);
 	return remap_pfn_range(vma, from, pfn, size, prot);
 }
 
@@ -351,7 +362,8 @@ static ssize_t __read_vmcore(char *buffer, size_t buflen, loff_t *fpos,
 					    m->offset + m->size - *fpos,
 					    buflen);
 			start = m->paddr + *fpos - m->offset;
-			tmp = read_from_oldmem(buffer, tsz, &start, userbuf);
+			tmp = read_from_oldmem(buffer, tsz, &start,
+					       userbuf, sme_active());
 			if (tmp < 0)
 				return tmp;
 			buflen -= tsz;
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index 3e4ba9d753c8..84d8ddcb818e 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -26,6 +26,19 @@ extern int remap_oldmem_pfn_range(struct vm_area_struct *vma,
 
 extern ssize_t copy_oldmem_page(unsigned long, char *, size_t,
 						unsigned long, int);
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+extern ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf,
+					  size_t csize, unsigned long offset,
+					  int userbuf);
+#else
+static inline
+ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf, size_t csize,
+				   unsigned long offset, int userbuf)
+{
+	return 0;
+}
+#endif
+
 void vmcore_cleanup(void);
 
 /* Architecture code defines this if there are other possible ELF
-- 
2.17.1


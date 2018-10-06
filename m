Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C248C65C30
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 11:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2396721473
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 11:47:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2396721473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbeJFSuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 14:50:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60161 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbeJFSuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 14:50:51 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w96BlaZt3530073
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 6 Oct 2018 04:47:36 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w96BlaXp3530070;
        Sat, 6 Oct 2018 04:47:36 -0700
Date:   Sat, 6 Oct 2018 04:47:36 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Lianbo Jiang <tipbot@zytor.com>
Message-ID: <tip-992b649a3f013465d8128da02e5449def662a4c3@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, lijiang@redhat.com, bp@suse.de,
        hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org
Reply-To: bp@suse.de, lijiang@redhat.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <be7b47f9-6be6-e0d1-2c2a-9125bc74b818@redhat.com>
References: <be7b47f9-6be6-e0d1-2c2a-9125bc74b818@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] kdump, proc/vmcore: Enable kdumping encrypted memory
 with SME enabled
Git-Commit-ID: 992b649a3f013465d8128da02e5449def662a4c3
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  992b649a3f013465d8128da02e5449def662a4c3
Gitweb:     https://git.kernel.org/tip/992b649a3f013465d8128da02e5449def662a4c3
Author:     Lianbo Jiang <lijiang@redhat.com>
AuthorDate: Sun, 30 Sep 2018 16:37:41 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Sat, 6 Oct 2018 12:09:26 +0200

kdump, proc/vmcore: Enable kdumping encrypted memory with SME enabled

In the kdump kernel, the memory of the first kernel needs to be dumped
into the vmcore file.

If SME is enabled in the first kernel, the old memory has to be remapped
with the memory encryption mask in order to access it properly.

Split copy_oldmem_page() functionality to handle encrypted memory
properly.

 [ bp: Heavily massage everything. ]

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: kexec@lists.infradead.org
Cc: tglx@linutronix.de
Cc: mingo@redhat.com
Cc: hpa@zytor.com
Cc: akpm@linux-foundation.org
Cc: dan.j.williams@intel.com
Cc: bhelgaas@google.com
Cc: baiyaowei@cmss.chinamobile.com
Cc: tiwai@suse.de
Cc: brijesh.singh@amd.com
Cc: dyoung@redhat.com
Cc: bhe@redhat.com
Cc: jroedel@suse.de
Link: https://lkml.kernel.org/r/be7b47f9-6be6-e0d1-2c2a-9125bc74b818@redhat.com
---
 arch/x86/kernel/crash_dump_64.c | 60 ++++++++++++++++++++++++++++-------------
 fs/proc/vmcore.c                | 24 ++++++++++++-----
 include/linux/crash_dump.h      |  4 +++
 3 files changed, 63 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kernel/crash_dump_64.c b/arch/x86/kernel/crash_dump_64.c
index 4f2e0778feac..eb8ab3915268 100644
--- a/arch/x86/kernel/crash_dump_64.c
+++ b/arch/x86/kernel/crash_dump_64.c
@@ -11,40 +11,62 @@
 #include <linux/uaccess.h>
 #include <linux/io.h>
 
-/**
- * copy_oldmem_page - copy one page from "oldmem"
- * @pfn: page frame number to be copied
- * @buf: target memory address for the copy; this can be in kernel address
- *	space or user address space (see @userbuf)
- * @csize: number of bytes to copy
- * @offset: offset in bytes into the page (based on pfn) to begin the copy
- * @userbuf: if set, @buf is in user address space, use copy_to_user(),
- *	otherwise @buf is in kernel address space, use memcpy().
- *
- * Copy a page from "oldmem". For this page, there is no pte mapped
- * in the current kernel. We stitch up a pte, similar to kmap_atomic.
- */
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
+ * copy_oldmem_page - copy one page of memory
+ * @pfn: page frame number to be copied
+ * @buf: target memory address for the copy; this can be in kernel address
+ *	space or user address space (see @userbuf)
+ * @csize: number of bytes to copy
+ * @offset: offset in bytes into the page (based on pfn) to begin the copy
+ * @userbuf: if set, @buf is in user address space, use copy_to_user(),
+ *	otherwise @buf is in kernel address space, use memcpy().
+ *
+ * Copy a page from the old kernel's memory. For this page, there is no pte
+ * mapped in the current kernel. We stitch up a pte, similar to kmap_atomic.
+ */
+ssize_t copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
+			 unsigned long offset, int userbuf)
+{
+	return __copy_oldmem_page(pfn, buf, csize, offset, userbuf, false);
+}
+
+/**
+ * copy_oldmem_page_encrypted - same as copy_oldmem_page() above but ioremap the
+ * memory with the encryption mask set to accomodate kdump on SME-enabled
+ * machines.
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
index 3e4ba9d753c8..f774c5eb9e3c 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -26,6 +26,10 @@ extern int remap_oldmem_pfn_range(struct vm_area_struct *vma,
 
 extern ssize_t copy_oldmem_page(unsigned long, char *, size_t,
 						unsigned long, int);
+extern ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf,
+					  size_t csize, unsigned long offset,
+					  int userbuf);
+
 void vmcore_cleanup(void);
 
 /* Architecture code defines this if there are other possible ELF

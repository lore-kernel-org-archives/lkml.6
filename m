Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BC5C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D8C520844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:42:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8C520844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbeIHCY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:24:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55032 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbeIHCYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:24:55 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 00686FEA;
        Fri,  7 Sep 2018 21:41:58 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Toshi Kani <toshi.kani@hp.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Brian Gerst <brgerst@gmail.com>, x86@kernel.org,
        mcgrof@suse.com, Dan Williams <dan.j.williams@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Airlie <airlied@redhat.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 46/47] x86/io: add interface to reserve io memtype for a resource range. (v1.1)
Date:   Fri,  7 Sep 2018 23:10:42 +0200
Message-Id: <20180907210909.311384712@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210904.607934824@linuxfoundation.org>
References: <20180907210904.607934824@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Airlie <airlied@redhat.com>

commit 8ef4227615e158faa4ee85a1d6466782f7e22f2f upstream.

A recent change to the mm code in:
87744ab3832b mm: fix cache mode tracking in vm_insert_mixed()

started enforcing checking the memory type against the registered list for
amixed pfn insertion mappings. It happens that the drm drivers for a number
of gpus relied on this being broken. Currently the driver only inserted
VRAM mappings into the tracking table when they came from the kernel,
and userspace mappings never landed in the table. This led to a regression
where all the mapping end up as UC instead of WC now.

I've considered a number of solutions but since this needs to be fixed
in fixes and not next, and some of the solutions were going to introduce
overhead that hadn't been there before I didn't consider them viable at
this stage. These mainly concerned hooking into the TTM io reserve APIs,
but these API have a bunch of fast paths I didn't want to unwind to add
this to.

The solution I've decided on is to add a new API like the arch_phys_wc
APIs (these would have worked but wc_del didn't take a range), and
use them from the drivers to add a WC compatible mapping to the table
for all VRAM on those GPUs. This means we can then create userspace
mapping that won't get degraded to UC.

v1.1: use CONFIG_X86_PAT + add some comments in io.h

Cc: Toshi Kani <toshi.kani@hp.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: x86@kernel.org
Cc: mcgrof@suse.com
Cc: Dan Williams <dan.j.williams@intel.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Airlie <airlied@redhat.com>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/io.h |    6 ++++++
 arch/x86/mm/pat.c         |   14 ++++++++++++++
 include/linux/io.h        |   22 ++++++++++++++++++++++
 3 files changed, 42 insertions(+)

--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -351,4 +351,10 @@ extern void arch_phys_wc_del(int handle)
 #define arch_phys_wc_add arch_phys_wc_add
 #endif
 
+#ifdef CONFIG_X86_PAT
+extern int arch_io_reserve_memtype_wc(resource_size_t start, resource_size_t size);
+extern void arch_io_free_memtype_wc(resource_size_t start, resource_size_t size);
+#define arch_io_reserve_memtype_wc arch_io_reserve_memtype_wc
+#endif
+
 #endif /* _ASM_X86_IO_H */
--- a/arch/x86/mm/pat.c
+++ b/arch/x86/mm/pat.c
@@ -726,6 +726,20 @@ void io_free_memtype(resource_size_t sta
 	free_memtype(start, end);
 }
 
+int arch_io_reserve_memtype_wc(resource_size_t start, resource_size_t size)
+{
+	enum page_cache_mode type = _PAGE_CACHE_MODE_WC;
+
+	return io_reserve_memtype(start, start + size, &type);
+}
+EXPORT_SYMBOL(arch_io_reserve_memtype_wc);
+
+void arch_io_free_memtype_wc(resource_size_t start, resource_size_t size)
+{
+	io_free_memtype(start, start + size);
+}
+EXPORT_SYMBOL(arch_io_free_memtype_wc);
+
 pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 				unsigned long size, pgprot_t vma_prot)
 {
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -154,4 +154,26 @@ enum {
 void *memremap(resource_size_t offset, size_t size, unsigned long flags);
 void memunmap(void *addr);
 
+/*
+ * On x86 PAT systems we have memory tracking that keeps track of
+ * the allowed mappings on memory ranges. This tracking works for
+ * all the in-kernel mapping APIs (ioremap*), but where the user
+ * wishes to map a range from a physical device into user memory
+ * the tracking won't be updated. This API is to be used by
+ * drivers which remap physical device pages into userspace,
+ * and wants to make sure they are mapped WC and not UC.
+ */
+#ifndef arch_io_reserve_memtype_wc
+static inline int arch_io_reserve_memtype_wc(resource_size_t base,
+					     resource_size_t size)
+{
+	return 0;
+}
+
+static inline void arch_io_free_memtype_wc(resource_size_t base,
+					   resource_size_t size)
+{
+}
+#endif
+
 #endif /* _LINUX_IO_H */



Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A75C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE2962087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE2962087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbeI3E0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:26:45 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51716 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728357AbeI3ES0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:26 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N66-0000H1-50; Sat, 29 Sep 2018 22:48:22 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5y-0006x4-R3; Sat, 29 Sep 2018 22:48:14 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, x86@kernel.org,
        "Brian Gerst" <brgerst@gmail.com>,
        "Toshi Kani" <toshi.kani@hp.com>,
        "Dave Airlie" <airlied@redhat.com>,
        "Dan Williams" <dan.j.williams@intel.com>, mcgrof@suse.com,
        "Ingo Molnar" <mingo@kernel.org>, "Borislav Petkov" <bp@alien8.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Denys Vlasenko" <dvlasenk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Andy Lutomirski" <luto@kernel.org>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.488323723@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 102/131] x86/io: add interface to reserve io memtype
 for a resource range. (v1.1)
In-Reply-To: <lsq.1538257386.330095874@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.59-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.16: Memory types have type unsigned long, and the
 constant is named _PAGE_CACHE_WC instead of _PAGE_CACHE_MODE_WC.]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/io.h |  6 ++++++
 arch/x86/mm/pat.c         | 14 ++++++++++++++
 include/linux/io.h        | 22 ++++++++++++++++++++++
 3 files changed, 42 insertions(+)

--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -340,4 +340,10 @@ extern void arch_phys_wc_del(int handle)
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
@@ -481,6 +481,20 @@ void io_free_memtype(resource_size_t sta
 	free_memtype(start, end);
 }
 
+int arch_io_reserve_memtype_wc(resource_size_t start, resource_size_t size)
+{
+	unsigned long type = _PAGE_CACHE_WC;
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
@@ -101,4 +101,26 @@ static inline void arch_phys_wc_del(int
 #define arch_phys_wc_add arch_phys_wc_add
 #endif
 
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


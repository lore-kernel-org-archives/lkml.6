Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A316BC65C30
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 11:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E7D21473
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 11:46:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63E7D21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbeJFStO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 14:49:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36615 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbeJFStO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 14:49:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w96Bjqcu3529898
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 6 Oct 2018 04:45:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w96BjpjQ3529895;
        Sat, 6 Oct 2018 04:45:51 -0700
Date:   Sat, 6 Oct 2018 04:45:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Lianbo Jiang <tipbot@zytor.com>
Message-ID: <tip-c3a7a61c192ec350330128edb13db33a9bc0ace1@git.kernel.org>
Cc:     lijiang@redhat.com, mingo@kernel.org, hpa@zytor.com,
        thomas.lendacky@amd.com, tglx@linutronix.de, bp@suse.de,
        linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, bp@suse.de, linux-kernel@vger.kernel.org,
          lijiang@redhat.com, mingo@kernel.org, thomas.lendacky@amd.com,
          hpa@zytor.com
In-Reply-To: <20180927071954.29615-2-lijiang@redhat.com>
References: <20180927071954.29615-2-lijiang@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/ioremap: Add an ioremap_encrypted() helper
Git-Commit-ID: c3a7a61c192ec350330128edb13db33a9bc0ace1
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

Commit-ID:  c3a7a61c192ec350330128edb13db33a9bc0ace1
Gitweb:     https://git.kernel.org/tip/c3a7a61c192ec350330128edb13db33a9bc0ace1
Author:     Lianbo Jiang <lijiang@redhat.com>
AuthorDate: Thu, 27 Sep 2018 15:19:51 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Sat, 6 Oct 2018 11:57:51 +0200

x86/ioremap: Add an ioremap_encrypted() helper

When SME is enabled, the memory is encrypted in the first kernel. In
this case, SME also needs to be enabled in the kdump kernel, and we have
to remap the old memory with the memory encryption mask.

The case of concern here is if SME is active in the first kernel,
and it is active too in the kdump kernel. There are four cases to be
considered:

a. dump vmcore
   It is encrypted in the first kernel, and needs be read out in the
   kdump kernel.

b. crash notes
   When dumping vmcore, the people usually need to read useful
   information from notes, and the notes is also encrypted.

c. iommu device table
   It's encrypted in the first kernel, kdump kernel needs to access its
   content to analyze and get information it needs.

d. mmio of AMD iommu
   not encrypted in both kernels

Add a new bool parameter @encrypted to __ioremap_caller(). If set,
memory will be remapped with the SME mask.

Add a new function ioremap_encrypted() to explicitly pass in a true
value for @encrypted. Use ioremap_encrypted() for the above a, b, c
cases.

 [ bp: cleanup commit message, extern defs in io.h and drop forgotten
   include. ]

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
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
Link: https://lkml.kernel.org/r/20180927071954.29615-2-lijiang@redhat.com
---
 arch/x86/include/asm/io.h |  3 ++-
 arch/x86/mm/ioremap.c     | 24 ++++++++++++++++--------
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 6de64840dd22..6df53efcecfd 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -187,11 +187,12 @@ extern void __iomem *ioremap_nocache(resource_size_t offset, unsigned long size)
 #define ioremap_nocache ioremap_nocache
 extern void __iomem *ioremap_uc(resource_size_t offset, unsigned long size);
 #define ioremap_uc ioremap_uc
-
 extern void __iomem *ioremap_cache(resource_size_t offset, unsigned long size);
 #define ioremap_cache ioremap_cache
 extern void __iomem *ioremap_prot(resource_size_t offset, unsigned long size, unsigned long prot_val);
 #define ioremap_prot ioremap_prot
+extern void __iomem *ioremap_encrypted(resource_size_t phys_addr, unsigned long size);
+#define ioremap_encrypted ioremap_encrypted
 
 /**
  * ioremap     -   map bus memory into CPU space
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index c63a545ec199..24e0920a9b25 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -131,7 +131,8 @@ static void __ioremap_check_mem(resource_size_t addr, unsigned long size,
  * caller shouldn't need to know that small detail.
  */
 static void __iomem *__ioremap_caller(resource_size_t phys_addr,
-		unsigned long size, enum page_cache_mode pcm, void *caller)
+		unsigned long size, enum page_cache_mode pcm,
+		void *caller, bool encrypted)
 {
 	unsigned long offset, vaddr;
 	resource_size_t last_addr;
@@ -199,7 +200,7 @@ static void __iomem *__ioremap_caller(resource_size_t phys_addr,
 	 * resulting mapping.
 	 */
 	prot = PAGE_KERNEL_IO;
-	if (sev_active() && mem_flags.desc_other)
+	if ((sev_active() && mem_flags.desc_other) || encrypted)
 		prot = pgprot_encrypted(prot);
 
 	switch (pcm) {
@@ -291,7 +292,7 @@ void __iomem *ioremap_nocache(resource_size_t phys_addr, unsigned long size)
 	enum page_cache_mode pcm = _PAGE_CACHE_MODE_UC_MINUS;
 
 	return __ioremap_caller(phys_addr, size, pcm,
-				__builtin_return_address(0));
+				__builtin_return_address(0), false);
 }
 EXPORT_SYMBOL(ioremap_nocache);
 
@@ -324,7 +325,7 @@ void __iomem *ioremap_uc(resource_size_t phys_addr, unsigned long size)
 	enum page_cache_mode pcm = _PAGE_CACHE_MODE_UC;
 
 	return __ioremap_caller(phys_addr, size, pcm,
-				__builtin_return_address(0));
+				__builtin_return_address(0), false);
 }
 EXPORT_SYMBOL_GPL(ioremap_uc);
 
@@ -341,7 +342,7 @@ EXPORT_SYMBOL_GPL(ioremap_uc);
 void __iomem *ioremap_wc(resource_size_t phys_addr, unsigned long size)
 {
 	return __ioremap_caller(phys_addr, size, _PAGE_CACHE_MODE_WC,
-					__builtin_return_address(0));
+					__builtin_return_address(0), false);
 }
 EXPORT_SYMBOL(ioremap_wc);
 
@@ -358,14 +359,21 @@ EXPORT_SYMBOL(ioremap_wc);
 void __iomem *ioremap_wt(resource_size_t phys_addr, unsigned long size)
 {
 	return __ioremap_caller(phys_addr, size, _PAGE_CACHE_MODE_WT,
-					__builtin_return_address(0));
+					__builtin_return_address(0), false);
 }
 EXPORT_SYMBOL(ioremap_wt);
 
+void __iomem *ioremap_encrypted(resource_size_t phys_addr, unsigned long size)
+{
+	return __ioremap_caller(phys_addr, size, _PAGE_CACHE_MODE_WB,
+				__builtin_return_address(0), true);
+}
+EXPORT_SYMBOL(ioremap_encrypted);
+
 void __iomem *ioremap_cache(resource_size_t phys_addr, unsigned long size)
 {
 	return __ioremap_caller(phys_addr, size, _PAGE_CACHE_MODE_WB,
-				__builtin_return_address(0));
+				__builtin_return_address(0), false);
 }
 EXPORT_SYMBOL(ioremap_cache);
 
@@ -374,7 +382,7 @@ void __iomem *ioremap_prot(resource_size_t phys_addr, unsigned long size,
 {
 	return __ioremap_caller(phys_addr, size,
 				pgprot2cachemode(__pgprot(prot_val)),
-				__builtin_return_address(0));
+				__builtin_return_address(0), false);
 }
 EXPORT_SYMBOL(ioremap_prot);
 

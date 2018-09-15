Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCB9ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 18:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0555D2083A
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 18:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0555D2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbeIPAML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 20:12:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38645 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbeIPAML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 20:12:11 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8FIpqeo3924490
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 15 Sep 2018 11:51:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8FIppVh3924485;
        Sat, 15 Sep 2018 11:51:51 -0700
Date:   Sat, 15 Sep 2018 11:51:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Brijesh Singh <tipbot@zytor.com>
Message-ID: <tip-b3f0907c71e006e12fde74ea9a745b6096b6f90f@git.kernel.org>
Cc:     hpa@zytor.com, mingo@kernel.org, sean.j.christopherson@intel.com,
        linux-kernel@vger.kernel.org, bp@suse.de, rkrcmar@redhat.com,
        pbonzini@redhat.com, tglx@linutronix.de, thomas.lendacky@amd.com,
        brijesh.singh@amd.com
Reply-To: thomas.lendacky@amd.com, tglx@linutronix.de,
          brijesh.singh@amd.com, rkrcmar@redhat.com, bp@suse.de,
          pbonzini@redhat.com, sean.j.christopherson@intel.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org
In-Reply-To: <1536932759-12905-2-git-send-email-brijesh.singh@amd.com>
References: <1536932759-12905-2-git-send-email-brijesh.singh@amd.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/mm: Add .bss..decrypted section to hold shared
 variables
Git-Commit-ID: b3f0907c71e006e12fde74ea9a745b6096b6f90f
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

Commit-ID:  b3f0907c71e006e12fde74ea9a745b6096b6f90f
Gitweb:     https://git.kernel.org/tip/b3f0907c71e006e12fde74ea9a745b6096b6f90f
Author:     Brijesh Singh <brijesh.singh@amd.com>
AuthorDate: Fri, 14 Sep 2018 08:45:58 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 15 Sep 2018 20:48:45 +0200

x86/mm: Add .bss..decrypted section to hold shared variables

kvmclock defines few static variables which are shared with the
hypervisor during the kvmclock initialization.

When SEV is active, memory is encrypted with a guest-specific key, and
if the guest OS wants to share the memory region with the hypervisor
then it must clear the C-bit before sharing it.

Currently, we use kernel_physical_mapping_init() to split large pages
before clearing the C-bit on shared pages. But it fails when called from
the kvmclock initialization (mainly because the memblock allocator is
not ready that early during boot).

Add a __bss_decrypted section attribute which can be used when defining
such shared variable. The so-defined variables will be placed in the
.bss..decrypted section. This section will be mapped with C=0 early
during boot.

The .bss..decrypted section has a big chunk of memory that may be unused
when memory encryption is not active, free it when memory encryption is
not active.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Radim Krčmář<rkrcmar@redhat.com>
Cc: kvm@vger.kernel.org
Link: https://lkml.kernel.org/r/1536932759-12905-2-git-send-email-brijesh.singh@amd.com

---
 arch/x86/include/asm/mem_encrypt.h |  7 +++++++
 arch/x86/kernel/head64.c           | 16 ++++++++++++++++
 arch/x86/kernel/vmlinux.lds.S      | 19 +++++++++++++++++++
 arch/x86/mm/init.c                 |  4 ++++
 arch/x86/mm/mem_encrypt.c          | 24 ++++++++++++++++++++++++
 5 files changed, 70 insertions(+)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index c0643831706e..616f8e637bc3 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -48,10 +48,13 @@ int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size);
 
 /* Architecture __weak replacement functions */
 void __init mem_encrypt_init(void);
+void __init mem_encrypt_free_decrypted_mem(void);
 
 bool sme_active(void);
 bool sev_active(void);
 
+#define __bss_decrypted __attribute__((__section__(".bss..decrypted")))
+
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
 
 #define sme_me_mask	0ULL
@@ -77,6 +80,8 @@ early_set_memory_decrypted(unsigned long vaddr, unsigned long size) { return 0;
 static inline int __init
 early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0; }
 
+#define __bss_decrypted
+
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
 
 /*
@@ -88,6 +93,8 @@ early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0;
 #define __sme_pa(x)		(__pa(x) | sme_me_mask)
 #define __sme_pa_nodebug(x)	(__pa_nodebug(x) | sme_me_mask)
 
+extern char __start_bss_decrypted[], __end_bss_decrypted[], __start_bss_decrypted_unused[];
+
 #endif	/* __ASSEMBLY__ */
 
 #endif	/* __X86_MEM_ENCRYPT_H__ */
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 8047379e575a..c16af27eb23f 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -112,6 +112,7 @@ static bool __head check_la57_support(unsigned long physaddr)
 unsigned long __head __startup_64(unsigned long physaddr,
 				  struct boot_params *bp)
 {
+	unsigned long vaddr, vaddr_end;
 	unsigned long load_delta, *p;
 	unsigned long pgtable_flags;
 	pgdval_t *pgd;
@@ -234,6 +235,21 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	/* Encrypt the kernel and related (if SME is active) */
 	sme_encrypt_kernel(bp);
 
+	/*
+	 * Clear the memory encryption mask from the .bss..decrypted section.
+	 * The bss section will be memset to zero later in the initialization so
+	 * there is no need to zero it after changing the memory encryption
+	 * attribute.
+	 */
+	if (mem_encrypt_active()) {
+		vaddr = (unsigned long)__start_bss_decrypted;
+		vaddr_end = (unsigned long)__end_bss_decrypted;
+		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
+			i = pmd_index(vaddr);
+			pmd[i] -= sme_get_me_mask();
+		}
+	}
+
 	/*
 	 * Return the SME encryption mask (if SME is active) to be used as a
 	 * modifier for the initial pgdir entry programmed into CR3.
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 8bde0a419f86..5dd3317d761f 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -65,6 +65,23 @@ jiffies_64 = jiffies;
 #define ALIGN_ENTRY_TEXT_BEGIN	. = ALIGN(PMD_SIZE);
 #define ALIGN_ENTRY_TEXT_END	. = ALIGN(PMD_SIZE);
 
+/*
+ * This section contains data which will be mapped as decrypted. Memory
+ * encryption operates on a page basis. Make this section PMD-aligned
+ * to avoid splitting the pages while mapping the section early.
+ *
+ * Note: We use a separate section so that only this section gets
+ * decrypted to avoid exposing more than we wish.
+ */
+#define BSS_DECRYPTED						\
+	. = ALIGN(PMD_SIZE);					\
+	__start_bss_decrypted = .;				\
+	*(.bss..decrypted);					\
+	. = ALIGN(PAGE_SIZE);					\
+	__start_bss_decrypted_unused = .;			\
+	. = ALIGN(PMD_SIZE);					\
+	__end_bss_decrypted = .;				\
+
 #else
 
 #define X86_ALIGN_RODATA_BEGIN
@@ -74,6 +91,7 @@ jiffies_64 = jiffies;
 
 #define ALIGN_ENTRY_TEXT_BEGIN
 #define ALIGN_ENTRY_TEXT_END
+#define BSS_DECRYPTED
 
 #endif
 
@@ -355,6 +373,7 @@ SECTIONS
 		__bss_start = .;
 		*(.bss..page_aligned)
 		*(.bss)
+		BSS_DECRYPTED
 		. = ALIGN(PAGE_SIZE);
 		__bss_stop = .;
 	}
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 7a8fc26c1115..faca978ebf9d 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -815,10 +815,14 @@ void free_kernel_image_pages(void *begin, void *end)
 		set_memory_np_noalias(begin_ul, len_pages);
 }
 
+void __weak mem_encrypt_free_decrypted_mem(void) { }
+
 void __ref free_initmem(void)
 {
 	e820__reallocate_tables();
 
+	mem_encrypt_free_decrypted_mem();
+
 	free_kernel_image_pages(&__init_begin, &__init_end);
 }
 
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index b2de398d1fd3..006f373f54ab 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -348,6 +348,30 @@ bool sev_active(void)
 EXPORT_SYMBOL(sev_active);
 
 /* Architecture __weak replacement functions */
+void __init mem_encrypt_free_decrypted_mem(void)
+{
+	unsigned long vaddr, vaddr_end, npages;
+	int r;
+
+	vaddr = (unsigned long)__start_bss_decrypted_unused;
+	vaddr_end = (unsigned long)__end_bss_decrypted;
+	npages = (vaddr_end - vaddr) >> PAGE_SHIFT;
+
+	/*
+	 * The unused memory range was mapped decrypted, change the encryption
+	 * attribute from decrypted to encrypted before freeing it.
+	 */
+	if (mem_encrypt_active()) {
+		r = set_memory_encrypted(vaddr, npages);
+		if (r) {
+			pr_warn("failed to free unused decrypted pages\n");
+			return;
+		}
+	}
+
+	free_init_pages("unused decrypted", vaddr, vaddr_end);
+}
+
 void __init mem_encrypt_init(void)
 {
 	if (!sme_me_mask)

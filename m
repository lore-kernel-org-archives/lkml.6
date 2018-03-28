Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752792AbeC1IrM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 04:47:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38927 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752479AbeC1IrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 04:47:08 -0400
Date: Wed, 28 Mar 2018 01:46:30 -0700
From: tip-bot for Tom Lendacky <tipbot@zytor.com>
Message-ID: <tip-07344b15a994acadbe439aa4e75127ed1ccca099@git.kernel.org>
Cc: bp@alien8.de, tglx@linutronix.de, brijesh.singh@amd.com,
        thomas.lendacky@amd.com, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org
Reply-To: mingo@kernel.org, kirill.shutemov@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, brijesh.singh@amd.com,
        thomas.lendacky@amd.com, bp@alien8.de, tglx@linutronix.de
In-Reply-To: <20180327220711.8702.55842.stgit@tlendack-t1.amdoffice.net>
References: <20180327220711.8702.55842.stgit@tlendack-t1.amdoffice.net>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/boot: Fix SEV boot failure from change to
 __PHYSICAL_MASK_SHIFT
Git-Commit-ID: 07344b15a994acadbe439aa4e75127ed1ccca099
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  07344b15a994acadbe439aa4e75127ed1ccca099
Gitweb:     https://git.kernel.org/tip/07344b15a994acadbe439aa4e75127ed1ccca099
Author:     Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate: Tue, 27 Mar 2018 17:07:11 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Mar 2018 10:42:57 +0200

x86/boot: Fix SEV boot failure from change to __PHYSICAL_MASK_SHIFT

In arch/x86/boot/compressed/kaslr_64.c, CONFIG_AMD_MEM_ENCRYPT support was
initially #undef'd to support SME with minimal effort.  When support for
SEV was added, the #undef remained and some minimal support for setting the
encryption bit was added for building identity mapped pagetable entries.

Commit b83ce5ee9147 ("x86/mm/64: Make __PHYSICAL_MASK_SHIFT always 52")
changed __PHYSICAL_MASK_SHIFT from 46 to 52 in support of 5-level paging.
This change resulted in SEV guests failing to boot because the encryption
bit was no longer being automatically masked out.  The compressed boot
path now requires sme_me_mask to be defined in order for the pagetable
functions, such as pud_present(), to properly mask out the encryption bit
(currently bit 47) when evaluating pagetable entries.

Add an sme_me_mask variable in arch/x86/boot/compressed/mem_encrypt.S,
which is set when SEV is active, delete the #undef CONFIG_AMD_MEM_ENCRYPT
from arch/x86/boot/compressed/kaslr_64.c and use sme_me_mask when building
the identify mapped pagetable entries.

Fixes: b83ce5ee9147 ("x86/mm/64: Make __PHYSICAL_MASK_SHIFT always 52")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lkml.kernel.org/r/20180327220711.8702.55842.stgit@tlendack-t1.amdoffice.net

---
 arch/x86/boot/compressed/kaslr_64.c    | 14 ++++----------
 arch/x86/boot/compressed/mem_encrypt.S | 17 ++++++++++-------
 arch/x86/boot/compressed/misc.h        |  2 +-
 3 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr_64.c b/arch/x86/boot/compressed/kaslr_64.c
index b5e5e02f8cde..522d11431433 100644
--- a/arch/x86/boot/compressed/kaslr_64.c
+++ b/arch/x86/boot/compressed/kaslr_64.c
@@ -16,13 +16,6 @@
 #define __pa(x)  ((unsigned long)(x))
 #define __va(x)  ((void *)((unsigned long)(x)))
 
-/*
- * The pgtable.h and mm/ident_map.c includes make use of the SME related
- * information which is not used in the compressed image support. Un-define
- * the SME support to avoid any compile and link errors.
- */
-#undef CONFIG_AMD_MEM_ENCRYPT
-
 /* No PAGE_TABLE_ISOLATION support needed either: */
 #undef CONFIG_PAGE_TABLE_ISOLATION
 
@@ -85,13 +78,14 @@ static struct x86_mapping_info mapping_info;
 /* Locates and clears a region for a new top level page table. */
 void initialize_identity_maps(void)
 {
-	unsigned long sev_me_mask = get_sev_encryption_mask();
+	/* If running as an SEV guest, the encryption mask is required. */
+	set_sev_encryption_mask();
 
 	/* Init mapping_info with run-time function/buffer pointers. */
 	mapping_info.alloc_pgt_page = alloc_pgt_page;
 	mapping_info.context = &pgt_data;
-	mapping_info.page_flag = __PAGE_KERNEL_LARGE_EXEC | sev_me_mask;
-	mapping_info.kernpg_flag = _KERNPG_TABLE | sev_me_mask;
+	mapping_info.page_flag = __PAGE_KERNEL_LARGE_EXEC | sme_me_mask;
+	mapping_info.kernpg_flag = _KERNPG_TABLE;
 
 	/*
 	 * It should be impossible for this not to already be true,
diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
index 54f5f6625a73..eaa843a52907 100644
--- a/arch/x86/boot/compressed/mem_encrypt.S
+++ b/arch/x86/boot/compressed/mem_encrypt.S
@@ -88,9 +88,7 @@ ENTRY(get_sev_encryption_bit)
 ENDPROC(get_sev_encryption_bit)
 
 	.code64
-ENTRY(get_sev_encryption_mask)
-	xor	%rax, %rax
-
+ENTRY(set_sev_encryption_mask)
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	push	%rbp
 	push	%rdx
@@ -101,9 +99,7 @@ ENTRY(get_sev_encryption_mask)
 	testl	%eax, %eax
 	jz	.Lno_sev_mask
 
-	xor	%rdx, %rdx
-	bts	%rax, %rdx		/* Create the encryption mask */
-	mov	%rdx, %rax		/* ... and return it */
+	bts	%rax, sme_me_mask(%rip)	/* Create the encryption mask */
 
 .Lno_sev_mask:
 	movq	%rbp, %rsp		/* Restore original stack pointer */
@@ -112,9 +108,16 @@ ENTRY(get_sev_encryption_mask)
 	pop	%rbp
 #endif
 
+	xor	%rax, %rax
 	ret
-ENDPROC(get_sev_encryption_mask)
+ENDPROC(set_sev_encryption_mask)
 
 	.data
 enc_bit:
 	.int	0xffffffff
+
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	.balign	8
+GLOBAL(sme_me_mask)
+	.quad	0
+#endif
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 4d369c308ed7..9e11be4cae19 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -114,6 +114,6 @@ static inline void console_init(void)
 { }
 #endif
 
-unsigned long get_sev_encryption_mask(void);
+void set_sev_encryption_mask(void);
 
 #endif

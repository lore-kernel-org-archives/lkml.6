Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B39ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D4B320671
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:12:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D4B320671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbeINT1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:27:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:44842 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727013AbeINT1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:27:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 84E21AE83;
        Fri, 14 Sep 2018 14:12:23 +0000 (UTC)
Date:   Fri, 14 Sep 2018 16:12:16 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v8 1/2] x86/mm: add .bss..decrypted section to hold
 shared variables
Message-ID: <20180914141216.GA29898@zn.tnic>
References: <1536875471-17391-1-git-send-email-brijesh.singh@amd.com>
 <1536875471-17391-2-git-send-email-brijesh.singh@amd.com>
 <20180914071056.GA4747@zn.tnic>
 <3517a0db-2f64-6d09-7100-dced40561d08@amd.com>
 <alpine.DEB.2.21.1809141414390.10480@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.1809141414390.10480@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 02:17:05PM +0200, Thomas Gleixner wrote:
> > The sme_encrypt_kernel() does not have access to pmd (after pointer
> > fixup is applied). You can extend the sme_encrypt_kernel() to pass an
> > additional arguments but then we start getting in include hell. The pmd
> > is defined as "pmdval_t". If we extend the sme_encrypt_kernel() then 
> > asm/mem_encrypt.h need to include the header file which defines
> > "pmdval_t". Adding the 'asm/pgtable_type.h' was causing all kind of
> > compilation errors. I didn't spend much time on it. IMO, we really don't
> > need to go in this path unless we see some value from doing this.
> 
> Keep it here then.

*For what is worth*, a simple forward declaration works. I've taken the
64-bit forward declaration of pmdval_t as SME is 64-bit only anyway.

The below diff ontop passes the mandatory all*config smoke builds:

---
 arch/x86/include/asm/mem_encrypt.h |  6 ++++--
 arch/x86/kernel/head64.c           | 18 +-----------------
 arch/x86/mm/mem_encrypt_identity.c | 18 +++++++++++++++++-
 3 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 616f8e637bc3..67c0e6cfdfb3 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -19,6 +19,8 @@
 
 #include <asm/bootparam.h>
 
+typedef unsigned long pmdval_t;
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 
 extern u64 sme_me_mask;
@@ -40,7 +42,7 @@ void __init sme_unmap_bootdata(char *real_mode_data);
 
 void __init sme_early_init(void);
 
-void __init sme_encrypt_kernel(struct boot_params *bp);
+void __init sme_encrypt_kernel(struct boot_params *bp, pmdval_t *pmd);
 void __init sme_enable(struct boot_params *bp);
 
 int __init early_set_memory_decrypted(unsigned long vaddr, unsigned long size);
@@ -69,7 +71,7 @@ static inline void __init sme_unmap_bootdata(char *real_mode_data) { }
 
 static inline void __init sme_early_init(void) { }
 
-static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
+static inline void __init sme_encrypt_kernel(struct boot_params *bp, pmdval_t *pmd) { }
 static inline void __init sme_enable(struct boot_params *bp) { }
 
 static inline bool sme_active(void) { return false; }
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index c16af27eb23f..6f8e9b534e80 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -112,7 +112,6 @@ static bool __head check_la57_support(unsigned long physaddr)
 unsigned long __head __startup_64(unsigned long physaddr,
 				  struct boot_params *bp)
 {
-	unsigned long vaddr, vaddr_end;
 	unsigned long load_delta, *p;
 	unsigned long pgtable_flags;
 	pgdval_t *pgd;
@@ -233,22 +232,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	*fixup_long(&phys_base, physaddr) += load_delta - sme_get_me_mask();
 
 	/* Encrypt the kernel and related (if SME is active) */
-	sme_encrypt_kernel(bp);
-
-	/*
-	 * Clear the memory encryption mask from the .bss..decrypted section.
-	 * The bss section will be memset to zero later in the initialization so
-	 * there is no need to zero it after changing the memory encryption
-	 * attribute.
-	 */
-	if (mem_encrypt_active()) {
-		vaddr = (unsigned long)__start_bss_decrypted;
-		vaddr_end = (unsigned long)__end_bss_decrypted;
-		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
-			i = pmd_index(vaddr);
-			pmd[i] -= sme_get_me_mask();
-		}
-	}
+	sme_encrypt_kernel(bp, pmd);
 
 	/*
 	 * Return the SME encryption mask (if SME is active) to be used as a
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index a19ef1a416ff..9dbc145d10f8 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -267,15 +267,17 @@ static unsigned long __init sme_pgtable_calc(unsigned long len)
 	return entries + tables;
 }
 
-void __init sme_encrypt_kernel(struct boot_params *bp)
+void __init sme_encrypt_kernel(struct boot_params *bp, pmdval_t *pmd)
 {
 	unsigned long workarea_start, workarea_end, workarea_len;
 	unsigned long execute_start, execute_end, execute_len;
 	unsigned long kernel_start, kernel_end, kernel_len;
 	unsigned long initrd_start, initrd_end, initrd_len;
 	struct sme_populate_pgd_data ppd;
+	unsigned long vaddr, vaddr_end;
 	unsigned long pgtable_area_len;
 	unsigned long decrypted_base;
+	int i;
 
 	if (!sme_active())
 		return;
@@ -467,6 +469,20 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 
 	/* Flush the TLB - no globals so cr3 is enough */
 	native_write_cr3(__native_read_cr3());
+
+	/*
+	 * Clear the memory encryption mask from the .bss..decrypted section.
+	 * The bss section will be memset to zero later in the initialization so
+	 * there is no need to zero it after changing the memory encryption
+	 * attribute.
+	 */
+	vaddr = (unsigned long)__start_bss_decrypted;
+	vaddr_end = (unsigned long)__end_bss_decrypted;
+
+	for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
+		i = pmd_index(vaddr);
+		pmd[i] -= sme_get_me_mask();
+	}
 }
 
 void __init sme_enable(struct boot_params *bp)
-- 
2.17.0.582.gccdcbd54c

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 

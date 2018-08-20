Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8160FC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316012173A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 316012173A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbeHTVUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 17:20:45 -0400
Received: from mga17.intel.com ([192.55.52.151]:35155 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbeHTVUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 17:20:44 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2018 11:04:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,266,1531810800"; 
   d="scan'208";a="63841458"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by fmsmga007.fm.intel.com with ESMTP; 20 Aug 2018 11:03:54 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 0AA99300DDE; Mon, 20 Aug 2018 11:03:54 -0700 (PDT)
Date:   Mon, 20 Aug 2018 11:03:53 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>, x86@kernel.org,
        dvyukov@google.com, hughd@google.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: Crash in MM code in v4.4.y, v4.9.y with TRANSPARENT_HUGEPAGE
 enabled
Message-ID: <20180820180353.GO12066@tassilo.jf.intel.com>
References: <20180817222733.GA18575@roeck-us.net>
 <20180820162938.GR29735@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180820162938.GR29735@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 06:29:38PM +0200, Michal Hocko wrote:
> On Fri 17-08-18 15:27:33, Guenter Roeck wrote:
> > Hi,
> > 
> > the following crash is seen in v4.4.148, v4.4.149, v4.9.120, and v4.9.121
> > with CONFIG_TRANSPARENT_HUGEPAGE=y, CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y.
> 
> Could you try to apply fd7e315988b7 ("x86/mm: Simplify p[g4um]d_page()
> macros"). I do not see it in stable 4.4 tree and it has been introduced
> much later in 4.14. This one gave us quite some headache because it is
> soooo easy to overlook.

Good catch!

I tested that with 4.9 and backporting the patch indeed fixes the
syzcaller test case running in a KVM VM. Backported patch appended.

Should probably go into 4.4 and 4.9.

Cannot explain the 4.17 report unfortunately.

I'll resend it as an email too

---

x86/mm: Simplify p[g4um]d_page() macros

Create a pgd_pfn() macro similar to the p[4um]d_pfn() macros and then
use the p[g4um]d_pfn() macros in the p[g4um]d_page() macros instead of
duplicating the code.

[Needed to fix crashes caused by earlier backports in 4.9 stable, likely 4.4 too]

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Larry Woodman <lwoodman@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Toshimitsu Kani <toshi.kani@hpe.com>
Cc: kasan-dev@googlegroups.com
Cc: kvm@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-efi@vger.kernel.org
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/e61eb533a6d0aac941db2723d8aa63ef6b882dee.1500319216.git.thomas.lendacky@amd.com
[Backported to 4.9 stable by AK, suggested by Michael Hocko]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Andi Kleen <ak@linux.intel.com>

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 4de6c282c02a..68a55273ce0f 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -173,6 +173,11 @@ static inline unsigned long pud_pfn(pud_t pud)
 	return (pfn & pud_pfn_mask(pud)) >> PAGE_SHIFT;
 }
 
+static inline unsigned long pgd_pfn(pgd_t pgd)
+{
+	return (pgd_val(pgd) & PTE_PFN_MASK) >> PAGE_SHIFT;
+}
+
 #define pte_page(pte)	pfn_to_page(pte_pfn(pte))
 
 static inline int pmd_large(pmd_t pte)
@@ -578,8 +583,7 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
  * Currently stuck as a macro due to indirect forward reference to
  * linux/mmzone.h's __section_mem_map_addr() definition:
  */
-#define pmd_page(pmd)		\
-	pfn_to_page((pmd_val(pmd) & pmd_pfn_mask(pmd)) >> PAGE_SHIFT)
+#define pmd_page(pmd)	pfn_to_page(pmd_pfn(pmd))
 
 /*
  * the pmd page can be thought of an array like this: pmd_t[PTRS_PER_PMD]
@@ -647,8 +651,7 @@ static inline unsigned long pud_page_vaddr(pud_t pud)
  * Currently stuck as a macro due to indirect forward reference to
  * linux/mmzone.h's __section_mem_map_addr() definition:
  */
-#define pud_page(pud)		\
-	pfn_to_page((pud_val(pud) & pud_pfn_mask(pud)) >> PAGE_SHIFT)
+#define pud_page(pud)	pfn_to_page(pud_pfn(pud))
 
 /* Find an entry in the second-level page table.. */
 static inline pmd_t *pmd_offset(pud_t *pud, unsigned long address)
@@ -688,7 +691,7 @@ static inline unsigned long pgd_page_vaddr(pgd_t pgd)
  * Currently stuck as a macro due to indirect forward reference to
  * linux/mmzone.h's __section_mem_map_addr() definition:
  */
-#define pgd_page(pgd)		pfn_to_page(pgd_val(pgd) >> PAGE_SHIFT)
+#define pgd_page(pgd)		pfn_to_page(pgd_pfn(pgd))
 
 /* to find an entry in a page-table-directory. */
 static inline unsigned long pud_index(unsigned long address)

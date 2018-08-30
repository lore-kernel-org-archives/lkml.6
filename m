Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC2FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 20:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E43120834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 20:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E43120834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbeHaAbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 20:31:52 -0400
Received: from mga09.intel.com ([134.134.136.24]:58621 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727207AbeHaAbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 20:31:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2018 13:27:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,308,1531810800"; 
   d="scan'208";a="259468619"
Received: from 2b52.sc.intel.com ([143.183.136.52])
  by fmsmga006.fm.intel.com with ESMTP; 30 Aug 2018 13:27:50 -0700
Message-ID: <1535660615.28258.37.camel@intel.com>
Subject: Re: [RFC PATCH v3 12/24] x86/mm: Modify ptep_set_wrprotect and
 pmdp_set_wrprotect for _PAGE_DIRTY_SW
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromiun.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Date:   Thu, 30 Aug 2018 13:23:35 -0700
In-Reply-To: <9879c17a-24da-d84a-5a7c-30bcbb473914@infradead.org>
References: <20180830143904.3168-1-yu-cheng.yu@intel.com>
         <20180830143904.3168-13-yu-cheng.yu@intel.com>
         <9879c17a-24da-d84a-5a7c-30bcbb473914@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-30 at 12:59 -0700, Randy Dunlap wrote:
> On 08/30/2018 07:38 AM, Yu-cheng Yu wrote:
> > 
> > When Shadow Stack is enabled, the read-only and PAGE_DIRTY_HW PTE
> > setting is reserved only for the Shadow Stack.  To track dirty of
> > non-Shadow Stack read-only PTEs, we use PAGE_DIRTY_SW.
> > 
> > Update ptep_set_wrprotect() and pmdp_set_wrprotect().
> > 
> > Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> > ---
> >  arch/x86/include/asm/pgtable.h | 42
> > ++++++++++++++++++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> > 
> > diff --git a/arch/x86/include/asm/pgtable.h
> > b/arch/x86/include/asm/pgtable.h
> > index 4d50de77ea96..556ef258eeff 100644
> > --- a/arch/x86/include/asm/pgtable.h
> > +++ b/arch/x86/include/asm/pgtable.h
> > @@ -1203,7 +1203,28 @@ static inline pte_t
> > ptep_get_and_clear_full(struct mm_struct *mm,
> >  static inline void ptep_set_wrprotect(struct mm_struct *mm,
> >  				      unsigned long addr, pte_t
> > *ptep)
> >  {
> > +	pte_t pte;
> > +
> >  	clear_bit(_PAGE_BIT_RW, (unsigned long *)&ptep->pte);
> > +	pte = *ptep;
> > +
> > +	/*
> > +	 * Some processors can start a write, but ending up
> > seeing
> 	                                      but end up seeing
> 
> > 
> > +	 * a read-only PTE by the time they get to the Dirty bit.
> > +	 * In this case, they will set the Dirty bit, leaving a
> > +	 * read-only, Dirty PTE which looks like a Shadow Stack
> > PTE.
> > +	 *
> > +	 * However, this behavior has been improved and will not
> > occur
> > +	 * on processors supporting Shadow Stacks.  Without this
> > +	 * guarantee, a transition to a non-present PTE and flush
> > the
> > +	 * TLB would be needed.
> > +	 *
> > +	 * When change a writable PTE to read-only and if the PTE
> > has
> 	        changing
> 
> > 
> > +	 * _PAGE_DIRTY_HW set, we move that bit to _PAGE_DIRTY_SW
> > so
> > +	 * that the PTE is not a valid Shadow Stack PTE.
> > +	 */
> > +	pte = pte_move_flags(pte, _PAGE_DIRTY_HW,
> > _PAGE_DIRTY_SW);
> > +	set_pte_at(mm, addr, ptep, pte);
> >  }
> >  
> >  #define flush_tlb_fix_spurious_fault(vma, address) do { } while
> > (0)
> > @@ -1266,7 +1287,28 @@ static inline pud_t
> > pudp_huge_get_and_clear(struct mm_struct *mm,
> >  static inline void pmdp_set_wrprotect(struct mm_struct *mm,
> >  				      unsigned long addr, pmd_t
> > *pmdp)
> >  {
> > +	pmd_t pmd;
> > +
> >  	clear_bit(_PAGE_BIT_RW, (unsigned long *)pmdp);
> > +	pmd = *pmdp;
> > +
> > +	/*
> > +	 * Some processors can start a write, but ending up
> > seeing
> 	                                      but end up seeing
> 
> > 
> > +	 * a read-only PTE by the time they get to the Dirty bit.
> > +	 * In this case, they will set the Dirty bit, leaving a
> > +	 * read-only, Dirty PTE which looks like a Shadow Stack
> > PTE.
> > +	 *
> > +	 * However, this behavior has been improved and will not
> > occur
> > +	 * on processors supporting Shadow Stacks.  Without this
> > +	 * guarantee, a transition to a non-present PTE and flush
> > the
> > +	 * TLB would be needed.
> > +	 *
> > +	 * When change a writable PTE to read-only and if the PTE
> > has
> 	        changing
> 
> > 
> > +	 * _PAGE_DIRTY_HW set, we move that bit to _PAGE_DIRTY_SW
> > so
> > +	 * that the PTE is not a valid Shadow Stack PTE.
> > +	 */
> > +	pmd = pmd_move_flags(pmd, _PAGE_DIRTY_HW,
> > _PAGE_DIRTY_SW);
> > +	set_pmd_at(mm, addr, pmdp, pmd);
> >  }
> >  
> >  #define pud_write pud_write
> > 
> 

Thanks, I will fix it!


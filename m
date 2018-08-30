Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DA3C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8767B20658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8767B20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbeH3UJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 16:09:10 -0400
Received: from mga05.intel.com ([192.55.52.43]:51126 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726592AbeH3UJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 16:09:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2018 09:06:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,307,1531810800"; 
   d="scan'208";a="84719735"
Received: from 2b52.sc.intel.com ([143.183.136.52])
  by fmsmga004.fm.intel.com with ESMTP; 30 Aug 2018 09:06:18 -0700
Message-ID: <1535644924.26689.7.camel@intel.com>
Subject: Re: [RFC PATCH v3 12/24] x86/mm: Modify ptep_set_wrprotect and
 pmdp_set_wrprotect for _PAGE_DIRTY_SW
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Jann Horn <jannh@google.com>
Cc:     the arch/x86 maintainers <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>, hjl.tools@gmail.com,
        Jonathan Corbet <corbet@lwn.net>, keescook@chromiun.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        ravi.v.shankar@intel.com, vedvyas.shanbhogue@intel.com
Date:   Thu, 30 Aug 2018 09:02:04 -0700
In-Reply-To: <CAG48ez0Rca0XsdXJZ07c+iGPyep0Gpxw+sxQuACP5gyPaBgDKA@mail.gmail.com>
References: <20180830143904.3168-1-yu-cheng.yu@intel.com>
         <20180830143904.3168-13-yu-cheng.yu@intel.com>
         <CAG48ez0Rca0XsdXJZ07c+iGPyep0Gpxw+sxQuACP5gyPaBgDKA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-30 at 17:49 +0200, Jann Horn wrote:
> On Thu, Aug 30, 2018 at 4:43 PM Yu-cheng Yu <yu-cheng.yu@intel.com>
> wrote:
> > 
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
> >                                       unsigned long addr, pte_t
> > *ptep)
> >  {
> > +       pte_t pte;
> > +
> >         clear_bit(_PAGE_BIT_RW, (unsigned long *)&ptep->pte);
> > +       pte = *ptep;
> > +
> > +       /*
> > +        * Some processors can start a write, but ending up seeing
> > +        * a read-only PTE by the time they get to the Dirty bit.
> > +        * In this case, they will set the Dirty bit, leaving a
> > +        * read-only, Dirty PTE which looks like a Shadow Stack
> > PTE.
> > +        *
> > +        * However, this behavior has been improved and will not
> > occur
> > +        * on processors supporting Shadow Stacks.  Without this
> > +        * guarantee, a transition to a non-present PTE and flush
> > the
> > +        * TLB would be needed.
> > +        *
> > +        * When change a writable PTE to read-only and if the PTE
> > has
> > +        * _PAGE_DIRTY_HW set, we move that bit to _PAGE_DIRTY_SW
> > so
> > +        * that the PTE is not a valid Shadow Stack PTE.
> > +        */
> > +       pte = pte_move_flags(pte, _PAGE_DIRTY_HW, _PAGE_DIRTY_SW);
> > +       set_pte_at(mm, addr, ptep, pte);
> >  }
> I don't understand why it's okay that you first atomically clear the
> RW bit, then atomically switch from DIRTY_HW to DIRTY_SW. Doesn't
> that
> mean that between the two atomic writes, another core can
> incorrectly
> see a shadow stack?

Yes, we had that concern earlier and checked.
On processors supporting Shadow Stacks, that will not happen.

Yu-cheng

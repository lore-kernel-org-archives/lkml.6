Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CF6C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84ACD208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84ACD208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbeHQUF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 16:05:56 -0400
Received: from mga03.intel.com ([134.134.136.65]:26230 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728027AbeHQUF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 16:05:56 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Aug 2018 10:01:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,251,1531810800"; 
   d="scan'208";a="73619333"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.132])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Aug 2018 10:01:48 -0700
Date:   Fri, 17 Aug 2018 10:01:48 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Peter Anvin <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] x86/speculation/l1tf: Exempt zeroed PTEs from XOR
 conversion
Message-ID: <20180817170148.GA29466@linux.intel.com>
References: <20180816204638.4046-1-sean.j.christopherson@intel.com>
 <CA+55aFweC_ja8pLOHv2dbokChaJej2bhhDyeO5ZxiQ+64C-Xog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFweC_ja8pLOHv2dbokChaJej2bhhDyeO5ZxiQ+64C-Xog@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 09:13:51AM -0700, Linus Torvalds wrote:
> On Thu, Aug 16, 2018 at 1:47 PM Sean Christopherson
> <sean.j.christopherson@intel.com> wrote:
> >
> > Fixes: 6b28baca9b1f ("x86/speculation/l1tf: Protect PROT_NONE PTEs against speculation")
> 
> This seems wrong.
> 
> That commit doesn't invert a cleared page table entry, because that
> commit still required _PAGE_PROTNONE being set for a pte to be
> inverted.
> 
> I'm assuming the real culprit is commit f22cc87f6c1f
> ("x86/speculation/l1tf: Invert all not present mappings") which made
> it look at _just_ the present bit.
> 
> And yeah, that was wrong.
> 
> So I really think a much better patch would be the appended one-liner.
> 
> Note - it's whitespace-damaged by cut-and-paste, but it should be
> obvious enough to apply by hand.
> 
> Can you test this one instead?

Checking for a non-zero val in __pte_needs_invert() also resolves the
issue.  I shied away from that change because prot_none_walk() doesn't
pass the full PTE to __pte_needs_invert(), it only passes the pgprot_t
bits.  This works because PAGE_NONE sets the global and accessed bits,
but it made me nervous nonetheless.

>              Linus
> ---
> 
>  arch/x86/include/asm/pgtable-invert.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/pgtable-invert.h
> b/arch/x86/include/asm/pgtable-invert.h
> index 44b1203ece12..821438e91b77 100644
> --- a/arch/x86/include/asm/pgtable-invert.h
> +++ b/arch/x86/include/asm/pgtable-invert.h
> @@ -6,7 +6,7 @@
> 
>  static inline bool __pte_needs_invert(u64 val)
>  {
> -       return !(val & _PAGE_PRESENT);
> +       return val && !(val & _PAGE_PRESENT);
>  }
> 
>  /* Get a mask to xor with the page table entry to get the correct pfn. */

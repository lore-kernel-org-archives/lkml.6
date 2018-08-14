Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723CFC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 21:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EEB2208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 21:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EEB2208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732526AbeHOASU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 20:18:20 -0400
Received: from mga05.intel.com ([192.55.52.43]:10599 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbeHOAST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 20:18:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2018 14:29:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,240,1531810800"; 
   d="scan'208";a="80299382"
Received: from 2b52.sc.intel.com ([143.183.136.51])
  by fmsmga004.fm.intel.com with ESMTP; 14 Aug 2018 14:29:15 -0700
Message-ID: <1534282125.24160.9.camel@intel.com>
Subject: Re: [RFC PATCH v2 13/27] mm: Handle shadow stack page fault
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromiun.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Date:   Tue, 14 Aug 2018 14:28:45 -0700
In-Reply-To: <20180711090656.GS2476@hirez.programming.kicks-ass.net>
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>
         <20180710222639.8241-14-yu-cheng.yu@intel.com>
         <2f3ff321-c629-3e00-59f6-8bca510650d4@linux.intel.com>
         <20180711090656.GS2476@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-11 at 11:06 +0200, Peter Zijlstra wrote:
> On Tue, Jul 10, 2018 at 04:06:25PM -0700, Dave Hansen wrote:
> > 
> > On 07/10/2018 03:26 PM, Yu-cheng Yu wrote:
> > > 
> > > +	if (is_shstk_mapping(vma->vm_flags))
> > > +		entry = pte_mkdirty_shstk(entry);
> > > +	else
> > > +		entry = pte_mkdirty(entry);
> > > +
> > > +	entry = maybe_mkwrite(entry, vma);
> > >  	if (ptep_set_access_flags(vma, vmf->address, vmf->pte,
> > > entry, 1))
> > >  		update_mmu_cache(vma, vmf->address, vmf->pte);
> > >  	pte_unmap_unlock(vmf->pte, vmf->ptl);
> > > @@ -2526,7 +2532,11 @@ static int wp_page_copy(struct vm_fault
> > > *vmf)
> > >  		}
> > >  		flush_cache_page(vma, vmf->address,
> > > pte_pfn(vmf->orig_pte));
> > >  		entry = mk_pte(new_page, vma->vm_page_prot);
> > > -		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
> > > +		if (is_shstk_mapping(vma->vm_flags))
> > > +			entry = pte_mkdirty_shstk(entry);
> > > +		else
> > > +			entry = pte_mkdirty(entry);
> > > +		entry = maybe_mkwrite(entry, vma);
> > Do we want to lift this hunk of code and put it elsewhere?  Maybe:
> > 
> > 	entry = pte_set_vma_features(entry, vma);
> > 
> > and then:
> > 
> > pte_t pte_set_vma_features(pte_t entry, struct vm_area_struct)
> > {
> > 		/*
> > 		 * Shadow stack PTEs are always dirty and always
> > 		 * writable.  They have a different encoding for
> > 		 * this than normal PTEs, though.
> > 		 */
> > 		if (is_shstk_mapping(vma->vm_flags))
> > 			entry = pte_mkdirty_shstk(entry);
> > 		else
> > 			entry = pte_mkdirty(entry);
> > 
> > 		entry = maybe_mkwrite(entry, vma);
> > 
> > 	return entry;
> > }
> Yes, that wants a helper like that. Not sold on the name, but
> whatever.
> 
> Is there any way we can hide all the shadow stack magic in arch
> code?

We use is_shstk_mapping() only to determine PAGE_DIRTY_SW or
PAGE_DIRTY_HW should be set in a PTE.  One way to remove this shadow
stack code from generic code is changing pte_mkdirty(pte) to
pte_mkdirty(pte, vma), and in the arch code we handle shadow stack.
Is this acceptable?

Thanks,
Yu-cheng


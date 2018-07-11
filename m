Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E3BC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 255A020846
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CJHCd0Hy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 255A020846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732442AbeGKJKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:10:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58432 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbeGKJKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:10:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=InLvEauMwcKvCxwW7K7Ux/s6fcMp9nd2FM12RUuHvGA=; b=CJHCd0HyEzyV40AQcyX7Uazq+
        ELRox0LV1q9cona1HliZfS6vQxIeadKugqvOwDqbSVCL71ld31RMKEHsQMQslDRM0DbNnm2/mndOf
        4mlSN2PXd4MPRWWTok5UjPWfRfCOl4IuSyALUn850hWwLrGPxklddwPezUT1b08r2GU5n2bwTTPds
        DX8sw9e8p26no3K9YqpcWWzIts41zwq/y+2t9U9eOU4C+zLeyO7fck0bKfnYfI5EBT0Z/AHAGXsA5
        jhtE4OLU2Z3KgC+OAX5DuzdSrQk+Bgu7/CzxwB58zaVXeLYzoBn7iLFfo4UVmE+tFbY8P4jzRveIz
        SsK0hiDXw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdB5N-0002lX-VE; Wed, 11 Jul 2018 09:06:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 72D7820291063; Wed, 11 Jul 2018 11:06:56 +0200 (CEST)
Date:   Wed, 11 Jul 2018 11:06:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
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
Subject: Re: [RFC PATCH v2 13/27] mm: Handle shadow stack page fault
Message-ID: <20180711090656.GS2476@hirez.programming.kicks-ass.net>
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>
 <20180710222639.8241-14-yu-cheng.yu@intel.com>
 <2f3ff321-c629-3e00-59f6-8bca510650d4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f3ff321-c629-3e00-59f6-8bca510650d4@linux.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 04:06:25PM -0700, Dave Hansen wrote:
> On 07/10/2018 03:26 PM, Yu-cheng Yu wrote:
> > +	if (is_shstk_mapping(vma->vm_flags))
> > +		entry = pte_mkdirty_shstk(entry);
> > +	else
> > +		entry = pte_mkdirty(entry);
> > +
> > +	entry = maybe_mkwrite(entry, vma);
> >  	if (ptep_set_access_flags(vma, vmf->address, vmf->pte, entry, 1))
> >  		update_mmu_cache(vma, vmf->address, vmf->pte);
> >  	pte_unmap_unlock(vmf->pte, vmf->ptl);
> > @@ -2526,7 +2532,11 @@ static int wp_page_copy(struct vm_fault *vmf)
> >  		}
> >  		flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
> >  		entry = mk_pte(new_page, vma->vm_page_prot);
> > -		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
> > +		if (is_shstk_mapping(vma->vm_flags))
> > +			entry = pte_mkdirty_shstk(entry);
> > +		else
> > +			entry = pte_mkdirty(entry);
> > +		entry = maybe_mkwrite(entry, vma);
> 
> Do we want to lift this hunk of code and put it elsewhere?  Maybe:
> 
> 	entry = pte_set_vma_features(entry, vma);
> 
> and then:
> 
> pte_t pte_set_vma_features(pte_t entry, struct vm_area_struct)
> {
> 		/*
> 		 * Shadow stack PTEs are always dirty and always
> 		 * writable.  They have a different encoding for
> 		 * this than normal PTEs, though.
> 		 */
> 		if (is_shstk_mapping(vma->vm_flags))
> 			entry = pte_mkdirty_shstk(entry);
> 		else
> 			entry = pte_mkdirty(entry);
> 
> 		entry = maybe_mkwrite(entry, vma);
> 
> 	return entry;
> }

Yes, that wants a helper like that. Not sold on the name, but whatever.

Is there any way we can hide all the shadow stack magic in arch code?

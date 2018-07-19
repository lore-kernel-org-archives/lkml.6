Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EECC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB02E2084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB02E2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732098AbeGSRyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 13:54:00 -0400
Received: from mga04.intel.com ([192.55.52.120]:31604 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732050AbeGSRyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 13:54:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jul 2018 10:09:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,375,1526367600"; 
   d="scan'208";a="74165176"
Received: from 2b52.sc.intel.com ([143.183.136.146])
  by orsmga001.jf.intel.com with ESMTP; 19 Jul 2018 10:09:53 -0700
Message-ID: <1532019963.16711.61.camel@intel.com>
Subject: Re: [RFC PATCH v2 16/27] mm: Modify can_follow_write_pte/pmd for
 shadow stack
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
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
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Date:   Thu, 19 Jul 2018 10:06:03 -0700
In-Reply-To: <f4c90626-51d8-5551-5b77-baaff81f16bb@linux.intel.com>
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>
         <20180710222639.8241-17-yu-cheng.yu@intel.com>
         <de510df6-7ea9-edc6-9c49-2f80f16472b4@linux.intel.com>
         <1531328731.15351.3.camel@intel.com>
         <45a85b01-e005-8cb6-af96-b23ce9b5fca7@linux.intel.com>
         <1531868610.3541.21.camel@intel.com>
         <fa9db8c5-41c8-05e9-ad8d-dc6aaf11cb04@linux.intel.com>
         <1531944882.10738.1.camel@intel.com>
         <3f158401-f0b6-7bf7-48ab-2958354b28ad@linux.intel.com>
         <1531955428.12385.30.camel@intel.com>
         <f4c90626-51d8-5551-5b77-baaff81f16bb@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-18 at 17:06 -0700, Dave Hansen wrote:
> > 
> > > 
> > > > 
> > > > -static inline bool can_follow_write_pte(pte_t pte, unsigned
> > > > int flags)
> > > > +static inline bool can_follow_write(pte_t pte, unsigned int
> > > > flags,
> > > > +				    struct vm_area_struct
> > > > *vma)
> > > >  {
> > > > -	return pte_write(pte) ||
> > > > -		((flags & FOLL_FORCE) && (flags & FOLL_COW)
> > > > && pte_dirty(pte));
> > > > +	if (!is_shstk_mapping(vma->vm_flags)) {
> > > > +		if (pte_write(pte))
> > > > +			return true;
> > > Let me see if I can say this another way.
> > > 
> > > The bigger issue is that these patches change the semantics of
> > > pte_write().  Before these patches, it meant that you *MUST*
> > > have this
> > > bit set to write to the page controlled by the PTE.  Now, it
> > > means: you
> > > can write if this bit is set *OR* the shadowstack bit
> > > combination is set.
> > Here, we only figure out (1) if the page is pointed by a writable
> > PTE; or
> > (2) if the page is pointed by a RO PTE (data or SHSTK) and it has
> > been
> > copied and it still exists.  We are not trying to
> > determine if the
> > SHSTK PTE is writable (we know it is not).
> Please think about the big picture.  I'm not just talking about this
> patch, but about every use of pte_write() in the kernel.
> 
> > 
> > > 
> > > That's the fundamental problem.  We need some code in the kernel
> > > that
> > > logically represents the concept of "is this PTE a shadowstack
> > > PTE or a
> > > PTE with the write bit set", and we will call that pte_write(),
> > > or maybe
> > > pte_writable().
> > > 
> > > You *have* to somehow rectify this situation.  We can absolutely
> > > no
> > > leave pte_write() in its current, ambiguous state where it has
> > > no real
> > > meaning or where it is used to mean _both_ things depending on
> > > context.
> > True, the processor can always write to a page through a shadow
> > stack
> > PTE, but it must do that with a CALL instruction.  Can we define
> > a 
> > write operation as: MOV r1, *(r2).  Then we don't have any doubt
> > on
> > pte_write() any more.
> No, we can't just move the target. :)
> 
> You can define it this way, but then you also need to go to every
> spot
> in the kernel that calls pte_write() (and _PAGE_RW in fact) and
> audit it
> to ensure it means "mov ..." and not push.

Which pte_write() do you think is right?

bool is_shstk_pte(pte) {
	return (_PAGE_RW not set) &&
(_PAGE_DIRTY_HW set);
}

int pte_write_1(pte) {
	return (_PAGE_RW set) && !is_shstk_pte(pte);
}

int pte_write_2(pte) {
	return (_PAGE_RW set) || is_shstk_pte(pte);
}

Yu-cheng


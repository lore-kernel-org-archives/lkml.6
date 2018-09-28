Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AA9C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 12:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80AAE216C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 12:23:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80AAE216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbeI1SrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 14:47:08 -0400
Received: from mga09.intel.com ([134.134.136.24]:63449 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726971AbeI1SrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 14:47:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Sep 2018 05:23:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,314,1534834800"; 
   d="scan'208";a="73820162"
Received: from ctosetti-mobl.ger.corp.intel.com ([10.249.38.196])
  by fmsmga007.fm.intel.com with ESMTP; 28 Sep 2018 05:17:51 -0700
Message-ID: <a70563ea8a4bfbf9d531d1bc0ca5f5577e6b83be.camel@linux.intel.com>
Subject: Re: [PATCH v14 09/19] x86/mm: x86/sgx: Signal SEGV_SGXERR for #PFs
 w/ PF_SGX
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com, serge.ayoun@intel.com,
        shay.katz-zamir@intel.com, linux-sgx@vger.kernel.org,
        andriy.shevchenko@linux.intel.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 MM" <linux-kernel@vger.kernel.org>
Date:   Fri, 28 Sep 2018 15:17:50 +0300
In-Reply-To: <87zhw2ohf0.fsf@xmission.com>
References: <20180925130845.9962-1-jarkko.sakkinen@linux.intel.com>
         <20180925130845.9962-10-jarkko.sakkinen@linux.intel.com>
         <87zhw2ohf0.fsf@xmission.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-09-27 at 21:43 +0200, Eric W. Biederman wrote:
> Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> writes:
> 
> > From: Sean Christopherson <sean.j.christopherson@intel.com>
> > 
> > Signal SIGSEGV(SEGV_SGXERR) for all faults with PF_SGX set in the
> > error code.  The PF_SGX bit is set if and only if the #PF is detected
> > by the Enclave Page Cache Map (EPCM), which is consulted only after
> > an access walks the kernel's page tables, i.e.:
> > 
> >   a. the access was allowed by the kernel
> >   b. the kernel's tables have become less restrictive than the EPCM
> >   c. the kernel cannot fixup the cause of the fault
> > 
> > Noteably, (b) implies that either the kernel has botched the EPC
> > mappings or the EPCM has been invalidated due to a power event.  In
> > either case, userspace needs to be alerted so that it can take
> > appropriate action, e.g. restart the enclave.  This is reinforced
> > by (c) as the kernel doesn't really have any other reasonable option,
> > e.g. we could kill the task or panic, but neither is warranted.
> > 
> > Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > ---
> >  arch/x86/mm/fault.c | 20 +++++++++++++++++---
> >  1 file changed, 17 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> > index 85d20516b2f3..3fb2b2838d6c 100644
> > --- a/arch/x86/mm/fault.c
> > +++ b/arch/x86/mm/fault.c
> > @@ -960,10 +960,13 @@ static noinline void
> >  bad_area_access_error(struct pt_regs *regs, unsigned long error_code,
> >  		      unsigned long address, struct vm_area_struct *vma)
> >  {
> > +	int si_code = SEGV_ACCERR;
> > +
> >  	if (bad_area_access_from_pkeys(error_code, vma))
> > -		__bad_area(regs, error_code, address, vma, SEGV_PKUERR);
> > -	else
> > -		__bad_area(regs, error_code, address, vma, SEGV_ACCERR);
> > +		si_code = SEGV_PKUERR;
> > +	else if (unlikely(error_code & X86_PF_SGX))
> > +		si_code = SEGV_SGXERR;
> > +	__bad_area(regs, error_code, address, vma, si_code);
> >  }
> 
> This conflicts with a cleanup in this area I have sitting in linux-next.
> It isn't in the x86 tree but you can find my siginfo tree at:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git
> siginfo-next
> 
> In my tree bad area no longer takes a vma parameter.
> 
> If you are going to make changes to the fault handling code this cycle
> please let's figure out how to build it on top of my clean ups.

We are now going with the proposed vdso solution for v15. Thank you for
your feedback. I'll sync with you if that route would show non-feasible
(still prototyping the vdso solution). 

> Thank you,
> Eric Biederman

/Jarkko

Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B633AC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82CF520878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82CF520878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbeLFNzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 08:55:48 -0500
Received: from mga02.intel.com ([134.134.136.20]:28946 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727685AbeLFNzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 08:55:47 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2018 05:55:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,322,1539673200"; 
   d="scan'208";a="98580096"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.154])
  by orsmga006.jf.intel.com with ESMTP; 06 Dec 2018 05:55:47 -0800
Date:   Thu, 6 Dec 2018 05:55:47 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [RFC PATCH 4/4] x86/vdso: Add __vdso_sgx_eenter() to wrap SGX
 enclave transitions
Message-ID: <20181206135546.GA31263@linux.intel.com>
References: <20181205232012.28920-1-sean.j.christopherson@intel.com>
 <20181205232012.28920-5-sean.j.christopherson@intel.com>
 <CALCETrXNvbhMnitCiydoSweEr92RaA2fKrFQjCdeg+--u-TeuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXNvbhMnitCiydoSweEr92RaA2fKrFQjCdeg+--u-TeuA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 03:40:48PM -0800, Andy Lutomirski wrote:
> On Wed, Dec 5, 2018 at 3:20 PM Sean Christopherson
> <sean.j.christopherson@intel.com> wrote:
> > +notrace long __vdso_sgx_eenter(void *tcs, void *priv,
> > +                              struct sgx_eenter_fault_info *fault_info)
> > +{
> > +       u32 trapnr, error_code;
> > +       long leaf;
> > +       u64 addr;
> > +
> > +       /*
> > +        *      %eax = EENTER
> > +        *      %rbx = tcs
> > +        *      %rcx = do_eresume
> > +        *      %rdi = priv
> > +        * do_eenter:
> > +        *      enclu
> > +        *      jmp     out
> > +        *
> > +        * do_eresume:
> > +        *      enclu
> > +        *      ud2
> 
> Is the only reason for do_eresume to be different from do_eenter so
> that you can do the ud2?

No, it was a holdover from doing fixup via a magic prefix in user code.
The fixup could only skip the ENCLU and so a second ENCLU was needed to
differentiate between EENTER and ERESUME.  The need for two ENCLUs got
ingrained in my head.  I can't think of anything that will break if we
use a single ENCLU.

> > +        *
> > +        * out:
> > +        *      <return to C code>
> > +        *
> > +        * fault_fixup:
> > +        *      <extable loads RDI, DSI and RDX with fault info>
> > +        *      jmp     out
> > +        */
> 
> This has the IMO excellent property that it's extremely awkward to use
> it for a model where the enclave is reentrant.  I think it's excellent
> because reentrancy on the same enclave thread is just asking for
> severe bugs.  Of course, I fully expect the SDK to emulate reentrancy,
> but then it's 100% their problem :)  On the fiip side, it means that
> you can't really recover from a reported fault, even if you want to,
> because there's no way to ask for ERESUME.  So maybe the API should
> allow that after all.

Doh.  The ability to do ERESUME is an explicit requirement from the SDK
folks.  More code that I pulled from my userspace implementation and
didn't revisit.

> I think it might be polite to at least give some out regs, maybe RSI and RDI?

For the outbound path?  I was thinking @priv would be used for passing
data out as well as in.

Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F71C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3499F208D9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3499F208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729587AbeJAVHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 17:07:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:24289 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729476AbeJAVHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 17:07:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2018 07:29:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,327,1534834800"; 
   d="scan'208";a="91120251"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.55])
  by fmsmga002.fm.intel.com with ESMTP; 01 Oct 2018 07:29:03 -0700
Message-ID: <1538404143.30715.27.camel@intel.com>
Subject: Re: [PATCH v14 09/19] x86/mm: x86/sgx: Signal SEGV_SGXERR for #PFs
 w/ PF_SGX
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Andy Lutomirski <luto@amacapital.net>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        X86 ML <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        nhorman@redhat.com, npmccallum@redhat.com,
        "Ayoun, Serge" <serge.ayoun@intel.com>, shay.katz-zamir@intel.com,
        linux-sgx@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 01 Oct 2018 07:29:03 -0700
In-Reply-To: <CALCETrXByb2UVuZ6AXUeOd8y90NAikbZuvdN3wf_TjHZ+CxNhA@mail.gmail.com>
References: <20180925130845.9962-1-jarkko.sakkinen@linux.intel.com>
         <20180925130845.9962-10-jarkko.sakkinen@linux.intel.com>
         <CALCETrVAhiwv+g5fzVO3ZSHZgcQKbeeG8r3HUcXO9k7Gi94NdQ@mail.gmail.com>
         <20180926173516.GA10920@linux.intel.com>
         <2D60780F-ADB4-48A4-AB74-15683493D369@amacapital.net>
         <9835e288-ba98-2f9e-ac73-504db9512bb9@intel.com>
         <20180926204400.GA11446@linux.intel.com>
         <b7e14c6e-fc05-93fa-eef9-5e3f06ab4729@intel.com>
         <CALCETrXByb2UVuZ6AXUeOd8y90NAikbZuvdN3wf_TjHZ+CxNhA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-09-26 at 14:15 -0700, Andy Lutomirski wrote:
> On Wed, Sep 26, 2018 at 1:55 PM Dave Hansen <dave.hansen@intel.com> wrote:
> > 
> > 
> > On 09/26/2018 01:44 PM, Sean Christopherson wrote:
> > > 
> > > On Wed, Sep 26, 2018 at 01:16:59PM -0700, Dave Hansen wrote:
> > > > 
> > > > We also need to clarify how this can happen.  Is it through something
> > > > than an app does, or is it solely when the hardware does something under
> > > > the covers, like suspend/resume.
> > > Are you looking for something in the changelog, the comment, or just
> > > a response?  If it's the latter...
> > Comments, please.
> > 
> > > 
> > > On bare metal with a bug-free kernel, the only scenario I'm aware of
> > > where we'll encounter these faults is when hardware pulls the rug out
> > > from under us.  In a virtualized environment all bets are off because
> > > the architecture allows VMMs to silently "destroy" the EPC at will,
> > > e.g. KVM, and I believe Hyper-V, will take advantage of this behavior
> > > to support live migration.  Post migration, the destination system
> > > will generate PF_SGX because the EPC{M} can't be migrated between
> > > system, i.e. the destination EPCM sees all EPC pages as invalid.
> > OK, cool.
> > 
> > That's good background fodder for the changelog.
> > 
> > But, for the comment, I'm happy with something like this:
> > 
> >         /*
> >          * The fault resulted from violation of SGX-specific access-
> >          * controls.  This is expected to be the result of some lower
> >          * layer action (CPU suspend/resume, VM migration) and is
> >          * not related to anything the OS did.  Treat it as an access
> >          * error to ensure it is passed up to the app via a signal where
> >          * it can be handled.
> >          */
> > 
> > I really don't think we need to delve too deeply into the relationship
> > between EPCM and PTEs or anything.  Let's just say, "it's not the
> > kernel's fault, it's not the app's fault, so throw up our hands".
> There is a non-nitpicky consideration here.  Logically, user code is
> going to do this (totally made-up pseudocode):
> 
> enclave_t enclave = load_and_init_enclave(...);
> int ret = sgx_run(enclave, some pointers to non-enclave-memory buffers, ...);
> 
> and, with the code in this patch, a correct implementation of
> sgx_run() requires installing a signal handler.  This is nasty, since
> signal handlers, expecially for something like SIGSEGV or SIGBUS, are
> not fantastic to say the least in libraries.
>
> Could we perhaps have a little vDSO entry (or syscall, I suppose) that
> runs an enclave an returns an error code, and rig up the #PF handler
> to check if the error happened in the vDSO entry and fix it up rather
> than sending a signal?


If we want to avoid having to install a signal handler then I'm pretty
sure we'd need to fixup all #GPs and "bad access" #PFs that occur on
EENTER or in the enclave, not just PF_SGX faults.  SGX1 hardware takes
a #GP instead of a #PF on EPCM faults, and SGX2 hardware allows enclaves
to allocate/free/adjust EPC pages at runtime, e.g. an enclave runtime
might want to intercept #PFs from within the enclave so that the enclave
can dynamically grow its stack.

> On Windows, this is much less of a concern, because Windows has real
> scoped fault handling. But Linux doesn't, at least not yet.
> 
> 
> --
> Andy Lutomirski
> AMA Capital Management, LLC

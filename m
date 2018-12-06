Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E5CC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1792E20868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:20:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1792E20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbeLFSUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:20:54 -0500
Received: from mga01.intel.com ([192.55.52.88]:46142 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbeLFSUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:20:54 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2018 10:20:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,323,1539673200"; 
   d="scan'208";a="96706897"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.154])
  by orsmga007.jf.intel.com with ESMTP; 06 Dec 2018 10:20:53 -0800
Date:   Thu, 6 Dec 2018 10:20:53 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [RFC PATCH 2/4] x86/fault: Attempt to fixup unhandled #PF in
 vDSO before signaling
Message-ID: <20181206182053.GG31263@linux.intel.com>
References: <20181205232012.28920-1-sean.j.christopherson@intel.com>
 <20181205232012.28920-3-sean.j.christopherson@intel.com>
 <7a2f8782-9599-1554-aaaf-b3bd12e00778@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a2f8782-9599-1554-aaaf-b3bd12e00778@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 10:17:34AM -0800, Dave Hansen wrote:
> >  #define CREATE_TRACE_POINTS
> >  #include <asm/trace/exceptions.h>
> > @@ -928,6 +929,9 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
> >  		if (address >= TASK_SIZE_MAX)
> >  			error_code |= X86_PF_PROT;
> >  
> > +		if (fixup_vdso_exception(regs, X86_TRAP_PF, error_code, address))
> > +			return;
> > +
> >  		if (likely(show_unhandled_signals))
> >  			show_signal_msg(regs, error_code, address, tsk);
> 
> I'd preferably like to get this plugged into the page fault code before
> we get to the "bad_area" handling.  This plugs it in near the erratum
> handling which seems really late to me.
> 
> > @@ -1045,6 +1049,9 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
> >  	if (is_prefetch(regs, error_code, address))
> >  		return;
> >  
> > +	if (fixup_vdso_exception(regs, X86_TRAP_PF, error_code, address))
> > +		return;
> > +
> >  	set_signal_archinfo(address, error_code);
> >  
> >  #ifdef CONFIG_MEMORY_FAILURE
> 
> This *seems* really late to me.  We've already called into the mm fault
> handling code to try and handle the fault and they told us it was
> VM_FAULT_SIGBUS.  Shouldn't we have just detected that it was in the
> vDSO first and not even called the handling code?

Not sure if Andy had other use cases in mind, but for SGX we only want
to invoke the fixup in lieu of a signal.  E.g. #PFs to fault in an EPC
page need to be handled in the kernel.

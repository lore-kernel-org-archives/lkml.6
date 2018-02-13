Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933636AbeBMHzq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 02:55:46 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55857 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933550AbeBMHzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 02:55:45 -0500
X-Google-Smtp-Source: AH8x227tqLfXa39pIDcQj5qYAe0mHSq4B+am0saxAsYqpSlncDgnCFb6wole1W6IxclL0FixRShyRQ==
Date: Tue, 13 Feb 2018 08:55:40 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dave Hansen <dave@sr71.net>, hpa@zytor.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        dwmw@amazon.co.uk, linux-tip-commits@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>, Arjan van de Ven <arjan@infradead.org>
Subject: Re: [tip:x86/pti] x86/speculation: Use IBRS if available before
 calling into firmware
Message-ID: <20180213075540.3lkikkpgjoe6ocjk@gmail.com>
References: <1518362359-1005-1-git-send-email-dwmw@amazon.co.uk>
 <tip-670c3e8da87fa4046a55077b1409cf250865a203@git.kernel.org>
 <20180212102211.cdrrqqd4hdw7xu5y@gmail.com>
 <a85c28b8-1255-3264-bb4a-89e85e3c6009@sr71.net>
 <20180212165835.GO25181@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212165835.GO25181@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Feb 12, 2018 at 08:13:31AM -0800, Dave Hansen wrote:
> > On 02/12/2018 02:22 AM, Ingo Molnar wrote:
> > >> +static inline void firmware_restrict_branch_speculation_end(void)
> > >> +{
> > >> +	alternative_msr_write(MSR_IA32_SPEC_CTRL, 0,
> > >> +			      X86_FEATURE_USE_IBRS_FW);
> > > BTW., there's a detail that only occurred to me today, this enabling/disabling 
> > > sequence is not NMI safe, and it might be called from NMI context:
> > 
> > FWIW, Tim Chen and I talked about this a bunch.  We ended up just
> > saving/restoring the MSR verbatim in the NMI handler the same way we do
> > CR3, stashing it in a high general-purpose-register (r%12?).  That costs
> > a RDMSR (at least) and an WRMSR (which you can optimize out).  We have a
> > patch for that somewhere if anybody wants it.
> 
> I would really rather not do that on the NMI path.. And if we _have_ to,
> please keep a software shadow of that MSR state, such that we can avoid
> touching that MSR 99% of the time.

Yeah, I'd rather avoid doing firmware calls from NMI context altogether.

Thanks,

	Ingo

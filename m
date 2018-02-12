Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753054AbeBLQ6z (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 11:58:55 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48552 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750912AbeBLQ6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 11:58:52 -0500
Date: Mon, 12 Feb 2018 17:58:35 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dave Hansen <dave@sr71.net>
Cc: Ingo Molnar <mingo@kernel.org>, hpa@zytor.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        dwmw@amazon.co.uk, linux-tip-commits@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>, Arjan van de Ven <arjan@infradead.org>
Subject: Re: [tip:x86/pti] x86/speculation: Use IBRS if available before
 calling into firmware
Message-ID: <20180212165835.GO25181@hirez.programming.kicks-ass.net>
References: <1518362359-1005-1-git-send-email-dwmw@amazon.co.uk>
 <tip-670c3e8da87fa4046a55077b1409cf250865a203@git.kernel.org>
 <20180212102211.cdrrqqd4hdw7xu5y@gmail.com>
 <a85c28b8-1255-3264-bb4a-89e85e3c6009@sr71.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a85c28b8-1255-3264-bb4a-89e85e3c6009@sr71.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 08:13:31AM -0800, Dave Hansen wrote:
> On 02/12/2018 02:22 AM, Ingo Molnar wrote:
> >> +static inline void firmware_restrict_branch_speculation_end(void)
> >> +{
> >> +	alternative_msr_write(MSR_IA32_SPEC_CTRL, 0,
> >> +			      X86_FEATURE_USE_IBRS_FW);
> > BTW., there's a detail that only occurred to me today, this enabling/disabling 
> > sequence is not NMI safe, and it might be called from NMI context:
> 
> FWIW, Tim Chen and I talked about this a bunch.  We ended up just
> saving/restoring the MSR verbatim in the NMI handler the same way we do
> CR3, stashing it in a high general-purpose-register (r%12?).  That costs
> a RDMSR (at least) and an WRMSR (which you can optimize out).  We have a
> patch for that somewhere if anybody wants it.

I would really rather not do that on the NMI path.. And if we _have_ to,
please keep a software shadow of that MSR state, such that we can avoid
touching that MSR 99% of the time.

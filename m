Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933693AbeBMH6a (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 02:58:30 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35023 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933656AbeBMH62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 02:58:28 -0500
X-Google-Smtp-Source: AH8x225FaDPQz79n9d7hkR8kYr7lUFBKX+I5NBS68oI26bqiSy7JUMJU1fQM8n39AyuCr02zAQ3G+w==
Date: Tue, 13 Feb 2018 08:58:24 +0100
From: Ingo Molnar <mingo@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Thomas Mingarelli <thomas.mingarelli@hpe.com>, hpa@zytor.com,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Dave Hansen <dave@sr71.net>, Borislav Petkov <bp@alien8.de>,
        Arjan van de Ven <arjan@infradead.org>
Subject: Re: [tip:x86/pti] x86/speculation: Use IBRS if available before
 calling into firmware
Message-ID: <20180213075824.ucnn3aef76jbfu4m@gmail.com>
References: <1518362359-1005-1-git-send-email-dwmw@amazon.co.uk>
 <tip-670c3e8da87fa4046a55077b1409cf250865a203@git.kernel.org>
 <20180212102211.cdrrqqd4hdw7xu5y@gmail.com>
 <20180212115002.GI25181@hirez.programming.kicks-ass.net>
 <1518438439.6606.36.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1518438439.6606.36.camel@infradead.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* David Woodhouse <dwmw2@infradead.org> wrote:

> On Mon, 2018-02-12 at 12:50 +0100, Peter Zijlstra wrote:
> > On Mon, Feb 12, 2018 at 11:22:11AM +0100, Ingo Molnar wrote:
> > > > +static inline void firmware_restrict_branch_speculation_start(void)
> > > > +{
> > > > +   alternative_msr_write(MSR_IA32_SPEC_CTRL, SPEC_CTRL_IBRS,
> > > > +                         X86_FEATURE_USE_IBRS_FW);
> > > > +}
> > > > +
> > > > +static inline void firmware_restrict_branch_speculation_end(void)
> > > > +{
> > > > +   alternative_msr_write(MSR_IA32_SPEC_CTRL, 0,
> > > > +                         X86_FEATURE_USE_IBRS_FW);
> > > 
> > > BTW., there's a detail that only occurred to me today, this enabling/disabling 
> > > sequence is not NMI safe, and it might be called from NMI context:
> > 
> > Wait, we're doing firmware from NMI? That sounds like a _REALLY_ bad
> > idea.
> 
> And spin_lock_irqsave() too. Which is probably why I missed the fact
> that this was being called in NMI context.
> 
> Yay for HP and their persistent attempts to "value subtract" in their
> firmware offerings.
> 
> I'm tempted to drop that part of the patch and declare that if you're
> using this driver, the potential for stray branch prediction when you
> call into the firmware from the NMI handler is the *least* of your
> problems.
> 
> I *will* go back over the other parts of the patch and audit them for
> preempt safety though; there could potentially be a similar issue
> there. I think I put them close enough to the actual firmware calls
> that if we aren't already preempt-safe then we were screwed anyway, but
> *maybe* there's merit in making the macros explicitly bump the preempt
> count anyway.

Ok, meanwhile I'm removing this patch from the x86/pti branch, and since the 
branch has to be rebased anyway, I'll merge these into a single patch:

85d8426e0720: x86/speculation: Correct Speculation Control microcode blacklist again
1751342095f0: x86/speculation: Update Speculation Control microcode blacklist

Thanks,

	Ingo

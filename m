Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4A7ECDE43
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE04214EE
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xNeukaRD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFE04214EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbeJTJav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 05:30:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:57304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbeJTJau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 05:30:50 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4050214C3;
        Sat, 20 Oct 2018 01:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539998534;
        bh=nnr++cakNdwQeHBF8Mo+BD2E9jerMxPx+h/1Su7CP+I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xNeukaRDs8QxY+WsTsHV/utHZdWp6oZCfYF4TepwDRTNcec0SEFrcO58xGDCcjcxX
         XSLJgohxIPVMC0dw3wByAdXfsa6VQPSUP4W8g+gWtB/ZA2F5uiNjjEEE735r2Cu2q2
         FHGSxaV1XFEFdnoY96AjsUPGURseCl/khT9S/pkg=
Date:   Sat, 20 Oct 2018 10:22:10 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "Woodhouse, David" <dwmw@amazon.co.uk>
Subject: Re: [RFC PATCH 1/5] x86: introduce preemption disable prefix
Message-Id: <20181020102210.e7c1bd30eb0270b0176999de@kernel.org>
In-Reply-To: <37CB98C2-AF9B-475B-8B2D-7B414DC491F3@vmware.com>
References: <20181018005420.82993-1-namit@vmware.com>
        <20181018005420.82993-2-namit@vmware.com>
        <D247AB7C-2890-49CE-B102-163E5B368FC2@amacapital.net>
        <07255D2B-0243-4254-B62A-37050C44207E@vmware.com>
        <CALCETrXEG8OrMpB3VBS9RF41O_MwtPmXBazkdSGE0ohZmXDcBw@mail.gmail.com>
        <925F22EA-F8CB-4194-B96B-378409ED7918@vmware.com>
        <2626124E-7344-42F3-AD07-0BB34D62A9EE@amacapital.net>
        <6F1FD9DA-5E86-42A2-8EAF-05F5D70FE2EF@vmware.com>
        <CALCETrWjeqMs7Z6auStk9VGT9vAn+U5REGE+=TBv1Yh4kmOF3w@mail.gmail.com>
        <37CB98C2-AF9B-475B-8B2D-7B414DC491F3@vmware.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Oct 2018 04:44:33 +0000
Nadav Amit <namit@vmware.com> wrote:

> at 9:29 PM, Andy Lutomirski <luto@kernel.org> wrote:
> 
> >> On Oct 18, 2018, at 6:08 PM, Nadav Amit <namit@vmware.com> wrote:
> >> 
> >> at 10:00 AM, Andy Lutomirski <luto@amacapital.net> wrote:
> >> 
> >>>> On Oct 18, 2018, at 9:47 AM, Nadav Amit <namit@vmware.com> wrote:
> >>>> 
> >>>> at 8:51 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> >>>> 
> >>>>>> On Wed, Oct 17, 2018 at 8:12 PM Nadav Amit <namit@vmware.com> wrote:
> >>>>>> at 6:22 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> >>>>>> 
> >>>>>>>> On Oct 17, 2018, at 5:54 PM, Nadav Amit <namit@vmware.com> wrote:
> >>>>>>>> 
> >>>>>>>> It is sometimes beneficial to prevent preemption for very few
> >>>>>>>> instructions, or prevent preemption for some instructions that precede
> >>>>>>>> a branch (this latter case will be introduced in the next patches).
> >>>>>>>> 
> >>>>>>>> To provide such functionality on x86-64, we use an empty REX-prefix
> >>>>>>>> (opcode 0x40) as an indication that preemption is disabled for the
> >>>>>>>> following instruction.
> >>>>>>> 
> >>>>>>> Nifty!
> >>>>>>> 
> >>>>>>> That being said, I think you have a few bugs. First, you can’t just ignore
> >>>>>>> a rescheduling interrupt, as you introduce unbounded latency when this
> >>>>>>> happens ― you’re effectively emulating preempt_enable_no_resched(), which
> >>>>>>> is not a drop-in replacement for preempt_enable(). To fix this, you may
> >>>>>>> need to jump to a slow-path trampoline that calls schedule() at the end or
> >>>>>>> consider rewinding one instruction instead. Or use TF, which is only a
> >>>>>>> little bit terrifying…
> >>>>>> 
> >>>>>> Yes, I didn’t pay enough attention here. For my use-case, I think that the
> >>>>>> easiest solution would be to make synchronize_sched() ignore preemptions
> >>>>>> that happen while the prefix is detected. It would slightly change the
> >>>>>> meaning of the prefix.
> >>>> 
> >>>> So thinking about it further, rewinding the instruction seems the easiest
> >>>> and most robust solution. I’ll do it.
> >>>> 
> >>>>>>> You also aren’t accounting for the case where you get an exception that
> >>>>>>> is, in turn, preempted.
> >>>>>> 
> >>>>>> Hmm.. Can you give me an example for such an exception in my use-case? I
> >>>>>> cannot think of an exception that might be preempted (assuming #BP, #MC
> >>>>>> cannot be preempted).
> >>>>> 
> >>>>> Look for cond_local_irq_enable().
> >>>> 
> >>>> I looked at it. Yet, I still don’t see how exceptions might happen in my
> >>>> use-case, but having said that - this can be fixed too.
> >>> 
> >>> I’m not totally certain there’s a case that matters.  But it’s worth checking
> >> 
> >> I am still checking. But, I wanted to ask you whether the existing code is
> >> correct, since it seems to me that others do the same mistake I did, unless
> >> I don’t understand the code.
> >> 
> >> Consider for example do_int3(), and see my inlined comments:
> >> 
> >> dotraplinkage void notrace do_int3(struct pt_regs *regs, long error_code)
> >> {
> >>   ...
> >>   ist_enter(regs);        // => preempt_disable()
> >>   cond_local_irq_enable(regs);    // => assume it enables IRQs
> >> 
> >>   ...
> >>   // resched irq can be delivered here. It will not caused rescheduling
> >>   // since preemption is disabled
> >> 
> >>   cond_local_irq_disable(regs);    // => assume it disables IRQs
> >>   ist_exit(regs);            // => preempt_enable_no_resched()
> >> }
> >> 
> >> At this point resched will not happen for unbounded length of time (unless
> >> there is another point when exiting the trap handler that checks if
> >> preemption should take place).
> > 
> > I think it's only a bug in the cases where someone uses extable to fix
> > up an int3 (which would be nuts) or that we oops.  But I should still
> > fix it.  In the normal case where int3 was in user code, we'll miss
> > the reschedule in do_trap(), but we'll reschedule in
> > prepare_exit_to_usermode() -> exit_to_usermode_loop().
> 
> Thanks for your quick response, and sorry for bothering instead of dealing
> with it. Note that do_debug() does something similar to do_int3().
> 
> And then there is optimized_callback() that also uses
> preempt_enable_no_resched(). I think the original use was correct, but then
> a19b2e3d7839 ("kprobes/x86: Remove IRQ disabling from ftrace-based/optimized
> kprobes”) removed the IRQ disabling, while leaving
> preempt_enable_no_resched() . No?

Ah, good catch!
Indeed, we don't need to stick on no_resched anymore.

Thanks!


-- 
Masami Hiramatsu <mhiramat@kernel.org>

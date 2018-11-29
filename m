Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5311C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823D52081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d9jIuLRC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 823D52081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbeK2Uvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 15:51:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45520 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbeK2Uvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 15:51:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FdR4OyRjbODw62SVWJQWNxtVI4PjzKcG/x2E72Ux1gw=; b=d9jIuLRCU9hnqwQ6SiAvXMQpgV
        f4I/4sNz9wMAORcq6nP6yXjA3pH8jsrz6S23oshYnxF7Q62j6Nsiw6LbWaBq9s5Fpr+mgS5BU9NPm
        FDj5g/xlMhRSTq2Z+vOeJn4Dvpzs5ed2ZXkN4+kK1Lt8UmS05NDcgw3pKNK3pwfqDGRXFGihrj9as
        kuNqKXEXLGhQttxO6Dio3h0TtNrwo6NQgdafDFfC9yiWbuXrbx4sWHu4/3WNqeJt4EquyHg7oHKjK
        6FhLcCLsZakFgM2NHYabkeE1mjTEtDTY+88Yre5FJav85MvmKNJpfR8A8FYCUtfIWxFjTXOt/sM6h
        j38QQS8Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSIuB-0004tZ-6t; Thu, 29 Nov 2018 09:46:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6CCCA2029FD58; Thu, 29 Nov 2018 10:46:41 +0100 (CET)
Date:   Thu, 29 Nov 2018 10:46:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "Woodhouse, David" <dwmw@amazon.co.uk>
Subject: Re: [RFC PATCH 1/5] x86: introduce preemption disable prefix
Message-ID: <20181129094641.GD2131@hirez.programming.kicks-ass.net>
References: <20181018005420.82993-1-namit@vmware.com>
 <20181018005420.82993-2-namit@vmware.com>
 <D247AB7C-2890-49CE-B102-163E5B368FC2@amacapital.net>
 <07255D2B-0243-4254-B62A-37050C44207E@vmware.com>
 <CALCETrXEG8OrMpB3VBS9RF41O_MwtPmXBazkdSGE0ohZmXDcBw@mail.gmail.com>
 <925F22EA-F8CB-4194-B96B-378409ED7918@vmware.com>
 <2626124E-7344-42F3-AD07-0BB34D62A9EE@amacapital.net>
 <6F1FD9DA-5E86-42A2-8EAF-05F5D70FE2EF@vmware.com>
 <20181019083325.GC3121@hirez.programming.kicks-ass.net>
 <F1F3B914-2630-41ED-B205-BBA50F94B64F@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F1F3B914-2630-41ED-B205-BBA50F94B64F@amacapital.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 07:29:45AM -0700, Andy Lutomirski wrote:
> > On Oct 19, 2018, at 1:33 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> >> On Fri, Oct 19, 2018 at 01:08:23AM +0000, Nadav Amit wrote:
> >> Consider for example do_int3(), and see my inlined comments:
> >> 
> >> dotraplinkage void notrace do_int3(struct pt_regs *regs, long error_code)
> >> {
> >>    ...
> >>    ist_enter(regs);        // => preempt_disable()
> >>    cond_local_irq_enable(regs);    // => assume it enables IRQs
> >> 
> >>    ...
> >>    // resched irq can be delivered here. It will not caused rescheduling
> >>    // since preemption is disabled
> >> 
> >>    cond_local_irq_disable(regs);    // => assume it disables IRQs
> >>    ist_exit(regs);            // => preempt_enable_no_resched()
> >> }
> >> 
> >> At this point resched will not happen for unbounded length of time (unless
> >> there is another point when exiting the trap handler that checks if
> >> preemption should take place).
> >> 
> >> Another example is __BPF_PROG_RUN_ARRAY(), which also uses
> >> preempt_enable_no_resched().
> >> 
> >> Am I missing something?
> > 
> > Would not the interrupt return then check for TIF_NEED_RESCHED and call
> > schedule() ?
> 
> The paranoid exit path doesn’t check TIF_NEED_RESCHED because it’s
> fundamentally atomic — it’s running on a percpu stack and it can’t
> schedule. In theory we could do some evil stack switching, but we
> don’t.
> 
> How does NMI handle this?  If an NMI that hit interruptible kernel
> code overflows a perf counter, how does the wake up work?

NMIs should never set NEED_RESCHED. What the perf does it self-IPI
(irq_work) and do the wakeup from there.

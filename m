Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32909C5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 21:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F19BE21470
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 21:39:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F19BE21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeJQFbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 01:31:23 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58915 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbeJQFbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 01:31:23 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gCX3L-0007DW-Au; Tue, 16 Oct 2018 23:38:59 +0200
Date:   Tue, 16 Oct 2018 23:38:59 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/3] x86/mm/pat: Disable preemption around
 __flush_tlb_all()
Message-ID: <20181016213859.ldx34cab7ggm5nm5@linutronix.de>
References: <20181016202525.29437-1-bigeasy@linutronix.de>
 <20181016202525.29437-2-bigeasy@linutronix.de>
 <CALCETrWB2kH9d5ui5haY3aRTD9SAU=tcdkTMoAzJ5rhLh3mO3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrWB2kH9d5ui5haY3aRTD9SAU=tcdkTMoAzJ5rhLh3mO3w@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-16 14:25:07 [-0700], Andy Lutomirski wrote:
> > diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
> > index 51a5a69ecac9f..fe6b21f0a6631 100644
> > --- a/arch/x86/mm/pageattr.c
> > +++ b/arch/x86/mm/pageattr.c
> > @@ -2088,7 +2088,9 @@ void __kernel_map_pages(struct page *page, int numpages, int enable)
> >          * We should perform an IPI and flush all tlbs,
> >          * but that can deadlock->flush only current cpu:
> >          */
> > +       preempt_disable();
> >         __flush_tlb_all();
> > +       preempt_enable();
> >
> 
> Depending on your CPU, __flush_tlb_all() is either
> __native_flush_tlb_global() or __native_flush_tlb().  Only
> __native_flush_tlb() could have any problem with preemption, but it
> has a WARN_ON_ONCE(preemptible()); in it.  Can you try to figure out
> why that's not firing for you?

It is firing, it is the warning that was introduced in commit
decab0888e6e (as mention in the commit message; I just noticed it way
later because it popped early in the boot log).

> I suspect that a better fix would be to put preempt_disable() into
> __native_flulsh_tlb(), but I'd still like to understand why the
> warning isn't working.

__native_flulsh_tlb() just had its preempt_disable() removed in
decab0888e6e and __kernel_map_pages() is only called from the debug
code. The other caller of __native_flulsh_tlb() seem to hold a lock or
run with disabled interrupts.

Sebastian

Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A14C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4CF2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Iiyj8+Qn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD4CF2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbeLJIzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 03:55:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49372 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeLJIzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 03:55:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7NJVooFTIsQ1sLkf0iscEhELwDGD/ToFRglzg8miKq0=; b=Iiyj8+QnmYLqIGGVuq//ASid1
        FgobeVzTq1ckKSaJ7bRoyUhcT3ZNDVmh6qHg5+xRraqRVuMWRX1MPc9bJV5fjtANCXXXudqtnr3wa
        Stj0H1iaezgqN8EfWOorQt8MZiMOrFmKsDvK6IlMHD+wKHVAvxCpf1gkkTUNibCMqZG2nHZ+WFm3w
        TwuGhVKRnZrtIborVj7qx5PQP4L+2XXMkrwlZV3+4v7SIAOXKOGrfUK6Q88nMCjIGL2cemBOodsJ0
        mLVJpOHOR+k9ecv4W5Ao+iPqeqmuJxzPqHbc5jIXxANkztnJqlsDaBqRSvd8/bPYktG9IiAMeLkcr
        1uZGkqZ3A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gWHLj-0002MZ-1S; Mon, 10 Dec 2018 08:55:35 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 56C20207261A3; Mon, 10 Dec 2018 09:55:32 +0100 (CET)
Date:   Mon, 10 Dec 2018 09:55:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: Should this_cpu_read() be volatile?
Message-ID: <20181210085532.GG5289@hirez.programming.kicks-ass.net>
References: <20181203224920.GQ10377@bombadil.infradead.org>
 <C377D9EF-A0F4-4142-8145-6942DC29A353@gmail.com>
 <EB579DAE-B25F-4869-8529-8586DF4AECFF@gmail.com>
 <20181206102559.GG13538@hirez.programming.kicks-ass.net>
 <55B665E1-3F64-4D87-B779-D1B4AFE719A9@gmail.com>
 <20181207084550.GA2237@hirez.programming.kicks-ass.net>
 <C29C792A-3F47-482D-B0D8-99EABEDF8882@gmail.com>
 <C064896E-268A-4462-8D51-E43C1CF10104@gmail.com>
 <20181208105220.GF5289@hirez.programming.kicks-ass.net>
 <5DE00B41-835C-4E68-B192-2A3C7ACB4392@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5DE00B41-835C-4E68-B192-2A3C7ACB4392@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2018 at 04:57:43PM -0800, Nadav Amit wrote:
> > On Dec 8, 2018, at 2:52 AM, Peter Zijlstra <peterz@infradead.org> wrote:

> > My patch proposed here:
> > 
> >  https://marc.info/?l=linux-mm&m=154409548410209
> > 
> > would actually fix that one I think, preempt_count() uses
> > raw_cpu_read_4() which will loose the volatile with that patch.

> I tested the patch you referenced, and it certainly improves the situation
> for reads, but there are still small and big issues lying around.

I'm sure :-(, this has been 'festering' for a long while it seems. And
esp. on x86 specific code, where for a long time we all assumed the
various per-cpu APIs were in fact the same (which turns out to very much
not be true).

> The biggest one is that (I think) smp_processor_id() should apparently use
> __this_cpu_read().

Agreed, and note that this will also improve code generation on !x86.

However, I'm not sure the current !debug definition:

#define smp_processor_id() raw_smp_processor_id()

is actually correct. Where raw_smp_processor_id() must be
this_cpu_read() to avoid CSE, we actually want to allow CSE on
smp_processor_id() etc..

> There are all kind of other smaller issues, such as set_irq_regs() and
> get_irq_regs(), which should run with disabled interrupts. They affect the
> generated code in do_IRQ() and others.
> 
> But beyond that, there are so many places in the code that use
> this_cpu_read() while IRQs are guaranteed to be disabled. For example
> arch/x86/mm/tlb.c is full with this_cpu_read/write() and almost(?) all
> should be running with interrupts disabled. Having said that, in my build
> only flush_tlb_func_common() was affected.

This all feels like something static analysis could help with; such
tools would also make sense for !x86 where the difference between the
various per-cpu accessors is even bigger.


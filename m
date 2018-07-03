Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D18C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB7F23C52
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gSOb6JK7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB7F23C52
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934376AbeGCRfu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:35:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38336 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934237AbeGCRfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:35:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vGzXPoW/Bg8Pd8Sl1LtBAwnJAJ4zXa3kozmVXoSBEBw=; b=gSOb6JK7SCo6MDqkNpOo/qJSb
        GijR0GC0IEQu5i+bZaH60CDOxXpSDL3WpYQ1OpbbxmRReQJbDFrrQEP/vzTwDmHUW+lzZcz+sjM7G
        f3RK6Fbw+DETPp6qyRls9SP2ZaeuxU4FetJKH6Z3e5iV2XI+q7uN/gpBa6gHmpGSUHN1zLjNRt0h3
        ugmDVZorAJZalfMTjyJQWly/2dZUItBcZcs7jv8iJNcyoD070dyw6kkJ1SwS+DCx4RbYGZBEIF7BO
        4Zjw8ja56O2zh8aevHiVaWmVgIq/ATy8UzfiiYYDewXTR2oAZYb61wYV/G/N9lpa4csDB70qwzbsw
        /N8RRczJA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1faPCX-0001Qu-PV; Tue, 03 Jul 2018 17:34:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B23B120289333; Tue,  3 Jul 2018 19:34:51 +0200 (CEST)
Date:   Tue, 3 Jul 2018 19:34:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andi Kleen <andi@firstfloor.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Christoph Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>, gor@linux.ibm.com
Subject: Re: [RFC PATCH for 4.18] rseq: use __u64 for rseq_cs fields,
 validate user inputs
Message-ID: <20180703173451.GX2494@hirez.programming.kicks-ass.net>
References: <858886246.10882.1530583291379.JavaMail.zimbra@efficios.com>
 <CA+55aFxWMjwx-4TGBHt0H6bh6FXC3NKMsjp=eKGw5cgA4wMBUA@mail.gmail.com>
 <1776351430.10902.1530585009519.JavaMail.zimbra@efficios.com>
 <20180703081449.GT2494@hirez.programming.kicks-ass.net>
 <20180703082955.GH3704@osiris>
 <20180703084312.GU2494@hirez.programming.kicks-ass.net>
 <20180703085546.GJ3704@osiris>
 <20180703092113.GV2494@hirez.programming.kicks-ass.net>
 <20180703164048.i2te5gjemcafqzwf@two.firstfloor.org>
 <CA+55aFzYEQgEhCnrwtbGuCy36Wh+aiw0_9rgMcjUgbn1JtZAPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzYEQgEhCnrwtbGuCy36Wh+aiw0_9rgMcjUgbn1JtZAPQ@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 10:10:37AM -0700, Linus Torvalds wrote:
> On Tue, Jul 3, 2018 at 9:40 AM Andi Kleen <andi@firstfloor.org> wrote:
> >
> > So it sounds like architectures that don't have an instruction atomic u64
> > *_user need to disable interrupts during the access, and somehow handle that
> > case when a page fault happens?
> 
> No. It's actually the store by *user* space that is the critical one.
> Not the whole 64-bit value, just the low pointer part.
> 
> The kernel could do it as a byte-by-byte load, really. It's
> per-thread, and once the kernel is running, it's not going to change.
> The kernel never changes the value, it just loads it from user space.

The kernel doesn't change _this_ value, but the kernel does change other
values, like for instance rseq->cpu_id. But even there, it could use
byte stores and it is again the userspace load of that field that is
critical again and needs to be a single op.


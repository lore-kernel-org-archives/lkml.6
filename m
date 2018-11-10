Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3014C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 23:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4B42089A
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 23:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vaTz9YyF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA4B42089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbeKKJH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 04:07:57 -0500
Received: from merlin.infradead.org ([205.233.59.134]:50802 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbeKKJH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 04:07:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pcvfrR2weqwFeCK+WlufDQK7hMyRibZsLKYSvbC9F3s=; b=vaTz9YyFye7cpozLKKUwPXGoS
        A+GoN2RKkxvysS0DXkwIlhtqGanV4dyhmvbrkvKu44/EPr6e5QFjXMVFzLbWgwviI63LMF/ax4X6Y
        /fFEXGa4I/td88PZ3hnExzmZMEpGoQqoKhaBaEQEDLwrLrTOUoIidR62aMIqWmxWv01agehNfLzXc
        2hAjfMTCVFyBkRwJUijDML5Amcdq1xa+yrBfrYRUyIS2yytQKUBiBrLuTLZVhChmPWUBAoh7xePft
        4rURTs+zavf0o03CiVOK+aDT1/1yJfqiMJ3RC0vUeb+Ki9uNS6O0b94VbXvADP40EfQH2H1knYQDH
        WPH9Ym8+Q==;
Received: from [64.114.255.114] (helo=worktop)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gLcYm-0000xX-3s; Sat, 10 Nov 2018 23:21:00 +0000
Received: by worktop (Postfix, from userid 1000)
        id 59EFB6E07D5; Sun, 11 Nov 2018 00:20:59 +0100 (CET)
Date:   Sun, 11 Nov 2018 00:20:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH RFC 0/3] Static calls
Message-ID: <20181110232059.GA12766@worktop.psav.com>
References: <cover.1541711457.git.jpoimboe@redhat.com>
 <20181109072811.GB86700@gmail.com>
 <CAKv+Gu-3OfrgGafO3OY3hAir723tD6shEaWTLJ5Ec4YcW4yZyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-3OfrgGafO3OY3hAir723tD6shEaWTLJ5Ec4YcW4yZyQ@mail.gmail.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 02:50:27PM +0100, Ard Biesheuvel wrote:
> On 9 November 2018 at 08:28, Ingo Molnar <mingo@kernel.org> wrote:
> >> - I'm not sure about the objtool approach.  Objtool is (currently)
> >>   x86-64 only, which means we have to use the "unoptimized" version
> >>   everywhere else.  I may experiment with a GCC plugin instead.
> >
> > I'd prefer the objtool approach. It's a pretty reliable first-principles
> > approach while GCC plugin would have to be replicated for Clang and any
> > other compilers, etc.
> >
> 
> I implemented the GCC plugin approach here for arm64

I'm confused; I though we only needed objtool for variable instruction
length architectures, because we can't reliably decode our instruction
stream. Otherwise we can fairly trivially use the DWARF relocation data,
no?

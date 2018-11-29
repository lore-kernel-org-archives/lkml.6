Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C265C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D1220863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uVGLzwLT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5D1220863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbeK3EOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:14:43 -0500
Received: from merlin.infradead.org ([205.233.59.134]:47190 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729157AbeK3EOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:14:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=w8oLPHASfULKC4/0yHJ7+XAK/WtkONNK6Ir9MvPeIW4=; b=uVGLzwLTStGRiXMQFgiEINH81
        bSJ97lqoEWbSQPlTMwWvspsJ4OXn7lCGYhoE/PsfKjmPZfoNeJ5dD+FtxbK0iqfRivcvw8FNko6Ba
        MRpiDHkVXpv0OiYSYR8izHHU9DH1+PVyMN5dLvsQNaQEwUMxSbLQf/t1KkzwjCrqX8ygJ4HoRJOQ/
        7z5pjF40JaSX6d0Kdsd54bo9gEPzFRlShUhzWPBVi90XrRdnZdRaOYuALDjweYDFI0R7qzbv6eFMS
        DMUR0/KbCWKfRdS14cbmG1nOV/6sotpT//i6ypoGqh83bETOZKQgx4kCi9T4UEiTCzVy6p2hFinzC
        0e0565BEw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSPmy-000338-Ri; Thu, 29 Nov 2018 17:07:45 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5528A2029FD58; Thu, 29 Nov 2018 18:07:42 +0100 (CET)
Date:   Thu, 29 Nov 2018 18:07:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, mhiramat@kernel.org,
        jbaron@akamai.com, Jiri Kosina <jkosina@suse.cz>,
        David.Laight@aculab.com, bp@alien8.de, julia@ni.com,
        jeyu@kernel.org, Peter Anvin <hpa@zytor.com>
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
Message-ID: <20181129170742.GC9027@hirez.programming.kicks-ass.net>
References: <20181126200801.GW2113@hirez.programming.kicks-ass.net>
 <20181126212628.4apztfazichxnt7r@treble>
 <20181127084330.GX2113@hirez.programming.kicks-ass.net>
 <CALCETrXam8JBtXE3S97Vyb_=+pmjgr23SoZ-Dm5pmYtwZYA+7Q@mail.gmail.com>
 <20181129094210.GC2131@hirez.programming.kicks-ass.net>
 <ECF632D9-581B-40B7-9F0A-6B5607A4D0E3@amacapital.net>
 <20181129143853.GO2131@hirez.programming.kicks-ass.net>
 <20181129163342.tp5wlfcyiazwwyoh@treble>
 <CAHk-=wg5wUXJX5mF+22WXWM_vPESb+p6-z-ZrG7rC1k2O7u=NQ@mail.gmail.com>
 <0A629D30-ADCF-4159-9443-E5727146F65F@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0A629D30-ADCF-4159-9443-E5727146F65F@amacapital.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 09:02:23AM -0800, Andy Lutomirski wrote:
> > On Nov 29, 2018, at 8:50 AM, Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > So no. Do *not* try to change %rsp on the stack in the bp handler.
> > Instead, I'd suggest:
> > 
> > - just restart the instruction (with the suggested "ptregs->rip --")
> > 
> > - to avoid any "oh, we're not making progress" issues, just fix the
> > instruction yourself to be the right call, by looking it up in the
> > "what needs to be fixed" tables.
> > 
> > No?

> Or do you think we can avoid the IPI while the int3 is there?

I'm thinking Linus is suggesting the #BP handler does the text write too
(as a competing store) and then sync_core() and restarts.

But I think that is broken, because then there is no telling what the
other CPUs will observe.

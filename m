Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053C6C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E13420989
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E13420989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbeK3E0T convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:26:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:37838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbeK3E0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:26:19 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B86AB20863;
        Thu, 29 Nov 2018 17:20:01 +0000 (UTC)
Date:   Thu, 29 Nov 2018 12:20:00 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>, julia@ni.com, jeyu@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
Message-ID: <20181129122000.7fb4fb04@gandalf.local.home>
In-Reply-To: <20181129171539.GD9027@hirez.programming.kicks-ass.net>
References: <20181126200801.GW2113@hirez.programming.kicks-ass.net>
        <20181126212628.4apztfazichxnt7r@treble>
        <20181127084330.GX2113@hirez.programming.kicks-ass.net>
        <CALCETrXam8JBtXE3S97Vyb_=+pmjgr23SoZ-Dm5pmYtwZYA+7Q@mail.gmail.com>
        <20181129094210.GC2131@hirez.programming.kicks-ass.net>
        <ECF632D9-581B-40B7-9F0A-6B5607A4D0E3@amacapital.net>
        <20181129143853.GO2131@hirez.programming.kicks-ass.net>
        <20181129163342.tp5wlfcyiazwwyoh@treble>
        <20181129164914.GA9027@hirez.programming.kicks-ass.net>
        <0FDA053D-7ADC-4F42-AEA5-99DA155FCED0@amacapital.net>
        <20181129171539.GD9027@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2018 18:15:39 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Nov 29, 2018 at 08:59:31AM -0800, Andy Lutomirski wrote:
> 
> > If you make it conditional on CPL, do it for 32-bit as well, add
> > comments,   
> 
> > and convince yourself that there isn’t a better solution
> > (like pointing IP at a stub that retpolines to the target by reading
> > the function pointer, a la the unoptimizable version), then okay, I
> > guess, with only a small amount of grumbling.  
> 
> Right; so we _could_ grow the trampoline with a retpoline indirect call
> and ret. It just makes the trampoline a whole lot bigger, but it could
> work.

Can't we make use of the callee clobbered registers? I mean, we know
that call is being made when the int3 is triggered. Then we can save
the return address in one register, and the jump location in another,
and then just call a trampoline that does:

r8 = return address
r9 = function to call

	push r8
	jmp *r9

Then have the regs->ip point to that trampoline.

-- Steve

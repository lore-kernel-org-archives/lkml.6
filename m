Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10F3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C818E213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C818E213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbeK3GiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:38:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:35660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbeK3GiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 01:38:06 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91CE220868;
        Thu, 29 Nov 2018 19:31:34 +0000 (UTC)
Date:   Thu, 29 Nov 2018 14:31:33 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, mhiramat@kernel.org,
        jbaron@akamai.com, Jiri Kosina <jkosina@suse.cz>,
        David.Laight@aculab.com, bp@alien8.de, julia@ni.com,
        jeyu@kernel.org, Peter Anvin <hpa@zytor.com>
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
Message-ID: <20181129143133.2b38bc76@gandalf.local.home>
In-Reply-To: <CAHk-=whBuSXe1+8HGT23FWDypkAP7TPun3te=fw2aLx+F6WVig@mail.gmail.com>
References: <20181126160217.GR2113@hirez.programming.kicks-ass.net>
        <20181129094210.GC2131@hirez.programming.kicks-ass.net>
        <ECF632D9-581B-40B7-9F0A-6B5607A4D0E3@amacapital.net>
        <20181129143853.GO2131@hirez.programming.kicks-ass.net>
        <20181129163342.tp5wlfcyiazwwyoh@treble>
        <CAHk-=wg5wUXJX5mF+22WXWM_vPESb+p6-z-ZrG7rC1k2O7u=NQ@mail.gmail.com>
        <0A629D30-ADCF-4159-9443-E5727146F65F@amacapital.net>
        <20181129121307.12393c57@gandalf.local.home>
        <CAHk-=wik5AfDs7qqjGHQ5vRBYkV8K6tFmPna3PdbwdzVwPGTsg@mail.gmail.com>
        <20181129124404.2fe55dd0@gandalf.local.home>
        <CAHk-=wgnZobye-KNaBVO-SdqX-5Xkz+i=aJ_kOFZ4RpZFT0HqQ@mail.gmail.com>
        <20181129125857.75c55b96@gandalf.local.home>
        <CAHk-=wigLUgxDM6Dq2aS7efduffratP976Ggmpv4Ev4EOrJxyA@mail.gmail.com>
        <20181129134725.6d86ade6@gandalf.local.home>
        <CAHk-=wgbnQs4fpuHqT1jLkDnKcvTGS5EN8m=qy7oUE5n_fhOig@mail.gmail.com>
        <20181129141648.6ef944a9@gandalf.local.home>
        <CAHk-=whBuSXe1+8HGT23FWDypkAP7TPun3te=fw2aLx+F6WVig@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2018 11:24:43 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, Nov 29, 2018 at 11:16 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > But then we need to implement all numbers of parameters.  
> 
> Oh, I agree, it's nasty.
> 
> But it's actually a nastiness that we've solved before. In particular,
> with the system call mappings, which have pretty much the exact same
> issue of "map unknown number of arguments to registers".
> 
> Yes, it's different - there you map the unknown number of arguments to
> a structure access instead. And yes, the macros are unbelievably ugly.
> See
> 
>     arch/x86/include/asm/syscall_wrapper.h

Those are not doing inline assembly.

> 
> and the __MAP() macro from
> 
>     include/linux/syscalls.h
> 
> so it's not pretty. But it would solve all the problems.
> 

Again, not inline assembly, and those only handle up to 6 parameters.

My POC started down this route, until I notice that there's tracepoints
that have 13 parameters! And I need to handle all tracepoints.

Yes, we can argue that we need to change those (if that doesn't break
the API of something using it).

-- Steve


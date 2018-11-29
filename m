Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E750AC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0AB12145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qz3M7r2J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0AB12145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbeK3Jcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 04:32:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:54868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbeK3Jct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 04:32:49 -0500
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89FD6214C1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 22:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543530347;
        bh=ZevyHl7cH+sKunfD6kCh0cr6GQjoM1LLS9r3Vdr+sz4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qz3M7r2JbJyLSmTb9YannoO52MIk74MtpfcXSP49rC3PnbaaLReqlkbt4+hs6T3Eb
         P/2mEjP5zf/StR9lhn/lYXfz1oZaeGVrAjSgBtwUP7TDREpJutUnwv+Ay4YrXR4Vu4
         Yr39Niqf0Wr60AJoKL1ZgVnkxgiS4YJrPJoiPu4s=
Received: by mail-wr1-f49.google.com with SMTP id r10so3440687wrs.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 14:25:47 -0800 (PST)
X-Gm-Message-State: AA+aEWYxEzibDYZECX9OyLNeU2aTFKk6Ql9Fldo4D70zAAGog9WgmB5w
        vWXo0eNo86GfMoK4aUNIrgrmrW+wqjsiyPP8PIQC0A==
X-Google-Smtp-Source: AFSGD/Vw6P1nJLBC0gy20gJemx5nRSHIRPwBrf3toYruAIBNP6KY5BWyShApx4MLlvBrqzYggs4CJrvj/hj9hhMrt8M=
X-Received: by 2002:adf:e08c:: with SMTP id c12mr2714518wri.199.1543530345975;
 Thu, 29 Nov 2018 14:25:45 -0800 (PST)
MIME-Version: 1.0
References: <CALCETrXam8JBtXE3S97Vyb_=+pmjgr23SoZ-Dm5pmYtwZYA+7Q@mail.gmail.com>
 <20181129094210.GC2131@hirez.programming.kicks-ass.net> <ECF632D9-581B-40B7-9F0A-6B5607A4D0E3@amacapital.net>
 <20181129143853.GO2131@hirez.programming.kicks-ass.net> <20181129163342.tp5wlfcyiazwwyoh@treble>
 <20181129164914.GA9027@hirez.programming.kicks-ass.net> <0FDA053D-7ADC-4F42-AEA5-99DA155FCED0@amacapital.net>
 <20181129171050.iio53bw67fbiwzud@treble> <20181129220148.GD11632@hirez.programming.kicks-ass.net>
 <20181129221446.qb7znvt7zprlbz77@treble> <20181129222209.GG11632@hirez.programming.kicks-ass.net>
In-Reply-To: <20181129222209.GG11632@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 29 Nov 2018 14:25:33 -0800
X-Gmail-Original-Message-ID: <CALCETrW+bU5Bc3ShLfoNN10Wmgt_aSxyOM4BTdSm1WuaOf91qA@mail.gmail.com>
Message-ID: <CALCETrW+bU5Bc3ShLfoNN10Wmgt_aSxyOM4BTdSm1WuaOf91qA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>, julia@ni.com, jeyu@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 2:22 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Nov 29, 2018 at 04:14:46PM -0600, Josh Poimboeuf wrote:
> > On Thu, Nov 29, 2018 at 11:01:48PM +0100, Peter Zijlstra wrote:
> > > On Thu, Nov 29, 2018 at 11:10:50AM -0600, Josh Poimboeuf wrote:
> > > > On Thu, Nov 29, 2018 at 08:59:31AM -0800, Andy Lutomirski wrote:
> > >
> > > > > (like pointing IP at a stub that retpolines to the target by reading
> > > > > the function pointer, a la the unoptimizable version), then okay, I
> > > > > guess, with only a small amount of grumbling.
> > > >
> > > > I tried that in v2, but Peter pointed out it's racy:
> > > >
> > > >   https://lkml.kernel.org/r/20181126160217.GR2113@hirez.programming.kicks-ass.net
> > >
> > > Ah, but that is because it is a global shared trampoline.
> > >
> > > Each static_call has it's own trampoline; which currently reads
> > > something like:
> > >
> > >     RETPOLINE_SAFE
> > >     JMP *key
> > >
> > > which you then 'defuse' by writing an UD2 on. _However_, if you write
> > > that trampoline like:
> > >
> > > 1:  RETPOLINE_SAFE
> > >     JMP *key
> > > 2:  CALL_NOSPEC *key
> > >     RET
> > >
> > > and have the text_poke_bp() handler jump to 2 (a location you'll never
> > > reach when you enter at 1), it will in fact work I think. The trampoline
> > > is never modified and not shared between different static_call's.
> >
> > But after returning from the function to the trampoline, how does it
> > return from the trampoline to the call site?  At that point there is no
> > return address on the stack.
>
> Oh, right, so that RET don't work. ARGH. Time to go sleep I suppose.

I assume I'm missing something, but can't it just be JMP_NOSPEC *key?
The code would call the trampoline just like any other function and,
if the alignment is bad, we can skip patching it.  And, if we want the
performance back, maybe some day we can find a clean way to patch
those misaligned callers, too.

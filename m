Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2355EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D390F2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aDWELOeM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D390F2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbeK3Fst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 00:48:49 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34090 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbeK3Fst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 00:48:49 -0500
Received: by mail-lj1-f196.google.com with SMTP id u6-v6so2692867ljd.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 10:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hBXTzVFCeXESYXc15GVm+W4pCXfGwIikmMqtKVO6zV0=;
        b=aDWELOeMmIHAnGuPmVxnnRD5AXZkBti98qOAAb1t8MPKZwIo98Vdo0oRhS1t2pniwA
         BaKQkG+6Yk3d/vO9VOI0vObsfXoX/lx8yt2QcjfY41KFaiXe6/+JcJXvjBxXichcc5iz
         dGGFjmEzqT61WxGSOUN85KunESX6i5fbNgmaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hBXTzVFCeXESYXc15GVm+W4pCXfGwIikmMqtKVO6zV0=;
        b=GXrXi0rTZ592JJd89uVzxHTUTLuWKhL+e207NYgs4fR4bxZ/n4aGfMR3UNmD7H7u1S
         CPMluEIu9JlDrz+iuNZRLxFGfz1TmyXe4fPYwka6xs51OtJfh6b3wTexFVp/VDMTHQwE
         +okDoHdSbNe+kn30JVrJmZitCXJxMqk5V3Ym9DO1ElrV9SBtUE6HJhvdYo9AWIlq6xHj
         m0bIm5IGYJnB1PH7fY+ybaTJvWruO2YIS0tFeR5wAX4QM7G3kFUjvM1EZL34Jw/QZjX3
         knp3P5Btcmgzl0Sy/b+y6mLLHSjg02Kp1vgi4RFYKimwfnVKz7Ec6Pm7g/czQ2wyDTAD
         Y3Zw==
X-Gm-Message-State: AA+aEWZ2qjLTHD5hxQjzlIKCeDxbiaGVGIE2GuVg65VdYoG3ls5CzF1G
        6kDw1uP07NtyppSCHVNQjYMjuAn0lcA=
X-Google-Smtp-Source: AFSGD/WcfhMuI038Hy+zrUWJEsiJvJdpeKCO96ag+oOAoIfELyTN1S+Ci6IdFGrAzsIEvM9cpd4Zdw==
X-Received: by 2002:a2e:8702:: with SMTP id m2-v6mr1803898lji.132.1543516947111;
        Thu, 29 Nov 2018 10:42:27 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id m21sm428943lfl.97.2018.11.29.10.42.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 10:42:26 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id z13so2216658lfe.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 10:42:25 -0800 (PST)
X-Received: by 2002:a19:982:: with SMTP id 124mr1717500lfj.138.1543516945195;
 Thu, 29 Nov 2018 10:42:25 -0800 (PST)
MIME-Version: 1.0
References: <20181126160217.GR2113@hirez.programming.kicks-ass.net>
 <20181126171036.chcbmb35ygpxziub@treble> <20181126175624.bruqfbkngbucpvxr@treble>
 <20181126200801.GW2113@hirez.programming.kicks-ass.net> <20181126212628.4apztfazichxnt7r@treble>
 <20181127084330.GX2113@hirez.programming.kicks-ass.net> <CALCETrXam8JBtXE3S97Vyb_=+pmjgr23SoZ-Dm5pmYtwZYA+7Q@mail.gmail.com>
 <20181129094210.GC2131@hirez.programming.kicks-ass.net> <ECF632D9-581B-40B7-9F0A-6B5607A4D0E3@amacapital.net>
 <20181129143853.GO2131@hirez.programming.kicks-ass.net> <20181129163342.tp5wlfcyiazwwyoh@treble>
 <CAHk-=wg5wUXJX5mF+22WXWM_vPESb+p6-z-ZrG7rC1k2O7u=NQ@mail.gmail.com>
 <0A629D30-ADCF-4159-9443-E5727146F65F@amacapital.net> <20181129121307.12393c57@gandalf.local.home>
 <CAHk-=wik5AfDs7qqjGHQ5vRBYkV8K6tFmPna3PdbwdzVwPGTsg@mail.gmail.com>
 <20181129124404.2fe55dd0@gandalf.local.home> <CAHk-=wgnZobye-KNaBVO-SdqX-5Xkz+i=aJ_kOFZ4RpZFT0HqQ@mail.gmail.com>
 <60A06EF9-C301-4705-A32C-5E77E2D9DA9C@amacapital.net>
In-Reply-To: <60A06EF9-C301-4705-A32C-5E77E2D9DA9C@amacapital.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Nov 2018 10:42:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=whS-A2SmC_+qvzv2hxZZVqxpftzc4jxwJC9=yqzN+jX8g@mail.gmail.com>
Message-ID: <CAHk-=whS-A2SmC_+qvzv2hxZZVqxpftzc4jxwJC9=yqzN+jX8g@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 10:00 AM Andy Lutomirski <luto@amacapital.net> wrote:
> > then it really sounds pretty safe to just say "ok, just make it
> > aligned and update the instruction with an atomic cmpxchg or
> > something".
>
> And how do we do that?  With a gcc plugin and some asm magic?

Asm magic.

You already have to mark the call sites with

    static_call(fn, arg1, arg2, ...);

and while it right now just magically depends on gcc outputting the
right code to call the trampoline. But it could do it as a jmp
instruction (tail-call), and maybe that works right, maybe it doesn't.
And maybe some gcc switch makes it output it as a indirect call due to
instrumentation or something. Doing it with asm magic would, I feel,
be safer anyway, so that we'd know *exactly* how that call gets done.

For example, if gcc does it as a jmp due to a tail-call, the
compiler/linker could in theory turn the jump into a short jump if it
sees that the trampoline is close enough. Does that happen? Probably
not. But I don't see why it *couldn't* happen in the current patch
series. The trampoline is just a regular function, even if it has been
defined by global asm.

Putting the trampoline in a different code section could fix things
like that (maybe there was a patch that did that and I missed it?) but
I do think that doing the call with an asm would *also* fix it.

But the "just always use a trampoline" is certainly the simpler model.

                  Linus

Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52317C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F59C213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DOk7KXlK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F59C213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbeK3GFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:05:25 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42152 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbeK3GFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 01:05:25 -0500
Received: by mail-lf1-f67.google.com with SMTP id l10so2259729lfh.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 10:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O9SojYwHQPcsPTe8qJAGrOuK6Ar88Oz5x/NxP2tnSYI=;
        b=DOk7KXlKgEyhByFZO0zXbwJuSqOMIZlQu6NYOT5uQJnKgjQH0L1loHn25qHqN08b1V
         D32GPQdSbwlmwxL/9IeUh7TZRuen/yrq94sLfd7cFncvqiuEoktDnPRyAYpkQA5xh1UX
         GnKqyAnZle6pNNQC8F0TuxYApgMmXTcWYjJFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O9SojYwHQPcsPTe8qJAGrOuK6Ar88Oz5x/NxP2tnSYI=;
        b=EpvdoYas2aF5GJZf5UB2DpbR2EwlsmIZvmSUV9UegealA+TyoRSkoGxCkM0ioVCwI/
         chVs7jb50DyWaUD2KfKXMBm9B+iMWz+jMRH2aUJrJKsyC5f2xQPBSnDvOAnwipNNasP8
         1rCGU8B5IpG/WuaE4Ayg6qA7FT+8Ax4ADu5LID1LtatPzqbfrC+T87RVTJDznaccAOEk
         DYDYEUZ0wo29g0m67k65RyyXuKwGjV2E/SQE+/7VF2IKzTi4p0ao920PpZtrKnwfbMhK
         Kl6tmQ68A8yFAZ4Yrk79jv5SQZY9TnbQt4SdSQw+E7gnX70ax/+PQdGpbfPKIV5Ny5ZL
         79yw==
X-Gm-Message-State: AA+aEWYd/yIYo6krM4cE5U8sIuBbIWuyWQZM/IOizVJcrp5tLzdyrPhV
        e3IAeK0UtppW5s36FGyayIfPGw94++M=
X-Google-Smtp-Source: AFSGD/Uk8f4JwSD8dnRGW3vKFx0zcyyfhmHkxTMOnZw66zzve0toBBDeXRZVuA99Lhu2fRMJeLmjdA==
X-Received: by 2002:a19:8096:: with SMTP id b144mr1901539lfd.8.1543517940233;
        Thu, 29 Nov 2018 10:59:00 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id p91sm448768lfg.4.2018.11.29.10.58.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 10:58:58 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id v1-v6so2736462ljd.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 10:58:57 -0800 (PST)
X-Received: by 2002:a2e:2416:: with SMTP id k22-v6mr2075067ljk.80.1543517937052;
 Thu, 29 Nov 2018 10:58:57 -0800 (PST)
MIME-Version: 1.0
References: <20181126160217.GR2113@hirez.programming.kicks-ass.net>
 <20181126200801.GW2113@hirez.programming.kicks-ass.net> <20181126212628.4apztfazichxnt7r@treble>
 <20181127084330.GX2113@hirez.programming.kicks-ass.net> <CALCETrXam8JBtXE3S97Vyb_=+pmjgr23SoZ-Dm5pmYtwZYA+7Q@mail.gmail.com>
 <20181129094210.GC2131@hirez.programming.kicks-ass.net> <ECF632D9-581B-40B7-9F0A-6B5607A4D0E3@amacapital.net>
 <20181129143853.GO2131@hirez.programming.kicks-ass.net> <20181129163342.tp5wlfcyiazwwyoh@treble>
 <CAHk-=wg5wUXJX5mF+22WXWM_vPESb+p6-z-ZrG7rC1k2O7u=NQ@mail.gmail.com>
 <0A629D30-ADCF-4159-9443-E5727146F65F@amacapital.net> <20181129121307.12393c57@gandalf.local.home>
 <CAHk-=wik5AfDs7qqjGHQ5vRBYkV8K6tFmPna3PdbwdzVwPGTsg@mail.gmail.com>
 <20181129124404.2fe55dd0@gandalf.local.home> <CAHk-=wgnZobye-KNaBVO-SdqX-5Xkz+i=aJ_kOFZ4RpZFT0HqQ@mail.gmail.com>
 <20181129125857.75c55b96@gandalf.local.home> <CAHk-=wigLUgxDM6Dq2aS7efduffratP976Ggmpv4Ev4EOrJxyA@mail.gmail.com>
 <20181129134725.6d86ade6@gandalf.local.home>
In-Reply-To: <20181129134725.6d86ade6@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Nov 2018 10:58:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgbnQs4fpuHqT1jLkDnKcvTGS5EN8m=qy7oUE5n_fhOig@mail.gmail.com>
Message-ID: <CAHk-=wgbnQs4fpuHqT1jLkDnKcvTGS5EN8m=qy7oUE5n_fhOig@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
To:     Steven Rostedt <rostedt@goodmis.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 10:47 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Note, we do have a bit of control at what is getting called. The patch
> set requires that the callers are wrapped in macros. We should not
> allow just any random callers (like from asm).

Actually, I'd argue that asm is often more controlled than C code.

Right now you can do odd things if you really want to, and have the
compiler generate indirect calls to those wrapper functions.

For example, I can easily imagine a pre-retpoline compiler turning

     if (cond)
        fn1(a,b)
     else
       fn2(a,b);

into a function pointer conditional

    (cond ? fn1 : fn2)(a,b);

and honestly, the way "static_call()" works now, can you guarantee
that the call-site doesn't end up doing that, and calling the
trampoline function for two different static calls from one indirect
call?

See what I'm talking about? Saying "callers are wrapped in macros"
doesn't actually protect you from the compiler doing things like that.

In contrast, if the call was wrapped in an inline asm, we'd *know* the
compiler couldn't turn a "call wrapper(%rip)" into anything else.

                  Linus

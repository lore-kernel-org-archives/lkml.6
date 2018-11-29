Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975BEC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C2221104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hkX5PiyI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C2221104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbeK3GPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:15:12 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36372 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeK3GPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 01:15:12 -0500
Received: by mail-lf1-f68.google.com with SMTP id a16so2297576lfg.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 11:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yOBoqJsbC6rZIGgx43iMudgOimKg4TSC64zHL9m5/w0=;
        b=hkX5PiyILjnUC9xqynqpfSu2GZszYMXNB/zzKbj/n6SHguhGukB6afj+800wXK0333
         hJ3eLRO0ZHNeRUhXOoexShhrFU3H/m5/xm/R7k4UcCr5Xfc919YPLTieSmikzxBQ8L2l
         vna/jqu1dRoA7lozVYMWzy212HBpU0GYD0sro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yOBoqJsbC6rZIGgx43iMudgOimKg4TSC64zHL9m5/w0=;
        b=eRQBtSS2/+nbz6aiQRkf5NX1r7EPybncJZAU4Ge/5A8wm9RR7SZzge/LZduFdthAhL
         qoxDF9GkepsPqp9jj38xdgShJtExpbRiIsSq4GmwjDxj9yFN9xGVqjPxXn51ra2TITcx
         Bz0ZONESTTqhtsuC3qN3/Me1JHKIEmvcPc8ihgfShX2kYiAdycTp2GGrVPQKjeF0IXyp
         HDWGCM/PjkaYLJO7ziLRFoC1Aii7efp4SFZiHS42Sly5FzKDxaeA+Fb7DrNhN7Xnj2jk
         RU1QffHQb1vW6Q6QWN8lqEfmbnGPuudfzX356wi6A9zVQMsFdmPGDNGQB/cIliZ2CX3s
         JHiA==
X-Gm-Message-State: AA+aEWaWiJRNi0H3mLsgHDhxFz1gNo2VC3vrPsqFUK/umQPLIVM05gxe
        jcT8bBS7KGdX0VuJlsk/FoeSq3XAshc=
X-Google-Smtp-Source: AFSGD/W31PhgQ0yF6MglIbkitaSBck95tK4XkkyGjjk/UpUwqibwBfONz5Ls9AWZqDGeAfTWYHRXUw==
X-Received: by 2002:a19:980f:: with SMTP id a15mr1945861lfe.103.1543518524711;
        Thu, 29 Nov 2018 11:08:44 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id x204sm438668lfa.5.2018.11.29.11.08.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 11:08:43 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id b20so2270613lfa.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 11:08:43 -0800 (PST)
X-Received: by 2002:a19:c014:: with SMTP id q20mr1724391lff.16.1543518522629;
 Thu, 29 Nov 2018 11:08:42 -0800 (PST)
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
 <20181129134725.6d86ade6@gandalf.local.home> <CAHk-=wgbnQs4fpuHqT1jLkDnKcvTGS5EN8m=qy7oUE5n_fhOig@mail.gmail.com>
In-Reply-To: <CAHk-=wgbnQs4fpuHqT1jLkDnKcvTGS5EN8m=qy7oUE5n_fhOig@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Nov 2018 11:08:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjN=sow0F-UtA6DtHHT_CNUV7wYVe3cQ4E8GPp4LN32+Q@mail.gmail.com>
Message-ID: <CAHk-=wjN=sow0F-UtA6DtHHT_CNUV7wYVe3cQ4E8GPp4LN32+Q@mail.gmail.com>
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

On Thu, Nov 29, 2018 at 10:58 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> In contrast, if the call was wrapped in an inline asm, we'd *know* the
> compiler couldn't turn a "call wrapper(%rip)" into anything else.

Actually, I think I have a better model - if the caller is done with inline asm.

What you can do then is basically add a single-byte prefix to the
"call" instruction that does nothing (say, cs override), and then
replace *that* with a 'int3' instruction.

Boom. Done.

Now, the "int3" handler can just update the instruction in-place, but
leave the "int3" in place, and then return to the next instruction
byte (which is just the normal branch instruction without the prefix
byte).

The cross-CPU case continues to work, because the 'int3' remains in
place until after the IPI.

But that would require that we'd mark those call instruction with

                  Linus

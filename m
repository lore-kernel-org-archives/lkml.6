Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A87C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ADC52145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Lw+WefoL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ADC52145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbeK3D4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:56:37 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38395 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729519AbeK3D4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:56:37 -0500
Received: by mail-lj1-f195.google.com with SMTP id c19-v6so2365161lja.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 08:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ieftWzuJk9u0tH0PSe3WttI77Vs/aPCC88uuLzGmMS8=;
        b=Lw+WefoLIrf861hhBL1Bedb3LogisHbVwscIAtmx+aGmZWSXnOCwJFzrhaA8ypf2HA
         Lib+eJawI0u3zA7qNExmQ9I/jqqM4eMTylaxQiArkYp5jMKb4En8CU2AbgpkSaYWZQdg
         8u6S9NH5WotRwk8Z1JVR5akAKCPxszm8F+ukk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ieftWzuJk9u0tH0PSe3WttI77Vs/aPCC88uuLzGmMS8=;
        b=laY2mYgKwWa7paYJTvQ9psZD565CreN2EcoiMwYGAq63q22DEUertjpJUktYJ/ckkl
         D3dtURi3sBmyiQSfKvBXESP7v0p2O3C4W45o5dBpqV8MfPrUCquIhcsWsM+IEu/FgSWM
         4aEpSs1AHHI1CTCmXCKJC0OK1iPSmsUqmf9YEaeK5wcJrMDWLER09SJqczGWmo9kg6+i
         YcRTgCxXn/7sh+aJST1Qn2WJoceO27VEPFbfa4inRRr/D6QboP0T5+xu5xw80UVKTRBi
         2UW8Qi2wMADKYrTbLWeCtqICHxL3X1I/CJsDZiWvK8Pn99Wam07IdaKtFdEccZqCA5cO
         9syg==
X-Gm-Message-State: AA+aEWZ4OmarJTjWe7Cz703nsHO8JJvTHbnKOtMdAfQB3WTt3oOagpkt
        +tNY+BZ+vozNzzCO17ukP4drJP9ipkE=
X-Google-Smtp-Source: AFSGD/V09/OMjXXNW9u+/teJIaVxMVqtO8ZVOPfsvY0HDpGI94WpoJ25SCDQ3e3gz4MMBQWWpSOrmw==
X-Received: by 2002:a2e:8449:: with SMTP id u9-v6mr1747290ljh.121.1543510235002;
        Thu, 29 Nov 2018 08:50:35 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id m13-v6sm378426ljg.56.2018.11.29.08.50.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 08:50:34 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id v15-v6so2339173ljh.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 08:50:33 -0800 (PST)
X-Received: by 2002:a2e:3e04:: with SMTP id l4-v6mr1556647lja.148.1543510232957;
 Thu, 29 Nov 2018 08:50:32 -0800 (PST)
MIME-Version: 1.0
References: <20181126160217.GR2113@hirez.programming.kicks-ass.net>
 <20181126171036.chcbmb35ygpxziub@treble> <20181126175624.bruqfbkngbucpvxr@treble>
 <20181126200801.GW2113@hirez.programming.kicks-ass.net> <20181126212628.4apztfazichxnt7r@treble>
 <20181127084330.GX2113@hirez.programming.kicks-ass.net> <CALCETrXam8JBtXE3S97Vyb_=+pmjgr23SoZ-Dm5pmYtwZYA+7Q@mail.gmail.com>
 <20181129094210.GC2131@hirez.programming.kicks-ass.net> <ECF632D9-581B-40B7-9F0A-6B5607A4D0E3@amacapital.net>
 <20181129143853.GO2131@hirez.programming.kicks-ass.net> <20181129163342.tp5wlfcyiazwwyoh@treble>
In-Reply-To: <20181129163342.tp5wlfcyiazwwyoh@treble>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Nov 2018 08:50:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg5wUXJX5mF+22WXWM_vPESb+p6-z-ZrG7rC1k2O7u=NQ@mail.gmail.com>
Message-ID: <CAHk-=wg5wUXJX5mF+22WXWM_vPESb+p6-z-ZrG7rC1k2O7u=NQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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

On Thu, Nov 29, 2018 at 8:33 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> This seems to work...
>
> +       .if \create_gap == 1
> +       .rept 6
> +       pushq 5*8(%rsp)
> +       .endr
> +       .endif
> +
> -idtentry int3                  do_int3                 has_error_code=0
> +idtentry int3                  do_int3                 has_error_code=0        create_gap=1

Ugh. Doesn't this entirely screw up the stack layout, which then
screws up  task_pt_regs(), which then breaks ptrace and friends?

... and you'd only notice it for users that use int3 in user space,
which now writes random locations on the kernel stack, which is then a
huge honking security hole.

It's possible that I'm confused, but let's not play random games with
the stack like this. The entry code is sacred, in scary ways.

So no. Do *not* try to change %rsp on the stack in the bp handler.
Instead, I'd suggest:

 - just restart the instruction (with the suggested "ptregs->rip --")

 - to avoid any "oh, we're not making progress" issues, just fix the
instruction yourself to be the right call, by looking it up in the
"what needs to be fixed" tables.

No?

              Linus

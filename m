Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0D1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D89214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TwOpg9fw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40D89214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbeKLObF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 09:31:05 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:54600 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbeKLObF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 09:31:05 -0500
Received: by mail-it1-f193.google.com with SMTP id a205-v6so5242547itd.4
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 20:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZjTRt0DT4A2OzPKlOCPUzd9PMvVAmqa/3ubknwqW0N4=;
        b=TwOpg9fwK0sUwHrlnuv5LGdZcq3VQXm1xP53pEKk0cEFeKcFaFHMhefspNYGWX1lg3
         YUXUlXCq8KPxH9OHS3HgK5aKrYte9PrAIGq9y1dcF6M1zpbqFjtZEl0pDg9+fB0UJQMp
         aW8PrTW7ZEzyd37PAZK5a9epxoBignyok6MwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZjTRt0DT4A2OzPKlOCPUzd9PMvVAmqa/3ubknwqW0N4=;
        b=QB9JNFO6ISx7DZPS/Nal9EWxH15vRLK8kgXKWh1qyae2YRLEtGCJzuL8uKnpPBbuYQ
         Fyoso8I1jEc+VXipTuu4DQnOh/pDr24IVF2tlsow/LHM9ulPrbtMyR+oMUH6kO3zkUJY
         VTgkgzjAnIYhSkKpz3yD+w1F04/CKZKoEL5NuMedUVtRfdspzAo9+yr/af1kCD87UK6V
         17jpTSd6NOXoUU4cuNX8j1/nY92Bg0kQMitS2u2rZCCK4vSXl7FNyr4EHRpeRHp8qXCr
         gPDC42ZPCpjh7BuT2hlMCijqcugYfp+mzaej6McNF56JYzjib15iXLbfsJFLBxn0hELy
         KZ0Q==
X-Gm-Message-State: AGRZ1gLj/e9IpwgYZa/84cUsUMi7BgGCpwHNLgwsqpR8KLwTCoRCFKgP
        9Vm2Am88bCiRhFqCnVVe2L8CWSDZ3n5qjk9r4QCyyLzf
X-Google-Smtp-Source: AJdET5fxIW511Fl4rO1XAVgEW2fPQGLvqxFvBhZzSq2gXO5SyDh9S31wFGcj6S2ez8kseZ/tBeRhZsjj6SUf2Fi+stc=
X-Received: by 2002:a24:2190:: with SMTP id e138-v6mr10878636ita.71.1541997579135;
 Sun, 11 Nov 2018 20:39:39 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:4f16:0:0:0:0:0 with HTTP; Sun, 11 Nov 2018 20:39:38
 -0800 (PST)
In-Reply-To: <20181112030722.da5cxslvlmdgttsw@treble>
References: <cover.1541711457.git.jpoimboe@redhat.com> <3cf04e113d71c9f8e4be95fb84a510f085aa4afa.1541711457.git.jpoimboe@redhat.com>
 <20181109133337.63487e3a@gandalf.local.home> <20181109193505.5p5iddrtgpk2cpb4@treble>
 <20181109145746.0037da3f@gandalf.local.home> <20181109203459.wbftlkxcvfnwo2bm@treble>
 <20181110001023.57f27312@vmware.local.home> <CAKv+Gu-y=O6=dSbCXSaMxkj7LxfL9txzJ4r8Bcf1U0G6JQNUng@mail.gmail.com>
 <20181110080917.29af5d66@vmware.local.home> <20181112030722.da5cxslvlmdgttsw@treble>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 12 Nov 2018 05:39:38 +0100
Message-ID: <CAKv+Gu-hs7cRjkAAzk7hUqoXWw1vQDvUGQaKnyALrPvW-TTLzA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] static_call: Add static call infrastructure
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 November 2018 at 04:07, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> On Sat, Nov 10, 2018 at 08:09:17AM -0500, Steven Rostedt wrote:
>> On Sat, 10 Nov 2018 12:58:08 +0100
>> Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>>
>>
>> > > The complaint is on:
>> > >
>> > >         DEFINE_STATIC_CALL(__tp_func_##name, __tracepoint_iter_##name);
>> > >
>> > > And the previous definition is on:
>> > >
>> > >         DECLARE_STATIC_CALL(__tp_func_##name, __tracepoint_iter_##name); \
>> > >
>> >
>> > Does the DECLARE really need the __ADDRESSABLE? Its purpose is to
>> > ensure that symbols with static linkage are not optimized away, but
>> > since the reference is from a header file, the symbol should have
>> > external linkage anyway.
>
> Yes, DECLARE needs the __ADDRESSABLE.  In the case where DECLARE
> is used, but DEFINE is not, GCC strips the symbol.
>

I assume DECLARE() is intended for use in header files, and DEFINE()
for source files, no?

Doesn't that mean that whatever symbol __ADDRESSABLE() refers to
should have external linkage, in which case it it addressable anyway?
Or are we talking about some LTO / --gc-sections use case here?

>> I applied the following change and it compiled fine:
>>
>> diff --git a/include/linux/static_call.h b/include/linux/static_call.h
>> index 90b580b95303..5f8a0f0e77be 100644
>> --- a/include/linux/static_call.h
>> +++ b/include/linux/static_call.h
>> @@ -108,8 +108,6 @@ extern void arch_static_call_poison_tramp(unsigned long insn);
>>  #define DECLARE_STATIC_CALL(key, func)                                       \
>>       extern struct static_call_key key;                              \
>>       extern typeof(func) STATIC_CALL_TRAMP(key);                     \
>> -     /* Preserve the ELF symbol so objtool can access it: */         \
>> -     __ADDRESSABLE(key)
>>
>>  #define DEFINE_STATIC_CALL(key, _func)                                       \
>>       DECLARE_STATIC_CALL(key, _func);                                \
>> @@ -117,7 +115,9 @@ extern void arch_static_call_poison_tramp(unsigned long insn);
>>               .func = _func,                                          \
>>               .site_mods = LIST_HEAD_INIT(key.site_mods),             \
>>       };                                                              \
>> -     ARCH_STATIC_CALL_TEMPORARY_TRAMP(key)
>> +     ARCH_STATIC_CALL_TEMPORARY_TRAMP(key);                          \
>> +     /* Preserve the ELF symbol so objtool can access it: */         \
>> +     __ADDRESSABLE(key)
>>
>>  #define static_call(key, args...) STATIC_CALL_TRAMP(key)(args)
>
> Adding __ADDRESSABLE to the DEFINE macro doesn't do any good.  By
> definition, the key is defined in the .o file, so the symbol already
> exists.
>
> The issue you're seeing is really an issue with the __ADDRESSABLE macro
> not creating unique symbol names.  This should fix it:
>
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 06396c1cf127..4bb73fd918b5 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -282,7 +282,7 @@ unsigned long read_word_at_a_time(const void *addr)
>   */
>  #define __ADDRESSABLE(sym) \
>         static void * __section(".discard.addressable") __used \
> -               __PASTE(__addressable_##sym, __LINE__) = (void *)&sym;
> +               __UNIQUE_ID(__addressable_##sym) = (void *)&sym;
>
>  /**
>   * offset_to_ptr - convert a relative memory offset to an absolute pointer

Not sure if it matters, but we'll end up with a lot more stuff in
.discard.addressable this way.

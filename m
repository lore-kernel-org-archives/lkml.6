Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B216DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F4522081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="icbexm/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F4522081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730530AbeK2RKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:10:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:51344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729229AbeK2RKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:10:21 -0500
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4772214F1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 06:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471568;
        bh=4VrUn6on3Uyzy/mpX10qWMuJIGb0880FsnwDxMhS7wc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=icbexm/Nz581BgreIEnW1F+suBrPLwO6XZae2+szGibL0aQDHilEADEdwUZiS2D5z
         8JybSKCNIp4GIo7Xo3Y3FENHY3P84cXFzdc5BG8+iv/vSCdBsuSOQNcyz99plASqqP
         w5uOi2bGrB/3EkyyxQQ3u3SHo9sbYFfFyA56aQxg=
Received: by mail-wm1-f51.google.com with SMTP id k198so914019wmd.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 22:06:07 -0800 (PST)
X-Gm-Message-State: AA+aEWYiGgP1C1OLgZsaYMxBiUQc7aTcvmx+6my0h/nFmD4flJ+pGZsq
        9KagAr7d3HZOF5xroEyWBEOMBjzjf8A88DqjM3l1OA==
X-Google-Smtp-Source: AFSGD/XrjNh6HKjpPn1Ci5F6J+RnhnMEWdhky1GXgPSz2PQqB3R5yVS+xsN0/y2MYaLHo+iGw8fQAorNjm4ynyhzpJ8=
X-Received: by 2002:a7b:ce11:: with SMTP id m17mr495132wmc.74.1543471566155;
 Wed, 28 Nov 2018 22:06:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1543200841.git.jpoimboe@redhat.com> <62188c62f6dda49ca2e20629ee8e5a62a6c0b500.1543200841.git.jpoimboe@redhat.com>
 <20181126160217.GR2113@hirez.programming.kicks-ass.net> <20181126171036.chcbmb35ygpxziub@treble>
 <20181126175624.bruqfbkngbucpvxr@treble> <20181126200801.GW2113@hirez.programming.kicks-ass.net>
 <20181126212628.4apztfazichxnt7r@treble> <20181127084330.GX2113@hirez.programming.kicks-ass.net>
In-Reply-To: <20181127084330.GX2113@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 28 Nov 2018 22:05:54 -0800
X-Gmail-Original-Message-ID: <CALCETrXam8JBtXE3S97Vyb_=+pmjgr23SoZ-Dm5pmYtwZYA+7Q@mail.gmail.com>
Message-ID: <CALCETrXam8JBtXE3S97Vyb_=+pmjgr23SoZ-Dm5pmYtwZYA+7Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Lutomirski <luto@kernel.org>,
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Nov 27, 2018, at 12:43 AM, Peter Zijlstra <peterz@infradead.org> wrote=
:
>
>> On Mon, Nov 26, 2018 at 03:26:28PM -0600, Josh Poimboeuf wrote:
>>
>> Yeah, that's probably better.  I assume you also mean that we would have
>> all text_poke_bp() users create a handler callback?  That way the
>> interface is clear and consistent for everybody.  Like:
>
> Can do, it does indeed make the interface less like a hack. It is not
> like there are too many users.
>
>> diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
>> index aac0c1f7e354..d4b0abe4912d 100644
>> --- a/arch/x86/kernel/jump_label.c
>> +++ b/arch/x86/kernel/jump_label.c
>> @@ -37,6 +37,11 @@ static void bug_at(unsigned char *ip, int line)
>>    BUG();
>> }
>>
>> +static inline void jump_label_bp_handler(struct pt_regs *regs, void *da=
ta)
>> +{
>> +    regs->ip +=3D JUMP_LABEL_NOP_SIZE - 1;
>> +}
>> +
>> static void __ref __jump_label_transform(struct jump_entry *entry,
>>                     enum jump_label_type type,
>>                     void *(*poker)(void *, const void *, size_t),
>> @@ -91,7 +96,7 @@ static void __ref __jump_label_transform(struct jump_e=
ntry *entry,
>>    }
>>
>>    text_poke_bp((void *)jump_entry_code(entry), code, JUMP_LABEL_NOP_SIZ=
E,
>> -             (void *)jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
>> +             jump_label_bp_handler, NULL);
>> }
>>
>> void arch_jump_label_transform(struct jump_entry *entry,
>
> Per that example..
>
>> diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call=
.c
>> index d3869295b88d..e05ebc6d4db5 100644
>> --- a/arch/x86/kernel/static_call.c
>> +++ b/arch/x86/kernel/static_call.c
>> @@ -7,24 +7,30 @@
>>
>> #define CALL_INSN_SIZE 5
>>
>> +struct static_call_bp_data {
>> +    unsigned long func, ret;
>> +};
>> +
>> +static void static_call_bp_handler(struct pt_regs *regs, void *_data)
>> +{
>> +    struct static_call_bp_data *data =3D _data;
>> +
>> +    /*
>> +     * For inline static calls, push the return address on the stack so=
 the
>> +     * "called" function will return to the location immediately after =
the
>> +     * call site.
>> +     *
>> +     * NOTE: This code will need to be revisited when kernel CET gets
>> +     *       implemented.
>> +     */
>> +    if (data->ret) {
>> +        regs->sp -=3D sizeof(long);
>> +        *(unsigned long *)regs->sp =3D data->ret;
>> +    }

You can=E2=80=99t do this.  Depending on the alignment of the old RSP, whic=
h
is not guaranteed, this overwrites regs->cs.  IRET goes boom.

Maybe it could be fixed by pointing regs->ip at a real trampoline?

This code is subtle and executed rarely, which is a bag combination.
It would be great if we had a test case.

I think it would be great if the implementation could be, literally:

regs->ip -=3D 1;
return;

IOW, just retry and wait until we get the new patched instruction.
The problem is that, if we're in a context where IRQs are off, then
we're preventing on_each_cpu() from completing and, even if we somehow
just let the code know that we already serialized ourselves, we're
still potentially holding a spinlock that another CPU is waiting for
with IRQs off.  Ugh.  Anyone have a clever idea to fix that?

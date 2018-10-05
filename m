Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9190C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F482205C9
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCjD4u9L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F482205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbeJFBBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 21:01:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbeJFBBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 21:01:02 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43512214C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Oct 2018 18:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538762472;
        bh=mu5NgnhwcBDogvrb3TYThtKFmNUUWGyoW1uh1XmVZcs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bCjD4u9L0vSic4sBpQ8Ht5wKnBMC6i/KCelyeOgvCsGUj9HxjsaT2vRwHBwEEgNki
         FiurOQDvrusn/Y+FgDpQJwWt7JBotqa4dqZwI3Pffhd9Tp4kYxj/ejO7Me/w121BJf
         BIg2EQcpykvj8yA68XOvG7L6RVkC/X9zPhvsxkTQ=
Received: by mail-wm1-f41.google.com with SMTP id 206-v6so2635508wmb.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 11:01:12 -0700 (PDT)
X-Gm-Message-State: ABuFfoiarHIbIbyzsaOgJ21t/Sf7+5DW5+RBoaeNUvKkM17tTgWaha9C
        eN3xWWm1JHkXUGTy+O5lQ4ROYCYnJFa5Oo0C13FnRA==
X-Google-Smtp-Source: ACcGV63lelnILluiu5cNDyOMHE2LUkUJYewQrkQmxVhMfkPssZQvbAoMaqLMg0bwA+X/o6TeUY5Am+ef59g+cPF6Qzc=
X-Received: by 2002:a1c:1fcd:: with SMTP id f196-v6mr8665998wmf.19.1538762470521;
 Fri, 05 Oct 2018 11:01:10 -0700 (PDT)
MIME-Version: 1.0
References: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
 <20181005133705.GA4588@zx2c4.com> <CAKv+Gu-f4uKBF=gtFcNJEeoC2L4qShX0+3p7kVhjTn0tR+3Gng@mail.gmail.com>
 <CALCETrVxv1fHt6WE4ZpvVEwtfsKQ19gRrhhA40zwCXGMk+DTLQ@mail.gmail.com> <CAKv+Gu_fFvoXmWscnx=dF7ovc2qXJgBnDte3Z8Co9Y4TzDfwbQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu_fFvoXmWscnx=dF7ovc2qXJgBnDte3Z8Co9Y4TzDfwbQ@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 5 Oct 2018 11:00:58 -0700
X-Gmail-Original-Message-ID: <CALCETrXv5vYxV+R4xAiKXMgHYeeDE5y4_Oj8Jx6pFiFq5+tXOQ@mail.gmail.com>
Message-ID: <CALCETrXv5vYxV+R4xAiKXMgHYeeDE5y4_Oj8Jx6pFiFq5+tXOQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] patchable function pointers for pluggable crypto routines
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>, Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Weinberger <richard@nod.at>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 10:28 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On 5 October 2018 at 19:26, Andy Lutomirski <luto@kernel.org> wrote:
> > On Fri, Oct 5, 2018 at 10:15 AM Ard Biesheuvel
> > <ard.biesheuvel@linaro.org> wrote:
> >>
> >> On 5 October 2018 at 15:37, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >> ...
> >> > Therefore, I think this patch goes in exactly the wrong direction. I
> >> > mean, if you want to introduce dynamic patching as a means for making
> >> > the crypto API's dynamic dispatch stuff not as slow in a post-spectre
> >> > world, sure, go for it; that may very well be a good idea. But
> >> > presenting it as an alternative to Zinc very widely misses the point and
> >> > serves to prolong a series of bad design choices, which are now able to
> >> > be rectified by putting energy into Zinc instead.
> >> >
> >>
> >> This series has nothing to do with dynamic dispatch: the call sites
> >> call crypto functions using ordinary function calls (although my
> >> example uses CRC-T10DIF), and these calls are redirected via what is
> >> essentially a PLT entry, so that we can supsersede those routines at
> >> runtime.
> >
> > If you really want to do it PLT-style, then just do:
> >
> > extern void whatever_func(args);
> >
> > Call it like:
> > whatever_func(args here);
> >
> > And rig up something to emit asm like:
> >
> > GLOBAL(whatever_func)
> >   jmpq default_whatever_func
> > ENDPROC(whatever_func)
> >
> > Architectures without support can instead do:
> >
> > void whatever_func(args)
> > {
> >   READ_ONCE(patchable_function_struct_for_whatever_func->ptr)(args);
> > }
> >
> > and patch the asm function for basic support.  It will be slower than
> > necessary, but maybe the relocation trick could be used on top of this
> > to redirect the call to whatever_func directly to the target for
> > architectures that want to squeeze out the last bit of performance.
> > This might actually be the best of all worlds: easy implementation on
> > all architectures, no inline asm, and the totally non-magical version
> > works with okay performance.
> >
> > (Is this what your code is doing?  I admit I didn't follow all the way
> > through all the macros.)
>
> Basically

Adding Josh Poimboeuf.

Here's a sketch of how this could work for better performance.  For a
static call "foo" that returns void and takes no arguments, the
generic implementation does something like this:

extern void foo(void);

struct static_call {
  void (*target)(void);

  /* arch-specific part containing an array of struct static_call_site */
};

void foo(void)
{
  READ_ONCE(__static_call_foo->target)();
}

Arch code overrides it to:

GLOBAL(foo)
  jmpq *__static_call_foo(%rip)
ENDPROC(foo)

and some extra asm to emit a static_call_site object saying that the
address "foo" is a jmp/call instruction where the operand is at offset
1 into the instruction.  (Or whatever the offset is.)

The patch code is like:

void set_static_call(struct static_call *call, void *target)
{
  /* take a spinlock? */
  WRITE_ONCE(call->target, target);
  arch_set_static_call(call, target);
}

and the arch code patches the call site if needed.

On x86, an even better implementation would have objtool make a bunch
of additional static_call_site objects for each call to foo, and
arch_set_static_call() would update all of them, too.  Using
text_poke_bp() if needed, and "if needed" can maybe be clever and
check the alignment of the instruction.  I admit that I never actually
remember the full rules for atomically patching an instruction on x86
SMP.  (Hmm.  This will be really epically slow.  Maybe we don't care.
Or we could finally optimize text_poke, etc to take a list of pokes to
do and do them as a batch.  But that's not a prerequisite for the rest
of this.)

What do you all think?

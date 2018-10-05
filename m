Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7DAC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7F521473
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ImiaXwot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7F521473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbeJFAXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 20:23:05 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:36658 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbeJFAXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 20:23:04 -0400
Received: by mail-it1-f194.google.com with SMTP id c85-v6so3796513itd.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 10:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nKIcHcj4VLihwnehuDMa/7jLvdFNBm7BBQ9E0Fn1km0=;
        b=ImiaXwothBeNxt0ytccOnoa6aVzfwERiZ9ea/DUhg4tEOpsvNdBJos9DYv8lzwy74s
         HnDWqqi3dBr+Zkc6mzKbK3r7bC2YbXSAxA/fU2R1GMI0U5c7Yf6yYeZxqAM0qfD2Nv2G
         QznafJPRqshALmXd0o7qdTR2uqc2zJwcpc4aI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nKIcHcj4VLihwnehuDMa/7jLvdFNBm7BBQ9E0Fn1km0=;
        b=iDh+tOQb/saBhStiJAIQ8VC0MtJ2Z/vg1+tEmj/kONu9d9UtOGRQlDO6/SSDZl67ed
         TZhCD1GsRBDVrbI+nJR+W4Z1ms0zMlsrK5l34rgARKa9oQksk7byzWLVWJXOfjvjh2Rc
         m+x3uY76/ZFz4qe8ZTYiSH+wSVqqAOjtPoQOtguAprtsE97selsghZ06GfkGAL4M0JAf
         6jGaJts1rkGONhjSPQSrgpHMh8w4AHxrVPxR4e1bOKT0dZhEQiyseIXSWXCo8JZ/FOT8
         p1P4z/b+nEkV1xGHQYS+IiXekQCa8vf7wM2pwE8dFichMXiYHHxz7SQYFV4pQVPGqEBL
         x9Cg==
X-Gm-Message-State: ABuFfohra3+lLhZSUerAqEmdWPZjGlC1h5un44HgBAYCIC+ylkw6dHSi
        lDxu+pz9KxLBl/Frw7v6vHihyEf0QlBlu9iCfcCoxA==
X-Google-Smtp-Source: ACcGV62iTEx3KMnRbakLtt+hprzaBCa/Pt4RA6C9OG7HjGikt3PY/6J2hFlEWtZjx3dF0D9ECIYaAUPdpwjEHMrEN4c=
X-Received: by 2002:a24:a10b:: with SMTP id y11-v6mr5195415ite.148.1538760203373;
 Fri, 05 Oct 2018 10:23:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:5910:0:0:0:0:0 with HTTP; Fri, 5 Oct 2018 10:23:22 -0700 (PDT)
In-Reply-To: <CALCETrU=fm+ZG4WZJfG-5GwL7kv5_GS1aZYu=L42d5BuSbhJDQ@mail.gmail.com>
References: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
 <20181005081333.15018-2-ard.biesheuvel@linaro.org> <20181005141433.GS19272@hirez.programming.kicks-ass.net>
 <9E0E08C8-0DFC-4E50-A4FA-73208835EF9E@amacapital.net> <CAKv+Gu9z503ZJXcsG+9Ys240BZiB-+GB=kNY4VGWpjvdzN4JtA@mail.gmail.com>
 <CALCETrWaewXsdJsf3SocgZ0ggnvZk86L+5-LWPRbjdnG2mB7jw@mail.gmail.com>
 <CAKv+Gu-oHBtgGbWXJu6+z4+BNhBZyY5VvF_v6cJJUGk_5YX1eQ@mail.gmail.com> <CALCETrU=fm+ZG4WZJfG-5GwL7kv5_GS1aZYu=L42d5BuSbhJDQ@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 5 Oct 2018 19:23:22 +0200
Message-ID: <CAKv+Gu8eHPEsUbkhN=61z9FvhdCo2e3VOdemp4g0bzdO1EJFYQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/9] kernel: add support for patchable function pointers
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
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
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 October 2018 at 19:20, Andy Lutomirski <luto@kernel.org> wrote:
> On Fri, Oct 5, 2018 at 10:11 AM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>>
>> On 5 October 2018 at 18:58, Andy Lutomirski <luto@kernel.org> wrote:
>> > On Fri, Oct 5, 2018 at 8:24 AM Ard Biesheuvel <ard.biesheuvel@linaro.o=
rg> wrote:
>> >>
>> >> On 5 October 2018 at 17:08, Andy Lutomirski <luto@amacapital.net> wro=
te:
>> >> >
>> >> >
>> >> >> On Oct 5, 2018, at 7:14 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>> >> >>
>> >> >>> On Fri, Oct 05, 2018 at 10:13:25AM +0200, Ard Biesheuvel wrote:
>> >> >>> diff --git a/include/linux/ffp.h b/include/linux/ffp.h
>> >> >>> new file mode 100644
>> >> >>> index 000000000000..8fc3b4c9b38f
>> >> >>> --- /dev/null
>> >> >>> +++ b/include/linux/ffp.h
>> >> >>> @@ -0,0 +1,43 @@
>> >> >>> +/* SPDX-License-Identifier: GPL-2.0 */
>> >> >>> +
>> >> >>> +#ifndef __LINUX_FFP_H
>> >> >>> +#define __LINUX_FFP_H
>> >> >>> +
>> >> >>> +#include <linux/types.h>
>> >> >>> +#include <linux/compiler.h>
>> >> >>> +
>> >> >>> +#ifdef CONFIG_HAVE_ARCH_FFP
>> >> >>> +#include <asm/ffp.h>
>> >> >>> +#else
>> >> >>> +
>> >> >>> +struct ffp {
>> >> >>> +    void    (**fn)(void);
>> >> >>> +    void    (*default_fn)(void);
>> >> >>> +};
>> >> >>> +
>> >> >>> +#define DECLARE_FFP(_fn, _def)                        \
>> >> >>> +    extern typeof(_def) *_fn;                    \
>> >> >>> +    extern struct ffp const __ffp_ ## _fn
>> >> >>> +
>> >> >>> +#define DEFINE_FFP(_fn, _def)                        \
>> >> >>> +    typeof(_def) *_fn =3D &_def;                    \
>> >> >>> +    struct ffp const __ffp_ ## _fn                    \
>> >> >>> +        =3D { (void(**)(void))&_fn, (void(*)(void))&_def };    \
>> >> >>> +    EXPORT_SYMBOL(__ffp_ ## _fn)
>> >> >>> +
>> >> >>> +static inline void ffp_set_target(const struct ffp *m, void *new=
_fn)
>> >> >>> +{
>> >> >>> +    WRITE_ONCE(*m->fn, new_fn);
>> >> >>> +}
>> >> >>> +
>> >> >>> +static inline void ffp_reset_target(const struct ffp *m)
>> >> >>> +{
>> >> >>> +    WRITE_ONCE(*m->fn, m->default_fn);
>> >> >>> +}
>> >> >>> +
>> >> >>> +#endif
>> >> >>> +
>> >> >>> +#define SET_FFP(_fn, _new)    ffp_set_target(&__ffp_ ## _fn, _ne=
w)
>> >> >>> +#define RESET_FFP(_fn)        ffp_reset_target(&__ffp_ ## _fn)
>> >> >>> +
>> >> >>> +#endif
>> >> >>
>> >> >> I don't understand this interface. There is no wrapper for the cal=
l
>> >> >> site, so how are we going to patch all call-sites when you update =
the
>> >> >> target?
>> >> >
>> >> > I=E2=80=99m also confused.
>> >> >
>> >> > Anyway, we have patchable functions on x86. They=E2=80=99re called =
PVOPs, and they=E2=80=99re way overcomplicated.
>> >> >
>> >> > I=E2=80=99ve proposed a better way that should generate better code=
, be more portable, and be more maintainable.  It goes like this.
>> >> >
>> >> > To call the function, you literally just call  the default implemen=
tation.  It *might* be necessary to call a nonexistent wrapper to avoid ann=
oying optimizations. At build time, the kernel is built with relocations, s=
o the object files contain relocation entries for the call. We collect thes=
e entries into a table. If we=E2=80=99re using the =E2=80=9Cnonexistent wra=
pper=E2=80=9D approach, we can link in a .S or linker script to alias them =
to the default implementation.
>> >> >
>> >> > To patch them, we just patch them. It can=E2=80=99t necessarily be =
done concurrently because nothing forces the right alignment. But we can do=
 it at boot time and module load time. (Maybe we can patch at runtime on ar=
chitectures with appropriate instruction alignment.  Or we ask gcc for an e=
xtension to align calls to a function.)
>> >> >
>> >> > Most of the machinery already exists: this is roughly how the modul=
e loader resolves calls outside of a module.
>> >>
>> >> Yeah nothing is ever simple on x86 :-(
>> >>
>> >> So are you saying the approach i use in patch #2 (which would
>> >> translate to emitting a jmpq instruction pointing to the default
>> >> implementation, and patching it at runtime to point elsewhere) would
>> >> not fly on x86?
>> >
>> > After getting some more sleep, I'm obviously wrong.  The
>> > text_poke_bp() mechanism will work.  It's just really slow.
>> >
>>
>> OK
>>
>> > Let me try to summarize some of the issues.  First, when emitting
>> > jumps and calls from inline asm on x86, there are a few considerations
>> > that are annoying:
>> >
>> > 1. Following the x86_64 ABI calling conventions is basically
>> > impossible.  x86_64 requires a 128-byte redzone and 16-byte stack
>> > alignment.  After much discussion a while back, we decided that it was
>> > flat-out impossible on current gcc to get the stack pointer aligned in
>> > a known manner in an inline asm statement.  Instead, if we actually
>> > need alignment, we need to align manually.  Fortunately, the kernel is
>> > built with an override that forces only 8-byte alignment (on *most*
>> > GCC versions).  But for crypto in particular, it sucks extra, since
>> > the crypto code is basically the only thing in the kernel that
>> > actually wants 16-byte alignment.  I don't think this is a huge
>> > problem in practice, but it's annoying.  And the kernel is built
>> > without a redzone.
>> >
>> > 2. On x86_64, depending on config, we either need frame pointers or
>> > ORC.  ORC is no big deal -- it Just Works (tm).  Frame pointers need
>> > extra asm hackery.  It's doable, but it's still annoying.
>> >
>> > 3. Actually getting the asm constraints right to do what a C
>> > programmer expects is distinctly nontrivial.  I just fixed an
>> > extremely longstanding bug in the vDSO code in which the asm
>> > constraints for the syscall fallback were wrong in such a way that GCC
>> > didn't notice that the fallback wrote to its output parameter.
>> > Whoops.
>> >
>>
>> OK, so the thing I am missing is why this all matters.
>>
>> Note that the compiler should take care of all of this. It emits a
>> call a function with external linkage having prototype X, and all the
>> inline asm does is emit a jmp to some function having that same
>> prototype, either the default one or the one we patched in.
>>
>> Apologies if I am missing something obvious here: as you know, x86 is
>> not my focus in general.
>
> The big issue that bothers me isn't the x86-ism so much as the nasty
> interactions with the optimizer.  On x86, we have all of this working.
> It's in arch/x86/include/asm/paravirt_types.h, and it looks roughly
> like:
>
>                         asm volatile(pre                                \
>                                      paravirt_alt(PARAVIRT_CALL)        \
>                                      post                               \
>                                      : call_clbr, ASM_CALL_CONSTRAINT   \
>                                      : paravirt_type(op),               \
>                                        paravirt_clobber(clbr),          \
>                                        ##__VA_ARGS__                    \
>                                      : "memory", "cc" extra_clbr);      \
>
> With some extra magic for the constraints.  And I don't even think
> this is strictly correct -- from very recent experience, telling the
> compiler that "memory" is clobbered and that a bunch of arguments are
> used as numeric inputs may not actually imply that the asm modifies
> the target of pointer arguments.  Checks this lovely bug out:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=
=3Dx86/vdso-tglx&id=3D715bd9d12f84d8f5cc8ad21d888f9bc304a8eb0b
>
> As far as I can tell, the whole PVOP infrastructure has the same bug.
> And I don't see how to avoid it generically on x86 or any other
> architecture.  (PeterZ, am I wrong?  Are we really just getting lucky
> that x86 pvop calls actually work?  Or do we not have enough of them
> that take pointers as arguments for this to matter?)
>
> Plus, asm volatile ( ..., "memory" ) is a barrier and makes code
> generation suck.
>
> Whereas, if we use my suggestion the semantics are precisely those of
> any other C function call because, as far as GCC is concerned, it *is*
> a C function call.  So the generated code *is* a function call.
>

But it is the *compiler* that actually emits the call.

Only, the target of that call is a jmpq to another location where some
version of the routine lives, and all have the same prototype.

How is that any different from PLTs in shared libraries?

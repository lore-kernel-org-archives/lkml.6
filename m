Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B23C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F8D2098A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uo2WBb1U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F8D2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbeJEX6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:58:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727572AbeJEX6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:58:11 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1EBE214D5
        for <linux-kernel@vger.kernel.org>; Fri,  5 Oct 2018 16:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538758717;
        bh=zwkzpfw0iYWbl/FnGz/l6ID7/PlZzOAMUSxipz/EpQ0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uo2WBb1UC/3jFt9gjhICi8ePf+KC6Htt374/R+Q9mUBQrfkzAkj5qlGzgsU7rs/Vd
         QykfBeoj6PMd9cUV6MX1XEtMzoXYVcOUh4AotXjVCG3Nft8MDPtFJo9EphKGQcMzgm
         J63MQPCKUI2a4fX+FgMkqfQl+i8BOAV9tg7xA578=
Received: by mail-wr1-f46.google.com with SMTP id y11-v6so3519262wrd.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 09:58:36 -0700 (PDT)
X-Gm-Message-State: ABuFfoiIXcNPLKkqx7NkIET6L9VxigNMeRS0Bi7OIjMvw71EvbD9o0uo
        ng4hqRZMHgp/KSTjwk6uNT4du7DCqrHdMigi9QofIw==
X-Google-Smtp-Source: ACcGV62uk7ckJnpdgqeoNL0UBJm77+Xv0FDKPW4NLAaUAgP5XZXLDeLGu+M/eMmQPIPTrpMILcDhcjaCHLnpdBA4T4w=
X-Received: by 2002:a5d:610a:: with SMTP id v10-v6mr2941835wrt.308.1538758714875;
 Fri, 05 Oct 2018 09:58:34 -0700 (PDT)
MIME-Version: 1.0
References: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
 <20181005081333.15018-2-ard.biesheuvel@linaro.org> <20181005141433.GS19272@hirez.programming.kicks-ass.net>
 <9E0E08C8-0DFC-4E50-A4FA-73208835EF9E@amacapital.net> <CAKv+Gu9z503ZJXcsG+9Ys240BZiB-+GB=kNY4VGWpjvdzN4JtA@mail.gmail.com>
In-Reply-To: <CAKv+Gu9z503ZJXcsG+9Ys240BZiB-+GB=kNY4VGWpjvdzN4JtA@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 5 Oct 2018 09:58:23 -0700
X-Gmail-Original-Message-ID: <CALCETrWaewXsdJsf3SocgZ0ggnvZk86L+5-LWPRbjdnG2mB7jw@mail.gmail.com>
Message-ID: <CALCETrWaewXsdJsf3SocgZ0ggnvZk86L+5-LWPRbjdnG2mB7jw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/9] kernel: add support for patchable function pointers
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
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

On Fri, Oct 5, 2018 at 8:24 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> w=
rote:
>
> On 5 October 2018 at 17:08, Andy Lutomirski <luto@amacapital.net> wrote:
> >
> >
> >> On Oct 5, 2018, at 7:14 AM, Peter Zijlstra <peterz@infradead.org> wrot=
e:
> >>
> >>> On Fri, Oct 05, 2018 at 10:13:25AM +0200, Ard Biesheuvel wrote:
> >>> diff --git a/include/linux/ffp.h b/include/linux/ffp.h
> >>> new file mode 100644
> >>> index 000000000000..8fc3b4c9b38f
> >>> --- /dev/null
> >>> +++ b/include/linux/ffp.h
> >>> @@ -0,0 +1,43 @@
> >>> +/* SPDX-License-Identifier: GPL-2.0 */
> >>> +
> >>> +#ifndef __LINUX_FFP_H
> >>> +#define __LINUX_FFP_H
> >>> +
> >>> +#include <linux/types.h>
> >>> +#include <linux/compiler.h>
> >>> +
> >>> +#ifdef CONFIG_HAVE_ARCH_FFP
> >>> +#include <asm/ffp.h>
> >>> +#else
> >>> +
> >>> +struct ffp {
> >>> +    void    (**fn)(void);
> >>> +    void    (*default_fn)(void);
> >>> +};
> >>> +
> >>> +#define DECLARE_FFP(_fn, _def)                        \
> >>> +    extern typeof(_def) *_fn;                    \
> >>> +    extern struct ffp const __ffp_ ## _fn
> >>> +
> >>> +#define DEFINE_FFP(_fn, _def)                        \
> >>> +    typeof(_def) *_fn =3D &_def;                    \
> >>> +    struct ffp const __ffp_ ## _fn                    \
> >>> +        =3D { (void(**)(void))&_fn, (void(*)(void))&_def };    \
> >>> +    EXPORT_SYMBOL(__ffp_ ## _fn)
> >>> +
> >>> +static inline void ffp_set_target(const struct ffp *m, void *new_fn)
> >>> +{
> >>> +    WRITE_ONCE(*m->fn, new_fn);
> >>> +}
> >>> +
> >>> +static inline void ffp_reset_target(const struct ffp *m)
> >>> +{
> >>> +    WRITE_ONCE(*m->fn, m->default_fn);
> >>> +}
> >>> +
> >>> +#endif
> >>> +
> >>> +#define SET_FFP(_fn, _new)    ffp_set_target(&__ffp_ ## _fn, _new)
> >>> +#define RESET_FFP(_fn)        ffp_reset_target(&__ffp_ ## _fn)
> >>> +
> >>> +#endif
> >>
> >> I don't understand this interface. There is no wrapper for the call
> >> site, so how are we going to patch all call-sites when you update the
> >> target?
> >
> > I=E2=80=99m also confused.
> >
> > Anyway, we have patchable functions on x86. They=E2=80=99re called PVOP=
s, and they=E2=80=99re way overcomplicated.
> >
> > I=E2=80=99ve proposed a better way that should generate better code, be=
 more portable, and be more maintainable.  It goes like this.
> >
> > To call the function, you literally just call  the default implementati=
on.  It *might* be necessary to call a nonexistent wrapper to avoid annoyin=
g optimizations. At build time, the kernel is built with relocations, so th=
e object files contain relocation entries for the call. We collect these en=
tries into a table. If we=E2=80=99re using the =E2=80=9Cnonexistent wrapper=
=E2=80=9D approach, we can link in a .S or linker script to alias them to t=
he default implementation.
> >
> > To patch them, we just patch them. It can=E2=80=99t necessarily be done=
 concurrently because nothing forces the right alignment. But we can do it =
at boot time and module load time. (Maybe we can patch at runtime on archit=
ectures with appropriate instruction alignment.  Or we ask gcc for an exten=
sion to align calls to a function.)
> >
> > Most of the machinery already exists: this is roughly how the module lo=
ader resolves calls outside of a module.
>
> Yeah nothing is ever simple on x86 :-(
>
> So are you saying the approach i use in patch #2 (which would
> translate to emitting a jmpq instruction pointing to the default
> implementation, and patching it at runtime to point elsewhere) would
> not fly on x86?

After getting some more sleep, I'm obviously wrong.  The
text_poke_bp() mechanism will work.  It's just really slow.

Let me try to summarize some of the issues.  First, when emitting
jumps and calls from inline asm on x86, there are a few considerations
that are annoying:

1. Following the x86_64 ABI calling conventions is basically
impossible.  x86_64 requires a 128-byte redzone and 16-byte stack
alignment.  After much discussion a while back, we decided that it was
flat-out impossible on current gcc to get the stack pointer aligned in
a known manner in an inline asm statement.  Instead, if we actually
need alignment, we need to align manually.  Fortunately, the kernel is
built with an override that forces only 8-byte alignment (on *most*
GCC versions).  But for crypto in particular, it sucks extra, since
the crypto code is basically the only thing in the kernel that
actually wants 16-byte alignment.  I don't think this is a huge
problem in practice, but it's annoying.  And the kernel is built
without a redzone.

2. On x86_64, depending on config, we either need frame pointers or
ORC.  ORC is no big deal -- it Just Works (tm).  Frame pointers need
extra asm hackery.  It's doable, but it's still annoying.

3. Actually getting the asm constraints right to do what a C
programmer expects is distinctly nontrivial.  I just fixed an
extremely longstanding bug in the vDSO code in which the asm
constraints for the syscall fallback were wrong in such a way that GCC
didn't notice that the fallback wrote to its output parameter.
Whoops.

And having all this asm hackery per architecture is ugly and annoying.

So my suggestion is to do it like a regular relocation.  Call a
function the normal way (make it literally be a C function and call
it), and rig up the noinline and noclone attributes and whatever else
is needed to make sure that it's a *relocatable* call.  Then the
toolchain emits ELF relocations saying exactly what part of the text
needs patching, and we can patch it at runtime.  On x86, this is a bit
extra annoying because we can't fully reliably parse backwards to find
the beginning of the instruction, but objtool could doit.

And then we get something that is mostly arch-neutral!  Because surely
ARM can also use a relocation-based mechanism.

I will generally object to x86 containing more than one
inline-asm-hackery-based patchable call mechanism, which your series
will add.  I would *love* to see a non-inline-asm one, and then we
could move most of the x86 paravirt crap over to use it for a big win
in readability and maintainability.

--Andy

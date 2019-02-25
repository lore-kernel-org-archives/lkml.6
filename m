Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_QP_LONG_LINE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E25C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DAC920663
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="iQb/5WSm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfBYPg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 10:36:27 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40535 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbfBYPg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 10:36:26 -0500
Received: by mail-pf1-f195.google.com with SMTP id h1so4662982pfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 07:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Qe+IVDkuWKSRxzAKPE16Ky2OCPsnHiwLi8d9RolXnfI=;
        b=iQb/5WSmjcOtEKCrapUAGOE2G86cXohBP6lIoAtCpMeYr447LHPao/CDatxCJoNsFu
         U+TWW9l5NuYzZ8U1eUdyhulKD7W5KoP/okpxQFRRaCz/xCuACe+cZNDx2/AKsFAaax2S
         i2UibU12vp9j9g4iLZ9Dhyu7Bip+CAZfoXG9Uq3OS0+grxHAchambperluSiwv0oIR4G
         9U9fy+rcrpt/3cd/o9UZkwiBZgVWGrfwP/mGQ0OPpQi4RL5b6t33/okk/BNYFusJWKLw
         EP9xi4mO+8jzoOXBI5BPVC8LQIBP4i+EAYH5FB797kKOEEOsSI4SRmUcGpz/pzWVJjWU
         Jb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Qe+IVDkuWKSRxzAKPE16Ky2OCPsnHiwLi8d9RolXnfI=;
        b=Z/cT7kMYstiabvx+cXupNNToLDNp6ZkMjVclfXkFzrz8kZcodV5Nbm9AchV8zWIBGs
         fjO+YYKFOsNvI8ObCLzEQXApkMhUi3twkp7sl5s8zI9QoYMkAUCiD9tda6F2uF3Ze21E
         wOXWiiw3jZTX92aHZxEvSJ2Wwp5X5Pc6UIC0WYxq55JB+aWNJWuu3GGfN5m8ylMVE9lq
         V5v6HOwfxjAho1RrBWOPnPg38gRoj0m3N4m1/aQzfDnwMGte4vi5Wt5FfhOy3R4Q8uEr
         ScX632QlOM7s2EpIHigK5pstjW0x7ztXINqY6vJv4BXLMDR/LL7t6CMyvkmaTW5KkuoW
         ID0g==
X-Gm-Message-State: AHQUAuY21t/SAICqBqbeQ7/iAlulfXfnqTD5E4QQGAskgbJzdmorGnc+
        gW0xPIKlGj6yQ7/s3R0RvUvC8Q==
X-Google-Smtp-Source: AHgI3IbwgtoFGqAHhOODxEs5PyCjKPQoyIUe/mPAh6whs8B6EAYFmL3wsmWVmpZsuRdQyN5u+qz1KA==
X-Received: by 2002:a63:1723:: with SMTP id x35mr19202547pgl.364.1551108985545;
        Mon, 25 Feb 2019 07:36:25 -0800 (PST)
Received: from ?IPv6:2601:646:c200:7429:b988:7895:8212:7b97? ([2601:646:c200:7429:b988:7895:8212:7b97])
        by smtp.gmail.com with ESMTPSA id u184sm16177015pgd.13.2019.02.25.07.36.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 07:36:24 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC][PATCH] objtool: STAC/CLAC validation
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16D57)
In-Reply-To: <20190225115344.GA32534@hirez.programming.kicks-ass.net>
Date:   Mon, 25 Feb 2019 07:36:23 -0800
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Julien Thierry <julien.thierry@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8D4F1170-AE12-40A5-BA7F-C566FA39DE8A@amacapital.net>
References: <20190219090409.GW32494@hirez.programming.kicks-ass.net> <20190219124808.GG8501@fuggles.cambridge.arm.com> <f8e99706-4e3b-68ec-7a3e-6e6dd876ad2f@zytor.com> <cb221e71-243d-fdbd-1d18-b175bc88979b@arm.com> <alpine.DEB.2.21.1902212231490.1612@nanos.tec.linutronix.de> <CAHk-=wh1B9eRG=gj7wsFVC5XNEedk8Edive-2cQok6T2dNq2aQ@mail.gmail.com> <alpine.DEB.2.21.1902221853330.1666@nanos.tec.linutronix.de> <20190222222635.GK14054@worktop.programming.kicks-ass.net> <CALCETrV0XAv_tuw3WzQG+dx0iKEahw9V6DLACq4PtNQrkJBwhw@mail.gmail.com> <20190225105144.GJ32477@hirez.programming.kicks-ass.net> <20190225115344.GA32534@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 25, 2019, at 3:53 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
>> On Mon, Feb 25, 2019 at 11:51:44AM +0100, Peter Zijlstra wrote:
>>> On Fri, Feb 22, 2019 at 03:55:25PM -0800, Andy Lutomirski wrote:
>>> I'm wondering if we can just change the code that does getreg() and
>>> load_gs_index() so it doesn't do it with AC set.  Also, what about
>>> paravirt kernels?  They'll call into PV code for load_gs_index() with
>>> AC set.
>>=20
>> Paravirt can go bugger off. There's no sane way to fix that.
>=20
>> I don't fully understand that code at all; I also have no clue why GS
>> has paravirt bits on but the other segments do not.=20
>=20
> *sigh* SWAPGS
>=20
>> *thought*... we could delay the actual set_user_seg() thing until after
>> the get_user_catch(), would that work?
>=20
>=20
> How horrible / broken is this?
>=20
> ---
>=20
> diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
> index 321fe5f5d0e9..67c866943102 100644
> --- a/arch/x86/ia32/ia32_signal.c
> +++ b/arch/x86/ia32/ia32_signal.c
> @@ -60,17 +60,21 @@
>    regs->seg =3D GET_SEG(seg) | 3;            \
> } while (0)
>=20
> -#define RELOAD_SEG(seg)        {        \
> -    unsigned int pre =3D GET_SEG(seg);    \
> -    unsigned int cur =3D get_user_seg(seg);    \
> -    pre |=3D 3;                \
> -    if (pre !=3D cur)                \
> -        set_user_seg(seg, pre);        \
> +#define LOAD_SEG(seg)        {            \
> +    pre_##seg =3D 3 | GET_SEG(seg);            \
> +    cur_##seg =3D get_user_seg(seg);            \
> +}
> +
> +#define RELOAD_SEG(seg)        {            \
> +    if (pre_##seg !=3D cur_##seg)            \
> +        set_user_seg(seg, pre_##seg);        \
> }
>=20
> static int ia32_restore_sigcontext(struct pt_regs *regs,
>                   struct sigcontext_32 __user *sc)
> {
> +    u16 pre_gs, pre_fs, pre_ds, pre_es;
> +    u16 cur_gs, cur_fs, cur_ds, cur_es;
>    unsigned int tmpflags, err =3D 0;
>    void __user *buf;
>    u32 tmp;
> @@ -85,10 +89,10 @@ static int ia32_restore_sigcontext(struct pt_regs *reg=
s,
>         * the handler, but does not clobber them at least in the
>         * normal case.
>         */
> -        RELOAD_SEG(gs);
> -        RELOAD_SEG(fs);
> -        RELOAD_SEG(ds);
> -        RELOAD_SEG(es);
> +        LOAD_SEG(gs);
> +        LOAD_SEG(fs);
> +        LOAD_SEG(ds);
> +        LOAD_SEG(es);
>=20
>        COPY(di); COPY(si); COPY(bp); COPY(sp); COPY(bx);
>        COPY(dx); COPY(cx); COPY(ip); COPY(ax);
> @@ -106,6 +110,11 @@ static int ia32_restore_sigcontext(struct pt_regs *re=
gs,
>        buf =3D compat_ptr(tmp);
>    } get_user_catch(err);
>=20
> +    RELOAD_SEG(gs);
> +    RELOAD_SEG(fs);
> +    RELOAD_SEG(ds);
> +    RELOAD_SEG(es);
> +
>    err |=3D fpu__restore_sig(buf, 1);
>=20
>    force_iret();

I would call this pretty horrible. How about we do it without macros? :)

But yes, deferring the segment load until after the read seems fine to me. Fra=
nkly, we could also just copy_from_user the whole thing up front =E2=80=94 t=
hus code is not really a serious fast path.=

Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31DFC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8603820834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DcgOq583"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8603820834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbeJEWXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 18:23:16 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34529 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbeJEWXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 18:23:16 -0400
Received: by mail-io1-f66.google.com with SMTP id w2-v6so4715317ioc.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 08:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LX+2MI+hHYUm+bKmtAJeiUXyAPi3Ulw5YVzm3/GssU0=;
        b=DcgOq583cb1mX/Otso2cQlfpjY1bepjnzyun2QY6sz8Y/CNAwJq+ic036IDRhXsDJM
         5wPGox4R+fpwpJx0rqCvaBwMU3woOwzEVt4Ss5RmHusG0vbG4nzcf8X/Dc+Fq0GKDTQt
         guUBLUkEDEsQpEx+4NBJML53DzgOb+3q/zOpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LX+2MI+hHYUm+bKmtAJeiUXyAPi3Ulw5YVzm3/GssU0=;
        b=ePmTjgiLRz2pWN23sMI752IFNN1XBd6znotfsdvgW4UAwXqtTIoH4aPAOWTcD0OdyD
         lqsG4qL796fkDhQykjBxYZTwPtb29UX/82nm0T2KGgKryOK37LbHbLQoyzG4M2Zzj30r
         KqJJA2ERDhp8kpoqG7eUaCY7v0ABgpMJU1P8/WZef8oRLkyy29RXWwLc6EOR+bUW4/yJ
         5b9ldbMYcc7y+0NTpVP8rTumBQbaivsA/nYpmhtherWilU/1xBCAZvpkE0d797tnetIq
         WPymLyHWZgBORf0X0zGDakVoGA8ZZg+yyn0+xkTzsvFyOVLhwmi5KJ44B/W7DKG8KfWk
         YpQQ==
X-Gm-Message-State: ABuFfojYJROe2zdGXVx3baLbIT4Vkhq6BMp8kFI0eMU2b9xUTCCVDeeY
        9X+SnpzE7K/9nMsrxgBYVcNt8WCA/154YjvNFNY4rg==
X-Google-Smtp-Source: ACcGV61H+r0byvXHjqqSSVHL0DSrdOHfNZWI5KXAhm0WzubTqAY62t3z9by+L6aq5atxmrK8iitpD33kqV/xwmNyptU=
X-Received: by 2002:a6b:be83:: with SMTP id o125-v6mr8136071iof.173.1538753044011;
 Fri, 05 Oct 2018 08:24:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:5910:0:0:0:0:0 with HTTP; Fri, 5 Oct 2018 08:24:03 -0700 (PDT)
In-Reply-To: <9E0E08C8-0DFC-4E50-A4FA-73208835EF9E@amacapital.net>
References: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
 <20181005081333.15018-2-ard.biesheuvel@linaro.org> <20181005141433.GS19272@hirez.programming.kicks-ass.net>
 <9E0E08C8-0DFC-4E50-A4FA-73208835EF9E@amacapital.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 5 Oct 2018 17:24:03 +0200
Message-ID: <CAKv+Gu9z503ZJXcsG+9Ys240BZiB-+GB=kNY4VGWpjvdzN4JtA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/9] kernel: add support for patchable function pointers
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andy Lutomirski <luto@kernel.org>,
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Weinberger <richard@nod.at>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 October 2018 at 17:08, Andy Lutomirski <luto@amacapital.net> wrote:
>
>
>> On Oct 5, 2018, at 7:14 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>>
>>> On Fri, Oct 05, 2018 at 10:13:25AM +0200, Ard Biesheuvel wrote:
>>> diff --git a/include/linux/ffp.h b/include/linux/ffp.h
>>> new file mode 100644
>>> index 000000000000..8fc3b4c9b38f
>>> --- /dev/null
>>> +++ b/include/linux/ffp.h
>>> @@ -0,0 +1,43 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +
>>> +#ifndef __LINUX_FFP_H
>>> +#define __LINUX_FFP_H
>>> +
>>> +#include <linux/types.h>
>>> +#include <linux/compiler.h>
>>> +
>>> +#ifdef CONFIG_HAVE_ARCH_FFP
>>> +#include <asm/ffp.h>
>>> +#else
>>> +
>>> +struct ffp {
>>> +    void    (**fn)(void);
>>> +    void    (*default_fn)(void);
>>> +};
>>> +
>>> +#define DECLARE_FFP(_fn, _def)                        \
>>> +    extern typeof(_def) *_fn;                    \
>>> +    extern struct ffp const __ffp_ ## _fn
>>> +
>>> +#define DEFINE_FFP(_fn, _def)                        \
>>> +    typeof(_def) *_fn =3D &_def;                    \
>>> +    struct ffp const __ffp_ ## _fn                    \
>>> +        =3D { (void(**)(void))&_fn, (void(*)(void))&_def };    \
>>> +    EXPORT_SYMBOL(__ffp_ ## _fn)
>>> +
>>> +static inline void ffp_set_target(const struct ffp *m, void *new_fn)
>>> +{
>>> +    WRITE_ONCE(*m->fn, new_fn);
>>> +}
>>> +
>>> +static inline void ffp_reset_target(const struct ffp *m)
>>> +{
>>> +    WRITE_ONCE(*m->fn, m->default_fn);
>>> +}
>>> +
>>> +#endif
>>> +
>>> +#define SET_FFP(_fn, _new)    ffp_set_target(&__ffp_ ## _fn, _new)
>>> +#define RESET_FFP(_fn)        ffp_reset_target(&__ffp_ ## _fn)
>>> +
>>> +#endif
>>
>> I don't understand this interface. There is no wrapper for the call
>> site, so how are we going to patch all call-sites when you update the
>> target?
>
> I=E2=80=99m also confused.
>
> Anyway, we have patchable functions on x86. They=E2=80=99re called PVOPs,=
 and they=E2=80=99re way overcomplicated.
>
> I=E2=80=99ve proposed a better way that should generate better code, be m=
ore portable, and be more maintainable.  It goes like this.
>
> To call the function, you literally just call  the default implementation=
.  It *might* be necessary to call a nonexistent wrapper to avoid annoying =
optimizations. At build time, the kernel is built with relocations, so the =
object files contain relocation entries for the call. We collect these entr=
ies into a table. If we=E2=80=99re using the =E2=80=9Cnonexistent wrapper=
=E2=80=9D approach, we can link in a .S or linker script to alias them to t=
he default implementation.
>
> To patch them, we just patch them. It can=E2=80=99t necessarily be done c=
oncurrently because nothing forces the right alignment. But we can do it at=
 boot time and module load time. (Maybe we can patch at runtime on architec=
tures with appropriate instruction alignment.  Or we ask gcc for an extensi=
on to align calls to a function.)
>
> Most of the machinery already exists: this is roughly how the module load=
er resolves calls outside of a module.

Yeah nothing is ever simple on x86 :-(

So are you saying the approach i use in patch #2 (which would
translate to emitting a jmpq instruction pointing to the default
implementation, and patching it at runtime to point elsewhere) would
not fly on x86?

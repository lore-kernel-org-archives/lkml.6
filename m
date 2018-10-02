Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E77C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A9312089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WU2AsIyd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A9312089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbeJBOAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:00:02 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34540 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbeJBOAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:00:01 -0400
Received: by mail-io1-f68.google.com with SMTP id k19-v6so1315828iom.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 00:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kMUuKzwLUcvDpVBgRrvs/5Hw4J49dkSkUTtdFn5Nzuk=;
        b=WU2AsIyd7OklbHOoOrU3ft0tRK4Jvaze0azVafU+z29GrOh9jhzOq9+zL17CrK50Kh
         Z2nEUiQ/5on/XlMnCL9C01Gs0Yf6YJyUme1T2DY7bKk5TK9qV22oM4X80Jy3KdRGHmxu
         8IZkKftsFLfBmwBmJCgBWITyGU/ky3Lz3Mv5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kMUuKzwLUcvDpVBgRrvs/5Hw4J49dkSkUTtdFn5Nzuk=;
        b=W6eNoXWdLaj5Z7R7jxjpx+pqlgApazC/eGAWDOt/qJXebXZ9nQ2ShlXrqMt0W2g7sn
         ERLvGm/FYs2c+otQdhb7zhDQFeIeazrNwm1LVQCiv/Z1VEfHYLeqwrtn6XDBs72fj/7F
         itxldUnIoJu20+fHl0iBAQV+MdnmhMLABGk33kZWSY+dr+NqGnsPwidOy24mJ/lpDVxI
         GSzvIKjMPG+2/+oM9xrFw9aEIynGalkVYkHnE0iAdUJB61n0u8JRW5u/s29eLpqu2zD4
         xTrMPMqNqisx1iOaS9mjPWV/Kvzi1kjZbyxPUOMvrs5rlS9lGl8rCcM+xibzxU6TXch5
         G4lA==
X-Gm-Message-State: ABuFfoh7DAeYx14kUjm9kBhk9hm+NTEWgmMFd75gtSTu1Dqava2GofMO
        M4c3DQn8PextdppISZEEMW8NO3WikLDWv+XYiG5bEw==
X-Google-Smtp-Source: ACcGV62GFUDazsoUKqQkJL0i2IstrhqukOYzqmLlZJhfewmWrQL5qk880AjYZawjl2Jkv8cb6utXyM0eupirPiHIa7U=
X-Received: by 2002:a6b:5d12:: with SMTP id r18-v6mr9432188iob.170.1538464692997;
 Tue, 02 Oct 2018 00:18:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:5910:0:0:0:0:0 with HTTP; Tue, 2 Oct 2018 00:18:12 -0700 (PDT)
In-Reply-To: <CAHmME9o7_Xh=dZfnEHbPCJdqzXW1L5R7qjg=_sqPZiP2KmTc1Q@mail.gmail.com>
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-2-Jason@zx2c4.com>
 <CAKv+Gu9e35+AyktmSq9qeNE0LR83_yrEEB3DiQv0bmyArivqRQ@mail.gmail.com>
 <CAKv+Gu9kbLPZH4W0zKAfuv-b11mcDaZ05HUauvh9gMZVGVR0AQ@mail.gmail.com>
 <CAHmME9pfs0_MsD9QAGfSm31_w-=6BCF_gZO04XkfhD=mEoZmtQ@mail.gmail.com>
 <CAKv+Gu__7mZFFq6qC=8yh0OuaV+TCCLFt6nm8yJfaANHUPrJ=A@mail.gmail.com>
 <CAHmME9owF+3aQaZUkK4KkfnJna+DK=GoWV8yf-Wb+gH4w3y9eg@mail.gmail.com>
 <CAKv+Gu9FAVVOiYyGovYZ19-107_6sK9Ya6LnK=AQkTgctMmu5A@mail.gmail.com>
 <CAHmME9rqsOid6UOx+VTsFzJLEiaXpTP_z_wvHC6MbeAQUeEtHg@mail.gmail.com>
 <8afdd3b1c51587708db6ae878eb0a7e9f8b5673a.camel@perches.com>
 <3E9E1888-026E-45C1-8AA7-DADA211EDBDF@amacapital.net> <CAHmME9o7_Xh=dZfnEHbPCJdqzXW1L5R7qjg=_sqPZiP2KmTc1Q@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 2 Oct 2018 09:18:12 +0200
Message-ID: <CAKv+Gu-9i28ncTCzZLFLoJsmWjVJGiJAUCmRCCc6VhiqeySV0Q@mail.gmail.com>
Subject: Re: [PATCH net-next v6 01/23] asm: simd context helper API
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Joe Perches <joe@perches.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 October 2018 at 03:43, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> On Sun, Sep 30, 2018 at 7:35 AM Andy Lutomirski <luto@amacapital.net> wro=
te:
>> >>>>>>> Oh, and another thing (and I'm surprised checkpatch.pl didn't co=
mplain
>> >>>>>>> about it): the use of typedef in new code is strongly discourage=
d.
>> >>>>>>> This policy predates my involvement, so perhaps Joe can elaborat=
e on
>> >>>>>>> the rationale?
>> >>>>>>
>> >>>>>> In case it matters, the motivation for making this a typedef is I
>> >>>>>> could imagine this at some point turning into a more complicated
>> >>>>>> struct on certain platforms and that would make refactoring easie=
r. I
>> >>>>>> could just make it `struct simd_context` now with 1 member though=
...
>> >>>>>
>> >>>>> Yes that makes sense
>> >>>>
>> >>>> The rationale for it being a typedef or moving to a struct now?
>> >>>
>> >>> Yes just switch to a struct.
>> >>
>> >> Okay. No problem with that, but will wait to hear from Joe first.
>> >
>> > Why do you need to hear from me again?
>> >
>> > As far as I know, the only info about typedef avoidance are in
>> > Documentation/process/coding-style.rst section 5.
>> >
>> >
>>
>> I personally prefer it with the typedef. If this were my code, I=E2=80=
=99d say the coding style is silly for opaque tiny structs like this.
>
> I'll stick with a typedef. Reading the style guide, this clearly falls
> into 5.a, 5.b, and maybe 5.c. For 5.a, at some point this will
> possibly contain architecture specific blobs. For 5.b, it is just an
> enum (integer) right now.

I can live with that, but other may still object.

In any case, since you are using the enum member as a bitfield, it
would be better to typedef it to int instead, and retain the enum
definition only for the symbolic constants.

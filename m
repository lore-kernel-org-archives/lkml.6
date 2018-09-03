Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26719C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAFDA2075E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ap/iolQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAFDA2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbeICOnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 10:43:22 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:35918 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeICOnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 10:43:21 -0400
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w83ANkOL007761;
        Mon, 3 Sep 2018 19:23:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w83ANkOL007761
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1535970227;
        bh=Y5TOG+LKnYD+uOxxlQ4UADrm7UwxsRgfYdEXrKFghh4=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=ap/iolQesENzZdKmHnTaOFDBgGK4Lo/vU7eyLrqmBXkHNa7WU2KvJFk7psPkZ80qV
         iDsN2CBf+krw75NGsqG9xnj6SZrrJ6M+89meQl1IeQNJRtfTQXxQ7xHpRTCLUK+7DP
         Pyp2SV2ZkJ6lhXKlASVfRstyq0AqmkxTuBCjw01LYzZ4qZmZryHH3KMc1QxEj4ZIDO
         vgHTTelicCyS0e1AX5uN9EwgE71FUIUVjAV0VcDYuj90kpS4kytl/5kLTGFQQK96bJ
         1sAqmPNKX9Wp5o9tRnSGOYHsDE3rvf6Eo12K43m8pfGc/boW5I/0I6BMmXMontdbcE
         6aMC/grIMHkVA==
X-Nifty-SrcIP: [209.85.222.53]
Received: by mail-ua1-f53.google.com with SMTP id o11-v6so55164uak.5;
        Mon, 03 Sep 2018 03:23:47 -0700 (PDT)
X-Gm-Message-State: APzg51Bs37JUMIM7g5Cd1nd1txYWmaNPpQs3FD6J8UBBGEuP5qNhansB
        n9DHfQwn4MrFhGO9+GpqkTiIAjicdgc1rMGy028=
X-Google-Smtp-Source: ANB0VdbKxtfzWoGs47TjTsFURG5edKVju+hu63zSkw4CSTgdVK134oPz0gYpQ7tS8AzjzjgyX07+8Zxl+O07lkAOmlA=
X-Received: by 2002:a67:4441:: with SMTP id r62-v6mr8176036vsa.38.1535970225680;
 Mon, 03 Sep 2018 03:23:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7103:0:0:0:0:0 with HTTP; Mon, 3 Sep 2018 03:23:05 -0700 (PDT)
In-Reply-To: <s5h6004hokn.wl-tiwai@suse.de>
References: <20180627143705.5a1fed1c@kitsune.suse.cz> <CAK7LNARVPNx_uC5xTrS_p9T4nMRTC79BO51T4Lytv2eU1c-ynw@mail.gmail.com>
 <20180628111623.3807fe9b@naga.suse.cz> <CAK7LNARRKU7Mfa8ZBu1qPFYFRr-5k69sjVyERM2bYcnWoBDN8g@mail.gmail.com>
 <20180806200725.4efa5d35@kitsune.suse.cz> <CAK7LNATCktToMui4NYxoUXV8ZbuDK8F0JCp_CysEWaSBPUP7NQ@mail.gmail.com>
 <s5h6004hokn.wl-tiwai@suse.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 3 Sep 2018 19:23:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNATwJsYAm_VLZKJryD2zB5OHr9qVBg2mD4hyu+ieNd+r0A@mail.gmail.com>
Message-ID: <CAK7LNATwJsYAm_VLZKJryD2zB5OHr9qVBg2mD4hyu+ieNd+r0A@mail.gmail.com>
Subject: Re: due to kconfig changes kernel config file is no longer sufficient
 for configuring the kernel
To:     Takashi Iwai <tiwai@suse.de>
Cc:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Schwab <schwab@suse.de>,
        Michal Kubecek <mkubecek@suse.cz>,
        Michal Marek <michal.lkml@markovi.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Jeff Mahoney <jeffm@suse.com>,
        "Peter Zijlstra," <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.


2018-08-21 3:37 GMT+09:00 Takashi Iwai <tiwai@suse.de>:
> On Mon, 20 Aug 2018 20:15:12 +0200,
> Masahiro Yamada wrote:
>>
>> 2018-08-07 3:07 GMT+09:00 Michal Such=C3=A1nek <msuchanek@suse.de>:
>> > On Mon, 30 Jul 2018 17:02:42 +0900
>> > Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>> >
>> >> 2018-06-28 18:16 GMT+09:00 Michal Such=C3=A1nek <msuchanek@suse.de>:
>> >> > On Wed, 27 Jun 2018 23:07:21 +0900
>> >> > Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>> >> >
>> >> >> Hi.
>> >> >>
>> >> >>
>> >> >> 2018-06-27 21:37 GMT+09:00 Michal Such=C3=A1nek <msuchanek@suse.de=
>:
>> >> >> > Hello,
>> >> >> >
>> >> >> > in the x86 Kconfig we have this:
>> >> >> >
>> >> >> > # Select 32 or 64 bit
>> >> >> > config 64BIT
>> >> >> >         bool "64-bit kernel" if "$(ARCH)" =3D "x86"
>> >> >> >         default "$(ARCH)" !=3D "i386"
>> >> >> >         ---help---
>> >> >> >           Say yes to build a 64-bit kernel - formerly known as
>> >> >> > x86_64 Say no to build a 32-bit kernel - formerly known as i386
>> >> >> >
>> >> >> > Since commit 104daea149c4 ("kconfig: reference environment
>> >> >> > variables directly and remove 'option env=3D'") the value of ARC=
H
>> >> >> > is not saved in the kernel config.
>> >> >>
>> >> >> I think this commit is unrelated.  It was just a syntax change.
>> >> >
>> >> > This does not look like syntax only change to me:
>> >> >
>> >> > diff --git a/init/Kconfig b/init/Kconfig
>> >> > index 15aae32e0719..1217fc62ca61 100644
>> >> > --- a/init/Kconfig
>> >> > +++ b/init/Kconfig
>> >> > @@ -1,20 +1,12 @@
>> >> > -config ARCH
>> >> > -       string
>> >> > -       option env=3D"ARCH"
>> >> > -
>> >> > -config KERNELVERSION
>> >> > -       string
>> >> > -       option env=3D"KERNELVERSION"
>> >> > -
>> >>
>> >> This is just syntax change.
>> >>
>> >> 'option env=3D' was used to reference an environment variable.
>> >>
>> >> Now, $(ARCH), $(KERNELVERSION) are simpler forms.
>> >>
>> >>
>> >> >>
>> >> >> Unless I am missing something,
>> >> >> we have never saved ARCH in the .config in the past.
>> >> >
>> >> > There was a config symbol defined for it before the commit removed
>> >> > it.
>> >>
>> >> No.
>> >>
>> >> CONFIG symbols with'option env=3D'
>> >> are not written out to the .config file.
>> >>
>> >> We have never had CONFIG_ARCH or CONFIG_KERNELVERSION.
>
> Maybe it sounds like a stupid question, but...
> if passing ARCH=3D is almost mandatory for distinguishing the bi-arch or
> cross-compile cases, why don't we save it in .config?


The .config may not exist, may not be loaded.

For "make help", "make headers_install" etc.
ARCH needs be given from the command line anyway.

I do not want to obscure "when to pass ARCH".


> The whole "regression" we've seen can be worked around by passing
> ARCH at each time.  So, by having it in .config, everything would work
> more easily, no?


Recording ARCH in .config does not solve the problem
because the .config contents depend on the compiler.


>
>
> thanks,
>
> Takashi



--=20
Best Regards
Masahiro Yamada

Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC74C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9811220843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="KrpwfEqW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9811220843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbeICO0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 10:26:33 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:17092 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbeICO0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 10:26:32 -0400
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w83A6g5H004107;
        Mon, 3 Sep 2018 19:06:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w83A6g5H004107
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1535969203;
        bh=7i6iCxWxEbKlgnnaePKrj4e5/dvhMmvFvjan042Ific=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=KrpwfEqWsnDgoOp9rMIIeS2cYu3ikbAO3JmpuV25fqmz9Bbwwv3jJEZKUtmHmzB3H
         97ye3NJvOb4s8x4bG1sDnOrIBBpRsIFLlh/3g/OHyu8Qh58EqX46YC9DhEHgMuVgLQ
         74cWDpKfV+Zoo2OBv5iNE0g7xUPwkN26ptG3g+JRm+DTmtdMenQ09GsKwc7Ce1+YFJ
         pQTDYKSZzwuUgfVfXiRKGcgDzxOn+F4sSzcemb7N1AUDxUZ3xYwqrDgjZ/WHiYFfa8
         zS0fZaGTa2FOISesd8uSqWft0ScTfd9NYvMsD3iWCicrE2TBj3jEgdXwdBupRF/gDe
         SFqvPnO81zkEA==
X-Nifty-SrcIP: [209.85.222.54]
Received: by mail-ua1-f54.google.com with SMTP id g18-v6so20104uam.6;
        Mon, 03 Sep 2018 03:06:42 -0700 (PDT)
X-Gm-Message-State: APzg51CAIxC++GCpmAIkaDWdtcc0KScFjZSZ+9pUH2YroWRkQTxpBeHe
        nkuBCM7RQOkRPOkg+ZEpgvaPq2+6d9tujQS7tl4=
X-Google-Smtp-Source: ANB0VdYaK6K9eRVmKkGW5ULgm40PaaeOZMh7SNFpThKLYb5r/bVT/evxj3VAkpzVnPJRwzEQL6becG3LPxnfKgSJL/4=
X-Received: by 2002:a67:7cc9:: with SMTP id x192-v6mr4825132vsc.9.1535969201306;
 Mon, 03 Sep 2018 03:06:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7103:0:0:0:0:0 with HTTP; Mon, 3 Sep 2018 03:06:00 -0700 (PDT)
In-Reply-To: <20180820233331.08dd2bfb@naga.suse.cz>
References: <20180627143705.5a1fed1c@kitsune.suse.cz> <CAK7LNARVPNx_uC5xTrS_p9T4nMRTC79BO51T4Lytv2eU1c-ynw@mail.gmail.com>
 <20180628111623.3807fe9b@naga.suse.cz> <CAK7LNARRKU7Mfa8ZBu1qPFYFRr-5k69sjVyERM2bYcnWoBDN8g@mail.gmail.com>
 <20180806200725.4efa5d35@kitsune.suse.cz> <CAK7LNATCktToMui4NYxoUXV8ZbuDK8F0JCp_CysEWaSBPUP7NQ@mail.gmail.com>
 <20180820233331.08dd2bfb@naga.suse.cz>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 3 Sep 2018 19:06:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ5Q-DPL006UJzs-dAhMo5Cdaa9P+UAD+XL67QvPw353g@mail.gmail.com>
Message-ID: <CAK7LNAQ5Q-DPL006UJzs-dAhMo5Cdaa9P+UAD+XL67QvPw353g@mail.gmail.com>
Subject: Re: due to kconfig changes kernel config file is no longer sufficient
 for configuring the kernel
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.de>, Andreas Schwab <schwab@suse.de>,
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

Hi,


2018-08-21 6:33 GMT+09:00 Michal Such=C3=A1nek <msuchanek@suse.de>:
> Hello,
>
> On Tue, 21 Aug 2018 03:15:12 +0900
> Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>
>> 2018-08-07 3:07 GMT+09:00 Michal Such=C3=A1nek <msuchanek@suse.de>:
>> > On Mon, 30 Jul 2018 17:02:42 +0900
>> > Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>> >
>> >> 2018-06-28 18:16 GMT+09:00 Michal Such=C3=A1nek <msuchanek@suse.de>:
>> >> > On Wed, 27 Jun 2018 23:07:21 +0900
>> >> > Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>> >> >
>
>> >>
>> >>
>> >>
>> >> >>
>> >> >> out-of-tree modules are built with exactly the same
>> >> >> configuration as used for the kernel.
>> >> >
>> >> > It is not true. And that is the problem. You need the config file
>> >> > and dump of the environment passed to the make command at
>> >> > configuration time to get the exact same configuration. The
>> >> > environment is not saved anywhere, though.
>> >>
>> >>
>> >> Why dump of the environment?
>> >>
>> >>
>> >> If you are building external modules natively
>> >> your distribution provides /lib/modules/$(uname -r)/build,
>> >> which contains files enough for building external modules.
>> >>
>> >> You can pass the directory path to M=3D... parameter.  That's it.
>> >
>> > No, that's not it. Since passing ARCH=3Di386 is the de-facto standard
>> > to configure a 32bit kernel and the result of passing that was not
>> > saved you need to pass it to make as well.
>>
>>
>> If you pass ARCH=3D for the configuration phase,
>> you need to pass the same ARCH=3D in the build phase.
>>
>>
>>
>>
>> What I can suggest for you is:
>>
>>
>> $ make ARCH=3Di386 defconfig
>> $ make ARCH=3Di386
>>
>>    OR
>>
>> $ make i386_defconfig
>> $ make
>
> Maybe you missed that but I do not want to build the defconfig. I want
> to build a *particular* config which has been saved in a file
> beforehand.
>>
>> > And you need to patch a number of
>> > 3rd party build scripts that build a kernel module as part of a
>> > bigger project.
>>
>>
>> You do not need to patch a number of scripts.
>>
>> Just one liner fix.
>> Add 'export ARCH=3Di386' in the top level script.
>
> And that does not work because there is no toplevel script. rpm has
> three toplevel scripts - prep, build and install.


OK, I understood real problem cases.

I wrote patches to support non-interactive .config updates.

For package building like rpm, deb, etc.
the target ARCH is determined when creating a source package.
If so, it would not hurt to hard-code to record ARCH in the spec file.


> Building out-of-tree module is another toplevel script.


As I said before, the .config is not reconfigured
when building out-of-tree modules.

Out-of-tree modules are built with the .config
that has been used to build vmlinux
regardless of whether you pass ARCH=3Di386, ARCH=3Dx86_64, or nothing.

If rpmbuild is given target option like 'rpmbuild --target i386 ...",
it think it makes sense to propagate it to ARCH=3D.


> And it does not suffice to 'export ARCH=3Di386'. What if it was a 64bit
> config? How do I tell?
>
> With more and more options left out of the config that depend on
> compiler features, environment variables, phase of the moon or whatnot
> you can't even tell what kind of kernel the user is running by looking
> at the config.


I added non-interactive .config update.

Please try it.




--=20
Best Regards
Masahiro Yamada

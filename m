Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754F9C43612
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C2EE204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730763AbfAOPTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:19:07 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46425 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730723AbfAOPTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:19:06 -0500
Received: by mail-qk1-f195.google.com with SMTP id q1so1701768qkf.13;
        Tue, 15 Jan 2019 07:19:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OFGD7PXuhpa61ZNV+Dxzw50BERwu8kM4CC/gfLY4p9U=;
        b=RNVXtHa5mOqBp4fFgCoHSu3Efmncw7kt9SLtisyVH/Y8jI1K3Iuy53T2d2kACwDYmP
         O84hjXwmvxDzxI6Br8cqx9K/okkxX8dj5QIsEGqJYKOn647yAejO/9azgflNirdOY8iz
         ZZU61772RM5lxxRKI1XVCs2okrl/dBiMwHi8EcXcctLrEE5l39VABVgzN5TtbqKULuGW
         bih3oHJn7ytTv52jHbXuQs45afQrkxM4Ipvc6wBYULRGp6F5aBieeIOsAyy3D9DMTnH8
         s/8UFcuHYKO1yWTydCY8FCQknIFG/ox34nwe4fpN7ypuhRBY5zyX8w1MnN7UqFrx3l+b
         Gplw==
X-Gm-Message-State: AJcUukeQuNKqrGPQYqCssoIRKBPqyWXL7z+FG7/W9TXUrAQRujIyaXGo
        MvlPn8uZL3BrRc8DUzDf4y9oss14THeI1B5G8kQ=
X-Google-Smtp-Source: ALg8bN5li7wBTklauFcVKrMtYE7+j8exj0sCThMZxxkRVYqsdAVuAfN8FZb6/7OCIQd/h7bJ0hMXGi+Oq4K6cLzGY0s=
X-Received: by 2002:ae9:d8c2:: with SMTP id u185mr2951683qkf.107.1547565544568;
 Tue, 15 Jan 2019 07:19:04 -0800 (PST)
MIME-Version: 1.0
References: <20190110162435.309262-1-arnd@arndb.de> <20190110162435.309262-15-arnd@arndb.de>
 <87pnsz28k2.fsf@concordia.ellerman.id.au> <CAK8P3a0uas76i2W1yjFvxHT-2=A8_egUZeAUM-Vya6386+87Xg@mail.gmail.com>
In-Reply-To: <CAK8P3a0uas76i2W1yjFvxHT-2=A8_egUZeAUM-Vya6386+87Xg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 15 Jan 2019 16:18:48 +0100
Message-ID: <CAK8P3a3eUzGDrJtV2ySpgHwjKHwZYr+1xHp6tChCt1gWi=mJ+g@mail.gmail.com>
Subject: Re: [PATCH 14/15] arch: add split IPC system calls where needed
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Paul Burton <paul.burton@mips.com>,
        Helge Deller <deller@gmx.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Rich Felker <dalias@libc.org>,
        David Miller <davem@davemloft.net>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-ia64@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 4:01 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Jan 14, 2019 at 4:59 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> > Arnd Bergmann <arnd@arndb.de> writes:
> > >  arch/m68k/kernel/syscalls/syscall.tbl     | 11 +++++++++++
> > >  arch/mips/kernel/syscalls/syscall_o32.tbl | 11 +++++++++++
> > >  arch/powerpc/kernel/syscalls/syscall.tbl  | 12 ++++++++++++
> >
> > I have some changes I'd like to make to our syscall table that will
> > clash with this.
> >
> > I'll try and send them today.
>
> Ok. Are those for 5.0 or 5.1? If they are intended for 5.0, it would be
> nice for me to have a branch based on 5.0-rc1 that I can put
> the other patches on top of.

There is also another change that I considered:

At the end of my series, we have a lot of entries like

245     32      clock_settime                   sys_clock_settime32
245     64      clock_settime                   sys_clock_settime
245     spu     clock_settime                   sys_clock_settime

which could be folded into

245     32      clock_settime                   sys_clock_settime32
245     spu64 clock_settime                   sys_clock_settime

if we just add another option to the ABI field. Any thoughts on
that?

      Arnd

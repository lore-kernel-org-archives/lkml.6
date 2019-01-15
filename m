Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFE6C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C8D2133D
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731653AbfAOQgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:36:11 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:33560 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727717AbfAOQgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:36:10 -0500
Received: by mail-ua1-f68.google.com with SMTP id t8so1156760uap.0;
        Tue, 15 Jan 2019 08:36:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=adm1Mw3mLDDQkb5Mftiy3lAZ198qNeHBJOL4SrY1tf8=;
        b=RfpRvsOPjC6Le8+InpGDrh2aOWx+Qz5hdHCcsa/JEJe6f6mFyF0KG2zyssinsmdzon
         5SadmnvI2XoT1BPpx2HvUt02Q0Zdj4XdE47GTnLf0EhflE3tIKePOyKp4zhyjs+xJlgt
         9zZGz8bA5Rk9pyKsIsnckQTRMDbnTLyGKXuwj4CzpCID2gHa3hlXjtPczPxKy7XHU1Ja
         jwZszq+kjIn1A5H+v+objqkbxKH4vtpT4ei2Pmop6zrg0O1kolC5knL/9f90PJw28njM
         t/9bA/cdfNTp1dHAa2ZLz1gQq5xtL/GH6jplREbvYoxdPn3Ywid93Y/m2nJwW8kJUH+P
         QFjw==
X-Gm-Message-State: AJcUukfVOUokvUsZWVxmBZPhXvivJQTMvunIlvjRQxHF2r48AAWKEOYI
        /T2UKhtOv0IhWR1xPGzZEZmdTmCkFqK2QAWuyFI=
X-Google-Smtp-Source: ALg8bN5nyuahVho846ktl4afIc2BkzN7/rQ1M7vxhSJ6rgU6eyfffsa43/9sALd1FvtSGdvtLkpiFjHkbityoUbDtSg=
X-Received: by 2002:ab0:210e:: with SMTP id d14mr1882691ual.20.1547570168071;
 Tue, 15 Jan 2019 08:36:08 -0800 (PST)
MIME-Version: 1.0
References: <20190110162435.309262-1-arnd@arndb.de> <20190110162435.309262-15-arnd@arndb.de>
 <87pnsz28k2.fsf@concordia.ellerman.id.au> <CAK8P3a0uas76i2W1yjFvxHT-2=A8_egUZeAUM-Vya6386+87Xg@mail.gmail.com>
 <CAK8P3a3eUzGDrJtV2ySpgHwjKHwZYr+1xHp6tChCt1gWi=mJ+g@mail.gmail.com>
In-Reply-To: <CAK8P3a3eUzGDrJtV2ySpgHwjKHwZYr+1xHp6tChCt1gWi=mJ+g@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 15 Jan 2019 17:35:55 +0100
Message-ID: <CAMuHMdVw1mBLGdn4hkiNVyoJ_oxMwi3d=_e7WL5ru+ALA4MKbw@mail.gmail.com>
Subject: Re: [PATCH 14/15] arch: add split IPC system calls where needed
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
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
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
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

Hi Arnd,

On Tue, Jan 15, 2019 at 4:19 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Jan 15, 2019 at 4:01 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Mon, Jan 14, 2019 at 4:59 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> > > Arnd Bergmann <arnd@arndb.de> writes:
> > > >  arch/m68k/kernel/syscalls/syscall.tbl     | 11 +++++++++++
> > > >  arch/mips/kernel/syscalls/syscall_o32.tbl | 11 +++++++++++
> > > >  arch/powerpc/kernel/syscalls/syscall.tbl  | 12 ++++++++++++
> > >
> > > I have some changes I'd like to make to our syscall table that will
> > > clash with this.
> > >
> > > I'll try and send them today.
> >
> > Ok. Are those for 5.0 or 5.1? If they are intended for 5.0, it would be
> > nice for me to have a branch based on 5.0-rc1 that I can put
> > the other patches on top of.
>
> There is also another change that I considered:
>
> At the end of my series, we have a lot of entries like
>
> 245     32      clock_settime                   sys_clock_settime32
> 245     64      clock_settime                   sys_clock_settime
> 245     spu     clock_settime                   sys_clock_settime
>
> which could be folded into
>
> 245     32      clock_settime                   sys_clock_settime32
> 245     spu64 clock_settime                   sys_clock_settime
>
> if we just add another option to the ABI field. Any thoughts on
> that?

So "spu64" would mean "spu + 64"?
That makes it more difficult to read, and to grep.
What about allowing multiple ABIs, separated by commas?
So that line would become:

    245     spu,64 clock_settime                   sys_clock_settime

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE44AC43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B802064C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbfAKIH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 03:07:59 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:37983 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfAKIH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 03:07:57 -0500
Received: by mail-vs1-f65.google.com with SMTP id x64so8687085vsa.5;
        Fri, 11 Jan 2019 00:07:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gk5sRyaMorBl1gCKq795+qZVHE+uAsmqqhSvjIZGPmU=;
        b=VfyLiJFmoydejEHDkg6wMZ1HKsUA0S3IhvdQWak9Reyfu2GMDG4r6RGR5eFEOiKieW
         78RcrPDc66lFCJ2Hb03iwHwy7jrgi+JvWsj6vKiv19F5bR+QeRuYa3DZMzdfw5nOLOpV
         bQhWFdl1Ih7BaHJbSGw/IwT9PEKfehk3285zgKu4NAJsjBDHI9HoGTLiEACg4gq1cdN+
         xp8MQZ7DzrGVWihzCFVJ6R/bXioC1ItXvN4j9O7kVKka5pikJdwDOGW3m4B1FiG39Vt4
         YGS/O+rVpXG1a6yrw0YhYuTAXqKolvxXL3RQIAxGIb2USX4ZjBvgpGZ1YmgAwhNSTMqF
         /Xgg==
X-Gm-Message-State: AJcUukffb2wnoPPx1NKlDDQe73afmoWFKx9lPHYp0ENSh2kxPwhtv/hY
        +iKGR4N5scvxwZIA/51V3ic6w7areGsUoMkbc/0=
X-Google-Smtp-Source: ALg8bN4BZSRCmO8JcdiTKsQLtOiGYCRcA4qcLBhQcTtWAUJ36fVLDe+20wntOZTNXHVnjK/m8j2ch6eOfrp0E8t9JNI=
X-Received: by 2002:a67:f43:: with SMTP id 64mr5594803vsp.166.1547194075355;
 Fri, 11 Jan 2019 00:07:55 -0800 (PST)
MIME-Version: 1.0
References: <20190110162435.309262-1-arnd@arndb.de> <CAMuHMdXYP3=TRHYqddVRfbRRaj_Ou=wfoX6ohKM7XNAx-c2RXw@mail.gmail.com>
 <CAK8P3a0kmr2ju+sZE+f-+=-2t5Eu+t-DS-+r6OKrPVTAxHwf8w@mail.gmail.com>
 <CAMuHMdVpUNUx-wdDYChYNzMYqYi79w5tzjk5x3JskdS88VQCQw@mail.gmail.com> <CAK8P3a07yNiadLCJcA0Tyfo90YeQ0P2XF-wOEy9XAb8cDTFObw@mail.gmail.com>
In-Reply-To: <CAK8P3a07yNiadLCJcA0Tyfo90YeQ0P2XF-wOEy9XAb8cDTFObw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 11 Jan 2019 09:07:43 +0100
Message-ID: <CAMuHMdUpThq_fmSitzUrEUFx40itYdURpjmunLs_YLA9BPaMQg@mail.gmail.com>
Subject: Re: [PATCH 00/15] arch: synchronize syscall tables in preparation for y2038
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Michal Simek <monstr@monstr.eu>,
        Paul Burton <paul.burton@mips.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
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

On Thu, Jan 10, 2019 at 11:43 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Jan 10, 2019 at 7:11 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, Jan 10, 2019 at 6:06 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Thu, Jan 10, 2019 at 5:59 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > On Thu, Jan 10, 2019 at 5:26 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > The system call tables have diverged a bit over the years, and a number
> > > > > of the recent additions never made it into all architectures, for one
> > > > > reason or another.
> > > > >
> > > > > This is an attempt to clean it up as far as we can without breaking
> > > > > compatibility, doing a number of steps:
> > > >
> > > > Thanks a lot!
> > > >
> > > > > - Add system calls that have not yet been integrated into all
> > > > >   architectures but that we definitely want there.
> > > >
> > > > It looks like you missed wiring up io_pgetevents() on m68k.
> > > > Is that intentional?
> > >
> > > Yes, I thought I had described that somewhere but maybe I
> > > forgot: semtimedop() and io_pgetevents() get replaced with
> > > time64 versions in the follow-up, so I only added them in
> > > 64-bit architectures. If you think we should have both
> > > io_pgetevents() and io_pgetevents_time32() on all 32-bit
> > > architectures, I can add that as well.
> >
> > Thanks, sounds fine to me.
>
> Just to be sure, you mean it's fine to not add it, not that we should
> add it?

I'm fine with not having the legacy 32-bit ones.

Sorry for being unclear.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

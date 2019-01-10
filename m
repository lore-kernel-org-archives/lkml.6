Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD45EC43612
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C07F206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730990AbfAJSLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 13:11:18 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:39998 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729882AbfAJSLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 13:11:15 -0500
Received: by mail-vs1-f65.google.com with SMTP id z3so7581343vsf.7;
        Thu, 10 Jan 2019 10:11:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EUuZ5Krtu82auHRun9veeZBKChDTVOpn44W3kwgqDtY=;
        b=MfgbvF4H1B08EEc4UW2D0OBgocum7r4ZszTCkwltQB2LGidZc5G4jpvxjjA06/IF5Z
         CKPyMOw3tG2Vkl/u0RFkqdFDfJawwmLb08c1PEW1Bydd12GrLp9hln7O/C5dxilRUz5y
         x6VQajubkooAXxtetItlv1b8p2WOV+7UyuqiEWC19ZgfIu6xT32ZLMs074CQlHRqRcyK
         G+nVwCNnZ6TSSRZRFxZb2WYyqiLum6NRPdttbf78HAZEP6BzDxqExUxmeqtrJR2/mM0b
         nX4z6cdwuuyxJIGkXPA1dnza9XHk0quJMvvc/AIWxArgsZf8dF/Xp5Vb8RECzn5/sn7G
         4znQ==
X-Gm-Message-State: AJcUukcAZyY/29b3RKW6Xlzzg6rhdFJrtd4kJwZLWob/JH3kZPKfjA17
        xrlcMpr7PlnsxT1o4iKcvvPjirKiHEn4neql4Us=
X-Google-Smtp-Source: ALg8bN6aokmnpf1j0NX2Ej8BYTOm8/6RZGNDOHHw2gQ7ocUs2TauDUatTN8cLeSj84eryGhe6FE/dq+5R1mIXqFPJxk=
X-Received: by 2002:a67:c202:: with SMTP id i2mr4350248vsj.11.1547143873299;
 Thu, 10 Jan 2019 10:11:13 -0800 (PST)
MIME-Version: 1.0
References: <20190110162435.309262-1-arnd@arndb.de> <CAMuHMdXYP3=TRHYqddVRfbRRaj_Ou=wfoX6ohKM7XNAx-c2RXw@mail.gmail.com>
 <CAK8P3a0kmr2ju+sZE+f-+=-2t5Eu+t-DS-+r6OKrPVTAxHwf8w@mail.gmail.com>
In-Reply-To: <CAK8P3a0kmr2ju+sZE+f-+=-2t5Eu+t-DS-+r6OKrPVTAxHwf8w@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 10 Jan 2019 19:11:00 +0100
Message-ID: <CAMuHMdVpUNUx-wdDYChYNzMYqYi79w5tzjk5x3JskdS88VQCQw@mail.gmail.com>
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

On Thu, Jan 10, 2019 at 6:06 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Jan 10, 2019 at 5:59 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, Jan 10, 2019 at 5:26 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > The system call tables have diverged a bit over the years, and a number
> > > of the recent additions never made it into all architectures, for one
> > > reason or another.
> > >
> > > This is an attempt to clean it up as far as we can without breaking
> > > compatibility, doing a number of steps:
> >
> > Thanks a lot!
> >
> > > - Add system calls that have not yet been integrated into all
> > >   architectures but that we definitely want there.
> >
> > It looks like you missed wiring up io_pgetevents() on m68k.
> > Is that intentional?
>
> Yes, I thought I had described that somewhere but maybe I
> forgot: semtimedop() and io_pgetevents() get replaced with
> time64 versions in the follow-up, so I only added them in
> 64-bit architectures. If you think we should have both
> io_pgetevents() and io_pgetevents_time32() on all 32-bit
> architectures, I can add that as well.

Thanks, sounds fine to me.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

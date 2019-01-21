Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898CEC282F4
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5603F20855
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbfAUIT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:19:27 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:41216 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728554AbfAUITZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:19:25 -0500
Received: by mail-vs1-f67.google.com with SMTP id t17so12087893vsc.8;
        Mon, 21 Jan 2019 00:19:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eNwdIYQYJT6Pc3PhNslPpG4rGotSgFNPjN+8uubEzLc=;
        b=Vo89ajKOwug4ns6UZvMUCUEmNFht3W/Wx6abnzf9O5tKN9U1kYLoWjLOEvNh+CMkSV
         pKemCXcpNgtHZ410WfIIjTv2OhiKv9Ix5wisMRvLmmoYJ7nWvORqFlYY0SiiawXuk/Eb
         iddRCgLYkPQAi2Q5k5QRKsIy1TKtyavXX+QwWjivTOlJZh+LGsiDekmyIR95X3xsPe+u
         2lUqRxDJLfbbrBLK9tDoFeaM0VkVkIXWWegzPHR5VzDgzw7kGGHTCDWLTzd6o1jiiyF0
         KJngLy/50a1MroFrwCkj68ZCpUrNlRRneAd8D3Po0LSDzBomPaLp/sYW8fIJHf/lnjXX
         WwTQ==
X-Gm-Message-State: AJcUukfGB3cNe9n0b5lieVnxC07tAKkZPYVwdg7An2iD11h/pRk2BJNi
        Kyo0djFImCANX0FAajFDz793Fw6jDJs1RIkqPHQ=
X-Google-Smtp-Source: ALg8bN7Na9+3XJsTlxP4CnU3flevzSwRj2I8fvGc/mex1gzD8KE0G4LYkLwzBJ2YcDmVU42ivUABTg84S/YKw2y1uBc=
X-Received: by 2002:a67:3885:: with SMTP id n5mr10324892vsi.96.1548058763095;
 Mon, 21 Jan 2019 00:19:23 -0800 (PST)
MIME-Version: 1.0
References: <20190118161835.2259170-1-arnd@arndb.de> <20190118161835.2259170-30-arnd@arndb.de>
 <CALCETrXqM5mhvwreN5y-9K99h1j9rs9MAVK-cNLC54s1fdHA6w@mail.gmail.com>
 <CAK8P3a0V+xboaGAF2nqrYtpjXXA7y0LcvCKi4ngLTus1D_XZBA@mail.gmail.com>
 <CALCETrWPj6dHEyo=AELoVjXGsiwuSpRp17x3CEWBHvp7i3cy+Q@mail.gmail.com> <20190119142852.cntdihah4mpa3lgx@e5254000004ec.dyn.armlinux.org.uk>
In-Reply-To: <20190119142852.cntdihah4mpa3lgx@e5254000004ec.dyn.armlinux.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Jan 2019 09:19:11 +0100
Message-ID: <CAMuHMdXzQNEEDjWrmTph8Krovj1g2WhnBUaM=FvKB+J2fZqctA@mail.gmail.com>
Subject: Re: [PATCH v2 29/29] y2038: add 64-bit time_t syscalls to all 32-bit architectures
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Michal Simek <monstr@monstr.eu>,
        Paul Burton <paul.burton@mips.com>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On Sat, Jan 19, 2019 at 3:29 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
> On Fri, Jan 18, 2019 at 11:53:25AM -0800, Andy Lutomirski wrote:
> > On Fri, Jan 18, 2019 at 11:33 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Fri, Jan 18, 2019 at 7:50 PM Andy Lutomirski <luto@kernel.org> wrote:
> > > > On Fri, Jan 18, 2019 at 8:25 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > - Once we get to 512, we clash with the x32 numbers (unless
> > > > >   we remove x32 support first), and probably have to skip
> > > > >   a few more. I also considered using the 512..547 space
> > > > >   for 32-bit-only calls (which never clash with x32), but
> > > > >   that also seems to add a bit of complexity.
> > > >
> > > > I have a patch that I'll send soon to make x32 use its own table.  As
> > > > far as I'm concerned, 547 is *it*.  548 is just a normal number and is
> > > > not special.  But let's please not reuse 512..547 for other purposes
> > > > on x86 variants -- that way lies even more confusion, IMO.
> > >
> > > Fair enough, the space for those numbers is cheap enough here.
> > > I take it you mean we also should not reuse that number space if
> > > we were to decide to remove x32 soon, but you are not worried
> > > about clashing with arch/alpha when everything else uses consistent
> > > numbers?
> > >
> >
> > I think we have two issues if we reuse those numbers for new syscalls.
> > First, I'd really like to see new syscalls be numbered consistently
> > everywhere, or at least on all x86 variants, and we can't on x32
> > because they mean something else.  Perhaps more importantly, due to
> > what is arguably a rather severe bug, issuing a native x86_64 syscall
> > (x32 bit clear) with nr in the range 512..547 does *not* return
> > -ENOSYS on a kernel with x32 enabled.  Instead it does something that
> > is somewhat arbitrary.  With my patch applied, it will return -ENOSYS,
> > but old kernels will still exist, and this will break syscall probing.
> >
> > Can we perhaps just start the consistent numbers above 547 or maybe
> > block out 512..547 in the new regime?
>
> I don't think you gain much with that kind of scheme - it won't take
> very long before an architecture misses having a syscall added, and
> then someone else adds their own.  Been there with ARM - I was keeping
> the syscall table in the same order as x86 for new syscalls, but now

Same for m68k, and probably other architectures.

> that others have been adding syscalls to the table since I converted
> ARM to the tabular form, that's now gone out the window.
>
> So, I think it's completely pointless to do what you're suggesting.
> We'll just end up with a big hole in the middle of the syscall table
> and then revert back to random numbering of syscalls thereafter again.

I believe the plan is to add future syscalls for all architectures in a
single commit, to keep everything in sync.

Regardless, I'm wondering what to do with the holes marked "room for
arch specific calls".
When is a syscall really arch-specific, and can it be added there, and
when does it turn out (later) that it isn't, breaking the
synchronization again?

The pkey syscalls may be a bad example, as AFAIU they can be implemented
on some architectures, but not on some others.  Still, I had skipped them
when adding new syscalls to m68k.

Perhaps we should get rid of the notion of "arch-specific syscalls", and
reserve a slot everywhere anyway?

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

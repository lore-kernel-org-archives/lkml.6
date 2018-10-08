Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59224C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F49204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27F49204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbeJHVxS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 17:53:18 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:42753 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeJHVxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 17:53:17 -0400
Received: by mail-vk1-f196.google.com with SMTP id t202-v6so4622413vke.9;
        Mon, 08 Oct 2018 07:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CgtQcrKJzjpdQ7ZPDgbb1FATbezKn8nvsfbJ+/trxnk=;
        b=Wcyct/RPlrcZC4wY9wL88/2XJxhQM7mA6u4qYoBjcli6rHYNXKM9QyQYvLu71eeP76
         RrP+jV3/fHxCYvxxjV1G5QSPhbqo4nBYm55vMQnnrFo959DLCUCAVYAyBaeIDKwW4FwC
         /rXghfL6ZDzF4RThOckrLensMj/WCX7jEVFzOfNfhGD6hBJCgVILR5wc2wRm93qPnMG3
         IPnr/GvpdBPbo5vlqMQfLASuBJiZD7j9NdadYBzp76t1KT6oRT0bpRoKMnMBlsYuGsxv
         Yi7HCMcfUVCafJOo9qGBqUH1tQC4H5aZ3PWhBOIBJzx91tdhqZo9TMlRoZMT5Aa97sMu
         l27g==
X-Gm-Message-State: ABuFfojIArftc80kB/FZrGPIW3uQ9FRN11+3sYSA5eSfugqC69Z+P5f9
        7PKsKjtUKBaUYxMlMMCotJ+/hINN3hHQ/YRXr/OA6w==
X-Google-Smtp-Source: ACcGV62NILaNUb/87nQSI/blosdEIxer3oRejn48QDi1rujQmNhhEY+wqlZDPoIuT/Z5/gs/7hdaZmFD7LSImo3X65Y=
X-Received: by 2002:a1f:2d56:: with SMTP id t83-v6mr9184379vkt.65.1539009673374;
 Mon, 08 Oct 2018 07:41:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180921142234.16882-1-kieran.bingham+renesas@ideasonboard.com>
 <20181005083313.2088252-1-arnd@arndb.de> <CANiq72mHDxe9-+pFf+dDuYXRz5YeyRYi6RW65tyo9-ENNngsCw@mail.gmail.com>
 <CAK7LNAT5h+Rku7DbD+kHGv7Kgk8FfuX4wwL_pwNOLSJbqw99MA@mail.gmail.com>
 <CAK7LNATycNLxzB=FtrBy9M4E6m9wx4Uhk=DQ7gcCMD2J_vfmfQ@mail.gmail.com>
 <5cbb504c-0506-cec8-d51b-00928cdb27fe@ideasonboard.com> <CAK7LNAQNhMhoCXSRDQVrNkTLUyLO0_xYJm1o_dyao0-rSbpwzA@mail.gmail.com>
In-Reply-To: <CAK7LNAQNhMhoCXSRDQVrNkTLUyLO0_xYJm1o_dyao0-rSbpwzA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 8 Oct 2018 16:41:01 +0200
Message-ID: <CAMuHMdXv62=+jvFDb8w2vms4Zt4xm3Sf2K1i0BX7-1cwEtdCCA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: fix kernel/bounds.c 'W=1' warning
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 4:33 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> On Mon, Oct 8, 2018 at 7:01 PM Kieran Bingham
> <kieran.bingham+renesas@ideasonboard.com> wrote:
> > On 06/10/18 23:06, Masahiro Yamada wrote:
> > > On Sun, Oct 7, 2018 at 6:58 AM Masahiro Yamada
> > > <yamada.masahiro@socionext.com> wrote:
> > >>
> > >> Hi Miguel,
> > >>
> > >>
> > >> On Sun, Oct 7, 2018 at 6:18 AM Miguel Ojeda
> > >> <miguel.ojeda.sandonis@gmail.com> wrote:
> > >>>
> > >>> On Fri, Oct 5, 2018 at 10:35 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > >>>>
> > >>>> Building any configuration with 'make W=1' produces a warning:
> > >>>>
> > >>>> kernel/bounds.c:16:6: warnign: no previous prototype for 'foo' [-Wmissing-prototypes]
> > >>>>
> > >>>> When also passing -Werror, this prevents us from building any
> > >>>> other files. Nobody ever calls the function, but we can't make
> > >>>> it 'static' either since we want the compiler output.
> > >>>>
> > >>>> Calling it 'main' instead however avoids the warning, because gcc
> > >>>> does not insist on having a declaration for main.
> > >>>
> > >>> I think marking the function as static __used should do the trick and
> > >>> would be less confusing.
> > >>
> > >>
> > >>
> > >>
> > >> I tried __used, but I still see the warning.
> > >>
> > >>
> > >> masahiro@grover:~/ref/linux$ git diff
> > >> diff --git a/kernel/bounds.c b/kernel/bounds.c
> > >> index c373e88..aee0101 100644
> > >> --- a/kernel/bounds.c
> > >> +++ b/kernel/bounds.c
> > >> @@ -13,7 +13,7 @@
> > >>  #include <linux/log2.h>
> > >>  #include <linux/spinlock_types.h>
> > >>
> > >> -void foo(void)
> > >> +void __used foo(void)
> > >>  {
> > >>         /* The enum constants to put into include/generated/bounds.h */
> > >>         DEFINE(NR_PAGEFLAGS, __NR_PAGEFLAGS);
> > >> masahiro@grover:~/ref/linux$ make W=1  prepare
> > >>   CC      kernel/bounds.s
> > >> kernel/bounds.c:16:13: warning: no previous prototype for ‘foo’
> > >> [-Wmissing-prototypes]
> > >>  void __used foo(void)
> > >>              ^
> > >>   CC      arch/x86/kernel/asm-offsets.s
> > >
> > >
> > >
> > > Sorry, I forgot to add 'static'.
> > >
> > > Adding both static and __used worked for me,
> > > and I like the idea.
> > >
> >
> > Aha - I'd also tried converting to static in my earlier attempts, but
> > didn't realise we had __used!
> >
> > updating as "static __used" causes the following diff:
> >
> > diff -Nurp bounds.s.foo bounds.s.static-used
> > --- bounds.s.foo        2018-10-05 10:20:53.269941404 +0100
> > +++ bounds.s.static-used        2018-10-08 10:51:18.079309049 +0100
> > @@ -110,7 +110,6 @@
> >  #NO_APP
> >         .align  2
> >         .p2align 3,,7
> > -       .global foo
> >         .type   foo, %function
> >  foo:
> >         stp     x29, x30, [sp, -16]!    //,,,
> >
> >
> > I'd say this is a pretty good alternative fix - however I see Arnd's
> > version is already on it's way though akpm's tree...
> >
> > https://ozlabs.org/~akpm/mmots/broken-out/kbuild-fix-kernel-boundsc-w%3D1-warning.patch
> >
> > Anyway, as long as one of the variants gets there I'll be happy :)
>
>
> I will leave it to Arnd.
>
>
> When we fix arch/{mips,sparc}/kernel/asm-offsets.c,
> 'static __used' is just additions.
>
> The 'main(void)' solution would require a little bit restructuring.
>
>
>
> FWIW, with my quick analysis, the following should be fixed as well:
>
> arch/alpha/kernel/asm-offsets.c
> arch/c6x/kernel/asm-offsets.c
> arch/ia64/kernel/asm-offsets.c
> arch/ia64/kernel/nr-irqs.c
> arch/mips/kernel/asm-offsets.c
> arch/riscv/kernel/asm-offsets.c
> arch/sparc/kernel/asm-offsets.c
> arch/x86/kernel/asm-offsets.c
> arch/x86/um/shared/sysdep/kernel-offsets.h
> samples/bpf/syscall_nrs.c

All the other asm-offsets.c files already use "int main(void)" ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

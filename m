Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904D8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 582B5223C8
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 582B5223C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbeKLS6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 13:58:47 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:51960 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbeKLS6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 13:58:47 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id D2621297D7;
        Mon, 12 Nov 2018 04:06:27 -0500 (EST)
Date:   Mon, 12 Nov 2018 20:06:50 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Philip Blundell <philb@gnu.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Joshua Thompson <funaho@jurai.org>
Subject: Re: [RFC PATCH 06/13] m68k: Drop ARCH_USES_GETTIMEOFFSET
In-Reply-To: <CAMuHMdXdo+L-Ta04zUsL62RSt1HOvmPJs7HFu_zEnc38R0FPjA@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1811122002530.351@nippy.intranet>
References: <cover.1541995959.git.fthain@telegraphics.com.au> <74edaee07800f91eb416ab3e72c4670b8ef4bd4e.1541995959.git.fthain@telegraphics.com.au> <CAMuHMdXdo+L-Ta04zUsL62RSt1HOvmPJs7HFu_zEnc38R0FPjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2018, Geert Uytterhoeven wrote:

> Hi Finn,
> 
> Thanks for your patch!
> 
> On Mon, Nov 12, 2018 at 5:46 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> > The functions that implement arch_gettimeoffset are re-used by
> > new clocksource drivers in subsequent patches.
> 
> Disabling this first affects functionality during bisection, right?
> 

It means that all platforms have to use the 'jiffies' clocksource.

At the end of the series, only apollo, q40, sun3 & sun3x continue to use 
that clocksource.

> > --- a/arch/m68k/amiga/config.c
> > +++ b/arch/m68k/amiga/config.c
> > @@ -95,8 +95,6 @@ static char amiga_model_name[13] = "Amiga ";
> >  static void amiga_sched_init(irq_handler_t handler);
> >  static void amiga_get_model(char *model);
> >  static void amiga_get_hardware_list(struct seq_file *m);
> > -/* amiga specific timer functions */
> > -static u32 amiga_gettimeoffset(void);
> >  extern void amiga_mksound(unsigned int count, unsigned int ticks);
> >  static void amiga_reset(void);
> >  extern void amiga_init_sound(void);
> > @@ -386,7 +384,6 @@ void __init config_amiga(void)
> >         mach_init_IRQ        = amiga_init_IRQ;
> >         mach_get_model       = amiga_get_model;
> >         mach_get_hardware_list = amiga_get_hardware_list;
> > -       arch_gettimeoffset   = amiga_gettimeoffset;
> 
> In addition, won't this lead to "function defined statically but not 
> called' warnings?
> 

I expect so. I haven't compile-tested each step in the series; but I'll do 
that before I send v2. Thanks for the reminder.

There are no new warnings at the end of the series.

-- 

> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> 

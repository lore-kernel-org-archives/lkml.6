Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA5BC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 11:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D69C208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 11:21:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D69C208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389088AbeHANHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 09:07:05 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:36314 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388565AbeHANHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 09:07:05 -0400
Received: by mail-ua0-f194.google.com with SMTP id c12-v6so12429373uan.3;
        Wed, 01 Aug 2018 04:21:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bNKd65oIUvaNQQyg/b4E7txOJePScJe/ZTkqCOCQoZA=;
        b=GKdBF3L1bCgr69Mqr2qnMmEVkUazNaq1QUz58D+vx7H5iyZPbXyDseOKtVR/FYIhTp
         djz3xDiTYfwGO4uZDoALqcMURae7Setlv4qoq28WzQw4kG98hlLCJk86/Zwz+JSAi3Fh
         PqaR6q2K7mmmtZd+VnW+xg5AUJd12/kTv8liF06+yIt05HDwS4CLjRnR1xeg8lXX/izI
         FeOv5R9i8O/FgMQH/C5InTrqbKrSUQo3Z0sx4eOJKAWiFRqM98XExTFKXCy6F3R5lyjT
         rFKpSceZ0vQU4UzihGBaWjYFOcikd0zJXB3cOoxnbED4c2Dt49/3yXwgzXwb0/fsFkC0
         QUzw==
X-Gm-Message-State: AOUpUlEfLQfCvh+zf9JpZg9yLzdBV6k9tei9u+p9yE+Eqp7HRUnQWGHz
        4n2/6VLGNDqSBDiBmdBBUkDuxyM2sZb0w3cUJBk=
X-Google-Smtp-Source: AAOMgpf5gBg27umL5rZA9dimVggrajP+AOU2EuvmmonTOaawWFTvtKqrPnbvkq3X+kfcTiDF03/M4FzjevzD+RPWZHM=
X-Received: by 2002:a9f:37c8:: with SMTP id q66-v6mr17906765uaq.180.1533122504428;
 Wed, 01 Aug 2018 04:21:44 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20180603154636epcas2p4812a1f19c6ae236336ae580658edb167@epcas2p4.samsung.com>
 <6008699.T6Yd1fn3Dk@amdc3058> <alpine.LRH.2.02.1807092148080.30863@file01.intranet.prod.int.rdu2.redhat.com>
 <1975707.vO8kdHz3oS@amdc3058> <alpine.LRH.2.02.1807300552140.2919@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.1807311111520.22145@file01.intranet.prod.int.rdu2.redhat.com>
 <CAMuHMdVBurd2L1iK218QvNUorLyQs4nnTpikZGgJRZjHN8apAw@mail.gmail.com> <alpine.LRH.2.02.1808010657300.903@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.1808010657300.903@file01.intranet.prod.int.rdu2.redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 1 Aug 2018 13:21:31 +0200
Message-ID: <CAMuHMdUGSv-_2nTcRoj1ScC2XhYr75yX4ttSvwcyW8esJas=eQ@mail.gmail.com>
Subject: Re: Sleeping from invalid context in udlfb
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Dave Airlie <airlied@redhat.com>,
        Bernie Thompson <bernie@plugable.com>,
        Ladislav Michl <ladis@linux-mips.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mikulas,

On Wed, Aug 1, 2018 at 12:59 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
> On Wed, 1 Aug 2018, Geert Uytterhoeven wrote:
> > On Tue, Jul 31, 2018 at 5:23 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
> > > BTW when using the udlfb driver as a console, I've got this warning.
> > > vt_console_print takes a spinlock and then calls the framebuffer driver
> > > that sleeps.
> > >
> > > The question is - whose fault is this? Could the console code somehow be
> > > told to print characters without holding a spinlock? Or does it mean that
> > > framebuffer drivers can't sleep?
> > >
> > > udlfb communicates through USB, so the sleeping is inevitable.
> > >
> > > Mikulas
> > >
> > >
> > > BUG: sleeping function called from invalid context at mm/slab.h:421
> > > in_atomic(): 1, irqs_disabled(): 0, pid: 430, name: kworker/2:3
> > > 6 locks held by kworker/2:3/430:
> > >  #0: 000000001301127e ( (wq_completion)"events"){....} , at: process_one_work+0x17c/0x3a8
> > >  #1: 00000000beacc951 ( (work_completion)(&(&dlfb->init_framebuffer_work)->work)){....} , at: process_one_work+0x17c/0x3a8
> > >  #2: 00000000a402f826 ( registration_lock){....} , at: register_framebuffer+0x28/0x2c0 [fb]
> > >  #3: 0000000021cbe902 ( console_lock){....} , at: register_framebuffer+0x258/0x2c0 [fb]
> > >  #4: 0000000096d51735 ( console_owner){....} , at: console_unlock+0x174/0x500
> > >  #5: 00000000faa7f206 ( printing_lock){....} , at: vt_console_print+0x60/0x3a0
> > > Preemption disabled at: [<ffffff8008403130>] vt_console_print+0x60/0x3a0
> > > CPU: 2 PID: 430 Comm: kworker/2:3 Not tainted 4.17.10-debug #3
> > > Hardware name: Marvell Armada 8040 MacchiatoBin/Armada 8040 MacchiatoBin, BIOS EDK II Jul 30 2018
> > > Workqueue: events dlfb_init_framebuffer_work [udlfb]
> > > Call trace:
> > >  dump_backtrace+0x0/0x150
> > >  show_stack+0x14/0x20
> > >  dump_stack+0x8c/0xac
> > >  ___might_sleep+0x140/0x170
> > >  __might_sleep+0x50/0x88
> > >  __kmalloc+0x1b0/0x270
> > >  xhci_urb_enqueue+0xa8/0x460 [xhci_hcd]
> > >  usb_hcd_submit_urb+0xc0/0x998 [usbcore]
> > >  usb_submit_urb+0x1e0/0x518 [usbcore]
> > >  dlfb_submit_urb+0x38/0x98 [udlfb]
> > >  dlfb_handle_damage.isra.4+0x1e0/0x210 [udlfb]
> > >  dlfb_ops_imageblit+0x28/0x38 [udlfb]
> > >  soft_cursor+0x15c/0x1d8 [fb]
> > >  bit_cursor+0x324/0x510 [fb]
> > >  fbcon_cursor+0x144/0x1a0 [fb]
> > >  hide_cursor+0x38/0xa0
> > >  vt_console_print+0x334/0x3a0
> > >  console_unlock+0x274/0x500
> > >  register_framebuffer+0x22c/0x2c0 [fb]
> > >  dlfb_init_framebuffer_work+0x1ec/0x2fc [udlfb]
> > >  process_one_work+0x1e8/0x3a8
> > >  worker_thread+0x44/0x418
> > >  kthread+0x11c/0x120
> > >  ret_from_fork+0x10/0x18
> >
> > This is sort of expected: you cannot do USB transfers from printk().
> >
> > Gr{oetje,eeting}s,
> >
> >                         Geert
>
> So, should there be a framebuffer flag that prevents the console from
> binding to it?
>
> If I start the kernel with "console=ttyS0,115200", it doesn't try to bind
> to the udlfb driver, but if I start it without this flag, it does and
> crashes :-(

Your frame buffer driver should offload tasks that may sleep to e.g. a
workqueue.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

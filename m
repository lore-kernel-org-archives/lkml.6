Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751931AbeDJBf1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 21:35:27 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:42212 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751767AbeDJBf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 21:35:26 -0400
Date: Tue, 10 Apr 2018 11:35:13 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Laurent Vivier <lvivier@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/12] m68k/mac: Don't remap SWIM MMIO region
In-Reply-To: <CAMuHMdUy6C4OoGF44e_34+XjsQHe6RwfoesfBzcM8baEHUwzXw@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1804101110380.8@nippy.intranet>
References: <cover.1522546571.git.fthain@telegraphics.com.au> <cdba869f704b457bc617007738870b9e1bdef9d3.1522546571.git.fthain@telegraphics.com.au> <CAMuHMdUy6C4OoGF44e_34+XjsQHe6RwfoesfBzcM8baEHUwzXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Apr 2018, Geert Uytterhoeven wrote:

> Hi Finn,
> 
> On Sun, Apr 1, 2018 at 3:41 AM, Finn Thain <fthain@telegraphics.com.au> 
> wrote:
> > For reasons I don't understand, calling ioremap() then iounmap() on 
> > the SWIM MMIO region causes a hang on 68030 (but not on 68040).
> 
> Michael Schmitz also notices strange things with ioremap() on '030.
> 
> > There's no need to call ioremap() for the SWIM address range, as it 
> > lies within the usual IO device region at 0x5000 0000, which is 
> > already mapped.
> 
> by head.S, right?
> 

Right. I'll mention that in the commit log when I re-submit this series.

> > --- a/drivers/block/swim.c
> > +++ b/drivers/block/swim.c
> > @@ -911,7 +911,7 @@ static int swim_probe(struct platform_device *dev)
> >                 goto out;
> >         }
> >
> > -       swim_base = ioremap(res->start, resource_size(res));
> > +       swim_base = (struct swim __iomem *)res->start;
> 
> I guess you need a __force to please sparse?
> 

No, sparse did not find any new issues. It appears there's an old issue 
elsewhere in the driver though. I'll prepare a new patch for that.

-- 

> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> 

-- 

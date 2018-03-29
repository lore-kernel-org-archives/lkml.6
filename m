Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751868AbeC2O3g (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 10:29:36 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42695 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750884AbeC2O3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 10:29:35 -0400
Date: Thu, 29 Mar 2018 16:29:22 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Peter Rosin <peda@axentia.se>, <linux-kernel@vger.kernel.org>,
        "wenyouya@gmail.com" <wenyouya@gmail.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] mtd: nand: raw: atmel: add module param to avoid using
 dma
Message-ID: <20180329162922.5db7acd1@bbrezillon>
In-Reply-To: <30d8bd45-4e5d-3703-5f41-07f5fc70f09d@microchip.com>
References: <20180329131054.22506-1-peda@axentia.se>
        <30d8bd45-4e5d-3703-5f41-07f5fc70f09d@microchip.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Mar 2018 16:20:38 +0200
Nicolas Ferre <nicolas.ferre@microchip.com> wrote:

> On 29/03/2018 at 15:10, Peter Rosin wrote:
> > On a sama5d31 with a Full-HD dual LVDS panel (132MHz pixel clock) NAND
> > flash accesses have a tendency to cause display disturbances. Add a
> > module param to disable DMA from the NAND controller, since that fixes
> > the display problem for me.
> > 
> > Signed-off-by: Peter Rosin <peda@axentia.se>
> > ---
> >   drivers/mtd/nand/raw/atmel/nand-controller.c | 7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
> > index b2f00b398490..2ff7a77c7b8e 100644
> > --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
> > +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
> > @@ -129,6 +129,11 @@
> >   #define DEFAULT_TIMEOUT_MS			1000
> >   #define MIN_DMA_LEN				128
> >   
> > +static bool atmel_nand_avoid_dma __read_mostly;
> > +
> > +MODULE_PARM_DESC(avoiddma, "Avoid using DMA");
> > +module_param_named(avoiddma, atmel_nand_avoid_dma, bool, 0400);  
> 
> We had the DT parameter "atmel,nand-has-dma" for this purpose and it was

Actually, that was not my understanding of this property. To me it
sounds like something to flag whether the platform supports DMA or
not, no whether it should be enabled on a per-board basis.

> associated with a module parameter as well (use_dma,).

That's true for the use_dma module param, I didn't add it back when
reworking the driver.

> 
> Is it only managed by old DT binding?

It is. I'm really not in favor of adding the DT prop back, but let's
re-introduce the module param if you think it's needed. BTW, the module
name has changed, so the param name will be different.

-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

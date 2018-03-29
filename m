Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752701AbeC2NoT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 09:44:19 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41202 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752067AbeC2NoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 09:44:18 -0400
Date: Thu, 29 Mar 2018 15:44:16 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Josh Wu <rainyfeeling@outlook.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] mtd: nand: raw: atmel: add module param to avoid using
 dma
Message-ID: <20180329154416.5c1a0013@bbrezillon>
In-Reply-To: <ed87cf13-a69a-6115-f0a8-5f51c4957d1d@axentia.se>
References: <20180329131054.22506-1-peda@axentia.se>
        <20180329153322.5e2fc1e7@bbrezillon>
        <ed87cf13-a69a-6115-f0a8-5f51c4957d1d@axentia.se>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Mar 2018 15:37:43 +0200
Peter Rosin <peda@axentia.se> wrote:

> On 2018-03-29 15:33, Boris Brezillon wrote:
> > On Thu, 29 Mar 2018 15:10:54 +0200
> > Peter Rosin <peda@axentia.se> wrote:
> >   
> >> On a sama5d31 with a Full-HD dual LVDS panel (132MHz pixel clock) NAND
> >> flash accesses have a tendency to cause display disturbances. Add a
> >> module param to disable DMA from the NAND controller, since that fixes
> >> the display problem for me.
> >>
> >> Signed-off-by: Peter Rosin <peda@axentia.se>
> >> ---
> >>  drivers/mtd/nand/raw/atmel/nand-controller.c | 7 ++++++-
> >>  1 file changed, 6 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
> >> index b2f00b398490..2ff7a77c7b8e 100644
> >> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
> >> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
> >> @@ -129,6 +129,11 @@
> >>  #define DEFAULT_TIMEOUT_MS			1000
> >>  #define MIN_DMA_LEN				128
> >>  
> >> +static bool atmel_nand_avoid_dma __read_mostly;
> >> +
> >> +MODULE_PARM_DESC(avoiddma, "Avoid using DMA");
> >> +module_param_named(avoiddma, atmel_nand_avoid_dma, bool, 0400);  
> > 
> > I'm not a big fan of those driver specific cmdline parameters. Can't we
> > instead give an higher priority to HLCDC master using the bus matrix?  
> 
> I don't know if it will be enough, but we sure can try. However, I have
> no idea how to do that. I will happily test stuff though...

There's no interface to configure that from Linux, but you can try to
tweak it with devmem and if that does the trick, maybe we can expose a
way to configure that from Linux. For more details, see the "Bus Matrix
(MATRIX)" section in Atmel datasheets.

-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

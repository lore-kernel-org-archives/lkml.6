Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756967AbeDBT25 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 15:28:57 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57504 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754879AbeDBT24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 15:28:56 -0400
Date: Mon, 2 Apr 2018 21:28:43 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Peter Rosin <peda@axentia.se>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org,
        Richard Weinberger <richard@nod.at>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] mtd: nand: raw: atmel: add module param to avoid using
 dma
Message-ID: <20180402212843.164d5d21@bbrezillon>
In-Reply-To: <e0d9bd59-8031-e387-676e-dc5811170a0c@axentia.se>
References: <20180329131054.22506-1-peda@axentia.se>
        <20180329153322.5e2fc1e7@bbrezillon>
        <ed87cf13-a69a-6115-f0a8-5f51c4957d1d@axentia.se>
        <20180329154416.5c1a0013@bbrezillon>
        <b740406a-e91c-67ad-24a3-cbdbe259d00d@axentia.se>
        <20180402142249.7e076a64@bbrezillon>
        <e0d9bd59-8031-e387-676e-dc5811170a0c@axentia.se>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Apr 2018 19:59:39 +0200
Peter Rosin <peda@axentia.se> wrote:

> On 2018-04-02 14:22, Boris Brezillon wrote:
> > On Thu, 29 Mar 2018 16:27:12 +0200
> > Peter Rosin <peda@axentia.se> wrote:
> >   
> >> On 2018-03-29 15:44, Boris Brezillon wrote:  
> >>> On Thu, 29 Mar 2018 15:37:43 +0200
> >>> Peter Rosin <peda@axentia.se> wrote:
> >>>     
> >>>> On 2018-03-29 15:33, Boris Brezillon wrote:    
> >>>>> On Thu, 29 Mar 2018 15:10:54 +0200
> >>>>> Peter Rosin <peda@axentia.se> wrote:
> >>>>>       
> >>>>>> On a sama5d31 with a Full-HD dual LVDS panel (132MHz pixel clock) NAND
> >>>>>> flash accesses have a tendency to cause display disturbances. Add a
> >>>>>> module param to disable DMA from the NAND controller, since that fixes
> >>>>>> the display problem for me.
> >>>>>>
> >>>>>> Signed-off-by: Peter Rosin <peda@axentia.se>
> >>>>>> ---
> >>>>>>  drivers/mtd/nand/raw/atmel/nand-controller.c | 7 ++++++-
> >>>>>>  1 file changed, 6 insertions(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
> >>>>>> index b2f00b398490..2ff7a77c7b8e 100644
> >>>>>> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
> >>>>>> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
> >>>>>> @@ -129,6 +129,11 @@
> >>>>>>  #define DEFAULT_TIMEOUT_MS			1000
> >>>>>>  #define MIN_DMA_LEN				128
> >>>>>>  
> >>>>>> +static bool atmel_nand_avoid_dma __read_mostly;
> >>>>>> +
> >>>>>> +MODULE_PARM_DESC(avoiddma, "Avoid using DMA");
> >>>>>> +module_param_named(avoiddma, atmel_nand_avoid_dma, bool, 0400);      
> >>>>>
> >>>>> I'm not a big fan of those driver specific cmdline parameters. Can't we
> >>>>> instead give an higher priority to HLCDC master using the bus matrix?      
> >>>>
> >>>> I don't know if it will be enough, but we sure can try. However, I have
> >>>> no idea how to do that. I will happily test stuff though...    
> >>>
> >>> There's no interface to configure that from Linux, but you can try to
> >>> tweak it with devmem and if that does the trick, maybe we can expose a
> >>> way to configure that from Linux. For more details, see the "Bus Matrix
> >>> (MATRIX)" section in Atmel datasheets.    
> >>
> >> I don't seem to succeed in changing the registers I think I need to change.
> >> I can poke the "Write Protection Mode Register" by writing MAT0 and MAT1 to
> >> it.  
> > 
> > You mean 0x4D415400, right? ("MAT0" != 0x4D415400).  
> 
> Bits 1 through 7 do not matter, so even though not equal they are (or
> should be) equivalent. But I did use 0x4d415400. I simply used the
> shorter syntax since that was easier to type and conveyed the relevant
> info.

Ok.

> 
> >> But when I try to write to "Priority Registers B For Slaves" it doesn't
> >> take, regardless of write protect mode.  
> > 
> > Did you check MATRIX_WPSR after writing to MATRIX_PRXSY?  
> 
> No, but did it again and checked, see transcript below.

I don't use devmem2. Is 'readback' information accurate or is it
always what's been written? Because when you write 0x33 to 0xFFFFECBC,
0x33 is read back, but just after that, when you read it again it's 0.

> BTW, how do I
> know which master is in use for the LCD controller? 8 or 9? Both?

It's configurable on a per-layer basis through the SIF bit in
LCDC_<layer>CFG0. The driver tries to dispatch the load on those 2 AHB
masters [1].

> And
> which DDR slave is the target? 7, 8, 9 or 10? More than one?

This, I don't know. I guess all of them can be used.

> 
> Cheers,
> Peter
> 
> # devmem2 0xffffede4 w
> /dev/mem opened.
> Memory mapped at address 0xb6f50000.
> Value at address 0xFFFFEDE4 (0xb6f50de4): 0x0
> # devmem2 0xffffede4 w 0x4d415401
> /dev/mem opened.
> Memory mapped at address 0xb6f0d000.
> Value at address 0xFFFFEDE4 (0xb6f0dde4): 0x0
> Written 0x4D415401; readback 0x4D415401
> # devmem2 0xffffede4 w
> /dev/mem opened.
> Memory mapped at address 0xb6f55000.
> Value at address 0xFFFFEDE4 (0xb6f55de4): 0x1
> # devmem2 0xffffede4 w 0x4d415400
> /dev/mem opened.
> Memory mapped at address 0xb6fb5000.
> Value at address 0xFFFFEDE4 (0xb6fb5de4): 0x1
> Written 0x4D415400; readback 0x4D415400
> # devmem2 0xffffede4 w
> /dev/mem opened.
> Memory mapped at address 0xb6fef000.
> Value at address 0xFFFFEDE4 (0xb6fefde4): 0x0
> 
> 
> # devmem2 0xffffede8 w
> /dev/mem opened.
> Memory mapped at address 0xb6fe9000.
> Value at address 0xFFFFEDE8 (0xb6fe9de8): 0x0
> 
> 
> # devmem2 0xffffecbc w
> /dev/mem opened.
> Memory mapped at address 0xb6ff0000.
> Value at address 0xFFFFECBC (0xb6ff0cbc): 0x0
> # devmem2 0xffffecbc w 0x33
> /dev/mem opened.
> Memory mapped at address 0xb6f79000.
> Value at address 0xFFFFECBC (0xb6f79cbc): 0x0
> Written 0x33; readback 0x33
> # devmem2 0xffffecbc w
> /dev/mem opened.
> Memory mapped at address 0xb6efe000.
> Value at address 0xFFFFECBC (0xb6efecbc): 0x0
> 
> 
> # devmem2 0xffffede8 w
> /dev/mem opened.
> Memory mapped at address 0xb6f9e000.
> Value at address 0xFFFFEDE8 (0xb6f9ede8): 0x0
> 

[1]https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c#L498

-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

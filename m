Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165716AbeE1O1i (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:27:38 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54043 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161626AbeE1O1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 10:27:31 -0400
Date: Mon, 28 May 2018 16:27:18 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Peter Rosin <peda@axentia.se>
Cc: Tudor Ambarus <tudor.ambarus@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Richard Weinberger <richard@nod.at>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: Re: [PATCH] mtd: nand: raw: atmel: add module param to avoid using
 dma
Message-ID: <20180528162718.6be7191f@bbrezillon>
In-Reply-To: <c3cc1894-2d7d-93b6-a9de-ed9ca4564ae9@axentia.se>
References: <20180329131054.22506-1-peda@axentia.se>
        <20180329153322.5e2fc1e7@bbrezillon>
        <ed87cf13-a69a-6115-f0a8-5f51c4957d1d@axentia.se>
        <20180329154416.5c1a0013@bbrezillon>
        <b740406a-e91c-67ad-24a3-cbdbe259d00d@axentia.se>
        <20180402142249.7e076a64@bbrezillon>
        <e0d9bd59-8031-e387-676e-dc5811170a0c@axentia.se>
        <20180402212843.164d5d21@bbrezillon>
        <20180402222020.1d344c14@bbrezillon>
        <d7e6f78d-b57b-4d0f-c07c-ca6c1930cd51@axentia.se>
        <20180403091813.5fb5c18c@bbrezillon>
        <d0afd431-6e51-a9b7-c103-ecf1f6e07c2e@axentia.se>
        <959d826d-1a98-ca22-acee-a4548427fcd3@microchip.com>
        <a25ca617-d3da-d401-1ba9-8e5887f8a8e5@microchip.com>
        <024079cb-77ad-9c48-e370-e6e8f2de171b@axentia.se>
        <9c496531-f7b6-4b9d-dd51-0bfb68ead303@axentia.se>
        <c3cc1894-2d7d-93b6-a9de-ed9ca4564ae9@axentia.se>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Mon, 28 May 2018 12:10:02 +0200
Peter Rosin <peda@axentia.se> wrote:

> On 2018-05-28 00:11, Peter Rosin wrote:
> > On 2018-05-27 11:18, Peter Rosin wrote:  
> >> On 2018-05-25 16:51, Tudor Ambarus wrote:  
> >>> We think the best way is to keep LCD on DDR Ports 2 and 3 (8th and 9th
> >>> slaves), to have maximum bandwidth and to use DMA on DDR port 1 for NAND
> >>> (7th slave).  
> >>
> >> Exactly how do I accomplish that?
> >>
> >> I can see how I can move the LCD between slave DDR port 2 and 3 by
> >> selecting LCDC DMA master 8 or 9 (but according to the above it should
> >> not matter). The big question is how I control what slave the NAND flash
> >> is going to use? I find nothing in the datasheet, and the code is also
> >> non-transparent enough for me to figure it out by myself without
> >> throwing out this question first...  
> > 
> > I added this:
> > 
> > diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
> > index e686fe73159e..3b33c63d2ed4 100644
> > --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
> > +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
> > @@ -1991,6 +1991,9 @@ static int atmel_nand_controller_init(struct atmel_nand_controller *nc,
> >  		nc->dmac = dma_request_channel(mask, NULL, NULL);
> >  		if (!nc->dmac)
> >  			dev_err(nc->dev, "Failed to request DMA channel\n");
> > +
> > +		dev_info(nc->dev, "using %s for DMA transfers\n",
> > +			 dma_chan_name(nc->dmac));
> >  	}
> >  
> >  	/* We do not retrieve the SMC syscon when parsing old DTs. */
> > 
> > 
> > 
> > and the output is
> > 
> > atmel-nand-controller 10000000.ebi:nand-controller: using dma0chan5 for DMA transfers
> > 
> > So, DMA controller 0 is in use. I still don't know if IF0, IF1 or IF2 is used
> > or how to find out. I guess IF2 is not in use since that does not allow any
> > DDR2 port as slave...
> > 
> > From the datasheet, DMAC0/IF0 uses DDR2 Port 2, and DMAC0/IF1 uses DDR2 Port 1.
> > But, by the looks of the register content in my other mail, it seems as if
> > DMA0/IF1 can also use DDR2 Port 3.
> > 
> > So, I think I want either
> > 
> > A) the NAND controller to use DMAC0/IF0 (i.e. DDR2 port 1, and possibly 3) and
> >    the LCDC to use master 9 (i.e. DDR2 Port 2)
> > 
> > or
> > 
> > B) the NAND controller to use DMAC1/IF1 (i.e. DDR2 port 2) and the LCDC to use
> >    master 8 (i.e. DDR2 Port 3)  
> 
> Crap, that was not what I meant to express. Sorry for the confusion. This is
> better.
> 
> So, I think I want either
> 
> A) the NAND controller to use master 1 DMAC0/IF0 (i.e. slave 8 DDR2 port 2) and
>    the LCDC to use master 9 (i.e. slave 9 DDR2 Port 3)
> 
> or
> 
> B) the NAND controller to use master 2 DMAC0/IF1 (i.e. slave 7 DDR2 port 1, and
>    possibly slave 9 DDR2 port 3 (if my previous findings are relevant) and the
>    LCDC to use master 8 (i.e. slave 8 DDR2 Port 2)
> 
> > But, again, how do I limit DMAC0 to either of IF0 or IF1 for NAND accesses?  
> 
> So, I added a horrid patch (attached), which mainly adds printk lines, but
> additionally does one more thing in atc_prep_dma_memcpy. It changes the DSCR_IF
> field (from 0) to 1 for DMA-memcpy for dma0chan5 (i.e. the NAND). At least I
> think it does that?
> 
> Running with that patch gets me this:
> 
> # dmesg | grep -i dma
> at_hdmac ffffe600.dma-controller: Atmel AHB DMA Controller ( cpy set slave ), 8 channels
> at_hdmac ffffe800.dma-controller: Atmel AHB DMA Controller ( cpy set slave ), 8 channels
> dma dma0chan0: xlate 0 2
> dma dma0chan1: xlate 0 2
> at91_i2c f0014000.i2c: using dma0chan0 (tx) and dma0chan1 (rx) for DMA transfers
> dma dma1chan0: xlate 0 2
> dma dma1chan1: xlate 0 2
> at91_i2c f801c000.i2c: using dma1chan0 (tx) and dma1chan1 (rx) for DMA transfers
> dma dma0chan2: xlate 0 2
> dma dma0chan3: xlate 0 2
> dma dma0chan4: xlate 0 2
> atmel_mci f0000000.mmc: using dma0chan4 for DMA transfers
> dma dma1chan2: xlate 0 2
> dma dma1chan3: xlate 0 2
> atmel_aes f8038000.aes: Atmel AES - Using dma1chan2, dma1chan3 for DMA transfers
> dma dma1chan4: xlate 0 2
> atmel_sha f8034000.sha: using dma1chan4 for DMA transfers
> dma dma1chan5: xlate 0 2
> dma dma1chan6: xlate 0 2
> atmel_tdes f803c000.tdes: using dma1chan5, dma1chan6 for DMA transfers
> atmel-nand-controller 10000000.ebi:nand-controller: using dma0chan5 for DMA transfers
> dma dma0chan5: memcpy: 0
> dma dma0chan5: DSCR_IF: 1
> dma dma0chan5: memcpy: 1
> 
> So, output is as expected and I believe that the patch makes the NAND DMA
> accesses use master 2 DMAC0/IF1 and are thus forced to use slave 7 DDR2 Port 1
> (and possibly 9). The LCDC is using slave 8 DDR2 Port 2. So there should be no
> slave conflict?
> 
> But the on-screen crap remains during NAND accesses.
> 
> But pressing on.
> 
> I then changed the priorities for all accesses to 0 in the PRxSy registers, except
> the ones for masters 8/9 LCDC (slaves 8/9) which I left at priority 3.
> 
> But the on-screen crap remains during NAND accesses.
> 
> My guess is that the NAND DMA is doing too long bursts and that the LCDC therefore
> has to wait too long and simply fails to keep the pipeline from running short?
> 
> So I tried to reduce the maximum SLOT_CYCLE for slaves 7 and 9 in the SCFGx
> registers. No noticeable effect either.
> 
> I then tried to split bursts from master 2 (DMAC0/IF1) with small values in the
> MCFG2 register. No effect.
> 
> I'm getting nowhere.

Could it just be that you're reaching the DDR bus limit. As I said
previously, when you go through the CPU, and assuming you're consuming
the data directly, you have:

1/ NFC SRAM -> CPU
2/ CPU -> L1 data cache --write-back--> DRAM
3/ L1-cache -> CPU

While, if you use DMA you get:

1/ NFC SRAM -> DRAM
2/ SDRAM -> L1 data cache -> CPU

So, if you're approaching the limit of (LP)DDR bandwidth, using the CPU
might make things a bit better. Still, if the limitation really comes
from the DDR bus, my opinion is that you should maybe use a smaller
resolution or use a more compact pixel format (RGB565?).

Did you calculate how much of the bandwidth is taken by the HLCDC
block and compared it to the max (LP)DDR bandwidth?

Regards,

Boris

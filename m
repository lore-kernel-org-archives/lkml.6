Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964841AbeE2OtQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:49:16 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34270 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935507AbeE2OtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:49:13 -0400
Date: Tue, 29 May 2018 16:49:11 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: Peter Rosin <peda@axentia.se>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] mtd: nand: raw: atmel: add module param to avoid using
 dma
Message-ID: <20180529164911.29820e07@bbrezillon>
In-Reply-To: <19d68279-072e-7646-6fdd-8649578229ea@microchip.com>
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
        <19d68279-072e-7646-6fdd-8649578229ea@microchip.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugen,

On Tue, 29 May 2018 09:30:54 +0300
Eugen Hristev <eugen.hristev@microchip.com> wrote:

> On 28.05.2018 13:10, Peter Rosin wrote:
> > On 2018-05-28 00:11, Peter Rosin wrote:  
> >> On 2018-05-27 11:18, Peter Rosin wrote:  
> >>> On 2018-05-25 16:51, Tudor Ambarus wrote:  
> >>>> We think the best way is to keep LCD on DDR Ports 2 and 3 (8th and 9th
> >>>> slaves), to have maximum bandwidth and to use DMA on DDR port 1 for NAND
> >>>> (7th slave).  
> >>>
> >>> Exactly how do I accomplish that?
> >>>
> >>> I can see how I can move the LCD between slave DDR port 2 and 3 by
> >>> selecting LCDC DMA master 8 or 9 (but according to the above it should
> >>> not matter). The big question is how I control what slave the NAND flash
> >>> is going to use? I find nothing in the datasheet, and the code is also
> >>> non-transparent enough for me to figure it out by myself without
> >>> throwing out this question first...  
> 
>  >> [...]  
> 
> >> and the output is
> >>
> >> atmel-nand-controller 10000000.ebi:nand-controller: using dma0chan5 for DMA transfers
> >>
> >> So, DMA controller 0 is in use. I still don't know if IF0, IF1 or IF2 is used
> >> or how to find out. I guess IF2 is not in use since that does not allow any
> >> DDR2 port as slave...  
> 
> Hello Peter,
> 
> Thank you for all the information, I will chip in to help a little bit.
> The Master/channel is described in the device tree. The channel has a 
> controller, a mem/periph interface and a periph ID, plus a FIFO 
> configuration.
> 
> The dma chan number reported in the dmesg is just software. Here is an 
> example from DT:
> dmas = <&dma0 2 AT91_DMA_CFG_PER_ID(1)>,
>         <&dma0 2 AT91_DMA_CFG_PER_ID(2)>;
> 
> you can match this with the help from 
> Documentation/devicetree/bindings/dma/atmel-dma.txt:
> 
> 1. A phandle pointing to the DMA controller. 
> 
> 2. The memory interface (16 most significant bits), the peripheral 
> interface
> (16 less significant bits). 
> 
> 3. Parameters for the at91 DMA configuration register which are device 
> 
> dependent: 
> 
>    - bit 7-0: peripheral identifier for the hardware handshaking 
> interface. The
>    identifier can be different for tx and rx. 
> 
>    - bit 11-8: FIFO configuration. 0 for half FIFO, 1 for ALAP, 2 for ASAP.
> 
> 
> So , what was Tudor asking for, is your DT for the ebi node (if you are 
> using ebi), or, your NFC SRAM (Nand Flash Controller SRAM) DMA 
> devicetree chunk, so, we can figure out which type of DMA are you using.

I think you're missing something here. We use the DMA engine in memcpy
mode (SRAM -> DRAM), not in device mode (dev -> DRAM or DRAM -> dev).
So there's no dmas prop defined in the DT and there should not be.

Regards,

Boris

> 
> Normally, the ebi should be connected to both DMA0 and DMA1 on those 
> interfaces specified in DT. Which ones you want to use, depends on your 
> setup (and contention on the bus/accesses, like in your case, the HLCDC)
> 
> Thats why we have multiple choices, to pick the right one for each case.
> In our vanilla DT sama5d3.dtsi we do not have DMA described for ebi 
> interface.
> 
> Eugen
> 
>  >> [...]  

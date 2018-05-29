Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935856AbeE2PQL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:16:11 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36290 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935535AbeE2PQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:16:07 -0400
Date: Tue, 29 May 2018 17:15:55 +0200
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
Message-ID: <20180529171555.19dd723f@bbrezillon>
In-Reply-To: <e3c34fb7-4881-3f49-b43b-1b07a8ab865d@microchip.com>
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
        <20180529164911.29820e07@bbrezillon>
        <e3c34fb7-4881-3f49-b43b-1b07a8ab865d@microchip.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 May 2018 18:01:40 +0300
Eugen Hristev <eugen.hristev@microchip.com> wrote:

> [...]
> 
> 
> > 
> > I think you're missing something here. We use the DMA engine in memcpy
> > mode (SRAM -> DRAM), not in device mode (dev -> DRAM or DRAM -> dev).
> > So there's no dmas prop defined in the DT and there should not be.
> > 
> > Regards,
> > 
> > Boris
> >   
> 
> Ok, so the memcpy SRAM <-> DRAM will hog the transfer between DRAM and 
> LCD if my understanding is correct. That's the DMA that Peter wants to 
> disable with his patch ?
> 
> Then we can then try to force NFC SRAM DMA channels to use just DDR port 
> 1 or 2 for memcpy ?

You mean the dmaengine? According to "14.1.3 Master to Slave Access"
that's already the case.

Only DMAC0 can access the NFC SRAM and it's done through DMAC0:IF0,
then access to DDR is going through port DDR port 1 (DMAC0:IF1) or 2
(DMAC0:IF0).

> 
> I have also received a suggestion to try to increase the porches in 
> LCDC_LCDCFG3 .

Yep, Nicolas suggested something similar. Peter, can you try that?

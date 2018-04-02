Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756794AbeDBUcp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 16:32:45 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58464 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756412AbeDBUco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 16:32:44 -0400
Date: Mon, 2 Apr 2018 22:32:32 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Peter Rosin <peda@axentia.se>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, Josh Wu <rainyfeeling@outlook.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] mtd: nand: raw: atmel: add module param to avoid using
 dma
Message-ID: <20180402223232.6213f409@bbrezillon>
In-Reply-To: <20180402222020.1d344c14@bbrezillon>
References: <20180329131054.22506-1-peda@axentia.se>
        <20180329153322.5e2fc1e7@bbrezillon>
        <ed87cf13-a69a-6115-f0a8-5f51c4957d1d@axentia.se>
        <20180329154416.5c1a0013@bbrezillon>
        <b740406a-e91c-67ad-24a3-cbdbe259d00d@axentia.se>
        <20180402142249.7e076a64@bbrezillon>
        <e0d9bd59-8031-e387-676e-dc5811170a0c@axentia.se>
        <20180402212843.164d5d21@bbrezillon>
        <20180402222020.1d344c14@bbrezillon>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Apr 2018 22:20:20 +0200
Boris Brezillon <boris.brezillon@bootlin.com> wrote:

> >   
> > > And
> > > which DDR slave is the target? 7, 8, 9 or 10? More than one?    
> > 
> > This, I don't know. I guess all of them can be used.  
> 
> Looks like I was wrong. According to "Table 15-3. SAMA5D3 Master to
> Slave Access", LCDC port 0 can only access DDR port 2 and LCDC port 1
> can only access DDR port 3.
> 
> Can you try to write 0x3 to 0xFFFFECCC and 0x30 to 0xFFFFECD4?
> 

Oh, one more thing. Changing the priority won't necessarily solve your
problem because of that:

"
If more than one master requests the slave bus, regardless of the
respective masters priorities, no master will be granted
the slave bus for two consecutive runs. A master can only get
back-to-back grants so long as it is the only requesting
master.
"

To solve that, you'll have to play with MATRIX_MCFGy.ULBT (make sure
DMAC0 and DMAC1 have a small enough ULBT that is not 0) or
MATRIX_SCFGx.SLOT_CYCLE (that one is probably harder to get right
since it's expressed in AHB clock cycles).

-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

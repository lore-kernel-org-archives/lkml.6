Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752045AbeEGIez (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 04:34:55 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45894 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751940AbeEGIev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 04:34:51 -0400
Date: Mon, 7 May 2018 10:34:49 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Radu Pirea <radu.pirea@microchip.com>, <cyrille.pitchen@wedev4u.fr>,
        <marek.vasut@gmail.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus - M18064 <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH] spi-nor: Add support for Atmel Dataflash memories
Message-ID: <20180507103449.054ea41b@bbrezillon>
In-Reply-To: <d9b3fffd-dded-b210-e058-13a326b4fb8f@microchip.com>
References: <1519818901-7116-1-git-send-email-radu.pirea@microchip.com>
        <20180504203844.0c09bf6d@bbrezillon>
        <d9b3fffd-dded-b210-e058-13a326b4fb8f@microchip.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On Mon, 7 May 2018 10:23:56 +0200
Nicolas Ferre <nicolas.ferre@microchip.com> wrote:

> On 04/05/2018 at 20:38, Boris Brezillon wrote:
> > Hi Radu,
> > 
> > Sorry for the late reply.
> > 
> > On Wed, 28 Feb 2018 13:55:01 +0200
> > Radu Pirea <radu.pirea@microchip.com> wrote:
> >   
> >> This patch add support in spi-nor for allmost all dataflash memories
> >> supported by old mtd_dataflash driver.  
> > 
> > Those devices clearly use a different instruction set, so I don't think
> > they fit in this framework. Can you tell us why you want to move
> > dataflash support to the SPI NOR framework. I think I know why, but I'd
> > like to get your version. My guess is that some people want to connect
> > dataflash chips to the Atmel QSPI controller, and it's not supported
> > right now because the Atmel QSPI controller implements the SPI-NOR
> > interface and not the generic SPI one, thus preventing anything that
> > is not a SPI NOR from being connected to this controller.
> > 
> > If I'm right, then the solution is to convert the QSPI driver to the
> > spi-mem interface [1] and move it to drivers/spi/.  
> 
> No, I we didn't think about this. Dataflash is not so popular those days 
> and we don't want to revive it anyway. Our QSPI driver has already a lot 
> of things to handle in QSPI-related topics to not mix it with oldies ;-)
> 
> The rationale behind this work is to get rid of the very old dataflash 
> standalone driver and benefit from the whole spi-nor infrastructure like 
> cache coherency management and DMA handling (which were broken in the 
> old dataflash driver in recent kernels).

Still don't think that's a good move, especially since those flashes are
using a completely different instruction set and are not exactly
behaving like SPI NORs. If we need some of the spi-nor logic to help
handle dataflash chips in a more efficient/safe way, then those bits
should be exposed as helpers at the MTD level instead of turning
spi-nor into a Frankenstein framework.

Regards,

Boris

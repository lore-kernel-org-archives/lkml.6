Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751452AbeERGuv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 02:50:51 -0400
Received: from mail.bootlin.com ([62.4.15.54]:48727 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750888AbeERGuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 02:50:50 -0400
Date: Fri, 18 May 2018 08:50:48 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-mtd@lists.infradead.org>, <srv_heupstream@mediatek.com>,
        <guochun.mao@mediatek.com>, <benliang.zhao@mediatek.com>,
        <bayi.cheng@mediatek.com>, <dandan.he@mediatek.com>,
        <sean.wang@mediatek.com>, <ryder.lee@mediatek.com>,
        <xiaolei.li@mediatek.com>, <honghui.zhang@mediatek.com>
Subject: Re: Some questions about the spi mem framework
Message-ID: <20180518085048.515c56a4@bbrezillon>
In-Reply-To: <1526622600.31853.117.camel@mhfsdcap03>
References: <1526355800.31853.45.camel@mhfsdcap03>
        <20180515172551.1adcf276@bbrezillon>
        <1526472699.31853.80.camel@mhfsdcap03>
        <20180516144204.65bb20c5@bbrezillon>
        <1526540304.31853.98.camel@mhfsdcap03>
        <20180517091308.387f0a70@bbrezillon>
        <1526542504.31853.106.camel@mhfsdcap03>
        <20180517094232.20651211@bbrezillon>
        <1526622600.31853.117.camel@mhfsdcap03>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 May 2018 13:50:00 +0800
Xiangsheng Hou <xiangsheng.hou@mediatek.com> wrote:

> Hi Boris,
> 
> On Thu, 2018-05-17 at 09:42 +0200, Boris Brezillon wrote:
> > On Thu, 17 May 2018 15:35:04 +0800
> > Xiangsheng Hou <xiangsheng.hou@mediatek.com> wrote:
> >   
> > > On Thu, 2018-05-17 at 09:13 +0200, Boris Brezillon wrote:  
> > > > On Thu, 17 May 2018 14:58:24 +0800
> > > > Xiangsheng Hou <xiangsheng.hou@mediatek.com> wrote:
> > > >     
> > > > > Hi Boris,
> > > > > 
> > > > > On Wed, 2018-05-16 at 14:42 +0200, Boris Brezillon wrote:    
> > > > > > On Wed, 16 May 2018 20:11:39 +0800
> > > > > > Xiangsheng Hou <xiangsheng.hou@mediatek.com> wrote:
> > > > > >       
> > > > > > > Hi Boris,
> > > > > > > 
> > > > > > > On Tue, 2018-05-15 at 17:25 +0200, Boris Brezillon wrote:      
> > > > > > > > Hi,
> > > > > > > > 
> > > > > > > > On Tue, 15 May 2018 11:43:20 +0800
> > > > > > > > Xiangsheng Hou <xiangsheng.hou@mediatek.com> wrote:
> > > > > > > >         
> > > > > > > > > Hello Boris,
> > > > > > > > > 
> > > > > > > > > I have seen you are working on extend the framework to generically
> > > > > > > > > support spi memory devices.
> > > > > > > > > And, I am working on upstream SPI Nand driver of Mediatek SPI NAND
> > > > > > > > > controller based on your branch[1].        
> > > > > > > > 
> > > > > > > > Great!
> > > > > > > >         
> > > > > > > > > I have some questions need your comment.
> > > > > > > > > 
> > > > > > > > > 1) There is a difference between different SPI NAND Flash when using the
> > > > > > > > > Quad SPI command,for example Macronix,Etron and GigaDevice, 
> > > > > > > > > Quad SPI commands require the Quad Enable bit in Status Register(B0H) to
> > > > > > > > > be set.
> > > > > > > > > However, current spi-mem framework does not have this operation,
> > > > > > > > > do you have a plan to support it?        
> > > > > > > > 
> > > > > > > > I added support for the QE bit in the v7 I sent just a few minutes ago
> > > > > > > > [1].        
> > > > > > > 
> > > > > > > Ok,I have studied v7.
> > > > > > >       
> > > > > > > >         
> > > > > > > > > 
> > > > > > > > > 2) I see that current spi-mem framework doesn't support ECC,
> > > > > > > > > But we need ECC, and we use Mediatek controller's HW ECC
> > > > > > > > > instead of spi nand on-chip ECC,
> > > > > > > > > maybe other companies also have this behavior,
> > > > > > > > > So the ECC part must be implemented in controller's driver.
> > > > > > > > > Will you abstract ECC interface in future?         
> > > > > > > > 
> > > > > > > > Well, I added support for on-die ECC in my v7 since all chips seem to
> > > > > > > > provide this feature. I was initially planning on abstracting ECC
> > > > > > > > engines, but I decided to go for a simpler approach and only support
> > > > > > > > on-die ECC. That does not mean we shouldn't work on this "ECC engine
> > > > > > > > abstraction", just that I wanted to get something out and didn't have
> > > > > > > > time to spend on this topic.
> > > > > > > > 
> > > > > > > > I'd be happy if someone else could work on that aspect though. BTW, do
> > > > > > > > you plan to use this engine [2], or is this yet another ECC engine?        
> > > > > > > 
> > > > > > > Yes,I plan to use this ecc engine[2].      
> > > > > > 
> > > > > > Cool. That probably means we'll have to move the driver one level up
> > > > > > (in drivers/mtd/nand) and work on this ECC engine interface I was
> > > > > > talking about.
> > > > > >        
> > > > > > > > > 3) You know, some nand controller need configure their registers when
> > > > > > > > > getting some information(page size, spare size) of nand flash,
> > > > > > > > > But the spi-mem framework doesn't has an interface for scanning NAND
> > > > > > > > > flash, when controller driver initialization.        
> > > > > > > > 
> > > > > > > > You seem to mix 2 different things:
> > > > > > > > - spi-mem: this is generic interface provided by the SPI framework to
> > > > > > > >   send spi_mem_op. There's nothing NOR or NAND specific in there, and
> > > > > > > >   I'd like it to stay like that as much as possible
> > > > > > > > - spinand: this the spi-mem driver that is dealing with SPI NAND
> > > > > > > >   devices, and this is where all the code related to SPI NAND support
> > > > > > > >   should end up.
> > > > > > > > 
> > > > > > > > Can you tell me exactly why your SPI controller needs such a detailed
> > > > > > > > description? Is it able to program/read pages or erase blocks on its
> > > > > > > > own? Do you have a spec of this controller publicly available?        
> > > > > > > 
> > > > > > > For Mediatek SPI Nand controller,I have to configure registers for ECC
> > > > > > > engine,page format and spare format according to nand information just
> > > > > > > like[3] in mtk_nfc_hw_runtime_config() function.      
> > > > > > 
> > > > > > So it's all related to the NAND controller, nothing specific to the SPI
> > > > > > controller, right?      
> > > > > 
> > > > > Yes,we use NAND controller rather than SPI controller.    
> > > > 
> > > > Sorry, I meant ECC engine, not NAND controller.    
> > > 
> > > It's related to ECC engine and NAND controller.  
> > 
> > Not sure I understand what you call NAND controller. Is it a SPI NAND
> > controller or the raw NAND controller available in
> > drivers/mtd/nand/raw? And if it's a SPI NAND controller, does that mean
> > MTK implements a NAND dedicated logic on top of its SPI controller?
> >   
> 
> Just as the attachment, MTK Nand controller can support Parallel Nand
> and SPI Nand via Parallel Nand interface or SPI interface,they share the
> MTK ECC engine.

Thanks for sharing this image, but unfortunately that's not enough to
understand how each block in the diagram works and how it should be
programmed.
Looks like your SPI NAND controller does not fit in the SPI mem
controller and is really dedicated to SPI NANDs, but I can't tell
for sure. 

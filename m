Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032844AbeE0QbA (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 12:31:00 -0400
Received: from mail.bootlin.com ([62.4.15.54]:52581 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032801AbeE0Qa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 12:30:59 -0400
Date: Sun, 27 May 2018 18:30:55 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Stefan Agner <stefan@agner.ch>,
        Benjamin Lindqvist <benjamin.lindqvist@endian.se>, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, thierry.reding@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        Lucas Stach <dev@lynxeye.de>, richard@nod.at, marcel@ziswiler.com,
        krzk@kernel.org, digetx@gmail.com, jonathanh@nvidia.com,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        Mirza Krak <mirza.krak@gmail.com>, linux-mtd@lists.infradead.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 2/5] mtd: rawnand: add NVIDIA Tegra NAND Flash
 controller driver
Message-ID: <20180527183055.05c4d197@bbrezillon>
In-Reply-To: <20180527175403.065a135d@xps13>
References: <cover.1526990589.git.stefan@agner.ch>
        <86fdf19ec92b732709732fb60199f16488b4b727.1526990589.git.stefan@agner.ch>
        <CAGefG55kvShaLhNYsFznbOq0_6RNbb+eJ47DLnnU9qRRpwu-iA@mail.gmail.com>
        <d8d6cb9fcd8ce7ea5c13b227012de6d2@agner.ch>
        <CAGefG56khQ2835c2QCteit7FuL_yG+APpj6-4vRRPxztFtkAMA@mail.gmail.com>
        <20180524135335.6aa0b7a4@bbrezillon>
        <146a3abbbff4dcef30ad662a0fb85ff1@agner.ch>
        <20180527161832.1152be6e@xps13>
        <20180527171337.002eeb9f@bbrezillon>
        <20180527175403.065a135d@xps13>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 May 2018 17:54:03 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hi Boris,
> 
> On Sun, 27 May 2018 17:13:37 +0200, Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> 
> > On Sun, 27 May 2018 16:18:32 +0200
> > Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >   
> > > Hi Stefan,
> > > 
> > > On Thu, 24 May 2018 14:19:18 +0200, Stefan Agner <stefan@agner.ch>
> > > wrote:
> > >     
> > > > On 24.05.2018 13:53, Boris Brezillon wrote:      
> > > > > Hi Benjamin,
> > > > > 
> > > > > On Thu, 24 May 2018 13:30:14 +0200
> > > > > Benjamin Lindqvist <benjamin.lindqvist@endian.se> wrote:
> > > > >         
> > > > >> Hi Stefan,
> > > > >>
> > > > >> It seems to me that a probe similar to what the BootROM does shouldn't
> > > > >> be awfully complicated to implement - just cycle through the switch
> > > > >> cases in case of an ECC error. But I guess that's more of an idea for
> > > > >> further improvements rather than a comment to the patch set under
> > > > >> review.        
> > > > > 
> > > > > Nope, not really an option, because you're not guaranteed that the NAND
> > > > > will be used as a boot media, and the first page or first set of pages
> > > > > might just be erased.
> > > > >         
> > > > 
> > > > Yeah I did not meant probing like the Boot ROM does.
> > > > 
> > > > What I meant was using only the ECC modes which are supported by the
> > > > Boot ROM when the driver tries to choose a viable mode. So that would
> > > > be:
> > > > - RS t=4
> > > > - BCH t=8
> > > > - BCH t=16
> > > > 
> > > > Maybe we could add a property to enable that behavior:
> > > > 
> > > > tegra,use-bootable-ecc-only;      
> > > 
> > > I'm not sure a property is needed.
> > > 
> > > As there is currently no official user of this driver, why not turning
> > > mandatory the nand-ecc-xxx properties?    
> > 
> > Not a big fan of this solution. We already have a few cases where the
> > NAND part was changed on a design and the new NAND had different ECC
> > requirements, With your suggestion, that means creating a new .dts file
> > for each possible NAND part.
> > 
> > Note that having a solution that picks the best ECC config based on
> > chip->ecc_xxx_ds should be the preferred approach. nand-ecc- props are
> > mainly here to address the case where you need/want to assign a config
> > that does not match the ECC requirements exposed by the chip.  
> 
> Ok, that's right it's a problem.
> 
> But then the driver has to choose a default algorithm if none is given.

Yep.

> In this case, should we select the one that fits best the NAND chip
> requirements, or shall we limit to the ones supported by the BootRom?

We should limit to the one used by the BootROM only if the NAND is used
as a boot medium.

> 
> The underlying question is: will we add a tegra,use-bootable-ecc-only
> property?

I guess this one is fine, because it's only adding a constraint on the
possible ECC modes that can be used, it's not forcing a specific ECC
strength.

Note that if we want to make this property generic we could name it
nand-is-boot-medium.

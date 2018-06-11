Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 3VGCHo4oHlusDwAAmS7hNA
	; Mon, 11 Jun 2018 07:46:35 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 57A07607A4; Mon, 11 Jun 2018 07:46:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B298160385;
	Mon, 11 Jun 2018 07:46:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B298160385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932456AbeFKHqc (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 03:46:32 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44109 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932395AbeFKHqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 03:46:31 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B078B20794; Mon, 11 Jun 2018 09:46:26 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-128-7.w90-88.abo.wanadoo.fr [90.88.9.7])
        by mail.bootlin.com (Postfix) with ESMTPSA id 46A35207A5;
        Mon, 11 Jun 2018 09:46:16 +0200 (CEST)
Date: Mon, 11 Jun 2018 09:46:16 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>
Cc: Frieder Schrempf <frieder.schrempf@exceet.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        David Wolfe <david.wolfe@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
        Han Xu <han.xu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Message-ID: <20180611094616.5c8f82cf@bbrezillon>
In-Reply-To: <DB6PR0402MB2838D514CF38AC5E6C004E8499780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
        <1527686082-15142-4-git-send-email-frieder.schrempf@exceet.de>
        <DB6PR0402MB283845A1A98672FE63C89550997B0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180608145130.09f979f9@bbrezillon>
        <DB6PR0402MB2838D514CF38AC5E6C004E8499780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yogesh,

On Mon, 11 Jun 2018 06:31:00 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> 
> > 
> > Observation 2:
> > I have observed data sanity issue after performing read/write 
> > operations using MTD interface. Explained below
> > 
> > root:~# mtd_debug erase /dev/mtd0 0x1000000 0x40000
> > Erased 262144 bytes from address 0x01000000 in flash                      --> Erase at address 0x1000000 of erase size 0x40000
> > root:~# mtd_debug read /dev/mtd0 0x0 0x100 rp
> > Copied 256 bytes from address 0x00000000 in flash to rp                   --> Read 0x100 bytes from flash from address 0x0 in file rp
> > root:~# mtd_debug write /dev/mtd0 0x1000000 0x100 rp
> > Copied 256 bytes from rp to address 0x01000000 in flash                   --> Write 0x100 bytes to flash address 0x1000000 from file rp
> > root:~# mtd_debug read /dev/mtd0 0x1000000 0x100 wp
> > Copied 256 bytes from address 0x01000000 in flash to wp                  --> Read 0x100 bytes from flash from address 0x1000000 in file wp
> > root:~# diff rp wp                                                                                           --> compare both rp and wp files, if they are different output comes on console stating file are different
> > Files rp and wp differ
> > root:~# hexdump wp
> > 0000000 aa55 aa55 0000 8010 541c 4000 0040 0000
> > 0000010 0000 0000 0000 0000 0000 0000 0000 000a
> > 0000020 0000 0030 0000 0000 11a0 00a0 2580 0000
> > 0000030 0000 0000 0040 0000 005b 0000 0000 0000
> > 0000040 ffff ffff ffff ffff ffff ffff ffff ffff
> > *
> > 0000100
> > root:~# hexdump rp
> > 0000000 aa55 aa55 0000 8010 541c 4000 0040 0000
> > 0000010 0000 0000 0000 0000 0000 0000 0000 000a
> > 0000020 0000 0030 0000 0000 11a0 00a0 2580 0000
> > 0000030 0000 0000 0040 0000 005b 0000 0000 0000
> > 0000040 2403 0000 0000 0000 0000 0000 0000 0000
> > 0000050 0000 0000 0000 0000 0000 0000 0000 0000
> > *
> > 0000070 0011 0000 09e7 0000 0000 4411 9555 0050
> > 0000080 0000 0000 0000 0000 f9bc afa1 0404 31e0
> > 0000090 0000 0000 0400 31e0 0000 2010 08dc 31eb
> > 00000a0 2880 0050 1300 31eb 4e20 8010 0000 80ff
> > 00000b0 0000 0000 beef dead beef dead beef dead
> > 00000c0 beef dead beef dead beef dead beef dead
> > *
> > 0000100
> > root:~#
> > 
> > In hexdump output of the file which being read from address 0x1000000,wp, it can be observed that only first 64 bytes (0x40) are written on the flash.
> > 
> > Observation 3:
> > As we can support JFFS2 filesystem on NOR flash, so we can expect JFFS2 commands should work fine on NOR flash.
> > But with this driver change my mount command is not working.
> > 
> > In my target there are 2 flash slave devices connected, and I have given argument to create MTD partition like "mtdparts=20c0000.quadspi-1:5M(rcw),10M(test),46M(rootfs) " for 2nd flash.
> > Below is output for /proc/mtd commands
> >     root@ls1012ardb:~# cat /proc/mtd
> >     dev:    size   erasesize  name
> >     mtd0: 04000000 00040000 "20c0000.quadspi-0"   --> First 64MB flash
> >     mtd1: 00500000 00040000 "rcw"                               --> Second 64 MB flash device, 3 MTD partition are created for it.
> >     mtd2: 00a00000 00040000 "test"
> >     mtd3: 02e00000 00040000 "rootfs"
> > 
> >     root@ls1012ardb:~# mkdir /media/ram ; flash_eraseall /dev/mtd3
> >     flash_eraseall has been replaced by `flash_erase <mtddev> 0 0`; please use it
> >     Erasing 256 Kibyte @ 0 --  0 % complete [   18.299929] random: crng init done
> >     Erasing 256 Kibyte @ 2dc0000 -- 100 % complete
> >     root@ls1012ardb:~# mount -t jffs2 /dev/mtdblock3 /media/ram/
> > 
> > This command didn't finish successfully and there are lot of messages coming on console mentioning failure in jffs2_scan_eraseblock()
> >     [  187.118677] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x013c0000: 0x2886 instead
> >     [  187.128159] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x013c0004: 0x7a3b instead
> >     [  187.137641] jffs2: jffs2_scan_eraseblock(): Magic bitmask 
> > 0x1985 not found at 0x013c0008: 0xb10f instead
> > 
> > If I remove this patch series and check with older implementation, JFFS2 mounting is working fine.  
> 
> Problems 2 and 3 should definitely be fixed. That's weird because I remember that Frieder tested the new driver with a NOR chip, maybe not with JFFS2 though.
> 
> For write issue, it would be happening due to the changes pushed in spi-mem framework.

Now I understand why Frieder didn't face this issue: he was testing on
an imx6 which has a 512 bytes TX FIFO, while you're probably testing on
a vhybrid or layerscape platform which only has a 64 bytes TX FIFO.

I think it's time to accept having partial page writes. This has come
up several times (last time was [1]) and it looks like the fsl quadspi
driver was already doing this sort of things (well hidden in the probe
path [2] :-)).

Marek, any comment on that?

Regards,

Boris

[1]https://patchwork.ozlabs.org/patch/905507/
[2]https://elixir.bootlin.com/linux/v4.17/source/drivers/mtd/spi-nor/fsl-quadspi.c#L1106

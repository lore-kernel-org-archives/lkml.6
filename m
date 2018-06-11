Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ZD6lK/hLHludJgAAmS7hNA
	; Mon, 11 Jun 2018 10:16:24 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A19D4607E7; Mon, 11 Jun 2018 10:16:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3550960541;
	Mon, 11 Jun 2018 10:16:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3550960541
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932717AbeFKKQV (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 06:16:21 -0400
Received: from mail.bootlin.com ([62.4.15.54]:48104 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932515AbeFKKQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 06:16:20 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 45FA4207A5; Mon, 11 Jun 2018 12:16:18 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-37-30.w90-88.abo.wanadoo.fr [90.88.156.30])
        by mail.bootlin.com (Postfix) with ESMTPSA id D86062069C;
        Mon, 11 Jun 2018 12:16:17 +0200 (CEST)
Date: Mon, 11 Jun 2018 12:16:18 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc: "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
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
Message-ID: <20180611121618.40f4b609@bbrezillon>
In-Reply-To: <DB6PR0402MB283825171DF93AD3C8590DD799780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
        <1527686082-15142-4-git-send-email-frieder.schrempf@exceet.de>
        <DB6PR0402MB283845A1A98672FE63C89550997B0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180608145130.09f979f9@bbrezillon>
        <DB6PR0402MB2838D514CF38AC5E6C004E8499780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180611094616.5c8f82cf@bbrezillon>
        <DB6PR0402MB283825171DF93AD3C8590DD799780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jun 2018 09:38:14 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> > > Observation 3:
> > > As we can support JFFS2 filesystem on NOR flash, so we can expect JFFS2 commands should work fine on NOR flash.
> > > But with this driver change my mount command is not working.
> > > 
> > > In my target there are 2 flash slave devices connected, and I have given argument to create MTD partition like "mtdparts=20c0000.quadspi-1:5M(rcw),10M(test),46M(rootfs) " for 2nd flash.
> > > Below is output for /proc/mtd commands
> > >     root@ls1012ardb:~# cat /proc/mtd
> > >     dev:    size   erasesize  name
> > >     mtd0: 04000000 00040000 "20c0000.quadspi-0"   --> First 64MB flash
> > >     mtd1: 00500000 00040000 "rcw"                               --> Second 64 MB flash device, 3 MTD partition are created for it.
> > >     mtd2: 00a00000 00040000 "test"
> > >     mtd3: 02e00000 00040000 "rootfs"

When I do mtd1 + mtd2 + mtd3, I end up with 0x3d00000 instead of
0x4000000. Is that normal? Do you reserve a bit of space at the end or
is it that rcw is not starting at 0?

> > > 
> > >     root@ls1012ardb:~# mkdir /media/ram ; flash_eraseall /dev/mtd3
> > >     flash_eraseall has been replaced by `flash_erase <mtddev> 0 0`; please use it
> > >     Erasing 256 Kibyte @ 0 --  0 % complete [   18.299929] random: crng init done
> > >     Erasing 256 Kibyte @ 2dc0000 -- 100 % complete
> > >     root@ls1012ardb:~# mount -t jffs2 /dev/mtdblock3 /media/ram/
> > > 
> > > This command didn't finish successfully and there are lot of messages coming on console mentioning failure in jffs2_scan_eraseblock()
> > >     [  187.118677] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x013c0000: 0x2886 instead

Did you try to create a smaller partition? Maybe we have a problem when
accessing addresses higher than X with the new driver (X to be
determined).

> > >     [  187.128159] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x013c0004: 0x7a3b instead
> > >     [  187.137641] jffs2: jffs2_scan_eraseblock(): Magic bitmask
> > > 0x1985 not found at 0x013c0008: 0xb10f instead
> > > 

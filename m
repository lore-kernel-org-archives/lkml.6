Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F9AECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 21:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AED12082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 21:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AED12082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbeJYFeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 01:34:14 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55852 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbeJYFeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 01:34:14 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D49FC208A4; Wed, 24 Oct 2018 23:04:32 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0C12B20726;
        Wed, 24 Oct 2018 23:04:32 +0200 (CEST)
Date:   Wed, 24 Oct 2018 23:04:32 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        <linux-gpio@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Peter Rosin <peda@axentia.se>,
        Mike Shettel <mshettel@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v9 6/9] i3c: master: Add driver for Cadence IP
Message-ID: <20181024230432.66dd71df@bbrezillon>
In-Reply-To: <99a506e3-d9d5-0d3e-26e1-031447c14857@ti.com>
References: <20181022133404.2061-1-boris.brezillon@bootlin.com>
        <20181022133404.2061-7-boris.brezillon@bootlin.com>
        <20181024202048.7e3534f7@bbrezillon>
        <99a506e3-d9d5-0d3e-26e1-031447c14857@ti.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Oct 2018 15:25:17 -0500
Grygorii Strashko <grygorii.strashko@ti.com> wrote:

> On 10/24/18 1:20 PM, Boris Brezillon wrote:
> > Hi Arnd,
> > 
> > On Mon, 22 Oct 2018 15:34:01 +0200
> > Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> > 
> >   
> >> +
> >> +static void cdns_i3c_master_rd_from_rx_fifo(struct cdns_i3c_master *master,
> >> +					    u8 *bytes, int nbytes)
> >> +{
> >> +	readsl(master->regs + RX_FIFO, bytes, nbytes / 4);  
> > 
> > Vitor reported a problem with readsl(): this function expects the 2nd
> > argument to be aligned on 32-bit, which is not guaranteed here. Unless
> > you see a better solution, I'll switch back to a loop doing:
> > 
> > 	for (i = 0; i < nbytes; i += 4) {
> > 		u32 tmp = __raw_readl(...);  
> 
> Pls, do not use __raw io.

Except this is exactly what I want here, unless you have a
replacement for "readl() without a mem-barrier and without endianness
conversion"

> 
> > 		memcpy(bytes + i, &tmp,
> > 		       nbytes - i  > 4 ? 4 : nbytes - i);
> > 	}
> >   
> >> +	if (nbytes & 3) {
> >> +		u32 tmp;
> >> +
> >> +		readsl(master->regs + RX_FIFO, &tmp, 1);
> >> +		memcpy(bytes + (nbytes & ~3), &tmp, nbytes & 3);
> >> +	}
> >> +}  
> > 
> > Regards,
> > 
> > Boris
> >   
> 


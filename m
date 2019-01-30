Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A27C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9542083B
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548860934;
	bh=7tSXuv1G3q0TZTT11mY3TM9600zhP/Lt29G6XlH6Kvg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=A/xhLH1joXru9t3cVmvKGx2m9Yb1Uh37IiSI698CjbpJ+opc93ptgoxxdBTPyB3oi
	 ZVTg/tVlLAQzRz5aNfOv41cMSkqZ+aq9eU99/JwepuBAhzVL1uvf7qovTKMYvT+6Te
	 ENBvy+IzEB3YMIbx7S5PZmiXN/u+zIQv5fsj3HOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731618AbfA3PIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:08:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:55760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731596AbfA3PIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:08:50 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A6F720989;
        Wed, 30 Jan 2019 15:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548860929;
        bh=7tSXuv1G3q0TZTT11mY3TM9600zhP/Lt29G6XlH6Kvg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zJa+P08V6zahu54Z+HGd75lTdIj/T+74SYRgRGPlnEWi6yJXfEbdzChLO00T4VR5j
         GrnCi/uWar3GTTSFFbEhKAOKmjZ1mxcmpjzcVOobcDZJZztW9eWlzzw+sloSxNCZj6
         Y9U/CZj6ahHYenu5hXpbzPDKnnWTWHEQUnkIsdtw=
Date:   Wed, 30 Jan 2019 16:08:39 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Nguyen An Hoan <na-hoan@jinso.co.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] eeprom: at25: SPI transfer improvements
Message-ID: <20190130160839.55f99e63@bbrezillon>
In-Reply-To: <20190130145054.GA990@kroah.com>
References: <20190118140525.29189-1-geert+renesas@glider.be>
        <20190118230740.44239fcf@bbrezillon>
        <CAMuHMdVfVHUQnjwvFikqQJ8HBD+0A7DSCTcdDN4e7V4c=4Usug@mail.gmail.com>
        <20190130145054.GA990@kroah.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Wed, 30 Jan 2019 15:50:54 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Tue, Jan 29, 2019 at 08:02:37PM +0100, Geert Uytterhoeven wrote:
> > Hi Boris,
> > 
> > On Fri, Jan 18, 2019 at 11:07 PM Boris Brezillon <bbrezillon@kernel.org> wrote:  
> > > Did you consider converting this driver to spimem? Looks like the
> > > protocol used to communicate with the memory resembles the one used on
> > > SPI NANDs/NORs and fits pretty well in the spi_mem_op representation.
> > >
> > > By doing this conversion you'd allow people to connect an AT25 EEPROM
> > > to an advanced SPI controller that does not support regular SPI
> > > transfers and you wouldn't have to forge SPI messages manually.
> > >
> > > Here is a patch (only compile tested) doing that. The diffstat is not in
> > > favor of this conversion, but I find the resulting code cleaner and more
> > > future proof.  
> > 
> > Thanks, seems to work fine, with the 512-byte 25LC040 I have!
> > 
> > Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > 
> > I did notice that the first two-byte transfer (command+offset) of each
> > message is now split in two one-byte transfers, though.  
> 
> Ok, I'll drop this patch series and wait for the updated version to be
> sent out :)

I'd like to further simplify the patch by using the recently introduced
devm_spi_mem_dirmap_create() function (queued to Mark's spi/for-5.1
branch), which means I'll have to wait v5.1-rc1 before sending a new
version. I'll let you decide if it's worth applying Geert's patches in
the meantime.

Regards,

Boris

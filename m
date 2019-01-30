Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB88BC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CAE120989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548859859;
	bh=I2mNUizMUdF4Sbvr3crwGZ6ivgszvULLCp9Cz/xQt3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l/PbkjLhT4Oxu2R/aHnLdB5AFe4b8HC8E05KvT8FASCKsFuZledMaDxUI0iDpr+4W
	 1DoUqkujPv1kCzpbVX6VYwpg6ui/QOTZoGIYce3iSGGo1QJe9j1SmnFJClPfGMi1d7
	 JFmPJkmX0K/jGdXiTLskl3J6D4fwPZbI0pB/qWcE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731379AbfA3Ou6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 09:50:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:51092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbfA3Ou5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 09:50:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CB3E20882;
        Wed, 30 Jan 2019 14:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548859856;
        bh=I2mNUizMUdF4Sbvr3crwGZ6ivgszvULLCp9Cz/xQt3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fVHpYx1rWMkMg/4qFSp7krwrXdeFXBlbvaCVM6GAYzXXBi1/fZv020gzigD74SfKE
         VZulMT1eYvgQM9pR1vLSWU2GuZwkHljEj7t/+ref7cun20BBkB5sm6YYYP3/aaESRK
         TA3YLLGAOGHoWMqNr5QAPp0x2ciVv/XZl7vsjeQ0=
Date:   Wed, 30 Jan 2019 15:50:54 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Nguyen An Hoan <na-hoan@jinso.co.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] eeprom: at25: SPI transfer improvements
Message-ID: <20190130145054.GA990@kroah.com>
References: <20190118140525.29189-1-geert+renesas@glider.be>
 <20190118230740.44239fcf@bbrezillon>
 <CAMuHMdVfVHUQnjwvFikqQJ8HBD+0A7DSCTcdDN4e7V4c=4Usug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVfVHUQnjwvFikqQJ8HBD+0A7DSCTcdDN4e7V4c=4Usug@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 08:02:37PM +0100, Geert Uytterhoeven wrote:
> Hi Boris,
> 
> On Fri, Jan 18, 2019 at 11:07 PM Boris Brezillon <bbrezillon@kernel.org> wrote:
> > Did you consider converting this driver to spimem? Looks like the
> > protocol used to communicate with the memory resembles the one used on
> > SPI NANDs/NORs and fits pretty well in the spi_mem_op representation.
> >
> > By doing this conversion you'd allow people to connect an AT25 EEPROM
> > to an advanced SPI controller that does not support regular SPI
> > transfers and you wouldn't have to forge SPI messages manually.
> >
> > Here is a patch (only compile tested) doing that. The diffstat is not in
> > favor of this conversion, but I find the resulting code cleaner and more
> > future proof.
> 
> Thanks, seems to work fine, with the 512-byte 25LC040 I have!
> 
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> I did notice that the first two-byte transfer (command+offset) of each
> message is now split in two one-byte transfers, though.

Ok, I'll drop this patch series and wait for the updated version to be
sent out :)

thanks,

greg k-h

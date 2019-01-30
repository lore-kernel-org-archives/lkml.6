Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C384C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F3B20989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548860156;
	bh=7G5T/KsM8XC2WiSdPDQavJovP2/zcBe1Um2PBAdj+3U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=hyuAi5m3dJfWKa7lMpXdn52HpXwZ56Kd2kIUq7VgybAANkGJ1SsWiz9v4Htk2XgvW
	 +49QIJ1UL4qxcHP1fplaHy3iTr1dlimEWaIZKiZae+gDHPEmR75HXjkXQ2mpgqbW78
	 8Waw55Lfovj9tzFablA7RjZ37THKkxlLnzk7/UCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbfA3Ozy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 09:55:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:51884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfA3Ozx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 09:55:53 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26E6720882;
        Wed, 30 Jan 2019 14:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548860153;
        bh=7G5T/KsM8XC2WiSdPDQavJovP2/zcBe1Um2PBAdj+3U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qYrh5hlh2iq0rXjNpgxGqwFfe9+n0Q19rZ5e+wKjmh5QIhPMaXcuVuFbSBk/3FuvK
         Fnvwybt9jQXos2z9hGma+lbCo+R52J7f1m/uVb3zORhES0EJtEUxNuLeQ2VnS9MZ90
         m57b0AF9SbonKN69LhTV7QsYGSpIO6amJ3+I6f48=
Date:   Wed, 30 Jan 2019 15:55:43 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Nguyen An Hoan <na-hoan@jinso.co.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] eeprom: at25: SPI transfer improvements
Message-ID: <20190130155543.5ab749b5@bbrezillon>
In-Reply-To: <CAMuHMdVfVHUQnjwvFikqQJ8HBD+0A7DSCTcdDN4e7V4c=4Usug@mail.gmail.com>
References: <20190118140525.29189-1-geert+renesas@glider.be>
        <20190118230740.44239fcf@bbrezillon>
        <CAMuHMdVfVHUQnjwvFikqQJ8HBD+0A7DSCTcdDN4e7V4c=4Usug@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2019 20:02:37 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

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

That's something we can optimize in drivers/spi/spi-mem.c if you think
it makes a difference.

Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE2EC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF6B02184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548877265;
	bh=fF9/4EGUIy+N2ANoKElFW6gKSOdMRwW+wEjrtwpy2h8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vpeN1L0/SAzTSUDfMVktOlHGbNvaF6KMtED21TWKsrB/I5Ku7ovMXdmJ5dIRtvoir
	 TPGyiGUwvr/q/U9Q2az/uXfm3lwNPPNziTkI5plguJskkbNTmHAbQObTLnVgBsQekp
	 taNP2hECCOUbjBKWYzm3yH+O1VxGA5hVT9Cj/mgI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387762AbfA3TlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 14:41:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:55194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387587AbfA3TlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 14:41:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BFCD21473;
        Wed, 30 Jan 2019 19:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548877262;
        bh=fF9/4EGUIy+N2ANoKElFW6gKSOdMRwW+wEjrtwpy2h8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GCZROYdBYUgcGe/xisVPs0TbO76M4Ecr24WZfMBWq7Vr+AKmaTDKm+bgBUeNZK/0x
         u9zdx8tkTqGVz4QtgJp1kKDxHHobnJhjTqFsrDt7wgCW+XBJHRtyVlhgxQWcFwNKC2
         smUY74T1efkc2KEb2g2HTjWKIYoz7kpYkXKGXKE0=
Date:   Wed, 30 Jan 2019 20:40:59 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Boris Brezillon <bbrezillon@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Nguyen An Hoan <na-hoan@jinso.co.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] eeprom: at25: SPI transfer improvements
Message-ID: <20190130194059.GC21181@kroah.com>
References: <20190118140525.29189-1-geert+renesas@glider.be>
 <20190118230740.44239fcf@bbrezillon>
 <CAMuHMdVfVHUQnjwvFikqQJ8HBD+0A7DSCTcdDN4e7V4c=4Usug@mail.gmail.com>
 <20190130145054.GA990@kroah.com>
 <20190130160839.55f99e63@bbrezillon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130160839.55f99e63@bbrezillon>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 04:08:39PM +0100, Boris Brezillon wrote:
> Hi Greg,
> 
> On Wed, 30 Jan 2019 15:50:54 +0100
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > On Tue, Jan 29, 2019 at 08:02:37PM +0100, Geert Uytterhoeven wrote:
> > > Hi Boris,
> > > 
> > > On Fri, Jan 18, 2019 at 11:07 PM Boris Brezillon <bbrezillon@kernel.org> wrote:  
> > > > Did you consider converting this driver to spimem? Looks like the
> > > > protocol used to communicate with the memory resembles the one used on
> > > > SPI NANDs/NORs and fits pretty well in the spi_mem_op representation.
> > > >
> > > > By doing this conversion you'd allow people to connect an AT25 EEPROM
> > > > to an advanced SPI controller that does not support regular SPI
> > > > transfers and you wouldn't have to forge SPI messages manually.
> > > >
> > > > Here is a patch (only compile tested) doing that. The diffstat is not in
> > > > favor of this conversion, but I find the resulting code cleaner and more
> > > > future proof.  
> > > 
> > > Thanks, seems to work fine, with the 512-byte 25LC040 I have!
> > > 
> > > Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > 
> > > I did notice that the first two-byte transfer (command+offset) of each
> > > message is now split in two one-byte transfers, though.  
> > 
> > Ok, I'll drop this patch series and wait for the updated version to be
> > sent out :)
> 
> I'd like to further simplify the patch by using the recently introduced
> devm_spi_mem_dirmap_create() function (queued to Mark's spi/for-5.1
> branch), which means I'll have to wait v5.1-rc1 before sending a new
> version. I'll let you decide if it's worth applying Geert's patches in
> the meantime.

If you all want Geert's patches merged now, someone has to resend them
please :)

thanks,

greg k-h

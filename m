Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F95CECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11EC20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:10:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E11EC20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388119AbeGWVM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:12:57 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36793 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728293AbeGWVM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:12:56 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3A0C320737; Mon, 23 Jul 2018 22:10:06 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id E33CB203EC;
        Mon, 23 Jul 2018 22:10:05 +0200 (CEST)
Date:   Mon, 23 Jul 2018 22:10:02 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Brian Norris <computersforpeace@gmail.com>
Cc:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, dwmw2@infradead.org,
        boris.brezillon@free-electrons.com, marek.vasut@gmail.com,
        richard@nod.at, cyrille.pitchen@wedev4u.fr
Subject: Re: [PATCHv3 2/2] mtd: m25p80: restore the status of SPI flash when
 exiting
Message-ID: <20180723221002.736e0830@bbrezillon>
In-Reply-To: <20180723181350.GA58212@ban.mtv.corp.google.com>
References: <20171206025342.7266-1-Zhiqiang.Hou@nxp.com>
        <20171206025342.7266-3-Zhiqiang.Hou@nxp.com>
        <20180723181350.GA58212@ban.mtv.corp.google.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian,

On Mon, 23 Jul 2018 11:13:50 -0700
Brian Norris <computersforpeace@gmail.com> wrote:

> Hello,
> 
> I noticed this got merged, but I wanted to put my 2 cents in here:

I wish you had replied to this thread when it was posted (more than
6 months ago). Reverting the patch now implies making some people
unhappy because they'll have to resort to their old out-of-tree
hacks :-(.

> 
> On Wed, Dec 06, 2017 at 10:53:42AM +0800, Zhiqiang Hou wrote:
> > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > 
> > Restore the status to be compatible with legacy devices.
> > Take Freescale eSPI boot for example, it copies (in 3 Byte
> > addressing mode) the RCW and bootloader images from SPI flash
> > without firing a reset signal previously, so the reboot command
> > will fail without reseting the addressing mode of SPI flash.
> > This patch implement .shutdown function to restore the status
> > in reboot process, and add the same operation to the .remove
> > function.  
> 
> We have previously rejected this patch multiple times, because the above
> comment demonstrates a broken product.

If we were to only support working HW parts, I fear Linux would not
support a lot of HW (that's even more true when it comes to flashes :P).

> You cannot guarantee that all
> reboots will invoke the .shutdown() method -- what about crashes? What
> about watchdog resets? IIUC, those will hit the same broken behavior,
> and have unexepcted behavior in your bootloader.

Yes, there are corner cases that are not addressed with this approach,
but it still seems to improve things. Of course, that means the
user should try to re-route all HW reset sources to SW ones (RESET input
pin muxed to the GPIO controller, watchdog generating an interrupt
instead of directly asserting the RESET output pin), which is not always
possible, but even when it's not, isn't it better to have a setup that
works fine 99% of the time instead of 50% of the time?

> 
> I suppose one could argue for doing this in remove(), but AIUI you're
> just papering over system bugs by introducing the shutdown() function
> here. Thus, I'd prefer we drop the shutdown() method to avoid misleading
> other users of this driver.

I understand your point. But if the problem is about making sure people
designing new boards get that right, why not complaining at probe time
when things are wrong?

I mean, spi_nor_restore() seems to only do something on very specific
NORs (those on which a SW RESET does not resets the addressing
mode). So, how about adding a flag that says "my board has the NOR HW
RESET pin wired" (there would be a DT props to set that flag). Then you
add a WARN_ON() when this flag is not set and a NOR chip impacted by
this bug is detected. This way you make sure people are informed that
they're doing something wrong, and for those who can't change their HW
(because it's already widely deployed), you have a fix that improve
things.

Regards,

Boris

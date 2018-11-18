Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C648C04EBC
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 10:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E07212086A
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 10:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E07212086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbeKRVFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 16:05:25 -0500
Received: from mail.bootlin.com ([62.4.15.54]:52266 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbeKRVFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 16:05:24 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id AFA6220791; Sun, 18 Nov 2018 11:45:24 +0100 (CET)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 64913206D8;
        Sun, 18 Nov 2018 11:45:14 +0100 (CET)
Date:   Sun, 18 Nov 2018 11:45:13 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Josh Wu <rainyfeeling@outlook.com>
Subject: Re: [PATCH v2 5/9] mtd: nand: atmel: fix OF child-node lookup
Message-ID: <20181118114514.78a9e3ee@bbrezillon>
In-Reply-To: <20181115142648.GJ19900@localhost>
References: <20180827082153.22537-1-johan@kernel.org>
        <20180827082153.22537-6-johan@kernel.org>
        <20180827102820.3abf7291@bbrezillon>
        <20180827084414.GZ14967@localhost>
        <20180827104842.26bce912@bbrezillon>
        <20180827094423.GA14967@localhost>
        <CAL_Jsq+fiM8E-za-fKufgDuoDqu3DY5a4bgZOuF3Ssvj2=6ayg@mail.gmail.com>
        <20181023205117.745a8f97@bbrezillon>
        <20181115142648.GJ19900@localhost>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Nov 2018 15:26:48 +0100
Johan Hovold <johan@kernel.org> wrote:

> On Tue, Oct 23, 2018 at 08:51:17PM +0200, Boris Brezillon wrote:
> > On Tue, 23 Oct 2018 13:28:09 -0500
> > Rob Herring <robh+dt@kernel.org> wrote:
> >   
> > > On Mon, Aug 27, 2018 at 4:44 AM Johan Hovold <johan@kernel.org> wrote:  
> > > >
> > > > On Mon, Aug 27, 2018 at 10:48:42AM +0200, Boris Brezillon wrote:    
> > > > > On Mon, 27 Aug 2018 10:44:14 +0200
> > > > > Johan Hovold <johan@kernel.org> wrote:
> > > > >    
> > > > > > On Mon, Aug 27, 2018 at 10:28:20AM +0200, Boris Brezillon wrote:    
> > > > > > > Hi Johan
> > > > > > >
> > > > > > > On Mon, 27 Aug 2018 10:21:49 +0200
> > > > > > > Johan Hovold <johan@kernel.org> wrote:
> > > > > > >    
> > > > > > > > Use the new of_get_compatible_child() helper to lookup the nfc child
> > > > > > > > node instead of using of_find_compatible_node(), which searches the
> > > > > > > > entire tree from a given start node and thus can return an unrelated
> > > > > > > > (i.e. non-child) node.
> > > > > > > >
> > > > > > > > This also addresses a potential use-after-free (e.g. after probe
> > > > > > > > deferral) as the tree-wide helper drops a reference to its first
> > > > > > > > argument (i.e. the node of the device being probed).
> > > > > > > >
> > > > > > > > While at it, also fix a related nfc-node reference leak.
> > > > > > > >
> > > > > > > > Fixes: f88fc122cc34 ("mtd: nand: Cleanup/rework the atmel_nand driver")
> > > > > > > > Cc: stable <stable@vger.kernel.org>     # 4.11
> > > > > > > > Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> > > > > > > > Cc: Josh Wu <rainyfeeling@outlook.com>
> > > > > > > > Cc: Boris Brezillon <boris.brezillon@bootlin.com>
> > > > > > > > Signed-off-by: Johan Hovold <johan@kernel.org>    
> > > > > > >
> > > > > > > Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>    
> > > > > >
> > > > > > Thanks for the ack.
> > > > > >    
> > > > > > > I'll let Miquel queue this patch to the nand/next branch, unless you
> > > > > > > want it to be merged in 4.19, in which case I'll queue it to the
> > > > > > > mtd/fixes branch.    
> > > > > >
> > > > > > Note that there's a dependency on the first patch of the series which
> > > > > > adds the new helper.    
> > > > >
> > > > > I was not Cc-ed on this patch :P.    
> > > >
> > > > Yeah, sorry about that. I made sure everyone was CCed on the
> > > > cover letter, but guess I could have reused that list for the helper as
> > > > well.
> > > >    
> > > > > > Rob can pick up the entire series if the various
> > > > > > maintainers agree, otherwise I'll try to get at the least the helper
> > > > > > into -rc2.    
> > > > >
> > > > > If everything goes in 4.19-rc2 through Rob's tree that's fine, but if
> > > > > it's queued for 4.20 we might need an immutable tag just in case we
> > > > > queue conflicting changes to the NAND tree.    
> > > >
> > > > Ok, thanks.    
> > > 
> > > Hi Boris, can you pick this one up. It conflicts with "mtd: rawnand:
> > > atmel: Fix potential NULL pointer dereference"  
> > 
> > Sure, I'll queue it for -rc2.  
> 
> This one hasn't showed up in -next yet, so sending a reminder.

Applied (thanks for the reminder, I had forgotten :-)). It should show
up in -rc4.

Thanks,

Boris

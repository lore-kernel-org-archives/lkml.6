Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5648C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E77208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="O794UlsC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E77208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeK2TMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 14:12:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:36028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbeK2TMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 14:12:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F64520834;
        Thu, 29 Nov 2018 08:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543478892;
        bh=Y7dCXkwUHZlyun9Jj/P0d5xxj8WOlsQH4+QkSqvvrLM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O794UlsCLZL4nVP2xiTRgDcaYE8Y7TXSDpYCTN9YczCJgTu1h+WyEtVyq7qtubpR6
         uJJEzqH0GeEU2YecJyiLUJQsPiC2P8W28ks4ylVtyW/vgB3vYttSs6x5Umk0JCLsyO
         kxzX7HkcC7hTAi/Gi6kjzYhBigrsEEyaCUkORs0A=
Date:   Thu, 29 Nov 2018 09:08:10 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux- stable <stable@vger.kernel.org>,
        nicolas.ferre@microchip.com, rainyfeeling@outlook.com
Subject: Re: [PATCH 4.14 58/62] mtd: rawnand: atmel: fix OF child-node lookup
Message-ID: <20181129080810.GD13859@kroah.com>
References: <20181126105050.592727680@linuxfoundation.org>
 <20181126105054.941598787@linuxfoundation.org>
 <CA+G9fYsyM9VS8QkaEizQT_LSvZyT+h6zdoWZbhVQtd1n60Bniw@mail.gmail.com>
 <20181126160840.1c702e87@bbrezillon>
 <20181126151418.GA19698@kroah.com>
 <20181126154824.GA2403@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126154824.GA2403@localhost>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 07:48:24AM -0800, Johan Hovold wrote:
> On Mon, Nov 26, 2018 at 04:14:18PM +0100, Greg Kroah-Hartman wrote:
> > On Mon, Nov 26, 2018 at 04:08:40PM +0100, Boris Brezillon wrote:
> > > On Mon, 26 Nov 2018 19:46:15 +0530
> > > Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > > 
> > > > Do you see build failure arm x15 beagleboard on 4.14 due to this patch ?
> > > > 
> > > > On Mon, 26 Nov 2018 at 16:31, Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > 4.14-stable review patch.  If anyone has any objections, please let me know.
> > > > >
> > > > > ------------------
> > > > >
> > > > > From: Johan Hovold <johan@kernel.org>
> > > > >
> > > > > commit 5d1e9c2212ea6b4dd735e4fc3dd6279a365d5d10 upstream.
> > > > >
> > > > > Use the new of_get_compatible_child() helper to lookup the nfc child
> > > > > node instead of using of_find_compatible_node(), which searches the
> > > > > entire tree from a given start node and thus can return an unrelated
> > > > > (i.e. non-child) node.
> > > > >
> > > > > This also addresses a potential use-after-free (e.g. after probe
> > > > > deferral) as the tree-wide helper drops a reference to its first
> > > > > argument (i.e. the node of the device being probed).
> > > > >
> > > > > While at it, also fix a related nfc-node reference leak.
> > > > >
> > > > > Fixes: f88fc122cc34 ("mtd: nand: Cleanup/rework the atmel_nand driver")
> > > > > Cc: stable <stable@vger.kernel.org>     # 4.11
> > > > > Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> > > > > Cc: Josh Wu <rainyfeeling@outlook.com>
> > > > > Cc: Boris Brezillon <boris.brezillon@bootlin.com>
> > > > > Signed-off-by: Johan Hovold <johan@kernel.org>
> > > > > Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> > > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > >
> > > > > ---
> > > > >  drivers/mtd/nand/atmel/nand-controller.c |   11 +++++++----
> > > > >  1 file changed, 7 insertions(+), 4 deletions(-)
> > > > >
> > > > > --- a/drivers/mtd/nand/atmel/nand-controller.c
> > > > > +++ b/drivers/mtd/nand/atmel/nand-controller.c
> > > > > @@ -2077,8 +2077,7 @@ atmel_hsmc_nand_controller_legacy_init(s
> > > > >         int ret;
> > > > >
> > > > >         nand_np = dev->of_node;
> > > > > -       nfc_np = of_find_compatible_node(dev->of_node, NULL,
> > > > > -                                        "atmel,sama5d3-nfc");
> > > > > +       nfc_np = of_get_compatible_child(dev->of_node, "atmel,sama5d3-nfc");
> > > > >         if (!nfc_np) {
> > > > >                 dev_err(dev, "Could not find device node for sama5d3-nfc\n");
> > > > >                 return -ENODEV;
> > > > > @@ -2492,15 +2491,19 @@ static int atmel_nand_controller_probe(s
> > > > >         }
> > > > >
> > > > >         if (caps->legacy_of_bindings) {
> > > > > +               struct device_node *nfc_node;
> > > > >                 u32 ale_offs = 21;
> > > > >
> > > > >                 /*
> > > > >                  * If we are parsing legacy DT props and the DT contains a
> > > > >                  * valid NFC node, forward the request to the sama5 logic.
> > > > >                  */
> > > > > -               if (of_find_compatible_node(pdev->dev.of_node, NULL,
> > > > > -                                           "atmel,sama5d3-nfc"))
> > > > > +               nfc_node = of_get_compatible_child(pdev->dev.of_node,
> > > > > +                                                  "atmel,sama5d3-nfc");
> > > > > +               if (nfc_node) {
> > > > >                         caps = &atmel_sama5_nand_caps;
> > > > > +                       of_node_put(nfc_node);
> > > > > +               }
> > > > >
> > > > >                 /*
> > > > >                  * Even if the compatible says we are dealing with an
> > > > >
> > > > >  
> > > > 
> > > > /drivers/mtd/nand/atmel/nand-controller.c: In function
> > > > 'atmel_hsmc_nand_controller_legacy_init':
> > > > /drivers/mtd/nand/atmel/nand-controller.c:2080:11: error: implicit
> > > > declaration of function 'of_get_compatible_child'; did you mean
> > > > 'of_get_next_available_child'? [-Werror=implicit-function-declaration]
> > > >    nfc_np = of_get_compatible_child(dev->of_node, "atmel,sama5d3-nfc");
> > > 
> > > Looks like of_get_compatible_child() has been introduced in 4.18, hence
> > > this error.
> > > 
> > > Greg, can you drop this patch from 4.14.y?
> > 
> > Yes, my fault, I fixed a number of these in the past, missed this one :(
> > 
> > Now dropped.
> 
> The intention here was that the helper should be backported along with
> the fixes. I mentioned this in the cover letter to the series
> introducing the helper and the fixes. As they were submitted together I
> could not use the usual
> 
> 	Cc: stable <stable@vger.kernel.org>	# 4.xx: 36156f9241cb
> 
> notation for this. I realise I should still have mentioned this in each
> individual commit messages as well, sorry about that.
> 
> The dependency for all of these fixes is:
> 
> 	36156f9241cb ("of: add helper to lookup compatible child node")
> 
> and the original thread can be found here:
> 
> 	https://lkml.kernel.org/r/20180827082153.22537-1-johan@kernel.org

Now fixed up and applied, thanks.

greg k-h

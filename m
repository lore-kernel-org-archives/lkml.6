Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC05C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F8B20664
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0F8B20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbeK0CDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 21:03:24 -0500
Received: from mail.bootlin.com ([62.4.15.54]:59801 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbeK0CDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 21:03:23 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id AA7E2207BD; Mon, 26 Nov 2018 16:08:58 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id C2ECC2073D;
        Mon, 26 Nov 2018 16:08:40 +0100 (CET)
Date:   Mon, 26 Nov 2018 16:08:40 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux- stable <stable@vger.kernel.org>,
        nicolas.ferre@microchip.com, rainyfeeling@outlook.com,
        johan@kernel.org
Subject: Re: [PATCH 4.14 58/62] mtd: rawnand: atmel: fix OF child-node
 lookup
Message-ID: <20181126160840.1c702e87@bbrezillon>
In-Reply-To: <CA+G9fYsyM9VS8QkaEizQT_LSvZyT+h6zdoWZbhVQtd1n60Bniw@mail.gmail.com>
References: <20181126105050.592727680@linuxfoundation.org>
        <20181126105054.941598787@linuxfoundation.org>
        <CA+G9fYsyM9VS8QkaEizQT_LSvZyT+h6zdoWZbhVQtd1n60Bniw@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2018 19:46:15 +0530
Naresh Kamboju <naresh.kamboju@linaro.org> wrote:

> Do you see build failure arm x15 beagleboard on 4.14 due to this patch ?
> 
> On Mon, 26 Nov 2018 at 16:31, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > 4.14-stable review patch.  If anyone has any objections, please let me know.
> >
> > ------------------
> >
> > From: Johan Hovold <johan@kernel.org>
> >
> > commit 5d1e9c2212ea6b4dd735e4fc3dd6279a365d5d10 upstream.
> >
> > Use the new of_get_compatible_child() helper to lookup the nfc child
> > node instead of using of_find_compatible_node(), which searches the
> > entire tree from a given start node and thus can return an unrelated
> > (i.e. non-child) node.
> >
> > This also addresses a potential use-after-free (e.g. after probe
> > deferral) as the tree-wide helper drops a reference to its first
> > argument (i.e. the node of the device being probed).
> >
> > While at it, also fix a related nfc-node reference leak.
> >
> > Fixes: f88fc122cc34 ("mtd: nand: Cleanup/rework the atmel_nand driver")
> > Cc: stable <stable@vger.kernel.org>     # 4.11
> > Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> > Cc: Josh Wu <rainyfeeling@outlook.com>
> > Cc: Boris Brezillon <boris.brezillon@bootlin.com>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> > ---
> >  drivers/mtd/nand/atmel/nand-controller.c |   11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > --- a/drivers/mtd/nand/atmel/nand-controller.c
> > +++ b/drivers/mtd/nand/atmel/nand-controller.c
> > @@ -2077,8 +2077,7 @@ atmel_hsmc_nand_controller_legacy_init(s
> >         int ret;
> >
> >         nand_np = dev->of_node;
> > -       nfc_np = of_find_compatible_node(dev->of_node, NULL,
> > -                                        "atmel,sama5d3-nfc");
> > +       nfc_np = of_get_compatible_child(dev->of_node, "atmel,sama5d3-nfc");
> >         if (!nfc_np) {
> >                 dev_err(dev, "Could not find device node for sama5d3-nfc\n");
> >                 return -ENODEV;
> > @@ -2492,15 +2491,19 @@ static int atmel_nand_controller_probe(s
> >         }
> >
> >         if (caps->legacy_of_bindings) {
> > +               struct device_node *nfc_node;
> >                 u32 ale_offs = 21;
> >
> >                 /*
> >                  * If we are parsing legacy DT props and the DT contains a
> >                  * valid NFC node, forward the request to the sama5 logic.
> >                  */
> > -               if (of_find_compatible_node(pdev->dev.of_node, NULL,
> > -                                           "atmel,sama5d3-nfc"))
> > +               nfc_node = of_get_compatible_child(pdev->dev.of_node,
> > +                                                  "atmel,sama5d3-nfc");
> > +               if (nfc_node) {
> >                         caps = &atmel_sama5_nand_caps;
> > +                       of_node_put(nfc_node);
> > +               }
> >
> >                 /*
> >                  * Even if the compatible says we are dealing with an
> >
> >  
> 
> /drivers/mtd/nand/atmel/nand-controller.c: In function
> 'atmel_hsmc_nand_controller_legacy_init':
> /drivers/mtd/nand/atmel/nand-controller.c:2080:11: error: implicit
> declaration of function 'of_get_compatible_child'; did you mean
> 'of_get_next_available_child'? [-Werror=implicit-function-declaration]
>    nfc_np = of_get_compatible_child(dev->of_node, "atmel,sama5d3-nfc");

Looks like of_get_compatible_child() has been introduced in 4.18, hence
this error.

Greg, can you drop this patch from 4.14.y?

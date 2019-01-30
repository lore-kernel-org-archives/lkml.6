Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C77C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D629E20882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730240AbfA3JcZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:32:25 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:34909 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfA3JcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:32:24 -0500
X-Originating-IP: 90.88.147.226
Received: from xps13 (aaubervilliers-681-1-27-226.w90-88.abo.wanadoo.fr [90.88.147.226])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id B2F1240018;
        Wed, 30 Jan 2019 09:32:21 +0000 (UTC)
Date:   Wed, 30 Jan 2019 10:32:20 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Liang Yang <liang.yang@amlogic.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Kevin Hilman <khilman@baylibre.com>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: rawnand: meson: Fix linking error on 32-bit
 platforms
Message-ID: <20190130103220.27b13ab9@xps13>
In-Reply-To: <42d2e92e-9f5a-62b2-c0af-b7f3544d79d2@amlogic.com>
References: <20190129214657.5877-1-natechancellor@gmail.com>
        <42d2e92e-9f5a-62b2-c0af-b7f3544d79d2@amlogic.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liang, Nathan,

Liang Yang <liang.yang@amlogic.com> wrote on Wed, 30 Jan 2019 17:26:39
+0800:

> Hi Nathan,
> 
> On 2019/1/30 5:46, Nathan Chancellor wrote:
> > On arm little endian allyesconfig:
> > 
> >    ld.lld: error: undefined symbol: __aeabi_uldivmod  
> >    >>> referenced by meson_nand.c
> >    >>> mtd/nand/raw/meson_nand.o:(meson_nfc_setup_data_interface) in archive drivers/built-in.a  
> > 
> > The dividend tBERS_max is u64, meaning we need to use DIV_ROUND_UP_ULL
> > (which wraps do_div) to prevent the compiler from emitting
> > __aebi_uldivmod.
> > 
> > Fixes: 2d570b34b41a ("mtd: rawnand: meson: add support for Amlogic NAND flash controller")
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >   drivers/mtd/nand/raw/meson_nand.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
> > index e858d58d97b0..6f12a96195d1 100644
> > --- a/drivers/mtd/nand/raw/meson_nand.c
> > +++ b/drivers/mtd/nand/raw/meson_nand.c
> > @@ -1116,8 +1116,8 @@ int meson_nfc_setup_data_interface(struct nand_chip *nand, int csline,
> >   				       div * NFC_CLK_CYCLE);
> >   	meson_chip->tadl = DIV_ROUND_UP(PSEC_TO_NSEC(timings->tADL_min),
> >   					div * NFC_CLK_CYCLE);
> > -	tbers_clocks = DIV_ROUND_UP(PSEC_TO_NSEC(timings->tBERS_max),
> > -				    div * NFC_CLK_CYCLE);
> > +	tbers_clocks = DIV_ROUND_UP_ULL(PSEC_TO_NSEC(timings->tBERS_max),
> > +					div * NFC_CLK_CYCLE);  
> 
> Looks good to me:
> 
> Acked-by: Liang Yang <liang.yang@amlogic.com>

This is nand/next material, so if you don't mind I would like to squash
this fix into the original commit inserting the driver.


Thanks,
Miquèl

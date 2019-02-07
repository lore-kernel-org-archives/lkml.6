Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD84C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1480F21872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="BWDwkpes"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfBGKrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 05:47:55 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:31531 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfBGKry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 05:47:54 -0500
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x17AlVBb028830
        for <linux-kernel@vger.kernel.org>; Thu, 7 Feb 2019 19:47:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x17AlVBb028830
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549536452;
        bh=a2aQCf6e/pUnLAtj49zQo5bkjXwLnat9d9gPY5wUf8Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BWDwkpesDBLq4J9825dVQvbzQ81NlpqQ3apdx0Txm7+z7xnIFeI0lWIopNMmEK9cp
         KnCVAQgbaU52G7e2/AV62MX63U9rSmz+Zv6/asR5fJpqpQ2serVxzjvNreYrbjCl8v
         8NzzFs46US3njx3Y0bPkhDLb9InAL+Qk8+mjlJwftLDVD/2CZlnCvSpEk3lyMXpo0K
         V6Y14x2fCzq4hcUnVHeRbA+03kB7g/OcnskD1REskaoD14hHbA9Dh8ixVt/yIM/MRS
         x64oJLwGwLsGkJG0NIqBu4xsym/cJIcnbK7mhhpsc7lEzdr3G3Xur8a1ujjGm5U13P
         /ZyZIIcuvacCA==
X-Nifty-SrcIP: [209.85.217.42]
Received: by mail-vs1-f42.google.com with SMTP id e7so6400331vsc.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 02:47:32 -0800 (PST)
X-Gm-Message-State: AHQUAuaTMx61dbW+XIJApCi454FTK41Tge0ADTl5kcIXwNTa3QMzHIMQ
        i1iNW2/0MvfEO52KiKgaAYc4/7glOD19bDzwYcA=
X-Google-Smtp-Source: AHgI3IYuFgv5h28FgTK86AZ8dE+Yn/nyTZDPvR37FvR0IDjHeSc1koRWapyaYEuOfmhrffkLIAzIRvEfKfCJnKvO5LY=
X-Received: by 2002:a67:485:: with SMTP id 127mr6529702vse.54.1549536450853;
 Thu, 07 Feb 2019 02:47:30 -0800 (PST)
MIME-Version: 1.0
References: <1549533476-3742-1-git-send-email-yamada.masahiro@socionext.com> <20190207111606.6b72dc34@xps13>
In-Reply-To: <20190207111606.6b72dc34@xps13>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 7 Feb 2019 19:46:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNASEvAUeJsBcp4eh+XW+gaVp921SU-d1m-DEs+Hs+YA8TA@mail.gmail.com>
Message-ID: <CAK7LNASEvAUeJsBcp4eh+XW+gaVp921SU-d1m-DEs+Hs+YA8TA@mail.gmail.com>
Subject: Re: [PATCH] mtd: rawnand: call onfi_fill_data_interface() once again
 after nand_detect
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Boris Brezillon <bbrezillon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 7:16 PM Miquel Raynal <miquel.raynal@bootlin.com> wr=
ote:
>
> Hi Masahiro,
>
> Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Thu,  7 Feb
> 2019 18:57:56 +0900:
>
> > nand_scan_ident() calls onfi_fill_data_interface() at its entry
> > to set up the initial timing parameters.
> >
> > The timing parameters are needed not only for ->setup_data_interface(),
> > but also for giving the correct delay to NAND_OP_WAIT_RDY, for example.
> >
> > If the driver sets the NAND_KEEP_TIMINGS flag, or does not support
> > ->setup_data_interface() hook, those parameters will never updated.
>
>                                                             ^ be

Will fix (if v2 is welcome)


> >
> > Before nand_detect(), we never know whether the chip is ONFi or not.
> > So, onfi_fill_data_interface() has to assume the worst case, i.e.
> > non-ONFi.
>
> s/ONFi/ONFI/?

Will fix.

Looks like I was misunderstanding
maybe because the letter 'I' in the logo
(http://www.onfi.org/)
looks like a lowercase...




>
> >
> > After nand_detect(), if the chip turns out to be ONFi-compliant,
> > we can optimize tPROG_max, tBERS_max, etc.
> >
> > Call onfi_fill_data_interface() once again.
>
> Sorry but I don't get why this is needed as there is the same call at
> the top of this function. Can you be more specific on where/when the
> missing call produces a failure?


onfi_fill_data_interface() sets different values
for tPROG_max, tBER_max, tR_max, tCCS_min
depending on whether the chip is ONFI or not.

For the first call, onfi_fill_data_interface()
chooses the else-part since we never know
the chip specification at this point.

If we call onfi_fill_data_interface() once again
after nand_detect(), it may choose the if-part.


If a driver supports ->setup_data_interface(),
nand_init_data_interface() will set the optimal
timing parameters anyway.

But, if a driver does not support ->setup_data_interface(),
it will not happen since nand_has_setup_data_iface() returns false.





> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> >  drivers/mtd/nand/raw/nand_base.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/na=
nd_base.c
> > index 9b3d7ff..35e543c 100644
> > --- a/drivers/mtd/nand/raw/nand_base.c
> > +++ b/drivers/mtd/nand/raw/nand_base.c
> > @@ -5040,6 +5040,9 @@ static int nand_scan_ident(struct nand_chip *chip=
, unsigned int maxchips,
> >
> >       nand_deselect_target(chip);
> >
> > +     /* If the chip turns out ONFi, we can optimize timing parameters.=
 */
> > +     onfi_fill_data_interface(chip, NAND_SDR_IFACE, 0);
> > +
> >       /* Check for a chip array */
> >       for (i =3D 1; i < maxchips; i++) {
> >               u8 id[2];
>
>
> Thanks,
> Miqu=C3=A8l



--=20
Best Regards
Masahiro Yamada

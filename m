Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC401C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4DED21917
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="gl6TpMEn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfBHIgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 03:36:24 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:34832 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfBHIgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 03:36:24 -0500
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x188a9It019974
        for <linux-kernel@vger.kernel.org>; Fri, 8 Feb 2019 17:36:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x188a9It019974
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549614970;
        bh=PpHo9P0D09VD5/dyO22w85nqV153LJU03tZXAAWBYiM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gl6TpMEnIXEX8docnt9el5eM1Dn8aOQlJNUFlr7Xv0gVaaQtq62MD5mtnmA3Do5zS
         4PIQNV8opjcjiwws/r33vpQYAMPZhBbN3AjAkx1h0uR6GcQ3SVymIXgCJxqe5pachv
         xgbugfB6gJVFW61TCsHnabBDd7rO0IK9ExT2VXL3drQzlOmb5PRV2YDg0rHSYR95wR
         ZdJ+l3WlFpbonOs/h7maRLqGhgI1K/QI+UdvY3QeaxeDwX2mjEX0wMnKFCPhYNBoRt
         01TeRSxnlXWXv9wbyihqvo6xRRq4G2oS/98mTdLcMJ11C4AC2wFJN09ZWECWOXSp8e
         a7c8GDaamqs0g==
X-Nifty-SrcIP: [209.85.217.48]
Received: by mail-vs1-f48.google.com with SMTP id t13so1657958vsk.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 00:36:10 -0800 (PST)
X-Gm-Message-State: AHQUAuYMaDs9XNJ+kWjmg4wigPbPkrADZPNJ+b3OesUwwRQ5Z3ReLmeX
        wQf10ggkuxUwqkmcErPblWGZC4tCyXxZuHWsHXM=
X-Google-Smtp-Source: AHgI3IZCLBk6hds9PIW/wT0loACA9VmSYVFfLSO5Iv3D3d/XbliBS8ImEeK+snQAV89GTnlzJyD0bkTzk51mO6u2tZY=
X-Received: by 2002:a67:f759:: with SMTP id w25mr2731202vso.215.1549614968903;
 Fri, 08 Feb 2019 00:36:08 -0800 (PST)
MIME-Version: 1.0
References: <1549533476-3742-1-git-send-email-yamada.masahiro@socionext.com>
 <20190207111606.6b72dc34@xps13> <CAK7LNASEvAUeJsBcp4eh+XW+gaVp921SU-d1m-DEs+Hs+YA8TA@mail.gmail.com>
 <20190207140136.2ae62982@xps13>
In-Reply-To: <20190207140136.2ae62982@xps13>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 8 Feb 2019 17:35:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ7P8iEkhyRBbHLdt6yN-dDgpLZOs256qwk2BpADiGcGw@mail.gmail.com>
Message-ID: <CAK7LNAQ7P8iEkhyRBbHLdt6yN-dDgpLZOs256qwk2BpADiGcGw@mail.gmail.com>
Subject: Re: [PATCH] mtd: rawnand: call onfi_fill_data_interface() once again
 after nand_detect
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Miquel,

On Thu, Feb 7, 2019 at 10:02 PM Miquel Raynal <miquel.raynal@bootlin.com> w=
rote:
>
> Hi Masahiro,
>
> Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Thu, 7 Feb
> 2019 19:46:54 +0900:
>
> > On Thu, Feb 7, 2019 at 7:16 PM Miquel Raynal <miquel.raynal@bootlin.com=
> wrote:
> > >
> > > Hi Masahiro,
> > >
> > > Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Thu,  7 Feb
> > > 2019 18:57:56 +0900:
> > >
> > > > nand_scan_ident() calls onfi_fill_data_interface() at its entry
> > > > to set up the initial timing parameters.
> > > >
> > > > The timing parameters are needed not only for ->setup_data_interfac=
e(),
> > > > but also for giving the correct delay to NAND_OP_WAIT_RDY, for exam=
ple.
> > > >
> > > > If the driver sets the NAND_KEEP_TIMINGS flag, or does not support
> > > > ->setup_data_interface() hook, those parameters will never updated.
> > >
> > >                                                             ^ be
> >
> > Will fix (if v2 is welcome)
> >
> >
> > > >
> > > > Before nand_detect(), we never know whether the chip is ONFi or not=
.
> > > > So, onfi_fill_data_interface() has to assume the worst case, i.e.
> > > > non-ONFi.
> > >
> > > s/ONFi/ONFI/?
> >
> > Will fix.
> >
> > Looks like I was misunderstanding
> > maybe because the letter 'I' in the logo
> > (http://www.onfi.org/)
> > looks like a lowercase...
> >
> >
>
> Oh right. I don't know what's best. Pick your favorite :)
>
> >
> >
> > >
> > > >
> > > > After nand_detect(), if the chip turns out to be ONFi-compliant,
> > > > we can optimize tPROG_max, tBERS_max, etc.
> > > >
> > > > Call onfi_fill_data_interface() once again.
> > >
> > > Sorry but I don't get why this is needed as there is the same call at
> > > the top of this function. Can you be more specific on where/when the
> > > missing call produces a failure?
> >
> >
> > onfi_fill_data_interface() sets different values
> > for tPROG_max, tBER_max, tR_max, tCCS_min
> > depending on whether the chip is ONFI or not.
> >
> > For the first call, onfi_fill_data_interface()
> > chooses the else-part since we never know
> > the chip specification at this point.
> >
> > If we call onfi_fill_data_interface() once again
> > after nand_detect(), it may choose the if-part.
> >
> >
> > If a driver supports ->setup_data_interface(),
> > nand_init_data_interface() will set the optimal
> > timing parameters anyway.
> >
> > But, if a driver does not support ->setup_data_interface(),
> > it will not happen since nand_has_setup_data_iface() returns false.
>
> And I think this is the expected behavior. Calling again
> onfi_fill_data_interface() would probably enhance a bit the timings.
> The effect is that later exchanges with the NAND chip would be just a
> bit faster. But if you care about performance, then why not implementing
> ->setup_data_interface()? Even a dummy implementation would do the
> trick: only accept timing mode 0 without any changes on the controller
> side.


My driver (denali) does implement ->setup_data_interface().

When I was testing this thoroughly on my board,
I noticed the timing parameters were slightly changed
after nand_detect() detected ONFI chip.

> Unless you give me a use case where this is not possible, I don't think
> it is worth changing this path.

Only the use case I can come up with is when NAND_KEEP_TIMINGS was set.
But, it is just a matter of timeout values.

So, please throw away this patch.


>
> Thanks,
> Miqu=C3=A8l
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/



--=20
Best Regards
Masahiro Yamada

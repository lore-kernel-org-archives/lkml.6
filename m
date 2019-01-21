Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA38FC2F421
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D23D20844
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="wF7QMDzT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbfAUP6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:58:40 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:39763 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728761AbfAUP6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:58:40 -0500
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x0LFwJuj019339
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 00:58:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x0LFwJuj019339
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1548086300;
        bh=TkayluUMumYW0n02g2V3Jh4qrxV+vg11IGRgL33PUYs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wF7QMDzT6R1tH1Xmu2NJ/VXGh4slznBZK5+g86PgFbDIWZH4OReYOnxJTz/vE2NcK
         q0vXuzZsSt4FDt0L7u0alXd7Sjt3K9qpHsS4q3gYkvRIyx6F/N0oCpEc4HzAcqwTLp
         fbnZmEhKo8r0hFKigJQvTpnxka0ywfmrudtqh6DDbvL9mpNVgrqoaKHot7VuJqBda0
         SvWiElY2hj7yIJP4ynBrXAP4mYxXaV8hwNDLxLXO0t6me0ANhDvLuERMOk72mHSFWb
         DTdOe4dkeJtCnWj9M9xQODGZzDytYM1kknFB3d+yoaZNkWX5FfEeOH9klCn94onSLs
         2Z6IKfKr9CTCg==
X-Nifty-SrcIP: [209.85.222.53]
Received: by mail-ua1-f53.google.com with SMTP id e16so7040260uam.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 07:58:20 -0800 (PST)
X-Gm-Message-State: AJcUukdaBuSxf74WbutlJj+wbT/vVmLIbK3hld6wY2inpgK0XtXLFINO
        4CGRnijkNtYD0f6M1zINFyh8MdcUUqIAjVPnDKA=
X-Google-Smtp-Source: ALg8bN73kMBmTfd0aQj+UcfVn3AOO4xuybGiSoOL0KIk4GWvX5cnh+ntLhDKSs0WpRJhHKKE2vVm1pYCxuB48lGOlNw=
X-Received: by 2002:a9f:3f41:: with SMTP id i1mr11098938uaj.42.1548086299245;
 Mon, 21 Jan 2019 07:58:19 -0800 (PST)
MIME-Version: 1.0
References: <1548075934-19963-1-git-send-email-yamada.masahiro@socionext.com> <20190121141403.20f6107b@bbrezillon>
In-Reply-To: <20190121141403.20f6107b@bbrezillon>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 22 Jan 2019 00:57:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNATUpyfnicBiSdL49dsFnvo+M=N9X-wY-J0efnRc-1_0gA@mail.gmail.com>
Message-ID: <CAK7LNATUpyfnicBiSdL49dsFnvo+M=N9X-wY-J0efnRc-1_0gA@mail.gmail.com>
Subject: Re: [PATCH] mtd: rawnand: check return code of nand_reset() and nand_readid_op()
To:     Boris Brezillon <bbrezillon@kernel.org>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 10:14 PM Boris Brezillon <bbrezillon@kernel.org> wrote:
>
> On Mon, 21 Jan 2019 22:05:34 +0900
> Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>
> > nand_scan_ident() iterates over maxchips to find as many homogeneous
> > chips as possible.
> >
> > Currently, this loop bails out only when manufacturer or device ID
> > unmatches. The reason of unmatch is most likely no chip is connected
> > to that chip select. In this case, nand_reset() has already failed,
> > and the following nand_readid_op() is pointless.
>
> While I agree with the following diff, I'd also like to point out that
> nand_scan() callers should know how many controller CS lines are
> connected to the chip (board file or DT description). The check we do in
> nand_scan_ident() should only be here to clamp this value if the board
> desc is wrong (maybe we should even fail in that case instead of
> silently fixing things).


I know this.
This is a problem for denali because
I have not decoupled chip/controller yet.


Maybe, is the following better?


------------------>8-----------------------
nand_scan_ident() iterates over maxchips to find as many homogeneous
chips as possible.

Since commit 2d472aba15ff ("mtd: nand: document the NAND controller/NAND
chip DT representation"), new drivers should pass in the exact number of
CS lines instead of possible max, but old platforms may still rely on
nand_scan_ident() to detect the actual number of connected CS lines.

In that case, this loop bails out when manufacturer or device ID
unmatches. The reason of unmatch is most likely no chip is connected
to that CS line. If so, nand_reset() should already have failed,
and the following nand_readid_op() is pointless.

Before ->exec_op hook was introduced, drivers had no way to tell
the failure of NAND_CMD_RESET to the framework because the legacy
->cmdfunc() has void return type. Now drivers implementing ->exec_op
hook can return the error code. You can save nand_readid_op() by
checking the return value of nand_reset(). The return value of
nand_readid_op() should be checked as well. If it fails, probably
id[0] and id[1] are undefined values.

Just for consistency, it should be sensible to check the return
code in nand_do_write_oob() as well.
------------------------------>8--------------------------------






> >
> > Before ->exec_op hook was introduced, drivers had no way to tell
> > the failure of NAND_CMD_RESET to the framework because the legacy
> > ->cmdfunc() has void return type. Now drivers implementing ->exec_op
> > hook can return the error code. You can save nand_readid_op() by
> > checking the return value of nand_reset(). The return value of
> > nand_readid_op() should be checked as well. If it fails, probably
> > id[0] and id[1] are undefined values.
> >
> > Just for consistency, it should be sensible to check the return
> > code in nand_do_write_oob() as well.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
>
> > ---
> >
> >  drivers/mtd/nand/raw/nand_base.c | 14 ++++++++++----
> >  1 file changed, 10 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> > index 7ea3f10..3407523 100644
> > --- a/drivers/mtd/nand/raw/nand_base.c
> > +++ b/drivers/mtd/nand/raw/nand_base.c
> > @@ -457,7 +457,7 @@ static int nand_do_write_oob(struct nand_chip *chip, loff_t to,
> >                            struct mtd_oob_ops *ops)
> >  {
> >       struct mtd_info *mtd = nand_to_mtd(chip);
> > -     int chipnr, page, status, len;
> > +     int chipnr, page, status, len, ret;
> >
> >       pr_debug("%s: to = 0x%08x, len = %i\n",
> >                        __func__, (unsigned int)to, (int)ops->ooblen);
> > @@ -479,7 +479,9 @@ static int nand_do_write_oob(struct nand_chip *chip, loff_t to,
> >        * if we don't do this. I have no clue why, but I seem to have 'fixed'
> >        * it in the doc2000 driver in August 1999.  dwmw2.
> >        */
> > -     nand_reset(chip, chipnr);
> > +     ret = nand_reset(chip, chipnr);
> > +     if (ret)
> > +             return ret;
> >
> >       nand_select_target(chip, chipnr);
> >
> > @@ -5037,11 +5039,15 @@ static int nand_scan_ident(struct nand_chip *chip, unsigned int maxchips,
> >               u8 id[2];
> >
> >               /* See comment in nand_get_flash_type for reset */
> > -             nand_reset(chip, i);
> > +             ret = nand_reset(chip, i);
> > +             if (ret)
> > +                     break;
> >
> >               nand_select_target(chip, i);
> >               /* Send the command for reading device ID */
> > -             nand_readid_op(chip, 0, id, sizeof(id));
> > +             ret = nand_readid_op(chip, 0, id, sizeof(id));
> > +             if (ret)
> > +                     break;
> >               /* Read manufacturer and device IDs */
> >               if (nand_maf_id != id[0] || nand_dev_id != id[1]) {
> >                       nand_deselect_target(chip);
>
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/



--
Best Regards
Masahiro Yamada

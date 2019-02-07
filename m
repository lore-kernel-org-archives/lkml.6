Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561E3C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 185E321902
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="1vOCd98m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfBGKwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 05:52:55 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:37921 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfBGKwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 05:52:55 -0500
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x17AqY4G031043
        for <linux-kernel@vger.kernel.org>; Thu, 7 Feb 2019 19:52:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x17AqY4G031043
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549536755;
        bh=tp5hPxpdOTL0M9fI0rFqN9RTOyPm39PjBpdl2kMLPRs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1vOCd98mgVXOfQ6PKRtY4731x+vOBf7XVT6Kx0Sp2pEt0rmW0vltNQQTOK7mdMW+w
         QRzFcVLCh9pi4WHfnn5A6ryMDpS5xHkGmDECs0ypSA36fv0wxxKbFyF9ZtlBvlnSjs
         fKEFKCxfcZ/zxqYEsC/SbKbVz42j0uuzesGsM5oj7RTifSpgm/M/YvSUFnd/Egp6tX
         YJ7RkTe7WC7el4BmpwwIyIQkWIYEez3SEBnyCOlO0DfDzP/rRiAB8BQO8CwID770pk
         e2TXK1qifCAJGqcF1ExlFW0kCAbpQLnGBr3HGkvBQ0OtP/ljwMrAP8jDHL/v1l8fvz
         yr0PDz7EJG2gw==
X-Nifty-SrcIP: [209.85.222.44]
Received: by mail-ua1-f44.google.com with SMTP id t8so3316139uap.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 02:52:35 -0800 (PST)
X-Gm-Message-State: AHQUAuaJbPB0Uj4hrqcyg3BkjJPHGmS8YD9QUm1QUZGkbX525B1dlG60
        W+zX5V5Snq5HLccBtmRrAkfrW1NJGdCJerg5TqQ=
X-Google-Smtp-Source: AHgI3IYhwsF+N0VInuOQiPghIM+VBrPUGdVnCy1tH4q9L0fGVW2mnDaSxgG2oC1O1ecqHXjUnKJVEfv01UZqLcYPlx8=
X-Received: by 2002:a9f:3f41:: with SMTP id i1mr5339535uaj.42.1549536754472;
 Thu, 07 Feb 2019 02:52:34 -0800 (PST)
MIME-Version: 1.0
References: <1549533476-3742-1-git-send-email-yamada.masahiro@socionext.com>
 <20190207111606.6b72dc34@xps13> <CAK7LNASEvAUeJsBcp4eh+XW+gaVp921SU-d1m-DEs+Hs+YA8TA@mail.gmail.com>
In-Reply-To: <CAK7LNASEvAUeJsBcp4eh+XW+gaVp921SU-d1m-DEs+Hs+YA8TA@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 7 Feb 2019 19:51:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT-QR3tYJMOLfTssD+tbrsy3G-DZtUvx4g7aC=sxgxtgQ@mail.gmail.com>
Message-ID: <CAK7LNAT-QR3tYJMOLfTssD+tbrsy3G-DZtUvx4g7aC=sxgxtgQ@mail.gmail.com>
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 7:46 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Thu, Feb 7, 2019 at 7:16 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >
> > Hi Masahiro,
> >
> > Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Thu,  7 Feb
> > 2019 18:57:56 +0900:
> >
> > > nand_scan_ident() calls onfi_fill_data_interface() at its entry
> > > to set up the initial timing parameters.
> > >
> > > The timing parameters are needed not only for ->setup_data_interface(),
> > > but also for giving the correct delay to NAND_OP_WAIT_RDY, for example.
> > >
> > > If the driver sets the NAND_KEEP_TIMINGS flag, or does not support
> > > ->setup_data_interface() hook, those parameters will never updated.
> >
> >                                                             ^ be
>
> Will fix (if v2 is welcome)
>
>
> > >
> > > Before nand_detect(), we never know whether the chip is ONFi or not.
> > > So, onfi_fill_data_interface() has to assume the worst case, i.e.
> > > non-ONFi.
> >
> > s/ONFi/ONFI/?
>
> Will fix.
>
> Looks like I was misunderstanding
> maybe because the letter 'I' in the logo
> (http://www.onfi.org/)
> looks like a lowercase...


http://www.onfi.org/ says

"Discover the advantages of an ONFi world"


Perhaps, is ONFi also correct??

Anyway, I will align with the majority.

There are only three instances in the kernel tree.


$ git grep ONFi
drivers/mtd/nand/raw/nand_legacy.c:      * a byte. The ONFi spec
(Revision 3.1; 2012-09-19, Section 2.16) reads:
drivers/mtd/nand/raw/nand_legacy.c:             /* EZ-NAND can take
upto 250ms as per ONFi v4.0 */
drivers/mtd/nand/raw/nand_legacy.c:             /* EZ-NAND can take
upto 250ms as per ONFi v4.0 */


-- 
Best Regards
Masahiro Yamada

Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24EBC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D21121721
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548146009;
	bh=oskaqloGxzpVlEB9EoI/Hzkqp8YIG8E7IGPgpL/k7Qc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=KJS2QqCWEwaWioQwBm0wdzYqoHnFbpiMaIMcocV0RtdHc1RsMkNJcdnACTLa3WYQI
	 gky2sHU7k4VjktmjN3uLcq1bI1iEkwWS0mSkJiFvTGIPKt7V9pCEM1yG+E8PZDyLfi
	 0PG/E7oV4hQ8Sf7vGbsPJk/qTr897kcTrTvppZik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfAVId1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 03:33:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:45606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727062AbfAVId1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 03:33:27 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B39920854;
        Tue, 22 Jan 2019 08:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548146005;
        bh=oskaqloGxzpVlEB9EoI/Hzkqp8YIG8E7IGPgpL/k7Qc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SN6uOnX8QcU7tNGU9shqUyIV1FcOmx2EDwewPXEUA3j1HSQ1E2IRndoza8MPxJC6c
         fkBhLVgEvC7v1lP/src3CD9wEldzKuVx1B2M3jjQaQpC+qwCvnYdW+qrA7vJUtuKn2
         7LQCt/AbXQjWhAPSGjDbdtPd190CEKmkxTGV4H84=
Date:   Tue, 22 Jan 2019 09:33:13 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Lucas Stach <dev@lynxeye.de>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Linus Walleij <linus.walleij@linaro.org>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-tegra@vger.kernel.org,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 2/2] mtd: rawnand: use unnamed union in struct
 nand_op_parser_pattern_elem
Message-ID: <20190122093313.67375948@bbrezillon>
In-Reply-To: <20190122090830.118eb6be@xps13>
References: <1548142975-14219-1-git-send-email-yamada.masahiro@socionext.com>
        <1548142975-14219-3-git-send-email-yamada.masahiro@socionext.com>
        <20190122084944.420fcd4a@xps13>
        <CAK7LNAQvD03By1PQJ8KZG-UqX+NVQcL6JU-5a-2ZVVovdgBpEQ@mail.gmail.com>
        <20190122090830.118eb6be@xps13>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2019 09:08:30 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hi Masahiro,
> 
> Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Tue, 22 Jan
> 2019 17:00:54 +0900:
> 
> > On Tue, Jan 22, 2019 at 4:50 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:  
> > >
> > > Hi Masahiro,
> > >
> > > Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Tue, 22 Jan
> > > 2019 16:42:55 +0900:
> > >    
> > > > Although drivers do not directly get access to the private data of
> > > > instruction patterns, let's use unnamed union field to be consistent
> > > > with nand_op_instr.
> > > >    
> > >
> > > Actually this is how we wrote it the first time. Then we got robots
> > > reporting that anonymous unions where not allowed with older (still
> > > supported) GCC versions and I had to do this:
> > >
> > >
> > > commit c1a72e2dbb4abb90bd408480d7c48ba40cb799ce
> > > Author: Miquel Raynal <miquel.raynal@free-electrons.com>
> > > Date:   Fri Jan 19 19:11:27 2018 +0100
> > >
> > >     mtd: nand: Fix build issues due to an anonymous union
> > >
> > >     GCC-4.4.4 raises errors when assigning a parameter in an anonymous
> > >     union, leading to this kind of failure:
> > >
> > >     drivers/mtd/nand/marvell_nand.c:1936:
> > >         warning: missing braces around initializer
> > >         warning: (near initialization for '(anonymous)[1].<anonymous>')
> > >         error: unknown field 'data' specified in initializer
> > >         error: unknown field 'addr' specified in initializer
> > >
> > >     Work around the situation by naming these unions.
> > >
> > >     Fixes: 8878b126df76 ("mtd: nand: add ->exec_op() implementation")
> > >     Reported-by: Andrew Morton <akpm@linux-foundation.org>
> > >     Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
> > >     Tested-by: Andrew Morton <akpm@linux-foundation.org>
> > >     Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > >    
> > 
> > 
> > Hmm, how come Andrew's compiler was fine with the following?
> > 
> > struct nand_flash_dev {
> >         char *name;
> >         union {
> >                 struct {
> >                         uint8_t mfr_id;
> >                         uint8_t dev_id;
> >                 };
> >                 uint8_t id[NAND_MAX_ID_LEN];
> >         };
> >         unsigned int pagesize;
> >         ...
> > };
> >   
> 
> It is probably not :)

It was compile fine. I don't know all the subtleties, but maybe it's
because ->id[] is a base type and not a struct.

> 
> > 
> > 
> > The current minimum version is GCC 4.6
> > (commit cafa0010cd51fb7)
> > but I am not sure if this restriction is remaining.
> >   
> 
> That's right, can you please test if this limitation is still
> ongoing wit GCC 4.6?

I have a more important question: why should we go bad back to unnamed
unions? Why is that a problem to have a named union? Sure, we initially
started with an unnamed ones because it made lines shorter, but now that
we switched to named unions I don't see the point of going back and
patching all drivers again (at the risk of seeing this problem appear
again when compiled with an old compiler version).

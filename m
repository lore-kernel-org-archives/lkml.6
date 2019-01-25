Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147E9C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F242146E
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfAYMjC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 07:39:02 -0500
Received: from mail.bootlin.com ([62.4.15.54]:49347 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbfAYMjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 07:39:01 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 898CE207B0; Fri, 25 Jan 2019 13:38:59 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
        by mail.bootlin.com (Postfix) with ESMTPSA id 37F3520397;
        Fri, 25 Jan 2019 13:38:49 +0100 (CET)
Date:   Fri, 25 Jan 2019 13:38:49 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] mtd: rawnand: check return code of nand_reset() and
 nand_readid_op()
Message-ID: <20190125133849.155819be@xps13>
In-Reply-To: <CAK7LNATUpyfnicBiSdL49dsFnvo+M=N9X-wY-J0efnRc-1_0gA@mail.gmail.com>
References: <1548075934-19963-1-git-send-email-yamada.masahiro@socionext.com>
        <20190121141403.20f6107b@bbrezillon>
        <CAK7LNATUpyfnicBiSdL49dsFnvo+M=N9X-wY-J0efnRc-1_0gA@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Tue, 22 Jan
2019 00:57:43 +0900:

> On Mon, Jan 21, 2019 at 10:14 PM Boris Brezillon <bbrezillon@kernel.org> wrote:
> >
> > On Mon, 21 Jan 2019 22:05:34 +0900
> > Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> >  
> > > nand_scan_ident() iterates over maxchips to find as many homogeneous
> > > chips as possible.
> > >
> > > Currently, this loop bails out only when manufacturer or device ID
> > > unmatches. The reason of unmatch is most likely no chip is connected
> > > to that chip select. In this case, nand_reset() has already failed,
> > > and the following nand_readid_op() is pointless.  
> >
> > While I agree with the following diff, I'd also like to point out that
> > nand_scan() callers should know how many controller CS lines are
> > connected to the chip (board file or DT description). The check we do in
> > nand_scan_ident() should only be here to clamp this value if the board
> > desc is wrong (maybe we should even fail in that case instead of
> > silently fixing things).  
> 
> 
> I know this.
> This is a problem for denali because
> I have not decoupled chip/controller yet.
> 
> 
> Maybe, is the following better?
> 
> 
> ------------------>8-----------------------  
> nand_scan_ident() iterates over maxchips to find as many homogeneous
> chips as possible.
> 
> Since commit 2d472aba15ff ("mtd: nand: document the NAND controller/NAND
> chip DT representation"), new drivers should pass in the exact number of
> CS lines instead of possible max, but old platforms may still rely on
> nand_scan_ident() to detect the actual number of connected CS lines.
> 
> In that case, this loop bails out when manufacturer or device ID
> unmatches. The reason of unmatch is most likely no chip is connected
> to that CS line. If so, nand_reset() should already have failed,
> and the following nand_readid_op() is pointless.
> 
> Before ->exec_op hook was introduced, drivers had no way to tell
> the failure of NAND_CMD_RESET to the framework because the legacy
> ->cmdfunc() has void return type. Now drivers implementing ->exec_op  
> hook can return the error code. You can save nand_readid_op() by
> checking the return value of nand_reset(). The return value of
> nand_readid_op() should be checked as well. If it fails, probably
> id[0] and id[1] are undefined values.
> 
> Just for consistency, it should be sensible to check the return
> code in nand_do_write_oob() as well.
> ------------------------------>8--------------------------------  
> 

Patch applied to nand/next with the second commit log you proposed.

Thanks for all your work!
Miquèl

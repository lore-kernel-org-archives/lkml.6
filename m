Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8021DC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE0E208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FE0E208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933982AbeFRNRp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 09:17:45 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36789 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933009AbeFRNRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 09:17:43 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1D752207A5; Mon, 18 Jun 2018 15:17:41 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-50-153.w90-88.abo.wanadoo.fr [90.88.168.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id C8BD120650;
        Mon, 18 Jun 2018 15:17:30 +0200 (CEST)
Date:   Mon, 18 Jun 2018 15:17:30 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [RFC PATCH 1/2] mtd: rawnand: handle ONFI revision number field
 being 0
Message-ID: <20180618151730.77bb168f@bbrezillon>
In-Reply-To: <20180618150521.067ef156@xps13>
References: <20180618045255.8015-1-chris.packham@alliedtelesis.co.nz>
        <20180618045255.8015-2-chris.packham@alliedtelesis.co.nz>
        <20180618150521.067ef156@xps13>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jun 2018 15:05:21 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hi Chris,
> 
> On Mon, 18 Jun 2018 16:52:54 +1200, Chris Packham
> <chris.packham@alliedtelesis.co.nz> wrote:
> 
> > Some Micron NAND chips (MT29F1G08ABAFAWP-ITE:F) report 00 00 for the
> > revision number field of the ONFI parameter page. Rather than rejecting
> > these outright assume ONFI version 1.0 if the revision number is 00 00.
> >   
> 
> Thanks for getting your hands into this.
> 
> > Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> > ---
> > At the moment I haven't qualified this check on anything, I should
> > probably at least include vendor == MICRON.  
> 
> The more I think about it the more I convince myself that this is not
> needed. If the 4 first bytes are "ONFI", then the chip is ONFI...
> 
> Then what you do below is simple and readable and (sadly) probably
> right.

Hm, I'm not entirely convinced considering version = 0 <=> version = 1
is the right thing to do. Clearly, we don't know if other chips are
also broken WRT version field but the actual version might differ.

I'd recommend letting the manufacturer driver fix the param page
instead of guessing what has to been done in the core. That means
adding a new hook to nand_manufacturer_ops (->fixup_onfi_param_page()?)
and calling it just after the CRC has been checked [1].

[1]https://elixir.bootlin.com/linux/v4.18-rc1/source/drivers/mtd/nand/raw/nand_base.c#L5170

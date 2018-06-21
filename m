Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F0DC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A64D20837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A64D20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754184AbeFUHPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 03:15:05 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44567 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750981AbeFUHPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 03:15:04 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 69E7720717; Thu, 21 Jun 2018 09:15:02 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-50-153.w90-88.abo.wanadoo.fr [90.88.168.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 13C6F20741;
        Thu, 21 Jun 2018 09:14:52 +0200 (CEST)
Date:   Thu, 21 Jun 2018 09:14:51 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>
Cc:     Richard Weinberger <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v3 3/4] mtd: rawnand: micron: add fixup for ONFI
 revision
Message-ID: <20180621091451.1a0226de@bbrezillon>
In-Reply-To: <5e3b8f2f896f44aaab97086dceb2a69b@svr-chch-ex1.atlnz.lc>
References: <20180620050544.31549-1-chris.packham@alliedtelesis.co.nz>
        <20180620050544.31549-4-chris.packham@alliedtelesis.co.nz>
        <20180620095410.664091d8@bbrezillon>
        <5e3b8f2f896f44aaab97086dceb2a69b@svr-chch-ex1.atlnz.lc>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jun 2018 21:12:02 +0000
Chris Packham <Chris.Packham@alliedtelesis.co.nz> wrote:

> On 20/06/18 19:54, Boris Brezillon wrote:
> > On Wed, 20 Jun 2018 17:05:43 +1200
> > Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:
> >   
> >> Some Micron NAND chips (MT29F1G08ABAFAWP-ITE:F) report 00 00 for the
> >> revision number field of the ONFI parameter page. Rather than rejecting
> >> these outright assume ONFI version 1.0 if the revision number is 00 00.
> >>
> >> Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
> >> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> >> ---
> >> This is now qualified on vendor == MICRON. I haven't qualified this
> >> based on specific chips the ABAFA (id=d1) and ABBFA (id=a1) variants are
> >> documented to have this behaviour.
> >>
> >> Changes in v2:
> >> - use fixup_onfi_param_page
> >> Changes in v3:
> >> - add code comment next to workaround
> >>
> >>   drivers/mtd/nand/raw/nand_micron.c | 13 +++++++++++++
> >>   1 file changed, 13 insertions(+)
> >>
> >> diff --git a/drivers/mtd/nand/raw/nand_micron.c b/drivers/mtd/nand/raw/nand_micron.c
> >> index 5ec4c90a637d..5cec79372181 100644
> >> --- a/drivers/mtd/nand/raw/nand_micron.c
> >> +++ b/drivers/mtd/nand/raw/nand_micron.c
> >> @@ -289,6 +289,19 @@ static int micron_nand_init(struct nand_chip *chip)
> >>   	return 0;
> >>   }
> >>   
> >> +static void micron_fixup_onfi_param_page(struct nand_chip *chip,
> >> +					 struct nand_onfi_params *p)
> >> +{
> >> +	/*
> >> +	 * MT29F1G08ABAFAWP-ITE:F and possibly others report 00 00 for the
> >> +	 * revision number field of the ONFI parameter page. Assume ONFI
> >> +	 * version 1.0 if the revision number is 00 00.
> >> +	 */
> >> +	if (le16_to_cpu(p->revision) == 0)
> >> +		p->revision = cpu_to_le16(1 << 1);  
> > 
> > Would be better to have macros defining all version numbers in rawnand.h
> > 
> > #define ONFI_VERSION_1_0		BIT(1)
> > #define ONFI_VERSION_2_0		BIT(2)
> > #define ONFI_VERSION_2_1		BIT(3)
> > #define ONFI_VERSION_2_2		BIT(4)
> > #define ONFI_VERSION_2_3		BIT(5)
> > #define ONFI_VERSION_3_0		BIT(6)
> > #define ONFI_VERSION_3_1		BIT(7)
> > #define ONFI_VERSION_3_2		BIT(8)
> > #define ONFI_VERSION_4_0		BIT(9)
> >   
> 
> Make sense. Do you want me to do so in a v4 or send a new patch and 
> clean up the other uses?

It can be part of your v4, but yes, the idea is to first introduce the
macros and patch existing users, and then use it in this patch.

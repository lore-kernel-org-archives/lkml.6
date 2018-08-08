Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0321DC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F85D219DB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F85D219DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbeHHOxe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 10:53:34 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58899 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726733AbeHHOxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 10:53:34 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CB2042084E; Wed,  8 Aug 2018 14:34:01 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-99-143.w90-88.abo.wanadoo.fr [90.88.4.143])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7732020741;
        Wed,  8 Aug 2018 14:33:51 +0200 (CEST)
Date:   Wed, 8 Aug 2018 14:33:52 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Jane Wan <Jane.Wan@nokia.com>,
        Jagdish Gediya <jagdish.gediya@nxp.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mtd: nand: fsl-ifc: fixup SRAM init for newer ctrl
 versions
Message-ID: <20180808143352.2f5b999c@xps13>
In-Reply-To: <20180808100909.anfi3qlfjnzb74p2@linutronix.de>
References: <20180806092137.9287-1-kurt@linutronix.de>
        <20180806092137.9287-3-kurt@linutronix.de>
        <20180808114832.61d31c29@xps13>
        <20180808100909.anfi3qlfjnzb74p2@linutronix.de>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kurt,


> > > @@ -769,6 +770,23 @@ static int fsl_ifc_sram_init(struct fsl_ifc_mtd *priv)
> > >  	uint32_t csor = 0, csor_8k = 0, csor_ext = 0;
> > >  	uint32_t cs = priv->bank;
> > >
> > > +	if (ctrl->version > FSL_IFC_VERSION_1_1_0) {  
> >
> > This is redundant and fsl_ifc_sram_init() is called only if
> > "ctrl->version > FSL_FC_VERSION_1_1_0".  
> 
> No, it's not. It's called when ctrl->version >=
> FSL_IFC_VERSION_1_1_0. Therefore, this check is needed.

Oh right, I missed the "=".

> 
> >
> > So this means this function has never worked?  
> 
> It did work for e.g. IFC controller in version 1.1.0.
> 
> However, it worked for the newer versions by accident, because U-Boot
> already initialized the SRAM correctly. If you boot without NAND
> initialization in U-Boot, then you'll hit the issue.
> 
> >
> > If this is the case, there should be at least a Fixes: tag.
> >
> > Maybe it would be cleaner to always call fsl_ifc_sram_init() from the
> > probe(), and just exit with a "return 0" here if the version is old?
> > (I'll let you choose the way you prefer).  
> 
> Sounds like a good idea. Otherwise we have to check the version twice.
> 
> >  
> > > +		u32 ncfgr, status;
> > > +		int ret;
> > > +
> > > +		/* Trigger auto initialization */
> > > +		ncfgr = ifc_in32(&ifc_runtime->ifc_nand.ncfgr);
> > > +		ifc_out32(ncfgr | IFC_NAND_NCFGR_SRAM_INIT_EN, &ifc_runtime->ifc_nand.ncfgr);
> > > +
> > > +		/* Wait until done */
> > > +		ret = readx_poll_timeout(ifc_in32, &ifc_runtime->ifc_nand.ncfgr,
> > > +					 status, !(status & IFC_NAND_NCFGR_SRAM_INIT_EN),
> > > +					 10, 1000);  
> >
> > Nit: I always prefer when delays/timeouts are defined (and may be
> > reused).  
> 
> Me too. I've missed that there is already a timeout constant
> IFC_TIMEOUT_MSECS (500). As it's huge, I'll add a second one.

Well, I'm not bothered with huge timeouts, it's in the error path so we
don't really care.

Thanks,
Miquèl

Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99828C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 10:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF9420891
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 10:45:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DF9420891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933686AbeFQKpp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 06:45:45 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33642 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933490AbeFQKpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 06:45:43 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AfJtHHTo0lBD; Sun, 17 Jun 2018 12:45:41 +0200 (CEST)
Received: from zn.tnic (p200300EC2BE29C00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2be2:9c00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8CFB01EC0136;
        Sun, 17 Jun 2018 12:45:41 +0200 (CEST)
Date:   Sun, 17 Jun 2018 12:45:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thor Thayer <thor.thayer@linux.intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH V2] EDAC, altera: Fix an error handling path in
 'altr_s10_sdram_probe()'
Message-ID: <20180617104538.GA16877@zn.tnic>
References: <20180610174532.22071-1-christophe.jaillet@wanadoo.fr>
 <092ce90c-1f68-1041-4385-997dcb13bc22@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <092ce90c-1f68-1041-4385-997dcb13bc22@linux.intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 09:53:53AM -0500, Thor Thayer wrote:
> On 06/10/2018 12:45 PM, Christophe JAILLET wrote:
> > IF 'regmap_write()' fails, we should release some resources as done in all
> > the other error handling paths of the function.
> > 
> > Fixes: e9918d7fafae ("EDAC, altera: Handle SDRAM Uncorrectable Errors on Stratix10")
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> > v1 -> v2: Fix subject line
> > ---
> >   drivers/edac/altera_edac.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> > index d0d5c4dbe097..5762c3c383f2 100644
> > --- a/drivers/edac/altera_edac.c
> > +++ b/drivers/edac/altera_edac.c
> > @@ -730,7 +730,8 @@ static int altr_s10_sdram_probe(struct platform_device *pdev)
> >   			 S10_DDR0_IRQ_MASK)) {
> >   		edac_printk(KERN_ERR, EDAC_MC,
> >   			    "Error clearing SDRAM ECC count\n");
> > -		return -ENODEV;
> > +		ret = -ENODEV;
> > +		goto err2;
> >   	}
> >   	if (regmap_update_bits(drvdata->mc_vbase, priv->ecc_irq_en_offset,
> > Thanks.
> 
> Reviewed-by: Thor Thayer <thor.thayer@linux.intel.com>

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC931C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808B720862
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 808B720862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730244AbeG0JIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 05:08:30 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55339 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729541AbeG0JIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 05:08:30 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 64AFD208FF; Fri, 27 Jul 2018 09:47:49 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-89-120.w90-88.abo.wanadoo.fr [90.88.30.120])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0F16B20741;
        Fri, 27 Jul 2018 09:47:39 +0200 (CEST)
Date:   Fri, 27 Jul 2018 09:47:39 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Nicholas Mc Guire <der.herr@hofr.at>
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Graham Moore <grmoore@opensource.altera.com>,
        Vignesh R <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] mtd: spi-nor: cadence-quadspi: make return type fit
 wait_for_completion_timeout
Message-ID: <20180727094739.10429824@bbrezillon>
In-Reply-To: <20180727052149.GA7462@osadl.at>
References: <1532189293-5975-1-git-send-email-hofrat@osadl.org>
        <20180724224626.777149ce@bbrezillon>
        <20180725063137.GB7194@osadl.at>
        <20180726220928.710f6276@bbrezillon>
        <20180727052149.GA7462@osadl.at>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jul 2018 05:21:49 +0000
Nicholas Mc Guire <der.herr@hofr.at> wrote:

> On Thu, Jul 26, 2018 at 10:09:28PM +0200, Boris Brezillon wrote:
> > On Wed, 25 Jul 2018 06:31:37 +0000
> > Nicholas Mc Guire <der.herr@hofr.at> wrote:
> >   
> > > On Tue, Jul 24, 2018 at 10:46:26PM +0200, Boris Brezillon wrote:  
> > > > On Sat, 21 Jul 2018 18:08:13 +0200
> > > > Nicholas Mc Guire <hofrat@osadl.org> wrote:
> > > >     
> > > > > wait_for_completion_timeout returns an unsigned long not int. declare a
> > > > > suitably type timeout and fix up assignment and check.
> > > > > 
> > > > > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > > > > Reported-by: Vignesh R <vigneshr@ti.com>
> > > > > Fixes: 140623410536 ("mtd: spi-nor: Add driver for Cadence Quad SPI Flash Controller")    
> > > > 
> > > > If you don't mind, I'd like to squash all wait_for_completion_timeout()
> > > > fixes into a single commit.
> > > >    
> > > makes sense - no objections to that at all.  
> > 
> > 
> > I also dropped the timeout vars and checked the return of
> > wait_for_completion_timeout() directly + removed the Fixes tag since
> > it's no longer possible to attach the fix to a single commit and also,
> > I'm sure the bug really existed (no overflow possible since the timeout
> > values are small enough to fit in a signed int).
> > 
> > Here is the resulting patch. Let me know if you're okay with this version.
> >  
> 
> looks good to me - quit a bit simpler than what I did - thanks !
> 
> thx!
> hofrat
>  
> > Thanks,
> > 
> > Boris
> >   
> > --->8---  
> > From 69edac4ef4d1c8dac519b6d12afd4097ce72a54e Mon Sep 17 00:00:00 2001
> > From: Nicholas Mc Guire <hofrat@osadl.org>
> > Date: Sat, 21 Jul 2018 16:21:51 +0200
> > Subject: [PATCH] mtd: spi-nor: cadence-quadspi: fix timeout handling
> > 
> > wait_for_completion_timeout returns an unsigned long not an int, so
> > let's check its return value directly instead of storing it in ret,
> > and avoid checking for negative values since this cannot happen.
> > 
> > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>

Applied this version.

Thanks,

Boris

> > ---
> >  drivers/mtd/spi-nor/cadence-quadspi.c | 20 ++++++++------------
> >  1 file changed, 8 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
> > index c3f7aaa5d18f..7a19dae717fa 100644
> > --- a/drivers/mtd/spi-nor/cadence-quadspi.c
> > +++ b/drivers/mtd/spi-nor/cadence-quadspi.c
> > @@ -525,15 +525,14 @@ static int cqspi_indirect_read_execute(struct spi_nor *nor, u8 *rxbuf,
> >  	       reg_base + CQSPI_REG_INDIRECTRD);
> >  
> >  	while (remaining > 0) {
> > -		ret = wait_for_completion_timeout(&cqspi->transfer_complete,
> > -						  msecs_to_jiffies
> > -						  (CQSPI_READ_TIMEOUT_MS));
> > +		if (!wait_for_completion_timeout(&cqspi->transfer_complete,
> > +				msecs_to_jiffies(CQSPI_READ_TIMEOUT_MS)))
> > +			ret = -ETIMEDOUT;
> >  
> >  		bytes_to_read = cqspi_get_rd_sram_level(cqspi);
> >  
> > -		if (!ret && bytes_to_read == 0) {
> > +		if (ret && bytes_to_read == 0) {
> >  			dev_err(nor->dev, "Indirect read timeout, no bytes\n");
> > -			ret = -ETIMEDOUT;
> >  			goto failrd;
> >  		}
> >  
> > @@ -649,10 +648,8 @@ static int cqspi_indirect_write_execute(struct spi_nor *nor, loff_t to_addr,
> >  		iowrite32_rep(cqspi->ahb_base, txbuf,
> >  			      DIV_ROUND_UP(write_bytes, 4));
> >  
> > -		ret = wait_for_completion_timeout(&cqspi->transfer_complete,
> > -						  msecs_to_jiffies
> > -						  (CQSPI_TIMEOUT_MS));
> > -		if (!ret) {
> > +		if (!wait_for_completion_timeout(&cqspi->transfer_complete,
> > +					msecs_to_jiffies(CQSPI_TIMEOUT_MS))) {
> >  			dev_err(nor->dev, "Indirect write timeout\n");
> >  			ret = -ETIMEDOUT;
> >  			goto failwr;
> > @@ -986,9 +983,8 @@ static int cqspi_direct_read_execute(struct spi_nor *nor, u_char *buf,
> >  	}
> >  
> >  	dma_async_issue_pending(cqspi->rx_chan);
> > -	ret = wait_for_completion_timeout(&cqspi->rx_dma_complete,
> > -					  msecs_to_jiffies(len));
> > -	if (ret <= 0) {
> > +	if (!wait_for_completion_timeout(&cqspi->rx_dma_complete,
> > +					 msecs_to_jiffies(len))) {
> >  		dmaengine_terminate_sync(cqspi->rx_chan);
> >  		dev_err(nor->dev, "DMA wait_for_completion_timeout\n");
> >  		ret = -ETIMEDOUT;  


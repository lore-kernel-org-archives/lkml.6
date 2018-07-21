Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA812ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 15:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 783A720856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 15:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 783A720856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hofr.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbeGUQrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 12:47:47 -0400
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:49397 "EHLO
        mail.osadl.at" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbeGUQrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 12:47:47 -0400
Received: by mail.osadl.at (Postfix, from userid 1001)
        id CE15C5C0DC9; Sat, 21 Jul 2018 15:52:57 +0000 (UTC)
Date:   Sat, 21 Jul 2018 15:52:57 +0000
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 1/2] mtd: spi-nor: cadence-quadspi: fix timeout handling
 in wait_for_completion_timeout
Message-ID: <20180721155257.GA26599@osadl.at>
References: <1532182912-3674-1-git-send-email-hofrat@osadl.org>
 <a0644f99-b997-2a94-01ac-dcc2656e984b@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0644f99-b997-2a94-01ac-dcc2656e984b@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 21, 2018 at 09:11:51PM +0530, Vignesh R wrote:
> Hi,
> 
> On 21-Jul-18 7:51 PM, Nicholas Mc Guire wrote:
> > wait_for_completion_timeout returns unsigned long not int so a variable of
> > proper type is introduced. Further the check for <= 0 is ambiguous and should
> > be == 0 here.
> >
> 
> Oops, my bad. Thanks for the fix! I see you have fixed similar bug in
> cqspi_indirect_read_execute(). There is similar code in
> cqspi_indirect_write_execute(). Could you fix that as well?
>

nice - so you just found a bug in my coccinelle script as it did not catch
that case of wrong type (which it should) - thanks ! 
will send a patch shortly.
 
> Regards
> Vignesh
> 
> 
> > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > Fixes: ffa639e069fb ("mtd: spi-nor: cadence-quadspi: Add DMA support for direct mode reads")
> > ---
> > 
> > Patch found by experimental coccinelle API conformance checker
> >> Patch was compile tested with: socfpga_defconfig (implies
> > CONFIG_SPI_CADENCE_QUADSPI=y)
> > 
> > Patch is against 4.18-rc5 (localversion-next is next-20180720)
> > 
> >  drivers/mtd/spi-nor/cadence-quadspi.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
> > index d7e10b3..79f6a54 100644
> > --- a/drivers/mtd/spi-nor/cadence-quadspi.c
> > +++ b/drivers/mtd/spi-nor/cadence-quadspi.c
> > @@ -953,6 +953,7 @@ static int cqspi_direct_read_execute(struct spi_nor *nor, u_char *buf,
> >  	enum dma_ctrl_flags flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
> >  	dma_addr_t dma_src = (dma_addr_t)cqspi->mmap_phys_base + from;
> >  	int ret = 0;
> > +	unsigned long timeout;
> >  	struct dma_async_tx_descriptor *tx;
> >  	dma_cookie_t cookie;
> >  	dma_addr_t dma_dst;
> > @@ -988,9 +989,9 @@ static int cqspi_direct_read_execute(struct spi_nor *nor, u_char *buf,
> >  	}
> >  
> >  	dma_async_issue_pending(cqspi->rx_chan);
> > -	ret = wait_for_completion_timeout(&cqspi->rx_dma_complete,
> > -					  msecs_to_jiffies(len));
> > -	if (ret <= 0) {
> > +	timeout = wait_for_completion_timeout(&cqspi->rx_dma_complete,
> > +					      msecs_to_jiffies(len));
> > +	if (timeout == 0) {
> >  		dmaengine_terminate_sync(cqspi->rx_chan);
> >  		dev_err(nor->dev, "DMA wait_for_completion_timeout\n");
> >  		ret = -ETIMEDOUT;
> > 

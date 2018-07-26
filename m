Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97525C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AEE32064D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AEE32064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731632AbeGZQ1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 12:27:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56148 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730083AbeGZQ1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 12:27:02 -0400
Received: from localhost (unknown [62.119.166.9])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3ACE4CFE;
        Thu, 26 Jul 2018 15:09:43 +0000 (UTC)
Date:   Thu, 26 Jul 2018 17:09:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH 4.4 101/105] spi: Fix scatterlist elements size in
 spi_map_buf
Message-ID: <20180726150940.GD27305@kroah.com>
References: <20180701153149.382300170@linuxfoundation.org>
 <20180701153156.693937436@linuxfoundation.org>
 <1532114624.21552.43.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1532114624.21552.43.camel@codethink.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 08:23:44PM +0100, Ben Hutchings wrote:
> On Sun, 2018-07-01 at 18:02 +0200, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > 
> > commit ce99319a182fe766be67f96338386f3ec73e321c upstream.
> > 
> > When SPI transfers can be offloaded using DMA, the SPI core need to
> > build a scatterlist to make sure that the buffer to be transferred is
> > dma-able.
> > 
> > This patch fixes the scatterlist entry size computation in the case
> > where the maximum acceptable scatterlist entry supported by the DMA
> > controller is less than PAGE_SIZE, when the buffer is vmalloced.
> > 
> > For each entry, the actual size is given by the minimum between the
> > desc_len (which is the max buffer size supported by the DMA controller)
> > and the remaining buffer length until we cross a page boundary.
> > 
> > Fixes: 65598c13fd66 ("spi: Fix per-page mapping of unaligned vmalloc-ed buffer")
> > Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/spi/spi.c |   10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > --- a/drivers/spi/spi.c
> > +++ b/drivers/spi/spi.c
> > @@ -707,8 +707,14 @@ static int spi_map_buf(struct spi_master
> >  	for (i = 0; i < sgs; i++) {
> >  
> >  		if (vmalloced_buf) { 
> > -			min = min_t(size_t,
> > -				    len, desc_len - offset_in_page(buf));
> > +			/*
> > +			 * Next scatterlist entry size is the minimum between
> > +			 * the desc_len and the remaining buffer length that
> > +			 * fits in a page.
> > +			 */
> > +			min = min_t(size_t, desc_len,
> > +				    min_t(size_t, len,
> > +					  PAGE_SIZE - offset_in_page(buf)));
> >  			vm_page = vmalloc_to_page(buf);
> >  			if (!vm_page) {
> >  				sg_free_table(sgt);
> 
> I think this makes sense upstream, but in 4.4 it seems to be a no-op
> since desc_len is always set to PAGE_SIZE when vmalloced_buf is true.
> This fix depends on (at least) commit df88e91bbfd1 "spi: respect the
> maximum segment size of DMA device" which went into 4.6.

Good catch.  I'll leave it as-is for now though.

thanks,

greg k-h

Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A76C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D912086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NZXL57fE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfANLJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:09:54 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59556 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbfANLJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 06:09:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IYhu4dKLu7L10t7jNRIgq6v9ENSKm6hUrZneFOvktpI=; b=NZXL57fE+fd52Ryq4TD+k6cNr
        sdSlwkxWE4P59f0ui5d4BD8PXZCPZwAx0Cs0f9a4HxxFomownWVpFLV+HcUB05xm653yONl4j5wBf
        XtKPWHUxIM8ucREkXQ7HhZ7ledKlWQQ2b92oaEkpNwn9Pny2oLdA3C1JlXolm8jrBdHKk+mFrgQNC
        R02Rs9RC69IGDjLtv8a3gTkquSZbrAwOJX4KOPSbwZ0cn/WZ0y8Le3GTBOqGiJPWeSGElIVUyK5eS
        AHRFWAwRODlZEk71lkxxX/LNYye9lo1f80bfLPpq4xxGyW+sc6blpnPpS502KJzWLUlwYRa00bvEg
        ApbXP84/w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gj07n-0004qn-Km; Mon, 14 Jan 2019 11:09:47 +0000
Date:   Mon, 14 Jan 2019 03:09:47 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Krishna Reddy <vdumpa@nvidia.com>, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mmc: sdhci: Properly set DMA mask
Message-ID: <20190114110947.GA30778@infradead.org>
References: <20190104104753.3383-1-thierry.reding@gmail.com>
 <20190104174354.GA18110@infradead.org>
 <20190110105911.GA32301@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110105911.GA32301@ulmo>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 11:59:11AM +0100, Thierry Reding wrote:
> On Fri, Jan 04, 2019 at 09:43:54AM -0800, Christoph Hellwig wrote:
> > > +	u64 dma_mask = dma_get_mask(dev);
> > 
> > This is not a driver API.  I think what you want is
> > dma_get_required_mask to query the mask.  But in that case
> > you still need to always actually set a mask in the driver as well.
> 
> That's slightly different from what I want to do here. The purpose of
> this part of the patch is that when the SDHCI hardware supports only 32
> bits of address space, then we want to prevent 64-bit addressing mode
> from being used because it isn't useful.
> 
> So what we do want to check here is the DMA mask configured by the
> driver (or the default set by the bus, or wherever it came from).
> dma_get_required_mask() returns the DMA mask required to address all of
> system memory. That would perhaps be a useful additional check, but it's
> orthogonal to what I'm trying to do here.
> 
> Is there something else appropriate that I could use to query the DMA
> mask set for a device?

I think the problem is that you try to mix up responsibility of who
needs to set the DMA mask.  Either we want the core sdhci code set
it as we do, or we move it to the driver, probably optionally.

So instead of trying to read something back you should either:

 - add a set_dma_mask to override it
 - add a 64bit_mode_dma_mask field to strct mmc_host, initialize
   that to 64-bit by default and let host drivers override it

While the first one creates a little more boilerplate code it actually
looks cleaner to me.  The added benefit is that it can also replace the
usage of SDHCI_QUIRK2_BROKEN_64_BIT_DMA.

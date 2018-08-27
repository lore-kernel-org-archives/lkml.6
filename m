Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD5BC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 13:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B27208B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 13:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Huz8QeIw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B27208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbeH0RmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 13:42:10 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:39695 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbeH0RmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 13:42:10 -0400
Received: by mail-oi0-f67.google.com with SMTP id c190-v6so27374914oig.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 06:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LrMe5qV2FEx7Ovh52zi6bUiFejPilfd6LnGKiNbt5rU=;
        b=Huz8QeIwCp6ZJ4ZIkxpiuYD3nDb0/CqG9/WFiqY20pGuroVU48lzNnOD36tlixSr5L
         9Y0IybrYN+tfB/ofouHPTTIMRhVIdzIqRK68dpCkAqGn5FOISP/7UE79Ar2p7iqK0Zxc
         BkZYofoyjxjfy7NO0UGQlax+H5I0RF32+bGDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LrMe5qV2FEx7Ovh52zi6bUiFejPilfd6LnGKiNbt5rU=;
        b=iXiNTPWpDp5VTWeUyIFC7RGUFnY7W1J4hYjNBVHrCcEAuf3TJFRVKiidE3AY0pisPT
         8UdN2qUfmE5AH6UjUc/hGkSB1F/9VV+1cI002XOQk5E91ruvu2tlDUEQyUUwoKCdsrkk
         ptfkxeWLRq49fNDqe8mhG3DkiQ/LGsBMeV1AuS3UTxJPplzMbeZ9WtAwY1Q+5xlMggSb
         xoE6HsmtVV+NABYPevmOcHr1K6KDbfK/siCv4bqxhrQ54mJP+Q8PBK3VJhzwHQAxW3xe
         RHS+u+MrKgIUo9dsymwFqxOnwroE574YCL9k1AMPTzP0skaqurAcJoAztoatWT2rrrqc
         K7+A==
X-Gm-Message-State: APzg51DhG+TVGOdhGkow39VwAJh0wEOHwVSGjnpBD3JL2n1k44CloBy4
        7mfaZ2TsBnEl7jYCmsbPoOaP2Q==
X-Google-Smtp-Source: ANB0VdZRW4zL41bmxnIIlKvBINuZdHTVcqu9f7LtYxnCDteIOSVCzzzFNafwsAlWYwETLZOn1DXwEg==
X-Received: by 2002:aca:dbc2:: with SMTP id s185-v6mr12811688oig.251.1535378125335;
        Mon, 27 Aug 2018 06:55:25 -0700 (PDT)
Received: from localhost (68-248-140-212.lightspeed.austtx.sbcglobal.net. [68.248.140.212])
        by smtp.gmail.com with ESMTPSA id h186-v6sm25356180oib.55.2018.08.27.06.55.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 06:55:24 -0700 (PDT)
Date:   Mon, 27 Aug 2018 08:55:24 -0500
From:   Brian Brooks <brian.brooks@linaro.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     David Miller <davem@davemloft.net>, antoine.tenart@bootlin.com,
        maxime.chevallier@bootlin.com, ymarkman@marvell.com,
        stefanc@marvell.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.topel@intel.com,
        brian.brooks@arm.com
Subject: Re: [PATCH] net: mvpp2: avoid bouncing buffers
Message-ID: <20180827135524.fv4mxkwjn5bv7p5e@di3>
References: <20180820024730.9147-1-brian.brooks@linaro.org>
 <20180819.195505.1988137313680465320.davem@davemloft.net>
 <20180820062326.GA22222@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180820062326.GA22222@infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/19 23:23:26, Christoph Hellwig wrote:
> On Sun, Aug 19, 2018 at 07:55:05PM -0700, David Miller wrote:
> > From: Brian Brooks <brian.brooks@linaro.org>
> > Date: Sun, 19 Aug 2018 21:47:30 -0500
> > 
> > > @@ -5126,6 +5126,12 @@ static int mvpp2_probe(struct platform_device *pdev)
> > >  	}
> > >  
> > >  	if (priv->hw_version == MVPP22) {
> > > +		/* Platform code may have set dev->dma_mask to point
> > > +		 * to dev->coherent_dma_mask, but we want to ensure
> > > +		 * they take different values due to comment below.
> > > +		 */
> > > +		pdev->dev.dma_mask = &priv->dma_mask;
> > 
> > The platform code might be doing this exactly because it cannot support
> > different coherent and streaming DMA masks.
> > 
> > Well, in any case, the platform code is doing it for a reason and
> > overriding this in a "driver" of all places seems totally
> > inappropriate and at best a layering violation.
> > 
> > I would rather you fix this in a way that involves well defined APIs
> > that set the DMA masks or whatever to the values that you need, rather
> > than going behind the platform code's back and changing the DMA mask
> > pointer like this.
> 
> Agreed.  What platform do you see this issue on?

This is Armada 8040 SoC with PPv2 net device on chip. MACCHIATObin board.

Both DT and ACPI have the following snippet:

	/*
	 * Set default coherent_dma_mask to 32 bit.  Drivers are expected to
	 * setup the correct supported mask.
	 */
	if (!dev->coherent_dma_mask)
		dev->coherent_dma_mask = DMA_BIT_MASK(32);

	/*
	 * Set it to coherent_dma_mask by default if the architecture
	 * code has not set it.
	 */
	if (!dev->dma_mask)
		dev->dma_mask = &dev->coherent_dma_mask;

Some architectures code setup DMA masks, but it does not seem appropriate
to add mvpp2 specific code in arch/arm64. The mvpp2 driver appeared to be
the least invasive place to resolve the limitation of this net device.

Another DMA API could be added to allocate storage for the streaming
mask to ensure masks can take on separate values when the existing DMA
APIs are used by the driver to set those values. But, this would be the
only driver using such API. Would that be how to handle this?

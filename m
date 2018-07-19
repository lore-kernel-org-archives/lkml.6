Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3B6C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B910F20856
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eN6xao00"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B910F20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbeGSKEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 06:04:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726475AbeGSKEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 06:04:47 -0400
Received: from localhost (unknown [106.201.102.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D105520671;
        Thu, 19 Jul 2018 09:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531992152;
        bh=kpz/abq3EZ5FWyFhtE91WwLwcwUpCYDhIgpYSyGoMFo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eN6xao00NNDP0O/XKkX3EWiwNdoIw/Rt7tf1Nt0/7WXsuslciYewWP2zuoOMlk2sk
         e37MpZv0FmN8Dekm2PrhK0bfz2QxFKvT1glimLtchY7uDeAD9gtSaQ2XPCLJYqJo3k
         xXaG9BONcFhB/iU3mLJdJjeMbKwCQ0kbpDFINs+4=
Date:   Thu, 19 Jul 2018 14:52:24 +0530
From:   Vinod <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     radheys@xilinx.com, vinod.koul@intel.com, lars@metafoo.de,
        michal.simek@xilinx.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, dan.j.williams@intel.com,
        appanad@xilinx.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC] dmaengine: Add metadat_ops for dma_async_tx_descriptor
Message-ID: <20180719092224.GK3219@vkoul-mobl>
References: <32208a9c-2b15-d345-1432-f1e387531f9b@ti.com>
 <20180601102429.16429-1-peter.ujfalusi@ti.com>
 <20180710055230.GB3219@vkoul-mobl>
 <052ebdd9-7e68-5b78-52c3-304376f48777@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <052ebdd9-7e68-5b78-52c3-304376f48777@ti.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 18-07-18, 13:06, Peter Ujfalusi wrote:

> >> +struct dma_async_tx_descriptor;
> >> +
> >> +struct dma_descriptor_metadata_ops {
> >> +	int (*attach)(struct dma_async_tx_descriptor *desc, void *data,
> >> +		      size_t len);
> > 
> > How does one detach?
> 
> I have not thought about detach, but clients can just attach NULL I guess.

So what are the implication of attach and detach here, should the data
be deref by dmaengine driver and drop the ref.

Should anyone do refcounting?

> 
> > When should the client free up the memory, IOW when
> > does dma driver drop ref to data.
> 
> The metadata is for the descriptor so the DMA driver might want to
> access to it while the descriptor is valid.
> 
> Typically clients can free up their metadata storage after the dma
> completion callback. On DEV_TO_MEM the metadata is going to be placed in
> the provided buffer when the transfer is completed.

That sounds okay to me

> >> +	void *(*get_ptr)(struct dma_async_tx_descriptor *desc,
> >> +			 size_t *payload_len, size_t *max_len);
> > 
> > so what is this supposed to do..?
> 
> My issue with the attach in general is that it will need additional
> memcpy to move the metadata from/to the client buffer to it's place.
> 
> With get_ptr the client can get the pointer to the actual place where
> the metadata resides and modify/read it in place w/o memcpy.
> 
> I know, I know... We need to trust the clients, but with high throughput
> peripherals the memcpy is taxing.

Okay I am not sure I have understood fully, so with attach you set
a pointer (containing metdata?) so why do you need additional one..

> 
> > 
> >> +	int (*set_len)(struct dma_async_tx_descriptor *desc,
> >> +		       size_t payload_len);
> > 
> > attach already has length, so how does this help?
> 
> So, DMA drivers can implement either or both:
> 1. attach()
> 2. get_ptr() / set_len()

Ah okay, what are the reasons for providing two methods and not a single
one

> 
> Clients must not mix the two way of handling the metadata.
> The set_len() is intended to tell the DMA driver the client provided
> metadata size (in MEM_TO_DEV case mostly).
> 
> MEM_TO_DEV flow on client side:
> get_ptr()
> fill in the metadata to the pointer (not exceeding max_len)
> set_len() to tell the DMA driver the amount of valid bytes written
> 
> DEV_TO_MEM flow on client side:
> In the completion callback, get_ptr()
> the metadata is payload_len bytes and can be accessed in the return pointer.

I would think to unify this..

> BTW: The driver which is going to need this is now accessible in public:
> https://git.ti.com/ti-linux-kernel/ti-linux-kernel/trees/ti-linux-4.14.y/drivers/dma/ti
> 
> or in my wip tree:
> https://github.com/omap-audio/linux-audio/tree/peter/ti-linux-4.14.y/wip/drivers/dma/ti
> 
> prefixed with k3-*
> 
-- 
~Vinod

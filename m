Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34570ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF10820875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMUnCHAM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF10820875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388499AbeGXMUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:20:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:56714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388291AbeGXMUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:20:31 -0400
Received: from localhost (unknown [106.201.120.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0F3320856;
        Tue, 24 Jul 2018 11:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532430873;
        bh=UoNRjaepLolSIybekZpID5ze/gjXbelG46ak/vV14y0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uMUnCHAMXD7k7mgd7OJ1gXs6Lan6ugD2NtJGZD0unZ9YgzjQi1UubtdQHk5xGlfPe
         udEJxW6A7yZTgPg/+ZNuXTcGzMkXMl2hGJE2EFkz5216MoR1DVUqboKowI8MLyDKcK
         hJnyn/9BT2MOfwV26orgUGYlRX9+C2kdWBIZM2CM=
Date:   Tue, 24 Jul 2018 16:44:25 +0530
From:   Vinod <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     radheys@xilinx.com, vinod.koul@intel.com, lars@metafoo.de,
        michal.simek@xilinx.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, dan.j.williams@intel.com,
        appanad@xilinx.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC] dmaengine: Add metadat_ops for dma_async_tx_descriptor
Message-ID: <20180724111425.GK3219@vkoul-mobl>
References: <32208a9c-2b15-d345-1432-f1e387531f9b@ti.com>
 <20180601102429.16429-1-peter.ujfalusi@ti.com>
 <20180710055230.GB3219@vkoul-mobl>
 <052ebdd9-7e68-5b78-52c3-304376f48777@ti.com>
 <20180719092224.GK3219@vkoul-mobl>
 <eb5acd10-e255-774b-e8bc-f88eb2af172a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb5acd10-e255-774b-e8bc-f88eb2af172a@ti.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-18, 16:42, Peter Ujfalusi wrote:
> 
> 
> On 2018-07-19 12:22, Vinod wrote:
> > Hi Peter,
> > 
> > On 18-07-18, 13:06, Peter Ujfalusi wrote:
> > 
> >>>> +struct dma_async_tx_descriptor;
> >>>> +
> >>>> +struct dma_descriptor_metadata_ops {
> >>>> +	int (*attach)(struct dma_async_tx_descriptor *desc, void *data,
> >>>> +		      size_t len);
> >>>
> >>> How does one detach?
> >>
> >> I have not thought about detach, but clients can just attach NULL I guess.
> > 
> > So what are the implication of attach and detach here, should the data
> > be deref by dmaengine driver and drop the ref.
> 
> It largely depends on the DMA driver, but I think we must have clear
> definition on how clients (and thus DMA drivers) must handle the metadata.

Correct, defining these will help out get clarity and avoid abuse.

> I think the simpler rule would be that clients _must_ attach the
> metadata buffer after _prepare() and before issue_pending() and they
> must make sure that the buffer is valid (not freed up) before the
> completion callback is called for the given descriptor.
> 
> About the detach: If clients detaches the metadata buffer then on
> completion it is not going to receive back any metadata and I think the
> DMA drivers should clean and disable the metadata sending as well if the
> detach happens before issue_pending().
> 
> > Should anyone do refcounting?
> 
> Need to think about that.
> 
> >>
> >>> When should the client free up the memory, IOW when
> >>> does dma driver drop ref to data.
> >>
> >> The metadata is for the descriptor so the DMA driver might want to
> >> access to it while the descriptor is valid.
> >>
> >> Typically clients can free up their metadata storage after the dma
> >> completion callback. On DEV_TO_MEM the metadata is going to be placed in
> >> the provided buffer when the transfer is completed.
> > 
> > That sounds okay to me
> > 
> >>>> +	void *(*get_ptr)(struct dma_async_tx_descriptor *desc,
> >>>> +			 size_t *payload_len, size_t *max_len);
> >>>
> >>> so what is this supposed to do..?
> >>
> >> My issue with the attach in general is that it will need additional
> >> memcpy to move the metadata from/to the client buffer to it's place.
> >>
> >> With get_ptr the client can get the pointer to the actual place where
> >> the metadata resides and modify/read it in place w/o memcpy.
> >>
> >> I know, I know... We need to trust the clients, but with high throughput
> >> peripherals the memcpy is taxing.
> > 
> > Okay I am not sure I have understood fully, so with attach you set
> > a pointer (containing metdata?) so why do you need additional one..
> > 
> >>
> >>>
> >>>> +	int (*set_len)(struct dma_async_tx_descriptor *desc,
> >>>> +		       size_t payload_len);
> >>>
> >>> attach already has length, so how does this help?
> >>
> >> So, DMA drivers can implement either or both:
> >> 1. attach()
> >> 2. get_ptr() / set_len()
> > 
> > Ah okay, what are the reasons for providing two methods and not a single
> > one
> 
> For the HW I have it would be more efficient to grab pointer and do
> in-place modification to metadata section (the part of the CPPI5
> descriptor which is owned by the client driver).
> 
> Other vendors might have the metadata scattered, or in different way
> which does not fit with the ptr mode for security or sanity point of
> view - I don't want to give the whole descriptor to the client. I don't
> trust ;)
> 
> >>
> >> Clients must not mix the two way of handling the metadata.
> >> The set_len() is intended to tell the DMA driver the client provided
> >> metadata size (in MEM_TO_DEV case mostly).
> >>
> >> MEM_TO_DEV flow on client side:
> >> get_ptr()
> >> fill in the metadata to the pointer (not exceeding max_len)
> >> set_len() to tell the DMA driver the amount of valid bytes written
> >>
> >> DEV_TO_MEM flow on client side:
> >> In the completion callback, get_ptr()
> >> the metadata is payload_len bytes and can be accessed in the return pointer.
> > 
> > I would think to unify this..
> 
> I have tried it, but the attach mode and the pointer mode is hard to
> handle with a generic API.
> I will try to find a way to unify things in a sane way.

Hmmm, looking from the description they will be for different methods,
so lets make them orthogonal and not allow driver to register both.

> 
> I have moved the metadata_ops to dma_async_tx_descriptor to emphasize
> that it is per descriptor setting:
> https://github.com/omap-audio/linux-audio/commit/02e095d1320a4bb3ae281ddb208ce82ead746f00#diff-92c0a79f414dc3be9dfc67a969c0dd71
> 
> 
> >> BTW: The driver which is going to need this is now accessible in public:
> >> https://git.ti.com/ti-linux-kernel/ti-linux-kernel/trees/ti-linux-4.14.y/drivers/dma/ti
> >>
> >> or in my wip tree:
> >> https://github.com/omap-audio/linux-audio/tree/peter/ti-linux-4.14.y/wip/drivers/dma/ti
> >>
> >> prefixed with k3-*
> >>
> 
> - Péter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

-- 
~Vinod

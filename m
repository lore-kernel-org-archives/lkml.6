Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1658BC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B232082C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AljSZwC9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9B232082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbeH3R2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 13:28:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:50354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728722AbeH3R2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 13:28:21 -0400
Received: from localhost (unknown [171.76.96.227])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2BA72073D;
        Thu, 30 Aug 2018 13:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535635571;
        bh=PBFnDuB2s6mygT2v1CyuXG/TMVBRskhtOf1hm7EP97g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AljSZwC9Itzpm0sKoZeoJXCJCxDEfxAZf9FlD1IoaO+YkUJoX0AIBPa1kCRwDCg0X
         PNAQGzw0AGfjtOYkP7VTW3YyoAirmCm5MPOgqc/uMEJ2KhBOeBvs3Z/t7mYuFiXTzH
         JVQIwemvt0eChCKX/5oqP9h9FTwfb8+BhNwRbEY8=
Date:   Thu, 30 Aug 2018 18:56:02 +0530
From:   Vinod <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, lars@metafoo.de, radheys@xilinx.com
Subject: Re: [PATCH] dmaengine: Add metadata_ops for dma_async_tx_descriptor
Message-ID: <20180830132602.GB2322@vkoul-mobl>
References: <20180823130728.20506-1-peter.ujfalusi@ti.com>
 <20180829155212.GG2388@vkoul-mobl>
 <ae790f49-40f6-8b89-6ec5-c3f3aeb09067@ti.com>
 <20180829162202.GI2388@vkoul-mobl>
 <2575b93d-f236-1c52-1633-ed51e29141b5@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2575b93d-f236-1c52-1633-ed51e29141b5@ti.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Peter,

On 30-08-18, 11:57, Peter Ujfalusi wrote:
> On 2018-08-29 19:22, Vinod wrote:
> >>>> + *   2. use dmaengine_desc_attach_metadata() to attach the buffer to the
> >>>> + *	descriptor
> >>>> + *   3. submit the transfer
> >>>> + * - DMA_DEV_TO_MEM:
> >>>> + *   1. prepare the descriptor (dmaengine_prep_*)
> >>>> + *   2. use dmaengine_desc_attach_metadata() to attach the buffer to the
> >>>> + *	descriptor
> >>>> + *   3. submit the transfer
> >>>> + *   4. when the transfer is completed, the metadata should be available in the
> >>>> + *	attached buffer
> >>>
> >>> I guess this is good to be moved into Documentation
> >>
> >> Should I create a new file for metadata? I guess it would make sense as the
> >> information is for both clients and engines.
> > 
> > Hmm not sure, lets see how it looks as entries in these files, detailing
> > roles of clients and providers
> 
> Update both client and provider documentation with tailoring the content
> for the audience?

Right :)

> >>> also we dont allow this for memcpy txn?
> >>
> >> I have not thought about that, but if I think about it it should be along the
> >> same lines as MEM_TO_DEV.
> >> I'll add the MEM_TO_MEM as well to the documentation.
> > 
> > Okay and lets not implement it then..
> 
> I'm not going to implement it, but the documentation could add that if
> metadata is used for MEM_TO_MEM then it is the same use case as with
> MEM_TO_DEV.

Yes that would be sensible

> >>>> + * @DESC_METADATA_ENGINE - the metadata buffer is allocated/managed by the DMA
> >>>> + *  driver. The client driver can ask for the pointer, maximum size and the
> >>>> + *  currently used size of the metadata and can directly update or read it.
> >>>> + *  dmaengine_desc_get_metadata_ptr() and dmaengine_desc_set_metadata_len() is
> >>>> + *  provided as helper functions.
> >>>> + *
> >>>> + * Client drivers interested to use this mode can follow:
> >>>> + * - DMA_MEM_TO_DEV:
> 
> Here, add DMA_MEM_TO_MEM
> 
> >>>> + *   1. prepare the descriptor (dmaengine_prep_*)
> >>>> + *   2. use dmaengine_desc_get_metadata_ptr() to get the pointer to the engine's
> >>>> + *	metadata area
> >>>> + *   3. update the metadata at the pointer
> >>>> + *   4. use dmaengine_desc_set_metadata_len()  to tell the DMA engine the amount
> >>>> + *	of data the client has placed into the metadata buffer
> >>>> + *   5. submit the transfer
> >>>> + * - DMA_DEV_TO_MEM:
> >>>> + *   1. prepare the descriptor (dmaengine_prep_*)
> >>>> + *   2. submit the transfer
> >>>> + *   3. on transfer completion, use dmaengine_desc_get_metadata_ptr() to get the
> >>>> + *	pointer to the engine's metadata are
> >>>> + *   4. Read out the metadate from the pointer
> >>>> + *
> >>>> + * Note: the two mode is not compatible and clients must use one mode for a
> >>>> + * descriptor.
> >>>> + */
> >>>> +enum dma_desc_metadata_mode {
> >>>> +	DESC_METADATA_CLIENT = (1 << 0),
> >>>> +	DESC_METADATA_ENGINE = (1 << 1),
> >>>
> >>> BIT(x)
> >>
> >> OK, I followed what we have in the header to not mix (1 << x) and BIT(x)
> > 
> > yeah lets update :)
> 
> OK.
> 
> >>>> +static inline int _desc_check_and_set_metadata_mode(
> >>>
> >>> why does this need to start with _ ?
> >>
> >> To scare people to use in client code ;)
> > 
> > Lets not expose to them :D
> 
> Sure, if the code moves to dmaengine.c it is granted.
> 
> >>> Also I would like to see a use :-) before further comments.
> >>
> >> You mean the DMA driver and at least one client?
> > 
> > DMA driver to _at_least_ start with. Client even better
> 
> Hrm, I can send the DMA driver as RFC (not to merge, will not compile)
> but I need to do some excess cover letter and documentation since the
> UDMA is 'just' a piece in the data movement architecture and need to
> explain couple of things around it.
> 
> I will need couple of days for that for sure.

If we are not merging, we can review it. I am not super excited about
merging w/o user of an API

> >> I have the DMA driver in my public facing branch [1], but it is not an easy
> >> read with it's close to 4k loc.
> > 
> > It doesnt exist :P
> 
> In this sense it does not, agree.
> 
> >> The client is not in my branch and it is actually using an older version of
> >> the metadata support.
> >>
> >> The problem is that I don't know when I will be able to send the driver for
> >> review as all of this is targeting a brand new SoC (AM654) with completely new
> >> data movement architecture. There are lots of dependencies still need to be
> >> upstreamed before I can send something which at least compiles.
> >>
> >> I can offer snippets from the client driver, if that is good enough or a link
> >> to the public tree where it can be accessed, but it is not going to go
> >> upstream before the DMA driver.
> > 
> > TBH that's not going to help much, lets come back to it when you need
> > this upstream.
> 
> One of the reason I have sent the metadata support early is because
> Radhey was looking for similar thing for xilinx_dma and I already had
> the generic implementation of it which suits his case.
> 
> I was planning to send the metadata support along with the DMA driver
> (and other core changes, new features).
> 
> If not for me, then for Radhey's stake can the metadata support be
> considered as stand alone for now?
> 
> I will send v2 as soon as I have it ready and I will send either v3 with
> the k3-udma DMA driver (UDMA drivers as not for merge) or standalone
> UDMA driver as RFC and for reference.

Okay, Radhey can take your patch and submit with his changes for merge.

-- 
~Vinod

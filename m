Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6C5C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 04:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2C3208A5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 04:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvbrLAma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B2C3208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbeGaGHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 02:07:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbeGaGHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 02:07:24 -0400
Received: from localhost (unknown [106.200.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C1D8208A3;
        Tue, 31 Jul 2018 04:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533011346;
        bh=s8Lz2etSqfhRf1Ir3gYIpPLraJurKfrRiUr5T6SWFTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DvbrLAmaLabK9nqqBWtw/gbl1127UNmobn1os8mdE+2BTUX906mNbLZx1mJlN554i
         qFh2HoJZWH2kSM5irPSJKsOfwPNnLHznjLZWY+gBW8jztmaGsfNXiZ8FVV0TM80JZc
         rZhYKicsssWTG0ACvy+KJeZR3nGQ1JfchCsNMbl8=
Date:   Tue, 31 Jul 2018 09:59:03 +0530
From:   Vinod <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     radheys@xilinx.com, vinod.koul@intel.com, lars@metafoo.de,
        michal.simek@xilinx.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, dan.j.williams@intel.com,
        appanad@xilinx.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC] dmaengine: Add metadat_ops for dma_async_tx_descriptor
Message-ID: <20180731042903.GC16775@vkoul-mobl>
References: <32208a9c-2b15-d345-1432-f1e387531f9b@ti.com>
 <20180601102429.16429-1-peter.ujfalusi@ti.com>
 <20180710055230.GB3219@vkoul-mobl>
 <052ebdd9-7e68-5b78-52c3-304376f48777@ti.com>
 <20180719092224.GK3219@vkoul-mobl>
 <eb5acd10-e255-774b-e8bc-f88eb2af172a@ti.com>
 <20180724111425.GK3219@vkoul-mobl>
 <e5112c28-a010-827b-c1fd-ecf00036412a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5112c28-a010-827b-c1fd-ecf00036412a@ti.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-07-18, 12:46, Peter Ujfalusi wrote:
> Vinod,
> 
> On 2018-07-24 14:14, Vinod wrote:
> >>>> Clients must not mix the two way of handling the metadata.
> >>>> The set_len() is intended to tell the DMA driver the client provided
> >>>> metadata size (in MEM_TO_DEV case mostly).
> >>>>
> >>>> MEM_TO_DEV flow on client side:
> >>>> get_ptr()
> >>>> fill in the metadata to the pointer (not exceeding max_len)
> >>>> set_len() to tell the DMA driver the amount of valid bytes written
> >>>>
> >>>> DEV_TO_MEM flow on client side:
> >>>> In the completion callback, get_ptr()
> >>>> the metadata is payload_len bytes and can be accessed in the return pointer.
> >>>
> >>> I would think to unify this..
> >>
> >> I have tried it, but the attach mode and the pointer mode is hard to
> >> handle with a generic API.
> >> I will try to find a way to unify things in a sane way.
> > 
> > Hmmm, looking from the description they will be for different methods,
> > so lets make them orthogonal and not allow driver to register both.
> 
> I would allow DMA drivers to register both, but somehow enforce that
> clients are not mixing the two distinct way of dealing with the metadata.
> 
> The reason for that is for example the attach mode is the simplest (I
> implemented it first and I have a client using it), but if the pointer
> mode is found to be more efficient and feasible for the DMA then the DMA
> driver can implement that mode and the client can move as well w/o
> breaking anything.

Sounds reasonable...

-- 
~Vinod

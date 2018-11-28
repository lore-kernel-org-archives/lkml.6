Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43215C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 152CC20832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 152CC20832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbeK2BVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:21:41 -0500
Received: from bmailout2.hostsharing.net ([83.223.90.240]:37219 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbeK2BVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:21:41 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 5467D2800B1D3;
        Wed, 28 Nov 2018 15:19:50 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id F30C3140749; Wed, 28 Nov 2018 15:19:49 +0100 (CET)
Date:   Wed, 28 Nov 2018 15:19:49 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Vivek Gautam <vivek.gautam@codeaurora.org>, airlied@linux.ie,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, tfiga@chromium.org,
        Sean Paul <seanpaul@chromium.org>,
        freedreno@lists.freedesktop.org
Subject: Re: [PATCH v2 1/1] drm: msm: Replace dma_map_sg with dma_sync_sg*
Message-ID: <20181128141949.6mww6g2ze3qkzxhj@wunner.de>
References: <20181126213710.3084-1-vivek.gautam@codeaurora.org>
 <20181128073940.GA13072@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128073940.GA13072@infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 11:39:40PM -0800, Christoph Hellwig wrote:
> > +		/*
> > +		 * dma_sync_sg_*() flush the physical pages, so point
> > +		 * sg->dma_address to the physical ones for the right behavior.
> > +		 */
> > +		for_each_sg(msm_obj->sgt->sgl, s, msm_obj->sgt->nents, i)
> > +			sg_dma_address(s) = sg_phys(s);
> > +
> 
> I'm sorry, but this is completely bogus and not acceptable.
> 
> The only place that is allowed to initialize sg_dma_address is
> dma_map_sg.  If the default dma ops don't work for your setup we have
> major a problem and need to fix the dma api / iommu integration instead
> of hacking around it.

Somewhat related, I recently submitted a patch for the spi-bcm2835.c
driver to overcome a limitation of the DMA engine and the spi0 master
on the Raspberry Pi:

http://lists.infradead.org/pipermail/linux-rpi-kernel/2018-November/008275.html

If a buffer needs to be sent or received which was vmalloc'ed (hence is
not contiguous in physical memory) and starts in the middle of a page
with an offset not a multiple of 4, the buffer could not be transmitted
with DMA so far because the spi0 master requires 4 byte writes to the
FIFO and the DMA engine is incapable of combining multiple sglist
entries of arbitrary length into a continuous stream of 4 byte chunks.

The solution I've found is to transfer the first few bytes of the first
sglist entry with programmed I/O such that the remainder has a length
which is a multiple of 4.  For this to work, I have to massage the first
sglist entry, i.e. I have to add the number of bytes transmitted with
PIO to the DMA address and subtract it from the sglist entry's length.
After the DMA engine has done its job, I undo those changes to the
sglist.

Could you comment on the acceptibility of this approach?  If you do not
deem it acceptable, could you make a suggestion how the dma-mapping API
shall be amended to support such use cases?

(I sure hope the approach *is* acceptable, getting this to work at all
required endless fiddling.  The BCM2835 is in some ways a not so great
SoC and could do with better documentation, to put it mildly.)

(Note: I've since amended the above-linked patch to sync only the modified
cachelines back to memory, not the full first sglist entry.  I've also
switched to the sg_dma_address() and sg_dma_len() syntax instead of
referencing the sglist entry members directly, this appears to be more
common in the tree even for l-values.  I was going to post these changes
as v2 shortly.)

Thanks,

Lukas

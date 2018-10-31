Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1011C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44B9420821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44B9420821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbeKABa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 21:30:28 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:43146 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeKABa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 21:30:27 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23991025AbeJaQbkPiy6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 17:31:40 +0100
Date:   Wed, 31 Oct 2018 16:31:40 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Christoph Hellwig <hch@lst.de>
cc:     iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] dma-mapping: merge direct and noncoherent ops
In-Reply-To: <alpine.LFD.2.21.1810311414200.20378@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.21.1810311559590.20378@eddie.linux-mips.org>
References: <20180914095808.22202-1-hch@lst.de> <20180914095808.22202-5-hch@lst.de> <alpine.LFD.2.21.1810311414200.20378@eddie.linux-mips.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2018, Maciej W. Rozycki wrote:

> > All the cache maintainance is already stubbed out when not enabled,
> > but merging the two allows us to nicely handle the case where
> > cache maintainance is required for some devices, but not others.
> 
>  FYI, you commit bc3ec75de545 ("dma-mapping: merge direct and noncoherent 
> ops") has caused:
> 
> fddi0: DMA command request failed!
> fddi0: Adapter open failed!
> 
> with the `defxx' driver on my R4400SC TURBOchannel DECstation (but not the 
> R3400 one) and consequently the interface does not work anymore.  Both are 
> non-coherent cache systems, however the R3400 implements the write-through 
> policy while the policy of the R4400SC is write-back (it also has 1MiB of 
> secondary cache), which I suspect is the reason of the difference.

 Doh!  It would have helped if I actually had the right adapter installed 
in the R3400 box.  I've got a spare one, which I have now plugged in there 
and the R3400 actually shows the same issue as the R4400SC does.  So this 
has nothing to do WRT write-through vs write-back.

 Hmm, in `dfx_hw_dma_cmd_req' the driver polls the consumer block (which 
is write-only by the adapter and read-only by the host, except for the 
initialisation time before adapter's DMA engines have been started, and 
write-through vs write-back indeed does not matter for this kind of use) 
and there's no DMA synchronisation whatsoever in that.

 However the block has been allocated with `dma_zalloc_coherent', which 
means no synchronisation is supposed to be required.  For non-coherent 
cache systems that essentially means an uncached memory allocation.

  Maciej

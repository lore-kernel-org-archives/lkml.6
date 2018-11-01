Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2298BC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 08:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81CC204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 08:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81CC204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbeKARfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 13:35:47 -0400
Received: from verein.lst.de ([213.95.11.211]:43098 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727704AbeKARfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 13:35:47 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 196CC7F1C0; Thu,  1 Nov 2018 09:33:46 +0100 (CET)
Date:   Thu, 1 Nov 2018 09:33:46 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Christoph Hellwig <hch@lst.de>, Paul Burton <paul.burton@mips.com>,
        iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: Fix `dma_alloc_coherent' returning a
 non-coherent allocation
Message-ID: <20181101083346.GA7136@lst.de>
References: <20180914095808.22202-1-hch@lst.de> <20180914095808.22202-5-hch@lst.de> <alpine.LFD.2.21.1810311414200.20378@eddie.linux-mips.org> <alpine.LFD.2.21.1810311559590.20378@eddie.linux-mips.org> <20181031203206.GA28337@lst.de> <alpine.LFD.2.21.1810312043250.20378@eddie.linux-mips.org> <20181101051359.GA4164@lst.de> <alpine.LFD.2.21.1811010523440.20378@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1811010523440.20378@eddie.linux-mips.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 07:54:24AM +0000, Maciej W. Rozycki wrote:
> Fix a MIPS `dma_alloc_coherent' regression from commit bc3ec75de545 
> ("dma-mapping: merge direct and noncoherent ops") that causes a cached 
> allocation to be returned on noncoherent cache systems.
> 
> This is due to an inverted check now used in the MIPS implementation of 
> `arch_dma_alloc' on the result from `dma_direct_alloc_pages' before 
> doing the cached-to-uncached mapping of the allocation address obtained.  
> The mapping has to be done for a non-NULL rather than NULL result, 
> because a NULL result means the allocation has failed.
> 
> Invert the check for correct operation then.
> 
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> Fixes: bc3ec75de545 ("dma-mapping: merge direct and noncoherent ops")
> Cc: stable@vger.kernel.org # 4.19+

Oops, yes this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

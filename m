Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A63C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F2DC214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:57:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F2DC214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732083AbeKVDcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 22:32:53 -0500
Received: from foss.arm.com ([217.140.101.70]:55122 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730417AbeKVDcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 22:32:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B57022F8;
        Wed, 21 Nov 2018 08:57:40 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EEFC03F5AF;
        Wed, 21 Nov 2018 08:57:39 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id B29241AE100A; Wed, 21 Nov 2018 16:57:55 +0000 (GMT)
Date:   Wed, 21 Nov 2018 16:57:55 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     John Garry <john.garry@huawei.com>
Cc:     joro@8bytes.org, robin.murphy@arm.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        ganapatrao.kulkarni@cavium.com, hch@lst.de,
        m.szyprowski@samsung.com, linuxarm@huawei.com
Subject: Re: [PATCH v3] iommu/dma: Use NUMA aware memory allocations in
 __iommu_dma_alloc_pages()
Message-ID: <20181121165755.GE24883@arm.com>
References: <1542812051-178935-1-git-send-email-john.garry@huawei.com>
 <20181121160718.GB24883@arm.com>
 <24be0d21-63b1-c88d-fdfd-42575f12634f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24be0d21-63b1-c88d-fdfd-42575f12634f@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 04:47:48PM +0000, John Garry wrote:
> On 21/11/2018 16:07, Will Deacon wrote:
> >On Wed, Nov 21, 2018 at 10:54:10PM +0800, John Garry wrote:
> >>From: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> >>
> >>Change function __iommu_dma_alloc_pages() to allocate pages for DMA from
> >>respective device NUMA node. The ternary operator which would be for
> >>alloc_pages_node() is tidied along with this.
> >>
> >>We also include a change to use kvzalloc() for kzalloc()/vzalloc()
> >>combination.
> >>
> >>Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> >>[JPG: Added kvzalloc(), drop pages ** being device local, tidied ternary operator]
> >>Signed-off-by: John Garry <john.garry@huawei.com>
> >
> >Weird, you're missing a diffstat here.
> >
> >Anyway, the patch looks fine to me, but it would be nice if you could
> >justify the change with some numbers. Do you actually see an improvement
> >from this change?
> >
> 
> Hi Will,
> 
> Ah, I missed adding my comments explaining the motivation. It would be
> better in the commit log. Anyway, here's the snippet:
> 
> " ... as mentioned in [3], dma_alloc_coherent() uses the locality
> information from the device - as in direct DMA - so this patch is just
> applying this same policy.
> 
> [3]
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1692998.html"

Yes, please add to this to the commit log.

> I did have some numbers to show improvement in some scenarios when I tested
> this a while back which I'll dig out.
> 
> However I would say that some scenarios will improve and the opposite for
> others with this change, considering different conditions in which DMA
> memory may be used.

Well, if you can show that it's useful in some cases and not catastrophic in
others, then I think shooting for parity with direct DMA is a reasonable
justification for the change.

Will

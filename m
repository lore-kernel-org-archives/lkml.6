Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FF3C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6F3A20834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:31:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6F3A20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbeLDObI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:31:08 -0500
Received: from verein.lst.de ([213.95.11.211]:44103 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbeLDObI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:31:08 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 601B568BF4; Tue,  4 Dec 2018 15:31:06 +0100 (CET)
Date:   Tue, 4 Dec 2018 15:31:06 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     hch@lst.de, m.szyprowski@samsung.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        cai@gmx.us, salil.mehta@huawei.com, john.garry@huawei.com
Subject: Re: [RFC 4/4] dma-debug: Make leak-like behaviour apparent
Message-ID: <20181204143106.GD2767@lst.de>
References: <cover.1543856576.git.robin.murphy@arm.com> <7ec928f0bd92122f271c421e99aaeb593ccabdf5.1543856576.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ec928f0bd92122f271c421e99aaeb593ccabdf5.1543856576.git.robin.murphy@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 05:28:09PM +0000, Robin Murphy wrote:
> Now that we can dynamically allocate DMA debug entries to cope with
> drivers maintaining excessively large numbers of live mappings, a driver
> which *does* actually have a bug leaking mappings (and is not unloaded)
> will no longer trigger the "DMA-API: debugging out of memory - disabling"
> message until it gets to actual kernel OOM conditions, which means it
> could go unnoticed for a while. To that end, let's inform the user each
> time the pool has grown to a multiple of its initial size, which should
> make it apparent that they either have a leak or might want to increase
> the preallocation size.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> Tagging this one as RFC since people might think it's silly.

I think finding out the numbers is useful, but I'm a little worried
about claiming a possible leak.  Maybe we just need to print a log message
for each new power of 2 of entries reached?

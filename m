Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87166C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51BE4206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:29:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51BE4206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbeLDO3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:29:41 -0500
Received: from verein.lst.de ([213.95.11.211]:44078 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726306AbeLDO3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:29:40 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 1038A68BF4; Tue,  4 Dec 2018 15:29:39 +0100 (CET)
Date:   Tue, 4 Dec 2018 15:29:38 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     hch@lst.de, m.szyprowski@samsung.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        cai@gmx.us, salil.mehta@huawei.com, john.garry@huawei.com
Subject: Re: [PATCH 3/4] dma-debug: Dynamically expand the dma_debug_entry
 pool
Message-ID: <20181204142938.GC2767@lst.de>
References: <cover.1543856576.git.robin.murphy@arm.com> <f99ea022be92a99339404867bc925f4fbd2ee6c4.1543856576.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f99ea022be92a99339404867bc925f4fbd2ee6c4.1543856576.git.robin.murphy@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	for (retry_count = 0; ; retry_count++) {
> +		spin_lock_irqsave(&free_entries_lock, flags);
> +
> +		if (num_free_entries > 0)
> +			break;
>  
>  		spin_unlock_irqrestore(&free_entries_lock, flags);

Taking a spinlock just to read a single integer value doesn't really
help anything.

> +
> +		if (retry_count < DMA_DEBUG_DYNAMIC_RETRIES &&
> +		    !prealloc_memory(DMA_DEBUG_DYNAMIC_ENTRIES))

Don't we need GFP_ATOMIC here?  Also why do we need the retries?

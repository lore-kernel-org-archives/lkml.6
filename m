Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95128C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D60520878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:23:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D60520878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbeLFOX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:23:28 -0500
Received: from verein.lst.de ([213.95.11.211]:57355 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727704AbeLFOX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:23:28 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 3805B68AA6; Thu,  6 Dec 2018 15:23:26 +0100 (CET)
Date:   Thu, 6 Dec 2018 15:23:26 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     hch@lst.de, m.szyprowski@samsung.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        cai@gmx.us, salil.mehta@huawei.com, john.garry@huawei.com
Subject: Re: [PATCH v2 3/8] dma-debug: Refactor dma_debug_entry allocation
Message-ID: <20181206142326.GA24642@lst.de>
References: <cover.1544037783.git.robin.murphy@arm.com> <d868e775492e417f446d6d162f5f792bd41ee7bc.1544037783.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d868e775492e417f446d6d162f5f792bd41ee7bc.1544037783.git.robin.murphy@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int dma_debug_add_entries(u32 num_entries, gfp_t gfp)
> +{
> +	struct dma_debug_entry *entry, *next_entry;
> +	LIST_HEAD(tmp);
> +	int i;
> +
> +	for (i = 0; i < num_entries; ++i) {
> +		entry = kzalloc(sizeof(*entry), gfp);
> +		if (!entry)
> +			goto out_err;
> +
> +		list_add_tail(&entry->list, &tmp);
> +	}
> +
> +	list_splice(&tmp, &free_entries);
> +	num_free_entries += num_entries;
> +	nr_total_entries += num_entries;

The adding to a local list and splicing seems a bit pointless if we
do it all under lock anyway.  Either we change the locking in
dma_debug_resize_entries and your upcoming automatic allocation that
we only do it over the splice and counter adjustment, which would
have the advantage of allowing freeing of entries in parallel to these
allocations, or we could just drop the local tmp list.

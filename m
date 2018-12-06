Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9228BC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65F5720838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F5720838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbeLFSKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:10:51 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57644 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbeLFSKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:10:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FEAD80D;
        Thu,  6 Dec 2018 10:10:50 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A4933F5AF;
        Thu,  6 Dec 2018 10:10:49 -0800 (PST)
Subject: Re: [PATCH v2 3/8] dma-debug: Refactor dma_debug_entry allocation
To:     Christoph Hellwig <hch@lst.de>
Cc:     m.szyprowski@samsung.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, cai@gmx.us, salil.mehta@huawei.com,
        john.garry@huawei.com
References: <cover.1544037783.git.robin.murphy@arm.com>
 <d868e775492e417f446d6d162f5f792bd41ee7bc.1544037783.git.robin.murphy@arm.com>
 <20181206142326.GA24642@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <9accc5fe-4aae-ff7d-a234-f27167c49614@arm.com>
Date:   Thu, 6 Dec 2018 18:10:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181206142326.GA24642@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2018 14:23, Christoph Hellwig wrote:
>> +static int dma_debug_add_entries(u32 num_entries, gfp_t gfp)
>> +{
>> +	struct dma_debug_entry *entry, *next_entry;
>> +	LIST_HEAD(tmp);
>> +	int i;
>> +
>> +	for (i = 0; i < num_entries; ++i) {
>> +		entry = kzalloc(sizeof(*entry), gfp);
>> +		if (!entry)
>> +			goto out_err;
>> +
>> +		list_add_tail(&entry->list, &tmp);
>> +	}
>> +
>> +	list_splice(&tmp, &free_entries);
>> +	num_free_entries += num_entries;
>> +	nr_total_entries += num_entries;
> 
> The adding to a local list and splicing seems a bit pointless if we
> do it all under lock anyway.  Either we change the locking in
> dma_debug_resize_entries and your upcoming automatic allocation that
> we only do it over the splice and counter adjustment, which would
> have the advantage of allowing freeing of entries in parallel to these
> allocations, or we could just drop the local tmp list.

AFAICS the tmp list wasn't about locking as much as meaning that if 
kzalloc() failed at any point, we can free the partial allocation and 
back out without disturbing free_entries at all - that still makes sense 
to me up until patch #8 where we embrace the "never free anything" 
paradigm and rip out the final traces.

That said, maybe I should just drop the refactoring of 
dma_debug_resize_entries() now that I'm deleting it as part of the same 
series anyway - then I guess I squash what's left of this patch into #4 
and bring forward some of the simplification from #8 to start with. 
Would that be more agreeable?

Robin.

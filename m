Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818B8C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 429C12081B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:06:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 429C12081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbeLDQGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:06:47 -0500
Received: from foss.arm.com ([217.140.101.70]:35922 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbeLDQGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:06:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C7D6A78;
        Tue,  4 Dec 2018 08:06:46 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 671973F614;
        Tue,  4 Dec 2018 08:06:45 -0800 (PST)
Subject: Re: [PATCH 3/4] dma-debug: Dynamically expand the dma_debug_entry
 pool
To:     Christoph Hellwig <hch@lst.de>
Cc:     John Garry <john.garry@huawei.com>, m.szyprowski@samsung.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        cai@gmx.us, salil.mehta@huawei.com
References: <cover.1543856576.git.robin.murphy@arm.com>
 <f99ea022be92a99339404867bc925f4fbd2ee6c4.1543856576.git.robin.murphy@arm.com>
 <a45fce07-3663-2a55-5b97-336002f21cdb@huawei.com>
 <70336fdc-abe8-2cea-8d8c-170b4863d884@arm.com> <20181204141743.GA2618@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <6e8ca917-32a7-5c0a-60c0-a266c3fbb163@arm.com>
Date:   Tue, 4 Dec 2018 16:06:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181204141743.GA2618@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2018 14:17, Christoph Hellwig wrote:
> On Tue, Dec 04, 2018 at 01:11:37PM +0000, Robin Murphy wrote:
>> In fact, having got this far in, what I'd quite like to do is to get rid of
>> dma_debug_resize_entries() such that we never need to free things at all,
>> since then we could allocate whole pages as blocks of entries to save on
>> masses of individual slab allocations.
> 
> Yes, we should defintively kill dma_debug_resize_entries.  Allocating
> page batches might sound nice, but is that going to introduce additional
> complexity?

OK, looking at what the weird AMD GART code does I reckon it should be 
happy enough with on-demand expansion, and that no tears will be shed if 
it can no longer actually trim the pool to the size it thinks is 
necessary. I'll add a patch to clean that up.

Page-based allocation, at least the way I'm thinking of it, shouldn't do 
much more than add an extra loop in one place, which should be more than 
made up for by removing all the freeing code :)

Robin.

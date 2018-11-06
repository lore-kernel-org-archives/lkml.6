Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25A3C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7032E2086B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:39:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7032E2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388896AbeKGAE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:04:59 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34836 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388659AbeKGAE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:04:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 829B680D;
        Tue,  6 Nov 2018 06:39:28 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 961FF3F5BD;
        Tue,  6 Nov 2018 06:39:27 -0800 (PST)
Subject: Re: [PATCH] iommu/dma: Zero pages manually in a length of scatterlist
To:     Christoph Hellwig <hch@infradead.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20181101213500.21800-1-nicoleotsuka@gmail.com>
 <63184c22-4587-be2b-8089-d2e4e0b5482d@arm.com>
 <20181102233613.GA26856@Asurada-Nvidia.nvidia.com>
 <20181105145847.GA31337@infradead.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <afdc0e33-db18-6ad9-61cd-919fe3df1b4e@arm.com>
Date:   Tue, 6 Nov 2018 14:39:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181105145847.GA31337@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/2018 14:58, Christoph Hellwig wrote:
> On Fri, Nov 02, 2018 at 04:36:13PM -0700, Nicolin Chen wrote:
>>> What if the pages came from highmem? I know that doesn't happen on arm64
>>> today, but the point of this code *is* to be generic, and other users will
>>> arrive eventually.
>>
>> Hmm, so it probably should use sg_miter_start/stop() too? Looking
>> at the flush routine doing in PAGE_SIZE for each iteration, would
>> be possible to map and memset contiguous pages together? Actually
>> the flush routine might be also optimized if we can map contiguous
>> pages.
> 
> FYI, I have patches I plan to submit soon that gets rid of the
> struct scatterlist use in this code to simplify it:

...and I have some significant objections to that simplification which I 
plan to respond with ;)

(namely that it defaults the whole higher-order page allocation business 
which will have varying degrees of performance impact on certain cases)

Robin.

Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A8BC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF942146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:04:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DF942146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbeK3XNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 18:13:54 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55270 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbeK3XNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 18:13:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF74E80D;
        Fri, 30 Nov 2018 04:04:49 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 973903F5A0;
        Fri, 30 Nov 2018 04:04:48 -0800 (PST)
Subject: Re: [PATCH] dma-debug: hns_enet_drv could use more DMA entries
To:     Christoph Hellwig <hch@lst.de>, Qian Cai <cai@gmx.us>
Cc:     m.szyprowski@samsung.com, yisen.zhuang@huawei.com,
        salil.mehta@huawei.com, iommu@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181130035456.1586-1-cai@gmx.us> <20181130084203.GA19812@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <19e7ac15-a1dc-33ee-d4be-f3433625e836@arm.com>
Date:   Fri, 30 Nov 2018 12:04:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181130084203.GA19812@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2018 08:42, Christoph Hellwig wrote:
> On Thu, Nov 29, 2018 at 10:54:56PM -0500, Qian Cai wrote:
>>   /* allow architectures to override this if absolutely required */
>>   #ifndef PREALLOC_DMA_DEBUG_ENTRIES
>> +/* amount of DMA mappings on this driver is huge. */
>> +#ifdef	HNS_ENET
>> +#define PREALLOC_DMA_DEBUG_ENTRIES (1 << 17)
>> +#else
>>   #define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
>>   #endif
>> +#endif
> 
> How would this be defined in a header that leaks into this file?

Apparently it wouldn't, because nothing defines that macro anywhere 
anyway. CONFIG_HNS_ENET, on the other hand, would be available by virtue 
of autoconf.h which is just about everywhere.

> I think we need to turn PREALLOC_DMA_DEBUG_ENTRIES into a user
> selectable config options, as I really don't want to collect hacks like
> this.

Agreed - we already have per-arch overrides scattered about, so growing 
special cases in yet another place just makes even more of a mess. 
Rounding all of it up into Kconfig would definitely make sense.

Robin.

Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33847C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E345A216FA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:35:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E345A216FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbeI0VyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 17:54:13 -0400
Received: from foss.arm.com ([217.140.101.70]:36384 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727335AbeI0VyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 17:54:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F35D7A9;
        Thu, 27 Sep 2018 08:35:24 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.Emea.Arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 365443F5B3;
        Thu, 27 Sep 2018 08:35:23 -0700 (PDT)
Subject: Re: [PATCH 2/5] dma-direct: add an explicit
 dma_direct_get_required_mask
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20180920185247.20037-1-hch@lst.de>
 <20180920185247.20037-3-hch@lst.de>
 <02ce2ecc-281d-7b7f-6d30-8d246acd1eaa@arm.com>
 <20180927152818.GC10566@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <d9ce1c62-9e89-dc73-68e8-4e3025b5725f@arm.com>
Date:   Thu, 27 Sep 2018 16:35:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180927152818.GC10566@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/18 16:28, Christoph Hellwig wrote:
> On Thu, Sep 27, 2018 at 03:12:25PM +0100, Robin Murphy wrote:
>>> +u64 dma_direct_get_required_mask(struct device *dev)
>>> +{
>>> +	u64 max_dma = phys_to_dma_direct(dev, (max_pfn - 1) << PAGE_SHIFT);
>>> +
>>> +	return (1ULL << (fls64(max_dma) - 1)) * 2 - 1;
>>
>> I think that may as well just use __fls64() - it seems reasonable to assume
>> max_dma > 0. Otherwise,
> 
> Is there any good reason to micro-optimize given that this isn't
> a fast path?

Not at all, I wasn't even thinking in terms of optimisation other than 
in terms of number of source characters and levels of parentheses.

But more importantly I was also being a big idiot because no matter how 
much I have the fls()/__fls() thing in mind, __fls64() doesn't actually 
exist. Nitpick rescinded!

Robin.

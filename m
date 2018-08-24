Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927E4C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D02621529
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D02621529
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbeHXS76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 14:59:58 -0400
Received: from foss.arm.com ([217.140.101.70]:60580 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbeHXS76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 14:59:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2A4CED1;
        Fri, 24 Aug 2018 08:24:51 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.emea.arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 271783F5BC;
        Fri, 24 Aug 2018 08:24:51 -0700 (PDT)
Subject: Re: [PATCH] Changing the AMD IOMMU API path to work in an atomic
 context which is necessary for any custom drivers using the IOMMU API while
 holding a spinlock.
To:     Christoph Hellwig <hch@infradead.org>, murphyt7@tcd.ie
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <1535120929-5693-1-git-send-email-murphyt7@tcd.ie>
 <20180824145328.GA7996@infradead.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <24d3f04a-e6e2-ed8f-e2bd-b38144f33f26@arm.com>
Date:   Fri, 24 Aug 2018 16:24:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180824145328.GA7996@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/18 15:53, Christoph Hellwig wrote:
> On Fri, Aug 24, 2018 at 02:28:49PM +0000, murphyt7@tcd.ie wrote:
>> From: Tom Murphy <murphyt7@tcd.ie>
>>
>> ---
>>
>> This patch allows the IOMMU API path in the AMD driver to be called from an atomic context.
>> This is useful for anyone building a driver which needs to call the IOMMU API while holding a spinlock.
> 
> I don't think that is a good idea.  Please point to the code in the
> driver and we can't probably find a better solution.

Although IIRC the AMD driver is in fact the only one whose map/unmap 
callbacks aren't already spinlock-safe (or at least it was last time I 
was looking). Stuff like iommu-dma is already relying on this in order 
to implement streaming DMA API calls (which may be in atomic context) on 
top of the corresponding IOMMU API operations.

Robin.

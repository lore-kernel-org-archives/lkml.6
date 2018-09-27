Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F9DC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64530216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:41:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64530216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbeI0XAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:00:46 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37498 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727480AbeI0XAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:00:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEE3518A;
        Thu, 27 Sep 2018 09:41:39 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.Emea.Arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93DF03F5B3;
        Thu, 27 Sep 2018 09:41:38 -0700 (PDT)
Subject: Re: [PATCH 4/5] dma-direct: implement complete bus_dma_mask handling
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20180920185247.20037-1-hch@lst.de>
 <20180920185247.20037-5-hch@lst.de>
 <a7626d1b-4dd8-abc4-0ab0-21ab7e5d1a4c@arm.com>
 <20180927153252.GE10566@lst.de>
 <967e98b1-99ab-8f95-4c89-6156ce489b93@arm.com>
 <20180927162737.GA11974@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <b87ef7ac-81fc-c649-7ffb-73017ec99790@arm.com>
Date:   Thu, 27 Sep 2018 17:41:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180927162737.GA11974@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/18 17:27, Christoph Hellwig wrote:
> On Thu, Sep 27, 2018 at 05:14:56PM +0100, Robin Murphy wrote:
>>> This just seemed more readable to me than min_not_zero, but if others
>>> prefer min_not_zero I can switch.
>>
>> Nah, just checking whether there were any intentionally different
>> assumptions compared to the couple of other places in the patch where
>> min_not_zero() *is* used. If it's purely a style thing then no worries
>> (personally I'd have written it yet another way anyway).
> 
> I'm curious: how would you have written it?

Come to think of it, I actually already have, in iommu-dma:

	if (dev->bus_dma_mask)
		mask &= dev->bus_dma_mask;

but of course it's not so pretty for those cases where you don't already 
have the local variable ready to go.

Robin.

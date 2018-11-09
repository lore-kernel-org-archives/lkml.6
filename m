Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E069C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A7920818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A7920818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbeKJCTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:19:17 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34374 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727955AbeKJCTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 21:19:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D92DA78;
        Fri,  9 Nov 2018 08:37:57 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3EF53F5BD;
        Fri,  9 Nov 2018 08:37:55 -0800 (PST)
Subject: Re: [PATCH 06/10] swiotlb: use swiotlb_map_page in
 swiotlb_map_sg_attrs
To:     Christoph Hellwig <hch@lst.de>,
        John Stultz <john.stultz@linaro.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        konrad.wilk@oracle.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
References: <20181008080246.20543-1-hch@lst.de>
 <20181008080246.20543-7-hch@lst.de>
 <CANcMJZAzrxA9LGNvP-epv2DwsUacEM_hcgA1n5gmaPuWRJG4iw@mail.gmail.com>
 <20181109074955.GA27489@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <9922f377-ee87-ba36-8d28-26af0f7822e5@arm.com>
Date:   Fri, 9 Nov 2018 16:37:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181109074955.GA27489@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2018 07:49, Christoph Hellwig wrote:
> On Tue, Nov 06, 2018 at 05:27:14PM -0800, John Stultz wrote:
>> But at that point if I just re-apply "swiotlb: use swiotlb_map_page in
>> swiotlb_map_sg_attrs", I reproduce the hangs.
>>
>> Any suggestions for how to further debug what might be going wrong
>> would be appreciated!
> 
> Very odd.  In the end map_sg and map_page are defined to do the same
> things to start with.  The only real issue we had in this area was:
> 
> "[PATCH v2] of/device: Really only set bus DMA mask when appropriate"
> 
> so with current mainline + that you still see a problem, and if you
> rever the commit we are replying to it still goes away?

OK, after quite a bit of trying I have managed to provoke a 
similar-looking problem with straight 4.20-rc1 on my Juno board - so far 
my "reproducer" is to decompress a ~10GB .tar.xz off an external USB 
hard disk, wherein after somewhere between 5 minutes and half an hour or 
so it tends to falls over with xz choking on corrupt data and/or a USB 
error.

 From the presentation, this really smells like there's some corner in 
which we're either missing cache maintenance or doing it to the wrong 
address - I've not seen any issues with Juno's main PCIe-attached I/O, 
but the EHCI here is non-coherent (and 32-bit, so the bus_dma_mask thing 
doesn't matter) as are the HiKey UFS and SD controller.

I'll keep digging...

Robin.

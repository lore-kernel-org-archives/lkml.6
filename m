Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A679C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF64206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF64206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbeIJSUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:20:38 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57490 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727970AbeIJSUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:20:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88D5C80D;
        Mon, 10 Sep 2018 06:26:32 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.emea.arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BEB683F557;
        Mon, 10 Sep 2018 06:26:31 -0700 (PDT)
Subject: Re: 4.19-rc3: IOMMU PT warnings: WARNING: CPU: 0 PID: 1 at
 mm/page_alloc.c:4065 __alloc_pages_slowpath+0xb7b/0xcd0
To:     Christoph Hellwig <hch@lst.de>, Meelis Roos <mroos@linux.ee>
Cc:     iommu@lists.linux-foundation.org,
        Linux Kernel list <linux-kernel@vger.kernel.org>
References: <alpine.LRH.2.21.1809101111040.31938@math.ut.ee>
 <20180910132304.GA20244@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <e3f0e78a-3e3d-aae7-2588-599184dee534@arm.com>
Date:   Mon, 10 Sep 2018 14:26:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180910132304.GA20244@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/18 14:23, Christoph Hellwig wrote:
> On Mon, Sep 10, 2018 at 11:16:12AM +0300, Meelis Roos wrote:
>> In 4.19-rc1, I found that to keep Intel integrated graphics working when
>> VT-d is on, I need to have IOMMU passthough on or GPU init would fail
>> with DMAR error and the screen would display static gibberish. So I
>> turned IOMMU PT on by default in kernel config. It worked, also in rc2.
>>
>> Now with rc3, it still works but I get some warning splats in dmesg
>> about IOMMU passthrough:
> 
> Any chance you could bisect this down to a specific commit?  For
> a start it might be worth if it is reproducable with:
> 
>     git://git.infradead.org/users/hch/dma-mapping.git dma-mapping-4.19-2
> 
> which were the only dma-mapping changes post -rc2.

Given the __alloc_pages_slowpath() warning, this looks like it's 
probably stemming from the oversized PASID table issue which a few other 
folks have hit too. I think this patch is the most up-to-date fix:

https://www.mail-archive.com/iommu@lists.linux-foundation.org/msg25639.html

Robin.

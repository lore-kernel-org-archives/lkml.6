Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D12C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA822175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731076AbfBFPIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 10:08:30 -0500
Received: from foss.arm.com ([217.140.101.70]:54170 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730230AbfBFPI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 10:08:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D29280D;
        Wed,  6 Feb 2019 07:08:29 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04B8A3F675;
        Wed,  6 Feb 2019 07:08:27 -0800 (PST)
Subject: Re: [PATCH 02/19] dma-iommu: cleanup dma-iommu.h
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190114094159.27326-1-hch@lst.de>
 <20190114094159.27326-3-hch@lst.de>
 <3f78b779-4360-1204-e942-39a8a81759c7@arm.com> <20190201161305.GI6532@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <5bf081c2-2b8c-d3d1-c93e-468c8f3cef67@arm.com>
Date:   Wed, 6 Feb 2019 15:08:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190201161305.GI6532@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/2019 16:13, Christoph Hellwig wrote:
> On Fri, Feb 01, 2019 at 02:47:17PM +0000, Robin Murphy wrote:
>> On 14/01/2019 09:41, Christoph Hellwig wrote:
>>> No need for a __KERNEL__ guard outside uapi, make sure we pull in the
>>> includes unconditionally so users can rely on it, and add a missing
>>> comment describing the #else cpp statement.  Last but not least include
>>> <linux/errno.h> instead of the asm version, which is frowned upon.
>>
>> I think the __KERNEL__ and asm/errno.h slip-ups are things I cargo-culted
>> from the arch code as a fresh-faced noob yet to learn the finer details, so
>> ack for those parts. The forward-declarations, though, were a deliberate
>> effort to minimise header dependencies and compilation bloat for includers
>> who absolutely wouldn't care, and specifically to try to avoid setting
>> transitive include expectations since they always seem to end up breaking
>> someone's config somewhere down the line. Admittedly this little backwater
>> is hardly comparable to the likes of the sched.h business, but I'm still
>> somewhat on the fence about that change :/
> 
> As far as I can tell almost all users of linux/dma-iommu.h require
> CONFIG_DMA_IOMMU to be enabled anyway..

Other than dma-iommu.c itself, none of them *require* it - only 
arch/arm64 selects it (the one from MTK_IOMMU is just bogus), and a lot 
of the drivers also build for at least one other architecture (and/or 
arm64 with !IOMMU_API).

Either way, I have no vehement objection to the change, I just don't see 
any positive value in it.

Robin.

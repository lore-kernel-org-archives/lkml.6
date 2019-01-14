Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877D3C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62286206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfANQiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:38:24 -0500
Received: from foss.arm.com ([217.140.101.70]:37148 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbfANQiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:38:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BEEEA78;
        Mon, 14 Jan 2019 08:38:23 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0FCD3F5BD;
        Mon, 14 Jan 2019 08:38:21 -0800 (PST)
Subject: Re: [PATCH] Revert "ARM: dma-mapping: Set proper DMA ops in
 arm_iommu_detach_device()"
To:     Thierry Reding <treding@nvidia.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Ben Skeggs <bskeggs@redhat.com>,
        Tobias Jakobi <tjakobi@math.uni-bielefeld.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <CGME20190114132250eucas1p2abdf2f36bad3554e37dfbf40e539f594@eucas1p2.samsung.com>
 <20190114132240.12125-1-m.szyprowski@samsung.com>
 <20190114160902.GB9218@ulmo>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <4f7fd8db-33e4-9c8d-2fee-1ca9c98a9276@arm.com>
Date:   Mon, 14 Jan 2019 16:38:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190114160902.GB9218@ulmo>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/01/2019 16:09, Thierry Reding wrote:
> On Mon, Jan 14, 2019 at 02:22:40PM +0100, Marek Szyprowski wrote:
>> This reverts commit 1874619a7df4b14b23b14877e705ae15325773e3.
>>
>> That patch broke IOMMU support for devices, which fails to probe for the
>> first time and use deferred probe approach. When non-NULL dma_ops is set
>> in arm_iommu_detach_device(), the given device later ignored by
>> arch_setup_dma_ops() and stays with non-IOMMU dma_ops.
>>
>> Reported-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>> Fixes: 1874619a7df4 "ARM: dma-mapping: Set proper DMA ops in arm_iommu_detach_device()"
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>   arch/arm/mm/dma-mapping.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> Can you point out exactly what drivers break because of this change? We
> need to find a solution that works for everyone. Reverting is only
> marginally useful because somebody will just end up wanting to revert
> the revert because a different driver is now broken.

At first glance, it sounds like what we really want is for 
arch_teardown_iommu_ops() to completely clear any ops that 
arch_setup_dma_ops() installed - does the below suffice?

Robin.

----->8-----
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index f1e2922e447c..1e3e08a1c456 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -2390,4 +2390,6 @@ void arch_teardown_dma_ops(struct device *dev)
  		return;

  	arm_teardown_iommu_dma_ops(dev);
+	/* Let arch_setup_dma_ops() start again from scratch upon re-probe */
+	set_dma_ops(dev, NULL);
  }

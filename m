Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 0tNfKYxXHlt5fgAAmS7hNA
	; Mon, 11 Jun 2018 11:05:48 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9C5F460792; Mon, 11 Jun 2018 11:05:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CF0C7601C3;
	Mon, 11 Jun 2018 11:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CF0C7601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932751AbeFKLFo (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 07:05:44 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50232 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932263AbeFKLFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:05:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F8161435;
        Mon, 11 Jun 2018 04:05:43 -0700 (PDT)
Received: from [10.1.210.39] (ostrya.cambridge.arm.com [10.1.210.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3F7E3F59D;
        Mon, 11 Jun 2018 04:05:41 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] add non-strict mode support for arm-smmu-v3
To: Zhen Lei <thunder.leizhen@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc: Xinwei Hu <huxinwei@huawei.com>, Hanjun Guo <guohanjun@huawei.com>,
        Guozhu Li <liguozhu@hisilicon.com>,
        Libin <huawei.libin@huawei.com>
References: <1528628843-10280-1-git-send-email-thunder.leizhen@huawei.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <d6f46de0-f8c3-2c9e-4de3-5949db0cf7b5@arm.com>
Date: Mon, 11 Jun 2018 12:05:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1528628843-10280-1-git-send-email-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhen Lei,

On 10/06/18 12:07, Zhen Lei wrote:
> v1 -> v2:
> Use the lowest bit of the io_pgtable_ops.unmap's iova parameter to pass the strict mode:
> 0, IOMMU_STRICT;
> 1, IOMMU_NON_STRICT;
> Treat 0 as IOMMU_STRICT, so that the unmap operation can compatible with
> other IOMMUs which still use strict mode. In other words, this patch series
> will not impact other IOMMU drivers. I tried add a new quirk IO_PGTABLE_QUIRK_NON_STRICT
> in io_pgtable_cfg.quirks, but it can not pass the strict mode of the domain from SMMUv3
> driver to io-pgtable module. 
> 
> Add a new member domain_non_strict in struct iommu_dma_cookie, this member will only be
> initialized when the related domain and IOMMU driver support non-strict mode.

It's not obvious from the commit messages or comments what the
non-strict mode involves exactly. Could you add a description, and point
out the trade-off associated with it?

In this mode you don't send an invalidate commands when removing a leaf
entry, but instead send invalidate-all commands at regular interval.
This improves performance but introduces a vulnerability window, which
should be pointed out to users.

IOVA allocation isn't the only problem, I'm concerned about the page
allocator. If unmap() returns early, the TLB entry is still valid after
the kernel reallocate the page. The device can then perform a
use-after-free (instead of getting a translation fault), so a buggy
device will corrupt memory and an untrusted one will access arbitrary data.

Or is there a way in mm to ensure that the page isn't reallocated until
the invalidation succeeds? Could dma-iommu help with this? Having
support from the mm would also help consolidate ATS, mark a page stale
when an ATC invalidation times out. But last time I checked it seemed
quite difficult to implement, and ATS is inherently insecure so I didn't
bother.

At the very least I think it might be worth warning users in dmesg about
this pitfall (and add_taint?). Tell them that an IOMMU in this mode is
good for scatter-gather performance but lacks full isolation. The
"non-strict" name seems somewhat harmless, and people should know what
they're getting into before enabling this.

Thanks,
Jean

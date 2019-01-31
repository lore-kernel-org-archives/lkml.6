Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46D6C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FF8D2082F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732552AbfAaMZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:25:56 -0500
Received: from foss.arm.com ([217.140.101.70]:42700 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726153AbfAaMZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:25:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9AC180D;
        Thu, 31 Jan 2019 04:25:55 -0800 (PST)
Received: from [10.1.197.2] (ostrya.cambridge.arm.com [10.1.197.2])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07E893F589;
        Thu, 31 Jan 2019 04:25:54 -0800 (PST)
Subject: Re: [PATCH 2/2] iommu/amd: Remove clear_flush_young notifier
To:     Peter Xu <peterx@redhat.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>
References: <20190130055758.3994-1-peterx@redhat.com>
 <20190130055758.3994-3-peterx@redhat.com>
 <69af2b6f-bfc1-a4b9-675a-6fc93a7efef2@arm.com> <20190131075941.GB25119@xz-x1>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <926c28c2-66a0-8068-f7bc-2d8f9ce9f0ad@arm.com>
Date:   Thu, 31 Jan 2019 12:25:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131075941.GB25119@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/2019 07:59, Peter Xu wrote:
> On Wed, Jan 30, 2019 at 12:27:40PM +0000, Jean-Philippe Brucker wrote:
>> Hi Peter,
> 
> Hi, Jean,
> 
>>
>> On 30/01/2019 05:57, Peter Xu wrote:
>>> AMD IOMMU driver is using the clear_flush_young() to do cache flushing
>>> but that's actually already covered by invalidate_range().  Remove the
>>> extra notifier and the chunks.
>>
>> Aren't uses of clear_flush_young() and invalidate_range() orthogonal? If
>> I understood correctly, when doing reclaim the kernel clears the young
>> bit from the PTE. This requires flushing secondary TLBs (ATCs), so that
>> new accesses from devices will go through the IOMMU, set the young bit
>> again and the kernel can accurately track page use. I didn't see
>> invalidate_range() being called by rmap or vmscan in this case, but
>> might just be missing it.
>>
>> Two MMU notifiers are used for the young bit, clear_flush_young() and
>> clear_young(). I believe the former should invalidate ATCs so that DMA
>> accesses participate in PTE aging. Otherwise the kernel can't know that
>> the device is still using entries marked 'old'. The latter,
>> clear_young() is exempted from invalidating the secondary TLBs by
>> mmu_notifier.h and the IOMMU driver doesn't need to implement it.
> 
> Yes I agree most of your analysis, but IMHO the problem is that the
> AMD IOMMU is not really participating in the PTE aging after all.
> Please have a look at mn_clear_flush_young() below at [1] - it's
> always returning zero, no matter whether the page has been accessed by
> device or not.  A real user of it could be someone like KVM (please
> see kvm_mmu_notifier_clear_flush_young) where we'll try to lookup the
> shadow PTEs and do test-and-clear on that, then return the result to
> the core mm.  That's why I think currently the AMD driver was only
> trying to use that as a way to do an extra flush however IMHO it's
> redundant.

Yes, in IOMMU drivers clear_flush_young() doesn't do the clear, only the
flush, since the level-1 page table is shared with the CPU. But removing
the flush gets you in the following situation:

  (1) Devices wants to access $addr, sends ATS query, the IOMMU sets PTE
young and the entry is cached in the ATC.

  (2) The CPU does ptep_clear_flush_young_notify(), clears young,
notices that the page is being used.

  (3) Device accesses $addr again. Given that we didn't invalidate the
ATC in (2) it accesses the page directly, without going through the IOMMU.

  (4) CPU does ptep_clear_flush_young_notify() again, the PTE doesn't
have the young bit, which means the page isn't being used and can be
reclaimed.

That's not accurate since the page is being used by the device. At step
(2) we should invalidate the ATC, so that (3) fetches the PTE again and
marks it young.

I can agree that the clear_flush_young() notifier is too brutal for this
purpose, since we send spurious ATC invalidation even when the PTE
wasn't young (and ATC inv is expensive). There should be another MMU
notifier "flush_young()" that is called by
ptep_clear_flush_young_notify() only when the page was actually young.
But for the moment it's the best we have to avoid the situation above.

I don't know enough about mm to understand exactly how the
page_referenced() information is used, but I believe the problem is only
about accuracy and not correctness. So applying this patch might not
break anything (after all, intel-svm.c never implemented the notifier)
but I think I'll keep the notifier in my SVA rework [1].

Thanks,
Jean

[1] https://www.spinics.net/lists/iommu/msg30081.html

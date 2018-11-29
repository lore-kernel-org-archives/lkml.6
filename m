Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453EDC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 20:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1818B21104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 20:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1818B21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbeK3HKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 02:10:31 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44310 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbeK3HKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 02:10:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14AF480D;
        Thu, 29 Nov 2018 12:03:56 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41B7C3F5A0;
        Thu, 29 Nov 2018 12:03:54 -0800 (PST)
Subject: Re: [PATCH v3 1/1] drm: msm: Replace dma_map_sg with dma_sync_sg*
To:     Tomasz Figa <tfiga@chromium.org>, Rob Clark <robdclark@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Archit Taneja <architt@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Sean Paul <seanpaul@chromium.org>
References: <20181129140315.28476-1-vivek.gautam@codeaurora.org>
 <20181129141429.GA22638@lst.de>
 <CAF6AEGvsFbXGkC+=4oq1xXnoC2EVX2J0k-GqShefcek1=uw4Lw@mail.gmail.com>
 <CAF6AEGu65Vvzpy6K7eF+Kk4YdYBPEKFX5ct8GxG0pw-KNwM5eA@mail.gmail.com>
 <20181129155418.GB26537@lst.de>
 <CAF6AEGufdp5jRtUZ_+VRQg3ZXH36hNHvbWZQeJDArp8N5SZ3Lg@mail.gmail.com>
 <20181129194029.GE17663@jcrouse-lnx.qualcomm.com>
 <CAAFQd5D139pNx9aEpO8745R4kfVYCBDyqyJNR_HDDXvKt7NZjw@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <06747338-b0fb-eef6-634a-0641e81ed3c1@arm.com>
Date:   Thu, 29 Nov 2018 20:03:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAAFQd5D139pNx9aEpO8745R4kfVYCBDyqyJNR_HDDXvKt7NZjw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2018 19:57, Tomasz Figa wrote:
> On Thu, Nov 29, 2018 at 11:40 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>>
>> On Thu, Nov 29, 2018 at 01:48:15PM -0500, Rob Clark wrote:
>>> On Thu, Nov 29, 2018 at 10:54 AM Christoph Hellwig <hch@lst.de> wrote:
>>>>
>>>> On Thu, Nov 29, 2018 at 09:42:50AM -0500, Rob Clark wrote:
>>>>> Maybe the thing we need to do is just implement a blacklist of
>>>>> compatible strings for devices which should skip the automatic
>>>>> iommu/dma hookup.  Maybe a bit ugly, but it would also solve a problem
>>>>> preventing us from enabling per-process pagetables for a5xx (where we
>>>>> need to control the domain/context-bank that is allocated by the dma
>>>>> api).
>>>>
>>>> You can detach from the dma map attachment using arm_iommu_detach_device,
>>>> which a few drm drivers do, but I don't think this is the problem.
>>>
>>> I think even with detach, we wouldn't end up with the context-bank
>>> that the gpu firmware was hard-coded to expect, and so it would
>>> overwrite the incorrect page table address register.  (I could be
>>> mis-remembering that, Jordan spent more time looking at that.  But it
>>> was something along those lines.)
>>
>> Right - basically the DMA domain steals context bank 0 and the GPU is hard coded
>> to use that context bank for pagetable switching.
>>
>> I believe the Tegra guys also had a similar problem with a hard coded context
>> bank.

AIUI, they don't need a specific hardware context, they just need to 
know which one they're actually using, which the domain abstraction hides.

> Wait, if we detach the GPU/display struct device from the default
> domain and attach it to a newly allocated domain, wouldn't the newly
> allocated domain use the context bank we need? Note that we're already

The arm-smmu driver doesn't, but there's no fundamental reason it 
couldn't. That should just need code to refcount domain users and 
release hardware contexts for domains with no devices currently attached.

Robin.

> doing that, except that we're doing it behind the back of the DMA
> mapping subsystem, so that it keeps using the IOMMU version of the DMA
> ops for the device and doing any mapping operations on the default
> domain. If we ask the DMA mapping to detach, wouldn't it essentially
> solve the problem?
> 
> Best regards,
> Tomasz
> 

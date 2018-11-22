Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70752C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2872D20684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lkgkUoZ4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YJUN75qj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2872D20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390368AbeKVUqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:46:47 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:60990 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731910AbeKVUqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 15:46:47 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7DF2060712; Thu, 22 Nov 2018 10:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542881280;
        bh=1UsBhzJUjaW/G4gmmuQFQjJLuZ0bIP0BH+CoXfEga/o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lkgkUoZ4yIFYN7/x2HP4+QcBfn1gNmf9Ul0N1uD2Cf6sWEieMenh5ksMSppTQR1Rl
         ZHDMWZZSlheGlgYQ/3hqnhmbb7eWL1EBVyYvkgHxIqoVif9A4ZcJNEj7JQv4s+du4S
         8EKRyfWSrnNa26MNl7MSlpP7EBWblCTxLZ6W1CiE=
Received: from [10.79.40.107] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3193D60712;
        Thu, 22 Nov 2018 10:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542881279;
        bh=1UsBhzJUjaW/G4gmmuQFQjJLuZ0bIP0BH+CoXfEga/o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YJUN75qjVjQApR/xL+eJAn7YkZT/PPq7LUm/fJ+XvXT55D4QNxMJMDGv6k3hOLZqz
         HuqO0BZwNc0Sss+ywM/S/B/hdSeqdtRYK0zMZcbGlxFMYgsVHgzJY/9YO/6KX6a3pX
         s13MMTRuY3SZEO7diB3IOr0p+/uWWTnMzIGbyEsE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3193D60712
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH 1/1] drm: msm: Replace dma_map_sg with dma_sync_sg*
To:     Tomasz Figa <tfiga@chromium.org>, jcrouse@codeaurora.org
Cc:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <20181120095437.29820-1-vivek.gautam@codeaurora.org>
 <20181120154148.GC31792@jcrouse-lnx.qualcomm.com>
 <CAAFQd5DAa+TmvJCViRHq8YTJh2GRyqBteicOLgohv5v7cNCQPA@mail.gmail.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <bb5d0665-ad58-95f2-3cc8-75209abe4c6b@codeaurora.org>
Date:   Thu, 22 Nov 2018 15:37:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAAFQd5DAa+TmvJCViRHq8YTJh2GRyqBteicOLgohv5v7cNCQPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomasz, Jordan,


On 11/21/2018 9:18 AM, Tomasz Figa wrote:
> Hi Jordan, Vivek,
>
> On Wed, Nov 21, 2018 at 12:41 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>> On Tue, Nov 20, 2018 at 03:24:37PM +0530, Vivek Gautam wrote:
>>> dma_map_sg() expects a DMA domain. However, the drm devices
>>> have been traditionally using unmanaged iommu domain which
>>> is non-dma type. Using dma mapping APIs with that domain is bad.
>>>
>>> Replace dma_map_sg() calls with dma_sync_sg_for_device{|cpu}()
>>> to do the cache maintenance.
>>>
>>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>>> Suggested-by: Tomasz Figa <tfiga@chromium.org>
>>> ---
>>>
>>> Tested on an MTP sdm845:
>>> https://github.com/vivekgautam1/linux/tree/v4.19/sdm845-mtp-display-working
>>>
>>>   drivers/gpu/drm/msm/msm_gem.c | 27 ++++++++++++++++++++-------
>>>   1 file changed, 20 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
>>> index 00c795ced02c..d7a7af610803 100644
>>> --- a/drivers/gpu/drm/msm/msm_gem.c
>>> +++ b/drivers/gpu/drm/msm/msm_gem.c
>>> @@ -81,6 +81,8 @@ static struct page **get_pages(struct drm_gem_object *obj)
>>>                struct drm_device *dev = obj->dev;
>>>                struct page **p;
>>>                int npages = obj->size >> PAGE_SHIFT;
>>> +             struct scatterlist *s;
>>> +             int i;
>>>
>>>                if (use_pages(obj))
>>>                        p = drm_gem_get_pages(obj);
>>> @@ -107,9 +109,19 @@ static struct page **get_pages(struct drm_gem_object *obj)
>>>                /* For non-cached buffers, ensure the new pages are clean
>>>                 * because display controller, GPU, etc. are not coherent:
>>>                 */
>>> -             if (msm_obj->flags & (MSM_BO_WC|MSM_BO_UNCACHED))
>>> -                     dma_map_sg(dev->dev, msm_obj->sgt->sgl,
>>> -                                     msm_obj->sgt->nents, DMA_BIDIRECTIONAL);
>>> +             if (msm_obj->flags & (MSM_BO_WC | MSM_BO_UNCACHED)) {
>>> +                     /*
>>> +                      * Fake up the SG table so that dma_sync_sg_*()
>>> +                      * can be used to flush the pages associated with it.
>>> +                      */
>> We aren't really faking.  The table is real, we are just slightly abusing the
>> sg_dma_address() which makes this comment a bit misleading. Instead I would
>> probably say something like:
>>
>> /* dma_sync_sg_* flushes pages using sg_dma_address() so point it at the
>>   * physical page for the right behavior */
>>
>> Or something like that.
>>
> It's actually quite complicated, but I agree that the comment isn't
> very precise. The cases are as follows:
> - arm64 iommu_dma_ops use sg_phys()
> https://elixir.bootlin.com/linux/v4.20-rc3/source/arch/arm64/mm/dma-mapping.c#L599
> - swiotlb_dma_ops used on arm64 if no IOMMU is available use
> sg->dma_address directly:
> https://elixir.bootlin.com/linux/v4.20-rc3/source/kernel/dma/swiotlb.c#L832
> - arm_dma_ops use sg_dma_address():
> https://elixir.bootlin.com/linux/v4.20-rc3/source/arch/arm/mm/dma-mapping.c#L1130
> - arm iommu_ops use sg_page():
> https://elixir.bootlin.com/linux/v4.20-rc3/source/arch/arm/mm/dma-mapping.c#L1869
>
> Sounds like a mess...
Thanks for the review.

Technically with the below assignment we address all of the above. How 
about an even
simpler version of the suggested comment:

/* dma_sync_sg_* flushes physical pages, so point sg->dma_address to
  * the physical one for the right behavior.
  */


>
>>> +                     for_each_sg(msm_obj->sgt->sgl, s,
>>> +                                 msm_obj->sgt->nents, i)
>>> +                             sg_dma_address(s) = sg_phys(s);
>>> +
>> I'm wondering - wouldn't we want to do this association for cached buffers to so
>> we could sync them correctly in cpu_prep and cpu_fini?  Maybe it wouldn't hurt
>> to put this association in the main path (obviously the sync should stay inside
>> the conditional for uncached buffers).
>>

Sure, I will move this out of the conditional check.

> I guess it wouldn't hurt indeed. Note that cpu_prep/fini seem to be
> missing the sync call currently.

I can't say I understand the usage of cpu_prep and cpu_fini(). But I can add
the necessary support if you can point me in the right direction.
Thanks

Best regards
Vivek
>
> P.S. Jordan, not sure if it's my Gmail or your email client, but your
> message had all the recipients in a Reply-to header, except you, so
> pressing Reply to all in my case led to a message that didn't have you
> in recipients anymore...
>
> Best regards,
> Tomasz


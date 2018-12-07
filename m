Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7922C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 705002082D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 705002082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbeLGVTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 16:19:30 -0500
Received: from foss.arm.com ([217.140.101.70]:54542 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbeLGVT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 16:19:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E35B15AB;
        Fri,  7 Dec 2018 13:19:29 -0800 (PST)
Received: from [192.168.1.123] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93D3E3F575;
        Fri,  7 Dec 2018 13:19:26 -0800 (PST)
Subject: Re: [PATCH v3 4/9] drm/rockchip/rockchip_drm_gem.c: Convert to use
 vm_insert_range
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, hjc@rock-chips.com,
        Heiko Stuebner <heiko@sntech.de>, airlied@linux.ie,
        Linux-MM <linux-mm@kvack.org>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20181206184227.GA28656@jordon-HP-15-Notebook-PC>
 <ca1779ea-7a87-971c-24c4-4a1c77a72e92@arm.com>
 <CAFqt6zbMbvB1ckwhSsBATrq5M-HQ6qk95sCWCoTTFFnwzBAnng@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <fd6b10d7-de66-f16a-f500-29a13b909f46@arm.com>
Date:   Fri, 7 Dec 2018 21:19:24 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <CAFqt6zbMbvB1ckwhSsBATrq5M-HQ6qk95sCWCoTTFFnwzBAnng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-07 8:30 pm, Souptick Joarder wrote:
> On Fri, Dec 7, 2018 at 8:20 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 06/12/2018 18:42, Souptick Joarder wrote:
>>> Convert to use vm_insert_range() to map range of kernel
>>> memory to user vma.
>>>
>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>>> Tested-by: Heiko Stuebner <heiko@sntech.de>
>>> Acked-by: Heiko Stuebner <heiko@sntech.de>
>>> ---
>>>    drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 20 ++------------------
>>>    1 file changed, 2 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
>>> index a8db758..2cb83bb 100644
>>> --- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
>>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
>>> @@ -221,26 +221,10 @@ static int rockchip_drm_gem_object_mmap_iommu(struct drm_gem_object *obj,
>>>                                              struct vm_area_struct *vma)
>>>    {
>>>        struct rockchip_gem_object *rk_obj = to_rockchip_obj(obj);
>>> -     unsigned int i, count = obj->size >> PAGE_SHIFT;
>>>        unsigned long user_count = vma_pages(vma);
>>> -     unsigned long uaddr = vma->vm_start;
>>> -     unsigned long offset = vma->vm_pgoff;
>>> -     unsigned long end = user_count + offset;
>>> -     int ret;
>>> -
>>> -     if (user_count == 0)
>>> -             return -ENXIO;
>>> -     if (end > count)
>>> -             return -ENXIO;
>>>
>>> -     for (i = offset; i < end; i++) {
>>> -             ret = vm_insert_page(vma, uaddr, rk_obj->pages[i]);
>>> -             if (ret)
>>> -                     return ret;
>>> -             uaddr += PAGE_SIZE;
>>> -     }
>>> -
>>> -     return 0;
>>> +     return vm_insert_range(vma, vma->vm_start, rk_obj->pages,
>>> +                             user_count);
>>
>> We're losing vm_pgoff handling here, which given the implication in
>> 57de50af162b, may well be a regression for at least some combination of
>> GPU and userspace driver (I assume that commit was in the context of
>> some version of the Arm Mali driver, possibly on RK3288).
> 
> In commit  57de50af162b, vma->vm_pgoff = 0 for GEM mmap handler context
> and removing it from common path which means if call stack looks like
> rockchip_gem_mmap_buf() -> rockchip_drm_gem_object_mmap() ->
> rockchip_drm_gem_object_mmap_iommu(), then we might have a non zero
> vma->vm_pgoff context which is not handled.
> 
> This is the problem you are pointing ? right ?

Exactly - if unconditionally zeroing the offset in the PRIME mmap() path 
was a problem, then the implication is that there are callers of that 
path who expect the offset to be honoured here.

Robin.

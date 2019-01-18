Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7C2C1B0F7
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D7A2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbfARUbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 15:31:39 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37601 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729403AbfARUbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 15:31:38 -0500
Received: by mail-qt1-f194.google.com with SMTP id t33so16658343qtt.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 12:31:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q/YMRxDKd7FKMnvlINhw9uqVLAtVZg+TmfCwOlM5qck=;
        b=mj1ipHI5kLjijNr/ZKz7Iy2H50B6EX3YToyo/VIPvY3ja1aJ6Likx3HG/wSEPAwBXj
         Cq+RWZNHmjKYQNGAjRyP5dxN3x2Yg7TUKG47pnBJJ1fdzUlD8JIQLYzSAUniZS+szQBx
         LjLbFcZ16GP4A3uu4wqT9Ab9zsGZQCX9/Yopy/hBWofaalSfEMAw82c1OYbrbREcfgS+
         6DdcUn30BbkKHoRZjAg6zo+e/tUBzHcFcmoeXsSbtKYAcC4STkLcRULeS0+FVyg930sI
         hWsCWadDc/Y7nXcGLFT4cY3hmspFuH22jVsBUoHyWrlIKwgaVEntiypo9fMnmBPqQE+8
         BDcg==
X-Gm-Message-State: AJcUukerVNL2ttTM93zV0OgoGwVWu3adUtRsnTR9Qx8zUorr4KBAkH01
        u70ZvixzZM3n03z1DW58B06v3g==
X-Google-Smtp-Source: ALg8bN5yj8BqaRYMB0KkkEPsTQk/K+NnX1CaiInS3uZ3G+h531r1wV6+IUlh/MdhVS+eUjxSoj8ukA==
X-Received: by 2002:a0c:f143:: with SMTP id y3mr17392935qvl.21.1547843496967;
        Fri, 18 Jan 2019 12:31:36 -0800 (PST)
Received: from ?IPv6:2601:602:9800:dae6::fb21? ([2601:602:9800:dae6::fb21])
        by smtp.gmail.com with ESMTPSA id c17sm76875340qtb.14.2019.01.18.12.31.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 12:31:35 -0800 (PST)
Subject: Re: [PATCH 13/14] staging: android: ion: Do not sync CPU cache on
 map/unmap
To:     "Andrew F. Davis" <afd@ti.com>, Liam Mark <lmark@codeaurora.org>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <20190111180523.27862-1-afd@ti.com>
 <20190111180523.27862-14-afd@ti.com>
 <alpine.DEB.2.10.1901140910130.23879@lmark-linux.qualcomm.com>
 <79eb70f6-00b0-2939-5ec9-65e196ab4987@ti.com>
 <alpine.DEB.2.10.1901150937280.4046@lmark-linux.qualcomm.com>
 <cfcd3daf-bd1d-0dbc-7b5c-8e504d179564@ti.com>
 <b6cb5596-6beb-73e0-0d8c-d9a13466d626@redhat.com>
 <99ca0b08-02bd-64fd-d43c-c330f0d11639@ti.com>
 <alpine.DEB.2.10.1901161441280.10666@lmark-linux.qualcomm.com>
 <7620534f-b749-76f9-0f53-f73e3f12e9a9@ti.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <fd33986f-ec26-c028-32c2-19c8cc0aba15@redhat.com>
Date:   Fri, 18 Jan 2019 12:31:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <7620534f-b749-76f9-0f53-f73e3f12e9a9@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/19 8:13 AM, Andrew F. Davis wrote:
> On 1/16/19 4:48 PM, Liam Mark wrote:
>> On Wed, 16 Jan 2019, Andrew F. Davis wrote:
>>
>>> On 1/15/19 1:05 PM, Laura Abbott wrote:
>>>> On 1/15/19 10:38 AM, Andrew F. Davis wrote:
>>>>> On 1/15/19 11:45 AM, Liam Mark wrote:
>>>>>> On Tue, 15 Jan 2019, Andrew F. Davis wrote:
>>>>>>
>>>>>>> On 1/14/19 11:13 AM, Liam Mark wrote:
>>>>>>>> On Fri, 11 Jan 2019, Andrew F. Davis wrote:
>>>>>>>>
>>>>>>>>> Buffers may not be mapped from the CPU so skip cache maintenance
>>>>>>>>> here.
>>>>>>>>> Accesses from the CPU to a cached heap should be bracketed with
>>>>>>>>> {begin,end}_cpu_access calls so maintenance should not be needed
>>>>>>>>> anyway.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>>>>>>>>> ---
>>>>>>>>>    drivers/staging/android/ion/ion.c | 7 ++++---
>>>>>>>>>    1 file changed, 4 insertions(+), 3 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/staging/android/ion/ion.c
>>>>>>>>> b/drivers/staging/android/ion/ion.c
>>>>>>>>> index 14e48f6eb734..09cb5a8e2b09 100644
>>>>>>>>> --- a/drivers/staging/android/ion/ion.c
>>>>>>>>> +++ b/drivers/staging/android/ion/ion.c
>>>>>>>>> @@ -261,8 +261,8 @@ static struct sg_table *ion_map_dma_buf(struct
>>>>>>>>> dma_buf_attachment *attachment,
>>>>>>>>>          table = a->table;
>>>>>>>>>    -    if (!dma_map_sg(attachment->dev, table->sgl, table->nents,
>>>>>>>>> -            direction))
>>>>>>>>> +    if (!dma_map_sg_attrs(attachment->dev, table->sgl, table->nents,
>>>>>>>>> +                  direction, DMA_ATTR_SKIP_CPU_SYNC))
>>>>>>>>
>>>>>>>> Unfortunately I don't think you can do this for a couple reasons.
>>>>>>>> You can't rely on {begin,end}_cpu_access calls to do cache
>>>>>>>> maintenance.
>>>>>>>> If the calls to {begin,end}_cpu_access were made before the call to
>>>>>>>> dma_buf_attach then there won't have been a device attached so the
>>>>>>>> calls
>>>>>>>> to {begin,end}_cpu_access won't have done any cache maintenance.
>>>>>>>>
>>>>>>>
>>>>>>> That should be okay though, if you have no attachments (or all
>>>>>>> attachments are IO-coherent) then there is no need for cache
>>>>>>> maintenance. Unless you mean a sequence where a non-io-coherent device
>>>>>>> is attached later after data has already been written. Does that
>>>>>>> sequence need supporting?
>>>>>>
>>>>>> Yes, but also I think there are cases where CPU access can happen before
>>>>>> in Android, but I will focus on later for now.
>>>>>>
>>>>>>> DMA-BUF doesn't have to allocate the backing
>>>>>>> memory until map_dma_buf() time, and that should only happen after all
>>>>>>> the devices have attached so it can know where to put the buffer. So we
>>>>>>> shouldn't expect any CPU access to buffers before all the devices are
>>>>>>> attached and mapped, right?
>>>>>>>
>>>>>>
>>>>>> Here is an example where CPU access can happen later in Android.
>>>>>>
>>>>>> Camera device records video -> software post processing -> video device
>>>>>> (who does compression of raw data) and writes to a file
>>>>>>
>>>>>> In this example assume the buffer is cached and the devices are not
>>>>>> IO-coherent (quite common).
>>>>>>
>>>>>
>>>>> This is the start of the problem, having cached mappings of memory that
>>>>> is also being accessed non-coherently is going to cause issues one way
>>>>> or another. On top of the speculative cache fills that have to be
>>>>> constantly fought back against with CMOs like below; some coherent
>>>>> interconnects behave badly when you mix coherent and non-coherent access
>>>>> (snoop filters get messed up).
>>>>>
>>>>> The solution is to either always have the addresses marked non-coherent
>>>>> (like device memory, no-map carveouts), or if you really want to use
>>>>> regular system memory allocated at runtime, then all cached mappings of
>>>>> it need to be dropped, even the kernel logical address (area as painful
>>>>> as that would be).
>>>>>
>>>>
>>>> I agree it's broken, hence my desire to remove it :)
>>>>
>>>> The other problem is that uncached buffers are being used for
>>>> performance reason so anything that would involve getting
>>>> rid of the logical address would probably negate any performance
>>>> benefit.
>>>>
>>>
>>> I wouldn't go as far as to remove them just yet.. Liam seems pretty
>>> adamant that they have valid uses. I'm just not sure performance is one
>>> of them, maybe in the case of software locks between devices or
>>> something where there needs to be a lot of back and forth interleaved
>>> access on small amounts of data?
>>>
>>
>> I wasn't aware that ARM considered this not supported, I thought it was
>> supported but they advised against it because of the potential performance
>> impact.
>>
> 
> Not sure what you mean by "this" being not supported, do you mean mixed
> attribute mappings? If so, it will certainly cause problems, and the
> problems will change from platform to platform, avoid at all costs is my
> understanding of ARM's position.
> 
>> This is after all supported in the DMA APIs and up until now devices have
>> been successfully commercializing with this configurations, and I think
>> they will continue to commercialize with these configurations for quite a
>> while.
>>
> 
> Use of uncached memory mappings are almost always wrong in my experience
> and are used to work around some bug or because the user doesn't want to
> implement proper CMOs. Counter examples welcome.
> 
>> It would be really unfortunate if support was removed as I think that
>> would drive clients away from using upstream ION.
>>
> 
> I'm not petitioning to remove support, but at very least lets reverse
> the ION_FLAG_CACHED flag. Ion should hand out cached normal memory by
> default, to get uncached you should need to add a flag to your
> allocation command pointing out you know what you are doing.
> 

I thought about doing that, the problem is it becomes an ABI break for
existing users which I really didn't want to do again. If it
ends up being the last thing we do before moving out of staging,
I'd consider doing it.

>>>>>> ION buffer is allocated.
>>>>>>
>>>>>> //Camera device records video
>>>>>> dma_buf_attach
>>>>>> dma_map_attachment (buffer needs to be cleaned)
>>>>>
>>>>> Why does the buffer need to be cleaned here? I just got through reading
>>>>> the thread linked by Laura in the other reply. I do like +Brian's
>>>>> suggestion of tracking if the buffer has had CPU access since the last
>>>>> time and only flushing the cache if it has. As unmapped heaps never get
>>>>> CPU mapped this would never be the case for unmapped heaps, it solves my
>>>>> problem.
>>>>>
>>>>>> [camera device writes to buffer]
>>>>>> dma_buf_unmap_attachment (buffer needs to be invalidated)
>>>>>
>>>>> It doesn't know there will be any further CPU access, it could get freed
>>>>> after this for all we know, the invalidate can be saved until the CPU
>>>>> requests access again.
>>>>>
>>>>>> dma_buf_detach  (device cannot stay attached because it is being sent
>>>>>> down
>>>>>> the pipeline and Camera doesn't know the end of the use case)
>>>>>>
>>>>>
>>>>> This seems like a broken use-case, I understand the desire to keep
>>>>> everything as modular as possible and separate the steps, but at this
>>>>> point no one owns this buffers backing memory, not the CPU or any
>>>>> device. I would go as far as to say DMA-BUF should be free now to
>>>>> de-allocate the backing storage if it wants, that way it could get ready
>>>>> for the next attachment, which may change the required backing memory
>>>>> completely.
>>>>>
>>>>> All devices should attach before the first mapping, and only let go
>>>>> after the task is complete, otherwise this buffers data needs copied off
>>>>> to a different location or the CPU needs to take ownership in-between.
>>>>>
>>>>
>>>> Maybe it's broken but it's the status quo and we spent a good
>>>> amount of time at plumbers concluding there isn't a great way
>>>> to fix it :/
>>>>
>>>
>>> Hmm, guess that doesn't prove there is not a great way to fix it either.. :/
>>>
>>> Perhaps just stronger rules on sequencing of operations? I'm not saying
>>> I have a good solution either, I just don't see any way forward without
>>> some use-case getting broken, so better to fix now over later.
>>>
>>
>> I can see the benefits of Android doing things the way they do, I would
>> request that changes we make continue to support Android, or we find a way
>> to convice them to change, as they are the main ION client and I assume
>> other ION clients in the future will want to do this as well.
>>
> 
> Android may be the biggest user today (makes sense, Ion come out of the
> Android project), but that can change, and getting changes into Android
> will be easier that the upstream kernel once Ion is out of staging.
> 
> Unlike some other big ARM vendors, we (TI) do not primarily build mobile
> chips targeting Android, our core offerings target more traditional
> Linux userspaces, and I'm guessing others will start to do the same as
> ARM tries to push more into desktop, server, and other spaces again.
> 
>> I am concerned that if you go with a solution which enforces what you
>> mention above, and bring ION out of staging that way, it will make it that
>> much harder to solve this for Android and therefore harder to get
>> Android clients to move to the upstream ION (and get everybody off their
>> vendor modified Android versions).
>>
> 
> That would be an Android problem, reducing functionality in upstream to
> match what some evil vendor trees do to support Android is not the way
> forward on this. At least for us we are going to try to make all our
> software offerings follow proper buffer ownership (including our Android
> offering).
> 

I don't think this is reducing functionality, it's about not breaking
what already works. There is some level of Android testing on a mainline
tree (hikey boards). I would say if we can come to an agreement on
a correct API, we could always merge the 'correct' version out of
staging and keep a legacy driver around for some time as a transition.

Thanks,
Laura

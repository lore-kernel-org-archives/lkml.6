Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751244AbeDYGHN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 02:07:13 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36854 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbeDYGHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 02:07:11 -0400
X-Google-Smtp-Source: AIpwx49V2YL8Rg6WOqKhsgEaTkHrD/JwZVbnrl/zLEtSjVkEVHFwrO/siVLiH4rCpcN7me1069jy7A==
Subject: Re: [Xen-devel] [PATCH 0/1] drm/xen-zcopy: Add Xen zero-copy helper
 DRM driver
To: Dongwon Kim <dongwon.kim@intel.com>
Cc: Wei Liu <wei.liu2@citrix.com>, jgross@suse.com,
        Artem Mygaiev <Artem_Mygaiev@epam.com>, konrad.wilk@oracle.com,
        airlied@linux.ie, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        "Potrola, MateuszX" <mateuszx.potrola@intel.com>,
        daniel.vetter@intel.com, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        "Oleksandr_Andrushchenko@epam.com" <Oleksandr_Andrushchenko@epam.com>
References: <41487acb-a67a-8933-d0c3-702c19b0938e@gmail.com>
 <20180418073508.ptvntwedczpvl7bx@MacBook-Pro-de-Roger.local>
 <ebcbf6ce-1d7a-5f3e-cff8-546d1c010e59@gmail.com>
 <20180418101058.hyqk3gr3b2ibxswu@MacBook-Pro-de-Roger.local>
 <20180420071914.GG31310@phenom.ffwll.local>
 <76cdc65a-7bb1-9377-7bc5-6164e32f7b5d@gmail.com>
 <20180423115242.ywdwqblj2aseu3fr@citrix.com>
 <61105351-8896-072b-abf0-757c7f6c0edf@gmail.com>
 <20180424115437.GT31310@phenom.ffwll.local>
 <18ab5f76-00b0-42a0-fcb8-e0cbf4cdd527@gmail.com>
 <20180424203514.GA26787@downor-Z87X-UD5H>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <43bc755f-3e31-6841-0962-542c42515f88@gmail.com>
Date: Wed, 25 Apr 2018 09:07:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424203514.GA26787@downor-Z87X-UD5H>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/24/2018 11:35 PM, Dongwon Kim wrote:
> Had a meeting with Daniel and talked about bringing out generic
> part of hyper-dmabuf to the userspace, which means we most likely
> reuse IOCTLs defined in xen-zcopy for our use-case if we follow
> his suggestion.
I will still have kernel side API, so backends/frontends implemented
in the kernel can access that functionality as well.
>
> So assuming we use these IOCTLs as they are,
> Several things I would like you to double-check..
>
> 1. returning gref as is to the user space is still unsafe because
> it is a constant, easy to guess and any process that hijacks it can easily
> exploit the buffer. So I am wondering if it's possible to keep dmabuf-to
> -gref or gref-to-dmabuf in kernel space and add other layers on top
> of those in actual IOCTLs to add some safety.. We introduced flink like
> hyper_dmabuf_id including random number but many says even that is still
> not safe.
Yes, it is generally unsafe. But even if we have implemented
the approach you have in hyper-dmabuf or similar, what stops
malicious software from doing the same with the existing gntdev UAPI?
No need to brute force new UAPI if there is a simpler one.
That being said, I'll put security aside at the first stage,
but of course we can start investigating ways to improve
(I assume you already have use-cases where security issues must
be considered, so, probably you can tell more on what was investigated
so far).
>
> 2. maybe we could take hypervisor-independent process (e.g. SGT<->page)
> out of xen-zcopy and put those in a new helper library.
I believe this can be done, but at the first stage I would go without
that helper library, so it is clearly seen what can be moved to it later
(I know that you want to run ACRN as well, but can I run it on ARM? ;)

> 3. please consider the case where original DMA-BUF's first offset
> and last length are not 0 and PAGE_SIZE respectively. I assume current
> xen-zcopy only supports page-aligned buffer with PAGE_SIZE x n big.
Hm, what is the use-case for that?
> thanks,
> DW
Thank you,
Oleksandr
> On Tue, Apr 24, 2018 at 02:59:39PM +0300, Oleksandr Andrushchenko wrote:
>> On 04/24/2018 02:54 PM, Daniel Vetter wrote:
>>> On Mon, Apr 23, 2018 at 03:10:35PM +0300, Oleksandr Andrushchenko wrote:
>>>> On 04/23/2018 02:52 PM, Wei Liu wrote:
>>>>> On Fri, Apr 20, 2018 at 02:25:20PM +0300, Oleksandr Andrushchenko wrote:
>>>>>>>>       the gntdev.
>>>>>>>>
>>>>>>>> I think this is generic enough that it could be implemented by a
>>>>>>>> device not tied to Xen. AFAICT the hyper_dma guys also wanted
>>>>>>>> something similar to this.
>>>>>>> You can't just wrap random userspace memory into a dma-buf. We've just had
>>>>>>> this discussion with kvm/qemu folks, who proposed just that, and after a
>>>>>>> bit of discussion they'll now try to have a driver which just wraps a
>>>>>>> memfd into a dma-buf.
>>>>>> So, we have to decide either we introduce a new driver
>>>>>> (say, under drivers/xen/xen-dma-buf) or extend the existing
>>>>>> gntdev/balloon to support dma-buf use-cases.
>>>>>>
>>>>>> Can anybody from Xen community express their preference here?
>>>>>>
>>>>> Oleksandr talked to me on IRC about this, he said a few IOCTLs need to
>>>>> be added to either existing drivers or a new driver.
>>>>>
>>>>> I went through this thread twice and skimmed through the relevant
>>>>> documents, but I couldn't see any obvious pros and cons for either
>>>>> approach. So I don't really have an opinion on this.
>>>>>
>>>>> But, assuming if implemented in existing drivers, those IOCTLs need to
>>>>> be added to different drivers, which means userspace program needs to
>>>>> write more code and get more handles, it would be slightly better to
>>>>> implement a new driver from that perspective.
>>>> If gntdev/balloon extension is still considered:
>>>>
>>>> All the IOCTLs will be in gntdev driver (in current xen-zcopy terminology):
>> I was lazy to change dumb to dma-buf, so put this notice ;)
>>>>   - DRM_ICOTL_XEN_ZCOPY_DUMB_FROM_REFS
>>>>   - DRM_IOCTL_XEN_ZCOPY_DUMB_TO_REFS
>>>>   - DRM_IOCTL_XEN_ZCOPY_DUMB_WAIT_FREE
>>> s/DUMB/DMA_BUF/ please. This is generic dma-buf, it has nothing to do with
>>> the dumb scanout buffer support in the drm/gfx subsystem. This here can be
>>> used for any zcopy sharing among guests (as long as your endpoints
>>> understands dma-buf, which most relevant drivers do).
>> Of course, please see above
>>> -Daniel
>>>
>>>> Balloon driver extension, which is needed for contiguous/DMA
>>>> buffers, will be to provide new *kernel API*, no UAPI is needed.
>>>>
>>>>> Wei.
>>>> Thank you,
>>>> Oleksandr
>>>> _______________________________________________
>>>> dri-devel mailing list
>>>> dri-devel@lists.freedesktop.org
>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756538AbeDXHwK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 03:52:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:51968 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756079AbeDXHwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 03:52:07 -0400
Subject: Re: [Xen-devel] [PATCH 0/1] drm/xen-zcopy: Add Xen zero-copy helper
 DRM driver
To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Wei Liu <wei.liu2@citrix.com>
Cc: =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Artem Mygaiev <Artem_Mygaiev@epam.com>,
        Dongwon Kim <dongwon.kim@intel.com>, konrad.wilk@oracle.com,
        airlied@linux.ie,
        "Oleksandr_Andrushchenko@epam.com" <Oleksandr_Andrushchenko@epam.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        "Potrola, MateuszX" <mateuszx.potrola@intel.com>,
        xen-devel@lists.xenproject.org, daniel.vetter@intel.com
References: <5d8fec7f-956c-378f-be90-f45029385740@gmail.com>
 <20180416192905.GA18096@downor-Z87X-UD5H>
 <20180417075928.GT31310@phenom.ffwll.local>
 <20180417205744.GA15930@downor-Z87X-UD5H>
 <41487acb-a67a-8933-d0c3-702c19b0938e@gmail.com>
 <20180418073508.ptvntwedczpvl7bx@MacBook-Pro-de-Roger.local>
 <ebcbf6ce-1d7a-5f3e-cff8-546d1c010e59@gmail.com>
 <20180418101058.hyqk3gr3b2ibxswu@MacBook-Pro-de-Roger.local>
 <20180420071914.GG31310@phenom.ffwll.local>
 <76cdc65a-7bb1-9377-7bc5-6164e32f7b5d@gmail.com>
 <20180423115242.ywdwqblj2aseu3fr@citrix.com>
 <61105351-8896-072b-abf0-757c7f6c0edf@gmail.com>
 <ce2ebb5b-fa13-0475-b0fd-6c330277d151@oracle.com>
 <30ddb005-96c8-f47c-2e23-4e0d354e5842@gmail.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <a25a394c-ecf8-d8cf-15b8-eb8cb71d0a02@suse.com>
Date: Tue, 24 Apr 2018 09:51:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <30ddb005-96c8-f47c-2e23-4e0d354e5842@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/18 07:43, Oleksandr Andrushchenko wrote:
> On 04/24/2018 01:41 AM, Boris Ostrovsky wrote:
>> On 04/23/2018 08:10 AM, Oleksandr Andrushchenko wrote:
>>> On 04/23/2018 02:52 PM, Wei Liu wrote:
>>>> On Fri, Apr 20, 2018 at 02:25:20PM +0300, Oleksandr Andrushchenko
>>>> wrote:
>>>>>>>       the gntdev.
>>>>>>>
>>>>>>> I think this is generic enough that it could be implemented by a
>>>>>>> device not tied to Xen. AFAICT the hyper_dma guys also wanted
>>>>>>> something similar to this.
>>>>>> You can't just wrap random userspace memory into a dma-buf. We've
>>>>>> just had
>>>>>> this discussion with kvm/qemu folks, who proposed just that, and
>>>>>> after a
>>>>>> bit of discussion they'll now try to have a driver which just wraps a
>>>>>> memfd into a dma-buf.
>>>>> So, we have to decide either we introduce a new driver
>>>>> (say, under drivers/xen/xen-dma-buf) or extend the existing
>>>>> gntdev/balloon to support dma-buf use-cases.
>>>>>
>>>>> Can anybody from Xen community express their preference here?
>>>>>
>>>> Oleksandr talked to me on IRC about this, he said a few IOCTLs need to
>>>> be added to either existing drivers or a new driver.
>>>>
>>>> I went through this thread twice and skimmed through the relevant
>>>> documents, but I couldn't see any obvious pros and cons for either
>>>> approach. So I don't really have an opinion on this.
>>>>
>>>> But, assuming if implemented in existing drivers, those IOCTLs need to
>>>> be added to different drivers, which means userspace program needs to
>>>> write more code and get more handles, it would be slightly better to
>>>> implement a new driver from that perspective.
>>> If gntdev/balloon extension is still considered:
>>>
>>> All the IOCTLs will be in gntdev driver (in current xen-zcopy
>>> terminology):
>>>   - DRM_ICOTL_XEN_ZCOPY_DUMB_FROM_REFS
>>>   - DRM_IOCTL_XEN_ZCOPY_DUMB_TO_REFS
>>>   - DRM_IOCTL_XEN_ZCOPY_DUMB_WAIT_FREE
>>>
>>> Balloon driver extension, which is needed for contiguous/DMA
>>> buffers, will be to provide new *kernel API*, no UAPI is needed.
>>>
>>
>> So I am obviously a bit late to this thread, but why do you need to add
>> new ioctls to gntdev and balloon? Doesn't this driver manage to do what
>> you want without any extensions?
> 1. I only (may) need to add IOCTLs to gntdev
> 2. balloon driver needs to be extended, so it can allocate
> contiguous (DMA) memory, not IOCTLs/UAPI here, all lives
> in the kernel.
> 3. The reason I need to extend gnttab with new IOCTLs is to
> provide new functionality to create a dma-buf from grant references
> and to produce grant references for a dma-buf. This is what I have as UAPI
> description for xen-zcopy driver:
> 
> 1. DRM_IOCTL_XEN_ZCOPY_DUMB_FROM_REFS
> This will create a DRM dumb buffer from grant references provided
> by the frontend. The intended usage is:
>   - Frontend
>     - creates a dumb/display buffer and allocates memory
>     - grants foreign access to the buffer pages
>     - passes granted references to the backend
>   - Backend
>     - issues DRM_XEN_ZCOPY_DUMB_FROM_REFS ioctl to map
>       granted references and create a dumb buffer
>     - requests handle to fd conversion via DRM_IOCTL_PRIME_HANDLE_TO_FD
>     - requests real HW driver/consumer to import the PRIME buffer with
>       DRM_IOCTL_PRIME_FD_TO_HANDLE
>     - uses handle returned by the real HW driver
>   - at the end:
>     o closes real HW driver's handle with DRM_IOCTL_GEM_CLOSE
>     o closes zero-copy driver's handle with DRM_IOCTL_GEM_CLOSE
>     o closes file descriptor of the exported buffer
> 
> 2. DRM_IOCTL_XEN_ZCOPY_DUMB_TO_REFS
> This will grant references to a dumb/display buffer's memory provided by
> the
> backend. The intended usage is:
>   - Frontend
>     - requests backend to allocate dumb/display buffer and grant references
>       to its pages
>   - Backend
>     - requests real HW driver to create a dumb with
> DRM_IOCTL_MODE_CREATE_DUMB
>     - requests handle to fd conversion via DRM_IOCTL_PRIME_HANDLE_TO_FD
>     - requests zero-copy driver to import the PRIME buffer with
>       DRM_IOCTL_PRIME_FD_TO_HANDLE
>     - issues DRM_XEN_ZCOPY_DUMB_TO_REFS ioctl to
>       grant references to the buffer's memory.
>     - passes grant references to the frontend
>  - at the end:
>     - closes zero-copy driver's handle with DRM_IOCTL_GEM_CLOSE
>     - closes real HW driver's handle with DRM_IOCTL_GEM_CLOSE
>     - closes file descriptor of the imported buffer
> 
> 3. DRM_XEN_ZCOPY_DUMB_WAIT_FREE
> This will block until the dumb buffer with the wait handle provided be
> freed:
> this is needed for synchronization between frontend and backend in case
> frontend provides grant references of the buffer via
> DRM_XEN_ZCOPY_DUMB_FROM_REFS IOCTL and which must be released before
> backend replies with XENDISPL_OP_DBUF_DESTROY response.
> wait_handle must be the same value returned while calling
> DRM_XEN_ZCOPY_DUMB_FROM_REFS IOCTL.
> 
> So, as you can see the above functionality is not covered by the
> existing UAPI
> of the gntdev driver.
> Now, if we change dumb -> dma-buf and remove DRM code (which is only a
> wrapper
> here on top of dma-buf) we get new driver for dma-buf for Xen.
> 
> This is why I have 2 options here: either create a dedicated driver for
> this
> (e.g. re-work xen-zcopy to be DRM independent and put it under
> drivers/xen/xen-dma-buf, for example) or extend the existing gntdev driver
> with the above UAPI + make changes to the balloon driver to provide kernel
> API for DMA buffer allocations.

Which user component would use the new ioctls?

I'm asking because I'm not very fond of adding more linux specific
functions to libgnttab which are not related to a specific Xen version,
but to a kernel version.

So doing this in a separate driver seems to be the better option in
this regard.


Juergen

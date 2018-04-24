Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932621AbeDXKYr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 06:24:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:36216 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932417AbeDXKYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 06:24:46 -0400
Subject: Re: [Xen-devel] [PATCH 0/1] drm/xen-zcopy: Add Xen zero-copy helper
 DRM driver
To: Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>,
        Wei Liu <wei.liu2@citrix.com>, Dongwon Kim <dongwon.kim@intel.com>
Cc: Oleksandr Andrushchenko <andr2000@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Artem Mygaiev <Artem_Mygaiev@epam.com>, konrad.wilk@oracle.com,
        airlied@linux.ie, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        "Potrola, MateuszX" <mateuszx.potrola@intel.com>,
        xen-devel@lists.xenproject.org, daniel.vetter@intel.com,
        Ian Jackson <Ian.Jackson@eu.citrix.com>
References: <76cdc65a-7bb1-9377-7bc5-6164e32f7b5d@gmail.com>
 <20180423115242.ywdwqblj2aseu3fr@citrix.com>
 <61105351-8896-072b-abf0-757c7f6c0edf@gmail.com>
 <ce2ebb5b-fa13-0475-b0fd-6c330277d151@oracle.com>
 <30ddb005-96c8-f47c-2e23-4e0d354e5842@gmail.com>
 <a25a394c-ecf8-d8cf-15b8-eb8cb71d0a02@suse.com>
 <c4c426eb-5a35-1f8f-59f3-350d6e97d89e@gmail.com>
 <6089d701-5221-75b4-38eb-b23bc5dc30cd@suse.com>
 <85fc8f82-6d4d-9343-2737-85b7d7391168@gmail.com>
 <0657bbb5-5cb7-4c63-5490-fbfc7dec1e59@suse.com>
 <20180424100132.5573sg2hhbhpkr7c@citrix.com>
 <b14fd51e-02f2-6039-228e-7dd8be2aebfa@epam.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <ef31824e-e189-2281-f2d8-8568a8a45da4@suse.com>
Date: Tue, 24 Apr 2018 12:24:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <b14fd51e-02f2-6039-228e-7dd8be2aebfa@epam.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/18 12:14, Oleksandr Andrushchenko wrote:
> On 04/24/2018 01:01 PM, Wei Liu wrote:
>> On Tue, Apr 24, 2018 at 11:08:41AM +0200, Juergen Gross wrote:
>>> On 24/04/18 11:03, Oleksandr Andrushchenko wrote:
>>>> On 04/24/2018 11:40 AM, Juergen Gross wrote:
>>>>> On 24/04/18 10:07, Oleksandr Andrushchenko wrote:
>>>>>> On 04/24/2018 10:51 AM, Juergen Gross wrote:
>>>>>>> On 24/04/18 07:43, Oleksandr Andrushchenko wrote:
>>>>>>>> On 04/24/2018 01:41 AM, Boris Ostrovsky wrote:
>>>>>>>>> On 04/23/2018 08:10 AM, Oleksandr Andrushchenko wrote:
>>>>>>>>>> On 04/23/2018 02:52 PM, Wei Liu wrote:
>>>>>>>>>>> On Fri, Apr 20, 2018 at 02:25:20PM +0300, Oleksandr
>>>>>>>>>>> Andrushchenko
>>>>>>>>>>> wrote:
>>>>>>>>>>>>>>          the gntdev.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I think this is generic enough that it could be
>>>>>>>>>>>>>> implemented by a
>>>>>>>>>>>>>> device not tied to Xen. AFAICT the hyper_dma guys also wanted
>>>>>>>>>>>>>> something similar to this.
>>>>>>>>>>>>> You can't just wrap random userspace memory into a dma-buf.
>>>>>>>>>>>>> We've
>>>>>>>>>>>>> just had
>>>>>>>>>>>>> this discussion with kvm/qemu folks, who proposed just
>>>>>>>>>>>>> that, and
>>>>>>>>>>>>> after a
>>>>>>>>>>>>> bit of discussion they'll now try to have a driver which just
>>>>>>>>>>>>> wraps a
>>>>>>>>>>>>> memfd into a dma-buf.
>>>>>>>>>>>> So, we have to decide either we introduce a new driver
>>>>>>>>>>>> (say, under drivers/xen/xen-dma-buf) or extend the existing
>>>>>>>>>>>> gntdev/balloon to support dma-buf use-cases.
>>>>>>>>>>>>
>>>>>>>>>>>> Can anybody from Xen community express their preference here?
>>>>>>>>>>>>
>>>>>>>>>>> Oleksandr talked to me on IRC about this, he said a few IOCTLs
>>>>>>>>>>> need to
>>>>>>>>>>> be added to either existing drivers or a new driver.
>>>>>>>>>>>
>>>>>>>>>>> I went through this thread twice and skimmed through the
>>>>>>>>>>> relevant
>>>>>>>>>>> documents, but I couldn't see any obvious pros and cons for
>>>>>>>>>>> either
>>>>>>>>>>> approach. So I don't really have an opinion on this.
>>>>>>>>>>>
>>>>>>>>>>> But, assuming if implemented in existing drivers, those IOCTLs
>>>>>>>>>>> need to
>>>>>>>>>>> be added to different drivers, which means userspace program
>>>>>>>>>>> needs to
>>>>>>>>>>> write more code and get more handles, it would be slightly
>>>>>>>>>>> better to
>>>>>>>>>>> implement a new driver from that perspective.
>>>>>>>>>> If gntdev/balloon extension is still considered:
>>>>>>>>>>
>>>>>>>>>> All the IOCTLs will be in gntdev driver (in current xen-zcopy
>>>>>>>>>> terminology):
>>>>>>>>>>      - DRM_ICOTL_XEN_ZCOPY_DUMB_FROM_REFS
>>>>>>>>>>      - DRM_IOCTL_XEN_ZCOPY_DUMB_TO_REFS
>>>>>>>>>>      - DRM_IOCTL_XEN_ZCOPY_DUMB_WAIT_FREE
>>>>>>>>>>
>>>>>>>>>> Balloon driver extension, which is needed for contiguous/DMA
>>>>>>>>>> buffers, will be to provide new *kernel API*, no UAPI is needed.
>>>>>>>>>>
>>>>>>>>> So I am obviously a bit late to this thread, but why do you need
>>>>>>>>> to add
>>>>>>>>> new ioctls to gntdev and balloon? Doesn't this driver manage to do
>>>>>>>>> what
>>>>>>>>> you want without any extensions?
>>>>>>>> 1. I only (may) need to add IOCTLs to gntdev
>>>>>>>> 2. balloon driver needs to be extended, so it can allocate
>>>>>>>> contiguous (DMA) memory, not IOCTLs/UAPI here, all lives
>>>>>>>> in the kernel.
>>>>>>>> 3. The reason I need to extend gnttab with new IOCTLs is to
>>>>>>>> provide new functionality to create a dma-buf from grant references
>>>>>>>> and to produce grant references for a dma-buf. This is what I
>>>>>>>> have as
>>>>>>>> UAPI
>>>>>>>> description for xen-zcopy driver:
>>>>>>>>
>>>>>>>> 1. DRM_IOCTL_XEN_ZCOPY_DUMB_FROM_REFS
>>>>>>>> This will create a DRM dumb buffer from grant references provided
>>>>>>>> by the frontend. The intended usage is:
>>>>>>>>      - Frontend
>>>>>>>>        - creates a dumb/display buffer and allocates memory
>>>>>>>>        - grants foreign access to the buffer pages
>>>>>>>>        - passes granted references to the backend
>>>>>>>>      - Backend
>>>>>>>>        - issues DRM_XEN_ZCOPY_DUMB_FROM_REFS ioctl to map
>>>>>>>>          granted references and create a dumb buffer
>>>>>>>>        - requests handle to fd conversion via
>>>>>>>> DRM_IOCTL_PRIME_HANDLE_TO_FD
>>>>>>>>        - requests real HW driver/consumer to import the PRIME
>>>>>>>> buffer
>>>>>>>> with
>>>>>>>>          DRM_IOCTL_PRIME_FD_TO_HANDLE
>>>>>>>>        - uses handle returned by the real HW driver
>>>>>>>>      - at the end:
>>>>>>>>        o closes real HW driver's handle with DRM_IOCTL_GEM_CLOSE
>>>>>>>>        o closes zero-copy driver's handle with DRM_IOCTL_GEM_CLOSE
>>>>>>>>        o closes file descriptor of the exported buffer
>>>>>>>>
>>>>>>>> 2. DRM_IOCTL_XEN_ZCOPY_DUMB_TO_REFS
>>>>>>>> This will grant references to a dumb/display buffer's memory
>>>>>>>> provided by
>>>>>>>> the
>>>>>>>> backend. The intended usage is:
>>>>>>>>      - Frontend
>>>>>>>>        - requests backend to allocate dumb/display buffer and grant
>>>>>>>> references
>>>>>>>>          to its pages
>>>>>>>>      - Backend
>>>>>>>>        - requests real HW driver to create a dumb with
>>>>>>>> DRM_IOCTL_MODE_CREATE_DUMB
>>>>>>>>        - requests handle to fd conversion via
>>>>>>>> DRM_IOCTL_PRIME_HANDLE_TO_FD
>>>>>>>>        - requests zero-copy driver to import the PRIME buffer with
>>>>>>>>          DRM_IOCTL_PRIME_FD_TO_HANDLE
>>>>>>>>        - issues DRM_XEN_ZCOPY_DUMB_TO_REFS ioctl to
>>>>>>>>          grant references to the buffer's memory.
>>>>>>>>        - passes grant references to the frontend
>>>>>>>>     - at the end:
>>>>>>>>        - closes zero-copy driver's handle with DRM_IOCTL_GEM_CLOSE
>>>>>>>>        - closes real HW driver's handle with DRM_IOCTL_GEM_CLOSE
>>>>>>>>        - closes file descriptor of the imported buffer
>>>>>>>>
>>>>>>>> 3. DRM_XEN_ZCOPY_DUMB_WAIT_FREE
>>>>>>>> This will block until the dumb buffer with the wait handle
>>>>>>>> provided be
>>>>>>>> freed:
>>>>>>>> this is needed for synchronization between frontend and backend in
>>>>>>>> case
>>>>>>>> frontend provides grant references of the buffer via
>>>>>>>> DRM_XEN_ZCOPY_DUMB_FROM_REFS IOCTL and which must be released
>>>>>>>> before
>>>>>>>> backend replies with XENDISPL_OP_DBUF_DESTROY response.
>>>>>>>> wait_handle must be the same value returned while calling
>>>>>>>> DRM_XEN_ZCOPY_DUMB_FROM_REFS IOCTL.
>>>>>>>>
>>>>>>>> So, as you can see the above functionality is not covered by the
>>>>>>>> existing UAPI
>>>>>>>> of the gntdev driver.
>>>>>>>> Now, if we change dumb -> dma-buf and remove DRM code (which is
>>>>>>>> only a
>>>>>>>> wrapper
>>>>>>>> here on top of dma-buf) we get new driver for dma-buf for Xen.
>>>>>>>>
>>>>>>>> This is why I have 2 options here: either create a dedicated driver
>>>>>>>> for
>>>>>>>> this
>>>>>>>> (e.g. re-work xen-zcopy to be DRM independent and put it under
>>>>>>>> drivers/xen/xen-dma-buf, for example) or extend the existing gntdev
>>>>>>>> driver
>>>>>>>> with the above UAPI + make changes to the balloon driver to provide
>>>>>>>> kernel
>>>>>>>> API for DMA buffer allocations.
>>>>>>> Which user component would use the new ioctls?
>>>>>> It is currently used by the display backend [1] and will
>>>>>> probably be used by the hyper-dmabuf frontend/backend
>>>>>> (Dongwon from Intel can provide more info on this).
>>>>>>> I'm asking because I'm not very fond of adding more linux specific
>>>>>>> functions to libgnttab which are not related to a specific Xen
>>>>>>> version,
>>>>>>> but to a kernel version.
>>>>>> Hm, I was not thinking about this UAPI to be added to libgnttab.
>>>>>> It seems it can be used directly w/o wrappers in user-space
>>>>> Would this program use libgnttab in parallel?
>>>> In case of the display backend - yes, for shared rings,
>>>> extracting grefs from displif protocol it uses gntdev via
>>>> helper library [1]
>>>>>    If yes how would the two
>>>>> usage paths be combined (same applies to the separate driver, btw)?
>>>>> The
>>>>> gntdev driver manages resources per file descriptor and libgnttab is
>>>>> hiding the file descriptor it is using for a connection.
>>>> Ah, at the moment the UAPI was not used in parallel as there were
>>>> 2 drivers for that: gntdev + xen-zcopy with different UAPIs.
>>>> But now, if we extend gntdev with the new API then you are rigth:
>>>> either libgnttab needs to be extended or that new part of the
>>>> gntdev UAPI needs to be open-coded by the backend
>>>>>    Or would the
>>>>> user program use only the new driver for communicating with the gntdev
>>>>> driver? In this case it might be an option to extend the gntdev driver
>>>>> to present a new device (e.g. "gntdmadev") for that purpose.
>>>> No, it seems that libgnttab and this new driver's UAPI will be used
>>>> in parallel
>>>>>>> So doing this in a separate driver seems to be the better option in
>>>>>>> this regard.
>>>>>> Well, from maintenance POV it is easier for me to have it all in
>>>>>> a separate driver as all dma-buf related functionality will
>>>>>> reside at one place. This also means that no changes to existing
>>>>>> drivers will be needed (if it is ok to have ballooning in/out
>>>>>> code for DMA buffers (allocated with dma_alloc_xxx) not in the
>>>>>> balloon
>>>>>> driver)
>>>>> I think in the end this really depends on how the complete solution
>>>>> will look like. gntdev is a special wrapper for the gnttab driver.
>>>>> In case the new dma-buf driver needs to use parts of gntdev I'd rather
>>>>> have a new driver above gnttab ("gntuser"?) used by gntdev and
>>>>> dma-buf.
>>>> The new driver doesn't use gntdev's existing API, but extends it,
>>>> e.g. by adding new ways to export/import grefs for a dma-buf and
>>>> manage dma-buf's kernel ops. Thus, gntdev, which already provides
>>>> UAPI, seems to be a good candidate for such an extension
>>> So this would mean you need a modification of libgnttab, right? This is
>>> something the Xen tools maintainers need to decide. In case they don't
>>> object extending the gntdev driver would be the natural thing to do.
>>>
>> That should be fine. Most of libgnttab does is to wrap existing kernel
>> interfaces and expose them sensibly to user space programs. If gnttab
>> device is extended, libgnttab should be extended accordingly. If a new
>> device is created, a new library should be added. Either way there will
>> be new toolstack code involved, which is not a problem in general.
> Great, so finally I see the following approach to have generic
> dma-buf use-cases support for Xen (which can be used for many purposes,
> e.g. GPU/DRM buffer sharing, V4L, hyper-dmabuf etc.):
> 
> 1. Extend Linux gntdev driver to support 3 new IOCTLs discussed previously
> 2. Extend libgnttab to provide UAPI for those - Linux only as dma-buf
> is a Linux thing
> 3. Extend kernel API of the Linux balloon driver to allow dma_alloc_xxx way
> of memory allocations
> 
> If the above looks ok, then I can start prototyping, so we can discuss
> implementation details

Fine for me.


Juergen

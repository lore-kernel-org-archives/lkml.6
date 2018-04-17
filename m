Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752597AbeDQIVC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 04:21:02 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34241 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbeDQITZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 04:19:25 -0400
X-Google-Smtp-Source: AIpwx4/ur0Psqd1vCNS7jnwFe5clomikG8X2aJlTPlAkWZvk+/g6lkXhtP9HH2bym+uFbMnbn6YyNQ==
Subject: Re: [PATCH 0/1] drm/xen-zcopy: Add Xen zero-copy helper DRM driver
To: Dongwon Kim <dongwon.kim@intel.com>, jgross@suse.com,
        Artem Mygaiev <Artem_Mygaiev@epam.com>, konrad.wilk@oracle.com,
        airlied@linux.ie,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        "Potrola, MateuszX" <mateuszx.potrola@intel.com>,
        daniel.vetter@intel.com, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
References: <20180329131931.29957-1-andr2000@gmail.com>
 <5d8fec7f-956c-378f-be90-f45029385740@gmail.com>
 <20180416192905.GA18096@downor-Z87X-UD5H>
 <20180417075928.GT31310@phenom.ffwll.local>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <be725bee-21ed-6ae2-8b6f-2d7f8101ed4a@gmail.com>
Date: Tue, 17 Apr 2018 11:19:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180417075928.GT31310@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/17/2018 10:59 AM, Daniel Vetter wrote:
> On Mon, Apr 16, 2018 at 12:29:05PM -0700, Dongwon Kim wrote:
>> Yeah, I definitely agree on the idea of expanding the use case to the
>> general domain where dmabuf sharing is used. However, what you are
>> targetting with proposed changes is identical to the core design of
>> hyper_dmabuf.
>>
>> On top of this basic functionalities, hyper_dmabuf has driver level
>> inter-domain communication, that is needed for dma-buf remote tracking
>> (no fence forwarding though), event triggering and event handling, extra
>> meta data exchange and hyper_dmabuf_id that represents grefs
>> (grefs are shared implicitly on driver level)
> This really isn't a positive design aspect of hyperdmabuf imo. The core
> code in xen-zcopy (ignoring the ioctl side, which will be cleaned up) is
> very simple & clean.
>
> If there's a clear need later on we can extend that. But for now xen-zcopy
> seems to cover the basic use-case needs, so gets the job done.
After we decided to remove DRM PRIME code from the zcopy driver
I think we can extend the existing Xen drivers instead of introducing
a new one:
gntdev [1], [2] - to handle export/import of the dma-bufs to/from grefs
balloon [3] - to allow allocating CMA buffers
>> Also it is designed with frontend (common core framework) + backend
>> (hyper visor specific comm and memory sharing) structure for portability.
>> We just can't limit this feature to Xen because we want to use the same
>> uapis not only for Xen but also other applicable hypervisor, like ACORN.
> See the discussion around udmabuf and the needs for kvm. I think trying to
> make an ioctl/uapi that works for multiple hypervisors is misguided - it
> likely won't work.
>
> On top of that the 2nd hypervisor you're aiming to support is ACRN. That's
> not even upstream yet, nor have I seen any patches proposing to land linux
> support for ACRN. Since it's not upstream, it doesn't really matter for
> upstream consideration. I'm doubting that ACRN will use the same grant
> references as xen, so the same uapi won't work on ACRN as on Xen anyway.
>
>> So I am wondering we can start with this hyper_dmabuf then modify it for
>> your use-case if needed and polish and fix any glitches if we want to
>> to use this for all general dma-buf usecases.
> Imo xen-zcopy is a much more reasonable starting point for upstream, which
> can then be extended (if really proven to be necessary).
>
>> Also, I still have one unresolved question regarding the export/import flow
>> in both of hyper_dmabuf and xen-zcopy.
>>
>> @danvet: Would this flow (guest1->import existing dmabuf->share underlying
>> pages->guest2->map shared pages->create/export dmabuf) be acceptable now?
> I think if you just look at the pages, and make sure you handle the
> sg_page == NULL case it's ok-ish. It's not great, but mostly it should
> work. The real trouble with hyperdmabuf was the forwarding of all these
> calls, instead of just passing around a list of grant references.
> -Daniel
>
>> Regards,
>> DW
>>   
>> On Mon, Apr 16, 2018 at 05:33:46PM +0300, Oleksandr Andrushchenko wrote:
>>> Hello, all!
>>>
>>> After discussing xen-zcopy and hyper-dmabuf [1] approaches
Even more context for the discussion [4], so Xen community can
catch up
>>> it seems that xen-zcopy can be made not depend on DRM core any more
>>>
>>> and be dma-buf centric (which it in fact is).
>>>
>>> The DRM code was mostly there for dma-buf's FD import/export
>>>
>>> with DRM PRIME UAPI and with DRM use-cases in mind, but it comes out that if
>>>
>>> the proposed 2 IOCTLs (DRM_XEN_ZCOPY_DUMB_FROM_REFS and
>>> DRM_XEN_ZCOPY_DUMB_TO_REFS)
>>>
>>> are extended to also provide a file descriptor of the corresponding dma-buf,
>>> then
>>>
>>> PRIME stuff in the driver is not needed anymore.
>>>
>>> That being said, xen-zcopy can safely be detached from DRM and moved from
>>>
>>> drivers/gpu/drm/xen into drivers/xen/dma-buf-backend(?).
>>>
>>> This driver then becomes a universal way to turn any shared buffer between
>>> Dom0/DomD
>>>
>>> and DomU(s) into a dma-buf, e.g. one can create a dma-buf from any grant
>>> references
>>>
>>> or represent a dma-buf as grant-references for export.
>>>
>>> This way the driver can be used not only for DRM use-cases, but also for
>>> other
>>>
>>> use-cases which may require zero copying between domains.
>>>
>>> For example, the use-cases we are about to work in the nearest future will
>>> use
>>>
>>> V4L, e.g. we plan to support cameras, codecs etc. and all these will benefit
>>>
>>> from zero copying much. Potentially, even block/net devices may benefit,
>>>
>>> but this needs some evaluation.
>>>
>>>
>>> I would love to hear comments for authors of the hyper-dmabuf
>>>
>>> and Xen community, as well as DRI-Devel and other interested parties.
>>>
>>>
>>> Thank you,
>>>
>>> Oleksandr
>>>
>>>
>>> On 03/29/2018 04:19 PM, Oleksandr Andrushchenko wrote:
>>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>>
>>>> Hello!
>>>>
>>>> When using Xen PV DRM frontend driver then on backend side one will need
>>>> to do copying of display buffers' contents (filled by the
>>>> frontend's user-space) into buffers allocated at the backend side.
>>>> Taking into account the size of display buffers and frames per seconds
>>>> it may result in unneeded huge data bus occupation and performance loss.
>>>>
>>>> This helper driver allows implementing zero-copying use-cases
>>>> when using Xen para-virtualized frontend display driver by
>>>> implementing a DRM/KMS helper driver running on backend's side.
>>>> It utilizes PRIME buffers API to share frontend's buffers with
>>>> physical device drivers on backend's side:
>>>>
>>>>   - a dumb buffer created on backend's side can be shared
>>>>     with the Xen PV frontend driver, so it directly writes
>>>>     into backend's domain memory (into the buffer exported from
>>>>     DRM/KMS driver of a physical display device)
>>>>   - a dumb buffer allocated by the frontend can be imported
>>>>     into physical device DRM/KMS driver, thus allowing to
>>>>     achieve no copying as well
>>>>
>>>> For that reason number of IOCTLs are introduced:
>>>>   -  DRM_XEN_ZCOPY_DUMB_FROM_REFS
>>>>      This will create a DRM dumb buffer from grant references provided
>>>>      by the frontend
>>>>   - DRM_XEN_ZCOPY_DUMB_TO_REFS
>>>>     This will grant references to a dumb/display buffer's memory provided
>>>>     by the backend
>>>>   - DRM_XEN_ZCOPY_DUMB_WAIT_FREE
>>>>     This will block until the dumb buffer with the wait handle provided
>>>>     be freed
>>>>
>>>> With this helper driver I was able to drop CPU usage from 17% to 3%
>>>> on Renesas R-Car M3 board.
>>>>
>>>> This was tested with Renesas' Wayland-KMS and backend running as DRM master.
>>>>
>>>> Thank you,
>>>> Oleksandr
>>>>
>>>> Oleksandr Andrushchenko (1):
>>>>    drm/xen-zcopy: Add Xen zero-copy helper DRM driver
>>>>
>>>>   Documentation/gpu/drivers.rst               |   1 +
>>>>   Documentation/gpu/xen-zcopy.rst             |  32 +
>>>>   drivers/gpu/drm/xen/Kconfig                 |  25 +
>>>>   drivers/gpu/drm/xen/Makefile                |   5 +
>>>>   drivers/gpu/drm/xen/xen_drm_zcopy.c         | 880 ++++++++++++++++++++++++++++
>>>>   drivers/gpu/drm/xen/xen_drm_zcopy_balloon.c | 154 +++++
>>>>   drivers/gpu/drm/xen/xen_drm_zcopy_balloon.h |  38 ++
>>>>   include/uapi/drm/xen_zcopy_drm.h            | 129 ++++
>>>>   8 files changed, 1264 insertions(+)
>>>>   create mode 100644 Documentation/gpu/xen-zcopy.rst
>>>>   create mode 100644 drivers/gpu/drm/xen/xen_drm_zcopy.c
>>>>   create mode 100644 drivers/gpu/drm/xen/xen_drm_zcopy_balloon.c
>>>>   create mode 100644 drivers/gpu/drm/xen/xen_drm_zcopy_balloon.h
>>>>   create mode 100644 include/uapi/drm/xen_zcopy_drm.h
>>>>
>>> [1]
>>> https://lists.xenproject.org/archives/html/xen-devel/2018-02/msg01202.html
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
[1] 
https://elixir.bootlin.com/linux/v4.17-rc1/source/include/uapi/xen/gntdev.h
[2] https://elixir.bootlin.com/linux/v4.17-rc1/source/drivers/xen/gntdev.c
[3] https://elixir.bootlin.com/linux/v4.17-rc1/source/drivers/xen/balloon.c
[4] https://lkml.org/lkml/2018/4/16/355

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbeDSION (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 04:14:13 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:46695 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbeDSIOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 04:14:07 -0400
X-Google-Smtp-Source: AIpwx4+UPC7Q4Xjeb2ObxhGC2QQMB3S26xN/Z5lbYk+d4eONzRB+dg0+BGqGJcfrZ55cOhMQ7GMimg==
Subject: Re: [PATCH 0/1] drm/xen-zcopy: Add Xen zero-copy helper DRM driver
To: Dongwon Kim <dongwon.kim@intel.com>
Cc: "Oleksandr_Andrushchenko@epam.com" <Oleksandr_Andrushchenko@epam.com>,
        jgross@suse.com, Artem Mygaiev <Artem_Mygaiev@epam.com>,
        konrad.wilk@oracle.com, airlied@linux.ie, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        "Potrola, MateuszX" <mateuszx.potrola@intel.com>,
        daniel.vetter@intel.com, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com, Matt Roper <matthew.d.roper@intel.com>
References: <20180329131931.29957-1-andr2000@gmail.com>
 <5d8fec7f-956c-378f-be90-f45029385740@gmail.com>
 <20180416192905.GA18096@downor-Z87X-UD5H>
 <20180417075928.GT31310@phenom.ffwll.local>
 <20180417205744.GA15930@downor-Z87X-UD5H>
 <41487acb-a67a-8933-d0c3-702c19b0938e@gmail.com>
 <20180418170148.GB20588@downor-Z87X-UD5H>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <fd9f60ea-5011-57c2-4bdf-661763c736b0@gmail.com>
Date: Thu, 19 Apr 2018 11:14:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180418170148.GB20588@downor-Z87X-UD5H>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/18/2018 08:01 PM, Dongwon Kim wrote:
> On Wed, Apr 18, 2018 at 09:38:39AM +0300, Oleksandr Andrushchenko wrote:
>> On 04/17/2018 11:57 PM, Dongwon Kim wrote:
>>> On Tue, Apr 17, 2018 at 09:59:28AM +0200, Daniel Vetter wrote:
>>>> On Mon, Apr 16, 2018 at 12:29:05PM -0700, Dongwon Kim wrote:
>>>>> Yeah, I definitely agree on the idea of expanding the use case to the
>>>>> general domain where dmabuf sharing is used. However, what you are
>>>>> targetting with proposed changes is identical to the core design of
>>>>> hyper_dmabuf.
>>>>>
>>>>> On top of this basic functionalities, hyper_dmabuf has driver level
>>>>> inter-domain communication, that is needed for dma-buf remote tracking
>>>>> (no fence forwarding though), event triggering and event handling, extra
>>>>> meta data exchange and hyper_dmabuf_id that represents grefs
>>>>> (grefs are shared implicitly on driver level)
>>>> This really isn't a positive design aspect of hyperdmabuf imo. The core
>>>> code in xen-zcopy (ignoring the ioctl side, which will be cleaned up) is
>>>> very simple & clean.
>>>>
>>>> If there's a clear need later on we can extend that. But for now xen-zcopy
>>>> seems to cover the basic use-case needs, so gets the job done.
>>>>
>>>>> Also it is designed with frontend (common core framework) + backend
>>>>> (hyper visor specific comm and memory sharing) structure for portability.
>>>>> We just can't limit this feature to Xen because we want to use the same
>>>>> uapis not only for Xen but also other applicable hypervisor, like ACORN.
>>>> See the discussion around udmabuf and the needs for kvm. I think trying to
>>>> make an ioctl/uapi that works for multiple hypervisors is misguided - it
>>>> likely won't work.
>>>>
>>>> On top of that the 2nd hypervisor you're aiming to support is ACRN. That's
>>>> not even upstream yet, nor have I seen any patches proposing to land linux
>>>> support for ACRN. Since it's not upstream, it doesn't really matter for
>>>> upstream consideration. I'm doubting that ACRN will use the same grant
>>>> references as xen, so the same uapi won't work on ACRN as on Xen anyway.
>>> Yeah, ACRN doesn't have grant-table. Only Xen supports it. But that is why
>>> hyper_dmabuf has been architectured with the concept of backend.
>>> If you look at the structure of backend, you will find that
>>> backend is just a set of standard function calls as shown here:
>>>
>>> struct hyper_dmabuf_bknd_ops {
>>>          /* backend initialization routine (optional) */
>>>          int (*init)(void);
>>>
>>>          /* backend cleanup routine (optional) */
>>>          int (*cleanup)(void);
>>>
>>>          /* retreiving id of current virtual machine */
>>>          int (*get_vm_id)(void);
>>>
>>>          /* get pages shared via hypervisor-specific method */
>>>          int (*share_pages)(struct page **pages, int vm_id,
>>>                             int nents, void **refs_info);
>>>
>>>          /* make shared pages unshared via hypervisor specific method */
>>>          int (*unshare_pages)(void **refs_info, int nents);
>>>
>>>          /* map remotely shared pages on importer's side via
>>>           * hypervisor-specific method
>>>           */
>>>          struct page ** (*map_shared_pages)(unsigned long ref, int vm_id,
>>>                                             int nents, void **refs_info);
>>>
>>>          /* unmap and free shared pages on importer's side via
>>>           * hypervisor-specific method
>>>           */
>>>          int (*unmap_shared_pages)(void **refs_info, int nents);
>>>
>>>          /* initialize communication environment */
>>>          int (*init_comm_env)(void);
>>>
>>>          void (*destroy_comm)(void);
>>>
>>>          /* upstream ch setup (receiving and responding) */
>>>          int (*init_rx_ch)(int vm_id);
>>>
>>>          /* downstream ch setup (transmitting and parsing responses) */
>>>          int (*init_tx_ch)(int vm_id);
>>>
>>>          int (*send_req)(int vm_id, struct hyper_dmabuf_req *req, int wait);
>>> };
>>>
>>> All of these can be mapped with any hypervisor specific implementation.
>>> We designed backend implementation for Xen using grant-table, Xen event
>>> and ring buffer communication. For ACRN, we have another backend using Virt-IO
>>> for both memory sharing and communication.
>>>
>>> We tried to define this structure of backend to make it general enough (or
>>> it can be even modified or extended to support more cases.) so that it can
>>> fit to other hypervisor cases. Only requirements/expectation on the hypervisor
>>> are page-level memory sharing and inter-domain communication, which I think
>>> are standard features of modern hypervisor.
>>>
>>> And please review common UAPIs that hyper_dmabuf and xen-zcopy supports. They
>>> are very general. One is getting FD (dmabuf) and get those shared. The other
>>> is generating dmabuf from global handle (secure handle hiding gref behind it).
>>> On top of this, hyper_dmabuf has "unshare" and "query" which are also useful
>>> for any cases.
>>>
>>> So I don't know why we wouldn't want to try to make these standard in most of
>>> hypervisor cases instead of limiting it to certain hypervisor like Xen.
>>> Frontend-backend structre is optimal for this I think.
>>>
>>>>> So I am wondering we can start with this hyper_dmabuf then modify it for
>>>>> your use-case if needed and polish and fix any glitches if we want to
>>>>> to use this for all general dma-buf usecases.
>>>> Imo xen-zcopy is a much more reasonable starting point for upstream, which
>>>> can then be extended (if really proven to be necessary).
>>>>
>>>>> Also, I still have one unresolved question regarding the export/import flow
>>>>> in both of hyper_dmabuf and xen-zcopy.
>>>>>
>>>>> @danvet: Would this flow (guest1->import existing dmabuf->share underlying
>>>>> pages->guest2->map shared pages->create/export dmabuf) be acceptable now?
>>>> I think if you just look at the pages, and make sure you handle the
>>>> sg_page == NULL case it's ok-ish. It's not great, but mostly it should
>>>> work. The real trouble with hyperdmabuf was the forwarding of all these
>>>> calls, instead of just passing around a list of grant references.
>>> I talked to danvet about this litte bit.
>>>
>>> I think there was some misunderstanding on this "forwarding". Exporting
>>> and importing flow in hyper_dmabuf are basically same as xen-zcopy's. I think
>>> what made confusion was that importing domain notifies exporting domain when
>>> there are dmabuf operations (like attach, mapping, detach and release) so that
>>> exporting domain can track the usage of dmabuf on the importing domain.
>>>
>>> I designed this for some basic tracking. We may not need to notify for every
>>> different activity but if none of them is there, exporting domain can't
>>> determine if it is ok to unshare the buffer or the originator (like i915)
>>> can free the object even if it's being accessed in importing domain.
>>>
>>> Anyway I really hope we can have enough discussion and resolve all concerns
>>> before nailing it down.
>> Let me explain how this works in case of para-virtual display
>> use-case with xen-zcopy.
>>
>> 1. There are 4 components in the system:
>>    - displif protocol [1]
>>    - xen-front - para-virtual DRM driver running in DomU (Guest) VM
>>    - backend - user-space application running in Dom0
>>    - xen-zcopy - DRM (as of now) helper driver running in Dom0
>>
>> 2. All the communication between domains happens between xen-front and the
>> backend, so it is possible to implement para-virtual display use-case
>> without xen-zcopy at all (this is why it is a helper driver), but in this
>> case
>> memory copying occurs (this is out of scope for this discussion).
>>
>> 3. To better understand security issues let's see what use-cases we have:
>>
>> 3.1 xen-front exports its dma-buf (dumb) to the backend
>>
>> In this case there are no security issues at all as Dom0 (backend side)
>> will use DomU's pages (xen-front side) and Dom0 is a trusted domain, so
>> we assume it won't hurt DomU. Even if DomU dies nothing bad happens to Dom0.
>> If DomU misbehaves it can only write to its own pages shared with Dom0, but
>> still
>> cannot go beyond that, e.g. it can't access Dom0's memory.
>>
>> 3.2 Backend exports dma-buf to xen-front
>>
>> In this case Dom0 pages are shared with DomU. As before, DomU can only write
>> to these pages, not any other page from Dom0, so it can be still considered
>> safe.
>> But, the following must be considered (highlighted in xen-front's Kernel
>> documentation):
>>   - If guest domain dies then pages/grants received from the backend cannot
>>     be claimed back - think of it as memory lost to Dom0 (won't be used for
>> any
>>     other guest)
>>   - Misbehaving guest may send too many requests to the backend exhausting
>>     its grant references and memory (consider this from security POV). As the
>>     backend runs in the trusted domain we also assume that it is trusted as
>> well,
>>     e.g. must take measures to prevent DDoS attacks.
>>
> There is another security issue that this driver itself can cause. Using the
> grant-reference as is is not very safe because it's easy to guess (counting
> number probably) and any attackers running on the same importing domain can
> use these references to map shared pages and access the data. This is why we
> implemented "hyper_dmabuf_id" that contains 96 bit random number to make it
> almost impossible to guess.
Yes, there is something to think about in general, not related
to dma-buf/zcopy. This is a question to Xen community what they
see as the right approach here.
>   All grant references for pages are shared in the
> driver level. This is another reason for having inter-VM comm.
>
>> 4. xen-front/backend/xen-zcopy synchronization
>>
>> 4.1. As I already said in 2) all the inter VM communication happens between
>> xen-front and the backend, xen-zcopy is NOT involved in that.
> Yeah, understood but this is also my point. Both hyper_dmabuf and xen-zcopy
> is a driver that expands dmabuf sharing to inter-VM level. Then shouldn't this
> driver itself provide some way to synchronize between two VMs?
No, because xen-zcopy is a *helper* driver, not more.
>   I think the
> assumption behind this is that Xen PV display interface and backend (running
> on the userspace) are used together with xen-zcopy
Backend may use xen-zcopy or may not - it depends if you need
zero copy or not, e.g. it is not a must for the backend
> but what if an user space
> just want to use xen-zcopy separately? Since it exposes ioctls, this is
> possible unless you add some dependency configuration there.
It is possible, any backend (user-space application) can use xen-zcopy
Even more, one can extend it to provide kernel side API
>
>> When xen-front wants to destroy a display buffer (dumb/dma-buf) it issues a
>> XENDISPL_OP_DBUF_DESTROY command (opposite to XENDISPL_OP_DBUF_CREATE).
>> This call is synchronous, so xen-front expects that backend does free the
>> buffer pages on return.
> Does it mean importing domain (dom0 assuming we do domU -> dom0 dmabuf
> exporting) makes a destory request to the exporting VM?
No, the requester is always DomU, so "destroy buffer" request
will always come from DomU
>   But isn't it
> the domU to make such decision since it's the owner of buffer.
See above
>
> And what about the other way around? For example, what happens if the
> originator of buffer (like i915) decides to free the object behind dmabuf?
For that reason there is ref-counting for dma-buf, e.g.
if i915 decides to free then the backend (in my case) still holds
the buffer, thus not allowing it do disappear. Basically, this is
the backend which creates dma-buf from refs and owns it.
> Would i915 or exporting side of xen-zcopy know whether dom0 currently
> uses the dmabuf or not?
Why do you need this to know (probably I don't understand the use-case).
I could be obvious here, but if ref-count of the dma-buf is not zero
it is still exists and used?
>
> And again, I think this tracking should be handled in the driver itself
> implicitly without any userspace involvement if we want to this dmabuf
> sharing exist as a generic feature.
Why not allow dma-buf Linux framework do that for you?
>
>> 4.2. Backend, on XENDISPL_OP_DBUF_DESTROY:
>>    - closes all dumb handles/fd's of the buffer according to [3]
>>    - issues DRM_IOCTL_XEN_ZCOPY_DUMB_WAIT_FREE IOCTL to xen-zcopy to make
>> sure
>>      the buffer is freed (think of it as it waits for dma-buf->release
>> callback)
>>    - replies to xen-front that the buffer can be destroyed.
>> This way deletion of the buffer happens synchronously on both Dom0 and DomU
>> sides. In case if DRM_IOCTL_XEN_ZCOPY_DUMB_WAIT_FREE returns with time-out
>> error
>> (BTW, wait time is a parameter of this IOCTL), Xen will defer grant
>> reference
>> removal and will retry later until those are free.
>>
>> Hope this helps understand how buffers are synchronously deleted in case
>> of xen-zcopy with a single protocol command.
>>
>> I think the above logic can also be re-used by the hyper-dmabuf driver with
>> some additional work:
>>
>> 1. xen-zcopy can be split into 2 parts and extend:
>> 1.1. Xen gntdev driver [4], [5] to allow creating dma-buf from grefs and
>> vise versa,
>> implement "wait" ioctl (wait for dma-buf->release): currently these are
>> DRM_XEN_ZCOPY_DUMB_FROM_REFS, DRM_XEN_ZCOPY_DUMB_TO_REFS and
>> DRM_XEN_ZCOPY_DUMB_WAIT_FREE
>> 1.2. Xen balloon driver [6] to allow allocating contiguous buffers (not
>> needed
>> by current hyper-dmabuf, but is a must for xen-zcopy use-cases)
> Not sure how to match our use case to xen-zcopy's case but we don't do alloc
> /free all the time.
We also don't
>   Also, dom0 won't make any freeing request to domU since it
> doesn't own the buffer. It only follows dmabuf protocol as such attach/detach
> /release,
Similar here
>   which are tracked by domU (exporting VM). And for destruction of
> sharing, we have separate IOCTL for that, which revoke grant references "IF"
> there is no drivers attached to the dmabuf in dom0. Otherwise, it schedules
> destruction of sharing until it gets final dmabuf release message from dom0.
We block instead with 3sec timeout + some other logic
(out of context now)
>
> Also, in our usecase, (although we didn't intend to do so) it ends up using
> 3~4 buffers repeately.
2-3 in our use-cases
> This is because DRM in domU (that renders) doesn't
> allocate more object for EGL image since there is always free objects used
> before exist in the list. And we actually don't do full-path exporting
> (extracting pages -> grant-references -> get those shared) all the time.
> If the same dmabuf is exported already, we just update private message then
> notifies dom0 (reason for hash tables for keeping exported and importer
> dmabufs).
In my case these 2-3 buffers are allocated at start and not freed
until the end - these are used as frame buffers which are constantly
flipped. So, in my case there is no much profit in trying to cache
which adds unneeded complexity (in my use-case, of course).
If those 3-4 buffers you allocate are the only buffers used you may
also try going without caching, but this depends on your use-case

>> 2. Then hyper-dmabuf uses Xen gntdev driver for Xen specific dma-buf
>> alloc/free/wait
>>
>> 3. hyper-dmabuf uses its own protocol between VMs to communicate buffer
>> creation/deletion and whatever else is needed (fences?).
>>
>> To Xen community: please think of dma-buf here as of a buffer representation
>> mechanism,
>> e.g. at the end of the day it's just a set of pages.
>>
>> Thank you,
>> Oleksandr
>>>> -Daniel
>>>>
>>>>> Regards,
>>>>> DW
>>>>> On Mon, Apr 16, 2018 at 05:33:46PM +0300, Oleksandr Andrushchenko wrote:
>>>>>> Hello, all!
>>>>>>
>>>>>> After discussing xen-zcopy and hyper-dmabuf [1] approaches
>>>>>>
>>>>>> it seems that xen-zcopy can be made not depend on DRM core any more
>>>>>>
>>>>>> and be dma-buf centric (which it in fact is).
>>>>>>
>>>>>> The DRM code was mostly there for dma-buf's FD import/export
>>>>>>
>>>>>> with DRM PRIME UAPI and with DRM use-cases in mind, but it comes out that if
>>>>>>
>>>>>> the proposed 2 IOCTLs (DRM_XEN_ZCOPY_DUMB_FROM_REFS and
>>>>>> DRM_XEN_ZCOPY_DUMB_TO_REFS)
>>>>>>
>>>>>> are extended to also provide a file descriptor of the corresponding dma-buf,
>>>>>> then
>>>>>>
>>>>>> PRIME stuff in the driver is not needed anymore.
>>>>>>
>>>>>> That being said, xen-zcopy can safely be detached from DRM and moved from
>>>>>>
>>>>>> drivers/gpu/drm/xen into drivers/xen/dma-buf-backend(?).
>>>>>>
>>>>>> This driver then becomes a universal way to turn any shared buffer between
>>>>>> Dom0/DomD
>>>>>>
>>>>>> and DomU(s) into a dma-buf, e.g. one can create a dma-buf from any grant
>>>>>> references
>>>>>>
>>>>>> or represent a dma-buf as grant-references for export.
>>>>>>
>>>>>> This way the driver can be used not only for DRM use-cases, but also for
>>>>>> other
>>>>>>
>>>>>> use-cases which may require zero copying between domains.
>>>>>>
>>>>>> For example, the use-cases we are about to work in the nearest future will
>>>>>> use
>>>>>>
>>>>>> V4L, e.g. we plan to support cameras, codecs etc. and all these will benefit
>>>>>>
>>>>> >from zero copying much. Potentially, even block/net devices may benefit,
>>>>>> but this needs some evaluation.
>>>>>>
>>>>>>
>>>>>> I would love to hear comments for authors of the hyper-dmabuf
>>>>>>
>>>>>> and Xen community, as well as DRI-Devel and other interested parties.
>>>>>>
>>>>>>
>>>>>> Thank you,
>>>>>>
>>>>>> Oleksandr
>>>>>>
>>>>>>
>>>>>> On 03/29/2018 04:19 PM, Oleksandr Andrushchenko wrote:
>>>>>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>>>>>
>>>>>>> Hello!
>>>>>>>
>>>>>>> When using Xen PV DRM frontend driver then on backend side one will need
>>>>>>> to do copying of display buffers' contents (filled by the
>>>>>>> frontend's user-space) into buffers allocated at the backend side.
>>>>>>> Taking into account the size of display buffers and frames per seconds
>>>>>>> it may result in unneeded huge data bus occupation and performance loss.
>>>>>>>
>>>>>>> This helper driver allows implementing zero-copying use-cases
>>>>>>> when using Xen para-virtualized frontend display driver by
>>>>>>> implementing a DRM/KMS helper driver running on backend's side.
>>>>>>> It utilizes PRIME buffers API to share frontend's buffers with
>>>>>>> physical device drivers on backend's side:
>>>>>>>
>>>>>>>   - a dumb buffer created on backend's side can be shared
>>>>>>>     with the Xen PV frontend driver, so it directly writes
>>>>>>>     into backend's domain memory (into the buffer exported from
>>>>>>>     DRM/KMS driver of a physical display device)
>>>>>>>   - a dumb buffer allocated by the frontend can be imported
>>>>>>>     into physical device DRM/KMS driver, thus allowing to
>>>>>>>     achieve no copying as well
>>>>>>>
>>>>>>> For that reason number of IOCTLs are introduced:
>>>>>>>   -  DRM_XEN_ZCOPY_DUMB_FROM_REFS
>>>>>>>      This will create a DRM dumb buffer from grant references provided
>>>>>>>      by the frontend
>>>>>>>   - DRM_XEN_ZCOPY_DUMB_TO_REFS
>>>>>>>     This will grant references to a dumb/display buffer's memory provided
>>>>>>>     by the backend
>>>>>>>   - DRM_XEN_ZCOPY_DUMB_WAIT_FREE
>>>>>>>     This will block until the dumb buffer with the wait handle provided
>>>>>>>     be freed
>>>>>>>
>>>>>>> With this helper driver I was able to drop CPU usage from 17% to 3%
>>>>>>> on Renesas R-Car M3 board.
>>>>>>>
>>>>>>> This was tested with Renesas' Wayland-KMS and backend running as DRM master.
>>>>>>>
>>>>>>> Thank you,
>>>>>>> Oleksandr
>>>>>>>
>>>>>>> Oleksandr Andrushchenko (1):
>>>>>>>    drm/xen-zcopy: Add Xen zero-copy helper DRM driver
>>>>>>>
>>>>>>>   Documentation/gpu/drivers.rst               |   1 +
>>>>>>>   Documentation/gpu/xen-zcopy.rst             |  32 +
>>>>>>>   drivers/gpu/drm/xen/Kconfig                 |  25 +
>>>>>>>   drivers/gpu/drm/xen/Makefile                |   5 +
>>>>>>>   drivers/gpu/drm/xen/xen_drm_zcopy.c         | 880 ++++++++++++++++++++++++++++
>>>>>>>   drivers/gpu/drm/xen/xen_drm_zcopy_balloon.c | 154 +++++
>>>>>>>   drivers/gpu/drm/xen/xen_drm_zcopy_balloon.h |  38 ++
>>>>>>>   include/uapi/drm/xen_zcopy_drm.h            | 129 ++++
>>>>>>>   8 files changed, 1264 insertions(+)
>>>>>>>   create mode 100644 Documentation/gpu/xen-zcopy.rst
>>>>>>>   create mode 100644 drivers/gpu/drm/xen/xen_drm_zcopy.c
>>>>>>>   create mode 100644 drivers/gpu/drm/xen/xen_drm_zcopy_balloon.c
>>>>>>>   create mode 100644 drivers/gpu/drm/xen/xen_drm_zcopy_balloon.h
>>>>>>>   create mode 100644 include/uapi/drm/xen_zcopy_drm.h
>>>>>>>
>>>>>> [1]
>>>>>> https://lists.xenproject.org/archives/html/xen-devel/2018-02/msg01202.html
>>>>> _______________________________________________
>>>>> dri-devel mailing list
>>>>> dri-devel@lists.freedesktop.org
>>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>>> -- 
>>>> Daniel Vetter
>>>> Software Engineer, Intel Corporation
>>>> http://blog.ffwll.ch
>> [1] https://elixir.bootlin.com/linux/v4.17-rc1/source/include/xen/interface/io/displif.h
>> [2] https://elixir.bootlin.com/linux/v4.17-rc1/source/include/xen/interface/io/displif.h#L539
>> [3] https://elixir.bootlin.com/linux/v4.17-rc1/source/drivers/gpu/drm/drm_prime.c#L39
>> [4] https://elixir.bootlin.com/linux/v4.17-rc1/source/drivers/xen/gntdev.c
>> [5]
>> https://elixir.bootlin.com/linux/v4.17-rc1/source/include/uapi/xen/gntdev.h
>> [6] https://elixir.bootlin.com/linux/v4.17-rc1/source/drivers/xen/balloon.c

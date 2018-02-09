Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751341AbeBILOp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 06:14:45 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52308 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750863AbeBILOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 06:14:43 -0500
Subject: Re: [PATCH v3 1/2] drm/virtio: Add window server support
From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: linux-kernel@vger.kernel.org, Zach Reizner <zachr@google.com>,
        kernel@collabora.com, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>,
        Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
References: <20180126135803.29781-1-tomeu.vizoso@collabora.com>
 <20180126135803.29781-2-tomeu.vizoso@collabora.com>
 <20180201163623.5cs2ysykg5wgulf4@sirius.home.kraxel.org>
 <49785e0d-936a-c3b4-62dd-aafc7083a942@collabora.com>
 <20180205122017.4vb5nlpodkq2uhxa@sirius.home.kraxel.org>
 <f07a5347-13fe-76c2-f971-3f02abebd3c9@collabora.com>
 <20180205160322.sntv5uoqp5o7flnh@sirius.home.kraxel.org>
 <fd557eb7-f539-2ecf-142c-8313b9f7ddb3@collabora.com>
 <20180206142302.vdjyqmnoypydci4t@sirius.home.kraxel.org>
 <04687943-847b-25a7-42ef-a21b4c7ef0cf@collabora.com>
Message-ID: <38880e66-b676-1170-c2ca-5a5603c5b521@collabora.com>
Date: Fri, 9 Feb 2018 12:14:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <04687943-847b-25a7-42ef-a21b4c7ef0cf@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerd and Stefan,

can we reach agreement on whether vsock should be involved in this?

Thanks,

Tomeu

On 02/07/2018 10:49 AM, Tomeu Vizoso wrote:
> On 02/06/2018 03:23 PM, Gerd Hoffmann wrote:
>>    Hi,
>>
>>>> Hmm?  I'm assuming the wayland client (in the guest) talks to the
>>>> wayland proxy, using the wayland protocol, like it would talk to a
>>>> wayland display server.  Buffers must be passed from client to
>>>> server/proxy somehow, probably using fd passing, so where is the
>>>> problem?
>>>>
>>>> Or did I misunderstand the role of the proxy?
>>>
>>> Hi Gerd,
>>>
>>> it's starting to look to me that we're talking a bit past the other, so I
>>> have pasted below a few words describing my current plan regarding the 
>>> 3 key
>>> scenarios that I'm addressing.
>>
>> You are describing the details, but I'm missing the big picture ...
>>
>> So, virtualization aside, how do buffers work in wayland?  As far I know
>> it goes like this:
>>
>>    (a) software rendering: client allocates shared memory buffer, renders
>>        into it, then passes a file handle for that shmem block together
>>        with some meta data (size, format, ...) to the wayland server.
>>
>>    (b) gpu rendering: client opens a render node, allocates a buffer,
>>        asks the cpu to renders into it, exports the buffer as dma-buf
>>        (DRM_IOCTL_PRIME_HANDLE_TO_FD), passes this to the wayland server
>>        (again including meta data of course).
>>
>> Is that correct?
> 
> Both are correct descriptions of typical behaviors. But it isn't spec'ed 
> anywhere who has to do the buffer allocation.
> 
> In practical terms, the buffer allocation happens in either the 2D GUI 
> toolkit (gtk+, for example), or the EGL implementation. Someone using 
> this in a real product would most probably be interested in avoiding any 
> extra copies and make sure that both allocate buffers via virtio-gpu, for 
> example.
> 
> Depending on the use case, they could be also interested in supporting 
> unmodified clients with an extra copy per buffer presentation.
> 
> That's to say that if we cannot come up with a zero-copy solution for 
> unmodified clients, we should at least support zero-copy for cooperative 
> clients.
> 
>> Now, with virtualization added to the mix it becomes a bit more
>> complicated.  Client and server are unmodified.  The client talks to the
>> guest proxy (wayland protocol).  The guest proxy talks to the host proxy
>> (protocol to be defined). The host proxy talks to the server (wayland
>> protocol).
>>
>> Buffers must be managed along the way, and we want avoid copying around
>> the buffers.  The host proxy could be implemented directly in qemu, or
>> as separate process which cooperates with qemu for buffer management.
>>
>> Fine so far?
> 
> Yep.
> 
>>> I really think that whatever we come up with needs to support 3D 
>>> clients as
>>> well.
>>
>> Lets start with 3d clients, I think these are easier.  They simply use
>> virtio-gpu for 3d rendering as usual.  When they are done the rendered
>> buffer already lives in a host drm buffer (because virgl runs the actual
>> rendering on the host gpu).  So the client passes the dma-buf to the
>> guest proxy, the guest proxy imports it to look up the resource-id,
>> passes the resource-id to the host proxy, the host proxy looks up the
>> drm buffer and exports it as dma-buf, then passes it to the server.
>> Done, without any extra data copies.
> 
> Yep.
> 
>>> Creation of shareable buffer by guest
>>> -------------------------------------------------
>>>
>>> 1. Client requests virtio driver to create a buffer suitable for sharing
>>> with host (DRM_VIRTGPU_RESOURCE_CREATE)
>>
>> client or guest proxy?
> 
> As per the above, the GUI toolkit could have been modified so the client 
> directly creates a shareable buffer, and renders directly to it without 
> any extra copies.
> 
> If clients cannot be modified, then it's the guest proxy what has to 
> create the shareable buffer and keep it in sync with the client's 
> non-shareable buffer at the right times, by intercepting 
> wl_surface.commit messages and copying buffer contents.
> 
>>> 4. QEMU maps that buffer to the guest's address space
>>> (KVM_SET_USER_MEMORY_REGION), passes the guest PFN to the virtio driver
>>
>> That part is problematic.  The host can't simply allocate something in
>> the physical address space, because most physical address space
>> management is done by the guest.  All pci bars are mapped by the guest
>> firmware for example (or by the guest OS in case of hotplug).
> 
> How can KVM_SET_USER_MEMORY_REGION ever be safely used then? I would have 
> expected that callers of that ioctl have enough knowledge to be able to 
> choose a physical address that won't conflict with the guest's kernel.
> 
> I see that the ivshmem device in QEMU registers the memory region in BAR 
> 2 of a PCI device instead. Would that be better in your opinion?
> 
>>> 4. QEMU pops data+buffers from the virtqueue, looks up shmem FD for each
>>> resource, sends data + FDs to the compositor with SCM_RIGHTS
>>
>> BTW: Is there a 1:1 relationship between buffers and shmem blocks?  Or
>> does the wayland protocol allow for offsets in buffer meta data, so you
>> can place multiple buffers in a single shmem block?
> 
> The latter: 
> https://wayland.freedesktop.org/docs/html/apa.html#protocol-spec-wl_shm_pool
> 
> Regards,
> 
> Tomeu

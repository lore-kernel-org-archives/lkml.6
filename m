Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935397AbeBMO2E (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 09:28:04 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45122 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933612AbeBMO2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 09:28:00 -0500
Subject: Re: [PATCH v3 1/2] drm/virtio: Add window server support
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
 <20180212114540.iygbha554busy4ip@sirius.home.kraxel.org>
From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Message-ID: <37179029-8ccb-8eb2-0901-04b64cef3608@collabora.com>
Date: Tue, 13 Feb 2018 15:27:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180212114540.iygbha554busy4ip@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2018 12:45 PM, Gerd Hoffmann wrote:
>    Hi,
> 
>>>     (a) software rendering: client allocates shared memory buffer, renders
>>>         into it, then passes a file handle for that shmem block together
>>>         with some meta data (size, format, ...) to the wayland server.
>>>
>>>     (b) gpu rendering: client opens a render node, allocates a buffer,
>>>         asks the cpu to renders into it, exports the buffer as dma-buf
>>>         (DRM_IOCTL_PRIME_HANDLE_TO_FD), passes this to the wayland server
>>>         (again including meta data of course).
>>>
>>> Is that correct?
>>
>> Both are correct descriptions of typical behaviors. But it isn't spec'ed
>> anywhere who has to do the buffer allocation.
> 
> Well, according to Pekka's reply it is spec'ed that way, for the
> existing buffer types.  So for server allocated buffers you need
> (a) a wayland protocol extension and (b) support for the extension
> in the clients.
> 
>> That's to say that if we cannot come up with a zero-copy solution for
>> unmodified clients, we should at least support zero-copy for cooperative
>> clients.
> 
> "cooperative clients" == "client which has support for the wayland
> protocol extension", correct?

Guess it could be that, but I was rather thinking of clients that would 
allocate the buffer for wl_shm_pool with DRM_VIRTGPU_RESOURCE_CREATE or 
equivalent. Then that buffer would be exported and the fd passed using 
the standard wl_shm protocol.

>>>> 4. QEMU maps that buffer to the guest's address space
>>>> (KVM_SET_USER_MEMORY_REGION), passes the guest PFN to the virtio driver
>>>
>>> That part is problematic.  The host can't simply allocate something in
>>> the physical address space, because most physical address space
>>> management is done by the guest.  All pci bars are mapped by the guest
>>> firmware for example (or by the guest OS in case of hotplug).
>>
>> How can KVM_SET_USER_MEMORY_REGION ever be safely used then? I would have
>> expected that callers of that ioctl have enough knowledge to be able to
>> choose a physical address that won't conflict with the guest's kernel.
> 
> Depends on the kind of region.  Guest RAM is allocated and mapped by
> qemu, guest firmware can query qemu about RAM mappings using a special
> interface, then create a e820 memory map for the guest os.  PCI device
> bars are mapped according to the pci config space registers, which in
> turn are initialized by the guest firmware, so it is basically in the
> guests hand where they show up.
> 
>> I see that the ivshmem device in QEMU registers the memory region in BAR 2
>> of a PCI device instead. Would that be better in your opinion?
> 
> Yes.

Would it make sense for virtio-gpu to map buffers to the guest via PCI 
BARs? So we can use a single drm driver for both 2d and 3d.

>>>> 4. QEMU pops data+buffers from the virtqueue, looks up shmem FD for each
>>>> resource, sends data + FDs to the compositor with SCM_RIGHTS
>>>
>>> BTW: Is there a 1:1 relationship between buffers and shmem blocks?  Or
>>> does the wayland protocol allow for offsets in buffer meta data, so you
>>> can place multiple buffers in a single shmem block?
>>
>> The latter:
>> https://wayland.freedesktop.org/docs/html/apa.html#protocol-spec-wl_shm_pool
> 
> Ah, good, that makes it alot easier.
> 
> So, yes, using ivshmem would be one option.  Tricky part here is the
> buffer management though.  It's just a raw piece of memory.  The guest
> proxy could mmap the pci bar and manage it.  But then it is again either
> unmodified guest + copying the data, or modified client (which requests
> buffers from guest proxy) for zero-copy.
> 
> Another idea would be extending stdvga.  Basically qemu would have to
> use shmem as backing storage for vga memory instead of anonymous memory,
> so it would be very  simliar to ivshmem on the host side.  But on the
> guest side we have a drm driver for it (bochs-drm).  So clients can
> allocate dumb drm buffers for software rendering, and the buffer would
> already be backed by a host shmem segment.  Given that wayland already
> supports drm buffers for 3d rendering that could work without extending
> the wayland protocol.  The client proxy would have to translate the drm
> buffer into an pci bar offset and pass it to the host side.  The host
> proxy could register the pci bar as wl_shm_pool, then just pass through
> the offset to reference the individual buffers.
> 
> Drawback of both approaches would be that software rendering and gpu
> rendering would use quite different code paths.

Yeah, would be great if we could find a way to avoid that.

> We also need a solution for the keymap shmem block.  I guess the keymap
> doesn't change all that often, so maybe it is easiest to just copy it
> over (host proxy -> guest proxy) instead of trying to map the host shmem
> into the guest?

I think that should be fine for now. Something similar will have to 
happen for the clipboard, which currently uses pipes to exchange data.

Thanks,

Tomeu

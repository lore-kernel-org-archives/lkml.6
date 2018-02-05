Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753029AbeBEOqb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 09:46:31 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57348 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752612AbeBEOqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 09:46:23 -0500
From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
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
Message-ID: <f07a5347-13fe-76c2-f971-3f02abebd3c9@collabora.com>
Date: Mon, 5 Feb 2018 15:46:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180205122017.4vb5nlpodkq2uhxa@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2018 01:20 PM, Gerd Hoffmann wrote:
>    Hi,
> 
>>> Why not use virtio-vsock to run the wayland protocol? I don't like
>>> the idea to duplicate something with very simliar functionality in
>>> virtio-gpu.
>>
>> The reason for abandoning that approach was the type of objects that
>> could be shared via virtio-vsock would be extremely limited. Besides
>> that being potentially confusing to users, it would mean from the
>> implementation side that either virtio-vsock would gain a dependency on
>> the drm subsystem, or an appropriate abstraction for shareable buffers
>> would need to be added for little gain.
> 
> Well, no.  The idea is that virtio-vsock and virtio-gpu are used largely
> as-is, without knowing about each other.  The guest wayland proxy which
> does the buffer management talks to both devices.

Note that the proxy won't know anything about buffers if clients opt-in 
for zero-copy support (they allocate the buffers in a way that allows 
for sharing with the host).

>>> If you have a guest proxy anyway using virtio-sock for the protocol
>>> stream and virtio-gpu for buffer sharing (and some day 3d rendering
>>> too) should work fine I think.
>>
>> If I understand correctly your proposal, virtio-gpu would be used for
>> creating buffers that could be shared across domains, but something
>> equivalent to SCM_RIGHTS would still be needed in virtio-vsock?
> 
> Yes, the proxy would send a reference to the buffer over virtio-vsock.
> I was more thinking about a struct specifying something like
> "ressource-id 42 on virtio-gpu-pci device in slot 1:23.0" instead of
> using SCM_RIGHTS.

Can you extend on this? I'm having trouble figuring out how this could 
work in a way that keeps protocol data together with the resources it 
refers to.

>> If the mechanics of passing presentation data were very complex, I think
>> this approach would have more merit. But as you can see from the code,
>> it isn't that bad.
> 
> Well, the devil is in the details.  If you have multiple connections you
> don't want one being able to stall the others for example.  There are
> reasons took quite a while to bring virtio-vsock to the state where it
> is today.

Yes, but at the same time there are use cases that virtio-vsock has to 
support but aren't important in this scenario.

>>> What is the plan for the host side? I see basically two options. Either
>>> implement the host wayland proxy directly in qemu. Or
>>> implement it as separate process, which then needs some help from
>>> qemu to get access to the buffers. The later would allow qemu running
>>> independant from the desktop session.
>>
>> Regarding synchronizing buffers, this will stop becoming needed in
>> subsequent commits as all shared memory is allocated in the host and
>> mapped to the guest via KVM_SET_USER_MEMORY_REGION.
>
> --verbose please.  The qemu patches linked from the cover letter not
> exactly helpful in understanding how all this is supposed to work.

A client will allocate a buffer with DRM_VIRTGPU_RESOURCE_CREATE, export 
it and pass the FD to the compositor (via the proxy).

During resource creation, QEMU would allocate a shmem buffer and map it 
into the guest with KVM_SET_USER_MEMORY_REGION.

The client would mmap that resource and render to it. Because it's 
backed by host memory, the compositor would be able to read it without 
any further copies.

>> This is already the case for buffers passed from the compositor to the
>> clients (see patch 2/2), and I'm working on the equivalent for buffers
>> from the guest to the host (clients still have to create buffers with
>> DRM_VIRTGPU_RESOURCE_CREATE but they will be only backend by host memory
>> so no calls to DRM_VIRTGPU_TRANSFER_TO_HOST are needed).
> 
> Same here.  --verbose please.

When a FD comes from the compositor, QEMU mmaps it and maps that virtual 
address to the guest via KVM_SET_USER_MEMORY_REGION.

When the guest proxy reads from the winsrv socket, it will get a FD that 
wraps the buffer referenced above.

When the client reads from the guest proxy, it would get a FD that 
references that same buffer and would mmap it. At that point, the client 
is reading from the same physical pages where the compositor wrote to.

To be clear, I'm not against solving this via some form of restricted FD 
passing in virtio-vsock, but Stefan (added to CC) thought that it would 
be cleaner to do it all within virtio-gpu. This is the thread where it 
was discussed:

https://lkml.kernel.org/r/<2d73a3e1-af70-83a1-0e84-98b5932ea20c@collabora.com>

Thanks,

Tomeu

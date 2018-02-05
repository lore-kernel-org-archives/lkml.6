Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753221AbeBEQDq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 11:03:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40574 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752925AbeBEQDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 11:03:40 -0500
Date: Mon, 5 Feb 2018 17:03:22 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, Zach Reizner <zachr@google.com>,
        kernel@collabora.com, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>,
        Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH v3 1/2] drm/virtio: Add window server support
Message-ID: <20180205160322.sntv5uoqp5o7flnh@sirius.home.kraxel.org>
References: <20180126135803.29781-1-tomeu.vizoso@collabora.com>
 <20180126135803.29781-2-tomeu.vizoso@collabora.com>
 <20180201163623.5cs2ysykg5wgulf4@sirius.home.kraxel.org>
 <49785e0d-936a-c3b4-62dd-aafc7083a942@collabora.com>
 <20180205122017.4vb5nlpodkq2uhxa@sirius.home.kraxel.org>
 <f07a5347-13fe-76c2-f971-3f02abebd3c9@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f07a5347-13fe-76c2-f971-3f02abebd3c9@collabora.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2018 at 03:46:17PM +0100, Tomeu Vizoso wrote:
> On 02/05/2018 01:20 PM, Gerd Hoffmann wrote:
> >    Hi,
> > 
> > > > Why not use virtio-vsock to run the wayland protocol? I don't like
> > > > the idea to duplicate something with very simliar functionality in
> > > > virtio-gpu.
> > > 
> > > The reason for abandoning that approach was the type of objects that
> > > could be shared via virtio-vsock would be extremely limited. Besides
> > > that being potentially confusing to users, it would mean from the
> > > implementation side that either virtio-vsock would gain a dependency on
> > > the drm subsystem, or an appropriate abstraction for shareable buffers
> > > would need to be added for little gain.
> > 
> > Well, no.  The idea is that virtio-vsock and virtio-gpu are used largely
> > as-is, without knowing about each other.  The guest wayland proxy which
> > does the buffer management talks to both devices.
> 
> Note that the proxy won't know anything about buffers if clients opt-in for
> zero-copy support (they allocate the buffers in a way that allows for
> sharing with the host).

Hmm?  I'm assuming the wayland client (in the guest) talks to the
wayland proxy, using the wayland protocol, like it would talk to a
wayland display server.  Buffers must be passed from client to
server/proxy somehow, probably using fd passing, so where is the
problem?

Or did I misunderstand the role of the proxy?

> > > > If you have a guest proxy anyway using virtio-sock for the protocol
> > > > stream and virtio-gpu for buffer sharing (and some day 3d rendering
> > > > too) should work fine I think.
> > > 
> > > If I understand correctly your proposal, virtio-gpu would be used for
> > > creating buffers that could be shared across domains, but something
> > > equivalent to SCM_RIGHTS would still be needed in virtio-vsock?
> > 
> > Yes, the proxy would send a reference to the buffer over virtio-vsock.
> > I was more thinking about a struct specifying something like
> > "ressource-id 42 on virtio-gpu-pci device in slot 1:23.0" instead of
> > using SCM_RIGHTS.
> 
> Can you extend on this? I'm having trouble figuring out how this could work
> in a way that keeps protocol data together with the resources it refers to.

Don't know much about the wayland protocol.  Assuming you are passing
buffers as file handles, together with some information what kind of
buffer this is (sysv shm, dma-buf, ...).

We have a proxy on both ends.  One running in the guest, one on the host
(be it qemu or some external one).  So these two have to agree on how to
pass buffers from one to the other.  One way would be to have them talk
a simple meta protocol to each other, with "here comes a chunk wayland
protocol to pass along" and "here is a buffer mgmt message".  Possibly
it is better to extend the wayland protocol to also cover this new kind
of buffer, so you don't need the meta protocol.

The proxies would talk normal wayland protocol to the client (in the
guest) and the server (on the host).  They will have to transform the
buffer into something they can pass along using the wayland protocol.

> > > > What is the plan for the host side? I see basically two options. Either
> > > > implement the host wayland proxy directly in qemu. Or
> > > > implement it as separate process, which then needs some help from
> > > > qemu to get access to the buffers. The later would allow qemu running
> > > > independant from the desktop session.
> > > 
> > > Regarding synchronizing buffers, this will stop becoming needed in
> > > subsequent commits as all shared memory is allocated in the host and
> > > mapped to the guest via KVM_SET_USER_MEMORY_REGION.
> > 
> > --verbose please.  The qemu patches linked from the cover letter not
> > exactly helpful in understanding how all this is supposed to work.
> 
> A client will allocate a buffer with DRM_VIRTGPU_RESOURCE_CREATE, export it
> and pass the FD to the compositor (via the proxy).
> 
> During resource creation, QEMU would allocate a shmem buffer and map it into
> the guest with KVM_SET_USER_MEMORY_REGION.

So the buffer magically shows up somewhere in the physical address space
of the guest?  That kind if magic usually isn't a very good idea.

> When a FD comes from the compositor, QEMU mmaps it and maps that virtual
> address to the guest via KVM_SET_USER_MEMORY_REGION.
> 
> When the guest proxy reads from the winsrv socket, it will get a FD that
> wraps the buffer referenced above.
> 
> When the client reads from the guest proxy, it would get a FD that
> references that same buffer and would mmap it. At that point, the client is
> reading from the same physical pages where the compositor wrote to.

Hmm.  I allways assumed the wayland client allocates the buffers, not
the server.  Is that wrong?

What is your plan for 3d acceleration support?

> To be clear, I'm not against solving this via some form of restricted FD
> passing in virtio-vsock, but Stefan (added to CC) thought that it would be
> cleaner to do it all within virtio-gpu.

Well, when targeting 3d acceleration it makes alot of sense to use
virtio-gpu.  And it makes sense to have 2d and 3d modes work as simliar
as possible.  That is not the direction you are taking with your
proposal though ...

If you don't plan for 3d support I'm wondering whenever virtio-gpu is a
good pick.  Mapping trickery aside, you wouldn't get linear buffers
which can easily be shared between host and guest, because guest buffers
are not required to be linear in guest physical memory.  One copy will
be needed, from (scattered) guest physical memory buffer to (linear)
host buffer.

One possible alternative would be to build on stdvga.  It has a pci
memory bar, it has a drm driver (bochs) which allows allocating drm
buffers in that bar.  They are linear buffers in both guest physical and
host virtual memory.  If we add an option to qemu to allocate the memory
bar in sysv shared memory it can easily be exported to other processes
on the host.  The wayland client in the guest can map it directly too,
it only needs to create a drm buffer and mmap it.  You can get zero-copy
without having to play mapping tricks.

cheers,
  Gerd

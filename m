Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752151AbeBFOXM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 09:23:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40136 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750990AbeBFOXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 09:23:06 -0500
Date: Tue, 6 Feb 2018 15:23:02 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, Zach Reizner <zachr@google.com>,
        kernel@collabora.com, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>,
        Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH v3 1/2] drm/virtio: Add window server support
Message-ID: <20180206142302.vdjyqmnoypydci4t@sirius.home.kraxel.org>
References: <20180126135803.29781-1-tomeu.vizoso@collabora.com>
 <20180126135803.29781-2-tomeu.vizoso@collabora.com>
 <20180201163623.5cs2ysykg5wgulf4@sirius.home.kraxel.org>
 <49785e0d-936a-c3b4-62dd-aafc7083a942@collabora.com>
 <20180205122017.4vb5nlpodkq2uhxa@sirius.home.kraxel.org>
 <f07a5347-13fe-76c2-f971-3f02abebd3c9@collabora.com>
 <20180205160322.sntv5uoqp5o7flnh@sirius.home.kraxel.org>
 <fd557eb7-f539-2ecf-142c-8313b9f7ddb3@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd557eb7-f539-2ecf-142c-8313b9f7ddb3@collabora.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > Hmm?  I'm assuming the wayland client (in the guest) talks to the
> > wayland proxy, using the wayland protocol, like it would talk to a
> > wayland display server.  Buffers must be passed from client to
> > server/proxy somehow, probably using fd passing, so where is the
> > problem?
> > 
> > Or did I misunderstand the role of the proxy?
> 
> Hi Gerd,
> 
> it's starting to look to me that we're talking a bit past the other, so I
> have pasted below a few words describing my current plan regarding the 3 key
> scenarios that I'm addressing.

You are describing the details, but I'm missing the big picture ...

So, virtualization aside, how do buffers work in wayland?  As far I know
it goes like this:

  (a) software rendering: client allocates shared memory buffer, renders
      into it, then passes a file handle for that shmem block together
      with some meta data (size, format, ...) to the wayland server.

  (b) gpu rendering: client opens a render node, allocates a buffer,
      asks the cpu to renders into it, exports the buffer as dma-buf
      (DRM_IOCTL_PRIME_HANDLE_TO_FD), passes this to the wayland server
      (again including meta data of course).

Is that correct?

Now, with virtualization added to the mix it becomes a bit more
complicated.  Client and server are unmodified.  The client talks to the
guest proxy (wayland protocol).  The guest proxy talks to the host proxy
(protocol to be defined). The host proxy talks to the server (wayland
protocol).

Buffers must be managed along the way, and we want avoid copying around
the buffers.  The host proxy could be implemented directly in qemu, or
as separate process which cooperates with qemu for buffer management.

Fine so far?

> I really think that whatever we come up with needs to support 3D clients as
> well.

Lets start with 3d clients, I think these are easier.  They simply use
virtio-gpu for 3d rendering as usual.  When they are done the rendered
buffer already lives in a host drm buffer (because virgl runs the actual
rendering on the host gpu).  So the client passes the dma-buf to the
guest proxy, the guest proxy imports it to look up the resource-id,
passes the resource-id to the host proxy, the host proxy looks up the
drm buffer and exports it as dma-buf, then passes it to the server.
Done, without any extra data copies.

> Creation of shareable buffer by guest
> -------------------------------------------------
> 
> 1. Client requests virtio driver to create a buffer suitable for sharing
> with host (DRM_VIRTGPU_RESOURCE_CREATE)

client or guest proxy?

> 4. QEMU maps that buffer to the guest's address space
> (KVM_SET_USER_MEMORY_REGION), passes the guest PFN to the virtio driver

That part is problematic.  The host can't simply allocate something in
the physical address space, because most physical address space
management is done by the guest.  All pci bars are mapped by the guest
firmware for example (or by the guest OS in case of hotplug).

> 4. QEMU pops data+buffers from the virtqueue, looks up shmem FD for each
> resource, sends data + FDs to the compositor with SCM_RIGHTS

BTW: Is there a 1:1 relationship between buffers and shmem blocks?  Or
does the wayland protocol allow for offsets in buffer meta data, so you
can place multiple buffers in a single shmem block?

cheers,
  Gerd

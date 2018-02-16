Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934295AbeBPKss (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 05:48:48 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56358 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934225AbeBPKso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 05:48:44 -0500
Date: Fri, 16 Feb 2018 11:48:40 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, Zach Reizner <zachr@google.com>,
        kernel@collabora.com, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>,
        Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH v3 1/2] drm/virtio: Add window server support
Message-ID: <20180216104840.wtqblyrrhwek6ox7@sirius.home.kraxel.org>
References: <20180201163623.5cs2ysykg5wgulf4@sirius.home.kraxel.org>
 <49785e0d-936a-c3b4-62dd-aafc7083a942@collabora.com>
 <20180205122017.4vb5nlpodkq2uhxa@sirius.home.kraxel.org>
 <f07a5347-13fe-76c2-f971-3f02abebd3c9@collabora.com>
 <20180205160322.sntv5uoqp5o7flnh@sirius.home.kraxel.org>
 <fd557eb7-f539-2ecf-142c-8313b9f7ddb3@collabora.com>
 <20180206142302.vdjyqmnoypydci4t@sirius.home.kraxel.org>
 <04687943-847b-25a7-42ef-a21b4c7ef0cf@collabora.com>
 <20180212114540.iygbha554busy4ip@sirius.home.kraxel.org>
 <37179029-8ccb-8eb2-0901-04b64cef3608@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37179029-8ccb-8eb2-0901-04b64cef3608@collabora.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Yes.
> 
> Would it make sense for virtio-gpu to map buffers to the guest via PCI BARs?
> So we can use a single drm driver for both 2d and 3d.

Should be doable.

I'm wondering two things though:

(1) Will shmem actually help avoiding a copy?

virtio-gpu with virgl will (even if the guest doesn't use opengl) store
the resources in gpu memory.  So the VIRTIO_GPU_CMD_TRANSFER_TO_HOST_2D
copy goes from guest memory directly to gpu memory, and if we export
that as dma-buf and pass it to the wayland server it should be able to
render it without doing another copy.

How does the wl_shm_pool workflow look like inside the wayland server?
Can it ask the gpu to render directly from the pool?  Or is a copy to
gpu memory needed here?  If the latter we would effectively trade one
copy for another ...

(2) Could we handle the mapping without needing shmem?

Possibly we could extend the vgem driver.  So we pass in a iov (which
qemu gets from guest via VIRTIO_GPU_CMD_RESOURCE_ATTACH_BACKING), get
back a drm object.  Which effectively creates drm objects on the host
which match the drm object in the guest (both backed by the same set of
physical pages).

cheers,
  Gerd

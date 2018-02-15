Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163894AbeBOP2u (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 10:28:50 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56374 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163874AbeBOP2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 10:28:47 -0500
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
Message-ID: <5ca446c7-582c-6871-c13f-9fc44c535ebc@collabora.com>
Date: Thu, 15 Feb 2018 16:28:41 +0100
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

On 02/12/2018 12:45 PM, Gerd Hoffmann wrote:>>>> 4. QEMU pops 
data+buffers from the virtqueue, looks up shmem FD for each
 >>>> resource, sends data + FDs to the compositor with SCM_RIGHTS
 >>>
 >>> BTW: Is there a 1:1 relationship between buffers and shmem blocks?  Or
 >>> does the wayland protocol allow for offsets in buffer meta data, so you
 >>> can place multiple buffers in a single shmem block?
 >>
 >> The latter:
 >> 
https://wayland.freedesktop.org/docs/html/apa.html#protocol-spec-wl_shm_pool
 >
 > Ah, good, that makes it alot easier.
 >
 > So, yes, using ivshmem would be one option.  Tricky part here is the
 > buffer management though.  It's just a raw piece of memory.  The guest
 > proxy could mmap the pci bar and manage it.  But then it is again either
 > unmodified guest + copying the data, or modified client (which requests
 > buffers from guest proxy) for zero-copy.

What if at VIRTIO_GPU_CMD_RESOURCE_CREATE_2D time we created a ivshmem 
device to back that resource. The ivshmem device would in turn be backed 
by a hostmem device that wraps a shmem FD.

The guest client can then export that resource/BO and pass the FD to the 
guest proxy. The guest proxy would import it and put the resource_id in 
the equivalent message in our protocol extension.

QEMU would get that resource id from vsock, look up which hostmem device 
is associated with that resource, and pass its FD to the compositor.

 > We also need a solution for the keymap shmem block.  I guess the keymap
 > doesn't change all that often, so maybe it is easiest to just copy it
 > over (host proxy -> guest proxy) instead of trying to map the host shmem
 > into the guest?

Not sure if that would be much simpler than creating a ivshmem+hostmem 
combo that wraps the incoming shmem FD and then having virtio-gpu create 
a BO that imports it.

Regards,

Tomeu

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754242AbeBLOmo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 09:42:44 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39814 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754224AbeBLOmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 09:42:42 -0500
Subject: Re: [PATCH v3 1/2] drm/virtio: Add window server support
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: linux-kernel@vger.kernel.org, Zach Reizner <zachr@google.com>,
        kernel@collabora.com, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>,
        Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
References: <49785e0d-936a-c3b4-62dd-aafc7083a942@collabora.com>
 <20180205122017.4vb5nlpodkq2uhxa@sirius.home.kraxel.org>
 <f07a5347-13fe-76c2-f971-3f02abebd3c9@collabora.com>
 <20180205160322.sntv5uoqp5o7flnh@sirius.home.kraxel.org>
 <fd557eb7-f539-2ecf-142c-8313b9f7ddb3@collabora.com>
 <20180206142302.vdjyqmnoypydci4t@sirius.home.kraxel.org>
 <04687943-847b-25a7-42ef-a21b4c7ef0cf@collabora.com>
 <38880e66-b676-1170-c2ca-5a5603c5b521@collabora.com>
 <20180212115242.z3qv5uejbnhgvd6o@sirius.home.kraxel.org>
 <eea72b9d-d180-6a57-81ce-4366dc0f2bcc@collabora.com>
 <20180212142730.g2646v77qsvzd5ff@sirius.home.kraxel.org>
From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Message-ID: <6cf0c06a-b884-3251-166b-6ff3dec3ebc7@collabora.com>
Date: Mon, 12 Feb 2018 15:42:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180212142730.g2646v77qsvzd5ff@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2018 03:27 PM, Gerd Hoffmann wrote:
> On Mon, Feb 12, 2018 at 03:00:24PM +0100, Tomeu Vizoso wrote:
>> On 02/12/2018 12:52 PM, Gerd Hoffmann wrote:
>>>     Hi,
>>>
>>>> can we reach agreement on whether vsock should be involved in this?
>>>
>>> I think the best approach would be to have guest proxy and host proxy
>>> use vsock for the wayland protocol.  Use a wayland protocol extension to
>>> reference the buffers in stdvga / ivshmem / virtio-gpu.  Only the two
>>> proxies need to understand the extension, the client <=> guest proxy and
>>> host proxy <=> server communication would be standard wayland protocol.
>>
>> Thanks for the ideas. What I haven't understood yet is how you see the
>> actual passing of buffers via vsock. Are you thinking of using ancillary
>> data to pass FDs, or something else?
> 
> I was more thinking about a struct containing enough info to allow the
> proxy on the host side find the buffer, something like:
> 
>     struct {
>        enum type { stdvga, virtio-cpu, ... }
>        pcislot device;
>        union {
>           int stdvga_pcibar_offset;
>           int virtio_gpu_resource_id;
>        }
>     }
> 
> So when the guest proxy gets a message with a fd referencing a buffer it
> would have to figure where the buffer is, rewrite the message into the
> struct above for the host proxy.  The host proxy would rewrite the
> message again for the server.

What I don't understand yet is how we can keep the buffer descriptions 
together with the protocol data that references them.

With SCM_RIGHTS, the FDs are placed in the ancillary data that "travels" 
together with the protocol data that references them.

With the present series, the DRM_IOCTL_VIRTGPU_WINSRV_TX ioctl struct has 
a field for the protocol data and an array of FDs.

How are you proposing to pass instances of that struct from above along 
the protocol data that refers to them?

Thanks,

Tomeu

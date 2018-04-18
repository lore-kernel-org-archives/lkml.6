Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752989AbeDRIBR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 04:01:17 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:42682 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752707AbeDRIBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 04:01:16 -0400
X-Google-Smtp-Source: AIpwx4/GK04LDGP1jq0b2sYosZ2FO7RlqBK+VysPybNRDS+vH6hrEwTopjfBSzmF5yexzpmfVenVNQ==
Subject: Re: [Xen-devel] [PATCH 0/1] drm/xen-zcopy: Add Xen zero-copy helper
 DRM driver
To: =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Cc: Dongwon Kim <dongwon.kim@intel.com>,
        "Oleksandr_Andrushchenko@epam.com" <Oleksandr_Andrushchenko@epam.com>,
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
 <20180418073508.ptvntwedczpvl7bx@MacBook-Pro-de-Roger.local>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <ebcbf6ce-1d7a-5f3e-cff8-546d1c010e59@gmail.com>
Date: Wed, 18 Apr 2018 11:01:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180418073508.ptvntwedczpvl7bx@MacBook-Pro-de-Roger.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/18/2018 10:35 AM, Roger Pau Monné wrote:
> On Wed, Apr 18, 2018 at 09:38:39AM +0300, Oleksandr Andrushchenko wrote:
>> On 04/17/2018 11:57 PM, Dongwon Kim wrote:
>>> On Tue, Apr 17, 2018 at 09:59:28AM +0200, Daniel Vetter wrote:
>>>> On Mon, Apr 16, 2018 at 12:29:05PM -0700, Dongwon Kim wrote:
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
> I cannot parse the above sentence:
>
> "As the backend runs in the trusted domain we also assume that it is
> trusted as well, e.g. must take measures to prevent DDoS attacks."
>
> What's the relation between being trusted and protecting from DoS
> attacks?
I mean that we trust the backend that it can prevent Dom0
from crashing in case DomU's frontend misbehaves, e.g.
if the frontend sends too many memory requests etc.
> In any case, all? PV protocols are implemented with the frontend
> sharing pages to the backend, and I think there's a reason why this
> model is used, and it should continue to be used.
This is the first use-case above. But there are real-world
use-cases (embedded in my case) when physically contiguous memory
needs to be shared, one of the possible ways to achieve this is
to share contiguous memory from Dom0 to DomU (the second use-case above)
> Having to add logic in the backend to prevent such attacks means
> that:
>
>   - We need more code in the backend, which increases complexity and
>     chances of bugs.
>   - Such code/logic could be wrong, thus allowing DoS.
You can live without this code at all, but this is then up to
backend which may make Dom0 down because of DomU's frontend doing evil 
things
>> 4. xen-front/backend/xen-zcopy synchronization
>>
>> 4.1. As I already said in 2) all the inter VM communication happens between
>> xen-front and the backend, xen-zcopy is NOT involved in that.
>> When xen-front wants to destroy a display buffer (dumb/dma-buf) it issues a
>> XENDISPL_OP_DBUF_DESTROY command (opposite to XENDISPL_OP_DBUF_CREATE).
>> This call is synchronous, so xen-front expects that backend does free the
>> buffer pages on return.
>>
>> 4.2. Backend, on XENDISPL_OP_DBUF_DESTROY:
>>    - closes all dumb handles/fd's of the buffer according to [3]
>>    - issues DRM_IOCTL_XEN_ZCOPY_DUMB_WAIT_FREE IOCTL to xen-zcopy to make
>> sure
>>      the buffer is freed (think of it as it waits for dma-buf->release
>> callback)
> So this zcopy thing keeps some kind of track of the memory usage? Why
> can't the user-space backend keep track of the buffer usage?
Because there is no dma-buf UAPI which allows to track the buffer life cycle
(e.g. wait until dma-buf's .release callback is called)
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
> I don't know much about the dma-buf implementation in Linux, but
> gntdev is a user-space device, and AFAICT user-space applications
> don't have any notion of dma buffers. How are such buffers useful for
> user-space? Why can't this just be called memory?
A dma-buf is seen by user-space as a file descriptor and you can
pass it to different drivers then. For example, you can share a buffer
used by a display driver for scanout with a GPU, to compose a picture
into it:
1. User-space (US) allocates a display buffer from display driver
2. US asks display driver to export the dma-buf which backs up that buffer,
US gets buffer's fd: dma_buf_fd
3. US asks GPU driver to import a buffer and provides it with dma_buf_fd
4. GPU renders contents into display buffer (dma_buf_fd)

Finally, this is indeed some memory, but a bit more [1]
>
> Also, (with my FreeBSD maintainer hat) how is this going to translate
> to other OSes? So far the operations performed by the gntdev device
> are mostly OS-agnostic because this just map/unmap memory, and in fact
> they are implemented by Linux and FreeBSD.
At the moment I can only see Linux implementation and it seems
to be perfectly ok as we do not change Xen's APIs etc. and only
use the existing ones (remember, we only extend gntdev/balloon
drivers, all the changes in the Linux kernel)
As the second note I can also think that we do not extend gntdev/balloon
drivers and have re-worked xen-zcopy driver be a separate entity,
say drivers/xen/dma-buf
>> implement "wait" ioctl (wait for dma-buf->release): currently these are
>> DRM_XEN_ZCOPY_DUMB_FROM_REFS, DRM_XEN_ZCOPY_DUMB_TO_REFS and
>> DRM_XEN_ZCOPY_DUMB_WAIT_FREE
>> 1.2. Xen balloon driver [6] to allow allocating contiguous buffers (not
>> needed
>> by current hyper-dmabuf, but is a must for xen-zcopy use-cases)
> I think this needs clarifying. In which memory space do you need those
> regions to be contiguous?
Use-case: Dom0 has a HW driver which only works with contig memory
and I want DomU to be able to directly write into that memory, thus
implementing zero copying
>
> Do they need to be contiguous in host physical memory, or guest
> physical memory?
Host
>
> If it's in guest memory space, isn't there any generic interface that
> you can use?
>
> If it's in host physical memory space, why do you need this buffer to
> be contiguous in host physical memory space? The IOMMU should hide all
> this.
There are drivers/HW which can only work with contig memory and
if it is backed by an IOMMU then still it has to be contig in IPA
space (real device doesn't know that it is actually IPA contig, not PA)
> Thanks, Roger.
Thank you,
Oleksandr

[1] https://01.org/linuxgraphics/gfx-docs/drm/driver-api/dma-buf.html

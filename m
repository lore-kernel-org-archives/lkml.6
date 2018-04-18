Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753136AbeDRHfR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 03:35:17 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:20921 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752760AbeDRHfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 03:35:16 -0400
X-IronPort-AV: E=Sophos;i="5.48,464,1517875200";
   d="scan'208";a="71728365"
Date: Wed, 18 Apr 2018 08:35:08 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Oleksandr Andrushchenko <andr2000@gmail.com>
CC: Dongwon Kim <dongwon.kim@intel.com>,
        "Oleksandr_Andrushchenko@epam.com" <Oleksandr_Andrushchenko@epam.com>,
        <jgross@suse.com>, Artem Mygaiev <Artem_Mygaiev@epam.com>,
        <konrad.wilk@oracle.com>, <airlied@linux.ie>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        "Potrola, MateuszX" <mateuszx.potrola@intel.com>,
        <daniel.vetter@intel.com>, <xen-devel@lists.xenproject.org>,
        <boris.ostrovsky@oracle.com>, Matt Roper <matthew.d.roper@intel.com>
Subject: Re: [Xen-devel] [PATCH 0/1] drm/xen-zcopy: Add Xen zero-copy helper
 DRM driver
Message-ID: <20180418073508.ptvntwedczpvl7bx@MacBook-Pro-de-Roger.local>
References: <20180329131931.29957-1-andr2000@gmail.com>
 <5d8fec7f-956c-378f-be90-f45029385740@gmail.com>
 <20180416192905.GA18096@downor-Z87X-UD5H>
 <20180417075928.GT31310@phenom.ffwll.local>
 <20180417205744.GA15930@downor-Z87X-UD5H>
 <41487acb-a67a-8933-d0c3-702c19b0938e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41487acb-a67a-8933-d0c3-702c19b0938e@gmail.com>
User-Agent: NeoMutt/20180323
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 09:38:39AM +0300, Oleksandr Andrushchenko wrote:
> On 04/17/2018 11:57 PM, Dongwon Kim wrote:
> > On Tue, Apr 17, 2018 at 09:59:28AM +0200, Daniel Vetter wrote:
> > > On Mon, Apr 16, 2018 at 12:29:05PM -0700, Dongwon Kim wrote:
> 3.2 Backend exports dma-buf to xen-front
> 
> In this case Dom0 pages are shared with DomU. As before, DomU can only write
> to these pages, not any other page from Dom0, so it can be still considered
> safe.
> But, the following must be considered (highlighted in xen-front's Kernel
> documentation):
>  - If guest domain dies then pages/grants received from the backend cannot
>    be claimed back - think of it as memory lost to Dom0 (won't be used for
> any
>    other guest)
>  - Misbehaving guest may send too many requests to the backend exhausting
>    its grant references and memory (consider this from security POV). As the
>    backend runs in the trusted domain we also assume that it is trusted as
> well,
>    e.g. must take measures to prevent DDoS attacks.

I cannot parse the above sentence:

"As the backend runs in the trusted domain we also assume that it is
trusted as well, e.g. must take measures to prevent DDoS attacks."

What's the relation between being trusted and protecting from DoS
attacks?

In any case, all? PV protocols are implemented with the frontend
sharing pages to the backend, and I think there's a reason why this
model is used, and it should continue to be used.

Having to add logic in the backend to prevent such attacks means
that:

 - We need more code in the backend, which increases complexity and
   chances of bugs.
 - Such code/logic could be wrong, thus allowing DoS.

> 4. xen-front/backend/xen-zcopy synchronization
> 
> 4.1. As I already said in 2) all the inter VM communication happens between
> xen-front and the backend, xen-zcopy is NOT involved in that.
> When xen-front wants to destroy a display buffer (dumb/dma-buf) it issues a
> XENDISPL_OP_DBUF_DESTROY command (opposite to XENDISPL_OP_DBUF_CREATE).
> This call is synchronous, so xen-front expects that backend does free the
> buffer pages on return.
> 
> 4.2. Backend, on XENDISPL_OP_DBUF_DESTROY:
>   - closes all dumb handles/fd's of the buffer according to [3]
>   - issues DRM_IOCTL_XEN_ZCOPY_DUMB_WAIT_FREE IOCTL to xen-zcopy to make
> sure
>     the buffer is freed (think of it as it waits for dma-buf->release
> callback)

So this zcopy thing keeps some kind of track of the memory usage? Why
can't the user-space backend keep track of the buffer usage?

>   - replies to xen-front that the buffer can be destroyed.
> This way deletion of the buffer happens synchronously on both Dom0 and DomU
> sides. In case if DRM_IOCTL_XEN_ZCOPY_DUMB_WAIT_FREE returns with time-out
> error
> (BTW, wait time is a parameter of this IOCTL), Xen will defer grant
> reference
> removal and will retry later until those are free.
> 
> Hope this helps understand how buffers are synchronously deleted in case
> of xen-zcopy with a single protocol command.
> 
> I think the above logic can also be re-used by the hyper-dmabuf driver with
> some additional work:
> 
> 1. xen-zcopy can be split into 2 parts and extend:
> 1.1. Xen gntdev driver [4], [5] to allow creating dma-buf from grefs and
> vise versa,

I don't know much about the dma-buf implementation in Linux, but
gntdev is a user-space device, and AFAICT user-space applications
don't have any notion of dma buffers. How are such buffers useful for
user-space? Why can't this just be called memory?

Also, (with my FreeBSD maintainer hat) how is this going to translate
to other OSes? So far the operations performed by the gntdev device
are mostly OS-agnostic because this just map/unmap memory, and in fact
they are implemented by Linux and FreeBSD.

> implement "wait" ioctl (wait for dma-buf->release): currently these are
> DRM_XEN_ZCOPY_DUMB_FROM_REFS, DRM_XEN_ZCOPY_DUMB_TO_REFS and
> DRM_XEN_ZCOPY_DUMB_WAIT_FREE
> 1.2. Xen balloon driver [6] to allow allocating contiguous buffers (not
> needed
> by current hyper-dmabuf, but is a must for xen-zcopy use-cases)

I think this needs clarifying. In which memory space do you need those
regions to be contiguous?

Do they need to be contiguous in host physical memory, or guest
physical memory?

If it's in guest memory space, isn't there any generic interface that
you can use?

If it's in host physical memory space, why do you need this buffer to
be contiguous in host physical memory space? The IOMMU should hide all
this.

Thanks, Roger.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752777AbeDPOdx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 10:33:53 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36568 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751205AbeDPOdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 10:33:50 -0400
X-Google-Smtp-Source: AIpwx4+Cok1AifV/LA5+GS4DP0ZS+SukucPkbyUB5vb5c21mXaUp9qtJ6g42EDZxRtKktCpxbwi9wA==
Subject: Re: [PATCH 0/1] drm/xen-zcopy: Add Xen zero-copy helper DRM driver
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org, gustavo@padovan.org,
        jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Dongwon Kim <dongwon.kim@intel.com>,
        "Potrola, MateuszX" <mateuszx.potrola@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Artem Mygaiev <Artem_Mygaiev@epam.com>
References: <20180329131931.29957-1-andr2000@gmail.com>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <5d8fec7f-956c-378f-be90-f45029385740@gmail.com>
Date: Mon, 16 Apr 2018 17:33:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180329131931.29957-1-andr2000@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, all!

After discussing xen-zcopy and hyper-dmabuf [1] approaches

it seems that xen-zcopy can be made not depend on DRM core any more

and be dma-buf centric (which it in fact is).

The DRM code was mostly there for dma-buf's FD import/export

with DRM PRIME UAPI and with DRM use-cases in mind, but it comes out that if

the proposed 2 IOCTLs (DRM_XEN_ZCOPY_DUMB_FROM_REFS and 
DRM_XEN_ZCOPY_DUMB_TO_REFS)

are extended to also provide a file descriptor of the corresponding 
dma-buf, then

PRIME stuff in the driver is not needed anymore.

That being said, xen-zcopy can safely be detached from DRM and moved from

drivers/gpu/drm/xen into drivers/xen/dma-buf-backend(?).

This driver then becomes a universal way to turn any shared buffer 
between Dom0/DomD

and DomU(s) into a dma-buf, e.g. one can create a dma-buf from any grant 
references

or represent a dma-buf as grant-references for export.

This way the driver can be used not only for DRM use-cases, but also for 
other

use-cases which may require zero copying between domains.

For example, the use-cases we are about to work in the nearest future 
will use

V4L, e.g. we plan to support cameras, codecs etc. and all these will benefit

from zero copying much. Potentially, even block/net devices may benefit,

but this needs some evaluation.


I would love to hear comments for authors of the hyper-dmabuf

and Xen community, as well as DRI-Devel and other interested parties.


Thank you,

Oleksandr


On 03/29/2018 04:19 PM, Oleksandr Andrushchenko wrote:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>
> Hello!
>
> When using Xen PV DRM frontend driver then on backend side one will need
> to do copying of display buffers' contents (filled by the
> frontend's user-space) into buffers allocated at the backend side.
> Taking into account the size of display buffers and frames per seconds
> it may result in unneeded huge data bus occupation and performance loss.
>
> This helper driver allows implementing zero-copying use-cases
> when using Xen para-virtualized frontend display driver by
> implementing a DRM/KMS helper driver running on backend's side.
> It utilizes PRIME buffers API to share frontend's buffers with
> physical device drivers on backend's side:
>
>   - a dumb buffer created on backend's side can be shared
>     with the Xen PV frontend driver, so it directly writes
>     into backend's domain memory (into the buffer exported from
>     DRM/KMS driver of a physical display device)
>   - a dumb buffer allocated by the frontend can be imported
>     into physical device DRM/KMS driver, thus allowing to
>     achieve no copying as well
>
> For that reason number of IOCTLs are introduced:
>   -  DRM_XEN_ZCOPY_DUMB_FROM_REFS
>      This will create a DRM dumb buffer from grant references provided
>      by the frontend
>   - DRM_XEN_ZCOPY_DUMB_TO_REFS
>     This will grant references to a dumb/display buffer's memory provided
>     by the backend
>   - DRM_XEN_ZCOPY_DUMB_WAIT_FREE
>     This will block until the dumb buffer with the wait handle provided
>     be freed
>
> With this helper driver I was able to drop CPU usage from 17% to 3%
> on Renesas R-Car M3 board.
>
> This was tested with Renesas' Wayland-KMS and backend running as DRM master.
>
> Thank you,
> Oleksandr
>
> Oleksandr Andrushchenko (1):
>    drm/xen-zcopy: Add Xen zero-copy helper DRM driver
>
>   Documentation/gpu/drivers.rst               |   1 +
>   Documentation/gpu/xen-zcopy.rst             |  32 +
>   drivers/gpu/drm/xen/Kconfig                 |  25 +
>   drivers/gpu/drm/xen/Makefile                |   5 +
>   drivers/gpu/drm/xen/xen_drm_zcopy.c         | 880 ++++++++++++++++++++++++++++
>   drivers/gpu/drm/xen/xen_drm_zcopy_balloon.c | 154 +++++
>   drivers/gpu/drm/xen/xen_drm_zcopy_balloon.h |  38 ++
>   include/uapi/drm/xen_zcopy_drm.h            | 129 ++++
>   8 files changed, 1264 insertions(+)
>   create mode 100644 Documentation/gpu/xen-zcopy.rst
>   create mode 100644 drivers/gpu/drm/xen/xen_drm_zcopy.c
>   create mode 100644 drivers/gpu/drm/xen/xen_drm_zcopy_balloon.c
>   create mode 100644 drivers/gpu/drm/xen/xen_drm_zcopy_balloon.h
>   create mode 100644 include/uapi/drm/xen_zcopy_drm.h
>
[1] 
https://lists.xenproject.org/archives/html/xen-devel/2018-02/msg01202.html

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754014AbeDTHjM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 03:39:12 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:35902 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753956AbeDTHjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 03:39:10 -0400
X-Google-Smtp-Source: AIpwx481EwgTtylVVGAGarWmvrZTCIU7J/6XVAdABzIb7Vfilcmb1WHVkG6X7VI/KtFmpHo4BfSr/Q==
MIME-Version: 1.0
References: <20180419154124.17512-1-paul.kocialkowski@bootlin.com> <20180419154124.17512-3-paul.kocialkowski@bootlin.com>
In-Reply-To: <20180419154124.17512-3-paul.kocialkowski@bootlin.com>
From: Alexandre Courbot <acourbot@chromium.org>
Date: Fri, 20 Apr 2018 07:38:57 +0000
X-Gmail-Original-Message-ID: <CAPBb6MVuyN+NdCrLQaM-7Rv0SyutgQjORBU=rZvq-dKs6RDjQA@mail.gmail.com>
Message-ID: <CAPBb6MVuyN+NdCrLQaM-7Rv0SyutgQjORBU=rZvq-dKs6RDjQA@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] media-request: Add a request complete operation
 to allow m2m scheduling
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, linux-sunxi@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>, robh+dt@kernel.org,
        mark.rutland@arm.com, Maxime Ripard <maxime.ripard@bootlin.com>,
        wens@csie.org, Pawel Osciak <pawel@osciak.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>, kyungmin.park@samsung.com,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>, p.zabel@pengutronix.de,
        arnd@arndb.de, Tomasz Figa <tfiga@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 12:43 AM Paul Kocialkowski <
paul.kocialkowski@bootlin.com> wrote:

> When using the request API in the context of a m2m driver, the
> operations that come with a m2m run scheduling call in their
> (m2m-specific) ioctl handler are delayed until the request is queued
> (for instance, this includes queuing buffers and streamon).

> Thus, the m2m run scheduling calls are not called in due time since the
> request AP's internal plumbing will (rightfully) use the relevant core
> functions directly instead of the ioctl handler.

> This ends up in a situation where nothing happens if there is no
> run-scheduling ioctl called after queuing the request.

> In order to circumvent the issue, a new media operation is introduced,
> called at the time of handling the media request queue ioctl. It gives
> m2m drivers a chance to schedule a m2m device run at that time.

> The existing req_queue operation cannot be used for this purpose, since
> it is called with the request queue mutex held, that is eventually needed
> in the device_run call to apply relevant controls.

> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>   drivers/media/media-request.c | 3 +++
>   include/media/media-device.h  | 2 ++
>   2 files changed, 5 insertions(+)

> diff --git a/drivers/media/media-request.c b/drivers/media/media-request.c
> index 415f7e31019d..28ac5ccfe6a2 100644
> --- a/drivers/media/media-request.c
> +++ b/drivers/media/media-request.c
> @@ -157,6 +157,9 @@ static long media_request_ioctl_queue(struct
media_request *req)
>                  media_request_get(req);
>          }

> +       if (mdev->ops->req_complete)
> +               mdev->ops->req_complete(req);
> +
>          return ret;
>   }

> diff --git a/include/media/media-device.h b/include/media/media-device.h
> index 07e323c57202..c7dcf2079cc9 100644
> --- a/include/media/media-device.h
> +++ b/include/media/media-device.h
> @@ -55,6 +55,7 @@ struct media_entity_notify {
>    * @req_alloc: Allocate a request
>    * @req_free: Free a request
>    * @req_queue: Queue a request
> + * @req_complete: Complete a request
>    */
>   struct media_device_ops {
>          int (*link_notify)(struct media_link *link, u32 flags,
> @@ -62,6 +63,7 @@ struct media_device_ops {
>          struct media_request *(*req_alloc)(struct media_device *mdev);
>          void (*req_free)(struct media_request *req);
>          int (*req_queue)(struct media_request *req);
> +       void (*req_complete)(struct media_request *req);

This is called *before* the request is actually run, isn't it? In that
case, wouldn't something like "req_schedule" be less confusing?
req_complete implies that the request is already completed.

Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DCDC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C132087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VnPkUlEH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2C132087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbeLCRlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:41:51 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:55694 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbeLCRlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:41:51 -0500
Received: by mail-it1-f193.google.com with SMTP id o19so10611250itg.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 09:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A0LMnZZgI+VCKBBiTAV+T5bexC7S5cpHgkaFauPJIKw=;
        b=VnPkUlEH+xHSkepxhigJFAVGt9BB+aNPX8gFgUx5deBTjpwA04z0e/2mhywHaROLrb
         5Ip9i55TxNqnLkWesrPIp2wyz+iZqvXamoO6H9r3H0NLlIK5VQ9g3qXDo5UJsU1EuVDI
         EqBtlAZ9VtV0uSPPO8Lri//l1jOq67aEAkGEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A0LMnZZgI+VCKBBiTAV+T5bexC7S5cpHgkaFauPJIKw=;
        b=TvE8tlF2FrGI7OtAGp7NPa8tzmWF3hMdaLINkSMiOZNraSSYlmb9ZMOvhhW4RFfw3s
         JQAus6+5JtEIOgjQSoIgUl/4+Gvy8i5dQhFS8qdIDN7rQQpNnivn1A6EHmJM04o5fST7
         YOgXxEVMOeCwliB9BKEMN2Vd7PiBefG6/P0avDOLXGQEM3a3nzb4Rr06lii7BFLEZ49D
         rarDMcSn6EOJEPvxZKMYdUHUllAf4A7MusiPGuYpUSNorX9JRQGO1M/X4+KeSTSn1jxI
         V5wKspEQbkAaLSdoBQWahA4nhnaWzpzwWjDJ8ABwLnQRYzGWk1ZGQyE70qvDASKCpaa0
         jPnA==
X-Gm-Message-State: AA+aEWaJEM0QKSBKchQ5vD7G84ImwFn22/MfT3GLb95YcraCq26PjDHo
        ULk50ZVjeCuJ2Po4rwogQx9aA4DXU4/YnoKBFyBUdg==
X-Google-Smtp-Source: AFSGD/UZcSlkSWn9IMl9KNq1Kw6fuNwlfsHyR6ET8/iw0Dvxk3yECtbvqMrv6K6GdcGCrnyCCJnD/DG5/ZdJVLiEPso=
X-Received: by 2002:a24:4e0d:: with SMTP id r13mr8228919ita.140.1543858908214;
 Mon, 03 Dec 2018 09:41:48 -0800 (PST)
MIME-Version: 1.0
References: <20181201005759.28093-1-eric@anholt.net> <20181201005759.28093-5-eric@anholt.net>
In-Reply-To: <20181201005759.28093-5-eric@anholt.net>
From:   Dave Emett <david.emett@broadcom.com>
Date:   Mon, 3 Dec 2018 17:41:36 +0000
Message-ID: <CAApk1dXjKeBN07LeycZgkCEOLEkdVjpvT_8Vu=8UStAY_ON15A@mail.gmail.com>
Subject: Re: [PATCH 5/6] drm/v3d: Add more tracepoints for V3D GPU rendering.
To:     Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Thomas Spurden <thomas.spurden@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Dec 2018 at 00:58, Eric Anholt <eric@anholt.net> wrote:
>
> The core scheduler tells us when the job is pushed to the scheduler's
> queue, and I had the job_run functions saying when they actually queue
> the job to the hardware.  By adding tracepoints for the very top of
> the ioctls and the IRQs signaling job completion, "perf record -a -e
> v3d:.\* -e gpu_scheduler:.\* <job>; perf script" gets you a pretty
> decent timeline.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>

Reviewed-by: Dave Emett <david.emett@broadcom.com>

> ---
>  drivers/gpu/drm/v3d/v3d_gem.c   |   4 ++
>  drivers/gpu/drm/v3d/v3d_irq.c   |  19 +++++-
>  drivers/gpu/drm/v3d/v3d_trace.h | 101 ++++++++++++++++++++++++++++++++
>  3 files changed, 121 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
> index 0bd6892e3044..2f82e2724b1f 100644
> --- a/drivers/gpu/drm/v3d/v3d_gem.c
> +++ b/drivers/gpu/drm/v3d/v3d_gem.c
> @@ -484,6 +484,8 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
>         struct drm_syncobj *sync_out;
>         int ret = 0;
>
> +       trace_v3d_submit_cl_ioctl(&v3d->drm, args->rcl_start, args->rcl_end);
> +
>         if (args->pad != 0) {
>                 DRM_INFO("pad must be zero: %d\n", args->pad);
>                 return -EINVAL;
> @@ -611,6 +613,8 @@ v3d_submit_tfu_ioctl(struct drm_device *dev, void *data,
>         int ret = 0;
>         int bo_count;
>
> +       trace_v3d_submit_tfu_ioctl(&v3d->drm, args->iia);
> +
>         job = kcalloc(1, sizeof(*job), GFP_KERNEL);
>         if (!job)
>                 return -ENOMEM;
> diff --git a/drivers/gpu/drm/v3d/v3d_irq.c b/drivers/gpu/drm/v3d/v3d_irq.c
> index dd7a7b0bd5a1..69338da70ddc 100644
> --- a/drivers/gpu/drm/v3d/v3d_irq.c
> +++ b/drivers/gpu/drm/v3d/v3d_irq.c
> @@ -15,6 +15,7 @@
>
>  #include "v3d_drv.h"
>  #include "v3d_regs.h"
> +#include "v3d_trace.h"
>
>  #define V3D_CORE_IRQS ((u32)(V3D_INT_OUTOMEM | \
>                              V3D_INT_FLDONE |   \
> @@ -88,12 +89,20 @@ v3d_irq(int irq, void *arg)
>         }
>
>         if (intsts & V3D_INT_FLDONE) {
> -               dma_fence_signal(v3d->bin_job->bin.done_fence);
> +               struct v3d_fence *fence =
> +                       to_v3d_fence(v3d->bin_job->bin.done_fence);
> +
> +               trace_v3d_bcl_irq(&v3d->drm, fence->seqno);
> +               dma_fence_signal(&fence->base);
>                 status = IRQ_HANDLED;
>         }
>
>         if (intsts & V3D_INT_FRDONE) {
> -               dma_fence_signal(v3d->render_job->render.done_fence);
> +               struct v3d_fence *fence =
> +                       to_v3d_fence(v3d->render_job->render.done_fence);
> +
> +               trace_v3d_rcl_irq(&v3d->drm, fence->seqno);
> +               dma_fence_signal(&fence->base);
>                 status = IRQ_HANDLED;
>         }
>
> @@ -119,7 +128,11 @@ v3d_hub_irq(int irq, void *arg)
>         V3D_WRITE(V3D_HUB_INT_CLR, intsts);
>
>         if (intsts & V3D_HUB_INT_TFUC) {
> -               dma_fence_signal(v3d->tfu_job->done_fence);
> +               struct v3d_fence *fence =
> +                       to_v3d_fence(v3d->tfu_job->done_fence);
> +
> +               trace_v3d_tfu_irq(&v3d->drm, fence->seqno);
> +               dma_fence_signal(&fence->base);
>                 status = IRQ_HANDLED;
>         }
>
> diff --git a/drivers/gpu/drm/v3d/v3d_trace.h b/drivers/gpu/drm/v3d/v3d_trace.h
> index f54ed9cd3444..edd984afa33f 100644
> --- a/drivers/gpu/drm/v3d/v3d_trace.h
> +++ b/drivers/gpu/drm/v3d/v3d_trace.h
> @@ -12,6 +12,28 @@
>  #define TRACE_SYSTEM v3d
>  #define TRACE_INCLUDE_FILE v3d_trace
>
> +TRACE_EVENT(v3d_submit_cl_ioctl,
> +           TP_PROTO(struct drm_device *dev, u32 ct1qba, u32 ct1qea),
> +           TP_ARGS(dev, ct1qba, ct1qea),
> +
> +           TP_STRUCT__entry(
> +                            __field(u32, dev)
> +                            __field(u32, ct1qba)
> +                            __field(u32, ct1qea)
> +                            ),
> +
> +           TP_fast_assign(
> +                          __entry->dev = dev->primary->index;
> +                          __entry->ct1qba = ct1qba;
> +                          __entry->ct1qea = ct1qea;
> +                          ),
> +
> +           TP_printk("dev=%u, RCL 0x%08x..0x%08x",
> +                     __entry->dev,
> +                     __entry->ct1qba,
> +                     __entry->ct1qea)
> +);
> +
>  TRACE_EVENT(v3d_submit_cl,
>             TP_PROTO(struct drm_device *dev, bool is_render,
>                      uint64_t seqno,
> @@ -42,6 +64,85 @@ TRACE_EVENT(v3d_submit_cl,
>                       __entry->ctnqea)
>  );
>
> +TRACE_EVENT(v3d_bcl_irq,
> +           TP_PROTO(struct drm_device *dev,
> +                    uint64_t seqno),
> +           TP_ARGS(dev, seqno),
> +
> +           TP_STRUCT__entry(
> +                            __field(u32, dev)
> +                            __field(u64, seqno)
> +                            ),
> +
> +           TP_fast_assign(
> +                          __entry->dev = dev->primary->index;
> +                          __entry->seqno = seqno;
> +                          ),
> +
> +           TP_printk("dev=%u, seqno=%llu",
> +                     __entry->dev,
> +                     __entry->seqno)
> +);
> +
> +TRACE_EVENT(v3d_rcl_irq,
> +           TP_PROTO(struct drm_device *dev,
> +                    uint64_t seqno),
> +           TP_ARGS(dev, seqno),
> +
> +           TP_STRUCT__entry(
> +                            __field(u32, dev)
> +                            __field(u64, seqno)
> +                            ),
> +
> +           TP_fast_assign(
> +                          __entry->dev = dev->primary->index;
> +                          __entry->seqno = seqno;
> +                          ),
> +
> +           TP_printk("dev=%u, seqno=%llu",
> +                     __entry->dev,
> +                     __entry->seqno)
> +);
> +
> +TRACE_EVENT(v3d_tfu_irq,
> +           TP_PROTO(struct drm_device *dev,
> +                    uint64_t seqno),
> +           TP_ARGS(dev, seqno),
> +
> +           TP_STRUCT__entry(
> +                            __field(u32, dev)
> +                            __field(u64, seqno)
> +                            ),
> +
> +           TP_fast_assign(
> +                          __entry->dev = dev->primary->index;
> +                          __entry->seqno = seqno;
> +                          ),
> +
> +           TP_printk("dev=%u, seqno=%llu",
> +                     __entry->dev,
> +                     __entry->seqno)
> +);
> +
> +TRACE_EVENT(v3d_submit_tfu_ioctl,
> +           TP_PROTO(struct drm_device *dev, u32 iia),
> +           TP_ARGS(dev, iia),
> +
> +           TP_STRUCT__entry(
> +                            __field(u32, dev)
> +                            __field(u32, iia)
> +                            ),
> +
> +           TP_fast_assign(
> +                          __entry->dev = dev->primary->index;
> +                          __entry->iia = iia;
> +                          ),
> +
> +           TP_printk("dev=%u, IIA 0x%08x",
> +                     __entry->dev,
> +                     __entry->iia)
> +);
> +
>  TRACE_EVENT(v3d_submit_tfu,
>             TP_PROTO(struct drm_device *dev,
>                      uint64_t seqno),
> --
> 2.20.0.rc1
>

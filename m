Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297DBC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC2192070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="WiOrp7C4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbfAHSWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:22:01 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:54734 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728752AbfAHSWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 13:22:01 -0500
Received: by mail-it1-f194.google.com with SMTP id i145so7667910ita.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 10:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XePhn5C1Lmxh/a5HZBqkApnTQigMZIbx/mg6hysE+pU=;
        b=WiOrp7C4HEza/moZWA1kHBqYAOpEz3CK58x4vwuKhGiDGhl30HjC2X8Sn9YzAFTEMw
         94vf4EiiRbLqZBjTzWBRMWyXuisImimiMj5/U3qMtFmzck1lnN71QO/iYBfuFKX0ucoM
         uSvneroZLPJQakfYHNDuhmTv0nUerw97rUhvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XePhn5C1Lmxh/a5HZBqkApnTQigMZIbx/mg6hysE+pU=;
        b=fELUEiEnTvmCmhergA+3P7uWN8I/cW/KQvZcuTC1DXZIqEKG+p899/XHBqK2v64R84
         8nqPCbASnpBT5DbULOqoSnZthGm6NJTPB/m2jtxca2uL2R4KIqS8SzN5MO7ixQ9HgJph
         2KQ8nLPadthsTtqjCUD9D7BMzd9DjiW6/Q2qx8R9wmm7AdjtXyk8rLXhPUcyPUH6oUfw
         di7rTMMRM30fAkrSEv+DqXAFAnqfLxw3X66fNnfR8RiJeufLx92Pzyhu1Z2uJU5xh411
         jeLUe9Ul5JV9Cr3zOQlvX0ayrbA9cmb3PmdCec1I8Ve0yAOGEvqClUK8ixuBS4aOL6jr
         rCDQ==
X-Gm-Message-State: AJcUukcG2+uBHY0Dh9KzKezJaZEROu4XV4X4NXH9a+eGnu1n6y7ksuaE
        nNcNm8B7nG1iL7DjDdHlOR9OtIu9/28J/WAydMDupw==
X-Google-Smtp-Source: ALg8bN44cazA5nwO2aB1U0yAcEqH9zV+3AnaEUo9PL2rMPxBmi+wpvi1fk2lcXfScvHk9nLliVZfgRZ7zvRhF20ZfpI=
X-Received: by 2002:a24:94cb:: with SMTP id j194mr2002607ite.117.1546971719925;
 Tue, 08 Jan 2019 10:21:59 -0800 (PST)
MIME-Version: 1.0
References: <20190108145056.2276-1-paul.kocialkowski@bootlin.com> <20190108145056.2276-2-paul.kocialkowski@bootlin.com>
In-Reply-To: <20190108145056.2276-2-paul.kocialkowski@bootlin.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 8 Jan 2019 19:21:48 +0100
Message-ID: <CAKMK7uE+=00wayXr4hUDiSj+s0PJbCEe9xqS1FFwd2cp3Om+ng@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] drm/vc4: Wait for display list synchronization
 when completing commit
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 3:51 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> During an atomic commit, the HVS is configured with a display list
> for the channel matching the associated CRTC. The Pixel Valve (CRTC)
> and encoder are also configured for the new setup at that time.
> While the Pixel Valve and encoder are reconfigured synchronously, the
> HVS is only reconfigured after the display list address (DISPLIST) has
> been updated to the current display list address (DISPLACTX), which is
> the responsibility of the hardware.
>
> The time frame during which the HVS is still running on its previous
> configuration but the CRTC and encoder have been reconfigured already
> can lead to a number of synchronization issues. They will eventually
> cause errors reported on the FIFOs, such as underruns.
>
> With underrun detection enabled (from Boris Brezillon's series), this
> leads to unreliable underrun detection with random false positives.
>
> To ensure a coherent state, wait for each enabled channel of the HVS
> to synchronize its current display list address. This fixes the issue
> of random underrun reporting on commits.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/gpu/drm/vc4/vc4_drv.h  |  1 +
>  drivers/gpu/drm/vc4/vc4_hvs.c  | 17 +++++++++++++++++
>  drivers/gpu/drm/vc4/vc4_kms.c  |  2 ++
>  drivers/gpu/drm/vc4/vc4_regs.h |  2 ++
>  4 files changed, 22 insertions(+)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
> index c24b078f0593..955f157f5ad0 100644
> --- a/drivers/gpu/drm/vc4/vc4_drv.h
> +++ b/drivers/gpu/drm/vc4/vc4_drv.h
> @@ -772,6 +772,7 @@ void vc4_irq_reset(struct drm_device *dev);
>  extern struct platform_driver vc4_hvs_driver;
>  void vc4_hvs_dump_state(struct drm_device *dev);
>  int vc4_hvs_debugfs_regs(struct seq_file *m, void *unused);
> +void vc4_hvs_sync_dlist(struct drm_device *dev);
>
>  /* vc4_kms.c */
>  int vc4_kms_load(struct drm_device *dev);
> diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
> index 5d8c749c9749..1ba60b8e0c2d 100644
> --- a/drivers/gpu/drm/vc4/vc4_hvs.c
> +++ b/drivers/gpu/drm/vc4/vc4_hvs.c
> @@ -166,6 +166,23 @@ static int vc4_hvs_upload_linear_kernel(struct vc4_hvs *hvs,
>         return 0;
>  }
>
> +void vc4_hvs_sync_dlist(struct drm_device *dev)
> +{
> +       struct vc4_dev *vc4 = to_vc4_dev(dev);
> +       unsigned int i;
> +       int ret;
> +
> +       for (i = 0; i < SCALER_CHANNELS_COUNT; i++) {
> +               if (!(HVS_READ(SCALER_DISPCTRLX(i)) & SCALER_DISPCTRLX_ENABLE))
> +                       continue;
> +
> +               ret = wait_for(HVS_READ(SCALER_DISPLACTX(i)) ==
> +                              HVS_READ(SCALER_DISPLISTX(i)), 1000);
> +               WARN(ret, "Timeout waiting for channel %d display list sync\n",
> +                    i);
> +       }
> +}
> +
>  static int vc4_hvs_bind(struct device *dev, struct device *master, void *data)
>  {
>         struct platform_device *pdev = to_platform_device(dev);
> diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
> index 0490edb192a1..2d66a2b57a91 100644
> --- a/drivers/gpu/drm/vc4/vc4_kms.c
> +++ b/drivers/gpu/drm/vc4/vc4_kms.c
> @@ -155,6 +155,8 @@ vc4_atomic_complete_commit(struct drm_atomic_state *state)
>
>         drm_atomic_helper_commit_hw_done(state);
>
> +       vc4_hvs_sync_dlist(dev);

From your description I'd have guessed you want this between when you
update the planes and the crtc, so somewhere between commit_planes()
and commit_modeset_enables(). At least I have no idea how waiting here
can prevent underruns, by this point there's no further hw programming
happening. Only exception is if you have an IOMMU which can fault, in
which case the cleanup_planes might remove the buffers prematurely.
But if that's the problem, then your semantics of the flip_done event
are wrong - when flip_done is signalled, the hw must have stopped
scanning out the old planes, since userspace expects to be able to
start overwriting/reusing them.
-Daniel

> +
>         drm_atomic_helper_wait_for_flip_done(dev, state);
>
>         drm_atomic_helper_cleanup_planes(dev, state);
> diff --git a/drivers/gpu/drm/vc4/vc4_regs.h b/drivers/gpu/drm/vc4/vc4_regs.h
> index 931088014272..50c653309aec 100644
> --- a/drivers/gpu/drm/vc4/vc4_regs.h
> +++ b/drivers/gpu/drm/vc4/vc4_regs.h
> @@ -212,6 +212,8 @@
>
>  #define PV_HACT_ACT                            0x30
>
> +#define SCALER_CHANNELS_COUNT                  3
> +
>  #define SCALER_DISPCTRL                         0x00000000
>  /* Global register for clock gating the HVS */
>  # define SCALER_DISPCTRL_ENABLE                        BIT(31)
> --
> 2.20.1
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch

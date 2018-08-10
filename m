Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FAFC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 21:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B8C21B32
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 21:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B8C21B32
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbeHKAK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 20:10:56 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39983 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbeHKAKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 20:10:55 -0400
Received: by mail-wm0-f67.google.com with SMTP id y9-v6so3230216wma.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 14:39:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gzdju55bYscpfUUNbtyh+5vSu2Al5jV5fsPuBY86HkA=;
        b=axyErnZkv54suadXTTZOwnN9jw4x75IcFqTiIrqRi+MlwDZP1rfeb2RlKJSBB0bM1d
         qDfvi/kI4+CJMFWPUt6flYmDVqiPoMLpWoAplG5mHZxXUD2zhY8MpsjngV+E+WDAFZzT
         0f3j3YWYZAysdh33OxpNAKByDTJwVDwzOqWlDLr3DG2VmO+qFvF5LmdAZPCSQRehHw8Z
         d2QS1Kl3uqw+IKP+v5kV/39vNqQXPB2WFJXS8v9aTK/FV567zLowsCLTSkoo+SSiShhn
         gPlYIRgjeT5O3D2HAdUt4Ep796VBdHxbePc5E5aCxOAQSOAstvL/NxKUY3nHKxzaNrsN
         iNhA==
X-Gm-Message-State: AOUpUlFwi6/sDstpX9oZ41pZ0wuU/t39YZ5NzbB67XjtAT05OxgplSBP
        ENZYs800+KpnkcLWGc6wBqApNKm5LJE5tsiPx+qicQ==
X-Google-Smtp-Source: AA+uWPz2qjtw+V+Gd/HhKZKqoZ+2MW1DRDcc4bXp0OPqYHTPbyvTIeipLD4tIkBLM/0IYoNei0f2lI4+V0XGGg5AG0Y=
X-Received: by 2002:a1c:be13:: with SMTP id o19-v6mr2362845wmf.1.1533937156336;
 Fri, 10 Aug 2018 14:39:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:28c2:0:0:0:0:0 with HTTP; Fri, 10 Aug 2018 14:39:15
 -0700 (PDT)
In-Reply-To: <20180807203914.2192-11-lyude@redhat.com>
References: <20180807203914.2192-1-lyude@redhat.com> <20180807203914.2192-11-lyude@redhat.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 10 Aug 2018 23:39:15 +0200
Message-ID: <CACO55tubLooNbmNvRUcN3VrUf466gfj9W_=9dy=EABE-vL+6VQ@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH v5 10/13] drm/nouveau: Use pm_runtime_get_noresume()
 in connector_detect()
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Karol Herbst <kherbst@redhat.com>

On Tue, Aug 7, 2018 at 10:39 PM, Lyude Paul <lyude@redhat.com> wrote:
> It's true we can't resume the device from poll workers in
> nouveau_connector_detect(). We can however, prevent the autosuspend
> timer from elapsing immediately if it hasn't already without risking any
> sort of deadlock with the runtime suspend/resume operations. So do that
> instead of entirely avoiding grabbing a power reference.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: stable@vger.kernel.org
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Karol Herbst <karolherbst@gmail.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_connector.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
> index 2a45b4c2ceb0..010d6db14cba 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
> @@ -572,12 +572,16 @@ nouveau_connector_detect(struct drm_connector *connector, bool force)
>                 nv_connector->edid = NULL;
>         }
>
> -       /* Outputs are only polled while runtime active, so acquiring a
> -        * runtime PM ref here is unnecessary (and would deadlock upon
> -        * runtime suspend because it waits for polling to finish).
> +       /* Outputs are only polled while runtime active, so resuming the
> +        * device here is unnecessary (and would deadlock upon runtime suspend
> +        * because it waits for polling to finish). We do however, want to
> +        * prevent the autosuspend timer from elapsing during this operation
> +        * if possible.
>          */
> -       if (!drm_kms_helper_is_poll_worker()) {
> -               ret = pm_runtime_get_sync(connector->dev->dev);
> +       if (drm_kms_helper_is_poll_worker()) {
> +               pm_runtime_get_noresume(dev->dev);
> +       } else {
> +               ret = pm_runtime_get_sync(dev->dev);
>                 if (ret < 0 && ret != -EACCES)
>                         return conn_status;
>         }
> @@ -655,10 +659,8 @@ nouveau_connector_detect(struct drm_connector *connector, bool force)
>
>   out:
>
> -       if (!drm_kms_helper_is_poll_worker()) {
> -               pm_runtime_mark_last_busy(connector->dev->dev);
> -               pm_runtime_put_autosuspend(connector->dev->dev);
> -       }
> +       pm_runtime_mark_last_busy(dev->dev);
> +       pm_runtime_put_autosuspend(dev->dev);
>
>         return conn_status;
>  }
> --
> 2.17.1
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau

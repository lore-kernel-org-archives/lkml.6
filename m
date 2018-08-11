Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC316C4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 09:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA1222399
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 09:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA1222399
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbeHKMJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 08:09:06 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42479 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbeHKMJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 08:09:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id e7-v6so10203231wrs.9
        for <linux-kernel@vger.kernel.org>; Sat, 11 Aug 2018 02:35:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=S7SkCJ3ir1x28haGtJLTyOmmtx9kdG+zsdKjnFjC0Lk=;
        b=sRNxhErVbQvHMizzeHMYwSrlR1D8uKN7uXkTh3uj961OvbBIz7YECloPOVZVq/hARn
         UAMc5Y+h0iLGM82gTYfVyxIq8YaiM6lWD2JaFidUuDONGMhoc8bd5QOPyC/AVuRCs3Nr
         M00ZLyJUYkXMhT90Gx0H5l3uA6/WA9NzsGXR5bLWZ0XVpf6BOYoz0UcyPvXgBP8qlUYM
         bLg9EPBt1OfirGSIFZEeaEb6bmCsvyMVX8yW5tjjcZLlwpeyGzmLgwx4/UlY6g3JuzR0
         2CsI4+fLcUdMDvTZpN4VgWVIYVDOxtALvmo6/OovgDWz9qaOEgwgj8baMxbDfYTDfx5d
         SGBA==
X-Gm-Message-State: AOUpUlG42+8Du9Y+SNGoOGC420oxHxR5tRCRWwtwmyPaPOfyQtX5vxoV
        bzAb4Jely5tLtNhVibrxccFw8xm5Y4NP8rNDgsSDAm334uk=
X-Google-Smtp-Source: AA+uWPxjSLWaXGS3IEQLTLRR8eUtU3Dm50GUEdIw1x5hEZXEcU9uIuAQAvXhv2qK1PpzMwdjrVG0andejfd8g4R/2go=
X-Received: by 2002:a5d:4e92:: with SMTP id e18-v6mr6533919wru.32.1533980127619;
 Sat, 11 Aug 2018 02:35:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:28c2:0:0:0:0:0 with HTTP; Sat, 11 Aug 2018 02:35:26
 -0700 (PDT)
In-Reply-To: <20180807203914.2192-14-lyude@redhat.com>
References: <20180807203914.2192-1-lyude@redhat.com> <20180807203914.2192-14-lyude@redhat.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Sat, 11 Aug 2018 11:35:26 +0200
Message-ID: <CACO55tthZMOSpU00nAXTPjfN0hfLEejETV=jT9shRDgucEdg7Q@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH v5 13/13] drm/nouveau: Call pm_runtime_get_noresume()
 from hpd handlers
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

On Tue, Aug 7, 2018 at 10:39 PM, Lyude Paul <lyude@redhat.com> wrote:
> We can't and don't need to try resuming the device from our hotplug
> handlers, but hotplug events are generally something we'd like to keep
> the device awake for whenever possible. So, grab a PM ref safely in our
> hotplug handlers using pm_runtime_get_noresume() and mark the device as
> busy once we're finished.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: stable@vger.kernel.org
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Karol Herbst <karolherbst@gmail.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_connector.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
> index 8409c3f2c3a1..5a8e8c1ad647 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
> @@ -1152,6 +1152,11 @@ nouveau_connector_hotplug(struct nvif_notify *notify)
>         const char *name = connector->name;
>         struct nouveau_encoder *nv_encoder;
>
> +       /* Resuming the device here isn't possible; but the suspend PM ops
> +        * will wait for us to finish our work before disabling us so this
> +        * should be enough
> +        */
> +       pm_runtime_get_noresume(drm->dev->dev);

what happens when pm_runtime_get_noresume is called nd the device is
suspended already? Do we have to take care of this here as well (like
simply aborting) or is it fine as it is?

>         nv_connector->hpd_task = current;
>
>         if (rep->mask & NVIF_NOTIFY_CONN_V0_IRQ) {
> @@ -1171,6 +1176,9 @@ nouveau_connector_hotplug(struct nvif_notify *notify)
>         }
>
>         nv_connector->hpd_task = NULL;
> +
> +       pm_runtime_mark_last_busy(drm->dev->dev);
> +       pm_runtime_put_autosuspend(drm->dev->dev);
>         return NVIF_NOTIFY_KEEP;
>  }
>
> --
> 2.17.1
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau

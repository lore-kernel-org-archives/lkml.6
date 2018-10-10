Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270D5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4BAC2075B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hm1Ve/Ym"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4BAC2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeJKCaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 22:30:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44676 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbeJKCaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 22:30:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id 63-v6so6936753wra.11;
        Wed, 10 Oct 2018 12:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FcxFELw4Gge1fMrmSblfThZVFGCBovpqW0A4OIVCrrM=;
        b=hm1Ve/YmZgPbUuQGQJHluK3mVczUMzZpcokOHdmuqC+LDKbT05MW3auWOufJbnevCp
         WKPXoZ24fU2FqByEeh4mHlupIk1APbSZfFDYMPxXm2oMy3Fy63tdTW2rsIk85fEG2iSZ
         qVKek8qPugf41tlQJH9On6zvFwpsFQKcQ5p6Ycpi3usTuoKDZWm9m5ad05uXcz1tKAUL
         /DsFBvxiPX+z5wfaHYWdQN1XFNtppLrHYXFK2MhqLYs1apyDer5L2bXHhUEuZGdzJPRe
         w7YYhJy9bthwCr0bBKGYyQd015cPpDAhQ3MvDBBoApLWQ3uUxirGRha7MTOuKxw+EUT4
         2BWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FcxFELw4Gge1fMrmSblfThZVFGCBovpqW0A4OIVCrrM=;
        b=D/NbpKVXnYG/gv8GM2Eh1NiEmw8QrYg7k7KbY2dyalNJYT/nfliFbYU8jCJ1/dstU/
         4lHy2sNHsct1hPE0NHytKWY3Un80wq8cOozORIWCfgXcX3k1Z3Sn51CKqPpnLyGUl0yR
         B2dYOnag9BqFrjeed5HxG75fkYP4SKRQVQ7Oq5dT7fO5B++YwakjhqA1xJfwCEJXT0HB
         ss/eU5uqdoX/iOfoc7dAWUWYNd1qjBAPTG8sRffAVo4SyNvioyumWStzCYRzYX/uRIuL
         84IcOOJZNmigO1zgGCa2rQbDtwj0mVjzLas0xTpy+35l6uqwhZr5XQNEpMorj4Qz93bt
         fGrw==
X-Gm-Message-State: ABuFfogq+B3lHRxJBFqSYuI1ieYxD1VuwKAqTI4iwPzcvyZ39Wq1l1ht
        JXYrRHaLVa9XvXJ5mJ/iw8VrrjeiPfdNkm78dj0=
X-Google-Smtp-Source: ACcGV62QM8S6BBd4UtE1OJ+pOHiu4zhX+XV1RVkyGCy8a+KVoht6GJ9mwfjG20ooG+teWbK0wYgyx622+CruLDCICVE=
X-Received: by 2002:a5d:52ce:: with SMTP id r14-v6mr23907998wrv.123.1539198404776;
 Wed, 10 Oct 2018 12:06:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180922004346.12288-1-lyude@redhat.com>
In-Reply-To: <20180922004346.12288-1-lyude@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 10 Oct 2018 15:06:32 -0400
Message-ID: <CADnq5_Ohjr2nnX=y2QeiUncVabADnJDdO+MZmT5ag+yCJL+cHA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Suppress keypresses from ACPI_VIDEO events
To:     Lyude <lyude@redhat.com>
Cc:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        "for 3.8" <stable@vger.kernel.org>, "Qu, Jim" <Jim.Qu@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Rex Zhu <Rex.Zhu@amd.com>,
        Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 8:44 PM Lyude Paul <lyude@redhat.com> wrote:
>
> Currently we return NOTIFY_DONE for any event which we don't think is
> ours. However, many laptops will send more then just an ATIF event and
> will also send an ACPI_VIDEO_NOTIFY_PROBE event as well. Since we don't
> check for this, we return NOTIFY_DONE which causes a keypress for the
> ACPI event to be propogated to userspace. This is the equivalent of
> someone pressing the display key on a laptop every time there's a
> hotplug event.
>
> So, check for ACPI_VIDEO_NOTIFY_PROBE events and suppress keypresses
> from them.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: stable@vger.kernel.org

Applied.  Thanks!  Sorry for the delay.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index 353993218f21..f008804f0b97 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -358,7 +358,9 @@ static int amdgpu_atif_get_sbios_requests(struct amdgpu_atif *atif,
>   *
>   * Checks the acpi event and if it matches an atif event,
>   * handles it.
> - * Returns NOTIFY code
> + *
> + * Returns:
> + * NOTIFY_BAD or NOTIFY_DONE, depending on the event.
>   */
>  static int amdgpu_atif_handler(struct amdgpu_device *adev,
>                                struct acpi_bus_event *event)
> @@ -372,11 +374,16 @@ static int amdgpu_atif_handler(struct amdgpu_device *adev,
>         if (strcmp(event->device_class, ACPI_VIDEO_CLASS) != 0)
>                 return NOTIFY_DONE;
>
> +       /* Is this actually our event? */
>         if (!atif ||
>             !atif->notification_cfg.enabled ||
> -           event->type != atif->notification_cfg.command_code)
> -               /* Not our event */
> -               return NOTIFY_DONE;
> +           event->type != atif->notification_cfg.command_code) {
> +               /* These events will generate keypresses otherwise */
> +               if (event->type == ACPI_VIDEO_NOTIFY_PROBE)
> +                       return NOTIFY_BAD;
> +               else
> +                       return NOTIFY_DONE;
> +       }
>
>         if (atif->functions.sbios_requests) {
>                 struct atif_sbios_requests req;
> @@ -385,7 +392,7 @@ static int amdgpu_atif_handler(struct amdgpu_device *adev,
>                 count = amdgpu_atif_get_sbios_requests(atif, &req);
>
>                 if (count <= 0)
> -                       return NOTIFY_DONE;
> +                       return NOTIFY_BAD;
>
>                 DRM_DEBUG_DRIVER("ATIF: %d pending SBIOS requests\n", count);
>
> --
> 2.17.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

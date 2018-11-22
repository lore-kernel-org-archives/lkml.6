Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7795DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3517220865
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ZWytbgTU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3517220865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405099AbeKVTMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 14:12:55 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:54021 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405086AbeKVTMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 14:12:55 -0500
Received: by mail-it1-f196.google.com with SMTP id g85so12998449ita.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 00:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v4klK6xFxSzgYgiv0rt7hN7g6hxIeJ+LKUwjjOZI/8Y=;
        b=ZWytbgTUBMQHxVhNY/uu9TRhVwzRxczNjV0rouM5qhn7m1Izv8Qelf1lPeaEebYhFy
         lya5nwN4yfZtSgnpSiucwPFLENEZQT1JH8SrIz6F2a0ICasSiaElNFGc1Ej6uWovUVc4
         64dKMmRnkRjKVZLm3KOnDaPiNqOcSXAa208lM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v4klK6xFxSzgYgiv0rt7hN7g6hxIeJ+LKUwjjOZI/8Y=;
        b=pf0iGW6fhn5OyTSM0sqDpu9a8RgrS/QI9vSzCKz9N/cwu97TU2YwucrFVzs7H3D9jW
         kIRJh7AMcwXE8r2MnUttcEvatBQuoZ/n9CpQAfpgJkys7pcpkuUwqkqprLRKWHcOpJcZ
         JOYi59Q6I5cftMtPFae2edzey+4c2heZSEyVgwQqB7a3cRUxPRctf5RaMOhvmthLwqCd
         unDFF1/LAgWt1SK6R1bHfI2whV618dpHeG3eUOMEQzphmYQYJJB/olfjKo9xwA4przbw
         UBo3gIgDDyQDEWbh2n2X7SW1v8bDBDsG1uchaowueyKSXomMrr1UBsskxHDscsM7iSL4
         R60w==
X-Gm-Message-State: AA+aEWbYNnzccEjGYQohnTIQQh5s6WI2c2jarvdyF1y9a64UE0ePSk2A
        JzxwyG3e/nNI64JqFtq4iOED0N3L7Udx2lDLRwh8xQ==
X-Google-Smtp-Source: AFSGD/Vt3THu2mDK3lC5B+1n+6Kou+72vuaxsatkDzWa3B49cPNLwDNBw6cnvfyKkgx7mQah3VjOD6IRAqr0GNf6/nM=
X-Received: by 2002:a24:21d4:: with SMTP id e203-v6mr7150652ita.51.1542875668730;
 Thu, 22 Nov 2018 00:34:28 -0800 (PST)
MIME-Version: 1.0
References: <20181113224613.28809-1-lyude@redhat.com>
In-Reply-To: <20181113224613.28809-1-lyude@redhat.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 22 Nov 2018 09:34:16 +0100
Message-ID: <CAKMK7uFAjG-tLMdUz7xf4E+1Lthnzx+cshobVG5BES9Mt=-fEg@mail.gmail.com>
Subject: Re: [PATCH] drm/dp_mst: Skip validating ports during destruction,
 just ref
To:     Lyude <lyude@redhat.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>, Dave Airlie <airlied@linux.ie>,
        Jerry Zuo <Jerry.Zuo@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 11:47 PM Lyude Paul <lyude@redhat.com> wrote:
>
> Jerry Zuo pointed out a rather obscure hotplugging issue that it seems I
> accidentally introduced into DRM two years ago.
>
> Pretend we have a topology like this:
>
> |- DP-1: mst_primary
>    |- DP-4: active display
>    |- DP-5: disconnected
>    |- DP-6: active hub
>       |- DP-7: active display
>       |- DP-8: disconnected
>       |- DP-9: disconnected
>
> If we unplug DP-6, the topology starting at DP-7 will be destroyed but
> it's payloads will live on in DP-1's VCPI allocations and thus require
> removal. However, this removal currently fails because
> drm_dp_update_payload_part1() will (rightly so) try to validate the port
> before accessing it, fail then abort. If we keep going, eventually we
> run the MST hub out of bandwidth and all new allocations will start to
> fail (or in my case; all new displays just start flickering a ton).
>
> We could just teach drm_dp_update_payload_part1() not to drop the port
> ref in this case, but then we also need to teach
> drm_dp_destroy_payload_step1() to do the same thing, then hope no one
> ever adds anything to the that requires a validated port reference in
> drm_dp_destroy_connector_work(). Kind of sketchy.
>
> So let's go with a more clever solution: any port that
> drm_dp_destroy_connector_work() interacts with is guaranteed to still
> exist in memory until we say so. While said port might not be valid we
> don't really care: that's the whole reason we're destroying it in the
> first place! So, teach drm_dp_get_validated_port_ref() to use the all
> mighty current_work() function to avoid attempting to validate ports
> from the context of mgr->destroy_connector_work. I can't see any
> situation where this wouldn't be safe, and this avoids having to play
> whack-a-mole in the future of trying to work around port validation.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Fixes: 263efde31f97 ("drm/dp/mst: Get validated port ref in drm_dp_update_payload_part1()")
> Reported-by: Jerry Zuo <Jerry.Zuo@amd.com>
> Cc: Jerry Zuo <Jerry.Zuo@amd.com>
> Cc: Harry Wentland <Harry.Wentland@amd.com>
> Cc: <stable@vger.kernel.org> # v4.6+

Hm, sounds very similar to the bug I pointed out in your "make vcpi
alloc more atomic" series. Will this all interact nicely with the
solution we've worked out there (where we need to delay at least the
kfree(port) until the last vcpi allocation is released?
-Daniel

> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 529414556962..08978ad72f33 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -1023,9 +1023,20 @@ static struct drm_dp_mst_port *drm_dp_mst_get_port_ref_locked(struct drm_dp_mst_
>  static struct drm_dp_mst_port *drm_dp_get_validated_port_ref(struct drm_dp_mst_topology_mgr *mgr, struct drm_dp_mst_port *port)
>  {
>         struct drm_dp_mst_port *rport = NULL;
> +
>         mutex_lock(&mgr->lock);
> -       if (mgr->mst_primary)
> -               rport = drm_dp_mst_get_port_ref_locked(mgr->mst_primary, port);
> +       /*
> +        * Port may or may not be 'valid' but we don't care about that when
> +        * destroying the port and we are guaranteed that the port pointer
> +        * will be valid until we've finished
> +        */
> +       if (current_work() == &mgr->destroy_connector_work) {
> +               kref_get(&port->kref);
> +               rport = port;
> +       } else if (mgr->mst_primary) {
> +               rport = drm_dp_mst_get_port_ref_locked(mgr->mst_primary,
> +                                                      port);
> +       }
>         mutex_unlock(&mgr->lock);
>         return rport;
>  }
> --
> 2.19.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch

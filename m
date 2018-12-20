Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E048C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE8482177E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="hlQur/3E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731179AbeLTKvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 05:51:10 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34402 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbeLTKvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 05:51:09 -0500
Received: by mail-ed1-f65.google.com with SMTP id b3so1343881ede.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 02:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=bPF42D8AWGi4XMchKt+pJ7HO9dueK5LAGbc/YbLe+qY=;
        b=hlQur/3Ecrp26LMth8aj1k2Kl0+KYFwI3zfm3Sob02KyArNvacd5qoOqY0/kaVwpAD
         68OgBtj4zsdrDQeNnPOQ3JkNPUtc/gtB3t3KWaZoqJCbOQ/dD+GSJFa2mQU+EgoPEI9x
         b44aiZWK3dnAy5UEB61qRmn/157NLV2N3J6Ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=bPF42D8AWGi4XMchKt+pJ7HO9dueK5LAGbc/YbLe+qY=;
        b=RzHMb+/gjrCncRcZXHxiMAhwpyYPHwtbwEedW8S9k/gP3jXmaURp/8kg23gr4+CiLy
         K9pShNm7S8fPlIeGJLR9AyiMqb5d7UIjIblnfJZmFfGhj0JpJx1/kmNd/3GA/Tvr3bvT
         ZsnwfUOz47bj0YbB5t9cTWIWu03OiMf8i9YKr8Uaq4offmM9GonxaQs7/nJLrdtFARzQ
         oRb2qjKmCpOv7aLzahZ2XridGcmeK6L6nOnICAZtKie9nyLz7U3ygnAdh4uNtOx3rhaq
         XhT9hJ6+2i9U+t125ImMIYKcbbF2oABkPnT0i2EhQ1yI/UqS2GfG1pIv/FcQnMk515LU
         0H5Q==
X-Gm-Message-State: AA+aEWYjUxc2V/HAGFff3yEr+b2vcUE6DGzw/MVk13wcWaFClecvE+AI
        2mngSDBgJN6HbfXNQNNkNmo0BA==
X-Google-Smtp-Source: AFSGD/UasvO3k5VkfcrATTOZOmzvWpGzziYX6RuMmKdY9XIjdROP1xfbcMK33eQN51ZK626FLaDuOA==
X-Received: by 2002:a05:6402:3d1:: with SMTP id t17mr23757616edw.21.1545303067508;
        Thu, 20 Dec 2018 02:51:07 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x30sm6182376edd.30.2018.12.20.02.51.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 02:51:06 -0800 (PST)
Date:   Thu, 20 Dec 2018 11:51:04 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, andr2000@gmail.com,
        daniel.vetter@ffwll.ch, David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] drm/bochs: add edid present check
Message-ID: <20181220105104.GI21184@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, andr2000@gmail.com,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20181220101122.16153-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220101122.16153-1-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 11:11:21AM +0100, Gerd Hoffmann wrote:
> Check header before trying to read the complete edid blob, to avoid the
> log being spammed in case qemu has no edid support (old qemu or edid
> support turned off).
> 
> Fixes: 01f23459cf drm/bochs: add edid support.
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/bochs/bochs_hw.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
> index c90a0d492f..d0b4e1cee8 100644
> --- a/drivers/gpu/drm/bochs/bochs_hw.c
> +++ b/drivers/gpu/drm/bochs/bochs_hw.c
> @@ -86,9 +86,16 @@ static int bochs_get_edid_block(void *data, u8 *buf,
>  
>  int bochs_hw_load_edid(struct bochs_device *bochs)
>  {
> +	u8 header[8];
> +
>  	if (!bochs->mmio)
>  		return -1;
>  
> +	/* check header to detect whenever edid support is enabled in qemu */
> +	bochs_get_edid_block(bochs, header, 0, ARRAY_SIZE(header));
> +	if (drm_edid_header_is_valid(header) != 8)
> +		return -1;
> +
>  	kfree(bochs->edid);
>  	bochs->edid = drm_do_get_edid(&bochs->connector,
>  				      bochs_get_edid_block, bochs);
> -- 
> 2.9.3
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AB7C282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0863F218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="gArcX+7f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfAYQJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 11:09:52 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:41684 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfAYQJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 11:09:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=zcy8HKQUdBHlJJOMkh7XP4QKAs+yKn8Q4aUXTkATKfo=;
        b=gArcX+7f2y2OQ6qLhEAEJc5OmMdrbvg75SLdkyhIheEZH3NaGfUT5FI28+GDYELNvkkqdxUx30wGK2jny+dqiK00qm1nVQ1Pg5oJNeoNdvCByBe9CCSwtcA/4r1op9BzCXTeQ9n0EZDwNhZodjEwvM/U1aA0OF9wzMCon1Ffy5CWd1Thu1hED4nyYN4QaJz3tJItGgaIhcXIPF3VFxIRGL1CePOtG1xlDxcEA4Yu37ZtYXeB8aqf5MBWXvGOicFOEhKZDhk+5WIvkswReTlCE/NMkPSYzJoixv4te4bwkTWWfza837wFqaOTtTwZeyWLjzvAWW9X4NkO6te4fWs1Bw==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:49436 helo=[192.168.10.176])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1gn43C-000652-Ad; Fri, 25 Jan 2019 17:09:50 +0100
Subject: Re: [PATCH v3 10/23] drm/qxl: move qxl_primary_apply_cursor to
 correct place
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>
References: <20190118122020.27596-1-kraxel@redhat.com>
 <20190118122020.27596-11-kraxel@redhat.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <b3c756b3-c7b6-f4d3-5208-c8de0168d655@tronnes.org>
Date:   Fri, 25 Jan 2019 17:09:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190118122020.27596-11-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 18.01.2019 13.20, skrev Gerd Hoffmann:
> The cursor must be set again after creating the primary surface.
> Also drop the error message.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/qxl/qxl_display.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
> index 86bfc19bea..1b700ef503 100644
> --- a/drivers/gpu/drm/qxl/qxl_display.c
> +++ b/drivers/gpu/drm/qxl/qxl_display.c
> @@ -533,7 +533,6 @@ static void qxl_primary_atomic_update(struct drm_plane *plane,
>  	    .x2 = plane->state->fb->width,
>  	    .y2 = plane->state->fb->height
>  	};
> -	int ret;
>  	bool same_shadow = false;
>  
>  	if (old_state->fb) {
> @@ -554,16 +553,13 @@ static void qxl_primary_atomic_update(struct drm_plane *plane,
>  		if (!same_shadow)
>  			qxl_io_destroy_primary(qdev);
>  		bo_old->is_primary = false;
> -
> -		ret = qxl_primary_apply_cursor(plane);
> -		if (ret)
> -			DRM_ERROR(
> -			"could not set cursor after creating primary");
>  	}
>  
>  	if (!bo->is_primary) {
> -		if (!same_shadow)
> +		if (!same_shadow) {
>  			qxl_io_create_primary(qdev, 0, bo);
> +			qxl_primary_apply_cursor(plane);
> +		}
>  		bo->is_primary = true;
>  	}
>  
> 

I don't see how the commit message matches what you're doing. It gives
the impression that it must be applied under yet another condition, but
the condition for applying the cursor is changed from bo_old->is_primary
to !bo->is_primary.
It probably makes sense to someone that knows the driver.

Acked-by: Noralf Trønnes <noralf@tronnes.org>

Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6DEC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C3F720C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C3F720C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chris-wilson.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732959AbeGKOxj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:53:39 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:57565 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732321AbeGKOxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:53:39 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 12321868-1500050 
        for multiple; Wed, 11 Jul 2018 15:48:35 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Dominique Martinet <asmadeus@codewreck.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <1531295175-24052-1-git-send-email-asmadeus@codewreck.org>
Cc:     David Airlie <airlied@linux.ie>, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dominique Martinet <asmadeus@codewreck.org>
References: <1531295175-24052-1-git-send-email-asmadeus@codewreck.org>
Message-ID: <153132051066.18500.1587767829295271001@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH] i915/intel_tv_get_modes: fix strncpy truncation warning
Date:   Wed, 11 Jul 2018 15:48:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dominique Martinet (2018-07-11 08:46:15)
> This is effectively no-op as the next line writes a nul at the final
> byte of the buffer, so copying one letter less does not change the
> behaviour.
> 
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> ---
> 
> gcc 8 gives the following warning, which I am not sure why is treated
> as error for this file, thus making me fix it:
> drivers/gpu/drm/i915/intel_tv.c: In function ‘intel_tv_get_modes’:
> drivers/gpu/drm/i915/intel_tv.c:1358:3: error: ‘strncpy’ specified bound 32 equals destination size [-Werror=stringop-truncation]
>    strncpy(mode_ptr->name, input->name, DRM_DISPLAY_MODE_LEN);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> 
> Also, as a side note, while checking if this was already sent I stumbled
> uppon this: https://lists.freedesktop.org/archives/intel-gfx/2018-July/170638.html
> ([Intel-gfx] [PATCH i-g-t 6/7] Fix truncate string in the strncpy)
> which replaces strncpy(dest, src, sizeof(dest)) by strncpy(dest, src,
> strlen(dest))... This isn't for linux but this looks like a pretty bad
> idea to me... (I'm not on the list to reply there, sorry)
> 
>  drivers/gpu/drm/i915/intel_tv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/intel_tv.c b/drivers/gpu/drm/i915/intel_tv.c
> index b55b5c157e38..f5614d07b10d 100644
> --- a/drivers/gpu/drm/i915/intel_tv.c
> +++ b/drivers/gpu/drm/i915/intel_tv.c
> @@ -1355,7 +1355,7 @@ intel_tv_get_modes(struct drm_connector *connector)
>                 mode_ptr = drm_mode_create(connector->dev);
>                 if (!mode_ptr)
>                         continue;
> -               strncpy(mode_ptr->name, input->name, DRM_DISPLAY_MODE_LEN);
> +               strncpy(mode_ptr->name, input->name, DRM_DISPLAY_MODE_LEN - 1);

strlcpy
-Chris

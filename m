Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC087ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD1321523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="JGNaxMj+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FD1321523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbeJQPNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:13:38 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39364 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbeJQPNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 11:13:37 -0400
Received: by mail-ed1-f65.google.com with SMTP id d15-v6so23822965edq.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 00:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=T6c+GU8JZhD8uHReyFIcJ2HPk1WshB0U4Y56teW+0Ec=;
        b=JGNaxMj+sznvG+GURcvnKQdkvWGdMZ+VcagVYChQ80nrQQW+0o3Ba0/AOWGPDbn4Xh
         xetVLQbVpCOdPPkmOnEAa/0CaLu7RP5NgtkW9xFlHewpsNLBbpxmYnWGu34bWGUz+CCR
         GhH6GwqgWPxNaGmxnOtrSQsIbLpgAhz8Tylrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=T6c+GU8JZhD8uHReyFIcJ2HPk1WshB0U4Y56teW+0Ec=;
        b=ai/ZplU8bLCmR7vWJwD8NePZ+N4oYYDalSPBw8jE1j4zU4oGoo3dWS5Ne+cWbOmvWt
         jg284pf6xwEiOj+6WlUn1O2xY46O9DWz9VZtwBL3HfbBPvPFllLvJ+gbd6voIjm/o2cV
         7a5QVpMbCTd1X21dLD7/CvT41zpnNuY4czX+IFqOVg/nhSvE6GtaHWTGkOvHMq2ZKAFW
         MRcPt7qa9VGV+w/DrwgykOJgaIfidyiX8IuPYx8QhxuWv4wZq7QOC+A2KRS3/g1akURq
         ZPLI7aTsx/aIGZpyfmcIQBvrMQkbfwmWYD8z3OXoVuboAUvTZlrqCDeuS4CMSycMPsVt
         xrMQ==
X-Gm-Message-State: ABuFfogfSlQJYaMoLEvWmpPfYleh9qPIkjMJ93vWnVbxBux8q9hol5j8
        dnLNpM1PfnZymP05GIKpGrA6fke8CtE=
X-Google-Smtp-Source: ACcGV61/SnEwK1sjYZVQBB4qReqHB8Xez8uac28GVMiikGiKlqXLiPhaynlsnTNBBo3VsfXBTSbeIA==
X-Received: by 2002:a50:b64f:: with SMTP id c15-v6mr34597754ede.288.1539760758883;
        Wed, 17 Oct 2018 00:19:18 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id v3-v6sm3433063ejq.40.2018.10.17.00.19.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 00:19:17 -0700 (PDT)
Date:   Wed, 17 Oct 2018 09:19:16 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/bufs: Fix Spectre v1 vulnerability
Message-ID: <20181017071916.GI31561@phenom.ffwll.local>
Mail-Followup-To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20181016095549.GA23586@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016095549.GA23586@embeddedor.com>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 11:55:49AM +0200, Gustavo A. R. Silva wrote:
> idx can be indirectly controlled by user-space, hence leading to a
> potential exploitation of the Spectre variant 1 vulnerability.
> 
> This issue was detected with the help of Smatch:
> 
> drivers/gpu/drm/drm_bufs.c:1420 drm_legacy_freebufs() warn: potential
> spectre issue 'dma->buflist' [r] (local cap)
> 
> Fix this by sanitizing idx before using it to index dma->buflist
> 
> Notice that given that speculation windows are large, the policy is
> to kill the speculation on the first load and not worry if it can be
> completed with a dependent load/store [1].
> 
> [1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied since it's correct, but I dropped the cc: stable. This code is
very dead and full of security issues, and spectre is the least of your
worries. If you want to a stab at fixing the real spectre issues in drm,
then look anywhere that isn't full of drm_legacy_* functions.

The most important file is probably drm_ioctl.c.
-Daniel

> ---
>  drivers/gpu/drm/drm_bufs.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_bufs.c b/drivers/gpu/drm/drm_bufs.c
> index 7412aca..d7d10ca 100644
> --- a/drivers/gpu/drm/drm_bufs.c
> +++ b/drivers/gpu/drm/drm_bufs.c
> @@ -36,6 +36,8 @@
>  #include <drm/drmP.h>
>  #include "drm_legacy.h"
>  
> +#include <linux/nospec.h>
> +
>  static struct drm_map_list *drm_find_matching_map(struct drm_device *dev,
>  						  struct drm_local_map *map)
>  {
> @@ -1417,6 +1419,7 @@ int drm_legacy_freebufs(struct drm_device *dev, void *data,
>  				  idx, dma->buf_count - 1);
>  			return -EINVAL;
>  		}
> +		idx = array_index_nospec(idx, dma->buf_count);
>  		buf = dma->buflist[idx];
>  		if (buf->file_priv != file_priv) {
>  			DRM_ERROR("Process %d freeing buffer not owned\n",
> -- 
> 2.7.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

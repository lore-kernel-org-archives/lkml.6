Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323E1C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E696C2147C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="WThiPVrv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E696C2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbeLNIf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 03:35:59 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46786 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbeLNIf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 03:35:59 -0500
Received: by mail-ed1-f66.google.com with SMTP id o10so4239087edt.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 00:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=a+mFNmUevWa0Q8JtSm+PvQ2RmPSbBdvcBYcdTdDpGtI=;
        b=WThiPVrvKOY/ootaKYQI/S8dllUFxsfTiwgzoYHmlwYt1KZJsha2nxXOkYp+vkAUg6
         C9T0QIbmCW22R3ov67TjD2Te+clHm73oE9WT5QYTgIPwNduM5AhdbIVPCdvGgAA2VIqH
         nBqDG66sbp+5aD5kZwQyG/PE0BwhVDIojFDNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=a+mFNmUevWa0Q8JtSm+PvQ2RmPSbBdvcBYcdTdDpGtI=;
        b=Cd8SbfWe+jRaJeJqZNeMcX3LDFPuBzkgQWs0c+alea+40zvc5dRcDx5C7v6vMnMS1a
         cKpVqtYHKbn5p9YTDP+bLwL8m1qYTQkNle9iQ4psIvNF/ilf9b59VeQI5y6tf5suvlGx
         X3SM/CQ1/fGrfRi3WcygI6Rp3OWZqDEIarqFqdMprO61KEV1tub43bHOQ/GEi2GhkNK1
         fgSixvSBHef1ljJb4vKsZc+/R3ws2kMXfVNRWts/NqjHNIss4hFi3+qzlGsX5ram3sA7
         BDuE0FdNEYuwX9cuwouLgQoUmWUcSgGH4BJrkjvtcY8derQi9XbqWy3MyYyKfot201gq
         eykQ==
X-Gm-Message-State: AA+aEWZGiAICTZUoCi3yFN4J1upE/9NN71xJAbEW3kzwvrO65sUUGCuf
        iI80/xMhfNvBj3i0hPTn/miy+g==
X-Google-Smtp-Source: AFSGD/WE/UArqCwp+bQ/DQ/f4XU8j0UYSrcDgIWrUzdDMTkYhekBqSrpxz6xVvf0SFV/fdqgEgmiZQ==
X-Received: by 2002:a17:906:44d:: with SMTP id e13-v6mr1773292eja.197.1544776557311;
        Fri, 14 Dec 2018 00:35:57 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id a11sm1293605edc.28.2018.12.14.00.35.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 00:35:56 -0800 (PST)
Date:   Fri, 14 Dec 2018 09:35:54 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH] drm: Remove complete task from TODO
 documentation
Message-ID: <20181214083554.GJ21184@phenom.ffwll.local>
Mail-Followup-To: Shayenne da Luz Moura <shayenneluzmoura@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
References: <20181213225537.nq4dwidn6tma33iv@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213225537.nq4dwidn6tma33iv@smtp.gmail.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 08:55:37PM -0200, Shayenne da Luz Moura wrote:
> This patch remove the follow complete task from TODO documentation:
> 
>   drm_mode_config.crtc_idr is misnamed, since it contains all KMS object.
>   Should be renamed to drm_mode_config.object_idr.
> 
> Signed-off-by: Shayenne da Luz Moura <shayenneluzmoura@gmail.com>

Applied, thanks for your patch.
-Daniel

> ---
>  Documentation/gpu/todo.rst | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
> index 14191b64446d..41da7b06195c 100644
> --- a/Documentation/gpu/todo.rst
> +++ b/Documentation/gpu/todo.rst
> @@ -354,9 +354,6 @@ KMS cleanups
>  
>  Some of these date from the very introduction of KMS in 2008 ...
>  
> -- drm_mode_config.crtc_idr is misnamed, since it contains all KMS object. Should
> -  be renamed to drm_mode_config.object_idr.
> -
>  - drm_display_mode doesn't need to be derived from drm_mode_object. That's
>    leftovers from older (never merged into upstream) KMS designs where modes
>    where set using their ID, including support to add/remove modes.
> -- 
> 2.19.2
> 
> -- 
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20181213225537.nq4dwidn6tma33iv%40smtp.gmail.com.
> For more options, visit https://groups.google.com/d/optout.

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

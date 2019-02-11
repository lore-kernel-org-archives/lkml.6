Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFC3C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 809082146F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="f2XM3G0J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfBKIaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 03:30:23 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35384 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfBKIaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 03:30:23 -0500
Received: by mail-ed1-f67.google.com with SMTP id b17so8115794eds.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 00:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=t9k0g+iymdAgx/ken/KOmfjkpVz8WbOyAfnn9zH+2Rw=;
        b=f2XM3G0JZ+vF65A9vT2PoKiOnAQBrXNhEl/P6EOJgp1gh31+o9hMIrAL2CVLDdxu7h
         jXKd4fFd0mDfAI/hhmdrrTjzT9fVAihI81v5xG/qdg8Dt5bqM2xU9qek6vZeYqwLMzYf
         neqjheQoqLzENLpagmoWQed2wh9fJ7kra3qO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=t9k0g+iymdAgx/ken/KOmfjkpVz8WbOyAfnn9zH+2Rw=;
        b=qOxpxM427a/OIPDRHLpOtDt1DjMyAtnqyyRsLcFCfy78PXPduH8/fUfY/Md1FOhmtz
         vYrHeccyQio+Ve4Tnqp0g+JsGGUMRlcCKSTHilt1pbNMS801QVfVGjxr3aVw2C98CqSz
         iVmuQOQyG7WIOf3WeL50VW1LbcvuKHX0ALYCFYxAPkyB4CWFuVNukOA6D5RFrSNGp1Th
         L8Hh+Bl5xsM3DRmRg5fc/jb2wBi8Ksky/uH4Q/AxjwoXUJT1FqRYxm4MN9l+8TG/vaFb
         wa/amEpUxKvlYR2pxFnAdq4i7e7q6EB/3uNK2UaVx2dGoNfqdvYVBo5oeuxYhG7Emf4s
         zJ8g==
X-Gm-Message-State: AHQUAua5YqgQ9wSRKYtopwejO4jRiNdrvcz4AHpGq52NT+HUksTL39mQ
        LLQtzke3ZiDMmPZgpV60IDUzGA==
X-Google-Smtp-Source: AHgI3IbIT7BBI6W6lKCNyNHdmlEboFXsUibMcPF+nAInwgiaTAVxpP/iBc7KnyPM9N9EHb6O2BwQWg==
X-Received: by 2002:a17:906:bb08:: with SMTP id jz8mr1966330ejb.181.1549873821290;
        Mon, 11 Feb 2019 00:30:21 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id z15sm2224180eju.7.2019.02.11.00.30.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 00:30:20 -0800 (PST)
Date:   Mon, 11 Feb 2019 09:30:18 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Shayenne Moura <shayenneluzmoura@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Corbet <corbet@lwn.net>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/doc: Remove solved KMS cleanup task
Message-ID: <20190211083018.GP23159@phenom.ffwll.local>
Mail-Followup-To: Shayenne Moura <shayenneluzmoura@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190208195312.aqv7acr3hgion5yz@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208195312.aqv7acr3hgion5yz@smtp.gmail.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 05:53:12PM -0200, Shayenne Moura wrote:
> Remove KMS cleanup task from documentation solved by patchset
> https://patchwork.freedesktop.org/series/54310/
> 
> Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>

Thanks for your patch, applied to drm-misc-next.
-Daniel

> ---
>  Documentation/gpu/todo.rst | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
> index cda4a37a02f0..159a4aba49e6 100644
> --- a/Documentation/gpu/todo.rst
> +++ b/Documentation/gpu/todo.rst
> @@ -398,10 +398,6 @@ KMS cleanups
>  
>  Some of these date from the very introduction of KMS in 2008 ...
>  
> -- drm_display_mode doesn't need to be derived from drm_mode_object. That's
> -  leftovers from older (never merged into upstream) KMS designs where modes
> -  where set using their ID, including support to add/remove modes.
> -
>  - Make ->funcs and ->helper_private vtables optional. There's a bunch of empty
>    function tables in drivers, but before we can remove them we need to make sure
>    that all the users in helpers and drivers do correctly check for a NULL
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

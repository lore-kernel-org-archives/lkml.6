Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40005C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C8FA206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="cH9Yl+Uv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfAIWYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 17:24:11 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41780 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfAIWYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 17:24:10 -0500
Received: by mail-ed1-f68.google.com with SMTP id a20so8600050edc.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 14:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Bis+LtvX+jpu/0z2zjn9gKHoEHHBokgt2vDbgtrOakc=;
        b=cH9Yl+Uv/O2seS+o88znAAIxNnvWmLiaBReHTsaLPoGhuwtQHARgg9MVyU9udKMWjF
         fsDBvV2iEjH1oECoxIhQGN5YTAZ5CjED0VzRSGrPl3q/z1Hm9HBqgVzaZcKCbSrzKAmh
         gIjzmXduzN4eytFs9tRpso7mTZ9U01+VNNxug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Bis+LtvX+jpu/0z2zjn9gKHoEHHBokgt2vDbgtrOakc=;
        b=I6KSPbxyLeRndFzZ2n9O/N/fjiK+MwwaHhdzQvbniGrHX57MyGQDehu/RdMUygVZr6
         0w5sHledhhHGOknacL+9oc4pzJXd+84H8I44vdI+w6K7IFSh/oHEAL4uEhRqsLXeWeei
         cx2OJT5m6aSvn4WPHjaJ2PzqFWTX0SGD43TXteg/EjpFsKttSpR6Vi2E7bWs6+ziPhvA
         K+CK15KqRGiDmd06SmzLJhIYteEUchPlJlJ7n93oat9qXyB1DtzBxLVnXuMeN9PpbdJE
         znMa9YSUqfFMai1x5KvgnqIpWYRI5Zt3MifiicUKjA+G8Ys+wwJYjW7uuOHtkI7lKkYJ
         0KMQ==
X-Gm-Message-State: AJcUukc+QIc6Brco/wMVSMkkzAwOad1TR0AmCc2nrLI+YSU2R6QxMA2E
        8fp2dZN9fM6l5vYXCdf5d46J5A==
X-Google-Smtp-Source: ALg8bN64HFH+4H4c8tNXqGNJq0F2zCxyAEx3yXp+dwW3+7UYquMuU8NwGCfdCQSCMalHHZVf6NfLXQ==
X-Received: by 2002:a50:951a:: with SMTP id u26mr7557675eda.4.1547072648704;
        Wed, 09 Jan 2019 14:24:08 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id n19-v6sm291861ejs.45.2019.01.09.14.24.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 14:24:07 -0800 (PST)
Date:   Wed, 9 Jan 2019 23:24:05 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 12/12] drm: remove drmP.h from drm_gem_cma_helper.h
Message-ID: <20190109222405.GB21184@phenom.ffwll.local>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20190108192939.15255-1-sam@ravnborg.org>
 <20190108192939.15255-13-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190108192939.15255-13-sam@ravnborg.org>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 08:29:39PM +0100, Sam Ravnborg wrote:
> With all dependencies fixed we can now remove
> drmP.h from drm_gem_cma_helper.h.
> It is replaced by the include files required,
> or forward declarations as appropritate.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Acked-by: Noralf Trønnes <noralf@tronnes.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>

Except for the ones I commented on, all patches applied. I also fixed the
one typo in the summary.

Thanks, Daniel
> ---
>  include/drm/drm_gem_cma_helper.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/drm/drm_gem_cma_helper.h b/include/drm/drm_gem_cma_helper.h
> index 07c504940ba1..947ac95eb24a 100644
> --- a/include/drm/drm_gem_cma_helper.h
> +++ b/include/drm/drm_gem_cma_helper.h
> @@ -2,9 +2,12 @@
>  #ifndef __DRM_GEM_CMA_HELPER_H__
>  #define __DRM_GEM_CMA_HELPER_H__
>  
> -#include <drm/drmP.h>
> +#include <drm/drm_file.h>
> +#include <drm/drm_ioctl.h>
>  #include <drm/drm_gem.h>
>  
> +struct drm_mode_create_dumb;
> +
>  /**
>   * struct drm_gem_cma_object - GEM object backed by CMA memory allocations
>   * @base: base GEM object
> -- 
> 2.12.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

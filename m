Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB0BC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689FC2098A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="BM13Ne8c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 689FC2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbeJEOZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 10:25:30 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35270 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728046AbeJEOZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 10:25:30 -0400
Received: by mail-ed1-f67.google.com with SMTP id y19-v6so10797158edd.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 00:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KQ1GeMVz2juF99OWvXYc8Hv1KZu82su4MZuApU1kMGE=;
        b=BM13Ne8cvZXBjtOSUfHejJAf0LMMenia7Jr5T1XTN/epN8LcNRJS0gzq3KH1/mbZoz
         wur3yBIqt9Id9WXtMvIBXZ16x5zrDAtyKH1I4Hm0vPu9vF6XFIUbkjA5uCOWC4gXlCIk
         NvTo2RAWJNwRpQQ6MI7mXcoAKFGQt5Xu1VhY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=KQ1GeMVz2juF99OWvXYc8Hv1KZu82su4MZuApU1kMGE=;
        b=HfKBmfo9tH5wY0A8LLr4xIIEE0zFvFmPfvsE0Ky2xrzCWPLqMRKlD3dYbJs9zxDtbe
         fc8SaSPuwgDjAK4IpCUQj+HXuvsz3SQ8IE/AwCZ4yYfFqQQI5kgBbHzzViXyxUmaZzhK
         GEEO2yuwMQwi2KL0HQyA6WNXtv+vqWrq5MEaNWzoIILjryZtIT5iA5oNv7PG34BHtB5n
         wnmvaoQWgzbr98abgtZgJ79Ee5LeBQpONsuXxLo0lKq8GYTrHAq4DR0OO8LXc2EjewuD
         lvh3bgI9jUSmrmD7CFjWJBkCQdPPCn/7ZE0yGQvjgI989CQDZg5+zeVdHarxpljfaCNd
         BwLg==
X-Gm-Message-State: ABuFfojm9abaOAYckMIQp8JyV1FVhF9Xa4bX6VCYRikZkVVQzXLaBNNV
        8R/dgeN3uLAfx9C36+p+hV7iGQ==
X-Google-Smtp-Source: ACcGV62r6d9JS6guhz3TOxITry4myReTbQ3hxoPbDM1XHt5fks+8RPbx/WadwwPBUXiIl4pU43GKDA==
X-Received: by 2002:a50:a2a6:: with SMTP id 35-v6mr12681674edm.276.1538724483518;
        Fri, 05 Oct 2018 00:28:03 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id h8-v6sm2123227edi.68.2018.10.05.00.28.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 00:28:02 -0700 (PDT)
Date:   Fri, 5 Oct 2018 09:28:00 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        stable@vger.kernel.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/5] drm/i915: Fix intel_dp_mst_best_encoder()
Message-ID: <20181005072800.GX31561@phenom.ffwll.local>
Mail-Followup-To: Lyude Paul <lyude@redhat.com>,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>, stable@vger.kernel.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
References: <20181005002956.7317-1-lyude@redhat.com>
 <20181005002956.7317-6-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005002956.7317-6-lyude@redhat.com>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 08:29:54PM -0400, Lyude Paul wrote:
> Currently, i915 appears to rely on blocking modesets on
> no-longer-present MSTB ports by simply returning NULL for
> ->best_encoder(), which in turn causes any new atomic commits that don't
> disable the CRTC to fail. This is wrong however, since we still want to
> allow userspace to disable CRTCs on no-longer-present MSTB ports by
> changing the DPMS state to off and this still requires that we retrieve
> an encoder.
> 
> So, fix this by always returning a valid encoder regardless of the state
> of the MST port.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: stable@vger.kernel.org
> 
> Changes since v1:
> - Remove mst atomic helper, since this got replaced with a much simpler
>   solution
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>

With the obvious rebase onto my bikeshed for patch 3:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>  drivers/gpu/drm/i915/intel_dp_mst.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/intel_dp_mst.c b/drivers/gpu/drm/i915/intel_dp_mst.c
> index a366f32b048a..daade60c5714 100644
> --- a/drivers/gpu/drm/i915/intel_dp_mst.c
> +++ b/drivers/gpu/drm/i915/intel_dp_mst.c
> @@ -407,8 +407,6 @@ static struct drm_encoder *intel_mst_atomic_best_encoder(struct drm_connector *c
>  	struct intel_dp *intel_dp = intel_connector->mst_port;
>  	struct intel_crtc *crtc = to_intel_crtc(state->crtc);
>  
> -	if (intel_connector->mst_port_gone)
> -		return NULL;
>  	return &intel_dp->mst_encoders[crtc->pipe]->base.base;
>  }
>  
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

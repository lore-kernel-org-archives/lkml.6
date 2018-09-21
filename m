Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC759C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C49A2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="WVuhb2yt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C49A2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389607AbeIUPSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 11:18:05 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44394 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388909AbeIUPSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 11:18:04 -0400
Received: by mail-ed1-f66.google.com with SMTP id s10-v6so10164841edb.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 02:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=SPtQf6JMVsxADNUbEwVSl/YcwHh/UX7t+P6PpvrtN0s=;
        b=WVuhb2ytX+aUWLYPSMxiXxRPtaIAGLONhRgN/fnr301pBKfba2+elm8N2Ty4xlfYi6
         LDWF0ukJQODdEeWrL3AZaos3gMGYac0P93ku2hIGPxmttvMDvrtUjDHrC5jkpmynErhF
         cp2wQ6vhMVbPB/DDsBFaa3z2K7Py1TYlN78Gw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=SPtQf6JMVsxADNUbEwVSl/YcwHh/UX7t+P6PpvrtN0s=;
        b=ovsKgocbklpMQGR/4L9YMBwfChUeceJDKaoeW66NzqzGSpu7XSGV8aWkZrc0wlscxk
         BTvoCdIl5UprP3QeWN6QCMuaADAbcSSarcAr8otOhBC/+8UiWuO/oUOL0izRk8+VKXxH
         o2s3C4+C7qDv7Pvgnv5Fx73cl5E/3fwyErHk1FYbpc2XYdLSxIxU7j474Ut+HEjc4Sx6
         jRCozrAI7NmT1fPXfE2iIeSjeiKz4tGLojZRtzqYO7TkheswN3W5SLg5xTwLgW0AjW/F
         +T2T0pYD71WygPIURf2KnzeBLOMUWROpwL/CRcuPyLAHOrtChuyJmMlSw1WrHc4d2nhJ
         gueA==
X-Gm-Message-State: APzg51BiG27a2YyQjEfWFWVAuzrVx4rVXVSrzdZfqpW80SwjnGV5ZnYX
        DbRDwMfV0lDovF2UqEUhr4xDAA==
X-Google-Smtp-Source: ANB0VdaefRwHWhhxqey4bLSkbwFpzQh5++BgUiZAKUixi6FSerJwMRhKAQqdOPuFtf41HymV9z+FCw==
X-Received: by 2002:a50:ba59:: with SMTP id 25-v6mr10078635eds.214.1537522204327;
        Fri, 21 Sep 2018 02:30:04 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id e38-v6sm1782241eda.74.2018.09.21.02.30.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 02:30:03 -0700 (PDT)
Date:   Fri, 21 Sep 2018 11:30:01 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     ning.a.zhang@intel.com
Cc:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/i915: set i915 driver probe to asynchronous
Message-ID: <20180921093001.GD11082@phenom.ffwll.local>
Mail-Followup-To: ning.a.zhang@intel.com, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20180919073712.25463-1-ning.a.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919073712.25463-1-ning.a.zhang@intel.com>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 03:37:12PM +0800, ning.a.zhang@intel.com wrote:
> From: Zhang Ning <ning.a.zhang@intel.com>
> 
> when i915 is built in module, and system has built-in display, eg. eDP,
> i915 will detect and active it during driver probe. it will take long
> time.
> 
> set i915 driver probe to asynchrous can save kernel initial time.
> 
> Signed-off-by: Zhang Ning <ning.a.zhang@intel.com>

Last time around this was proposed there was a very long discussion around
how this breaks the sound driver. Was this resolved? Definitely needs to
add this context to the commit message, and all people involved back then
added to the Cc: list. Searching for PROBE_PREFER_ASYNCHRONOUS in the
archives should dig it all up.

Thanks, Daniel
> ---
>  drivers/gpu/drm/i915/i915_pci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_pci.c
> index 6a4d1388ad2d..0f57d71d0abb 100644
> --- a/drivers/gpu/drm/i915/i915_pci.c
> +++ b/drivers/gpu/drm/i915/i915_pci.c
> @@ -738,6 +738,7 @@ static struct pci_driver i915_pci_driver = {
>  	.probe = i915_pci_probe,
>  	.remove = i915_pci_remove,
>  	.driver.pm = &i915_pm_ops,
> +	.driver.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>  };
>  
>  static int __init i915_init(void)
> -- 
> 2.18.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

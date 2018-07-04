Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9789C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E7B2064D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DbHhTvLc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E7B2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753652AbeGDJex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:34:53 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34214 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752904AbeGDJev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:34:51 -0400
Received: by mail-wr0-f196.google.com with SMTP id a12-v6so4636279wro.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 02:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4cG+YIVMeU+YnO+4+b/25sa+RJTfytYx4klsPRiiQV4=;
        b=DbHhTvLcAqr40kDXSruQYsUhAzfZhg/zi4TCQJYEathbJucQB0D0R5agGHQzIy+8DI
         G2tCE8ONGQ+OO30V9bK7oBelhZ859fI1KkrGwkH9hclpv1Ez9v9tT9IVNnfdVtaQ7IN/
         gEcVlUthfIMwTn3P4Ql5WarboOEhXZjs0WeXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4cG+YIVMeU+YnO+4+b/25sa+RJTfytYx4klsPRiiQV4=;
        b=oJMEKmXkLqjoxTThC2v1jGrj+yXzxKKyEMYc2u5MsBN/7ogZniHlT9kWPsHlUhKNZE
         sOu8m9rMSxMCvLzp/uez98jYJwsXDNB4+aGSPf2atg6uLZTDiaMhECC4nUfH1XOXWmfm
         FCsPTmxwg8+Q2HRGH9VOGzMwFWR4oSmMs5urtYuI7z57FvK7Uudv65VD5YxcYUss60jf
         E1FmhRxY4LmjbpxBl7oGL1bWvHQ4iNY6gNB2O7ojOyZdRxb7PuP5AFh83LO2mcKCvk58
         oGGWuCmixo9j9COX0dhENTKuEdhJVOmTjzSN4LpsCzM8qb2nT3r4bf9Vkvs1V+bd9Cxv
         SPVw==
X-Gm-Message-State: APt69E1Xr3Uz90w4UV2H2btIVE0XvS/ZsD3GZksfd+FGTFMxrWjKS6JX
        XgH0HovdFDYkzvRjni47bGWk/w==
X-Google-Smtp-Source: AAOMgpcArCiAcAm9jzhwLt7mQRfpMQWoG2fAlkdQfo4oV6WUCBhv9VPZnvPwwNg6NGV1IY2QZriGWQ==
X-Received: by 2002:adf:ea87:: with SMTP id s7-v6mr957476wrm.150.1530696890299;
        Wed, 04 Jul 2018 02:34:50 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id b16-v6sm4199698wrm.15.2018.07.04.02.34.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 02:34:49 -0700 (PDT)
Date:   Wed, 4 Jul 2018 10:34:47 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [PATCH] backlight: remove obsolete comment for ->state
Message-ID: <20180704093447.GU20176@dell>
References: <20180503141517.28207-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180503141517.28207-1-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Jani spotted this when reviewing my earlier patch to remove the driver
> internal usage of this field in
> 
> commit 3cf91adaa594e8933af1727942ac560e5c7bc70e
> Author: Daniel Vetter <daniel.vetter@ffwll.ch>
> Date:   Wed Apr 25 19:42:52 2018 +0200
> 
>     backlight: Nuke BL_CORE_DRIVER1

FYI, sending patches like this is not a good idea.

I'll clean it up for you this time, but in future please send patches
properly and place any additional comments you may have below the
'---' line.

> Cc: Jani Nikula <jani.nikula@intel.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> ---
>  include/linux/backlight.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> index 7fbf0539e14a..0b5897446dca 100644
> --- a/include/linux/backlight.h
> +++ b/include/linux/backlight.h
> @@ -79,7 +79,6 @@ struct backlight_properties {
>  	/* Backlight type */
>  	enum backlight_type type;
>  	/* Flags used to signal drivers of state changes */
> -	/* Upper 4 bits are reserved for driver internal use */
>  	unsigned int state;
>  
>  #define BL_CORE_SUSPENDED	(1 << 0)	/* backlight is suspended */

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

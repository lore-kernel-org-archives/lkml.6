Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9996C46475
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 08:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 793D82084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 08:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="PORQkwiT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 793D82084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbeJ2QwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 12:52:15 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36007 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729286AbeJ2QwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 12:52:15 -0400
Received: by mail-ed1-f68.google.com with SMTP id x2-v6so6431143eds.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 01:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rWzWUn0L4nUDcG9iBGzUS/TqgGBWSi8J+8UWTWX8x5w=;
        b=PORQkwiTTpY1Cbn6VY9wIMO2NzIyaZbGTUUTGvrd2amHMUnA9Bolun8u4k2eLRHObL
         wzumvr1vsXjiwD7FCNSUGaffcovUTfVCg9FmMBQaGVrGHrc5Adw6v4XjC/PyPBSueBof
         qYSI/oA1k+57nBoGCGmgZ42x3TF7bYAcfTafo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=rWzWUn0L4nUDcG9iBGzUS/TqgGBWSi8J+8UWTWX8x5w=;
        b=b1Tfjj/ms1i8Q7zFVN9FuqZp6/aCPuvLylNO4dVzZb71nMyk/FCskyhlas6LpCp38L
         1YPIdue+3gEkXI2HV0izaSSvuAPT0Et08vUTI5T+mKUZpfgLQYePGQn1cYGpYP0HfXyW
         jAPPHAD0eNTukpAHT4NuO63qgqwl7lLtWWYCqGK4BuxeL7ViauzrJwgxmaW94QGrTzRj
         1R1dOghQui8RxUVB7iAuuDe2GwN9/ivRjrvbv+uES9QJ3newP9PE5ICV+1i5O83IVZX/
         uwoO43YMRxVPUhgkFNe1w4hIsuv8U30rL82J/Ojr1laP4MKA1uAwebRroItjbIKZV1Pr
         JOYw==
X-Gm-Message-State: AGRZ1gK3O+JiO5afZ0Gkqd+ORUA6uzT/dhfoR1tdhXNRdO1Tvu6YnNvD
        /Bkmw+TT8olrthGG3XefcRwMMw==
X-Google-Smtp-Source: AJdET5fJmmF6+NepP36cQbx+Hmuv95JRiu2sVOLXiHsC4Mht9HEA2PC16LhXW2/PF/NBM5Uiio1Pzg==
X-Received: by 2002:a17:906:6582:: with SMTP id x2-v6mr10012534ejn.22.1540800281848;
        Mon, 29 Oct 2018 01:04:41 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id u7-v6sm1168465edo.40.2018.10.29.01.04.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 01:04:41 -0700 (PDT)
Date:   Mon, 29 Oct 2018 09:04:39 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Colin King <colin.king@canonical.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpu: drm/lease: fix spelling mistake, EACCESS -> EACCES
Message-ID: <20181029080439.GP21967@phenom.ffwll.local>
Mail-Followup-To: Colin King <colin.king@canonical.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181026180512.4908-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181026180512.4908-1-colin.king@canonical.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 07:05:12PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to a spelling mistake of the error access name EACCESS,
> rename to EACCES
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks for your patch, applied to drm-misc-next.
-Daniel

> ---
>  drivers/gpu/drm/drm_lease.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_lease.c b/drivers/gpu/drm/drm_lease.c
> index 24a177ea5417..9ab88db8fad0 100644
> --- a/drivers/gpu/drm/drm_lease.c
> +++ b/drivers/gpu/drm/drm_lease.c
> @@ -195,7 +195,7 @@ EXPORT_SYMBOL(drm_lease_filter_crtcs);
>   * make sure all of the desired objects can be leased, atomically
>   * leasing them to the new drmmaster.
>   *
> - * 	ERR_PTR(-EACCESS)	some other master holds the title to any object
> + * 	ERR_PTR(-EACCES)	some other master holds the title to any object
>   * 	ERR_PTR(-ENOENT)	some object is not a valid DRM object for this device
>   * 	ERR_PTR(-EBUSY)		some other lessee holds title to this object
>   *	ERR_PTR(-EEXIST)	same object specified more than once in the provided list
> -- 
> 2.19.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590EDC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0685205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="OjdoUDN4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0685205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbeK2UnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 15:43:14 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45393 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbeK2UnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 15:43:14 -0500
Received: by mail-ed1-f68.google.com with SMTP id d39so1285626edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 01:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9xllrEvB2eA3wMsFtSx3nY/XVVZZnFPzIpbG/h1Vw/c=;
        b=OjdoUDN4bS8OD7eoHGIR9uxIQv8UIXE8FkfH0VeBfbkmj4SMEPoMIC3NVGqtlJWOvB
         ec0f6JnsIXYpVOal53fg4UaeJrgL1fRfsvpHVF6vFwPJ2HSesCRqFEjJrszydWAlGOrZ
         sRtw87fomFhpzMKtNxV7LV5AyTYXUUvdK9Fas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=9xllrEvB2eA3wMsFtSx3nY/XVVZZnFPzIpbG/h1Vw/c=;
        b=pfNERIp0kHED//HvRPlvmZel37geC/qGz6/FlpuZ5BHVSbJ7XzKxYql7QzqaqhVhYw
         xwQCrCfJIVJDJqDcw120LskJiMVsiRqIbgM5P7FyaS8kunC6NCHL9ZiQPwbK6vIKiciW
         Y9ayZEZrWXCOMtY6PE+rTTiZdYoKgojf2BNOIeu3EVSBxFbR46l8aKE8kMLwROaJqbXg
         GZ6/5oK3tT6zlZxk9xwMH1Q5XNfLabDSOGynscUqRCEkoxv3fc+DqEM/34JTaYzJqK7U
         M6wRYrZzimz/gNRJ/cJidzSRv7jiRwsD3riPg1qDSGm9gWmiD+CWx6UC8UeuAwcXXZlw
         lyDg==
X-Gm-Message-State: AA+aEWb0j85kCWYIFamZy4LB8IgIkc9pDBvribEYy5Vufv7IIf8Kg+LL
        5xYxP+ugMkYzfOwm9avSrxakIQ==
X-Google-Smtp-Source: AFSGD/VnyP6k6JkAuhCfgoOxcDpe5f63Vy2OJBPlPDi2c5VNoMp6uK5SA2O27O/OBjAC16ZpQwmTxQ==
X-Received: by 2002:a17:906:6085:: with SMTP id t5-v6mr1003301ejj.47.1543484308506;
        Thu, 29 Nov 2018 01:38:28 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id k26-v6sm256708ejv.59.2018.11.29.01.38.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 01:38:27 -0800 (PST)
Date:   Thu, 29 Nov 2018 10:38:25 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org,
        Dave Emett <david.emett@broadcom.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] drm/v3d: Fix prime imports of buffers from other
 drivers.
Message-ID: <20181129093825.GJ21184@phenom.ffwll.local>
Mail-Followup-To: Eric Anholt <eric@anholt.net>,
        dri-devel@lists.freedesktop.org,
        Dave Emett <david.emett@broadcom.com>, linux-kernel@vger.kernel.org
References: <20181128230927.10951-1-eric@anholt.net>
 <20181128230927.10951-3-eric@anholt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128230927.10951-3-eric@anholt.net>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 03:09:27PM -0800, Eric Anholt wrote:
> v3d_bo_get_pages() checks this to decide to map the imported buffer
> instead of the backing shmem file.  The caller was about to set this
> value anyway, and there's no error path in between.  Ideally we
> wouldn't even allocate the shmem file for our imports, but that's a
> more invasive fix.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Fixes: 57692c94dcbe ("drm/v3d: Introduce a new DRM driver for Broadcom V3D V3.x+")
> Cc: Dave Emett <david.emett@broadcom.com>

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
> 
> I've been sitting on this one because I don't like it and was hoping
> the shmem library would pan out.  This is a useful patch for now,
> though.
> 
>  drivers/gpu/drm/v3d/v3d_bo.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
> index 54d96518a131..a08766d39eab 100644
> --- a/drivers/gpu/drm/v3d/v3d_bo.c
> +++ b/drivers/gpu/drm/v3d/v3d_bo.c
> @@ -293,6 +293,7 @@ v3d_prime_import_sg_table(struct drm_device *dev,
>  	bo->resv = attach->dmabuf->resv;
>  
>  	bo->sgt = sgt;
> +	obj->import_attach = attach;
>  	v3d_bo_get_pages(bo);
>  
>  	v3d_mmu_insert_ptes(bo);
> -- 
> 2.20.0.rc1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

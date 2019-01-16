Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35ACEC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29E520840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="UbW8AT2c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389133AbfAPKZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:25:20 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46172 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729269AbfAPKZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 05:25:19 -0500
Received: by mail-ed1-f66.google.com with SMTP id o10so4939044edt.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 02:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mUFfbATeuACDoZHq1dMDfkYicUfYgKpoKTKzfHAtOsI=;
        b=UbW8AT2c3/A8x1k94BfQQDOlsLKKKGqF5QlqMjxnB6Um6nXAKvbmx70Ly80jB3YlLP
         OkNutrp6CmKWgnmF1qXPT1r8lTJs5g2tFDOdxdRBVtcuR1ofSpbfOqikIOIh7ZRMgLvY
         JqsKTgVEYHEfbFNGCIRSZD+McPsjw7Kwawt+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=mUFfbATeuACDoZHq1dMDfkYicUfYgKpoKTKzfHAtOsI=;
        b=gVSpykt8aCkbl1NQ68vwFc62O8Yf5Z04aVU9TGUfW0qb7H091PM9cCtiQg4Ah/UX3C
         uaAvFhfmnsunWYP9OuIJHQ2GCQ9ti1YSxqeuXacaemY9BdeVUqcGLNuPzEtKauNQ9RUr
         kmq6hfzDBwuYzki8aal5sKa44nk9RwZk1Y+ZG/gPpPLixMEQGspEU1mpRGYFriOAmzu0
         gVsUS7ftrZD5jAMbC/S0uM4VHgHTY6i7fA938EhTXrWdu0QEPTxFVW+jl21QmFG3Bw/w
         ewQcDVyxQSxiLnNghwJ56ND6gPwmsI9KgzPN1B6Cygq/VHB0cTfdC+anyVISmNC4cYHV
         dGxg==
X-Gm-Message-State: AJcUukdK1LR1bKSIZiehVFGugwf3wdoGV6jCB+PTWgPxFQars1cSuNLS
        li5D0nPI6F8sYYyBX15RAmMEuw==
X-Google-Smtp-Source: ALg8bN6TMf/Ci5rj0r+PDL0Qo5u2mXvrrR2tday7eMtfnEKV1Z0wIk4ok3j4QdXl0tzHZq+mv0W6Uw==
X-Received: by 2002:aa7:dd0f:: with SMTP id i15mr6622529edv.29.1547634318086;
        Wed, 16 Jan 2019 02:25:18 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id g20sm5179568edr.47.2019.01.16.02.25.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 02:25:16 -0800 (PST)
Date:   Wed, 16 Jan 2019 11:25:14 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alexander Kapshuk <alexander.kapshuk@gmail.com>
Subject: Re: [PATCH 1/2] staging/vboxvideo: Don't set
 FBINFO_MISC_ALWAYS_SETPAR
Message-ID: <20190116102514.GU10517@phenom.ffwll.local>
Mail-Followup-To: DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alexander Kapshuk <alexander.kapshuk@gmail.com>
References: <20190115102755.16183-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115102755.16183-1-daniel.vetter@ffwll.ch>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 11:27:54AM +0100, Daniel Vetter wrote:
> It's a debug hack flag useful to work around driver bugs. That's not a
> good idea for a new driver. Especially for a new drm driver.
> 
> Aside: the fbdev support should probably be converted over to the new
> generic fbdev support.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Alexander Kapshuk <alexander.kapshuk@gmail.com>
> ---
>  drivers/staging/vboxvideo/vbox_fb.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/staging/vboxvideo/vbox_fb.c b/drivers/staging/vboxvideo/vbox_fb.c
> index 2181c36c19ab..1da4cb7647b8 100644
> --- a/drivers/staging/vboxvideo/vbox_fb.c
> +++ b/drivers/staging/vboxvideo/vbox_fb.c
> @@ -91,11 +91,6 @@ int vboxfb_create(struct drm_fb_helper *helper,
>  	fb = &vbox->afb.base;
>  	helper->fb = fb;
>  
> -	/*
> -	 * The last flag forces a mode set on VT switches even if the kernel
> -	 * does not think it is needed.
> -	 */
> -	info->flags = FBINFO_MISC_ALWAYS_SETPAR;

For the record I screwed up rebasing this one because it was in some patch
that also removed FBINFO_DEFAULT (which is 0, so pointless to set since
the structure is kzalloc'ed). Actually merged patch also removes
FBINFO_DEFAULT :-/ No real harm done though since as explained 0 doesn't
matter here.
-Daniel
>  	info->fbops = &vboxfb_ops;
>  
>  	/*
> -- 
> 2.20.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC6BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 542B021841
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="BWyMqes7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbeLTI2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 03:28:31 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44590 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbeLTI2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 03:28:31 -0500
Received: by mail-ed1-f66.google.com with SMTP id y56so952701edd.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 00:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=HCx9Grv2IXzbKzcvk2q1CUUBhcUizeMfdCvZdAwrobY=;
        b=BWyMqes7DiBYp2ZPUVym6B/1yh8NUD6b0C873tT1Z5uUTFm5qcot1pxEipJYhaGD0E
         dIIC/iBLxHvdiKZ5NlzGi/L05UZfngtoouA0Ax2FdQsjsoYzPoA29tlieb2+SPciTV1N
         S+hYPRc2Aiylu9Ww5zabhGOgLLvuFbjqXhFbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=HCx9Grv2IXzbKzcvk2q1CUUBhcUizeMfdCvZdAwrobY=;
        b=D5QwGO23261y+NwSMy98O3de7QOVabOeLAZ+c6llRVWKsHHD5k4ktsOxfYTZKvnbG6
         WOnKFCos4zBxOTEFKitJzK4H2b02XUD61M+d6wKj/4Ld6vcxMnPsvQQMyCOV6j/gb8EE
         2Q+OjWd+evB8in1tLgxSyH+AmxBLVwPW9Tg07Y7suXq85UhE0S9DKHYG6rqM1K6G5B+G
         r2X1Br2iYgHUJiKFisyxE2+2Cw9dXAeJLKOHg+OXoSJXyqXvkVpfsS70EjBBqcoPvB97
         gwOotjBW/Y5ONv6eyeZez9890OyX/TFwXT3Bmm0v8Mzw+7A0HcBPsfEhyezrdQGyaGLo
         jsXA==
X-Gm-Message-State: AA+aEWbiwQgyeSeN+B97ronDINrWiLK2Iow1Gpdlr7ayCI/GoLc4OpQT
        TNksXxtD8M+yYARInLjbCM5yqg==
X-Google-Smtp-Source: AFSGD/UHZGCgOiB20E0N6Os9Gryk0lY7xme2YFS6MKEd7LE7y5Q4gT2b0G7dmi1M5vUzPcaK1dzRDA==
X-Received: by 2002:a50:9a42:: with SMTP id o60mr23406609edb.180.1545294509807;
        Thu, 20 Dec 2018 00:28:29 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id c11-v6sm3046569ejz.70.2018.12.20.00.28.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 00:28:28 -0800 (PST)
Date:   Thu, 20 Dec 2018 09:28:26 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, andr2000@gmail.com,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v2] drm/bochs: add edid present check
Message-ID: <20181220082826.GE21184@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, andr2000@gmail.com,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>
References: <20181220065001.9594-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220065001.9594-1-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 07:50:01AM +0100, Gerd Hoffmann wrote:
> Check first two header bytes before trying to read the edid blob,
> to avoid the log being spammed in case qemu has no edid support (old
> qemu or edid turned off).
> 
> Fixes: 01f23459cf drm/bochs: add edid support.
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

It's a bit a hack, but makes sense.

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>  drivers/gpu/drm/bochs/bochs_hw.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
> index c90a0d492f..e1f8ffce00 100644
> --- a/drivers/gpu/drm/bochs/bochs_hw.c
> +++ b/drivers/gpu/drm/bochs/bochs_hw.c
> @@ -89,6 +89,14 @@ int bochs_hw_load_edid(struct bochs_device *bochs)
>  	if (!bochs->mmio)
>  		return -1;
>  
> +	/*
> +	 * Check first two EDID blob header bytes to figure whenever
> +	 * edid support is enabled in qemu.
> +	 */
> +	if (readb(bochs->mmio + 0) != 0x00 ||
> +	    readb(bochs->mmio + 1) != 0xff)
> +		return -1;
> +
>  	kfree(bochs->edid);
>  	bochs->edid = drm_do_get_edid(&bochs->connector,
>  				      bochs_get_edid_block, bochs);
> -- 
> 2.9.3
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

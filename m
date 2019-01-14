Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A100C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE88F2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="MqVp7gy1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbfANKBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:01:06 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:32949 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfANKBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 05:01:05 -0500
Received: by mail-ed1-f68.google.com with SMTP id p6so18208268eds.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 02:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LhIkfJqOCczaS6olU3SnHKo4Nt0dGbqqFJr/fHrj5qc=;
        b=MqVp7gy1U1fkIdiOJUgj4mXZTrIJLumxfJOGO3djU4WW6oNQrUtX9O7Bo/CEJoQYRw
         74aph/ENuvrGOzske77g3Lq1+7ZGhVu0Z3DdVgqygCbtcFK4pDG1hLDvyw+SgN1tHR6C
         jlzW1JlovYNN80vmR/KJlCkmdNBHc7Tg6li5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=LhIkfJqOCczaS6olU3SnHKo4Nt0dGbqqFJr/fHrj5qc=;
        b=d0xSTj/vo4HOqcZgQLS+LgZjsaj+45IJq6cLH53q8Ewjot1f6QCkuYWyoD/lRvbJO/
         0GqZX3DQ7ou4nwNiZcizKz0Q2u8tTIp3q6tGmUPz/N5pfAmaO1d5OreADCGtLPeFis8P
         m3jRkTvyD/yGxh2ACP7uajNComCLxnLB/0ioQysGUL5QKHUsc54yCuyOQjEADwFT3NlE
         M1a7jMs1uFysA14I8UKuVlajPyfbUKQbYBde7v8GfKZ/WKTKIlPCBTAqFtfErFWQoTaH
         LVQp2Efg1CirH+fzhFtv2l/AD7Ej4+Jw4J35SsFD0oJzf6o/QToX7FDjR2SwGFaWXu0Q
         J3xg==
X-Gm-Message-State: AJcUukfhlc26zpxA6JuP0oDkLJzAuCnbOa5DxaKJmLpQOOjrlgSWaLU6
        /w8nAVpKVZjQLZ9jeRxBtwQlEg==
X-Google-Smtp-Source: ALg8bN5jiXs/FHkalpSzyDu2v0zwq/EZNN59NsnoOAM2BKGtfYxVyBWpAdSmKbaQZdsRwDZ6mgOuYQ==
X-Received: by 2002:a50:b286:: with SMTP id p6mr22508211edd.202.1547460063547;
        Mon, 14 Jan 2019 02:01:03 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id g31sm4055163eda.96.2019.01.14.02.01.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 02:01:02 -0800 (PST)
Date:   Mon, 14 Jan 2019 11:00:57 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND] MAINTAINERS: Add entry for VKMS
Message-ID: <20190114100056.GA10517@phenom.ffwll.local>
Mail-Followup-To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20190113204038.bvdc6d5tyxjz6bzf@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190113204038.bvdc6d5tyxjz6bzf@smtp.gmail.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 13, 2019 at 06:40:38PM -0200, Rodrigo Siqueira wrote:
> Add maintainers and reviewers for VKMS driver
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Since you have commit rights for drm-misc already I think best if you push
this yourself using the dim tooling:

https://drm.pages.freedesktop.org/maintainer-tools/getting-started.html

Cheers, Daniel

> ---
> Changes in v2:
>   - Insert the section in alphabetical order
> 
> Resend:
>   - Update patch due to changes in MAINTAINER file
> 
>  MAINTAINERS | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 163c8f76a1c8..6e1cef2f21d9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4925,6 +4925,16 @@ S:	Odd Fixes
>  F:	drivers/gpu/drm/udl/
>  T:	git git://anongit.freedesktop.org/drm/drm-misc
>  
> +DRM DRIVER FOR VIRTUAL KERNEL MODESETTING (VKMS)
> +M:	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> +R:	Haneen Mohammed <hamohammed.sa@gmail.com>
> +R:	Daniel Vetter <daniel@ffwll.ch>
> +T:	git git://anongit.freedesktop.org/drm/drm-misc
> +S:	Maintained
> +L:	dri-devel@lists.freedesktop.org
> +F:	drivers/gpu/drm/vkms/
> +F:	Documentation/gpu/vkms.rst
> +
>  DRM DRIVER FOR VMWARE VIRTUAL GPU
>  M:	"VMware Graphics" <linux-graphics-maintainer@vmware.com>
>  M:	Thomas Hellstrom <thellstrom@vmware.com>
> -- 
> 2.20.1

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

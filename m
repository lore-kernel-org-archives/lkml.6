Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83830C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC50222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="K/urVz0f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391890AbfBMP2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:28:07 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33577 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730097AbfBMP2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 10:28:07 -0500
Received: by mail-ed1-f65.google.com with SMTP id a2so2305871edi.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 07:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5q2Aoc1BTxctG5qU/Eq3DEwQGlwEYGhrTs8vuF9TMxs=;
        b=K/urVz0fSwmBy0pAif3Rrv24tr/soVV3RdDE0+sXmW4E0zntpjI5kfD1lYvjDfU9dx
         VkONotfPhEluX7Iy+LP+54l25rga2EDALGUsBL9MskAyLtpbeaLkTGMEuN9Ix1xsLZU8
         5sbJgSXtdpFTPonysTwzDv0XSzqvkCWvjCKzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=5q2Aoc1BTxctG5qU/Eq3DEwQGlwEYGhrTs8vuF9TMxs=;
        b=pAOXzKlkJKGoQsrcvkeNfGgBlNts7kqxvoRulj7zAlJ5dV02ozA896ltvhkYABCcd7
         dRgWetHpLOPsRDMoCOhI/uTRW0pQP11yMlCsjZKnIeU2ehRxnhsonLWwH8wnvARi3xh4
         /ZS6FwRgoqjWgggwpBlYLax56jlds7LfUc9l8/n6CPsGDWdeYZo5+ZBcaIiw182fPUjG
         mnSuQrTquVgqR/lgE0OE30jYe58jRoMZiSwco1mUZbtm4A5g0aEZx57J2raabJFMLnAO
         cnbN5h9J0AslGbAEFd6qxuG9I10CFRLTDY7dqOUA7d+P1oS0WrXlkr6v70UGr3+VT90k
         mhIQ==
X-Gm-Message-State: AHQUAuZ9lso15g/lAfIgXpm9Qb3KR2moPCcopovseqlS7XNA+ZkZjGId
        ppGEmIjMwiN/QBaSs6y7PtqJaQ==
X-Google-Smtp-Source: AHgI3IYMhCt8HejpBaR5+pn98CvVDL1hkVgC/B3rNi5SjPlZfkgQXRPlv6f5D9he4u1xrVPonGQslQ==
X-Received: by 2002:a50:b3c9:: with SMTP id t9mr845664edd.270.1550071685374;
        Wed, 13 Feb 2019 07:28:05 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id jt20sm3819062ejb.38.2019.02.13.07.28.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 07:28:04 -0800 (PST)
Date:   Wed, 13 Feb 2019 16:28:02 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-kernel@vger.kernel.org, Sean Paul <seanpaul@chromium.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] MAINTAINERS: update entry for drm/msm
Message-ID: <20190213152802.GK23159@phenom.ffwll.local>
Mail-Followup-To: Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-kernel@vger.kernel.org, Sean Paul <seanpaul@chromium.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
References: <20190213151107.14833-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213151107.14833-1-robdclark@gmail.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 10:10:44AM -0500, Rob Clark via dri-devel wrote:
> We've moved the tree to a shared gitlab tree, so that Sean can help out
> with maintainer duties.
> 
> Cc: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Rob Clark <robdclark@gmail.com>
> ---
> I can include this patch in msm-next for v5.1, but wanted to get it
> ack'd on list

Is the plan to also add this to dim, for full group maintainership fun?
It's more or less adding a few lines to nightly.conf and done (plus
everyone being ok with using the dim tooling).
-Daniel

> 
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9919840d54cd..2141a1b6653d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4838,10 +4838,11 @@ F:	Documentation/devicetree/bindings/display/multi-inno,mi0283qt.txt
>  
>  DRM DRIVER FOR MSM ADRENO GPU
>  M:	Rob Clark <robdclark@gmail.com>
> +M:	Sean Paul <sean@poorly.run>
>  L:	linux-arm-msm@vger.kernel.org
>  L:	dri-devel@lists.freedesktop.org
>  L:	freedreno@lists.freedesktop.org
> -T:	git git://people.freedesktop.org/~robclark/linux
> +T:	git https://gitlab.freedesktop.org/drm/msm.git
>  S:	Maintained
>  F:	drivers/gpu/drm/msm/
>  F:	include/uapi/drm/msm_drm.h
> -- 
> A
> 2.20.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D766FC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD462190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="VbFabojB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392223AbfBMPcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:32:03 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40146 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391894AbfBMPcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 10:32:02 -0500
Received: by mail-qt1-f196.google.com with SMTP id j36so2984528qta.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 07:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KUjm2kl2nvkyPYBq/onD5lEJDxp+mYjNIapGUYbrTXU=;
        b=VbFabojBJ8njxlfwGdu4Isj4JGRM0O2djVkjCiUkq3uf+6N59u3Fv1WDypplgMI1O6
         mVsAMO/yufsYn+0BOeJcg4LkekwXl3BB4L97+ovScNV7Ye9x8NNp/iXJzUr9i0+B5tmo
         jGuAYPFjMQv/HKB92aat+Lh+qGvnq7HUfjbEfv42VH3ogVHaFUOHXqsA9QmCd1+VxJm7
         XgqqBnUznRrgsKkB3XY30XgtRI+L/vy7jfFoWVg9t5Op4HQRYrJomM38uKAVUI9ijM8z
         AxmYj1SUfJ4UyLmlwQyHoO2DuMoRKbth+l2NUxBP5OhjteAOwQrK0GUJmbIf1h0eehMQ
         3jhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KUjm2kl2nvkyPYBq/onD5lEJDxp+mYjNIapGUYbrTXU=;
        b=i/XDtPv4paBVShxx6sWBXh7P3RNnvtfMWlgBQr2QLWcd9m2bck50lkiBDha5v9/Fhn
         +ow6yfyce+w2gdr9UUGqlwxFGvftiF5cYeJo958LvaRMqOv8Giby+HuoygN4cJ1uaC3O
         ZfQUcOpB4P+fTJQAM2EcuPWkPfOYIQqIDsauN1HgxwFprJTXTV40PjRob1KUPtQM8aAb
         z6rkJGoB9eUrscsBMDwjG4XG5ebiSOd+eZKWAs8EMrCLqb1pZI5MM2bR+Mw4aG9/yK5T
         TxzvxvVGiGdnkDkrYIbU353LvKPYp32fI8OVtxyECZgb/podO3+FgU2IgtZeKoEA7VQp
         AUEg==
X-Gm-Message-State: AHQUAuY1EpC5CmAJJ+WtIGvEXDB7eUAtD1XQlJrZSE6SLLcscHTl54Mm
        SXyXqeoFlVC0vhe0CjHHXcX5KQ==
X-Google-Smtp-Source: AHgI3IacYzW3nnW/+IMSTkKBfJTY2acFgSEo0idWrLqn/4vHONyWWTnNX+ORC4bvL2SfLwNTimOM0g==
X-Received: by 2002:a0c:81b4:: with SMTP id 49mr837286qvd.144.1550071921197;
        Wed, 13 Feb 2019 07:32:01 -0800 (PST)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id c202sm21985691qkb.19.2019.02.13.07.31.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 07:32:00 -0800 (PST)
Date:   Wed, 13 Feb 2019 10:31:59 -0500
From:   Sean Paul <sean@poorly.run>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-kernel@vger.kernel.org, Sean Paul <seanpaul@chromium.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] MAINTAINERS: update entry for drm/msm
Message-ID: <20190213153159.GK114153@art_vandelay>
References: <20190213151107.14833-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213151107.14833-1-robdclark@gmail.com>
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

Acked-by: Sean Paul <sean@poorly.run>

> Signed-off-by: Rob Clark <robdclark@gmail.com>
> ---
> I can include this patch in msm-next for v5.1, but wanted to get it
> ack'd on list
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
Sean Paul, Software Engineer, Google / Chromium OS

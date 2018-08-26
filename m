Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52DFC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 22:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6409F208CA
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 22:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ekWeUVF2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6409F208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbeH0Bsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 21:48:46 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:46994 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeH0Bsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 21:48:46 -0400
Received: by mail-yb0-f196.google.com with SMTP id y20-v6so5357917ybi.13
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 15:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ej936iLY9EHK3H6pbFMhj4gM/urRqmvEbiwm85NUVXM=;
        b=ekWeUVF2yRlItN8KMsFwLBypLLl3+oE1cegcwK3OZlzjQGaE24PP2HlbMmXau5wV8s
         6N1MA1NQNLxXzzQTehId3PvDhBKTf+1NG63IWkDMPZxFJ8TxDqS4zbpOBv7bYAeBpJSH
         TN73Q3HO04N8+B/SwJotb7vni8GeizuOYhkPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ej936iLY9EHK3H6pbFMhj4gM/urRqmvEbiwm85NUVXM=;
        b=Rc8aaEfwn2apATdBFQLjUy3EmNC1qls6K6PioLV/X5nhYdEeallSQp9pQqvK/lP/nM
         wyugPnasiYFDpy7pMxUPAZ6WZjdgBGN1nkRSseJiMc3A2NEcG1K0fYHJ0WTt0vmS2G8M
         TF+xMXl43CJVgdRzS+0le22yWIXbki3ZCrypb1Dg2Trkuc/eJQvYr93zg56zs16ebJFD
         rZnQDaI6kahpsZEcrWcdmmE+l4FiLinkq0f1CCnF5QRRva+5VL7K2PSAgo6gLuGtsGN3
         LWW+bVR/I5vgQgUkk1PJ/W9OOFjk2e5QO4wa1BUHbNWodT+arrBDJotdd8ASfHnOcLCJ
         +T7Q==
X-Gm-Message-State: APzg51BsDpzyIXk6QZElZDUd5d2Bg5oqawbNSVG78N+NUjDdQlsD8GyF
        X7nUsPKlQc+V63sx9hd4knlue+TdzXo=
X-Google-Smtp-Source: ANB0VdYj8UVnqhJkFTWsu0T/phEy2qaGvfCk1x0sSFU9qOa1zxKL7qbHdS8i2OvJlP/PrJ25WPzCaQ==
X-Received: by 2002:a5b:811:: with SMTP id x17-v6mr5631826ybp.382.1535321094481;
        Sun, 26 Aug 2018 15:04:54 -0700 (PDT)
Received: from mail-yw1-f46.google.com (mail-yw1-f46.google.com. [209.85.161.46])
        by smtp.gmail.com with ESMTPSA id e124-v6sm5792599ywh.66.2018.08.26.15.04.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 15:04:53 -0700 (PDT)
Received: by mail-yw1-f46.google.com with SMTP id j131-v6so4909878ywc.13
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 15:04:53 -0700 (PDT)
X-Received: by 2002:a81:4e01:: with SMTP id c1-v6mr5912918ywb.237.1535321092910;
 Sun, 26 Aug 2018 15:04:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:2c11:0:0:0:0:0 with HTTP; Sun, 26 Aug 2018 15:04:52
 -0700 (PDT)
In-Reply-To: <20180826184712.GA9330@embeddedor.com>
References: <20180826184712.GA9330@embeddedor.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sun, 26 Aug 2018 15:04:52 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKkLMWz6aBzPHde9X5+_=k-X3ryjq6mm=z5X1QtRg-MxQ@mail.gmail.com>
Message-ID: <CAGXu5jKkLMWz6aBzPHde9X5+_=k-X3ryjq6mm=z5X1QtRg-MxQ@mail.gmail.com>
Subject: Re: [PATCH] drm/rockchip: Use struct_size() in devm_kzalloc()
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rockchip@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 26, 2018 at 11:47 AM, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
>
> struct foo {
>         int stuff;
>         void *entry[];
> };
>
> instance = devm_kzalloc(dev, sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
>
> or, like in this particular case:
>
> size = sizeof(struct foo) + sizeof(void *) * count;
> instance = devm_kzalloc(dev, size, GFP_KERNEL);
>
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
>
> instance = devm_kzalloc(dev, struct_size(instance, entry, count),
> GFP_KERNEL);
>
> This issue was detected with the help of Coccinelle.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index 1359e5c..cf64e4d 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -32,6 +32,7 @@
>  #include <linux/of_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/component.h>
> +#include <linux/overflow.h>
>
>  #include <linux/reset.h>
>  #include <linux/delay.h>
> @@ -1561,7 +1562,6 @@ static int vop_bind(struct device *dev, struct device *master, void *data)
>         struct drm_device *drm_dev = data;
>         struct vop *vop;
>         struct resource *res;
> -       size_t alloc_size;
>         int ret, irq;
>
>         vop_data = of_device_get_match_data(dev);
> @@ -1569,8 +1569,8 @@ static int vop_bind(struct device *dev, struct device *master, void *data)
>                 return -ENODEV;
>
>         /* Allocate vop struct and its vop_win array */
> -       alloc_size = sizeof(*vop) + sizeof(*vop->win) * vop_data->win_size;
> -       vop = devm_kzalloc(dev, alloc_size, GFP_KERNEL);
> +       vop = devm_kzalloc(dev, struct_size(vop, win, vop_data->win_size),
> +                          GFP_KERNEL);
>         if (!vop)
>                 return -ENOMEM;
>
> --
> 2.7.4
>



-- 
Kees Cook
Pixel Security

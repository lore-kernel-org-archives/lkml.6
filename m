Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489A9C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F4562146F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TZS21HWA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbfAHXlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 18:41:37 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:40367 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfAHXlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 18:41:37 -0500
Received: by mail-vs1-f66.google.com with SMTP id z3so3634331vsf.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 15:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wmdI+bVhDNEfrfvm8mcNse9Eldw8ZhGvvpxgT3n7A/Q=;
        b=TZS21HWA8tOAcjneAJWv6F6TvgEt3LuToPtbdmaXE/t0FnwEEtowMJskgeEMPkRVuE
         S636xhnIbBFTMgXijG8adIQWap2lG3Y4a8oSA95iPWZhBJX9eO6OkoMzFGGGDaMOjjIw
         X186aMkwRyLyzAlgB0hGg9/yxwUzRj0CxTUk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wmdI+bVhDNEfrfvm8mcNse9Eldw8ZhGvvpxgT3n7A/Q=;
        b=ZMnDyBt3J7LpyFSx0UKw/46uxrWHOix5PmUhZl9qxqzs8XUrvvgmntvlcR32IbN7LE
         qzm/HvCdxseBYZmWs0BYtKXqPx1fJ9nzYnFjNtt9acueb4eTyaw+IaUlpWBz+NUJn+uH
         dguGh49fx6nJupcWtrXyOrj+0uf/147OSo2E2ckrB2WLqKhTNV8c3s3MaYFc+0bH6wRu
         VM4larOoFuHSRVWgRki/YlU1cPO7UFyMEtA4CSfdQiGHsWZKbOnTuwsKuiW8fGBkgP7q
         /9TE/kvXeFQ1jX+cPv/TF1vlPkIFYqCydY8rtODqd8+IbPN2g5i6Q1umBBmekbmeEOvK
         mQPw==
X-Gm-Message-State: AJcUukelPn5jSihzYHrhXYc2/152+X5q2G3ce/zm0e028+x0zv12s1UO
        xLZ7dNei3jnIX2+6PDwKYvMGT5QQPU0=
X-Google-Smtp-Source: ALg8bN4SEC8cmDcoGI+OXXxEy5O9mS25OmxzAw6jDu0BCKa/XWfqQ6JxRkILy5wQYtP+QImJAdUMVw==
X-Received: by 2002:a67:6d42:: with SMTP id i63mr1586775vsc.158.1546990895568;
        Tue, 08 Jan 2019 15:41:35 -0800 (PST)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id p8sm30731860vke.27.2019.01.08.15.41.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 15:41:34 -0800 (PST)
Received: by mail-vs1-f45.google.com with SMTP id b74so3635388vsd.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 15:41:34 -0800 (PST)
X-Received: by 2002:a67:848a:: with SMTP id g132mr1560225vsd.222.1546990894221;
 Tue, 08 Jan 2019 15:41:34 -0800 (PST)
MIME-Version: 1.0
References: <20190106075408.58405-1-vlad@tsyrklevich.net>
In-Reply-To: <20190106075408.58405-1-vlad@tsyrklevich.net>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 8 Jan 2019 15:41:22 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKiKA79mnTwCxTKsXBBKAvaoaX=CH61pLXdxtWQvUhhuQ@mail.gmail.com>
Message-ID: <CAGXu5jKiKA79mnTwCxTKsXBBKAvaoaX=CH61pLXdxtWQvUhhuQ@mail.gmail.com>
Subject: Re: [PATCH] Fix stack memory disclosure
To:     Vlad Tsyrklevich <vlad@tsyrklevich.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-fbdev@vger.kernel.org,
        Security Officers <security@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 5, 2019 at 11:51 PM Vlad Tsyrklevich <vlad@tsyrklevich.net> wrote:
>
> Using [1] for static analysis I found that the OMAPFB_QUERY_PLANE,
> OMAPFB_GET_COLOR_KEY, OMAPFB_GET_DISPLAY_INFO, and OMAPFB_GET_VRAM_INFO
> cases could all leak uninitialized stack memory--either due to
> uninitialized padding or 'reserved' fields.
>
> Fix them by clearing the shared union used to store copied out data.
>
> [1] https://github.com/vlad902/kernel-uninitialized-memory-checker
>
> Signed-off-by: Vlad Tsyrklevich <vlad@tsyrklevich.net>

Reviewed-by: Kees Cook <keescook@chromium.org>
Fixes: b39a982ddecf ("OMAP: DSS2: omapfb driver")

Since this driver is orphaned (according to MAINTAINERS), I think this
fix should go via Bart's tree. Bart, can you take this?

-Kees

> Cc: security@kernel.org
>
> ---
>  drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c b/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
> index 53f93616c..8e23160ec 100644
> --- a/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
> +++ b/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
> @@ -609,6 +609,8 @@ int omapfb_ioctl(struct fb_info *fbi, unsigned int cmd, unsigned long arg)
>
>         int r = 0;
>
> +       memset(&p, 0, sizeof(p));
> +
>         switch (cmd) {
>         case OMAPFB_SYNC_GFX:
>                 DBG("ioctl SYNC_GFX\n");
> --
> 2.17.0
>


-- 
Kees Cook

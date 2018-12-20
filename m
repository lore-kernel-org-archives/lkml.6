Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26362C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E52E621741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545303943;
	bh=Ac7gdSCyzoZZQoHjpnGwYX9JxXwIoDWQGf7QqRtG0hU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0orqX5coPqsBqizW7rrujgMldeCSpFQucehbisp5ul50sw2i7Yf8GHgY6mMpFgGw0
	 tEvFkURTyN733UVWRba1T8tdp54K4htuUuLOGIWt0Qn9+RPnJS5oLfTaTAPpg9QpcA
	 VNUiiiRDOb4XKRGTBO+ikewjVIG6jcP0XTTmO2Vc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730604AbeLTLFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 06:05:41 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42354 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730001AbeLTLFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 06:05:41 -0500
Received: by mail-ot1-f65.google.com with SMTP id v23so1267382otk.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 03:05:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nq8d07HAa0tURcA9JYcwKrgnNSA4HwhiWl3XqEL59Zc=;
        b=oD3eX3qy5yZAjGszV2vFxiTBmvAPnJIy8ltGHO59ll04jvcVHpTe5X4uvyB+ohA4KR
         mV1noTjkYNyUCedGI1fIYrE9pEpojKdwx2IKEkkylzm5h18ydZhcyPvobXw7WOrSMGaw
         WkAR15lTwFklH0TMw7Fc5XRWEyECZtcv0QoFsMhuKwgsX7nGNdxSCdPZm9ppLIYZnwKr
         vXLIkgkB5Gm09TZhDsFDgG1Gmr/minFu5iSHr2hQGrxB5BGN0w8VmZoM9gShMHSQayzh
         Pgiv3tZz9SQFqdoagxhCiq1Qj/CIcDk1u0Uxdv5xEYWPjUFVaKsroTy+lPN0yrpDm4pf
         DLBQ==
X-Gm-Message-State: AA+aEWa0htwcwEMUcCA+Ud6K6VRmvjkFcnG+RN02zR2fn0zas5pwoZ/6
        vB6woY+NcJfYnS0rNdPQ86jR0XBzqXehQ6wNkMk=
X-Google-Smtp-Source: AFSGD/XBUlS0ADGlXz9kg54sao9pZE5paZ6+97pw61rIIxgIojgvRKmkFuaLFikqMe3TYsAr0EAM7pXCfDSDq2jexu8=
X-Received: by 2002:a9d:4c84:: with SMTP id m4mr16332731otf.124.1545303940805;
 Thu, 20 Dec 2018 03:05:40 -0800 (PST)
MIME-Version: 1.0
References: <CGME20181220102300eucas1p210735c7753688a52a73ccf026884dd11@eucas1p2.samsung.com>
 <20181220102247.4911-1-a.hajda@samsung.com> <20181220102247.4911-4-a.hajda@samsung.com>
In-Reply-To: <20181220102247.4911-4-a.hajda@samsung.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 20 Dec 2018 12:05:29 +0100
Message-ID: <CAJZ5v0gzwu9Zf+1MjVqomqMuvZpHtpKizETgW0==7HBqDq2w-w@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] driver core: add probe_err_ptr helper
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        javierm@redhat.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 11:23 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
>
> probe_err is useful in multiple contexts where error is encoded in pointer.
> Adding helper performing conversion to error value should simplify code
> further.
>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  include/linux/device.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 2d3a1cc6f5da..50632414c363 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -1594,6 +1594,8 @@ do {                                                                      \
>  extern __printf(3, 4)
>  int probe_err(const struct device *dev, int err, const char *fmt, ...);
>
> +#define probe_err_ptr(dev, ptr, args...) probe_err(dev, PTR_ERR(ptr), args)
> +
>  /* Create alias, so I can be autoloaded. */
>  #define MODULE_ALIAS_CHARDEV(major,minor) \
>         MODULE_ALIAS("char-major-" __stringify(major) "-" __stringify(minor))
> --
> 2.17.1
>

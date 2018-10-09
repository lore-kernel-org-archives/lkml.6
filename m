Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24026C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB1082077C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GSYKmcQD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB1082077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbeJIQ0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 12:26:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54032 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbeJIQ0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 12:26:47 -0400
Received: by mail-wm1-f65.google.com with SMTP id y11-v6so1044524wma.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 02:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=aJQG1Z6axg0Bmu9VGblnwnnwDCwZ3+S4hgBImsoWAs0=;
        b=GSYKmcQDGtKdb8rZLgO8FKW+zdG0JSoTv7xhYi+hC590K8G4j5Ek+WGFYLaiJGQmsW
         6/OO/QEGsHhgkIwuJNe2X44JDjqkykl4wboTe4pHyXvOPBi3vF3OOe51JZwTvzg9Jlgg
         mPPA5kkHQyXWv0rgkww63jiwA5MnopHsYNyhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=aJQG1Z6axg0Bmu9VGblnwnnwDCwZ3+S4hgBImsoWAs0=;
        b=OTC4wZGX5AUH6mxbQ3z0uteS+y/V75unedwlYkDVsxQX6/ybAndMUnTCvVT2sKiIyH
         2k+ZU1Yn+HGGx2i0l/eDh+v9HtpGkV3+QIM9qtKPcSB/p01j1nGxatQbi7lMLw1PG/Lz
         KebbPS3rtivJLsxQFUzXwjh50h9I0zBfh8ueyVlPi8cGGQZ321G4yN+9MWgmcmL8U9Q/
         k0mAKNpd0bgVDois1876CvFFK0z8vxdoe06ztkRSN0G1KzCewkvIEu/Ob9gkWu/zzRnr
         vnJowGdzcU+4SkoQmCUzRHzg1wQW0hmXwI8FNbys6ARVZgwaikGuaTfmjOMjgF93LZ0/
         2vPA==
X-Gm-Message-State: ABuFfoiqT+gueRPvBOAhkkJ94jj+T8OeAOoLmDMDAHWXGO3AhJbJBn+U
        Zks7tkCBM9NUMW38bOQsnO3FlQ==
X-Google-Smtp-Source: ACcGV61Hu2kvjq1GoKHV67cDJOhcK9De3b25iCWFPJAw5/Yu0+FZVuhsApx9vd5OD0V2EChjyYIUeQ==
X-Received: by 2002:a1c:a90:: with SMTP id 138-v6mr1241763wmk.49.1539076250488;
        Tue, 09 Oct 2018 02:10:50 -0700 (PDT)
Received: from dell ([2.27.167.111])
        by smtp.gmail.com with ESMTPSA id b8-v6sm10710959wme.1.2018.10.09.02.10.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 02:10:49 -0700 (PDT)
Date:   Tue, 9 Oct 2018 02:10:48 -0700
From:   Lee Jones <lee.jones@linaro.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] backlight: lm3639: Unconditionally call
 led_classdev_unregister
Message-ID: <20181009091048.GF4939@dell>
References: <20180921202130.12480-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180921202130.12480-1-natechancellor@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2018, Nathan Chancellor wrote:

> Clang warns that the address of a pointer will always evaluated as true
> in a boolean context.
> 
> drivers/video/backlight/lm3639_bl.c:403:14: warning: address of
> 'pchip->cdev_torch' will always evaluate to 'true'
> [-Wpointer-bool-conversion]
>         if (&pchip->cdev_torch)
>         ~~   ~~~~~~~^~~~~~~~~~
> drivers/video/backlight/lm3639_bl.c:405:14: warning: address of
> 'pchip->cdev_flash' will always evaluate to 'true'
> [-Wpointer-bool-conversion]
>         if (&pchip->cdev_flash)
>         ~~   ~~~~~~~^~~~~~~~~~
> 2 warnings generated.
> 
> These statements have been present since 2012, introduced by
> commit 0f59858d5119 ("backlight: add new lm3639 backlight
> driver"). Given that they have been called unconditionally since
> then presumably without any issues, removing the always true if
> statements to fix the warnings without any real world changes.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/119
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
> 
> Alternatively, it's possible the address wasn't supposed to be taken or
> the dev in these structs should be checked instead. I don't have this
> hardware to make that call so I would appreciate some review and
> opinions on what was intended here.
> 
> Thanks!
> 
>  drivers/video/backlight/lm3639_bl.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

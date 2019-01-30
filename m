Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7E7C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA1E20989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RwK224n6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730835AbfA3Nf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:35:29 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39541 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfA3Nf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:35:29 -0500
Received: by mail-wr1-f67.google.com with SMTP id t27so26062017wra.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 05:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=eAqb433WEy8+p6Y2xKwHpzstU04b4LVa8pajWUFxtsk=;
        b=RwK224n67FMlRpssc8GKGW1PRxEjpDtDCuNtlSrfQQFIm/O0KFMt6DZLbYN65V6CTM
         7tRFVWPkoL232YOtBrk6GqdtUxFgDAz0X8t6GND5Yznj98j/X421bFghkgZzTPN0e4++
         j+EoyC+V2uGR3FzvHYJJSMUoNPAT4MsS+FurY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=eAqb433WEy8+p6Y2xKwHpzstU04b4LVa8pajWUFxtsk=;
        b=Q/p5na66Qedmo21cca+emcSrq1O7Gwig3Tt6cgTHmt40AAaZJNUpcZ4VdhduMJWBrJ
         Xf2ByPZBGoE1MiLet76Z7gUfz6E98B9UDNcNoiwUEulo/RsIvLoR/w5gVJ1TwckOjQXj
         J6JZAdkeevoWgQAdI4bDTFvXLKyKzZMUa2NnPEbGqJI8vYeb5ZMZ9oYnQIMdpDdMpEC4
         lQgJKLpHq9a0ZST9K+ShnpMfqCczndNbhQWDhtsABKDpLgYA7k/gUoc0Xw7EcANWH5wi
         bjxhkQlS/o/KVVCyJ4gG+UZZgfIEfVPGgnomgVuwPEltpqAqQpXbvhHFMx9QWvFpeTv/
         p7BQ==
X-Gm-Message-State: AJcUukck2G3fWyfh+0m2/X7YmsLcrl38BNvBPgI7DaMiGcwM+flM5prx
        C00zB0hVDSPvz2RsX0JUBG/887dv1Tc=
X-Google-Smtp-Source: ALg8bN4yVSNnYw7KJRLdZ9DvVqQYjKaO8hcMKjWRqh+t4Zwuj8u53Ml0H4ewxeBQVzNkHPlvLQaD8g==
X-Received: by 2002:adf:9083:: with SMTP id i3mr29865862wri.124.1548855327183;
        Wed, 30 Jan 2019 05:35:27 -0800 (PST)
Received: from dell ([2.27.35.198])
        by smtp.gmail.com with ESMTPSA id g188sm2368119wmf.32.2019.01.30.05.35.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 05:35:26 -0800 (PST)
Date:   Wed, 30 Jan 2019 13:35:25 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mfd: sm501: Fix potential NULL pointer dereference
Message-ID: <20190130133525.GG4701@dell>
References: <cover.1548175934.git.gustavo@embeddedor.com>
 <6376930a04650c2dafcbe306f6d402794c30d5b3.1548175934.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6376930a04650c2dafcbe306f6d402794c30d5b3.1548175934.git.gustavo@embeddedor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2019, Gustavo A. R. Silva wrote:

> There is a potential NULL pointer dereference in case devm_kzalloc()
> fails and returns NULL.
> 
> Fix this by adding a NULL check on *lookup*
> 
> This bug was detected with the help of Coccinelle.
> 
> Fixes: b2e63555592f ("i2c: gpio: Convert to use descriptors")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/mfd/sm501.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

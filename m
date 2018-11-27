Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B72CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212EF21104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="c9qXp5lW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 212EF21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730901AbeK0XMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 18:12:30 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33328 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729515AbeK0XMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 18:12:30 -0500
Received: by mail-wm1-f68.google.com with SMTP id 79so1454236wmo.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 04:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VABBGL7pT1AAKaWTjEI4KTBSlYJ4GR9Nug9f4H0FIOc=;
        b=c9qXp5lWYpua5jrcgcGK0ZSOpMO+Eh0qk4I1lMS5OVKwc6/5rz5FvrF9eTzYo7/33A
         AUFrPqdj9gXCXQE30h4xvGCqEd9UsaBWgmuQOsTf7B5PdGKtEFZ+C3H/j8uNOWiJT/7k
         zhHU5MkSPv+Qxg7OHqwEqV45UWbKTynwWkURo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VABBGL7pT1AAKaWTjEI4KTBSlYJ4GR9Nug9f4H0FIOc=;
        b=skwG5uXgJrqI1Onqx9c+m0uW3bFGvYT9oB6xrSzv58Sd9gQZizqMaLnWFJiB9ScjWZ
         udwYKHIuPpW6x8ZKyyk9uG6lJAmj1XEECdRhrhM1aqvDbyt/IESmrZRIFY48YWxM4aaG
         CQr5BwjAkUc8Zkw23+k077m7dmayjVEyEzBfOTAXJkhlObZTSbsv8fA/JzhMWsvl+8f2
         BB2po2tJTvOp3O+XVMP17dycHcRxOgvUML41GRvQJo4hfGPTbV5zvm3bVtriWbgV8PZY
         c58NmuwsTAVu7IAPQypn6i69veQuUkBQQyZvfY6X9pE4FtBCw8BXHL8x3u8dl3aNTq59
         n2cQ==
X-Gm-Message-State: AGRZ1gLhUvjJAU+y1VQ5AFCfh/tRYATQnfFppez7gipEziDQS1tgFtGU
        A8ueyeozK23SkuBr5uUYAk8w8w==
X-Google-Smtp-Source: AFSGD/Vk7NVXqXACBbwjDcjgy0dGDqTjEA7pYXZTWqi/IcVlU33ynuIxeHcTYgxEYiTZFfy/UKBqeQ==
X-Received: by 2002:a1c:4b14:: with SMTP id y20mr27593101wma.82.1543320886052;
        Tue, 27 Nov 2018 04:14:46 -0800 (PST)
Received: from dell ([2.27.35.241])
        by smtp.gmail.com with ESMTPSA id z17sm3661561wrv.2.2018.11.27.04.14.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 04:14:45 -0800 (PST)
Date:   Tue, 27 Nov 2018 12:14:30 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Philippe Schenker <dev@pschenker.ch>
Cc:     jic23@kernel.org, marcel.ziswiler@toradex.com, stefan@agner.ch,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/4] mfd: stmpe: Move ADC related defines to header of
 mfd
Message-ID: <20181127121430.GJ4272@dell>
References: <20181119102528.2830-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181119102528.2830-1-dev@pschenker.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2018, Philippe Schenker wrote:

> Move defines that are ADC related to the header of the overlying mfd,
> so they can be used from multiple sub-devices.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> ---
> 
> Changes in v2:
>  - This is a new added commit. Separate commit for moving the defines out of
>    drivers/input/touchscreen/stmpe-ts.c to overlying mfd-device drivers/mfd/stmpe.c
>  - Pre-fix defines with STMPE_
> 
>  drivers/input/touchscreen/stmpe-ts.c | 34 +++++++++++-----------------
>  include/linux/mfd/stmpe.h            | 11 +++++++++
>  2 files changed, 24 insertions(+), 21 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

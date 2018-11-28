Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1518C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A282081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DE+f8Ota"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A282081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbeK1UQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:16:32 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40787 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbeK1UQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:16:32 -0500
Received: by mail-wm1-f68.google.com with SMTP id q26so1734962wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 01:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3D7fLPnCvmEyWtJOyLYdC8hy/rwwmPIVlKl5/YMRZ3E=;
        b=DE+f8OtaVYnFl1kxPakjBKOCdQvl/LkIFv11MYoEUVkC+UFz9V5yWJ9P3rr+AYzIlm
         FQ2BkmX62d6nkoHa8wz3cATt3tsNCExcTmz2+BJg/kskrX4qsBdbxr1nCNTbwpy71pAc
         NzD8YEr76G47d4m8o8B1LMzjNrEdw6AaHx+vU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3D7fLPnCvmEyWtJOyLYdC8hy/rwwmPIVlKl5/YMRZ3E=;
        b=JXIJsVTRv4C3laBThwkYqb8BFtGEgCT7hfytM9jPBTq3lKhgSQrcHDQvtlxVQURGeh
         jAdjQSx5D4PLMiYGCk6XCmZmeMWRzAqxZ7iwH4v9CWobyIfyotM0wAZq060YBA+L/WZl
         H4Jyy47cog2/EpoONmI0Muu/16imnTsXPCf7qetnloKuKS7MKHrVZ8qrDqfj2q8pfJ/o
         JBPLS7O4YCUDNWSnY2zr+K/Qwrx76xGVgouu96qCBk2MPZJfNBYWXDuwrIDsDi+rrqRl
         uSbRGiuFLD2ATFRZSNNk4N4LfELaRBnIfXOzoNYnAR+8Dd7IOdzG+M5THIhCvMU9uPtn
         Em8g==
X-Gm-Message-State: AA+aEWYMp3bjeC+mDAq1ZALyBSE9MjcR9nuJzZGogA4Zg65FIGq05FEw
        +rG1QhxZ7pKbyYw2EB+rCBFZ1Q==
X-Google-Smtp-Source: AFSGD/VxIPvnzP/WlMJCOWvWd4YaPCsbDJ665o1U9Urg1ziiqLG0HvttMyoZEd/v+iHoWI5rpXvgBw==
X-Received: by 2002:a1c:2d57:: with SMTP id t84-v6mr2059134wmt.9.1543396535275;
        Wed, 28 Nov 2018 01:15:35 -0800 (PST)
Received: from dell ([2.31.167.233])
        by smtp.gmail.com with ESMTPSA id n15sm6104925wrt.21.2018.11.28.01.15.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 01:15:34 -0800 (PST)
Date:   Wed, 28 Nov 2018 09:15:32 +0000
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
Subject: Re: [PATCH v3 1/4] mfd: stmpe: Move ADC related defines to header of
 mfd
Message-ID: <20181128091532.GU4272@dell>
References: <20181123142411.8921-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181123142411.8921-1-dev@pschenker.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Nov 2018, Philippe Schenker wrote:

> Move defines that are ADC related to the header of the overlying mfd,
> so they can be used from multiple sub-devices.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> ---
> 
> Changes in v3:
>  - None
> 
> Changes in v2:
>  - This is a new added commit. Separate commit for moving the defines out of
>    drivers/input/touchscreen/stmpe-ts.c to overlying mfd-device drivers/mfd/stmpe.c
>  - Pre-fix defines with STMPE_
> 
>  drivers/input/touchscreen/stmpe-ts.c | 34 +++++++++++-----------------
>  include/linux/mfd/stmpe.h            | 11 +++++++++

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

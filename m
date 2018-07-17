Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0889BECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 23:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9622075A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 23:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CeRaRAQ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB9622075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731293AbeGRA30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 20:29:26 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37360 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730180AbeGRA30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 20:29:26 -0400
Received: by mail-pl0-f68.google.com with SMTP id 31-v6so1153236plc.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 16:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gr7Gr10Z8fKJ2NcUyJIp3rVVHNSL1BoHfyMbYkz+Unw=;
        b=CeRaRAQ0MvtsAbR/GsKTXjQSaCcb6ZrVoG2UgeWqp1omz4BQUr7k0Yjp5gu4LXwFTE
         N0nAbjYft1qqdTKofJ8ObzRpeKY7RAG30Kl1EUt/S6TsctdgY/sCod9h6FN741wpiMWY
         yHGtux9xfHo8vQpsrz1o1Y+V/kpqXAPgsmT4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gr7Gr10Z8fKJ2NcUyJIp3rVVHNSL1BoHfyMbYkz+Unw=;
        b=hkg181QkPPq7q+epo+jou7w0KbM6LeriA+9NsdJ1vpC4ET0ti7kH1FFFE953WU9+03
         7NoFFZJwt1D8xMeksdw2wN6cB2iclJrQvWt4OO9VvLxLSuKs5HQKi40rO734W8doHfjB
         wxnVYjlq7D0VXzJ7l20/nqs3F+Oc9fKCDW5+DoDrwcNi+rjby/+2stiw5EVezGdub9wT
         OPkRz9qc64prmubs2XQCMHrVAXRSepjpvwdnRwWGE8z98/Qxrva/xfKd1dfXnbjowSDM
         lMCNhpcRsR2GIkU2g9ROdn0xB+3EbKLKG5+Zk+YPkRNND33KU6sRaUhQmpasAqwrvREt
         JHGw==
X-Gm-Message-State: AOUpUlF9h4yMGlgCeRsB7+2tu8kT+3eH/DyKwAnDJy7Ys5GE4nLMqOuG
        e2OAWWvsPbOgspKWYsuXA9O04Q==
X-Google-Smtp-Source: AAOMgpehVbDKkUy7/Ulsbh4te9qUPulHqyVML0XjK/bl0aArue1qwaTv9lg2g7VTRmCncujC/7QKXQ==
X-Received: by 2002:a17:902:6f02:: with SMTP id w2-v6mr3461468plk.216.1531871664705;
        Tue, 17 Jul 2018 16:54:24 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id g11-v6sm2486591pfh.63.2018.07.17.16.54.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 16:54:24 -0700 (PDT)
Date:   Tue, 17 Jul 2018 16:54:23 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        edubezval@gmail.com, smohanad@codeaurora.org,
        vivek.gautam@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 4/7] thermal: tsens: Rename tsens-8996 to tsens-v2 for
 reuse
Message-ID: <20180717235423.GE129942@google.com>
References: <cover.1531384019.git.amit.kucheria@linaro.org>
 <3bd2c05db1bfe6fd3891abd87b0c767152346a1d.1531384019.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3bd2c05db1bfe6fd3891abd87b0c767152346a1d.1531384019.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 02:09:05PM +0530, Amit Kucheria wrote:
> The TSENS block inside the 8996 is internally classified as version 2 of
> the IP. Several other SoC families use this block and can share this code.
> 
> We rename get_temp() to reflect that it can be used across the v2 family.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/thermal/qcom/Makefile                     |  2 +-
>  drivers/thermal/qcom/{tsens-8996.c => tsens-v2.c} | 25 ++++++++---------------
>  2 files changed, 9 insertions(+), 18 deletions(-)
>  rename drivers/thermal/qcom/{tsens-8996.c => tsens-v2.c} (66%)
> 
> diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
> index 2cc2193..a821929 100644
> --- a/drivers/thermal/qcom/Makefile
> +++ b/drivers/thermal/qcom/Makefile
> @@ -1,2 +1,2 @@
>  obj-$(CONFIG_QCOM_TSENS)	+= qcom_tsens.o
> -qcom_tsens-y			+= tsens.o tsens-common.o tsens-8916.o tsens-8974.o tsens-8960.o tsens-8996.o
> +qcom_tsens-y			+= tsens.o tsens-common.o tsens-8916.o tsens-8974.o tsens-8960.o tsens-v2.o
> diff --git a/drivers/thermal/qcom/tsens-8996.c b/drivers/thermal/qcom/tsens-v2.c
> similarity index 66%
> rename from drivers/thermal/qcom/tsens-8996.c
> rename to drivers/thermal/qcom/tsens-v2.c
> index 3e60cec..44d3736 100644
> --- a/drivers/thermal/qcom/tsens-8996.c
> +++ b/drivers/thermal/qcom/tsens-v2.c
> @@ -1,27 +1,18 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2015, The Linux Foundation. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 and
> - * only version 2 as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> + * Copyright (c) 2018, Linaro Limited
>   */
>  
> -#include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include "tsens.h"
>  
> -#define STATUS_OFFSET	0xa0
> -#define LAST_TEMP_MASK	0xfff
> +#define STATUS_OFFSET		0xa0
> +#define LAST_TEMP_MASK		0xfff
>  #define STATUS_VALID_BIT	BIT(21)
>  #define CODE_SIGN_BIT		BIT(11)
>  
> -static int get_temp_8996(struct tsens_device *tmdev, int id, int *temp)
> +static int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)
>  {
>  	struct tsens_sensor *s = &tmdev->sensor[id];
>  	u32 code;
> @@ -73,12 +64,12 @@ static int get_temp_8996(struct tsens_device *tmdev, int id, int *temp)
>  	return 0;
>  }
>  
> -static const struct tsens_ops ops_8996 = {
> +static const struct tsens_ops ops_generic_v2 = {
>  	.init		= init_common,
> -	.get_temp	= get_temp_8996,
> +	.get_temp	= get_temp_tsens_v2,
>  };
>  
>  const struct tsens_data data_8996 = {
>  	.num_sensors	= 13,
> -	.ops		= &ops_8996,
> +	.ops		= &ops_generic_v2,
>  };

nit: the unrelated cleanup (SPDX identifier, removal of header,
indendation fixes) could have been done in a separate patch. This
patch is small enough though that it doesn't add too much
distraction and one could argue that this patch creates a new
file ;-)

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

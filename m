Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BD5C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7089C20893
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kgHq/Jl0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7089C20893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733043AbeGZR4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 13:56:02 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33853 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731856AbeGZR4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 13:56:01 -0400
Received: by mail-pl0-f67.google.com with SMTP id f6-v6so1072428plo.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 09:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c9iF+U7dQUahRCWtGKav/2xWhC5XpoY6NxVIGXCntFE=;
        b=kgHq/Jl0wFun2YSzV9CPWZxasHGJgkYqC+2UvmKAV4uABgRo3n2FQaUNsN5hwVgi76
         VSe4fK2gHtKeQ/QtYlzN/4hFX+6PoIeBMuM9r/t/yi6iWnGHIhQerZZNDs1DhqP5avVx
         7vnaAgOFBEIr5uynKVpM6AaE/j9Fc/ikcbGKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c9iF+U7dQUahRCWtGKav/2xWhC5XpoY6NxVIGXCntFE=;
        b=fy60IdwPANef9smCZyS4EC/U2Da8lV7yD7cHovecSDnDv7IOBbOCEQJ7pYfQXZb9zv
         93NySJYo/n9AZNOZJw+1Q8rhLIrYFLuUure7ndDkGUyYUQTqJfyoCAoswGZrAubmDTMJ
         OGPDeaHC7wou3bb3liqIQ8jwxv5K2JGY31jTFKaLTHHWejG11LXcZ1Voe/IlzHITr2yX
         q+wXQ+8nOhfz2bw9gGYQSa5DM4EQPrNHXe+gPsMQCnvrqpor68QKD/IaJgwfFIWBSLv5
         2o1gBAs/p7zKHonFFTYvtT2TOMSKr9+hWx00puRiHkSnGCnZcN8cwT7ACMH8nHZ+cU4M
         C0Ow==
X-Gm-Message-State: AOUpUlEFFyhKqVgyb1CmSmry58GvkyLo6TzITiz6TcpZjdhAzhUW5yig
        CWPOTLOwJMSwnNSb4JoYgxAw1Q==
X-Google-Smtp-Source: AAOMgpei63yn/uwxECuwFqvCNDA23pXSbhxmqMaWzZ19nfxeiZHqmL5fiiiT5FftKNhXauz2WZ6NLA==
X-Received: by 2002:a17:902:b401:: with SMTP id x1-v6mr2636998plr.236.1532623104617;
        Thu, 26 Jul 2018 09:38:24 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id k123-v6sm3484282pga.21.2018.07.26.09.38.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 09:38:23 -0700 (PDT)
Date:   Thu, 26 Jul 2018 09:41:32 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 3/3] thermal: tsens: Fix negative temperature reporting
Message-ID: <20180726164132.GC5450@tuxbook-pro>
References: <cover.1532600791.git.amit.kucheria@linaro.org>
 <52516c287c9455676e7cbde4a4fa94282d73367f.1532600791.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52516c287c9455676e7cbde4a4fa94282d73367f.1532600791.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26 Jul 03:33 PDT 2018, Amit Kucheria wrote:

> The current code will always return 0xffffffff in case of negative
> temperatures due to a bug in how the binary sign extension is being done.
> 
> Use sign_extend32() instead.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/thermal/qcom/tsens-v2.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
> index 908e3dcb2d5c..44da02f594ac 100644
> --- a/drivers/thermal/qcom/tsens-v2.c
> +++ b/drivers/thermal/qcom/tsens-v2.c
> @@ -5,19 +5,20 @@
>   */
>  
>  #include <linux/regmap.h>
> +#include <linux/bitops.h>
>  #include "tsens.h"
>  
>  #define STATUS_OFFSET		0xa0
>  #define LAST_TEMP_MASK		0xfff
>  #define STATUS_VALID_BIT	BIT(21)
> -#define CODE_SIGN_BIT		BIT(11)
>  
>  static int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)
>  {
>  	struct tsens_sensor *s = &tmdev->sensor[id];
>  	u32 code;
>  	unsigned int status_reg;
> -	int last_temp = 0, last_temp2 = 0, last_temp3 = 0, ret;
> +	u32 last_temp = 0, last_temp2 = 0, last_temp3 = 0;
> +	int ret;
>  
>  	status_reg = tmdev->tm_offset + STATUS_OFFSET + s->hw_id * 4;
>  	ret = regmap_read(tmdev->map, status_reg, &code);
> @@ -54,12 +55,8 @@ static int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)
>  	else if (last_temp2 == last_temp3)
>  		last_temp = last_temp3;
>  done:
> -	/* Code sign bit is the sign extension for a negative value */
> -	if (last_temp & CODE_SIGN_BIT)
> -		last_temp |= ~CODE_SIGN_BIT;
> -
> -	/* Temperatures are in deciCelicius */
> -	*temp = last_temp * 100;
> +	/* Convert temperature from deciCelsius to milliCelsius */
> +	*temp = sign_extend32(last_temp, fls(LAST_TEMP_MASK) - 1) * 100;
>  
>  	return 0;
>  }
> -- 
> 2.17.GIT
> 

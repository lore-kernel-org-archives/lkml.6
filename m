Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA25C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C2420843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Int6DamW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C2420843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731902AbeGZBDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 21:03:40 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:32998 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731522AbeGZBDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 21:03:39 -0400
Received: by mail-pl0-f65.google.com with SMTP id 6-v6so3956286plb.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 16:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TI9y3QJnwJ8xsSkl1/i3nEl03g27qlylrQLC6+UXpD4=;
        b=Int6DamWZsJymYpIhZV8juX7pwxy+DB9CjVhkzw2q8lBI0ElkxnkTlLDstBgvf62iH
         mQZS1OENJSJpzBjYhhDUTPsgJfhJjHIo9/8scHI7bN4kaEB5xHjaCYkBfDuxFfEd8/gg
         dbIc/EN3InjW2aUCsiDu1eGFCXqFC8NEDwqgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TI9y3QJnwJ8xsSkl1/i3nEl03g27qlylrQLC6+UXpD4=;
        b=mCoSSDWZi/dWGYXesys6zfYMgVpk2qi3ZcdqydQuhVWArq+VeT0JKAQrdxxsVBvfFC
         sFGvv6JPq8AGxnB6WzBZ1zqMK/HXDq4ibKdgubtinEhtdXgZCaeyyBbQQDpTQBKfA9gf
         f0fYM1dnWRYlmxfhfSi2VvFP1ealAzjjK8lV72Cd4mXOftNJDyOVazngdm5ssGd5Wpxq
         TbaH6o7YeK+pE1DX7PQMYwDiBxtuNDhMZ9tqdecVYPE+ifGuE5zt4aMFMH8BzkXSW0mB
         t8u0jV3IvPiL+qp6FjkH/KZBl/F8ydcaVUNWU5gsO28jvDflcsxjcXoIpm9bVE+FkKTV
         Q0Dw==
X-Gm-Message-State: AOUpUlEmTSvxmh055j9OwO262tqZrfv+0CeOq/hB7ZfcJuvwwzFkFpkq
        rZLhXqnbueZRL4A+ZDOWzON+G1pLg/I=
X-Google-Smtp-Source: AAOMgpeJKf7ne9iRCFzMucx5NJUyWcILYb3kOUqFQGgm4iKoc5qEcotiW89JYQZlP37JXMy8zFed4g==
X-Received: by 2002:a17:902:209:: with SMTP id 9-v6mr23068102plc.270.1532562577136;
        Wed, 25 Jul 2018 16:49:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id s27-v6sm25734461pfk.133.2018.07.25.16.49.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 16:49:36 -0700 (PDT)
Date:   Wed, 25 Jul 2018 16:49:36 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        edubezval@gmail.com, smohanad@codeaurora.org,
        andy.gross@linaro.org, dianders@chromium.org,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 3/3] thermal: tsens: Fix negative temperature reporting
Message-ID: <20180725234936.GT129942@google.com>
References: <cover.1531898088.git.amit.kucheria@linaro.org>
 <42d6f2a6f9babd6351bd2fcde4000d5ca9c351ce.1531898088.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <42d6f2a6f9babd6351bd2fcde4000d5ca9c351ce.1531898088.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 12:55:03PM +0530, Amit Kucheria wrote:
> The current code will always return 0xffffffff in case of negative
> temperatures due to a bug in how the binary sign extension is being done.
> 
> Use sign_extend32() instead.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/qcom/tsens-v2.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
> index 908e3dc..46abc21 100644
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
> +	/* Convert temperatures to milliCelicius */

nits:

s/temperatures/temperature/
s/milliCelicius/milliCelsius/

> +	*temp = sign_extend32(last_temp, fls(LAST_TEMP_MASK) - 1) * 100;
>  
>  	return 0;
>  }

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

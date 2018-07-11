Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFB1C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CCB020870
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ULDdkVKz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CCB020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389800AbeGKQnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:43:13 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43803 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388213AbeGKQnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:43:13 -0400
Received: by mail-pf0-f196.google.com with SMTP id y8-v6so18764116pfm.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 09:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TCkqlh9AWJHgA9aS+GR4d8+1MwSUDTEf4bx5hPTLU0w=;
        b=ULDdkVKzyO7QEmvVHDZ2t84Cjg0NY1YZQPzRIR0L/pmEJWv09TloIqgPtL44ghSCcU
         rOmlv0jkHh5UQWod6eqzVHqKqs03ERuJR+V/2Xyq9yFXutai4281Rq8z4y7zZ/1bUmV2
         gdUSDYBgd2XQ0I09rGShP62mgMUL5U78FV1fY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TCkqlh9AWJHgA9aS+GR4d8+1MwSUDTEf4bx5hPTLU0w=;
        b=VxUYmQr9bMgixNvLIVYCBC6P4SykjSs0IivdK5VMcgzXlMumvIDHSm604avnnSNw6v
         ziL3g4GfmwbPHlLswmPp/2Uk8R8wullDcBakMlbOPYgcHcTWsB1N1zGmRnYSmkJu92Ss
         EA3sFtBuzBJn3h3ZlwlQOqaZumPeBs/7uKNBDAKFBBZmQuCVtQWnqUCHU0vtls6wmJFW
         2yiLqQQS+aVmpU2/E8JlFcDOFUSYbQiBHernBzswyzMfTxE/GaELw2H39prsd+5XNBOr
         JW2NoOAM09AmCrukGjUjf38uq9VyZtv9FdF94UjngHfmDh5fZmNAGCwQkAm5EoqjguHa
         kNbg==
X-Gm-Message-State: APt69E2ZJb32ibApjcsNjZoSqB5MSZux/QqDgNX66IyUrO6tPY+XTnPT
        laqkQ3Wl3fXzX1laCjTo6oJCtg==
X-Google-Smtp-Source: AAOMgpcIegqmOkAxtJsOaKtZbxeLFHkA2JW8LaPSDk/RFXe/hM1Y4nEIlXKZDTwoR27evM+dzjjY4w==
X-Received: by 2002:a62:9992:: with SMTP id t18-v6mr30869830pfk.239.1531327084285;
        Wed, 11 Jul 2018 09:38:04 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q26-v6sm2237641pff.9.2018.07.11.09.38.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 09:38:03 -0700 (PDT)
Date:   Wed, 11 Jul 2018 09:40:45 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, edubezval@gmail.com,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Rob Herring <robh@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 5/7] thermal: tsens: Add generic support for TSENS v2
 IP
Message-ID: <20180711164045.GD545@tuxbook-pro>
References: <cover.1531135999.git.amit.kucheria@linaro.org>
 <278b59d6a25f874a087995368cecec2572b5be89.1531135999.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <278b59d6a25f874a087995368cecec2572b5be89.1531135999.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09 Jul 04:43 PDT 2018, Amit Kucheria wrote:

> SDM845 uses v2 of the TSENS IP block but the get_temp() function
> appears to be identical across v2.x.y in code seen so far. We use the
> generic get_temp() function defined as part of ops_generic_v2.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/thermal/qcom/tsens-v2.c | 6 +++++-
>  drivers/thermal/qcom/tsens.c    | 3 +++
>  drivers/thermal/qcom/tsens.h    | 5 ++++-
>  3 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
> index 34ba6c7..f40150f 100644
> --- a/drivers/thermal/qcom/tsens-v2.c
> +++ b/drivers/thermal/qcom/tsens-v2.c
> @@ -69,8 +69,12 @@ static const struct tsens_ops ops_generic_v2 = {
>  	.get_temp	= get_temp_tsens_v2,
>  };
>  
> +const struct tsens_data data_tsens_v2 = {
> +	.ops            = &ops_generic_v2,
> +};
> +
> +/* Kept around for backward compatibility with old msm8996.dtsi */
>  const struct tsens_data data_8996 = {
>  	.num_sensors	= 13,
>  	.ops		= &ops_generic_v2,
>  };
> -
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 3440166c..a2c9bfa 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -72,6 +72,9 @@ static const struct of_device_id tsens_table[] = {
>  	}, {
>  		.compatible = "qcom,msm8996-tsens",
>  		.data = &data_8996,
> +	}, {
> +		.compatible = "qcom,tsens-v2",
> +		.data = &data_tsens_v2,
>  	},
>  	{}
>  };
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index d785b37..14331eb 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -88,6 +88,9 @@ void compute_intercept_slope(struct tsens_device *, u32 *, u32 *, u32);
>  int init_common(struct tsens_device *);
>  int get_temp_common(struct tsens_device *, int, int *);
>  
> -extern const struct tsens_data data_8916, data_8974, data_8960, data_8996;
> +/* TSENS v1 targets */
> +extern const struct tsens_data data_8916, data_8974, data_8960;
> +/* TSENS v2 targets */
> +extern const struct tsens_data data_8996, data_tsens_v2;
>  
>  #endif /* __QCOM_TSENS_H__ */
> -- 
> 2.7.4
> 

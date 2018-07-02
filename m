Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FDEC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AB0624443
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aAkJaBoZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AB0624443
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932181AbeGBStF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:49:05 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39799 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932120AbeGBStD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:49:03 -0400
Received: by mail-pl0-f65.google.com with SMTP id s24-v6so8350318plq.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 11:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8DcgL7ZJO88FRHNOZCvhy917idLbcarXVnpvSeJ0Lrs=;
        b=aAkJaBoZ0c+FYSqw+vcnSzfBUH1X4VgdUl2DO733jsLjNYORFnPKG9tCKG29NyrKfa
         b7zkGOALkbbP1qjxqWr3XleF2S3cbKLZFvfj/ks+3rYP1aAJaLiEMXKprxsVoF5sRM1y
         aIx5c+H/a8ZCv4qVUX5TzVgp4/YpKFI7kF5+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8DcgL7ZJO88FRHNOZCvhy917idLbcarXVnpvSeJ0Lrs=;
        b=SF4NviQ/4RaLKQOky+QXnFowiQ9przuSVdYw4KnZ9ibjq4lwKkjs+eyg3B5jSCC1Gx
         yactYFRetbuSLOlbT6wL2V/K9nSzJdWSbocvFB7nv/tGDU+WuZtW0OkQqgvNEAIKHCSC
         VS2563dc3UiDvXZOiHIlHg7EsV6Y2LCCPAjVSjdc3RCE8nQ1Lw/CBx1YIRn0vG7Eokyd
         9PN8UqvY9Ec0apn9tK/ZEuUwvdWikwI/VCqkU0rIoXpqnp20pTi6Y0zxMdocxNcG5IVX
         QBMPZ4Rf/viccIoficaT8WqJumbChhxv2F9c7tet0U4RTz5m0Ts2hhZMdZlXJJAzlSlW
         A7vw==
X-Gm-Message-State: APt69E1eM1OqHwBgxY+NqdYV7i5L6DypmYcs+wVKTY8EUTkOAqofuAoA
        sCwwqTA39uI5E5tAWKRiUWmd8A==
X-Google-Smtp-Source: ADUXVKKrnXRBvsl3joEvQXtzmiog1C/Uh4URtytblLHtMZZ57pLqua6aBTKrUv7udbHGFtli0q/9qg==
X-Received: by 2002:a17:902:622:: with SMTP id 31-v6mr26721154plg.135.1530557342394;
        Mon, 02 Jul 2018 11:49:02 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id w7-v6sm22322639pgs.68.2018.07.02.11.49.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 11:49:01 -0700 (PDT)
Date:   Mon, 2 Jul 2018 11:51:32 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, edubezval@gmail.com,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 4/6] thermal: tsens: Add support for SDM845
Message-ID: <20180702185132.GC2050@tuxbook-pro>
References: <cover.1530533998.git.amit.kucheria@linaro.org>
 <43e3ae530334efab3fa0151430879f03731e9daa.1530533998.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43e3ae530334efab3fa0151430879f03731e9daa.1530533998.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 02 Jul 05:44 PDT 2018, Amit Kucheria wrote:

> SDM845 uses v2.4.0 of the TSENS IP block but the get_temp() function
> appears to be identical across v2.x.y in code seen so far. We use the
> generic get_temp() function.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.txt | 2 ++
>  drivers/thermal/qcom/tsens-v2.c                          | 6 +++++-
>  drivers/thermal/qcom/tsens.c                             | 6 ++++++
>  drivers/thermal/qcom/tsens.h                             | 5 ++++-
>  4 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> index 06195e8..075182e 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> @@ -5,6 +5,8 @@ Required properties:
>   - "qcom,msm8916-tsens" : For 8916 Family of SoCs
>   - "qcom,msm8974-tsens" : For 8974 Family of SoCs
>   - "qcom,msm8996-tsens" : For 8996 Family of SoCs
> + - "qcom,tsens-v2.4.0"  : For SDM845 Family of SoCs
> + - "qcom,tsens-v2"      : Generic fallback binding for any Soc using 2.x.y version of the tsens IP
>  
>  - reg: Address range of the thermal registers
>  - #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description.
> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
> index 2eca7ff..1871945 100644
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
> index 3440166c..992ed17 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -72,6 +72,12 @@ static const struct of_device_id tsens_table[] = {
>  	}, {
>  		.compatible = "qcom,msm8996-tsens",
>  		.data = &data_8996,
> +	}, {
> +		.compatible = "qcom,tsens-v2.4.0",
> +		.data = &data_tsens_v2,
> +	}, {
> +		.compatible = "qcom,tsens-v2",
> +		.data = &data_tsens_v2,
>  	},
>  	{}
>  };
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index dc56e1e..69212cb 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -87,6 +87,9 @@ void compute_intercept_slope(struct tsens_device *, u32 *, u32 *, u32);
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

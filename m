Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC95C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 19:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A97120779
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 19:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="g9+cgC/C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A97120779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752839AbeGDTOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 15:14:48 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37848 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752615AbeGDTOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 15:14:09 -0400
Received: by mail-pl0-f68.google.com with SMTP id 31-v6so151587plc.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 12:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eAYt6KLxpDk89eLGjFPeZk5xox60zcAyMxlexxCmPZI=;
        b=g9+cgC/CpBhopcoTSBbOMMu1rsmnrzv7mtELLPr3roFG8s8leZO3SILGJv5iOp3H6K
         22/xW5m3QXJzp99XvFwqHgD5ZFCU3zrGRxBCZ/+2Kuma19vIl/qWusvockkXXiZMgxBR
         N8gpgkDQmT/gYQZN3uRxLjiZPFoTdy57Me0vI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eAYt6KLxpDk89eLGjFPeZk5xox60zcAyMxlexxCmPZI=;
        b=bB7P00ixCChqxQJ9fNfFO6wbj++yqLrBfWFMsymv7iyntKUj/0TduZG8LAhyhiEAdu
         oAMzThht1YwfNRZvszXixzaDHmNR1lzR8sl7R2MHxuv8KhsQDHeT8D7RrPc3ACgFrraF
         gzhTfQjtADOTRQEf14eJ5RpCOl55MO5tyUf9Fq7YBfLfpq26jzOCoA9kEb6Qb0+hFJxI
         HbwpeAKCrYpBQzanF1lCYhXGjCouN9p7R5SoUpk/11S+c0vm8GyUoK9Q+z6vn7GqC000
         YJ5REn/RLwyWCbVa9RUBwHpGbCZSRprd4GBV05nPwLdPATCTB0dlZYJ1rvnNuOAmp5J0
         q5BQ==
X-Gm-Message-State: APt69E2mmKb8/XfqiOkkKFDfGZ14dZ5Dd/XTaOU6cuw1uW2Ej5iz4ybn
        DoP20LfJbY9Ls+OqAPbhUyTwOfDQ/1w=
X-Google-Smtp-Source: AAOMgpdT1ax6IZ3kE9OSUDVk/eb0muME+XutpwDhUoWEfBHvHYGVRqrgqASgnQaT9leBFdGwVs/Rvw==
X-Received: by 2002:a17:902:8207:: with SMTP id x7-v6mr3185261pln.57.1530731649185;
        Wed, 04 Jul 2018 12:14:09 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d9-v6sm8634228pfb.92.2018.07.04.12.14.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 12:14:08 -0700 (PDT)
Date:   Wed, 4 Jul 2018 12:14:10 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: llc-slice: Add missing MODULE_LICENSE()
Message-ID: <20180704191410.GB16463@builder>
References: <20180629154447.2272-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629154447.2272-1-niklas.cassel@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 29 Jun 08:44 PDT 2018, Niklas Cassel wrote:

> Add missing MODULE_LICENSE().
> According to the SPDX-License-Identifier, the license is GPL v2.
> 
> Fixes the following warning:
> WARNING: modpost: missing MODULE_LICENSE() in drivers/soc/qcom/llcc-slice.o
> 
> Fixes: c5c7385f89bf ("drivers: soc: Add LLCC driver")
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/soc/qcom/llcc-slice.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/soc/qcom/llcc-slice.c b/drivers/soc/qcom/llcc-slice.c
> index fcaad1a4b41d..54063a31132f 100644
> --- a/drivers/soc/qcom/llcc-slice.c
> +++ b/drivers/soc/qcom/llcc-slice.c
> @@ -9,6 +9,7 @@
>  #include <linux/device.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
> +#include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/of_device.h>
>  #include <linux/regmap.h>
> @@ -333,3 +334,5 @@ int qcom_llcc_probe(struct platform_device *pdev,
>  	return qcom_llcc_cfg_program(pdev);
>  }
>  EXPORT_SYMBOL_GPL(qcom_llcc_probe);
> +
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.17.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

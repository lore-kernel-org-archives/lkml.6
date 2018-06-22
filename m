Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D8FC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF68024642
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QD9ixist"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF68024642
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754685AbeFVRC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:02:58 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33701 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754441AbeFVRCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:02:55 -0400
Received: by mail-pl0-f65.google.com with SMTP id 6-v6so3780125plb.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 10:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kCCJPS2hm9qeEVxg5jjEQbFc5/9fqdwT4Ofnr0pC9t4=;
        b=QD9ixistRGNGmUiO1Vlwd9CszNmbjc+iMWIPA9gI/sHi5LCcNUtbHLo1+3dNmB+b4A
         yUaR1lk5Ds+Fy4slieoYOI3s9OXTXFg20cuEPK7NpEWUOwxlsyeobTfCgXrrQpIL0bpB
         edKK1rL2sd3bBTHE/c/FdY4Ur77f+pqLf8jrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kCCJPS2hm9qeEVxg5jjEQbFc5/9fqdwT4Ofnr0pC9t4=;
        b=Qbrx/S0+XbXoJgsN8xJ+cdipI1Z3jwKktJpFgHGWBM2uScCTcSCS5/gqUcso+ZYwYm
         a9oks+SuEYt14ZwjGQuCH13Yl/19YlExReIhsSP8InrLoOrFTvwq7pQxNMwdZb6Ivpt3
         wfAO75ktcLujRmyX4JyEIffZaY5lOKgAiIPCXZYYx6k+RN2pFikAOluMemJxFCG+7tJA
         TcPZYia+MzQsctDSbwkr7CymRV6OvZ9D/w909suco3H7L94Rg2KNoeXXaOQmqmVTtygz
         0M95CvCMwI5B/j6TlGnX28OHr97pSY++T6ZLxTUNneK8qF9b1GxDXlhooF0mL2SUh0WV
         ioeA==
X-Gm-Message-State: APt69E2YT8hsFwbJVdlmmxinNdNKj5Zm1tc4VtfWL8WBdyeYvEOx8yex
        Gd5bxlYouOP01eq+LtvsbHygqg==
X-Google-Smtp-Source: ADUXVKIMUdB2tnkyz9/B4imyhrETUsZQsSPZcOWthD5CzAvH+tUpELOoUSrxGb0bihMGsOJlHGRy7g==
X-Received: by 2002:a17:902:1566:: with SMTP id b35-v6mr2519615plh.107.1529686974927;
        Fri, 22 Jun 2018 10:02:54 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 14-v6sm11057251pgc.63.2018.06.22.10.02.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 10:02:54 -0700 (PDT)
Date:   Fri, 22 Jun 2018 10:02:51 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     andy.gross@linaro.org, tdas@codeaurora.org,
        collinsd@codeaurora.org, sboyd@kernel.org, ilina@codeaurora.org,
        broonie@kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: qcom: rpmh-rsc: Check cmd_db_ready() to help
 children
Message-ID: <20180622170251.GD10336@builder>
References: <20180618172230.241960-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618172230.241960-1-dianders@chromium.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 18 Jun 10:22 PDT 2018, Douglas Anderson wrote:

> Children of RPMh will need access to cmd_db.  Rather than having each
> child have code to check if cmd_db is ready let's add the check to
> RPMh.
> 
> Suggested-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> This code is based upon v11 of Lina and Raju's RPMh series.
> 
> With this we'll be able to remove this boilerplate code from
> clk-rpmh.c and qcom-rpmh-regulator.c.  Neither of these files has
> landed upstream yet but patches are pretty far along.
> 
>  drivers/soc/qcom/rpmh-rsc.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index 144a058407c0..ad85523bdd3b 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -18,6 +18,7 @@
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  
> +#include <soc/qcom/cmd-db.h>
>  #include <soc/qcom/tcs.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>  
> @@ -621,6 +622,18 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
>  	struct rsc_drv *drv;
>  	int ret, irq;
>  
> +	/*
> +	 * Even though RPMh doesn't directly use cmd-db, all of its children
> +	 * do.  To avoid adding this check to our children we'll do it now.
> +	 */
> +	ret = cmd_db_ready();
> +	if (ret) {
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "Command DB not available (%d)\n",
> +									ret);
> +		return ret;
> +	}
> +
>  	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
>  	if (!drv)
>  		return -ENOMEM;
> -- 
> 2.18.0.rc1.244.gcf134e6275-goog
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

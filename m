Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C1EC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 391AD24624
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gm1USk95"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 391AD24624
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933795AbeFVQzA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:55:00 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36878 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933549AbeFVQy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:54:57 -0400
Received: by mail-pg0-f68.google.com with SMTP id r21-v6so3223216pgv.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 09:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y9e0bklUnUlBvXG3pRt1UlBVrglub8GcRRBCHjQ0ezA=;
        b=gm1USk95gjTN7zvyYzUE6wxlSXmFbLjj2Fg6PXhPGzS2TJbURg5jcLNAL/XrCj1PUq
         yTxJ8k5yHZUKdQ1TVFSZ+E8Bzt2PrMd19cu82bFUeu//0Uh50iuYFGdkMmG12T85QMY/
         xd3y3BD4nIh3o9GdyPOMGhYXpHpJ0Ay7eguVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y9e0bklUnUlBvXG3pRt1UlBVrglub8GcRRBCHjQ0ezA=;
        b=spMln/Pj85B1A3LfjtwHYcD9lCZJybJxi8D3MMg+EWCV7WRERt870DHwikE884ftPj
         0HAJiL27et8DVJGBMaqlC4pmJs3kDZNJ8fWoOqpeA5bU7ENl6VSlb/8PUd8+iWRP5Dmk
         /ZVmsqpjjjZaSKFS3gDS05oPXifsD8T+DBGFIXaFRgFEq764qjXkHsesbsOdnLvwSZSm
         AFDbzYnKk5hMLMQMKP5DYTNFE01RaMkYdGz8CnDb3PA3aCV6+UcV7iDiUdob00mq7VHk
         mnATGboIOKI2DfRw4424Auz+lQacMwUCMCL1Ghw2N9m/6aPVB9EqteAPDMTpNUWObw41
         ugaw==
X-Gm-Message-State: APt69E0PgtukSptQHAPi0EKXz6axcIZXrgFYCIm4GXKZZIQLFyOGtwbh
        REdyqZqvxDEIrU2Hhv/YUYxOEQ==
X-Google-Smtp-Source: ADUXVKIGp0eiPBebconH3BDZw3ppZkopb+m4jHBWak+iWPHpJlr9DuZ8kJ0fPKzsvVY7t4lsMypypA==
X-Received: by 2002:a62:2044:: with SMTP id g65-v6mr2604301pfg.40.1529686497056;
        Fri, 22 Jun 2018 09:54:57 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id r79-v6sm17837034pfe.115.2018.06.22.09.54.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 09:54:56 -0700 (PDT)
Date:   Fri, 22 Jun 2018 09:54:54 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>
Subject: Re: [PATCH] soc: qcom: geni: Make version macros simpler
Message-ID: <20180622165454.GA10336@builder>
References: <20180518224750.232742-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518224750.232742-1-swboyd@chromium.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 18 May 15:47 PDT 2018, Stephen Boyd wrote:

> This macro doesn't work, because it hides a local variable inside of the
> macro to hold the version and that variable name is called 'ver' and
> 'version' sometimes.
> 
> Let's change this to be more explicit. Introduce three macros for the
> major, minor, and step of the version, and require callers to pass the
> version in to get the part of the version out. This way we don't hide
> local variables inside macros and things are less evil overall.
> 
> Cc: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
> Cc: Sagar Dharia <sdharia@codeaurora.org>
> Cc: Girish Mahadevan <girishm@codeaurora.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

I was expecting that someone referenced this macro, but I guess that's
coming?

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  include/linux/qcom-geni-se.h | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/qcom-geni-se.h b/include/linux/qcom-geni-se.h
> index 5d6144977828..3bcd67fd5548 100644
> --- a/include/linux/qcom-geni-se.h
> +++ b/include/linux/qcom-geni-se.h
> @@ -225,19 +225,14 @@ struct geni_se {
>  #define HW_VER_MINOR_SHFT		16
>  #define HW_VER_STEP_MASK		GENMASK(15, 0)
>  
> +#define GENI_SE_VERSION_MAJOR(ver) ((ver & HW_VER_MAJOR_MASK) >> HW_VER_MAJOR_SHFT)
> +#define GENI_SE_VERSION_MINOR(ver) ((ver & HW_VER_MINOR_MASK) >> HW_VER_MINOR_SHFT)
> +#define GENI_SE_VERSION_STEP(ver) (ver & HW_VER_STEP_MASK)
> +
>  #if IS_ENABLED(CONFIG_QCOM_GENI_SE)
>  
>  u32 geni_se_get_qup_hw_version(struct geni_se *se);
>  
> -#define geni_se_get_wrapper_version(se, major, minor, step) do { \
> -	u32 ver; \
> -\
> -	ver = geni_se_get_qup_hw_version(se); \
> -	major = (ver & HW_VER_MAJOR_MASK) >> HW_VER_MAJOR_SHFT; \
> -	minor = (ver & HW_VER_MINOR_MASK) >> HW_VER_MINOR_SHFT; \
> -	step = version & HW_VER_STEP_MASK; \
> -} while (0)
> -
>  /**
>   * geni_se_read_proto() - Read the protocol configured for a serial engine
>   * @se:		Pointer to the concerned serial engine.
> -- 
> Sent by a computer through tubes
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C200C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 01:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C477B20827
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 01:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="L99/ZRKW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C477B20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbeJ2KWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 06:22:24 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45090 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727633AbeJ2KWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 06:22:24 -0400
Received: by mail-pg1-f195.google.com with SMTP id s3-v6so3055525pga.12
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 18:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dzsJgafHUcxMEeFPZzBQ8ipad4RXQdlSgIANYemMJMY=;
        b=L99/ZRKWmOWZg2vppg3bJZgt4c/ZxvQcnUdNoI9bMpqHaXmn/o+9MsBMyyJyqjFkz9
         8krR7L+jEfXN6hnlq2pKqRRt8Nu2n6AUyxYDViqtJlZ5rpQwDuWyM6fSDK5FIXA/BJ8y
         BYmennCh1/4JJ0s2N/ILkSu7ymAohB/YMWK9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dzsJgafHUcxMEeFPZzBQ8ipad4RXQdlSgIANYemMJMY=;
        b=RUElT1Vz55HSBl2kvL3h8Vf6JVqXDgPXxFsMgN//JhOXsh9fNyHv+QsbNTyz5lu/zZ
         PbQ4wQELOSgzQeJCGWjRu+S8tRTxLXOrFXg6geJTnxBJLgGBDjLwQ0lrDPgpPPgM+ZnM
         trineVzgql7rflJGCgGQqUSQQIV0jmz9Q4F+eayOjHfyUVrDIr3iz82KcTtbqTV9JquT
         GRw9nbMBpOB/vfbEPq5j0chQ9F7uKkd3MUN/wKu3Pf2v+OQBVjThxFi4MLv5XjOEUjrH
         dApgTKVFWLFoP6OKJG7FMMQvuabGvtOc8XA4odsHWmG1KI3AuGEiyiFYKnurkQUG+VxX
         oiLw==
X-Gm-Message-State: AGRZ1gJO6iCux9iPXbbwaHsVKUXfdmR0Yrbb4+IsPs7r9BwCG0TySvzh
        owFlZN79fKodO6LhogIAvwjXiA==
X-Google-Smtp-Source: AJdET5elkkUzivIez/ZFGgyVPWGhYKh3F2BCr/VTPSDszftyWIx/rW++eccl3tZ5CrpgYQt+RmWNbw==
X-Received: by 2002:a62:178c:: with SMTP id 134-v6mr677819pfx.29.1540776959605;
        Sun, 28 Oct 2018 18:35:59 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id i12-v6sm3411232pfe.7.2018.10.28.18.35.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 18:35:58 -0700 (PDT)
Date:   Sun, 28 Oct 2018 18:35:56 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        dianders@chromium.org, evgreen@chromium.org, benchan@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org
Subject: Re: [PATCH] arm64: dts: qcom: sdm845: Add SCM DT node
Message-ID: <20181029013556.GB1855@tuxbook-pro>
References: <20181026122542.4714-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181026122542.4714-1-sibis@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 26 Oct 05:25 PDT 2018, Sibi Sankar wrote:

> Add SCM DT node to enable SCM functionality on SDM845.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index b72bdb0a31a5..fad22acfda4d 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -221,6 +221,12 @@
>  		};
>  	};
>  
> +	firmware {
> +		scm {
> +			compatible = "qcom,scm-sdm845", "qcom,scm";
> +		};
> +	};
> +
>  	tcsr_mutex: hwlock {
>  		compatible = "qcom,tcsr-mutex";
>  		syscon = <&tcsr_mutex_regs 0 0x1000>;
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 

Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1CBC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1827B2081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DWK436v3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1827B2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbeKHQVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 11:21:18 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35373 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeKHQVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 11:21:18 -0500
Received: by mail-pl1-f195.google.com with SMTP id n4-v6so9083524plp.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 22:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HHURChZVqe0BW173VsCwP6xdtQa8mlv1jGucaXpb3J8=;
        b=DWK436v3D6W+Jy2xTfTfTxfq6O0mEZdwgXvx2qiDgzIF/uZRD/hotthecgueNzWJut
         IvxOxq+UsovEYFbP6KJ7EL/EjCBh7P598x7iUW3iRHVcM1Mx9tmrMcTJWyzdzd+RNOWH
         MViFRoW5yQOG5THwLQzXWeuYXd4AZ73+AR1Xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HHURChZVqe0BW173VsCwP6xdtQa8mlv1jGucaXpb3J8=;
        b=q2EZ1SlFF51ilvsx5GPM8EgEv1wnZF1pXg6XPRIhAeyS4Hd6f8A06yfpK9Rs/uL6G6
         XqxOYHNc7/qptF85tgfjFUvk4+0HtLmAZg2Al1mIYqiIx+6UARtxjxRwnuacrQkNLSQG
         4qpercdQ15NrJ3UqiOJi/xA97Dvkz6o2Jvka13dzE8IkhL3bB2Ww3kHzhGdk6rV+nWPp
         YZAFHUSTh2l1bCYrfQ2gjc/h2d11Mo77RKw2zh5lBO2syKRjRnZbhCobfVecot7vFzmR
         YIzwt7Pl39JqucsFGtum11Mb821vE30vzWJJ042IJ2oxAbm7pKpDZZ+F8FLi/wR7mjI4
         p5Ug==
X-Gm-Message-State: AGRZ1gK5QJuNY8IDA+wpEQjqXhHIb/sGhfmEpY558zUsMfMutMBfVXC0
        HglJVf0lNzVajj3ZMecvYOHb2A==
X-Google-Smtp-Source: AJdET5etr9dwBr9kfQbe/Niv61Che5tyxsXvIgNAQMS8y0ybEvx9XvV6TsssllMZZzhveEepVdFOkQ==
X-Received: by 2002:a17:902:703:: with SMTP id 3-v6mr3456284pli.38.1541659638672;
        Wed, 07 Nov 2018 22:47:18 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id w80-v6sm4823018pfk.11.2018.11.07.22.47.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 22:47:18 -0800 (PST)
Date:   Wed, 7 Nov 2018 22:51:03 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     ohad@wizery.com, robh+dt@kernel.org, mark.rutland@arm.com,
        alexandre.torgue@st.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH 3/5] ARM: dts: stm32: Add hwspinlock node for stm32mp157
 SoC
Message-ID: <20181108065103.GD12063@builder>
References: <20181031093032.20386-1-benjamin.gaignard@st.com>
 <20181031093032.20386-4-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031093032.20386-4-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 31 Oct 02:30 PDT 2018, Benjamin Gaignard wrote:

> Declare hwspinlock device for stm32mp157 SoC
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>

Pending the clock-names question,

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  arch/arm/boot/dts/stm32mp157c.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
> index 185541a5b69f..9b16c28f8ac3 100644
> --- a/arch/arm/boot/dts/stm32mp157c.dtsi
> +++ b/arch/arm/boot/dts/stm32mp157c.dtsi
> @@ -803,6 +803,15 @@
>  			status = "disabled";
>  		};
>  
> +		hsem: hwspinlock@4c000000 {
> +			compatible = "st,stm32-hwspinlock";
> +			#hwlock-cells = <1>;
> +			reg = <0x4c000000 0x400>;
> +			clocks = <&rcc HSEM>;
> +			clock-names = "hwspinlock";
> +			status = "disabled";
> +		};
> +
>  		rcc: rcc@50000000 {
>  			compatible = "st,stm32mp1-rcc", "syscon";
>  			reg = <0x50000000 0x1000>;
> -- 
> 2.15.0
> 

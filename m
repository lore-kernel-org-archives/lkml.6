Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2EFC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3778A208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EQiOjfhP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3778A208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbeKPF34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:29:56 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35368 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbeKPF34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:29:56 -0500
Received: by mail-pg1-f195.google.com with SMTP id 32-v6so9446149pgu.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 11:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RT+x/iQrkIWcwfEkVnN2HIogY3vnXb2WKtAGM88lLH8=;
        b=EQiOjfhPqESRBDQ/AewYzps1EJ6sMS7moeTDKFIR8j+KhbpR6pQwAK+DTUjXCUtPlv
         Qqm4xfOf+hV5IGoJHWOtvNL4hCUNv+ghduu/EUpf8rgTpLKr9/KkpDMbDxPWJgKydcyS
         owjLhNJzSJkyg5MjhmQ4I0KIH7M8M+bJ5wXU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RT+x/iQrkIWcwfEkVnN2HIogY3vnXb2WKtAGM88lLH8=;
        b=l1WLh4LdbHAfOHlaDQ7rVjJsWFE5rmrLMuevAMM/sj3UMREyie8LreDvIQNtDuaLZw
         c3V6R5wxzxoEPYhDwwnoqO1sIuEVQ9gkiEpDkyeyhrE3bY5aeHepgeKDKO1qinGmt/B4
         XNzvjLYlGFjd1ak/XEAbL+PMvxC17/C5OrUJBZBnqEBdveaKlZ0BSlFMm2t1FxS5caH7
         ntEOtJIfAJ8mhMLADfHKitREZE8s2tFWWg+ihSQrBQas9PM/OUAuxAMb+sAMNCyorTVn
         uIO0GihV0zlxq565y3/5rEf3lLmHi10F0rmRZp/Qh/kqLXftdpZDDrtR5beoDtgz3v94
         Dywg==
X-Gm-Message-State: AGRZ1gJQj9EKsiYAIgqMFjVPp3kSzWu0iy8m5LNGMpx9nIJUnk4fdayV
        RMZttBCWFadJzILUqAPUzCPEvg==
X-Google-Smtp-Source: AJdET5dFVDpQbgWGEjhej2UXiyhGj0MtYVYQ1FSdpM6d8hSkknUy9rnHNpH24s6T9dqbC9bfFU/GPA==
X-Received: by 2002:a62:9f98:: with SMTP id v24-v6mr7605506pfk.163.1542309651203;
        Thu, 15 Nov 2018 11:20:51 -0800 (PST)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id l187-v6sm25695161pfc.79.2018.11.15.11.20.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 11:20:50 -0800 (PST)
Date:   Thu, 15 Nov 2018 11:20:47 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] arm64: dts: qcom: msm8998-mtp: Add external SD
Message-ID: <20181115192047.GL10915@tuxbook-pro>
References: <1542302291-6864-1-git-send-email-jhugo@codeaurora.org>
 <1542302291-6864-5-git-send-email-jhugo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542302291-6864-5-git-send-email-jhugo@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 15 Nov 09:18 PST 2018, Jeffrey Hugo wrote:

> The externally accessible SD card slot on the MTP is driven by SDCC2.
> Wire it up for use.
> 
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi | 13 +++++++++++++
>  arch/arm64/boot/dts/qcom/msm8998.dtsi     |  1 +
>  2 files changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> index b4276da..a90b427 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> @@ -241,3 +241,16 @@
>  		};
>  	};
>  };
> +
> +&sdhc2 {
> +	status = "okay";

Please fix the indentation of the rest of the properties in this block.

> +        cd-gpios = <&tlmm 95 GPIO_ACTIVE_LOW>;
> +
> +        vmmc-supply = <&vreg_l21a_2p95>;
> +        vqmmc-supply = <&vreg_l13a_2p95>;
> +
> +        pinctrl-names = "default", "sleep";
> +        pinctrl-0 = <&sdc2_clk_on  &sdc2_cmd_on  &sdc2_data_on  &sdc2_cd_on>;
> +        pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
> +};

With that,

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

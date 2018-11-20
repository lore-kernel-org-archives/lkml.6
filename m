Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7662BC4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 18:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EACD20870
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 18:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lWusSGLS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EACD20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbeKUEwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:52:05 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38487 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbeKUEwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 23:52:04 -0500
Received: by mail-pl1-f195.google.com with SMTP id e5so1520490plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 10:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LBXkKvqDiVm+5eOtHTgtUuj2t2WfXbEXznYzz0+SFec=;
        b=lWusSGLSzzLEHxRJJ4W4ctM4AohGFEt3uMEhG7WMgqRLCyHvEH/xlvraVof5BbinDa
         19Fi6sLEUBJj2oZ1qu1nWsX1RXjOm9UsJf6YrH0VvMhp69QcpackosP8cvcDfLElvpik
         4rC8zOxEVfmE3fRCsMuRQrteMMXIlPtDEpaJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LBXkKvqDiVm+5eOtHTgtUuj2t2WfXbEXznYzz0+SFec=;
        b=Q03+MpzHu13zK2jh/Mc7nk1FoayDKuAYk12xPfSpDtOnnvVtO4R3xPSnktf4c1T8Xv
         sSgnwlMQSnB2q9Jj5cB5KgUMJvEsutgKYr5OAMf+LnuLHGYl+nfGIyz7iIsyozu+VjEq
         JXxv+wGNQmO0o90lF4yTsaRtwfR0wG05htho42mnPwjsqrjbSOO99Lv0OYsAS1rP7XJu
         qyiehgxf4W2lvR1swAT6GN7egifhfpydhHUvrs+BM5LhMDE5tU/tKFUAuQpPCoiKtUtz
         uMKuYKCF2QZaULy+o23/llX9AtAaJlDtANoxlKyY5SRt23RF6UDIqlMOaAleuTb1sWSH
         KMpw==
X-Gm-Message-State: AA+aEWak15PCmQuFBxIZnk0pE8wXHCvdgfo5h04g1/MlzdBysRTsCbCQ
        HetD1QVe32RJuZkrYEEbtZfBkw==
X-Google-Smtp-Source: AFSGD/W04va/XoGtSNKNc0T9gqecLGOJaB/9vc6fK9LCUdvRaQvbnMDDVITlfOE/ycBSvUP/7sDKDQ==
X-Received: by 2002:a17:902:d03:: with SMTP id 3-v6mr3387711plu.66.1542738095269;
        Tue, 20 Nov 2018 10:21:35 -0800 (PST)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id g69-v6sm23821756pfe.37.2018.11.20.10.21.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 10:21:34 -0800 (PST)
Date:   Tue, 20 Nov 2018 10:21:33 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] arm64: dts: qcom: pm8998: Use ADC temperature to
 temp-alarm node
Message-ID: <20181120182133.GR22824@google.com>
References: <20180927212253.177200-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180927212253.177200-1-mka@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 02:22:53PM -0700, Matthias Kaehlcke wrote:
> The temperature information from the temp-alarm block itself is very
> coarse ("temperature is above/below trip points"). Provide the driver
> with the die temperature channel of the ADC on the PMIC for more precise
> readings.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> - based on agross/for-next (7a002fe0179c "Merge branch
>   'defconfig-for-4.20' into all-for-4.20-redo"))
> - depends on e13d757279bb ("iio: adc: Add QCOM SPMI PMIC5 ADC driver")
>   from IIO pull request:
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.20a
> - to work properly https://patchwork.kernel.org/patch/10594491/ is
>   needed
> ---
>  arch/arm64/boot/dts/qcom/pm8998.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> index 048f19fa0150..fab5a826fb01 100644
> --- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> @@ -58,6 +58,8 @@
>  			compatible = "qcom,spmi-temp-alarm";
>  			reg = <0x2400>;
>  			interrupts = <0x0 0x24 0x0 IRQ_TYPE_EDGE_RISING>;
> +			io-channels = <&pm8998_adc ADC5_DIE_TEMP>;
> +			io-channel-names = "thermal";
>  			#thermal-sensor-cells = <0>;
>  		};
>  

I think this should be ready to land in for-next now that "arm64: dts:
qcom: pm8998: Add die temperature channel node to the ADC"
(a789fd0bab57) has been added.

Cheers

Matthias

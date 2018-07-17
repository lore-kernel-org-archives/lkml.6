Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4993CECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC58F20693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ReYmuAN3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC58F20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbeGQVp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:45:59 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44976 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729802AbeGQVp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:45:59 -0400
Received: by mail-pg1-f196.google.com with SMTP id r1-v6so967444pgp.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 14:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MAq+k2/fieCLlgiPVMKma/6jueUiaekU8kObx3ZsGyA=;
        b=ReYmuAN3FOZUGulFh+9NkiqMHm6tLEOLbvi+Do6LpMjQuxqn27XOt/OPuYo6atDGZ5
         4NK5oEKmjUw8fwOro9OgVsCJvXyozW5IwaQpbnYTPkcoom0Dw8jpd/XiIbLmf2kJ/QZr
         Krbm3EhXrzfx1Y9W7pF3T6f6gvHHhCUM0fWCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MAq+k2/fieCLlgiPVMKma/6jueUiaekU8kObx3ZsGyA=;
        b=TAHL9Xk0GtQ6/To9u+BoSZ7oP0QrVcRSsDwfrFtW2Wz9vJjkrU9pcGxwnvGe/21UDM
         +tQGjHJy78pSplvVaQrbeGM8aCNYYOIPBdCcH59siPBUhguSWnQrjjwCzs9eDJOShfIS
         XH1zana6D2P3EK2pWh2bKH//ZsatoRni8+zhTeH3j9fBrfE9BZ/horhLtuSYDR2JPa6P
         oVq4n4kuqRyluVsdyT98/OmvdFLr6Iyli8VZTt/J/j01Quqcocjkzb0l4Nq5sB1FxcHF
         iW8eNjiW7+vBNUuIbhW1CpbsOy/FSs54eP+NRh8X+Y+EQjRZsx5CEVB4zaJ5X90JYikG
         gowQ==
X-Gm-Message-State: AOUpUlGdCKf5dj24+pi6pJ72UYJxCSTHT9lbJvyyKLNpp1LLG9J/p+Bi
        D0I9R18+bnum0i9M1cyAXqH39A==
X-Google-Smtp-Source: AAOMgpcuUGlEzlC1ustB0YAd+liDWQ1VT4JE6O/IfNCKJT7n2szxqH5RYFFjdcvV+wgqT3HipKTHFA==
X-Received: by 2002:a63:e318:: with SMTP id f24-v6mr3013574pgh.175.1531861889470;
        Tue, 17 Jul 2018 14:11:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id n11-v6sm2768184pgc.22.2018.07.17.14.11.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 14:11:28 -0700 (PDT)
Date:   Tue, 17 Jul 2018 14:11:28 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc:     linux-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v4 2/3] arm64: dts: qcom: pm8998: Add spmi-temp-alarm node
Message-ID: <20180717211128.GB129942@google.com>
References: <20180717210815.245639-1-mka@chromium.org>
 <20180717210815.245639-2-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180717210815.245639-2-mka@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 02:08:14PM -0700, Matthias Kaehlcke wrote:
> This adds the spmi-temp-alarm node to pm8998 based on the examples in the
> bindings.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

I should have added:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

> ---
> Changes in v4:
> - none
> 
> Changes in v3:
> - changed node name from 'qcom,temp-alarm@2400' to 'temp-alarm@2400'
> - removed controller register length value from 'reg'
> 
> Changes in v2:
> - none
> ---
>  arch/arm64/boot/dts/qcom/pm8998.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> index 92bed1e7d4bb..7eea94701b23 100644
> --- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> @@ -11,6 +11,13 @@
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> +		pm8998_temp: temp-alarm@2400 {
> +			compatible = "qcom,spmi-temp-alarm";
> +			reg = <0x2400>;
> +			interrupts = <0x0 0x24 0x0 IRQ_TYPE_EDGE_RISING>;
> +			#thermal-sensor-cells = <0>;
> +		};
> +
>  		pm8998_gpio: gpios@c000 {
>  			compatible = "qcom,pm8998-gpio", "qcom,spmi-gpio";
>  			reg = <0xc000>;

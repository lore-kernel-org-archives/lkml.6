Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E380C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 21:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21F79243D2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 21:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KvhXSyHO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F79243D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753287AbeGCVs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 17:48:26 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44331 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753159AbeGCVsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 17:48:23 -0400
Received: by mail-pl0-f68.google.com with SMTP id m16-v6so1632374pls.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 14:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zu0ewdK9sB0im189WeoIEE+LL2ocUAWsXvwjBauS7a4=;
        b=KvhXSyHOu+OhpqfhktAq8qH0ViswwOUBkg1tJErIZ9gW07NlseZ5A4u9UjxLdgQjM3
         yL1g3k2C6rYo8A5Z8xE5WqLsQaJdk2M3CQ+7HACGfYng6N606gxBTaEdFnPmHPv6Pkrd
         X4z6O9rrhHfIsv7okWQVP3vUHxyT1ink9L5l4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zu0ewdK9sB0im189WeoIEE+LL2ocUAWsXvwjBauS7a4=;
        b=TgbgR/rg/arEIJnewgVYm0VjK+c88GQ2n6RZphsaJuYGu/tM6oBLFqhXKNvhyczQIy
         Ct9pnzvwmMYXiqjZaMDWAV0XOcWZczS0nqDOesg9b3o+sddodwK3oE+hguet+D3xiy1m
         K2HjY8F4MDmTi8E5ViVe/5fb0vvdUpiDMsU3zxYFZ8uZlkpA3ia8eswu+rhY0QAzel4c
         ZmkKGzZvOUV3Tf0SZfVNvzMEH0Dg61UVbgoCq1L9BOLfJzHeX0jlFeaDZcPiiO3TtOfu
         jYUO6AkLKuXV1sjmUn3Ciz4FaNwhtymbkHWvGywWpRuxahrQ/4w+LyYO4wUDDh8gp8vf
         Gzkg==
X-Gm-Message-State: APt69E0zkr5vTh0pYA7PURtNMBadtWy6taKt5Fqnn6I+vFlnMXp8nU7m
        hrUuvg+fSP5BG2fCzCvS4IMOOQ==
X-Google-Smtp-Source: AAOMgpeMeZ3wqR6dzRbZ7AQ3kyOmeQoIQPwJvY41u9etb9SBiVAPugkW+YB9qACKvGbAT9jrllIFww==
X-Received: by 2002:a17:902:82c3:: with SMTP id u3-v6mr24862446plz.83.1530654503432;
        Tue, 03 Jul 2018 14:48:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id b65-v6sm3742103pfg.34.2018.07.03.14.48.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 14:48:22 -0700 (PDT)
Date:   Tue, 3 Jul 2018 14:48:22 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        edubezval@gmail.com, smohanad@codeaurora.org,
        vivek.gautam@codeaurora.org, andy.gross@linaro.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v4 6/6] arm64: dts: sdm845: Add tsens nodes
Message-ID: <20180703214822.GD129942@google.com>
References: <cover.1530533998.git.amit.kucheria@linaro.org>
 <a52b77ad84867774a0659f51ccb79b17ba7638ab.1530533998.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a52b77ad84867774a0659f51ccb79b17ba7638ab.1530533998.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 02, 2018 at 06:14:09PM +0530, Amit Kucheria wrote:
> SDM845 has two tsens blocks, one with 13 sensors and the other with 8
> sensors.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index cdaabeb..edf8505 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -221,6 +221,22 @@
>  			#interrupt-cells = <2>;
>  		};
>  
> +		tsens0: tsens@c222000 {
> +			compatible = "qcom,tsens-v2.4.0", "qcom,tsens-v2";
> +			reg = <0xc263000 0x1ff>, /* TM */
> +			      <0xc222000 0x1ff>; /* SROT */
> +			#qcom,sensors = <13>;
> +			#thermal-sensor-cells = <1>;
> +		};
> +
> +		tsens1: tsens@c223000 {
> +			compatible = "qcom,tsens-v2.4.0", "qcom,tsens-v2";
> +			reg = <0xc265000 0x1ff>, /* TM */
> +			      <0xc223000 0x1ff>; /* SROT */
> +			#qcom,sensors = <8>;
> +			#thermal-sensor-cells = <1>;
> +		};
> +
>  		spmi_bus: spmi@c440000 {
>  			compatible = "qcom,spmi-pmic-arb";
>  			reg = <0xc440000 0x1100>,

I tested this series on an SDM845 board. Temperatures can be read from
the tsens0 sensors, however for tsens1 sensors I get:

cat temp
cat: temp: No data available

TRDY_READY_BIT set when reading TRDY_OFFSET in get_temp_tsens_v2().
Unfortunately I currently have no documentation of the registers or the
thermal sensors in general and couldn't investigate further.

Any idea what could be the problem?

Thanks

Matthias

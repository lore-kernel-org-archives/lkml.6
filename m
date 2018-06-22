Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C7AC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E879C2462A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gFPAuJHJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E879C2462A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754527AbeFVQ6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:58:16 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:42893 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933472AbeFVQ6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:58:09 -0400
Received: by mail-pf0-f193.google.com with SMTP id w7-v6so3491605pfn.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 09:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XvWoy2FdkiNW7IlMLNScW1Xka3FyeAiV8p0d0T4xplo=;
        b=gFPAuJHJlHBf6ArcPAj6FGjGOQVoRx6O/fn15F2a4bcpaWgPVpVLZ8x4AMHCislxFn
         rAD3+KD3qnEI6xt0ncjOwe39x2jOU33QRNgpkqN8AyLy8MY8B1+P41uPodRPA9puO93/
         4E1x2TQTwWAQ4LuWd2pJJAi3YFY8yeJ7KNYuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XvWoy2FdkiNW7IlMLNScW1Xka3FyeAiV8p0d0T4xplo=;
        b=Krub6DXIseqx5NU8kWEem0lsKMi9GSVj7lyn8gRU9/fESnOTCPBPtmWRWQogA0S3kc
         1dWtYe04pLX3X+NaTqIpMA7B1YA+OR5/vb/C5BzNVp/CNmjbV/xCuA9YxI8WYxrkvkvT
         RQ9FXlbXlAzY5ivdrbwSY8efQqwB9m6rbgH9Ptgq2Lod8sJ2Esj6LisXLS7/PqoxLae8
         QphrS59zvysxAOO+SQm0bLDItJjnXMhi6im5BSaQ960whZEBjzKilazDfPecyuOWFvZY
         2Brjm/jTC3ihAwqT0mQ09zJTDQofiw/SO84hmGIlGSiRb8voe2Q9AGp7l57ivcCNcNp+
         CLzA==
X-Gm-Message-State: APt69E0eXuWQfmai66IGu4alcbYLI2qeJwU3mEdUxsHaQ7h0Y/aq9709
        nVZO4AJZmLQZ2ixPME/dJxFauQ==
X-Google-Smtp-Source: ADUXVKJAG0oJKLjoXIMxhMWBNIut/y0PntfamFZwtYb59Z+eh7AV6r3IeF2VT1+J/ppDBWux05+ubw==
X-Received: by 2002:a62:9652:: with SMTP id c79-v6mr2621855pfe.114.1529686688670;
        Fri, 22 Jun 2018 09:58:08 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y72-v6sm20235789pff.128.2018.06.22.09.58.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 09:58:08 -0700 (PDT)
Date:   Fri, 22 Jun 2018 09:58:06 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: Add pm8005 and pm8998 support
Message-ID: <20180622165806.GC10336@builder>
References: <20180613152054.54812-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613152054.54812-1-swboyd@chromium.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 13 Jun 08:20 PDT 2018, Stephen Boyd wrote:

> Add basic support for the pm8005 and pm8998 PMICs. For now just support
> the GPIO controllers.
> 
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/pm8005.dtsi | 33 +++++++++++++++++
>  arch/arm64/boot/dts/qcom/pm8998.dtsi | 55 ++++++++++++++++++++++++++++
>  2 files changed, 88 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/pm8005.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/pm8998.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/pm8005.dtsi b/arch/arm64/boot/dts/qcom/pm8005.dtsi
> new file mode 100644
> index 000000000000..4d5aca3eeb69
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/pm8005.dtsi
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/* Copyright 2018 Google LLC. */
> +
> +#include <dt-bindings/spmi/spmi.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +&spmi_bus {
> +	pm8005_lsid0: pmic@4 {
> +		compatible = "qcom,pm8005", "qcom,spmi-pmic";
> +		reg = <0x4 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pm8005_gpio: gpios@c000 {
> +			compatible = "qcom,pm8005-gpio", "qcom,spmi-gpio";
> +			reg = <0xc000>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupts = <0 0xc0 0 IRQ_TYPE_NONE>,
> +				     <0 0xc1 0 IRQ_TYPE_NONE>,
> +				     <0 0xc2 0 IRQ_TYPE_NONE>,
> +				     <0 0xc3 0 IRQ_TYPE_NONE>;
> +		};
> +
> +	};
> +
> +	pm8005_lsid1: pmic@5 {
> +		compatible = "qcom,pm8005", "qcom,spmi-pmic";
> +		reg = <0x5 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> new file mode 100644
> index 000000000000..92bed1e7d4bb
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/* Copyright 2018 Google LLC. */
> +
> +#include <dt-bindings/spmi/spmi.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +&spmi_bus {
> +	pm8998_lsid0: pmic@0 {
> +		compatible = "qcom,pm8998", "qcom,spmi-pmic";
> +		reg = <0x0 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pm8998_gpio: gpios@c000 {
> +			compatible = "qcom,pm8998-gpio", "qcom,spmi-gpio";
> +			reg = <0xc000>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupts = <0 0xc0 0 IRQ_TYPE_NONE>,
> +				     <0 0xc1 0 IRQ_TYPE_NONE>,
> +				     <0 0xc2 0 IRQ_TYPE_NONE>,
> +				     <0 0xc3 0 IRQ_TYPE_NONE>,
> +				     <0 0xc4 0 IRQ_TYPE_NONE>,
> +				     <0 0xc5 0 IRQ_TYPE_NONE>,
> +				     <0 0xc6 0 IRQ_TYPE_NONE>,
> +				     <0 0xc7 0 IRQ_TYPE_NONE>,
> +				     <0 0xc8 0 IRQ_TYPE_NONE>,
> +				     <0 0xc9 0 IRQ_TYPE_NONE>,
> +				     <0 0xca 0 IRQ_TYPE_NONE>,
> +				     <0 0xcb 0 IRQ_TYPE_NONE>,
> +				     <0 0xcc 0 IRQ_TYPE_NONE>,
> +				     <0 0xcd 0 IRQ_TYPE_NONE>,
> +				     <0 0xce 0 IRQ_TYPE_NONE>,
> +				     <0 0xcf 0 IRQ_TYPE_NONE>,
> +				     <0 0xd0 0 IRQ_TYPE_NONE>,
> +				     <0 0xd1 0 IRQ_TYPE_NONE>,
> +				     <0 0xd2 0 IRQ_TYPE_NONE>,
> +				     <0 0xd3 0 IRQ_TYPE_NONE>,
> +				     <0 0xd4 0 IRQ_TYPE_NONE>,
> +				     <0 0xd5 0 IRQ_TYPE_NONE>,
> +				     <0 0xd6 0 IRQ_TYPE_NONE>,
> +				     <0 0xd7 0 IRQ_TYPE_NONE>,
> +				     <0 0xd8 0 IRQ_TYPE_NONE>,
> +				     <0 0xd9 0 IRQ_TYPE_NONE>;
> +		};
> +
> +	};
> +
> +	pm8998_lsid1: pmic@1 {
> +		compatible = "qcom,pm8998", "qcom,spmi-pmic";
> +		reg = <0x1 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> +};
> -- 
> Sent by a computer through tubes
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

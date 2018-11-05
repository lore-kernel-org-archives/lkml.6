Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2068C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD5D2085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="R1FCmRhi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADD5D2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387959AbeKFE3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:29:10 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35642 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387932AbeKFE3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 23:29:10 -0500
Received: by mail-pg1-f195.google.com with SMTP id 32-v6so4654784pgu.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 11:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uxQ6TtxJN3C2wnhqS+RR3firXUmrm9Pg36r5o/Hfuxw=;
        b=R1FCmRhiUOK5ciu1PFJqTIoJHWCh2yNVcB+I2Q3aTX9Rf1Ib31K3q6zqttSUOt6QHr
         C1zxJ3sHqRIXip7kewTz6MO9aEzlerwIlu+mWRMScBe+PWN868vcDqqNqYBodC8WG15j
         VJ9290PawYLPlH/eOtkaJZs8Kbwn6VOAntDaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uxQ6TtxJN3C2wnhqS+RR3firXUmrm9Pg36r5o/Hfuxw=;
        b=RT12QSeHssANMwihdJpRtS8ZNBIJvvWdFZ57LJaA4/Xh9odBDmZ8Z8wchmGFkG/VEf
         W7d1NHJknD7Vx22Mu7ruOoWG8Wv/Pzy6lTCqeMBaMLee5gKFU6/z3AdSwJBeZP+FlXB2
         38cYAkFkQ7iiBZRGV8LevWBYHR1oXLQKpKNqRs09jBjeHniH5j9BiXm/trI/u1sQ17Tf
         92N0KzrLaW5ybHuEvnan3ftqkOAMIsY/0+oTHZ32rxnIQ53Bu1/2iOjerblmo/2f157W
         4CXn9nC12Wjrc9nv1NePUzQ2ubuLXAi5pKvZHS78QxBjgGR6EzSlCVs3zkFZagvuhqUL
         l2nw==
X-Gm-Message-State: AGRZ1gIy4R7CfhzlIoHqTPsBX5hjZ0V/SswIHSVtEkeIbFylUU6gxQCj
        9nM8RQH90kWT+TrN9bMHan2xoQ==
X-Google-Smtp-Source: AJdET5cdwCDKoHQWKfdNTYhLiZD6C/V8WAS/DvYtke1lP1N23/y+jLL8vsS24iFC/OEx2mX5R4NM0A==
X-Received: by 2002:a63:e101:: with SMTP id z1mr17707330pgh.310.1541444885505;
        Mon, 05 Nov 2018 11:08:05 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h62-v6sm41237376pfg.27.2018.11.05.11.08.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 11:08:04 -0800 (PST)
Date:   Mon, 5 Nov 2018 11:08:02 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/17] arm64: dts: qcom: pms405: add gpios
Message-ID: <20181105190802.GQ2523@minitux>
References: <20181105154529.7614-1-vkoul@kernel.org>
 <20181105154529.7614-12-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105154529.7614-12-vkoul@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05 Nov 07:45 PST 2018, Vinod Koul wrote:

> Add the GPIOs present on PMS405 chip.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/pms405.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pms405.dtsi b/arch/arm64/boot/dts/qcom/pms405.dtsi
> index cdb4547c998b..18410d9f0f8f 100644
> --- a/arch/arm64/boot/dts/qcom/pms405.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pms405.dtsi
> @@ -17,5 +17,21 @@
>  			reg-names = "rtc", "alarm";
>  			interrupts = <0x0 0x61 0x1 IRQ_TYPE_NONE>;
>  		};
> +
> +		pms405_gpios: gpios@c000 {
> +			compatible = "qcom,pms405-gpio";
> +			reg = <0xc000>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupts = <0 0xc1 0 IRQ_TYPE_NONE>,
> +				<0 0xc2 0 IRQ_TYPE_NONE>,
> +				<0 0xc3 0 IRQ_TYPE_NONE>,
> +				<0 0xc4 0 IRQ_TYPE_NONE>,
> +				<0 0xc5 0 IRQ_TYPE_NONE>,
> +				<0 0xc6 0 IRQ_TYPE_NONE>,
> +				<0 0xc7 0 IRQ_TYPE_NONE>,
> +				<0 0xca 0 IRQ_TYPE_NONE>,
> +				<0 0xcb 0 IRQ_TYPE_NONE>;

Is there a reason why gpio 1, 8 and 9 are omitted from this list?

Regards,
Bjorn

> +		};
>  	};
>  };
> -- 
> 2.14.4
> 

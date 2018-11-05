Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81101C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DBF120685
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CvOB8YCi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DBF120685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387861AbeKFERy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:17:54 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39276 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729821AbeKFERy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 23:17:54 -0500
Received: by mail-pl1-f194.google.com with SMTP id b5-v6so4892544pla.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 10:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IuP+G/wQhv69woVdVBCgwwl2K93FbMQdaNLzrexQrH4=;
        b=CvOB8YCiIg0cdyG2N9SxuStw5rhof4gbukSb129P6zDTr1T9HwpWa7V2aGTWMEYDVL
         PzgJ0btEJs/fVAYhk6Sd9DImrXKqXnsXyYLF8sXS1N5OCmAzahpG75X5SC1FZWp5llkA
         WsVvjVOkp4z3/hlcFmGoqwtDGxrH85lusdSS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IuP+G/wQhv69woVdVBCgwwl2K93FbMQdaNLzrexQrH4=;
        b=GHAZpL7lTsIdFeeFRj49OoIo2G+1adWw8vABVI+J73hc96vuygZ4W+tTHAp0ylnOBj
         M5H/QwVns4bjl7pJcma3HsH+vVDGQ4e5Blqdq97zuDW9wmGcnC53BOh6nWwXNeHkYYxt
         KfiqP/wSob/sRs9P5vUX0rKaEoLJcxZiqHwWtiOCHjIWwlmRaglxbXs9sx2KvEpzPUAU
         6GIUGoSk5ka4u4wwmPtCiWFv2UuPKxwRUbB7/qxrNlgsYlCYh95cDVqKoH8bxnxObDjd
         OHB1BPlTWhH3MfIepi2Tae4Bh9E6folost/tLmfJr7ZI44FE6qzsw22L8+f9pM+Q2/0C
         SIRg==
X-Gm-Message-State: AGRZ1gLkqu/ugM7hHUlNa+axGd9k10XhF6OtmN06nSH2mrb198DvI2Gt
        VLeR5cg7Xpf15kNSQsbL1o73JMiX7/I=
X-Google-Smtp-Source: AJdET5d4bby8PYtRenExcclIB1OsGjPkPICG8tgJa9N0z0O429Wn+D1y+FKQ2OJoqefEqKB6HY47HA==
X-Received: by 2002:a17:902:8bca:: with SMTP id r10-v6mr3334357plo.199.1541444211751;
        Mon, 05 Nov 2018 10:56:51 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 80-v6sm13330942pfv.154.2018.11.05.10.56.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 10:56:51 -0800 (PST)
Date:   Mon, 5 Nov 2018 10:56:48 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/17] arm64: dts: qcom: qcs404: add base dts files
Message-ID: <20181105185648.GL2523@minitux>
References: <20181105154529.7614-1-vkoul@kernel.org>
 <20181105154529.7614-2-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105154529.7614-2-vkoul@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05 Nov 07:45 PST 2018, Vinod Koul wrote:

> diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dts b/arch/arm64/boot/dts/qcom/qcs404-evb.dts
> new file mode 100644
> index 000000000000..74dc09ddb0d2
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dts
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2018, Linaro Limited
> +
> +// QCS EVB DTS

This can be read from the filename and the model a few lines down. So
please drop.

> +
> +/dts-v1/;
> +
> +#include "qcs404.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. QCS404 EVB 1000";
> +	compatible = "qcom,qcs404-evb";
> +
> +	aliases {
> +		serial0 = &blsp1_uart2;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0";
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
[..]
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 2 0xff08>,
> +			     <GIC_PPI 3 0xff08>,
> +			     <GIC_PPI 4 0xff08>,
> +			     <GIC_PPI 1 0xff08>;
> +	};
> +
> +	clocks {

Please sort these nodes alphabetically.

> +		xo_board: xo_board {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <19200000>;
> +		};
> +	};
> +
> +	soc: soc@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0 0 0xffffffff>;
> +		compatible = "simple-bus";
> +

Please pad the address in reg to 8 digits and sort these nodes by
address.

> +		intc: interrupt-controller@b000000 {
> +			compatible = "qcom,msm-qgic2";
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +			reg = <0x0b000000 0x1000>,
> +			      <0x0b002000 0x1000>;
> +		};
> +

Regards,
Bjorn

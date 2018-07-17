Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2517AECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5AB421475
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FEAft6nE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5AB421475
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731769AbeGQOr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 10:47:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37061 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731691AbeGQOr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 10:47:28 -0400
Received: by mail-pg1-f194.google.com with SMTP id n7-v6so505626pgq.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 07:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GHEpIVcvpNWb+XRQNq9F7cibEI4qpG0+r8Jzf3ypt0s=;
        b=FEAft6nEC9KV1t/0KBSAlCHCysLC58/tOqokAfU+w7LahPksKGIOFuW4gOBDpRvvrS
         2dZFYYpRtcan+J7GOmwqVPHqLzb4Ue5fQShtiwEelR9W7hYeBKKja9iLG+Sbzy+n2w6Z
         PttzF1Uu0w/x56f9nGvEZ4S0Z5gxDSxrnkuGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GHEpIVcvpNWb+XRQNq9F7cibEI4qpG0+r8Jzf3ypt0s=;
        b=qJ1pzLJpb1M9XUeogOuGPfD+3Y9P7lS2h61mfPL/upWqwSs+Wwk/yQkWeKeaAEF7Mm
         6sG1FAUxYreFlvj7Dr27ips1pOUCakHHVqKLjq+7oXB8/zYZy5laFpm/I9w6ZIVqaMUB
         30ernKlzeIsanSZ0fZZxGrKZ760k4IYC8w8xfaANlrReUHAjRVL3D7f+vYuzX06QThCo
         tL38kIyHqR/mU6L9//P+OLIf+bnRP4Gx+7HGz2fKMMhhEsH8IvYSibmQlmIWsppoZSx3
         V5QIvj+5//5A2qWRH24xdYzLXQcvkEqJDpN29adsE53YsUDB6+u1Szw8+7Fw9oQ5SxOa
         PPSw==
X-Gm-Message-State: AOUpUlFCdslXRdBP79YU7nAmnw+n0UJ2lrjz9C7/aOeTx7c/xgPaef5a
        36PP+ziySnfmf0SWve4bP//A
X-Google-Smtp-Source: AAOMgpd7hnnJV2VdB7zf5tSLN/72PmcU/ArvF7QADd0YiD9Nueq3PYUXv4nUut6jZlOYBv5SYwHlKw==
X-Received: by 2002:a63:5a13:: with SMTP id o19-v6mr1733446pgb.195.1531836877034;
        Tue, 17 Jul 2018 07:14:37 -0700 (PDT)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id p5-v6sm1945634pfn.57.2018.07.17.07.14.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 07:14:36 -0700 (PDT)
Date:   Tue, 17 Jul 2018 19:44:29 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     afaerber@suse.de, sboyd@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux@cubietech.com,
        support@cubietech.com, catalin.marinas@arm.com,
        mturquette@baylibre.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, thomas.liau@actions-semi.com,
        darren@cubietech.com, robh+dt@kernel.org,
        jeff.chen@actions-semi.com, pn@denx.de, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mp-cs@actions-semi.com
Subject: Re: [PATCH v6 4/5] arm64: dts: actions: Add Clock Management Unit
 for S700
Message-ID: <20180717141429.GC19076@mani>
References: <20180715203524.11948-1-sravanhome@gmail.com>
 <20180715203524.11948-5-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180715203524.11948-5-sravanhome@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravanan,

On Sun, Jul 15, 2018 at 10:35:23PM +0200, Saravanan Sekar wrote:
> Add Clock Management Unit for Actions Semi S700 SoC.
> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  arch/arm64/boot/dts/actions/s700.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
> index 66dd5309f0a2..4497741d48b2 100644
> --- a/arch/arm64/boot/dts/actions/s700.dtsi
> +++ b/arch/arm64/boot/dts/actions/s700.dtsi
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/actions,s700-cmu.h>
>  
>  / {
>  	compatible = "actions,s700";
> @@ -44,6 +45,13 @@
>  		};
>  	};
>  
> +	cmu: clock-controller@e0168000 {
> +		compatible = "actions,s700-cmu";
> +		reg = <0x0 0xe0168000 0x0 0x1000>;
> +		clocks = <&hosc>, <&losc>;
> +		#clock-cells = <1>;
> +	};
> +

CMU node should come under soc, ordered based on the address.

Thanks,
Mani

>  	reserved-memory {
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> @@ -87,6 +95,12 @@
>  		#clock-cells = <0>;
>  	};
>  
> +	losc: losc {
> +		compatible = "fixed-clock";
> +		clock-frequency = <32768>;
> +		#clock-cells = <0>;
> +	};
> +
>  	soc {
>  		compatible = "simple-bus";
>  		#address-cells = <2>;
> -- 
> 2.18.0
> 

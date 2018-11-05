Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1D0C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D517E20700
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VL/c0jbn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D517E20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387991AbeKFEdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:33:10 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44927 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387462AbeKFEdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 23:33:10 -0500
Received: by mail-pg1-f195.google.com with SMTP id w3-v6so4636964pgs.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 11:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hR6SLvJTlBPFT/iLgDfXmJaIS50oy6dvEbObviNjpDI=;
        b=VL/c0jbn2SZFMfY+cRHZhH6q0uwru21JM3vTaCeigmKMUHwGczkTth8JzQTYnq2+AG
         QMQBfOQ3fRmBZTxa8BdCxZgTOnkRvmTEuhpGqM5SdIWSY1Z03FJpn4jJHEtAcSTg9bFG
         At+ZZEPyUoj2g0kR77bDgWl1AAs7eYj3SZhwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hR6SLvJTlBPFT/iLgDfXmJaIS50oy6dvEbObviNjpDI=;
        b=ghivIE1LHILsYf49Yahj3rElkIfrjHya5hqMT2bo6p2rkHKOv6t+cd3O/sAqniptLs
         deIlC2h7Kd7ifu2d7Xf62veScnk7VQbOEyGHOYIJ07jYzrdYPTXXSKOuz0hjUKQNS6Z+
         SEPCufHzGLqdgrMEhibSU98EJee5zoNQkDGczWbwo1ynYAYDj3tImCMSDdlYjG1iwegp
         2mDa7KkT/iCaaWI9rV0ElFfKDIJPHt907rc6qccsz7fdZ8hgp0R/iLEZqmCvwvibl8bO
         BpBMD2gWFqzBoiVzHix+zmKGDlcScczmETQa3WlIToII9jKiyK4NWR4sZem7iIjUDxzO
         X5hA==
X-Gm-Message-State: AGRZ1gKGhsETcU0oI5yBsId2NycKjY73bOuBiFCnE0FroIzS4nLAiCgk
        /djAjh0hjcaj43yyi9MiIdb02g==
X-Google-Smtp-Source: AJdET5ejKMFYY+hTD1P5jbRAK3IeTBTUS1gkJg1HUIhnGh+me6nOTiHRQjJV9VoRS0Zdp/pzNZcLEA==
X-Received: by 2002:a63:9b11:: with SMTP id r17mr21328528pgd.416.1541445124059;
        Mon, 05 Nov 2018 11:12:04 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id t64-v6sm36282962pfd.127.2018.11.05.11.12.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 11:12:03 -0800 (PST)
Date:   Mon, 5 Nov 2018 11:12:01 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 15/17] arm64: dts: qcom: qcs404: Add BAM DMA node
Message-ID: <20181105191201.GT2523@minitux>
References: <20181105154529.7614-1-vkoul@kernel.org>
 <20181105154529.7614-16-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105154529.7614-16-vkoul@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05 Nov 07:45 PST 2018, Vinod Koul wrote:

> Add the BAM DMA instance found in BLSP1 node of the QCS404

What about blsp2 bam?

> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/qcs404.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> index a37930639b8d..88e04a0ee67f 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> @@ -276,6 +276,19 @@
>  			status = "okay";
>  		};
>  
> +		blsp1_dma: dma@7884000 {
> +			compatible = "qcom,bam-v1.7.0";
> +			reg = <0x07884000 0x25000>;
> +			interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP1_AHB_CLK>;
> +			clock-names = "bam_clk";
> +			#dma-cells = <1>;
> +			qcom,controlled-remotely = <1>;
> +			qcom,ee = <0>;
> +
> +			status = "okay";
> +		};
> +
>  		apcs_glb: mailbox@b011000 {
>  			compatible = "qcom,qcs404-apcs-apps-global", "syscon";
>  			reg = <0xb011000 0x1000>;
> -- 
> 2.14.4
> 

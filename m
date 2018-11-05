Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BE8C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2225620825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="d1SqOAmf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2225620825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387966AbeKFEbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:31:45 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45482 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387932AbeKFEbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 23:31:45 -0500
Received: by mail-pg1-f195.google.com with SMTP id y4so4203539pgc.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 11:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OFhNl+U7UbbOluGWGD/oKU+j05e6n3F+9bLruXTtoa4=;
        b=d1SqOAmfY9ZPUdg88XOZxDqojY+Y3PrLErO2hW6BnVIFbxkexSOQ5rPKkykyuUY1dk
         c2TmvORCe2y9TKtswTv86m2DEZM3/0TtvF+GseJYwjtbuPw3AvODmVkf3n4Nqgf/Dzb4
         we5fQtuDnbfs4hIsHiLff2rc3sSUhNbwX4TGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OFhNl+U7UbbOluGWGD/oKU+j05e6n3F+9bLruXTtoa4=;
        b=sJ0IVO8jQNg15itMmjLzJKEzjWml2LOkS64Na47oLJZhXUKVueeyxGGL0qDl0lqbqY
         Q5slqYFr2chiwvT7GA/TqzcB6SAU7vDeca0kWOsWrrlSyvbkRCyRx4/UPgxbDTvw6i6t
         RFCf3HKCv8u7qe5oVTkq+8D8x9BY3NMebqbgU26pzKBf4n5vAQE++NVGqEq753jSk2tc
         8C0rOCFmS/Hd0jczeguurETB/eI3gsgbb3PouOjMmp8DvRz4iqvGzN+I7SmDZve/gWir
         9qK/tlIfSLktkFUvFL8IBG/4AZ90jP1J0Fefw1flbhS5NOkW3x1N4mf4+c6PaKN1ErPF
         ikUQ==
X-Gm-Message-State: AGRZ1gJjNKJpZKySmXEaOZ5zqRA2IEm5QeDcMXgp+JhRAG4a+iIsq3wi
        xaaowXiT467sVp2wPWbOMP/7nQ==
X-Google-Smtp-Source: AJdET5caW27VSjRTtN4mcrwrtKbknIFDrAW7ILqJu57cju7VkQ5ANGI+HYWbeonpXZCMnv6vKX6dAg==
X-Received: by 2002:a62:5bc4:: with SMTP id p187-v6mr23184500pfb.94.1541445038892;
        Mon, 05 Nov 2018 11:10:38 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id k129sm9724014pgk.29.2018.11.05.11.10.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 11:10:38 -0800 (PST)
Date:   Mon, 5 Nov 2018 11:10:35 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/17] arm64: dts: qcom: qcs404: Add remoteproc nodes
Message-ID: <20181105191035.GR2523@minitux>
References: <20181105154529.7614-1-vkoul@kernel.org>
 <20181105154529.7614-14-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105154529.7614-14-vkoul@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05 Nov 07:45 PST 2018, Vinod Koul wrote:

> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Add the TrustZone based remoteproc nodes and their glink edges for
> adsp, cdsp and wcss.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/qcs404.dtsi | 87 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 87 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> index 8e207a25ddf0..b560ab6e49ff 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> @@ -373,4 +373,91 @@
>  			#interrupt-cells = <2>;
>  		};
>  	};
> +
> +	remoteproc-adsp {
> +		compatible = "qcom,qcs404-adsp-pas";
> +
> +		interrupts-extended = <&intc GIC_SPI 293 IRQ_TYPE_EDGE_RISING>,
> +				      <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> +				      <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> +				      <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> +				      <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
> +		interrupt-names = "wdog", "fatal", "ready",
> +				  "handover", "stop-ack";
> +
> +		clocks = <&xo_board>;
> +		clock-names = "xo";
> +

As the TZ-backed remoteproc drivers will not be used on all variation of
products on this platform please add status = "disabled"; to these nodes
and enable them in the evb.

Regards,
Bjorn

> +		memory-region = <&adsp_fw_mem>;
> +
> +		qcom,smem-states = <&adsp_smp2p_out 0>;
> +		qcom,smem-state-names = "stop";
> +
> +		glink-edge {
> +			interrupts = <GIC_SPI 289 IRQ_TYPE_EDGE_RISING>;
> +
> +			qcom,remote-pid = <2>;
> +			mboxes = <&apcs_glb 8>;
> +
> +			label = "adsp";
> +		};
> +	};
> +
> +	remoteproc-cdsp {
> +		compatible = "qcom,qcs404-cdsp-pas";
> +
> +		interrupts-extended = <&intc GIC_SPI 229 IRQ_TYPE_EDGE_RISING>,
> +				      <&cdsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> +				      <&cdsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> +				      <&cdsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> +				      <&cdsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
> +		interrupt-names = "wdog", "fatal", "ready",
> +				  "handover", "stop-ack";
> +
> +		clocks = <&xo_board>;
> +		clock-names = "xo";
> +
> +		memory-region = <&cdsp_fw_mem>;
> +
> +		qcom,smem-states = <&cdsp_smp2p_out 0>;
> +		qcom,smem-state-names = "stop";
> +
> +		glink-edge {
> +			interrupts = <GIC_SPI 141 IRQ_TYPE_EDGE_RISING>;
> +
> +			qcom,remote-pid = <5>;
> +			mboxes = <&apcs_glb 12>;
> +
> +			label = "cdsp";
> +		};
> +	};
> +
> +	remoteproc-wcss {
> +		compatible = "qcom,qcs404-wcss-pas";
> +
> +		interrupts-extended = <&intc GIC_SPI 153 IRQ_TYPE_EDGE_RISING>,
> +				      <&wcss_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> +				      <&wcss_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> +				      <&wcss_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> +				      <&wcss_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
> +		interrupt-names = "wdog", "fatal", "ready",
> +				  "handover", "stop-ack";
> +
> +		clocks = <&xo_board>;
> +		clock-names = "xo";
> +
> +		memory-region = <&wlan_fw_mem>;
> +
> +		qcom,smem-states = <&wcss_smp2p_out 0>;
> +		qcom,smem-state-names = "stop";
> +
> +		glink-edge {
> +			interrupts = <GIC_SPI 156 IRQ_TYPE_EDGE_RISING>;
> +
> +			qcom,remote-pid = <1>;
> +			mboxes = <&apcs_glb 16>;
> +
> +			label = "wcss";
> +		};
> +	};
>  };
> -- 
> 2.14.4
> 

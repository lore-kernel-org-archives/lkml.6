Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234E0C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E392520825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qu2ckHek"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E392520825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387859AbeKFEW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:22:57 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44343 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbeKFEW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 23:22:57 -0500
Received: by mail-pf1-f194.google.com with SMTP id j13-v6so4857685pff.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 11:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ujEAnUIkZLDKmVDTfmOBkdzK1vRjUZhEORA8b/X7Lp8=;
        b=Qu2ckHekXenv3pcNJVLAqzthHc5/0skhHAMcqqEVbz2uLOqzHvPpngenqERGnnUm1Y
         6PO5FPlXYPKimzVn8y7SBftErmwSaUFMzrwQU8/YhsnjPuLBuCJiK1FQMFWGMMigpHTF
         zHhV9zaVkEwTKId2gN0BJDVK1trQVG61X7CWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ujEAnUIkZLDKmVDTfmOBkdzK1vRjUZhEORA8b/X7Lp8=;
        b=bRv2+qtbL8DxWJs1QDLV+azhQxjByOKtOPe6+dWBvI2mqTofTW7EaDa7zc9ME0O/+o
         a3ad83l0FF7ktp5ZNFzI2uAV4JzOcBDKPZ2pqUIwR/RSxYewzUqiIIAGKKkrlVe1CGa2
         ti5TMHBRxi1sg+RVISdI+Bol8aNYCy1XhL9AlAHlwUIZbjHGYm/3eSUd9BAfDXZKnICJ
         ePoB9scP9nr1CRTO+5zFuFrbTWviei5IDXE8Fyn7OshKAnEAAUrsSRhCRT331OALn0vy
         2clILhqrk9Iks5xSLt+PQc5gO4hi+yBiTH5Ju280kDyxG8MswwIKG4alqDcW7ibf18xz
         U85Q==
X-Gm-Message-State: AGRZ1gItikke/lKzdUWOrqdki7FAT5u16pWkO0B0S7c4hjx1HLb9YnXJ
        uUtvx3K1DAoDPIQJ1gM21eUYPg==
X-Google-Smtp-Source: AJdET5eibC7GnFCbTydMp6WVnvhY/doSYLX9DmxeKtrUpYwV1IM1S6GlBodOkWgaivP5VDcohW6WjA==
X-Received: by 2002:a62:8012:: with SMTP id j18-v6mr23044699pfd.202.1541444513278;
        Mon, 05 Nov 2018 11:01:53 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id w125-v6sm12899039pfd.145.2018.11.05.11.01.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 11:01:52 -0800 (PST)
Date:   Mon, 5 Nov 2018 11:01:49 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/17] arm64: dts: qcom: qcs404: add smp2p nodes
Message-ID: <20181105190149.GM2523@minitux>
References: <20181105154529.7614-1-vkoul@kernel.org>
 <20181105154529.7614-6-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105154529.7614-6-vkoul@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05 Nov 07:45 PST 2018, Vinod Koul wrote:

> Add the smp2p-adsp, smp2p-cdsp and smp2p-wcss nodes found in QCS404.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/qcs404.dtsi | 60 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> index c749c61225b4..c87b0440584a 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> @@ -257,4 +257,64 @@
>  			#mbox-cells = <1>;
>  		};
>  	};
> +
> +	smp2p-adsp {
> +		compatible = "qcom,smp2p";
> +		qcom,smem = <443>, <429>;
> +		interrupts = <GIC_SPI 291 IRQ_TYPE_EDGE_RISING>;
> +		mboxes = <&apcs_glb 10>;
> +		qcom,local-pid = <0>;
> +		qcom,remote-pid = <2>;
> +
> +		adsp_smp2p_out: master-kernel {
> +			qcom,entry-name = "master-kernel";
> +			#qcom,smem-state-cells = <1>;
> +		};
> +
> +		adsp_smp2p_in: slave-kernel {
> +			qcom,entry-name = "slave-kernel";
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +
> +	smp2p-cdsp {
> +		compatible = "qcom,smp2p";
> +		qcom,smem = <94>, <432>;
> +		interrupts = <GIC_SPI 143 IRQ_TYPE_EDGE_RISING>;
> +		mboxes = <&apcs_glb 14>;
> +		qcom,local-pid = <0>;
> +		qcom,remote-pid = <5>;
> +
> +		cdsp_smp2p_out: master-kernel {
> +			qcom,entry-name = "master-kernel";
> +			#qcom,smem-state-cells = <1>;
> +		};
> +
> +		cdsp_smp2p_in: slave-kernel {
> +			qcom,entry-name = "slave-kernel";
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +
> +	smp2p-wcss {
> +		compatible = "qcom,smp2p";
> +		qcom,smem = <435>, <428>;
> +		interrupts = <GIC_SPI 158 IRQ_TYPE_EDGE_RISING>;
> +		mboxes = <&apcs_glb 18>;
> +		qcom,local-pid = <0>;
> +		qcom,remote-pid = <1>;
> +
> +		wcss_smp2p_out: master-kernel {
> +			qcom,entry-name = "master-kernel";
> +			#qcom,smem-state-cells = <1>;
> +		};
> +
> +		wcss_smp2p_in: slave-kernel {
> +			qcom,entry-name = "slave-kernel";
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
>  };
> -- 
> 2.14.4
> 

Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D2EC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC84620C0E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SXcIkM1N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC84620C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389747AbeGKQj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:39:56 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34416 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388018AbeGKQj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:39:56 -0400
Received: by mail-pl0-f67.google.com with SMTP id z9-v6so9386408plo.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 09:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sin8EWAzhOYsIykJ3xN4LzPke6ob3fmYaAjtx9DEaHA=;
        b=SXcIkM1Ne37VsPcD66UZkfJ3Cb1/NDt4NQNK20D+harHG/+jG/vMPl0Jht9V+VadrO
         GPMcb8q9PT35n4EHUu/kcYHfjbCPjWZibgAYkHJQSmWe/Z2WdUwLeNFvT+pZjLv2RzqJ
         75CXPpRAIgY5EuDXUrdaD6EI0PffXr4iZ4f8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sin8EWAzhOYsIykJ3xN4LzPke6ob3fmYaAjtx9DEaHA=;
        b=BqsDJm5uV5wenYIJaARPmO3rr2ET6qP3nHzy0xk847XQRrEMSX4LLhej3Rciy6jMd3
         d8hvQh+F0PZ0A3Wb9NyL8s7y619tShSpaoq9xZdO5mfCboajMfazOrr8G1R2mwc8CLvD
         b1PVuhfJlpNWRVmUlPZCQXNTYCI7Tun6U7cKb0HeItMUfCYMC/vqivKQgwFowGRLxnnP
         bOqBHWCLABDGR4vbmzXgzQ9mm/aoYbiIWZeEDkOyEYi3PbFtef/7MQn3OL+GdeJzVSI5
         MD6W4zxdk1pxrhvikJ5X+3X6RBcZdt9PnsQUGHSOSE6/uRwaXzMgffcQNtq7cICQ41sA
         QhDg==
X-Gm-Message-State: APt69E1n/d6asX1Z4Qc2cPkcyducRgLLggpbuKpOgptqFxuLXTM8qArl
        y9ljzxGD7duUJMl3GJ0Y440xcg==
X-Google-Smtp-Source: AAOMgpfVwaOpCVz+X3kXEocCS9ODKnxijrdn4uHBadUeH2KjasOX9t5No2lSMxrOi7TauZwZqkI5Pg==
X-Received: by 2002:a17:902:205:: with SMTP id 5-v6mr29092139plc.301.1531326888624;
        Wed, 11 Jul 2018 09:34:48 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h8-v6sm28053974pgq.35.2018.07.11.09.34.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 09:34:47 -0700 (PDT)
Date:   Wed, 11 Jul 2018 09:37:29 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, edubezval@gmail.com,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 3/7] dt: qcom: 8996: thermal: Move to DT initialisation
Message-ID: <20180711163729.GB545@tuxbook-pro>
References: <cover.1531135999.git.amit.kucheria@linaro.org>
 <ee06e59ae84a9b9013480c58bd4678e44d201a42.1531135999.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee06e59ae84a9b9013480c58bd4678e44d201a42.1531135999.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09 Jul 04:43 PDT 2018, Amit Kucheria wrote:

> We also split up the regmap address space into two, one for the TM
> registers, the other for the SROT registers. This was required to deal with
> different address offsets for the TM and SROT registers across different
> SoC families.
> 
> Since tsens-common.c/init_common() currently only registers one address
> space, the order is important (TM before SROT). This is OK since the code
> doesn't really use the SROT functionality yet.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 8c7f9ca..6c8a857 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -461,7 +461,17 @@
>  
>  		tsens0: thermal-sensor@4a8000 {
>  			compatible = "qcom,msm8996-tsens";
> -			reg = <0x4a8000 0x2000>;
> +			reg = <0x4a9000 0x1000>, /* TM */
> +			      <0x4a8000 0x1000>; /* SROT */
> +			#qcom,sensors = <13>;
> +			#thermal-sensor-cells = <1>;
> +		};
> +
> +		tsens1: thermal-sensor@4ac000 {
> +			compatible = "qcom,msm8996-tsens";
> +			reg = <0x4ad000 0x1000>, /* TM */
> +			      <0x4ac000 0x1000>; /* SROT */
> +			#qcom,sensors = <8>;
>  			#thermal-sensor-cells = <1>;
>  		};
>  
> -- 
> 2.7.4
> 

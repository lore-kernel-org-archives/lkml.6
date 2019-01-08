Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A34C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44A32089F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GQWnWkY1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbfAHHAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 02:00:34 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39992 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfAHHAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 02:00:33 -0500
Received: by mail-pg1-f193.google.com with SMTP id z10so1301469pgp.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 23:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yMr4+9hR+4j7tdQO3zoCoGTjkKbof4Z3u4AWZsENkQI=;
        b=GQWnWkY100usS8LQLOiPf718v3mQywWi40n6HAYA8QpdiaYBkuBy3UDqS7/GiTXFSy
         +AKJZ8fhhoi364He6h88W0JtTU7n4jLggycm7OUzAgN+FXGJmZeh6U/v7ut/M5Vodya5
         ELbCC/oZWBiMS6pjANd7RxlPBICwKsNOFkPWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yMr4+9hR+4j7tdQO3zoCoGTjkKbof4Z3u4AWZsENkQI=;
        b=aeXwlM/YZnF1PnubwzHj2OEwS/vbjvHRS7xo2SJLzDscbE1X//nHngPPEItxRiH/Dh
         ga3Xma7qNc6/GqpwQ2qIHvJDEkhBwx93znzRGJUQn8VsfrzC8v+GR7+anjJxmVgd12H+
         BRPda6KdH7rDfkZVpSIwfDm6W3wI9j5X+HlNC4RT1lJbt2b+jZXkQ4AZgZ71eWJyGwrf
         vnhuelV3zDukrVN8Vb7EIZ5xn6jdX736Tp3Po2OCTt+GOm/AemlVuqIMrhdgBmuxb73F
         YDTq47OEIj9PwfzaGOxwhdgr/CLn28mCPwaZU+BtDBR+j07x/GdWvGXv35cbbvzhKWpk
         tsWg==
X-Gm-Message-State: AJcUukcEfm+0o7hArrIS3I6V/jyzSIMRoMoiimCtcggm9IQgHF3Cw7Ze
        XAPb+4zjS89UYvJiPEh9w39oLQ==
X-Google-Smtp-Source: ALg8bN7zpm0PL4syTIZ7HEYx+XrBwaC1S6AhaiqHBtEFNTWw3gzm0iF1BkGAkPXm81cCRP44Y00MmA==
X-Received: by 2002:a65:4381:: with SMTP id m1mr507985pgp.358.1546930832342;
        Mon, 07 Jan 2019 23:00:32 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 125sm127586976pfx.159.2019.01.07.23.00.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 23:00:31 -0800 (PST)
Date:   Mon, 7 Jan 2019 22:59:35 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     joro@8bytes.org, robh+dt@kernel.org, andy.gross@linaro.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mark.rutland@arm.com,
        david.brown@linaro.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, will.deacon@arm.com, dianders@chromium.org
Subject: Re: [PATCH v4 2/2] dts: arm64/sdm845: Add node for arm,mmu-500
Message-ID: <20190108065935.GA11536@builder>
References: <20181011094930.17010-1-vivek.gautam@codeaurora.org>
 <20181011094930.17010-3-vivek.gautam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011094930.17010-3-vivek.gautam@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 11 Oct 02:49 PDT 2018, Vivek Gautam wrote:

> Add device node for arm,mmu-500 available on sdm845.
> This MMU-500 with single TCU and multiple TBU architecture
> is shared among all the peripherals except gpu.
> 

Hi Vivek,

Applying this patch together with UFS ([1] and [2]) ontop of v5.0-rc1
causes my MTP reboot once the UFSHCD module is inserted and probed.
Independently the patches seems to work fine.

Do you have any suggestion to why this would be?

[1] https://lore.kernel.org/lkml/20181210192826.241350-4-evgreen@chromium.org/
[2] https://lore.kernel.org/lkml/20181210192826.241350-5-evgreen@chromium.org/

Regards,
Bjorn

> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
> 
> Changes since v3:
>  - none.
> 
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 72 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index b72bdb0a31a5..0aace729643d 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -1297,6 +1297,78 @@
>  			cell-index = <0>;
>  		};
>  
> +		apps_smmu: iommu@15000000 {
> +			compatible = "qcom,sdm845-smmu-500", "arm,mmu-500";
> +			reg = <0x15000000 0x80000>;
> +			#iommu-cells = <2>;
> +			#global-interrupts = <1>;
> +			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
>  		apss_shared: mailbox@17990000 {
>  			compatible = "qcom,sdm845-apss-shared";
>  			reg = <0x17990000 0x1000>;
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 

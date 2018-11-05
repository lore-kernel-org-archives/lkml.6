Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93397C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E592086B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="By2nMyol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E592086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388022AbeKFEdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:33:38 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46263 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387948AbeKFEdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 23:33:38 -0500
Received: by mail-pf1-f193.google.com with SMTP id r64-v6so4868287pfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 11:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yUR50mVbEIidvjPOX4rU8yiwJ/RL5j4CCpaX9HPsNUE=;
        b=By2nMyolptxrn0gJwPT2UrgRm2EE2q0jUtzgkTiNL1aFE1xMxcNAs5bo40n2ZfqkOL
         R95kuwL775GbEjxO4k+G+4ccueuJzJl+rHXtCl6JP2NQOBULh36S3ngMlXzQ4LNcm5S5
         Mh1P7GpsWyJ/GU5E7WQ5v5di93XpcoxxjBAGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yUR50mVbEIidvjPOX4rU8yiwJ/RL5j4CCpaX9HPsNUE=;
        b=k+XM+S0TXCGtVKaw2z9dP9HQjP/MyisrFJvmZtSrZ5koZGBxcygabEAk5WWEfC0FbX
         CWu2xCBiLHZ0aZyH5oVk4f/j6nQgsPNkqc912UiT4qmU5fOtUjfuLJO9iVnHxKybUpAz
         0JxVqsxS1kfJgB/UblH7o/rft37JlTW5aOhCAIER7apgf0U3fmVpwDr4sRKDdeZJamaH
         DJN94V7VuQbwW18pr7MijSHqOajt08Q87CNGsAGhtCaCsFm6cjcuuP4Jm5LOB7x4JAnd
         0DvwIfFVGQYgn9elj04ayDL2R5uMIqUH437gQlqL1hP8WkTkeKVKNC25/qNG4/HZOlKU
         T1GQ==
X-Gm-Message-State: AGRZ1gKwJGL8maTxX7W0jqO5ntLjqi8HdIKA/fE3KMv8B/zs5tBJNlo4
        wK2gD90fMS+VQrN9hhlOEwZKqkR/tr8=
X-Google-Smtp-Source: AJdET5c0mrJI7VhzwWFHsfOU63nflPy7ojL/acKetpwyW0ZwHCCydhaytaWpYuiYnSv+iNqtab4i3g==
X-Received: by 2002:a62:8145:: with SMTP id t66-v6mr23178729pfd.246.1541445152014;
        Mon, 05 Nov 2018 11:12:32 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 72-v6sm56846581pfl.126.2018.11.05.11.12.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 11:12:31 -0800 (PST)
Date:   Mon, 5 Nov 2018 11:12:29 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 16/17] arm64: dts: qcom: qcs404: Use BAM DMA for
 serial uart2
Message-ID: <20181105191229.GU2523@minitux>
References: <20181105154529.7614-1-vkoul@kernel.org>
 <20181105154529.7614-17-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105154529.7614-17-vkoul@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05 Nov 07:45 PST 2018, Vinod Koul wrote:

> We can use BAM DAM for serial UART data transfers, so add it
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/qcs404.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> index 88e04a0ee67f..23a16b7c43b6 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> @@ -273,6 +273,8 @@
>  			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&gcc GCC_BLSP1_UART2_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
>  			clock-names = "core", "iface";
> +			dmas = <&blsp1_dma 5>, <&blsp1_dma 4>;
> +			dma-names = "rx", "tx";
>  			status = "okay";
>  		};
>  
> -- 
> 2.14.4
> 

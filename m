Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0706EC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 04:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C165B2070C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 04:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y4PnJPBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbfACErc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 23:47:32 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33419 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbfACErb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 23:47:31 -0500
Received: by mail-pf1-f195.google.com with SMTP id c123so16132787pfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 20:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=On+I7NHOZIkneoPiu+k/yqQU7U/xet9QbNr1Xr5/6QM=;
        b=Y4PnJPBfkoSHIAuGksonZBhRFF+wiHmnKCF2+2xpk3mr+N/X7y1+ZkulAI1K9liMtK
         6pMjqkYa+YmaXtHtf4wSqw4CV0CFq8Gt39xokOtxWXYhAz59ryiYFewhwut23LnXrRwK
         3hzIpv2rOWRjVhhUyYVY3Um4McrXKFaj7NfH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=On+I7NHOZIkneoPiu+k/yqQU7U/xet9QbNr1Xr5/6QM=;
        b=jbk96uUUhcdO9b1opC/2KdGuoGE71mrUCfx2v4YJ3PKOZWh2rO/gdlMV3MmksrN63n
         8mATwzF6bqCYCRbZUhzMW5hLBwxBZvgmxbyVPnErNZRaRCNNyDxQpAWZjRDiAunya/Zx
         +tUWr+UUTWl4NO08vzDStLyijqUACRQsbkZ0MWqLl4iIBT2dgfHt2Zh+ChhICE5N2U4A
         ndnEbGsP7JxQ2b9o8SO7ZD/qVZ/PUJJSCXA12Osq/yYBkC0CHktGD1+13f8vR3ya9t5U
         Eh6kneAcWZ0pb+XLagb41EklftbWAQvbWpg6dFW/0FmVvdKMkc4vTsUqM0CAKISe8CSc
         MlQg==
X-Gm-Message-State: AA+aEWbIwzbPPpq/h1R9cgJm1ep7k/RuzN8NdzeeOsLtuI8RzbPk0f/z
        yaogv9ZFPJk6OWZAnFbg00xtxg==
X-Google-Smtp-Source: AFSGD/Uty+vxgE7wfGOFbBiGiiMCcWlnT0Sg5G3GqM2YA739QsspPIjVzuWHkOIcGyB9P1FQF/KLyg==
X-Received: by 2002:a62:de06:: with SMTP id h6mr48253415pfg.158.1546490850250;
        Wed, 02 Jan 2019 20:47:30 -0800 (PST)
Received: from localhost ([122.166.131.155])
        by smtp.gmail.com with ESMTPSA id s21sm86243157pfk.133.2019.01.02.20.47.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 20:47:29 -0800 (PST)
Date:   Thu, 3 Jan 2019 10:17:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Henry Chen <henryc.chen@mediatek.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Fan Chen <fan.chen@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Kees Cook <keescook@chromium.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC RESEND PATCH 4/7] arm64: dts: mt8183: add performance state
 support of scpsys
Message-ID: <20190103044727.i34ak7vw6qfircvq@vireshk-i7>
References: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
 <1546438198-1677-5-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546438198-1677-5-git-send-email-henryc.chen@mediatek.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-01-19, 22:09, Henry Chen wrote:
> Add support for performance state of scpsys on mt8183 platform.
> 
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 47926a7..e396410 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -9,6 +9,7 @@
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/power/mt8183-power.h>
> +#include <dt-bindings/soc/mtk,dvfsrc.h>
>  
>  / {
>  	compatible = "mediatek,mt8183";
> @@ -243,6 +244,26 @@
>  			      "vpu-3", "vpu-4", "vpu-5";
>  		infracfg = <&infracfg>;
>  		smi_comm = <&smi_common>;
> +		operating-points-v2 = <&dvfsrc_opp_table>;
> +		dvfsrc_opp_table: opp-table {
> +			compatible = "operating-points-v2-mtk-level";
> +
> +			dvfsrc_vol_min: opp1 {
> +				mtk,level = <MT8183_DVFSRC_LEVEL_1>;
> +			};
> +
> +			dvfsrc_freq_medium: opp2 {
> +				mtk,level = <MT8183_DVFSRC_LEVEL_2>;
> +			};
> +
> +			dvfsrc_freq_max: opp3 {
> +				mtk,level = <MT8183_DVFSRC_LEVEL_3>;
> +			};
> +
> +			dvfsrc_vol_max: opp4 {
> +				mtk,level = <MT8183_DVFSRC_LEVEL_4>;
> +			};
> +		};
>  	};

I don't see a patch which makes use of this OPP table using the required-opps
thing. Where is that ?

-- 
viresh

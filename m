Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7CBECDFB4
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 23:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C512D2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 23:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LF94ZDYr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C512D2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731126AbeGRARO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 20:17:14 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34279 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729714AbeGRARO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 20:17:14 -0400
Received: by mail-pg1-f194.google.com with SMTP id y5-v6so1120593pgv.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 16:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1ossnfxNO76KpNJAZWlPCQmCFQCGcJKrZaYlGJLonGQ=;
        b=LF94ZDYrnfyrD0rEt4O/EonjbLLMm8qa4TEccnL4RmGKLjYNlu4GM7hQSzXR9UYLLQ
         mAYGMJ+oCNy7RWAa0SIj6b/r2RsoBGGFWxavuRfJk8KNTEzeL9ODp6/qZ14vh6xU1fI1
         cVDm+/7GMBnP8S6smlt5BAW6cp7oF3lbWSHC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1ossnfxNO76KpNJAZWlPCQmCFQCGcJKrZaYlGJLonGQ=;
        b=cg3tWFbfWLnaK3UEZLqR7fkxJAWKuCOVPY6e7D7T+Zb9+eqnC/fu61azuPRxkywbEg
         Vs2/V+A4YvesQ2kUAD6q9/l8yGaUcw4Vz6fov7HZJoOMYVzEEfCL3jwotkl8s89ENeJu
         F4kynSFUc57QmLccIsIusebVUG84VSSkoE8SvSqCHxVUmXdjqt6cSTwKHPozZ9KUhKfI
         KRReMPgTALX7F4rX7ORIockEgV49hcLXXfh9Ty26YA7oVVSCYVj8R5Ycehx70DqNVk1a
         OVYGznDsQbGPor/Ju6yc8KWBVXSeUzLyt5vBL7wxiImE+/KZiyfXv6vaADj5/VuCV9jy
         a8hg==
X-Gm-Message-State: AOUpUlGZBwb3ewjqM11gvGe7LgTiHMXCWx2R4Vx8fe/Jx5iqkeSspGui
        DICzLJinyB8LaeLO31MBJqRA9A==
X-Google-Smtp-Source: AAOMgpdNQAy0E619FZygBsq4yqKRZAeAdCx7lKmP974XE0tjtwJqL1hoFg4/PUcnT3iI/H1gfnKd2A==
X-Received: by 2002:a65:560a:: with SMTP id l10-v6mr3578790pgs.130.1531870934736;
        Tue, 17 Jul 2018 16:42:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id g14-v6sm3250623pfj.175.2018.07.17.16.42.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 16:42:14 -0700 (PDT)
Date:   Tue, 17 Jul 2018 16:42:13 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        edubezval@gmail.com, smohanad@codeaurora.org,
        vivek.gautam@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 3/7] arm64: dts: msm8996: thermal: Initialise via DT
 and add second controller
Message-ID: <20180717234213.GD129942@google.com>
References: <cover.1531384019.git.amit.kucheria@linaro.org>
 <f6cb99e6b805b0850b039e4f5d469e761d84f6d0.1531384019.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f6cb99e6b805b0850b039e4f5d469e761d84f6d0.1531384019.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 02:09:04PM +0530, Amit Kucheria wrote:
> We also split up the regmap address space into two, for the TM and SROT
> registers. This was required to deal with different address offsets for the
> TM and SROT registers across different SoC families.
> 
> 8996 has two TSENS IP blocks, initialise the second one too.
> 
> Since tsens-common.c/init_common() currently only registers one address
> space, the order is important (TM before SROT). This is OK since the code
> doesn't really use the SROT functionality yet.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 8c7f9ca..688e752 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -459,9 +459,19 @@
>  			status = "disabled";
>  		};
>  
> -		tsens0: thermal-sensor@4a8000 {
> +		tsens0: thermal-sensor@4a9000 {
                                       ~~~~~~

I suppose the address of the TM block is used here instead of the SROT
address (which is lower) since SROT functionality is currently not
used. Would/should this change if/when the driver uses SROT?

>  			compatible = "qcom,msm8996-tsens";
> -			reg = <0x4a8000 0x2000>;
> +			reg = <0x4a9000 0x1000>, /* TM */
> +			      <0x4a8000 0x1000>; /* SROT */
> +			#qcom,sensors = <13>;
> +			#thermal-sensor-cells = <1>;
> +		};
> +
> +		tsens1: thermal-sensor@4ad000 {
> +			compatible = "qcom,msm8996-tsens";
> +			reg = <0x4ad000 0x1000>, /* TM */
> +			      <0x4ac000 0x1000>; /* SROT */
> +			#qcom,sensors = <8>;
>  			#thermal-sensor-cells = <1>;
>  		};

Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7B603C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31DBF20891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aRVpcnhc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31DBF20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933460AbeFLTfO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 15:35:14 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37733 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933224AbeFLTfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 15:35:11 -0400
Received: by mail-pl0-f68.google.com with SMTP id 31-v6so63920plc.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 12:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SAMuhf0vaF3MUgU/uFUUNh8Ga/pQqEViocSlhwffGnI=;
        b=aRVpcnhcbp0ya639DFHSLojpI5IR4sTwoRXrPxP6Pd0wzycUvXUqACPMoNrWA5ex3v
         XDamZQfHzUbbW8P4EVWblm0rzXMyi4JNAPhjOG2d6YfpYoM0YM2XcaepV+6+7WkAVK0P
         nEIIgWgWXOmrShHatSymfxZjoIPuBMnlg9Y+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SAMuhf0vaF3MUgU/uFUUNh8Ga/pQqEViocSlhwffGnI=;
        b=TlM2+90nBxrHX1z9A3mP7/IGsM7BHpkwFYjqxtN4ywTMfuruYacafOIdfmv8L8xDv0
         f2yFWpyuVmhHMm1QyaEJfet1XsAf9POQAMpY7Z0VCF68rY00lv66uNFk9OYRlWeLKZf5
         BVZOLUNSyilhroAOJFk6quJj4hGMaX9R5qE/iAxtLTtUTY0kvImeEK65Tf+uxlZUxlzS
         U9POj6wv9SsxjCdylvf/h7dLvAkPUI8LN9fSYhVNlF2fJXOgCo/2VQjBnoKr4cPSYLB0
         CnImx2tH+iXs/3OzjEnxvtzAyyxbAkyFMZtiFDW8iVAzMfD7lY9gR21xiGI8Xn/dsAXK
         L8ww==
X-Gm-Message-State: APt69E2kXXEngSsHFzzuFqY12sdZx6xTYcLQBKN5m6nQPselYQlgehTe
        cQ1NmIGTpYApdmtGlzxamx5H+g==
X-Google-Smtp-Source: ADUXVKJdV2dUrnCULAImh6tUTZ4JZGLYRwc0ig/5InIiUdb2lG8Kcy7I+KV+nuXjErKiaXQIuwiZNA==
X-Received: by 2002:a17:902:b18b:: with SMTP id s11-v6mr1862098plr.190.1528832110503;
        Tue, 12 Jun 2018 12:35:10 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p1-v6sm1068764pfp.137.2018.06.12.12.35.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 12:35:09 -0700 (PDT)
Date:   Tue, 12 Jun 2018 12:35:07 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, edubezval@gmail.com,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] dt: qcom: 8996: thermal: Move to DT initialisation
Message-ID: <20180612193507.GO14924@minitux>
References: <cover.1528799892.git.amit.kucheria@linaro.org>
 <683ceb9a7d283bcad47fc6e8e4fcfbd7e76c1018.1528799892.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <683ceb9a7d283bcad47fc6e8e4fcfbd7e76c1018.1528799892.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12 Jun 03:54 PDT 2018, Amit Kucheria wrote:

> We also split up the regmap address space into two, one for the TM
> registers, the other for the SROT registers. This was required to deal with
> different address offsets for the TM and SROT registers across different
> SoC families.
> 
> Since tsens-common.c/init_common() currently only registers one address space, the order is important (TM before SROT).This is OK since the code doesn't really use the SROT functionality yet.

Please line wrap this.

> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 12 +++++++++++-
>  drivers/thermal/qcom/tsens-8996.c     |  1 -
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 410ae78..b4aab18 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -451,7 +451,17 @@
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
> diff --git a/drivers/thermal/qcom/tsens-8996.c b/drivers/thermal/qcom/tsens-8996.c
> index e1f7781..6e59078 100644
> --- a/drivers/thermal/qcom/tsens-8996.c
> +++ b/drivers/thermal/qcom/tsens-8996.c
> @@ -79,6 +79,5 @@ static const struct tsens_ops ops_8996 = {
>  };
>  
>  const struct tsens_data data_8996 = {
> -	.num_sensors	= 13,

This will cause the current 8996 dts to fail probing the tsens. I think
you should just leave this as is, because specifying qcom,sensors in dts
will overwrite this number regardless.

It also would make this change dts specific, which is convenient as it
breaks the interdependency between the different subsystems.

>  	.ops		= &ops_8996,

Regards,
Bjorn

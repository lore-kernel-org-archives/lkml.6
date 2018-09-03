Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA305C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 833052086B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CIwAZmsi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 833052086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbeIDAwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 20:52:03 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36666 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbeIDAwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 20:52:03 -0400
Received: by mail-pf1-f193.google.com with SMTP id b11-v6so596617pfo.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 13:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lA5qyTW/kXw5kzacK9lme9LtGVB0aSyWMV/8Zpl/HXc=;
        b=CIwAZmsijXKrQcdIvXMM+st4MJ4CkTvig+mPMZ2qFdHvFQhM5RuM5voASn6XFCKmy4
         G5ELofdT6zWDesLX3Yd1cv1URXOmK2gppvOqN9/skH4BIXSKW6rStY2wRqk1tSjwVemK
         uwzxLHJMdU6yC5bPr6gxQ0I4yOuVaOfyR37YU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lA5qyTW/kXw5kzacK9lme9LtGVB0aSyWMV/8Zpl/HXc=;
        b=BbGWt9mKZAxIGNavr7vtuyBIOI8nRSJT9o0Je1NdoSGt6OqyM53z+2vhO1G4GFc/qg
         xSAnzv0pFbPSvuPlX8oDt243j5kGdkGvXWi2iYq0H+wK/jSHs1Cv05K4Akadgf6ziiCD
         zXVlda7ZnOV62weAs2pdzlz87OnDpmzhDBrNgm2Fue7ev9vMs9THUo0Fxvw61eppYaPd
         DjGMLy4rGPr++Rk2Gr+3W7OxokxrXRBTlCAHocjRt14fwwJKoNOfpC/0ceZVeMmqrHSV
         kj5IyXsWh1sX9dwjHRs5NTI2PE+BqyyrIf4lfVmm9CtogcCxas5MyvjtVlESVagfGyjv
         TWJA==
X-Gm-Message-State: APzg51AT/Ww6l8ElQtKQi6fuILz+wR+t/fUB3/paV32x4W+yh+1pkzJY
        17ZR7mc1qJ1/t6t5C3+wieQJsQ==
X-Google-Smtp-Source: ANB0VdZ1/aQJ9Nnk899cqa8ISsPF/FBtV72VAlLQn24w//M4GRjP0rjfdB5aHYMrkBjuo5M1HJQ0Bg==
X-Received: by 2002:a63:ed4f:: with SMTP id m15-v6mr27853388pgk.147.1536006612780;
        Mon, 03 Sep 2018 13:30:12 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z63-v6sm25844586pgd.69.2018.09.03.13.30.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 13:30:12 -0700 (PDT)
Date:   Mon, 3 Sep 2018 13:34:05 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 10/11] arm64: dts: qcom: Add reg-names for all tsens
 nodes
Message-ID: <20180903203405.GT3456@tuxbook-pro>
References: <cover.1535462942.git.amit.kucheria@linaro.org>
 <c49d9f13b3d6849604ae3eb00a92b80948ef1534.1535462942.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c49d9f13b3d6849604ae3eb00a92b80948ef1534.1535462942.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28 Aug 06:38 PDT 2018, Amit Kucheria wrote:

> Instead of showing up as thermal-sensor@<addr>, the nodes will show up as
> tsens0_tm, tsen1_tm, tsens1_srot, etc. in /proc/iomem making it easier to
> read.
> 
> IOW,
> 
> 0c222000-0c2221fe : thermal-sensor@c263000
> 0c223000-0c2231fe : thermal-sensor@c265000
> 0c263000-0c2631fe : thermal-sensor@c263000
> 0c265000-0c2651fe : thermal-sensor@c265000
> 
> becomes
> 
> 0c222000-0c2221fe : tsens0_srot
> 0c223000-0c2231fe : tsens1_srot
> 0c263000-0c2631fe : tsens0_tm
> 0c265000-0c2651fe : tsens1_tm
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  arch/arm/boot/dts/qcom-msm8974.dtsi   | 1 +
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 1 +
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 ++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi  | 2 ++
>  4 files changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
> index 3c4b81c29798..64c9f81ddd90 100644
> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> @@ -431,6 +431,7 @@
>  			compatible = "qcom,msm8974-tsens";
>  			reg = <0xfc4a9000 0x1000>, /* TM */
>  			      <0xfc4a8000 0x1000>; /* SROT */
> +			reg-names = "tsens_tm", "tsens_srot";

While the iomem output seems more convenient this way, these register
names are a contract between the DT binding and the particular tsens
instance.

As such this is a good idea, but with the names should not include the
instance information. They should be "tm", "srot".

>  			nvmem-cells = <&tsens_calib>, <&tsens_backup>;
>  			nvmem-cell-names = "calib", "calib_backup";
>  			#qcom,sensors = <11>;
[..]
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 0c9a2aa6a1b5..f1a36d6829cf 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -966,6 +966,7 @@
>  			compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
>  			reg = <0xc263000 0x1ff>, /* TM */
>  			      <0xc222000 0x1ff>; /* SROT */
> +			reg-names = "tsens0_tm", "tsens0_srot";
>  			#qcom,sensors = <13>;
>  			#thermal-sensor-cells = <1>;
>  		};
> @@ -974,6 +975,7 @@
>  			compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
>  			reg = <0xc265000 0x1ff>, /* TM */
>  			      <0xc223000 0x1ff>; /* SROT */
> +			reg-names = "tsens1_tm", "tsens1_srot";

And I do recognize that in this case iomem won't show which one is
tsens0 and which is tsens1...


As with previous patches, please split arm and arm64 in separate
patches.

Regards,
Bjorn

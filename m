Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C05BC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354B920862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JLIMnTGd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 354B920862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbeIDAUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 20:20:46 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44895 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728486AbeIDAUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 20:20:46 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1-v6so541295pgp.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 12:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mIGchnHE/lk5I7Hi5ELF5UjfBg31a9B1OIk6YF3geSM=;
        b=JLIMnTGduWid5TcWu9Ib2J28xZcNQPmWBlltFbLFg/qU3bRk/0S+gwRd6GMyEdvfSv
         Q2pmwjov/eeMD5sDcN68jYFOkWNTkjZSKH18KR8sREDE1itRTJb19piFqVSAxTHfe4Yb
         dam+aqDciHHTol/hmDlFXK8idnH0Wvd39Dy4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mIGchnHE/lk5I7Hi5ELF5UjfBg31a9B1OIk6YF3geSM=;
        b=F2ad+v8VtzjdJcW465o6jzuS0l3i9460WLdG7GpBPJ+2ABlTFjed30fq0lnmXil/Xz
         cpuLAoKoDBKgoC4bdSi9yBL2G9uTeQ/7n22lxhA+s4PZsQh86JOXYIqBvlWj2YG7PEpG
         123C3hXjP9pBwjJOKQ/LTnABu5j06pmqwfs7rBerw4NfjhkFMNiGsxsBqmK5cTRssQAa
         zpn+6Fje4Lt7AB0XeLJnWIn4WQ93ZxC2tO2bax6GJoKQwuVoTmLzO8KFMoXSohwc5nB2
         mUHT89itFyR4CjnRv4/RRHAqjaUrT8FsZ5TJCijn1us7SqKGJZYrqW3UcWbi4AeYrm5F
         xhRw==
X-Gm-Message-State: APzg51CMMQF3kJE3caT/3yl1zZVCqa2gYRIhvXHNJkRyw1OP5utLyXXr
        9fMoKAkU//npXjSMvTzZ8uliaA==
X-Google-Smtp-Source: ANB0VdYemPaDGkkl+2xlvsuBX7gIyFzjtnLND84i1L19lweyERFKU4D2wBnSR1HUpjoeFbDpc7xsow==
X-Received: by 2002:a62:7a01:: with SMTP id v1-v6mr30906340pfc.153.1536004742149;
        Mon, 03 Sep 2018 12:59:02 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 16-v6sm31488622pfo.164.2018.09.03.12.59.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 12:59:01 -0700 (PDT)
Date:   Mon, 3 Sep 2018 13:02:55 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 01/11] arm/arm64: dts: msm8974/msm8916: thermal: Split
 address space into two
Message-ID: <20180903200255.GL3456@tuxbook-pro>
References: <cover.1535462942.git.amit.kucheria@linaro.org>
 <882739b10bd0a3b655baef9b7ee1958680aa0b04.1535462942.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <882739b10bd0a3b655baef9b7ee1958680aa0b04.1535462942.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28 Aug 06:38 PDT 2018, Amit Kucheria wrote:

> We've earlier added support to split the register address space into TM
> and SROT regions.
> 
> Split up the regmap address space into two for the remaining platforms
> that have a similar register layout and make corresponding changes to
> the get_temp_common() function used by these platforms.
> 
> Since tsens-common.c/init_common() currently only registers one address
> space, the order is important (TM before SROT).  This is OK since the
> code doesn't really use the SROT functionality yet.
> 

Having a single patch touching both code and dts will cause merge issues
as this patch travel upstream. Even more arm-soc expects arm and arm64
dts changes to come in different pull requests.

Please split it so that the three pieces can be picked up by respective
maintainer.

> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  arch/arm/boot/dts/qcom-msm8974.dtsi   | 5 +++--
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 5 +++--
>  drivers/thermal/qcom/tsens-common.c   | 5 +++--
>  3 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
> index d9019a49b292..56dbbf788d15 100644
> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> @@ -427,9 +427,10 @@
>  			};
>  		};
>  
> -		tsens: thermal-sensor@fc4a8000 {
> +		tsens: thermal-sensor@fc4a9000 {
>  			compatible = "qcom,msm8974-tsens";
> -			reg = <0xfc4a8000 0x2000>;
> +			reg = <0xfc4a9000 0x1000>, /* TM */
> +			      <0xfc4a8000 0x1000>; /* SROT */
>  			nvmem-cells = <&tsens_calib>, <&tsens_backup>;
>  			nvmem-cell-names = "calib", "calib_backup";
>  			#thermal-sensor-cells = <1>;
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index 7b32b8990d62..6a277fce3333 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -761,9 +761,10 @@
>  			};
>  		};
>  
> -		tsens: thermal-sensor@4a8000 {
> +		tsens: thermal-sensor@4a9000 {
>  			compatible = "qcom,msm8916-tsens";
> -			reg = <0x4a8000 0x2000>;
> +			reg = <0x4a9000 0x1000>, /* TM */
> +			      <0x4a8000 0x1000>; /* SROT */
>  			nvmem-cells = <&tsens_caldata>, <&tsens_calsel>;
>  			nvmem-cell-names = "calib", "calib_sel";
>  			#thermal-sensor-cells = <1>;
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> index 6207d8d92351..478739543bbc 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -21,7 +21,7 @@
>  #include <linux/regmap.h>
>  #include "tsens.h"
>  
> -#define S0_ST_ADDR		0x1030
> +#define STATUS_OFFSET		0x30
>  #define SN_ADDR_OFFSET		0x4
>  #define SN_ST_TEMP_MASK		0x3ff
>  #define CAL_DEGC_PT1		30
> @@ -107,8 +107,9 @@ int get_temp_common(struct tsens_device *tmdev, int id, int *temp)
>  	unsigned int status_reg;
>  	int last_temp = 0, ret;
>  
> -	status_reg = S0_ST_ADDR + s->hw_id * SN_ADDR_OFFSET;
> +	status_reg = tmdev->tm_offset + STATUS_OFFSET + s->hw_id * SN_ADDR_OFFSET;

Wasn't this change part of the previous set that introduced the
tm_offset? If not how did we handle the fact that tmdev->map is already
indented 0x1000 bytes?

Both changes looks good, but I'm worries about the order of things.

Regards,
Bjorn

>  	ret = regmap_read(tmdev->map, status_reg, &code);
> +
>  	if (ret)
>  		return ret;
>  	last_temp = code & SN_ST_TEMP_MASK;
> -- 
> 2.17.1
> 

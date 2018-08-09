Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB33C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301EE21EB7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DKBunHGn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 301EE21EB7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbeHIVhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 17:37:13 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37554 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbeHIVhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 17:37:13 -0400
Received: by mail-pg1-f193.google.com with SMTP id n7-v6so3184080pgq.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 12:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qY/nUCJlHonZ9QIQuM23V5KBY1h8mqc6sUd7aertdxs=;
        b=DKBunHGnvIGbxHhMkp+iZdjZC57rR6CDJvLbfmwrEnmaNs2BesY8xc1hb8Tghf84Jj
         2vfBFvXx+5OPEW7ON27FeKVdIqcCR8q19+qPQlrPvEy6B2w2T6QhLvkD+5mqelsjtiOb
         eIketuZzy2FvnW8LDdUafc26dUTLy8AfV6xQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qY/nUCJlHonZ9QIQuM23V5KBY1h8mqc6sUd7aertdxs=;
        b=ND4GS59co63vg8/Svv0Zl9w/OCdlvXQHys4dex9YVjZvlplYQc0H5RISO9RPuLhnuW
         n6QP3Eki3xqHoU7YjywhbyORugq3H9jpthIP0v9q0fUOEGE29/DETyoW0CMSlwe+gYzO
         tLC6H9HW00ELsAbJ6+1ugANRDhqgLIxDTeqwo1hm8gCGrdpXuAAXeoMqdLKkUQx94ThZ
         IrtE8rC0+G1Gim59nUDMMiZ3PU3WpnTr12+EsPY8C7NLaFsjt1R3ztT5Vp460Ig17t0Y
         irRjqpoyj/RdkFe084NqJVg4RKZdlcFcMlk98t4SEjJ/VBaUkBvSHR8wQtTnHVGRooN+
         33Rw==
X-Gm-Message-State: AOUpUlHk4oU8ylDSCpZTw6GvuXJgB4GuJxLz9vmPlPVQ/Cb5CnrCVp4L
        kfKyd3ZhJ+g7PvGg/Qgo/5tfVA==
X-Google-Smtp-Source: AA+uWPyim240s5XKa5JJLrb7zXh7kjzpyq8YuTthDB0GDPzxl4kZuDtKiB/mDcAzN/+OGi7kxectIg==
X-Received: by 2002:a62:8acd:: with SMTP id o74-v6mr3683204pfk.12.1533841861195;
        Thu, 09 Aug 2018 12:11:01 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id a20-v6sm15973850pfc.14.2018.08.09.12.11.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 12:11:00 -0700 (PDT)
Date:   Thu, 9 Aug 2018 12:10:59 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        edubezval@gmail.com, smohanad@codeaurora.org,
        andy.gross@linaro.org, dianders@chromium.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 01/10] arm/arm64: dts: msm8974/msm8916: thermal: Split
 address space into two
Message-ID: <20180809191059.GI160295@google.com>
References: <cover.1533815718.git.amit.kucheria@linaro.org>
 <d01f560abed221b536b27bfaa42a530257642974.1533815718.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d01f560abed221b536b27bfaa42a530257642974.1533815718.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 06:02:33PM +0530, Amit Kucheria wrote:
> We've earlier added support to split the register address space into TM
> and SROT regions.
> 
> Split up the regmap address space into two for the remaining platforms that
> have a similar register layout and make corresponding changes to the
> get_temp_common() function used by these platforms.
> 
> Since tsens-common.c/init_common() currently only registers one address
> space, the order is important (TM before SROT).  This is OK since the code
> doesn't really use the SROT functionality yet.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  arch/arm/boot/dts/qcom-msm8974.dtsi   | 6 ++++--
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 6 ++++--
>  drivers/thermal/qcom/tsens-common.c   | 5 +++--
>  3 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
> index d9019a49b292..3c4b81c29798 100644
> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> @@ -427,11 +427,13 @@
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
> +			#qcom,sensors = <11>;

nit: adding the number of sensors isn't directly related and probably
should be in a separate patch. Not important enough to re-spin just
for this though ;-)

>  			#thermal-sensor-cells = <1>;
>  		};
>  
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index cc1040eacdf5..abf84df5a7bc 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -774,11 +774,13 @@
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
> +			#qcom,sensors = <5>;

ditto

>  			#thermal-sensor-cells = <1>;
>  		};
>  
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
>  	ret = regmap_read(tmdev->map, status_reg, &code);
> +
>  	if (ret)
>  		return ret;
>  	last_temp = code & SN_ST_TEMP_MASK;

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

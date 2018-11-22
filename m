Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3763C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 20:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D70720870
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 20:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AL5V+7h5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D70720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393150AbeKWHEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 02:04:39 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36355 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732806AbeKWHEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 02:04:39 -0500
Received: by mail-pf1-f194.google.com with SMTP id b85so2363940pfc.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 12:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GqvNxDL/pRxvMdVa6plmqM9BDGm3lo4Yg47mv8hj69U=;
        b=AL5V+7h5uqAq+zQKHtuxz91gparo2a1ugFdsieqzPqssOBzJHMakEHTt81cXn7IWLs
         UYpWoiYIHfGiRkw4Ew8DqsA/+CVAsNYlv+VtJbbQOMoktiErsdzF9z4FU6z6iJZWZlU0
         wmf3nCxGy0gG3u0elsTNHfCpA3aVgeWicrn7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GqvNxDL/pRxvMdVa6plmqM9BDGm3lo4Yg47mv8hj69U=;
        b=lgC/cp9ZNo9jQ+9DPk4LmrheJ9UaU7Lg1zWOr8maJ3w52WoUS9B/l1xd5xyT+ebMjT
         O+COW+euQhXaFhqu1rH7ZR4Gg7zo4OmalgTWCeFnRDB+LL9WvDCynXRRJm+TWQXj23Sy
         7JpBz1MLFREIjRwhB8EArxayFbj7mxr0z/QK8/rXijyaOsyPW7rvWLria4aX0G8eOe/m
         fj61M5Mx2vZZ5UG/Ld4gn3t3GM1Jpb48M14qHHVa2cyWEe2p0NjowgzefbjshN/gXWx8
         37gSqbBx7DSVyTKWcxhnxy0NeaqEgX+4Zm/XpBg3s8s5lClhIk7Zxs5xptnJhqJor3Hp
         Mu3w==
X-Gm-Message-State: AA+aEWajdbTMIpUwiuCPhpk48gd1vhEOA43CMxiLjiaLoNJcrq3zj+i9
        J6D6OeaCWZ73Hq7JYmJROuZifg==
X-Google-Smtp-Source: AFSGD/UeXLuyxtomF9QJY3KefQqaFlbu2gUUKRSca09fRSWKVjY691DQ16tQiW1xA8xEc5Slfp3saw==
X-Received: by 2002:a63:fb10:: with SMTP id o16mr8781413pgh.211.1542918219731;
        Thu, 22 Nov 2018 12:23:39 -0800 (PST)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h8sm34198772pgv.27.2018.11.22.12.23.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 12:23:39 -0800 (PST)
Date:   Thu, 22 Nov 2018 12:23:36 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, edubezval@gmail.com,
        andy.gross@linaro.org, David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v1] arm64: dts: msm8998: thermal: split address space
 into two
Message-ID: <20181122202315.GN1921@tuxbook-pro>
References: <cover.1542911304.git.amit.kucheria@linaro.org>
 <565873e4dd152df24c86d091327687f4aa3505e2.1542911304.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <565873e4dd152df24c86d091327687f4aa3505e2.1542911304.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 22 Nov 10:32 PST 2018, Amit Kucheria wrote:

> We added support to split the register address space for
> tsens into TM and SROT regions in 'Commit 5b1283984fa3 ("thermal: tsens:
> Add support to split up register address space into two")'.
> 
> Split up the tsens address space for msm8998 since it has a similar
> register layout to other versions of the IP to allow for better code
> sharing.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
> (Compile-tested only, since I don't have the hardware)

You do have hardware, it's available in our conmux.

Regards,
Bjorn

>  arch/arm64/boot/dts/qcom/msm8998.dtsi | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> index 78227cce16db..eb4f6f77969f 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -577,17 +577,18 @@
>  			cell-index = <0>;
>  		};
>  
> -		tsens0: thermal@10aa000 {
> +		tsens0: thermal@10ab000 {
>  			compatible = "qcom,msm8998-tsens", "qcom,tsens-v2";
> -			reg = <0x10aa000 0x2000>;
> -
> +			reg = <0x10ab000 0x1000>, /* TM */
> +			      <0x10aa000 0x1000>; /* SROT */
>  			#qcom,sensors = <12>;
>  			#thermal-sensor-cells = <1>;
>  		};
>  
> -		tsens1: thermal@10ad000 {
> +		tsens1: thermal@10ae000 {
>  			compatible = "qcom,msm8998-tsens", "qcom,tsens-v2";
> -			reg = <0x10ad000 0x2000>;
> +			reg = <0x10ae000 0x1000>, /* TM */
> +			      <0x10ad000 0x1000>; /* SROT */
>  
>  			#qcom,sensors = <8>;
>  			#thermal-sensor-cells = <1>;
> -- 
> 2.17.1
> 

Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD859C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 05:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 598562081F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 05:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IjNDvnLD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 598562081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbeKCOj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 10:39:26 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41770 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbeKCOjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 10:39:25 -0400
Received: by mail-pl1-f194.google.com with SMTP id p16-v6so1914412plr.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 22:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U4tIsdncRg7DVvaXL+i3xB+2lczTzMPoEXb+mB6GxXI=;
        b=IjNDvnLDmvl4OXguUqbbFigNC5hMlbs0QETyR/XyG9fmZx+tmZzgkDeQQ0oLQ5s0ap
         p0vMgXlQk4cGynK9rAWIXJyUmZqOcwkLX/d0o1dvOqOMFBPDbfHmcm6JbBGutXzl5z6J
         MiaqdDnrhZBRkKCoGP55SideXzgHJ96GQ/XRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U4tIsdncRg7DVvaXL+i3xB+2lczTzMPoEXb+mB6GxXI=;
        b=OeiZWpGiZ9IUR2UMJODE1eQOh8UTvm37jZhXkkmaBHvDoqz5Rgb00gH1P651iKwVcH
         LgRE/UOD4o1qwdzLJYmBqIb1ierX2w30DXMDOpvOsfXieCE7FDSbkbl9y1ruP58vtui4
         kZ8f8ayXVlkguR761eP14m0ts26YpuA0ITMKr8uEeILg9JI4q34F4h0YBDFdfWAOc0+K
         ZMxjJ2QxPtZFTs8qnt2Le1e446x7nXONLJf4zRjDb8FflpndMjGuP24FuPoiWQhliDzF
         BHSN9OVi8fgGjo5Zld3DVtWl7eeqTQg8I2kNh1K1cw6S3Rw1ZIROM+s0tka8GE0QU7YM
         IKXw==
X-Gm-Message-State: AGRZ1gI1dI4l0DEuPDIZDlZJoSRgl9VuqVho5ttQ1sMjRqxaYUgL1+gZ
        E7Av6ChVcKE6m903rrGTUNGCyQ==
X-Google-Smtp-Source: AJdET5ch3BsD7qqpQetfTMHZ5DIH11pMxY04Sz5FvOATooqTxM+zelF9wS4Cfh8zplzFjeIuUmOymQ==
X-Received: by 2002:a17:902:8b8c:: with SMTP id ay12-v6mr13657428plb.69.1541222959999;
        Fri, 02 Nov 2018 22:29:19 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c70-v6sm16863920pfg.97.2018.11.02.22.29.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 22:29:19 -0700 (PDT)
Date:   Fri, 2 Nov 2018 22:29:11 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: msm8916: remove bogus argument to the cpu
 clock
Message-ID: <20181103052911.GC1785@tuxbook-pro>
References: <20181103005734.15545-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181103005734.15545-1-niklas.cassel@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 02 Nov 17:57 PDT 2018, Niklas Cassel wrote:

> The apcs node has #clock-cells = <0>, which means that those who
> references it should specify 0 arguments.
> 
> The apcs reference in the cpu node incorrectly specifies an argument,
> remove this bogus argument.
> 
> Fixes: 65afdf458360 ("arm64: dts: qcom: msm8916: Add CPU frequency scaling support")
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index d302d8d639a1..e4bfd47178b1 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -111,7 +111,7 @@
>  			next-level-cache = <&L2_0>;
>  			enable-method = "psci";
>  			cpu-idle-states = <&CPU_SPC>;
> -			clocks = <&apcs 0>;
> +			clocks = <&apcs>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			#cooling-cells = <2>;
>  		};
> @@ -123,7 +123,7 @@
>  			next-level-cache = <&L2_0>;
>  			enable-method = "psci";
>  			cpu-idle-states = <&CPU_SPC>;
> -			clocks = <&apcs 0>;
> +			clocks = <&apcs>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			#cooling-cells = <2>;
>  		};
> @@ -135,7 +135,7 @@
>  			next-level-cache = <&L2_0>;
>  			enable-method = "psci";
>  			cpu-idle-states = <&CPU_SPC>;
> -			clocks = <&apcs 0>;
> +			clocks = <&apcs>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			#cooling-cells = <2>;
>  		};
> @@ -147,7 +147,7 @@
>  			next-level-cache = <&L2_0>;
>  			enable-method = "psci";
>  			cpu-idle-states = <&CPU_SPC>;
> -			clocks = <&apcs 0>;
> +			clocks = <&apcs>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			#cooling-cells = <2>;
>  		};
> -- 
> 2.19.1
> 

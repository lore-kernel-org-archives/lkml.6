Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44899C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1177520856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TFx/29Ie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbfAQGgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 01:36:46 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42475 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbfAQGgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 01:36:45 -0500
Received: by mail-pg1-f195.google.com with SMTP id d72so3978954pga.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 22:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vxQkdMjTikHdV+D01KGNE2ZNqnn8VM0XG4t7jDYHpmE=;
        b=TFx/29Ie+5knQFudhi+WqwXV24nkiYswHFAKpKYV0VkehePeXz/neJgm9QNjOu5P2V
         6oYDYjB9c0i9Hm5SDWyOCLBrMRSAm3on6eVIjfzXSButwLm8Fir/LrLsrhj4oUk5xBtQ
         jUN2L782MCldVNIBX0QZup13nN9maF33PeSyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vxQkdMjTikHdV+D01KGNE2ZNqnn8VM0XG4t7jDYHpmE=;
        b=kUjynQSeKhjca+d3LbXSpaE1/B4+4e7MRg8WNioRDT9DxlG6p6ZQfR+UJdEJD6bxDH
         EIeiEesI/W0E9q7FOPmEb8s1Gpk0H1yNpKRlyDroA/hSiOD52lonsuLUL0pzFSXV8iaa
         4ed35izAz0VLYILWUxgJRf4pOtr71eRIZKzLgRYEidN7QWS6HqnMz45DQU4/nb1duefi
         k+23MpAJmj6SOMISq2Q5QSat8d12+UpymdM2/tfFhP5WemGiox+lQObIrHw0pW5X+BMv
         uIgs4pzMusMReNcs7LVZ1WmMqlrDvJmfqsL/6FhUYJqYp9P+kXCoyw1JXdeTDBUxzlCf
         BppQ==
X-Gm-Message-State: AJcUukdBjLvy7HzT+DMtHPa6zUOrsCYM0a2VjZvPI+oKaAnkj559ne3t
        k77EOObuzMQpQvZZNqrkxlSBcA==
X-Google-Smtp-Source: ALg8bN7lRBsL54kfBxvrKwmQG6g1r5xezKcKdsu+5mmNQDe+0CGMtHhf2p3BAH6wcOHC19lpIIH8sw==
X-Received: by 2002:a62:1212:: with SMTP id a18mr14112211pfj.217.1547707003688;
        Wed, 16 Jan 2019 22:36:43 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d13sm1378590pfd.58.2019.01.16.22.36.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 22:36:43 -0800 (PST)
Date:   Wed, 16 Jan 2019 22:36:03 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, sboyd@kernel.org, will.deacon@arm.com,
        mturquette@baylibre.com, jassisinghbrar@gmail.com,
        vkoul@kernel.org, niklas.cassel@linaro.org, sibis@codeaurora.org,
        georgi.djakov@linaro.org, arnd@arndb.de,
        horms+renesas@verge.net.au, heiko@sntech.de,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 12/13] arm64: dts: qcom: qcs404: Add cpufreq support
Message-ID: <20190117063603.GH25498@builder>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-13-git-send-email-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545039990-19984-13-git-send-email-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 17 Dec 01:46 PST 2018, Jorge Ramirez-Ortiz wrote:

> Support CPU frequency scaling on qcs404.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qcs404.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> index 2d9e70e..5a14887 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> @@ -30,6 +30,8 @@
>  			reg = <0x100>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_0>;
> +			clocks = <&apcs_glb>;
> +			operating-points-v2 = <&cpu_opp_table>;
>  		};
>  
>  		CPU1: cpu@101 {
> @@ -38,6 +40,8 @@
>  			reg = <0x101>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_0>;
> +			clocks = <&apcs_glb>;
> +			operating-points-v2 = <&cpu_opp_table>;
>  		};
>  
>  		CPU2: cpu@102 {
> @@ -46,6 +50,8 @@
>  			reg = <0x102>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_0>;
> +			clocks = <&apcs_glb>;
> +			operating-points-v2 = <&cpu_opp_table>;
>  		};
>  
>  		CPU3: cpu@103 {
> @@ -54,6 +60,8 @@
>  			reg = <0x103>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_0>;
> +			clocks = <&apcs_glb>;
> +			operating-points-v2 = <&cpu_opp_table>;
>  		};
>  
>  		L2_0: l2-cache {
> -- 
> 2.7.4
> 

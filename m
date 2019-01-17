Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CE6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E63A220851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="T+9D966g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfAQGgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 01:36:21 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37337 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfAQGgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 01:36:21 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5so4266713plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 22:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yAWRTL93sTtOSi98RyIBxtIVWCPcSUjGWoSe6meVdDI=;
        b=T+9D966gZpfgzNwQNyqSaCvw01s/kVIXKpNUzfNHfR8qSJIzS91Hy9MvkuJsnF18ue
         r1Q5Pzp1vqu9izPX2H2tDX8uJfGP/zBFbfA/zhxBvkmBp1AzGFXXvqsvlgo/ZKsc/+Zq
         /KlWzwuEgg/Ch8HKonld7Fw8M9nka9zQAVcRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yAWRTL93sTtOSi98RyIBxtIVWCPcSUjGWoSe6meVdDI=;
        b=FhwaerVQUd6eGm9su+9RY+ieUv+3RltzOAyuRFJM3unGB5bi3USqRlJs4R35UXPfG6
         g6lgqw4kysIzL2Vk0jqHEPt7DvGZXwfUqg50LHtXD8/4GAyVvGKAPKyf+Rss7BTl4Xu1
         nhLlhM/Yi8l9OXKpu6jc8t25Y3x/PyvZbXGxJFSQ5EZKJbEOomSvLFi0t1DVuEDE9Ewm
         PGM/djcsJFFYb7FEoSYSQS0kL0nrd2LvDwjzq9X0MLxh1bbicVc9os6dxpENOdBUXeYu
         k0+GSWuVstVSgaICsGYnsdeK0zVHVsiG3qi92e8Hyceoy24WwlgyhQ34/UXPp8Mm/uut
         nKug==
X-Gm-Message-State: AJcUukek0TFhq8EADcAyT7cQgy2Y/Khl5vEtpb0dV+EMv9XmA1jPpePY
        npc40Ddl1221EDmn/BPviKUomw==
X-Google-Smtp-Source: ALg8bN5fwty0cHZKQCSE+Eb39PJyhTu5iku1Ogv+ANeAJr0F3suynCKts6levZ96WHZ+Q82nucT0nw==
X-Received: by 2002:a17:902:468:: with SMTP id 95mr13619788ple.3.1547706980368;
        Wed, 16 Jan 2019 22:36:20 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id r130sm1637143pfr.48.2019.01.16.22.36.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 22:36:19 -0800 (PST)
Date:   Wed, 16 Jan 2019 22:35:39 -0800
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
Subject: Re: [PATCH 11/13] arm64: dts: qcom: qcs404: Add the clocks for APCS
 mux/divider
Message-ID: <20190117063539.GG25498@builder>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-12-git-send-email-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545039990-19984-12-git-send-email-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 17 Dec 01:46 PST 2018, Jorge Ramirez-Ortiz wrote:

> Specify the clocks that feed the APCS mux/divider instead of using
> default hardcoded values in the source code.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qcs404.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> index ec3f6c7..2d9e70e 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> @@ -373,6 +373,9 @@
>  			compatible = "qcom,qcs404-apcs-apps-global", "syscon";
>  			reg = <0x0b011000 0x1000>;
>  			#mbox-cells = <1>;
> +			clocks = <&gcc GCC_GPLL0_AO_OUT_MAIN>, <&apcs_hfpll>;
> +			clock-names = "aux", "pll";
> +			#clock-cells = <0>;
>  		};
>  
>  		apcs_hfpll: clock-controller@0b016000 {
> -- 
> 2.7.4
> 

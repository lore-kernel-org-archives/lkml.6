Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DA6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77FE721738
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WvSpiRt8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfAJGYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 01:24:04 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35424 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfAJGYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 01:24:03 -0500
Received: by mail-pg1-f195.google.com with SMTP id s198so4429404pgs.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 22:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2BeolWeXP7bTs4CiVa1/MVZec9PsZULVRVGAQmzgstQ=;
        b=WvSpiRt82uHW3BRpPWX6eXAwOB5sMb6s9GIYQnoZMhcl0GjOPdlk3z+K/WPKJtItT1
         +AeyCls7KLHd9/ayNjTyQXzpGMukwYnUuPZ5Y3LY/6lYpq3lp1rQG73g6JBGDWhV2lG6
         hyNHVl+vluMUZuyBCzuBgZo659u3MhB7rxEXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2BeolWeXP7bTs4CiVa1/MVZec9PsZULVRVGAQmzgstQ=;
        b=AhLR3nrLYMaYKswxHsNStSRkM8dqVLlTyAXEf/wokbq4cMfL4QZqTfEqy+vxL8f35r
         JNprBX40JMjp61S7SD3lHsb84J2vryAivdiGXhE0jMg9H1MeY8WqzX7EBwnFzbZEFIaW
         cry8aC9DIIdmzLvQOcBfL8HMQb+WsVxTIPnCxTBt3PveBMLZWmVenr/wnptppgXOZO8J
         zrlXuC5kgiN85PNbqoj5Xx7X0H+Vlcbei29vaMXC3cf9An4KvN7jckcS4YwDn+BHRlhB
         mqMacH7J/l93m3xuqcpy4nmH7Yq7Zlbvfro6w1JsUPj2ilKTnqR4RF3dssc7nleiGPJZ
         3GsA==
X-Gm-Message-State: AJcUukfsc7ayZGxa/F6tM4OESDbtkICKOFaABKyz0xm8u9r4OU6HTzqT
        jIcJBV8UcJt8mh6W6qWGcE2+fw==
X-Google-Smtp-Source: ALg8bN4cq3Wu82ExswjaScOFbC0IA7HRPXkpXLwkr9VqLpxbfXnjuyfz/9bXNcRF0iJIe5E8/JnmRw==
X-Received: by 2002:a63:86c1:: with SMTP id x184mr5969520pgd.305.1547101442601;
        Wed, 09 Jan 2019 22:24:02 -0800 (PST)
Received: from localhost ([122.166.131.155])
        by smtp.gmail.com with ESMTPSA id h8sm79355162pgv.27.2019.01.09.22.24.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 22:24:01 -0800 (PST)
Date:   Thu, 10 Jan 2019 11:53:59 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, tdas@codeaurora.org, swboyd@chromium.org,
        dianders@chromium.org, David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v1 7/7] arm64: dts: sdm845: wireup the thermal trip
 points to cpufreq
Message-ID: <20190110062359.aea3tic5aw3iuocr@vireshk-i7>
References: <cover.1547078153.git.amit.kucheria@linaro.org>
 <6c5b26e65be18222587724e066fc2e39b9f60397.1547078153.git.amit.kucheria@linaro.org>
 <20190110022217.GX261387@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110022217.GX261387@google.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-01-19, 18:22, Matthias Kaehlcke wrote:
> Hi Amit,
> 
> On Thu, Jan 10, 2019 at 05:30:56AM +0530, Amit Kucheria wrote:
> > Since the big and little cpus are in the same frequency domain, use all
> > of them for mitigation in the cooling-map. At the lower trip points we
> > restrict ourselves to throttling only a few OPPs. At higher trip
> > temperatures, allow ourselves to be throttled to any extent.
> > 
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 145 +++++++++++++++++++++++++++
> >  1 file changed, 145 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > index 29e823b0caf4..cd6402a9aa64 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > @@ -13,6 +13,7 @@
> >  #include <dt-bindings/reset/qcom,sdm845-aoss.h>
> >  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> >  #include <dt-bindings/clock/qcom,gcc-sdm845.h>
> > +#include <dt-bindings/thermal/thermal.h>
> >  
> >  / {
> >  	interrupt-parent = <&intc>;
> > @@ -99,6 +100,7 @@
> >  			compatible = "qcom,kryo385";
> >  			reg = <0x0 0x0>;
> >  			enable-method = "psci";
> > +			#cooling-cells = <2>;
> >  			next-level-cache = <&L2_0>;
> >  			L2_0: l2-cache {
> >  				compatible = "cache";
> > @@ -114,6 +116,7 @@
> >  			compatible = "qcom,kryo385";
> >  			reg = <0x0 0x100>;
> >  			enable-method = "psci";
> > +			#cooling-cells = <2>;
> 
> This is not needed (also applies to other for other non-policy
> cores). A single cpufreq device is created per frequency domain /
> cluster, hence a single cooling device is registered per cluster,
> which IMO makes sense given that the CPUs of a cluster can't change
> their frequencies independently.
 
> As per above, there are no cooling devices for CPU1-3 and CPU5-7.

lore.kernel.org/lkml/cover.1527244200.git.viresh.kumar@linaro.org
lore.kernel.org/lkml/b687bb6035fbb010383f4511a206abb4006679fa.1527244201.git.viresh.kumar@linaro.org

-- 
viresh

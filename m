Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5A2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE4B20657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FoLHtbyD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbfAQGoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 01:44:54 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44001 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbfAQGox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 01:44:53 -0500
Received: by mail-pf1-f196.google.com with SMTP id w73so4325634pfk.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 22:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=atLgXCZJmtT0O+GD3SkLBWNlve906gHwrgA3+iQTNq8=;
        b=FoLHtbyD+T0hvK+Xsp8pX/kYm+I/+k4QezqwPy4hZEZOawY2bnAnmlg4Lqho8lfRFC
         Pe+kTdIIXJOQiqLOuMj2BNQwVtPcMeN9yRHNlK3tuyW9GRfX/qzmxsKxAR+caOljDVnx
         7oIH1rzzHgC/Mst7cn6AwQQOxI6ERIWzCV4G4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=atLgXCZJmtT0O+GD3SkLBWNlve906gHwrgA3+iQTNq8=;
        b=DnF0uN3ZSZ6quXcpdiytB0FA96vECVV2CFnowGBtARZu1Mj+68SMQUC7CAufa2YZfZ
         iMw1Ws34Xe9yjUe4lQt67CcxLkf0b5lw7lZHx9sOIOPj1YKPo5MXDo7RQfsgxj0jJcxX
         VsXBoP3cgN/+Mj8Bnsdlk4LhM30dMvZD9ERgbe68e83UDHYTzXVi+WX8/JPoqc0ZFOBK
         11qPb1O1quwVCAw4iXNN10st60XAnswEcHVC7p2kX7aFYLZV6nMNKbgMtGxyYPlSw8Ve
         Jqd8atAo96BlcYJFQD3maHLjJCo3FZM/yP65ay+SZ5FDeIhPNLYH35NB2tg/LOgmzjRT
         XL4A==
X-Gm-Message-State: AJcUukddt5rZwZrXPRgMQvlthHbVwH2oFsR7TJK7nn9+e6gV7ZQWjxBd
        xjUYiHfYvwedj38FX0bjRD38Dg==
X-Google-Smtp-Source: ALg8bN62G0/QBaoJRR1ApqR8rAiY5+uOY2xmB/Wpjp2VNGDP8FZVdyPWnrnDVFMusI5C+iaXRq/f4Q==
X-Received: by 2002:a62:2fc3:: with SMTP id v186mr13782534pfv.82.1547707492463;
        Wed, 16 Jan 2019 22:44:52 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v190sm977708pfv.26.2019.01.16.22.44.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 22:44:51 -0800 (PST)
Date:   Wed, 16 Jan 2019 22:44:11 -0800
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
Subject: Re: [PATCH 04/13] dt-bindings: mailbox: qcom: Add clock-name
 optional property
Message-ID: <20190117064411.GK25498@builder>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-5-git-send-email-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545039990-19984-5-git-send-email-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 17 Dec 01:46 PST 2018, Jorge Ramirez-Ortiz wrote:

> When the APCS clock is registered (platform dependent), it retrieves
> its parent names from hardcoded values in the driver.
> 
> The following commit allows the DT node to provide such clock names to
> the platform data based clock driver therefore avoiding having to
> explicitly embed those names in the clock driver source code.
> 
> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  .../bindings/mailbox/qcom,apcs-kpss-global.txt      | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
> index 1232fc9..f252439 100644
> --- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
> +++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
> @@ -23,6 +23,10 @@ platforms.
>  	Value type: <phandle>
>  	Definition: phandle to the input PLL, which feeds the APCS mux/divider
>  
> +       Usage: required if #clock-names property is present
> +       Value type: <phandle array>
> +	Definition: phandles to the two parent clocks of the clock driver.

I presume you meant to replace the existing definition of "clocks"?

I think the purpose of "required if #clock-cells" comes from that
meaning that it represents a clock-controller if #clock-cells is
specified, in which case it requires the upstream clock(s).

Regards,
Bjorn

> +
>  - #mbox-cells:
>  	Usage: required
>  	Value type: <u32>
> @@ -33,6 +37,12 @@ platforms.
>  	Value type: <u32>
>  	Definition: as described in clock.txt, must be 0
>  
> +- clock-names:
> +	Usage: required if the platform data based clock driver needs to
> +	retrieve the parent clock names from device tree.
> +	This will requires two mandatory clocks to be defined.
> +	Value type: <string-array>
> +	Definition: must be "aux" and "pll"
>  
>  = EXAMPLE
>  The following example describes the APCS HMSS found in MSM8996 and part of the
> @@ -65,3 +75,14 @@ Below is another example of the APCS binding on MSM8916 platforms:
>  		clocks = <&a53pll>;
>  		#clock-cells = <0>;
>  	};
> +
> +Below is another example of the APCS binding on QCS404 platforms:
> +
> +	apcs_glb: mailbox@b011000 {
> +		compatible = "qcom,qcs404-apcs-apps-global", "syscon";
> +		reg = <0x0b011000 0x1000>;
> +		#mbox-cells = <1>;
> +		clocks = <&gcc GCC_GPLL0_AO_OUT_MAIN>, <&apcs_hfpll>;
> +		clock-names = "aux", "pll";
> +		#clock-cells = <0>;
> +	};
> -- 
> 2.7.4
> 

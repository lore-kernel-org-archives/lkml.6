Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4798C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 676692086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544564108;
	bh=N7gb6qPQ6l4xx7Jqa1+otD3GHZ3HHlTNj59svbyZDaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aKgebnfhTbfmWDxeXv6nElgy8rFq0oL7PWbABjQt0iwg11aCHbRLCmrT0HNUZhf1K
	 dDvV3b6s+TWK7VA/fe6Am76D/riunYeT0LhEhfEzUAD1zsu46xH3ot8lylCxUPRW6b
	 nQPirtt/rqF7JAq5NQidOQd09AkziCldY06Zuz84=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 676692086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbeLKVfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 16:35:07 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:47018 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbeLKVfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 16:35:06 -0500
Received: by mail-ot1-f66.google.com with SMTP id w25so15538401otm.13;
        Tue, 11 Dec 2018 13:35:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rV8gIkjzN/PQdUgG6ehN76wdlzIjiKZOrmo2juMNHGU=;
        b=YMx3fmUGQ1xFrv6EdJVC1PwnvGm/6alh5byJq9+74IeX3IEUsrYpwxX9eFVZjkPj+G
         UTUuG2RGY8AmGS3EE5aq9MEx937Tmt2MjM8+3iqnIuBwRL+mU21zrNPP5MOwf6AGKASr
         Fpz7nYLIU/nml3Ld3BEh+cAsP5BV0IUQJoQM7429NMZMj9qdKAQtSh09M8+AVcyNJPMr
         TtYbIFYPcrFMfzlzTFVvZRVAamWaMLaUITrdG166arZyPN3SGBm0jZskqL4VnO3x5Sh9
         KIhXUvAWk2OSktKqh1dViJ/bhID/czV/jof/4qv81yLCdzfyH1jqcOzDLRZuxLhq0uho
         JUxw==
X-Gm-Message-State: AA+aEWYsgJf8pjfvaSwIBVPVP4ygfbTBqGPMzzkBxhMkHgIePGoseOJ8
        vfyqLwdIoqbT/N+2XwxIEQ==
X-Google-Smtp-Source: AFSGD/WgSolc/ihRQEmnaMMQza0LpojZAP3HFprA1uTdVv0HR0JQUeU1pwfG4T8g8sdB8q5GH8b3rA==
X-Received: by 2002:a9d:4595:: with SMTP id x21mr12111855ote.234.1544564105644;
        Tue, 11 Dec 2018 13:35:05 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z7sm7486958otm.63.2018.12.11.13.35.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 13:35:05 -0800 (PST)
Date:   Tue, 11 Dec 2018 15:35:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] dt-bindings: timer: gpt: update binding doc
Message-ID: <20181211213504.GA29643@bogus>
References: <1542963884-20823-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542963884-20823-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 09:10:09AM +0000, Anson Huang wrote:
> The i.MX GPT timer driver binding doc is out of date,
> the "interrupts", "clocks" and "clock-names" do NOT match
> current GPT driver implementation, update it and use i.MX6SX
> as example.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  .../devicetree/bindings/timer/fsl,imxgpt.txt       | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt b/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
> index 9809b11..4e9fa16 100644
> --- a/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
> +++ b/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
> @@ -2,17 +2,21 @@ Freescale i.MX General Purpose Timer (GPT)
>  
>  Required properties:
>  
> -- compatible : should be "fsl,<soc>-gpt"
> -- reg : Specifies base physical address and size of the registers.
> -- interrupts : A list of 4 interrupts; one per timer channel.
> -- clocks : The clocks provided by the SoC to drive the timer.
> +- compatible : should be "fsl,<soc>-gpt".

This should enumerate valid <soc> values.

> +- reg : specifies base physical address and size of the registers.
> +- interrupts : should be the clock event device interrupt.
> +- clocks : the clocks provided by the SoC to drive the timer, must contain
> +           an entry for each entry in clock-names.
> +- clock-names : must include an "per" or "osc_per" entry, and "ipg" entry
> +                is optional according to SoC design.

Need to define the order. Ideally the optional clock should be last, but 
that's not what the example has.

>  
>  Example:
>  
> -gpt1: timer@10003000 {
> -	compatible = "fsl,imx27-gpt", "fsl,imx1-gpt";
> -	reg = <0x10003000 0x1000>;
> -	interrupts = <26>;
> -	clocks = <&clks 46>, <&clks 61>;
> +gpt: gpt@2098000 {

timer@...

> +	compatible = "fsl,imx6sx-gpt", "fsl,imx31-gpt";

You haven't documented "fsl,imx31-gpt" is a valid fallback. Is the old 
example not still valid for imx27?

> +	reg = <0x02098000 0x4000>;

Using a size > 4KB just wastes virtual space which is valuable on 32-bit 
systems with >= 1GB RAM.

> +	interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
> +	clocks = <&clks IMX6SX_CLK_GPT_BUS>,
> +		 <&clks IMX6SX_CLK_GPT_3M>;
>  	clock-names = "ipg", "per";
>  };
> -- 
> 2.7.4
> 

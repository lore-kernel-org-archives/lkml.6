Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69901C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 04:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EEC721785
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 04:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="C0ztYqKp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EEC721785
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbeHMHOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 03:14:47 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44748 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbeHMHOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 03:14:47 -0400
Received: by mail-pl0-f67.google.com with SMTP id ba4-v6so6383190plb.11
        for <linux-kernel@vger.kernel.org>; Sun, 12 Aug 2018 21:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AiO51thYNoySjVYDafJZKfYnJh/XWu/jwqbq/Go0ZCs=;
        b=C0ztYqKp2fFbRQD3Z7SQIDQ/lEjEZmFAiKtlha3wljDfJUWpWk19Vo8s/+hOCw5dle
         e6peKq+D86q8vSZEUqt8gDJs7l0hqj84BM/yb0EA4pRhZHmj66n5o8GtxBearKLJbj5G
         Pgwnzar6DViT/35AVgwsEKAE4mp/lyfh7tOXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AiO51thYNoySjVYDafJZKfYnJh/XWu/jwqbq/Go0ZCs=;
        b=uXqtcusZs4uhHhYav6iAUukSRWCsW8/fTGLp9LGrOg+kCi9iM3CmVkAscamKPPo7vc
         R/k04z/2Q1mUju7R46uS0uFbbt5HL4QNxs9Usots/FOJs7PeI+uVUIKS+XC8Hq9PhfUZ
         qL0fn8YgQqrqPflSU5PsqdE8qnJIiFExoyvHZO0ACDE0EoxZhzYf2rx45Kubgq7gfr8H
         nwVyJz9K1hZPzeVXnHYvskq83YuxrtPLA8IBi19aIojvcgItYOUaZ5GOlPYXJMtmF1D5
         zplUUDqrm99Kmsf9qbFlVpLEtjtvyVimYBMofXIPe9C/g53Go5eUdF9ZQY0xpCcY7oqC
         EoQA==
X-Gm-Message-State: AOUpUlHUHV2U6JGaSNRwPVPjk/eFY+iXYjlKqOwBoRl1RsKGeuzYSyv2
        E6gvbl/pMm2DUNG193oON9DWXIPuqA==
X-Google-Smtp-Source: AA+uWPyFWQWbc1NxaGqYs01Ne2EIOESjNY9LZ9E7ri13Las7GPzbCcQnshM0kpC1Lf2QawvRyzkucg==
X-Received: by 2002:a17:902:8a97:: with SMTP id p23-v6mr15144951plo.21.1534134858156;
        Sun, 12 Aug 2018 21:34:18 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:631d:d852:4dea:6732:2ed1:5303])
        by smtp.gmail.com with ESMTPSA id w70-v6sm25779580pgd.18.2018.08.12.21.34.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 Aug 2018 21:34:17 -0700 (PDT)
Date:   Mon, 13 Aug 2018 10:04:06 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Parthiban Nallathambi <pn@denx.de>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com, afaerber@suse.de,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, sravanhome@gmail.com,
        thomas.liau@actions-semi.com, mp-cs@actions-semi.com,
        linux@cubietech.com, edgar.righi@lsitec.org.br,
        laisa.costa@lsitec.org.br, guilherme.simoes@lsitec.org.br,
        mkzuffo@lsi.usp.br
Subject: Re: [PATCH v2 1/3] dt-bindings: interrupt-controller: Actions
 external interrupt controller
Message-ID: <20180813043406.GA16275@Mani-XPS-13-9360>
References: <20180812122215.1079590-1-pn@denx.de>
 <20180812122215.1079590-2-pn@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180812122215.1079590-2-pn@denx.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Parthiban,

On Sun, Aug 12, 2018 at 02:22:13PM +0200, Parthiban Nallathambi wrote:
> Actions Semi OWL family SoC's provides support for external interrupt
> controller to be connected and controlled using SIRQ pins. S500, S700
> and S900 provides 3 SIRQ lines and works independently for 3 external
> interrupt controllers.
> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  .../interrupt-controller/actions,owl-sirq.txt      | 46 ++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
> new file mode 100644
> index 000000000000..4b8437751331
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
> @@ -0,0 +1,46 @@
> +Actions Semi Owl SoCs SIRQ interrupt controller
> +
> +S500, S700 and S900 SoC's from Actions provides 3 SPI's from GIC,
> +in which external interrupt controller can be connected. 3 SPI's
> +45, 46, 47 from GIC are directly exposed as SIRQ. It has
> +the following properties:

We should really document the driver here. What it does? and how the
hierarchy is handled with GIC? etc...

> +
> +- inputs three interrupt signal from external interrupt controller
> +
> +Required properties:
> +
> +- compatible: should be "actions,owl-sirq"
> +- reg: physical base address of the controller and length of memory mapped.

...length of memory mapped region?

> +- interrupt-controller: identifies the node as an interrupt controller
> +- #interrupt-cells: specifies the number of cells needed to encode an interrupt
> +  source, should be 2.
> +- actions,sirq-shared-reg: Applicable for S500 and S700 where SIRQ register
> +  details are maintained at same offset/register.
> +- actions,sirq-offset: register offset for SIRQ interrupts. When registers are
> +  shared, all the three offsets will be same (S500 and S700).
> +- actions,sirq-clk-sel: external interrupt controller can be either
> +  connected to 32Khz or 24Mhz external/internal clock. This needs

Hertz should be specified as Hz.

> +  to be configured for per SIRQ line. Failing defaults to 32Khz clock.

What value needs to be specified for selecting 24MHz clock? You should
mention the available options this property supports.

> +
> +Example for S900:
> +
> +sirq: interrupt-controller@e01b0000 {
> +	compatible = "actions,owl-sirq";
> +	reg = <0 0xe01b0000 0 0x1000>;

could be: reg = <0x0 0xe01b0000 0x0 0x1000>;

> +	interrupt-controller;
> +	#interrupt-cells = <2>;
> +	actions,sirq-clk-sel = <0 0 0>;
> +	actions,sirq-offset = <0x200 0x528 0x52c>;
> +};
> +
> +Example for S500 and S700:
> +
> +sirq: interrupt-controller@e01b0000 {
> +	compatible = "actions,owl-sirq";
> +	reg = <0 0xe01b0000 0 0x1000>;

For S500, reg base is 0xb01b0000.

Thanks
Mani

> +	interrupt-controller;
> +	#interrupt-cells = <2>;
> +	actions,sirq-shared-reg;
> +	actions,sirq-clk-sel = <0 0 0>;
> +	actions,sirq-offset = <0x200 0x200 0x200>;
> +};
> -- 
> 2.14.4
> 

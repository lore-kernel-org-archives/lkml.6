Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3E9C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FFF32084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544566001;
	bh=7Ey62Xetjv+JnZeFKsau/gmBEKiq4GTGBYt5e/XLn20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZXQoUxBCfo1P5BN/8ufln50Mi90uqOCO2etw87JzFgiDXP6YMF7i61odJl79kw/Ji
	 tSsm8I51FoRymh6fjDuvBwd2nI+UEZXf2QS5Eu2EO3XDXyrg4K/k/UpK5OuZGPG3+1
	 mtcqcAbJIPJwlosIGouj6DBi7IlcJ6y4UFX91wKk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FFF32084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbeLKWGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:06:40 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36156 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeLKWGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:06:40 -0500
Received: by mail-oi1-f194.google.com with SMTP id x23so13376045oix.3;
        Tue, 11 Dec 2018 14:06:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zxCHXJVn4g17vaDC2XUQXh0RHGbwgRdcqSlW3XixLQQ=;
        b=cuP9UHmVjCkKI+0pse+O3wHpATrQ1c+m6WpWM1FtfJ/0Yv1tdwF0BBeaNJcyHfItRM
         HXFya2TD0poRlNWgMSTHCTf3+7dUwXydhDyOk7jr3TfxyW8XGGa9odq2sv+yrrSA+9L9
         fPhZBNgiOKYK+2ADIE28qm1AqIwNZmZXnFJH2EHnfTSiYPC9ZmHaqhCrlMNUuIFafshJ
         jFt9QGf7X5+eGyZ4vNhKjbjUGHoxO6xCr158lfEbVqLvdRKSRcbJuvaCPnELSozbz6mb
         p9w172xe9vW+kxItcr3L2p/3i6eC7dGO9NU2kxa2kfEJqUL+f1Xk4XSF2KPWVrk8zQNl
         1WRA==
X-Gm-Message-State: AA+aEWaKzn2rhIM3+4F0O5kHKGMy9SY9lZIAYM2dAHFj9JU92dN9EfxQ
        LhfS4e7BN5awGWj9jmgO9A==
X-Google-Smtp-Source: AFSGD/U+e0//ayUG57ZOL0ioXZAFq5e19gceavoIYy4lsGUmGULjH0x5bbWsbX+1A9/Xk1W7UA4K/w==
X-Received: by 2002:aca:3345:: with SMTP id z66mr1230589oiz.91.1544565998924;
        Tue, 11 Dec 2018 14:06:38 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q128sm7247905oia.4.2018.12.11.14.06.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 14:06:38 -0800 (PST)
Date:   Tue, 11 Dec 2018 16:06:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Roger Quadros <rogerq@ti.com>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org, tony@atomide.com,
        bcousson@baylibre.com, ssantosh@kernel.org, s-anna@ti.com,
        nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com,
        m-karicheri2@ti.com, woods.technical@gmail.com,
        linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 12/16] dt-bindings: remoteproc: ti-pruss: Document
 application node bindings
Message-ID: <20181211220637.GA32460@bogus>
References: <1543218769-5507-1-git-send-email-rogerq@ti.com>
 <1543218769-5507-13-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543218769-5507-13-git-send-email-rogerq@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 09:52:45AM +0200, Roger Quadros wrote:
> From: Tero Kristo <t-kristo@ti.com>
> 
> Add documentation for the Texas Instruments PRU application nodes.
> These are used to configure specific user applications for PRU instances.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> [s-anna@ti.com: some binding updates]
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  .../devicetree/bindings/soc/ti/ti,pruss.txt        | 43 ++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.txt b/Documentation/devicetree/bindings/soc/ti/ti,pruss.txt
> index 3e5f32f..94c91ee 100644
> --- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.txt
> +++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.txt
> @@ -210,6 +210,38 @@ used in TI Davinci SoCs. Please refer to the corresponding binding document,
>  Documentation/devicetree/bindings/net/davinci-mdio.txt for details.
>  
>  
> +Application/User Nodes
> +=======================
> +A PRU application/user node typically uses one or more PRU device nodes to
> +implement a PRU application/functionality. Each application/client node would
> +need a reference to at least a PRU node, and optionally pass some configuration
> +parameters.
> +
> +Required Properties:
> +--------------------
> +- prus                 : phandles to the PRU nodes used
> +
> +Optional Properties:
> +--------------------
> +- firmware-name        : firmwares for the PRU cores, the default firmware
> +                         for the core from the PRU node will be used if not
> +                         provided. The firmware names should correspond to
> +                         the PRU cores listed in the 'prus' property
> +- ti,pruss-gp-mux-sel  : array of values for the GP_MUX_SEL under PRUSS_GPCFG
> +                         register for a PRU. This selects the internal muxing
> +                         scheme for the PRU instance. If not provided, the
> +                         default out-of-reset value (0) for the PRU core is
> +                         used. Values should correspond to the PRU cores listed
> +                         in the 'prus' property
> +- ti,pru-interrupt-map : PRU interrupt mappings, containing an array of entries
> +                         with each entry consisting of 4 cell-values. First one
> +                         is an index towards the "prus" property to identify the
> +                         PRU core for the interrupt map, second is the PRU
> +                         System Event id, third is the PRU interrupt channel id
> +                         and fourth is the PRU host interrupt id. If provided,
> +                         this map will supercede any other configuration
> +                         provided through firmware

Can't you use 'interrupt-map' or use more cells for the PRU intc cells. 
Or use interrupts-extended if you need more than 1 parent.

> +
>  Example:
>  ========
>  1.	/* AM33xx PRU-ICSS */
> @@ -397,3 +429,14 @@ Example:
>  			...
>  		};
>  	};
> +
> +3:	/* PRU application node example */
> +	app_node: app_node {
> +		prus = <&pru1_0>, <&pru1_1>;
> +		firmware-name = "pruss-app-fw", "pruss-app-fw-2";
> +		ti,pruss-gp-mux-sel = <2>, <1>;
> +		/* setup interrupts for prus:
> +		   prus[0] => pru1_0: ev=16, chnl=2, host-irq=7,
> +		   prus[1] => pru1_1: ev=19, chnl=1, host-irq=3 */
> +		ti,pru-interrupt-map = <0 16 2 7 >, <1 19 1 3>;
> +	}
> -- 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 

Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF2EC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8559020837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544225378;
	bh=1IwVtqm+ywnceX2T2ICQQlx7wmosnth2z/wLOD2PVlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jpsl6qXpyQI3pztPCyv9zLksUTyR9kVN7+jhdmssFf/g5yLfV4TynUARk/U1vj9sG
	 hCecpwu32CkPLM9Nd1BsxbrCsxheX3w7CyJJ2/d0MOcARsaXIC9r2kIzeqdNQ6Hmr/
	 KBbmmOGET4kIu7jKayx/RbUM0cbaNWKrvIHuhuKM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8559020837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbeLGX3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 18:29:37 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33140 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLGX3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 18:29:37 -0500
Received: by mail-ot1-f66.google.com with SMTP id i20so5416682otl.0;
        Fri, 07 Dec 2018 15:29:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IOMCtzCHH/8bAidk48htasyfLtH4dFYPPTgxZpEhtQo=;
        b=mBuG4AJlnp6/VfFf+cnwyWJACXyUMM3zOPpgeBmMEM1tifGlOs1PsXysgrPj0H0QRp
         2Kg7vj/b6PW7EGXl0SEIv4QGDghdHIfyEvDbvJIRuSv9FSSZjcuj7Jym/SPPH4rV4R1m
         ZcKboFZ9dsWct9hb9qsd2bas5Dk0pVJvySwqaK8AIBQRONI313BbxEJ+497Vf2vieM9P
         ZDkIJj7K/kEe69lxDVWNOp3f/+8ZjAnk125nzlSvBv3l03sRP9/ykqFrifLDSYK+fogC
         FZ+rxSzSM8lpgAs4dTBMVPB60sNGwIySj+pCnTM+Qnak1MENXpQRRsRh8FKYrcn9Nhvy
         pImQ==
X-Gm-Message-State: AA+aEWZuUwhtW9CPtrbF9D4OHX4qA7/aROw7mnoEPLCi4CzfpoxPCnrN
        FmXy5UxSSOX+KxcRjA+CWQ==
X-Google-Smtp-Source: AFSGD/XutWZjAnKe0+Mnic6LMqJqqiXswhQxr9nwJpdbAFIyLKnY/cqZJ418LvQ9uTAGWowjAoHOcw==
X-Received: by 2002:a9d:5249:: with SMTP id q9mr2718240otg.160.1544225375950;
        Fri, 07 Dec 2018 15:29:35 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p203sm5250409oic.49.2018.12.07.15.29.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 15:29:35 -0800 (PST)
Date:   Fri, 7 Dec 2018 17:29:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Parthiban Nallathambi <pn@denx.de>
Cc:     marc.zyngier@arm.com, tglx@linutronix.de, jason@lakedaemon.net,
        mark.rutland@arm.com, afaerber@suse.de, catalin.marinas@arm.com,
        will.deacon@arm.com, manivannan.sadhasivam@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, thomas.liau@actions-semi.com,
        mp-cs@actions-semi.com, linux@cubietech.com,
        edgar.righi@lsitec.org.br, laisa.costa@lsitec.org.br,
        guilherme.simoes@lsitec.org.br, mkzuffo@lsi.usp.br,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: interrupt-controller: Actions
 external interrupt controller
Message-ID: <20181207232934.GA28201@bogus>
References: <20181126100356.2840578-1-pn@denx.de>
 <20181126100356.2840578-2-pn@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126100356.2840578-2-pn@denx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 11:03:53AM +0100, Parthiban Nallathambi wrote:
> Actions Semi OWL family SoC's provides support for external interrupt
> controller to be connected and controlled using SIRQ pins. S500, S700
> and S900 provides 3 SIRQ lines and works independently for 3 external
> interrupt controllers.
> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  .../interrupt-controller/actions,owl-sirq.txt | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
> new file mode 100644
> index 000000000000..b3adc4bddf40
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
> @@ -0,0 +1,57 @@
> +Actions Semi Owl SoCs SIRQ interrupt controller
> +
> +S500, S700 and S900 SoC's from Actions provides 3 SPI's from GIC,

Listing SoCs here means you have to update this line for every new SoC.

> +in which external interrupt controller can be connected. 3 SPI's
> +45, 46, 47 from GIC are directly exposed as SIRQ. It has
> +the following properties:
> +
> +- inputs three interrupt signal from external interrupt controller
> +
> +Required properties:
> +
> +- compatible: should be "actions,owl-sirq"

SoC specific compatibles needed.

> +- reg: physical base address of the controller and length of memory mapped
> +  region.
> +- interrupt-controller: identifies the node as an interrupt controller
> +- #interrupt-cells: specifies the number of cells needed to encode an interrupt
> +  source, should be 2.
> +- actions,sirq-shared-reg: Applicable for S500 and S700 where SIRQ register
> +  details are maintained at same offset/register.
> +- actions,sirq-reg-offset: register offset for SIRQ interrupts. When registers are
> +  shared, all the three offsets will be same (S500 and S700).

These properties should be implied by the compatible string.

> +- actions,ext-irq-range: Identifies external irq number range in different SoCs.

Why is this needed? It appears to always be the same.

> +
> +Example for S900:
> +
> +sirq: interrupt-controller@e01b0000 {
> +	compatible = "actions,owl-sirq";
> +	reg = <0x0 0xe01b0000 0x0 0x1000>;
> +	interrupt-controller;
> +	#interrupt-cells = <3>;
> +	actions,sirq-offset = <0x200 0x528 0x52c>;
> +	actions,ext-irq-range = <13 15>;
> +};
> +
> +Example for S700:

Examples are examples, not an enumeration of all possible dts entries. 
So 1 should be sufficient.

> +
> +sirq: interrupt-controller@e01b0000 {
> +	compatible = "actions,owl-sirq";
> +	reg = <0x0 0xe01b0000 0x0 0x1000>;
> +	interrupt-controller;
> +	#interrupt-cells = <3>;
> +	actions,sirq-shared-reg;
> +	actions,sirq-reg-offset = <0x200 0x200 0x200>;
> +	actions,ext-irq-range = <13 15>;
> +};
> +
> +Example for S500:
> +
> +sirq: interrupt-controller@b01b0000 {
> +	compatible = "actions,owl-sirq";
> +	reg = <0x0 0xb01b0000 0x0 0x1000>;
> +	interrupt-controller;
> +	#interrupt-cells = <3>;
> +	actions,sirq-shared-reg;
> +	actions,sirq-offset = <0x200 0x200 0x200>;
> +	actions,ext-irq-range = <13 15>;
> +};
> -- 
> 2.17.2
> 

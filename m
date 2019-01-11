Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B845AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766F721848
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547223331;
	bh=unsRdQJ9KVmSSYAUtwTmn0H8lc65JaL5UWSNVfZTDOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I35JqJEh1mvSRLQ5AXs/l/CQYVGjx02cg8YIpXYuNUb96YiAiGlUJ5ut2Fr/6tO3Z
	 svE8u7DfDB8l8OUGwSWfOMr/F/ZyL4CrbSiUOpCYK5pcLChC3+dkBrYKxJr4b/n/Y7
	 wtOPqMotGgVecvP+J6JPXdwzWOaKVNYVna3z9YWo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387530AbfAKQPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 11:15:30 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36289 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbfAKQPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 11:15:30 -0500
Received: by mail-ot1-f65.google.com with SMTP id k98so13569497otk.3;
        Fri, 11 Jan 2019 08:15:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o2lJu0osneZBXtlcgr3qMVTvat7qTMs5SntOY5KyBr8=;
        b=iax4F2oFFFFZizjlivCr2RoOa4ZLpyIIzcJZRKP+3st84q4+D2kpUnbgnhKE6GaJqN
         0ivZJHczxpt3RECQ08MOnHtbpjy22VrY6tpJJn/X20o6mS3nm95nPUCXHiC+imbElZEq
         2gXJ6IvS0XXk7VlKXfMzlcqED4n3ZY/eEEt0eMrNvn3ihosgor+Vh0p2ZT/lI+EgZKLM
         KKAtkoPjVcRK+wiuhb9/ZwmQ4GOcFavN7csg7hPcYUlhErTkBjCkkaD1HM8+0wR67kwC
         rUe6oQnh0vWdyaccnen8kECtOL9WhwG5rhdqqkY4IgfebgdYEBI2Vi3QjOVfuQEP0kyk
         IzYQ==
X-Gm-Message-State: AJcUukcO9qgxldihA5sZvuFUMmNLRCBce8C+DZyeUkfpbmT7LJeuvRBS
        oR9OjUkORRBafeRnq3Rhyw==
X-Google-Smtp-Source: ALg8bN6Y7KgQBREz83gcFA7+qntf7qj6ajwNXPn9vaYxX2Kn4lDI6IOAKXi9O0qtS5d0RXp2fXQ3DQ==
X-Received: by 2002:a9d:5f85:: with SMTP id g5mr10181558oti.333.1547223329316;
        Fri, 11 Jan 2019 08:15:29 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q128sm37093019oia.4.2019.01.11.08.15.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 08:15:28 -0800 (PST)
Date:   Fri, 11 Jan 2019 10:15:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Cc:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Jin Gao (Arm Technology China)" <Jin.Gao@arm.com>,
        nd <nd@arm.com>, "sean@poorly.run" <sean@poorly.run>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH v4 2/9] dt/bindings: drm/komeda: Add DT bindings for ARM
 display processor D71
Message-ID: <20190111161527.GA9669@bogus>
References: <20190103113841.15403-1-james.qian.wang@arm.com>
 <20190103113841.15403-3-james.qian.wang@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190103113841.15403-3-james.qian.wang@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 11:40:04AM +0000, james qian wang (Arm Technology China) wrote:
> From: "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
> 
> Add DT bindings documentation for the ARM display processor D71 and later
> IPs.
> 
> Changes in v4:
> - Deleted unnecessary address-cells, size-cells [Liviu Dudau]
> 
> Changes in v3:
> - Deleted unnecessary property: interrupt-names.
> - Dropped 'ports' and moving 'port' up a level.
> 
> Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.com>
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> ---
>  .../bindings/display/arm/arm,komeda.txt       | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/arm/arm,komeda.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/arm/arm,komeda.txt b/Documentation/devicetree/bindings/display/arm/arm,komeda.txt
> new file mode 100644
> index 000000000000..919d651d3e8c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/arm/arm,komeda.txt
> @@ -0,0 +1,73 @@
> +Device Tree bindings for Arm Komeda display driver
> +
> +Required properties:
> +- compatible: Should be "arm,mali-d71"
> +- reg: Physical base address and length of the registers in the system
> +- interrupts: the interrupt line number of the device in the system
> +- clocks: A list of phandle + clock-specifier pairs, one for each entry
> +    in 'clock-names'
> +- clock-names: A list of clock names. It should contain:
> +      - "mclk": for the main processor clock
> +      - "pclk": for the APB interface clock
> +- #address-cells: Must be 1
> +- #size-cells: Must be 0
> +
> +Required properties for sub-node: pipeline@nq
> +Each device contains one or two pipeline sub-nodes (at least one), each
> +pipeline node should provide properties:
> +- reg: Zero-indexed identifier for the pipeline
> +- clocks: A list of phandle + clock-specifier pairs, one for each entry
> +    in 'clock-names'
> +- clock-names: should contain:
> +      - "pxclk": pixel clock
> +      - "aclk": AXI interface clock
> +
> +- port: each pipeline connect to an encoder input port. The connection is
> +    modeled using the OF graph bindings specified in
> +    Documentation/devicetree/bindings/graph.txt
> +
> +Optional properties:
> +  - memory-region: phandle to a node describing memory (see
> +    Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt)
> +    to be used for the framebuffer; if not present, the framebuffer may
> +    be located anywhere in memory.
> +
> +Example:
> +/ {
> +	...
> +
> +	dp0: display@c00000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "arm,mali-d71";
> +		reg = <0xc00000 0x20000>;
> +		interrupts = <0 168 4>;
> +		clocks = <&dpu_mclk>, <&dpu_aclk>;
> +		clock-names = "mclk", "pclk";
> +
> +		dp0_pipe0: pipeline@0 {
> +			clocks = <&fpgaosc2>, <&dpu_aclk>;
> +			clock-names = "pxclk", "aclk";
> +			reg = <0>;
> +
> +			port@0 {

Drop the '@0'

> +				dp0_pipe0_out: endpoint {
> +					remote-endpoint = <&db_dvi0_in>;
> +				};
> +			};
> +		};
> +
> +		dp0_pipe1: pipeline@1 {
> +			clocks = <&fpgaosc2>, <&dpu_aclk>;
> +			clock-names = "pxclk", "aclk";
> +			reg = <1>;
> +
> +			port@0 {

And here.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +				dp0_pipe1_out: endpoint {
> +					remote-endpoint = <&db_dvi1_in>;
> +				};
> +			};
> +		};
> +	};
> +	...
> +};
> -- 
> 2.17.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

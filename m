Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C05C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD152081B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731889AbfBRO3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:29:36 -0500
Received: from foss.arm.com ([217.140.101.70]:60040 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733129AbfBRO3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:29:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90ADAA78;
        Mon, 18 Feb 2019 06:29:33 -0800 (PST)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4580F3F589;
        Mon, 18 Feb 2019 06:29:28 -0800 (PST)
Date:   Mon, 18 Feb 2019 14:28:45 +0000
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     guoren@kernel.org
Cc:     tglx@linutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V2 5/7] dt-bindings: interrupt-controller: Update csky
 mpintc
Message-ID: <20190218142845.4ad56ec0@why.wild-wind.fr.eu.org>
In-Reply-To: <1550455483-11710-5-git-send-email-guoren@kernel.org>
References: <1550455483-11710-1-git-send-email-guoren@kernel.org>
        <1550455483-11710-5-git-send-email-guoren@kernel.org>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Feb 2019 10:04:41 +0800
guoren@kernel.org wrote:

> From: Guo Ren <ren_guo@c-sky.com>
> 
> Add trigger type and priority setting for csky,mpintc.
> 
> Changelog:
>  - change #interrupt-cells to <3>
> 
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> ---
>  .../bindings/interrupt-controller/csky,mpintc.txt   | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
> index ab921f1..dccd913 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
> @@ -6,11 +6,18 @@ C-SKY Multi-processors Interrupt Controller is designed for ck807/ck810/ck860
>  SMP soc, and it also could be used in non-SMP system.
>  
>  Interrupt number definition:
> -
>    0-15  : software irq, and we use 15 as our IPI_IRQ.
>   16-31  : private  irq, and we use 16 as the co-processor timer.
>   31-1024: common irq for soc ip.
>  
> +Interrupt triger mode:
> + IRQ_TYPE_LEVEL_HIGH (default)
> + IRQ_TYPE_LEVEL_LOW
> + IRQ_TYPE_EDGE_RISING
> + IRQ_TYPE_EDGE_FALLING
> +
> +Interrupt priority range: 0-255
> +
>  =============================
>  intc node bindings definition
>  =============================
> @@ -26,15 +33,21 @@ intc node bindings definition
>  	- #interrupt-cells
>  		Usage: required
>  		Value type: <u32>
> -		Definition: must be <1>
> +		Definition: <3>

This seem to be invalidating all existing DTs. Is this an acceptable
thing to do? It will require an Ack from a DT maintainer.

>  	- interrupt-controller:
>  		Usage: required
>  
> -Examples:
> +Examples: ("interrupts = <irq_num IRQ_TYPE_XXX priority>")
>  ---------
>  
>  	intc: interrupt-controller {
>  		compatible = "csky,mpintc";
> -		#interrupt-cells = <1>;
> +		#interrupt-cells = <3>;
>  		interrupt-controller;
>  	};
> +
> +	device: device-example {
> +		...
> +		interrupts = <34 IRQ_TYPE_EDGE_RISING 254>;
> +		interrupt-parent = <&intc>;
> +	};

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.
